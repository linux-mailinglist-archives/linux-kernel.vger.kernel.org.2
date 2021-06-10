Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD59D3A2522
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 09:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhFJHQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 03:16:16 -0400
Received: from mail-vs1-f47.google.com ([209.85.217.47]:36514 "EHLO
        mail-vs1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbhFJHQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 03:16:13 -0400
Received: by mail-vs1-f47.google.com with SMTP id z7so1335240vso.3;
        Thu, 10 Jun 2021 00:14:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y0PGTrqqap0AD0zgzrltlkdjoUc8xunpWBJ8PcUZGZg=;
        b=sXCqtgUxMOVukm5YYJz0tO8clvtvzs+rQzZ8ha++cVlDHvDM/ACGzxz1pzloz3zvul
         hyHPYuph7NhzgZEUiMcD9hL2dhwcehIOqeKsQIbfErQaZn+1CIEmm9iCxN/3xnScVOWz
         in1WqwFU96vFWCZYRbuiSzC1NKDSnHwkucU/NIWvQas0kREFlnKKAk4Hkuk7+rvRjCEC
         AeVCxumxO2kkl4w8hTvRCFB5BY8eeAtKHczg7/BCW3x8azqxJfuMwtj/UJI+CkcD4APk
         RZgAhvyQmeI3tb5J4uWKQlLxzdfxyAgtcWb/FqgRhYrS2HGl46EwP4gblQx0ma2pILf4
         znJw==
X-Gm-Message-State: AOAM531xK1nOzO9LVwPAhC1FCrPtGwiEh3Gak7gs1R0P39UkedjBZEax
        +MlUBtYjJclvpfmKCxOaQRtdlWRUZFHz8c/Z1x8=
X-Google-Smtp-Source: ABdhPJyCuBdZk9ZP3ryMwLapVtEZoI5iKL7Zkhu6nonEYVDpYYmFJ9VmENs1OstRv2+BQ73VOOJ57IqQxjm00FxC6o0=
X-Received: by 2002:a05:6102:2011:: with SMTP id p17mr2927387vsr.40.1623309246296;
 Thu, 10 Jun 2021 00:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1623287706.git.fthain@linux-m68k.org>
In-Reply-To: <cover.1623287706.git.fthain@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 10 Jun 2021 09:13:55 +0200
Message-ID: <CAMuHMdWLJWBH5uz=PLL7pt2uEHz9uSO2Gh7twCDUTz3NDfhdEQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Use libata platform drivers to replace deprecated
 m68k IDE drivers
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Joshua Thompson <funaho@jurai.org>, linux-ide@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Richard Zidlicky <rz@linux-m68k.org>,
        Michael Schmitz <schmitzmic@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Finn,

On Thu, Jun 10, 2021 at 3:34 AM Finn Thain <fthain@linux-m68k.org> wrote:
> This patch series allows m68k platforms to switch from deprecated IDE
> drivers to libata drivers.
>
> Changed since v1:
>  - Added reviewed-by and tested-by tags.
>  - Improved commit log.
>
> Changed since v2:
>  - Added #ifdef guards to prevent build failure when CONFIG_ATARI=n.

Thanks for the update!

Note that Jens has already applied v2 to block/for-next.
https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-next&id=9658506fbf8c1b629ca8a660862bc1ee57400506

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
