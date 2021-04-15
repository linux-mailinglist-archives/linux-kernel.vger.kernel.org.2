Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B99A23602E6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbhDOHC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:02:27 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:40615 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhDOHCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:02:25 -0400
Received: by mail-vs1-f54.google.com with SMTP id b18so6487845vso.7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 00:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kh5JSKFgKiI6/fzZSUT75Zk01gVPXzC73l3A3An4ly4=;
        b=Zn+df/wf3Rv3fE4HxVbADgTtfM7/e37vhi1RfuEtqWQsujKTKmKq3MPjJeTQnpPaw1
         Oy+iMaa+Y9/sJOYvm4ZrAF4PyQZpOJymtQOFsz3TxiKju174+LU82HCxj8fXWIxHSCCn
         BjyhE/CCpWJMrgfBkJ85OI3w8tZhWZM5hxP4Q6gTfBYi++VI+chGCZuBIG0vHllna9ky
         xsVtI95LrLVkZV6wMNBNt4P/fsjwr8LlIxUn7274q8T5ze9IDctSqxiJgjmgQAm3IpYq
         tfcYClSncAUj4iXhBNm3EHg5sQjDBNLFe6c1vbqKQ6HTWZTk3KfNjsxcntorUmVIyvNL
         c2bg==
X-Gm-Message-State: AOAM5309IRG4yBtJgGin2NLMcLC6S4zNL0lSx1eoG5eA4Z1Kh87mgA+s
        CWiltFXiKcOiw7P5tY5aTPBIdusv3/1NdbKUXrA=
X-Google-Smtp-Source: ABdhPJwcHBEl1MSF99keJBjFtTOX4fbDADDi/QcDjIuZpme2iFOm27l/mD3c6RySflAVeKqvLSnGYRl064suzqej9bs=
X-Received: by 2002:a67:ad10:: with SMTP id t16mr955651vsl.3.1618470122666;
 Thu, 15 Apr 2021 00:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210415031450.23379-1-wanjiabing@vivo.com>
In-Reply-To: <20210415031450.23379-1-wanjiabing@vivo.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 15 Apr 2021 09:01:51 +0200
Message-ID: <CAMuHMdWaaTNnSbgBQgxnSNgpZ3HNWyFBoG3UNt5mdKmZPCVJWA@mail.gmail.com>
Subject: Re: [PATCH] m68k: Remove unneeded semicolon
To:     wanjiabing@vivo.com
Cc:     Sam Creasey <sammy@sammy.net>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kael_w@yeah.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 5:15 AM Wan Jiabing <wanjiabing@vivo.com> wrote:
> Fix the following coccicheck warning:
>
> ./arch/m68k/include/asm/sun3xflop.h:109:2-3: Unneeded semicolon
>
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.14 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
