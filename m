Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0268D3FF280
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 19:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346621AbhIBRip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 13:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346796AbhIBRi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 13:38:28 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D8FC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 10:37:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d17so1650873plr.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 10:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HDAoUcZsfD+c/zEC0G2P+XLrfWfsXMInjiJ2c5tUjik=;
        b=gfrGu3TieN1sG6JBeZ/ppgP2xRHXanv2OoeZyn/J7xB6Xju7XUkcNyEW+87BWZuxCY
         43aLdcDr/zLJWDZkXfdY+ntoMc8/lhOH3FZqyo1JG4jjrcOgTzOWwQtPXTSfnuvKeteH
         BjK/Vc4GPRrjhGM2oxA9TMmVjkLhpgJvElm6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HDAoUcZsfD+c/zEC0G2P+XLrfWfsXMInjiJ2c5tUjik=;
        b=uAirFGnIqwunLC00vtel6/iaOgnwXuL8pRmgSsNabEtIK8SRsE3eZbglKuJpFAAQjp
         Sh+zTdrI4UmBs1yeb6VvHt3Aa0UUAYKmyey9r01lCIeuTbvVQfe5cAZqKoc0UV8LWPQw
         SXaz3eUzzoyfhAbSS8qwyGrb7la70sz90uggseNVslpJh8LJX+qZaN5pntXLjOFpWO3L
         3U/YsC4fwfRlx6Iup81SuibjFLa817R9VEXCbGZnHy9Bl1oIrhDg8sTSgtdamR3+bK7v
         liLMgzdhf0gmfsS5I+JfB/Rqnw72JnJy3O63qrQhzAqIQUqxn22UyNqvbO1ibswX+ABE
         kVig==
X-Gm-Message-State: AOAM530EbUjkemIXrUJoMwLzRDB/YdZIhdKuX6M98DOkewS4cpiC3mAV
        rYBeH+JFkOR7sMUoOjSJ1F4T4A==
X-Google-Smtp-Source: ABdhPJzISf1zacCO0hVRi7xUY/mfmSYpRYOBnO0mwBhHxhMQP/+SwUHlYxKTp9Y34GjPbK7lRdzIpw==
X-Received: by 2002:a17:90a:6f01:: with SMTP id d1mr5280843pjk.36.1630604249962;
        Thu, 02 Sep 2021 10:37:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c9sm3455764pgq.58.2021.09.02.10.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 10:37:29 -0700 (PDT)
Date:   Thu, 2 Sep 2021 10:37:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Keith Packard <keithp@keithp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abbott Liu <liuwenliang@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Maninder Singh <maninder1.s@samsung.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Desaulniers <ndesaulniers@gooogle.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vaneet Narang <v.narang@samsung.com>,
        "Wolfram Sang (Renesas)" <wsa+renesas@sang-engineering.com>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Keith Packard <keithpac@amazon.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/2]: ARM: Enable THREAD_INFO_IN_TASK
Message-ID: <202109021036.859812D3DB@keescook>
References: <20210902155429.3987201-1-keithp@keithp.com>
 <202109020904.976207C@keescook>
 <CAMj1kXGfQuEFOh79TZ089+9eP4S5svWgTMbZLugmD8Hq9b=fMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGfQuEFOh79TZ089+9eP4S5svWgTMbZLugmD8Hq9b=fMQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 06:18:29PM +0200, Ard Biesheuvel wrote:
> On Thu, 2 Sept 2021 at 18:07, Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Sep 02, 2021 at 08:54:26AM -0700, Keith Packard wrote:
> > > Placing thread_info in the kernel stack leaves it vulnerable to stack
> > > overflow attacks. This short series addresses that by using the
> > > existing THREAD_INFO_IN_TASK infrastructure.
> >
> > Very cool! Thanks for working on this. If you want, you can refer to the
> > KSPP bug for this too:
> > https://github.com/KSPP/linux/issues/1
> >
> > (Anyone want to do MIPS?)
> >
> 
> I take it this breaks the GCC plugin based per-task stack protector,
> given that it emits code to mask the stack pointer and apply an offset
> to the resulting value.
> 
> It would be nice if we could replace this with something suitable for
> THREAD_INFO_IN_TASK, and if it is suitable enough, try and get the
> GCC/Clang folks to adopt it as well (which was never going to happen
> for the stack pointer mask/offset approach)

I'd love to see the native GCC offset stuff work on arm32, but it's not
clear to me how much work that would be. It's implemented for several
architectures already. I've tried to capture the matrix here:
https://github.com/KSPP/linux/issues/29

-Kees

-- 
Kees Cook
