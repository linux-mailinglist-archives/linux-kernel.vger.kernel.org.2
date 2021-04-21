Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F07736736D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 21:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242942AbhDUT2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 15:28:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235159AbhDUT2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 15:28:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 77C1F61439;
        Wed, 21 Apr 2021 19:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619033286;
        bh=3Prx6APaB0qLvd0pJ5rZUpsHpKVoGTv/kj4I88UpMFU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=grLY+7tslNYeq3F0ztxKd7Mv69IPh5RV9PVFqpwhmJSr/FNF8kG4kvKU6wZH1BmeN
         LJ7wL3++XTI38rKqNsh86IcuJruAY+xcbSt+9In8evCK96/QllKCAgIar3cPLgKciG
         5XFoErNr9nr7NpDJlnT16yewyV3OzNEfHsxzMC0e9LgzhiQdiA89ZKZ4fS75SBKfcw
         HSOXd1lERpV+NwV9I1/cznHuxE5ACJQ/Gg1AQ5cEEmUWZZFL/O9J6hc73wVJO67R2r
         sgBM/Z2HjAPX/Bo1qh6OMapDy8hOHO1+qXn98svubdET233MB976J2iFPYJc32hNY2
         ryU7U+knbPTWw==
Received: by mail-wm1-f52.google.com with SMTP id k128so22793726wmk.4;
        Wed, 21 Apr 2021 12:28:06 -0700 (PDT)
X-Gm-Message-State: AOAM530Dxkohkp71JBADbHpd7rfS/UZTJ/Op96berOIZX/ITzW2U68FN
        e0uH48Naipb5kNZjkj6j8psgd6NzgL3/8XwIMw0=
X-Google-Smtp-Source: ABdhPJxaOXHntTZbcJvxKAY6l8tAygpl01bDvtRlqRjFSflL49lx5n4FJz9U4dWlNMBZgp1/vj/w3pjGCsoGVKp0IOk=
X-Received: by 2002:a05:600c:2282:: with SMTP id 2mr11641379wmf.84.1619033285096;
 Wed, 21 Apr 2021 12:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210421135215.3414589-1-arnd@kernel.org> <CAKwvOdk21V0qW_xQrWqQYnrw8nEr_+KTJnVZgL0gJsJiUf2Scw@mail.gmail.com>
In-Reply-To: <CAKwvOdk21V0qW_xQrWqQYnrw8nEr_+KTJnVZgL0gJsJiUf2Scw@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 21 Apr 2021 21:27:46 +0200
X-Gmail-Original-Message-ID: <CAK8P3a23w+8Hzj0v7c32ebH1Qj0xE3+uO+WUsmnLUM3QXfyV1A@mail.gmail.com>
Message-ID: <CAK8P3a23w+8Hzj0v7c32ebH1Qj0xE3+uO+WUsmnLUM3QXfyV1A@mail.gmail.com>
Subject: Re: [PATCH] memstick: r592: ignore kfifo_out() return code again
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Jing Xiangfeng <jingxiangfeng@huawei.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 7:17 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
> On Wed, Apr 21, 2021 at 6:52 AM Arnd Bergmann <arnd@kernel.org> wrote:

> > The value was never checked here, and the purpose of the function
> > is only to flush the contents, so restore the old behavior but
> > add a cast to void and a comment, which hopefully warns with neither
> > gcc nor clang now.
> >
> > If anyone has an idea for how to fix it without ignoring the return
> > code, that is probably better.
>
> Should r592_flush_fifo_write be made to return an int, then callers of
> r592_flush_fifo_write percolate up their return code?
> r592_transfer_fifo_pio() seems to only return 0, but its callers are
> doing return code checking.

I looked into that but couldn't come up with anything useful to do with
the return code in the callers. kfifo_out() itself doesn't seem to
ever return an error but only the length.

        Arnd
