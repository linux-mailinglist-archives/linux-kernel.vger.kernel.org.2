Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E693FF0BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbhIBQIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbhIBQIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:08:43 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5550C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:07:44 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 8so2461704pga.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BGrVU98Zacn5uG81q99DxyUsWOrCnOhhT/dK37UsEiU=;
        b=lQfm8PKUgLZqfpgTk9CZI28oAthBMMxm9xTl2XYEBMCVut/D/XscAuELHGMabtiU7d
         r2FH9zrmKqXbJy4ol/w2QaFc1j7XV/o8NW4ubivUp4ALkp19LfVsupvUMlQANopLM2kw
         Y6zyDQRM8GOGvJO8BVMb/ni4OYK77TtzG+omQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BGrVU98Zacn5uG81q99DxyUsWOrCnOhhT/dK37UsEiU=;
        b=Vkh6I+4WiUxcogw+IZfw3mhR40iFOUNXXTR8DGU7YXcDCD9JyuSPeoGKjZBjvUbirf
         dtZZ1R7XFFap4QZJ+56Ekf5uyPEDDwr7sr7lVcGc+/jma6i6j3XOy4HDaCmjP7y99mHr
         ZvR04zrVVEXCMnz46/rNgPqr1rEYNVxlOAK0c9OF576wPyJztc4PCofgFf3yBmOnRxnu
         TfrsFvzM6/K8gvPZpp4DxPIS7dgkG1ytB7Ed79hILXTrylO5b+ljJNB8z8eek8Qc7IbG
         +ZJxPie9N7yoeqSVJnoRAeAPds1D5XbNsT2SVFdOPj2QQfbcLK2WhLI+VzAO/f69j79b
         3x/w==
X-Gm-Message-State: AOAM530E59jeIq4kQwYyTf82DEp5xSV3Bo1PuH5mqy7sxA4YFzGHc2gT
        HzinURUeX1FRqjz21jpXYVWvFg==
X-Google-Smtp-Source: ABdhPJzNQZasCUlINaO1/WxTEUOJhLcP6KAhMypIpiLxI1BdOKXxkzuvOj3gnCdQv+9EZtpdl5jh+Q==
X-Received: by 2002:a63:5413:: with SMTP id i19mr3942630pgb.297.1630598864267;
        Thu, 02 Sep 2021 09:07:44 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q22sm3111413pgn.67.2021.09.02.09.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:07:43 -0700 (PDT)
Date:   Thu, 2 Sep 2021 09:07:42 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Keith Packard <keithp@keithp.com>
Cc:     linux-kernel@vger.kernel.org, Abbott Liu <liuwenliang@huawei.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Jens Axboe <axboe@kernel.dk>, Jian Cai <jiancai@google.com>,
        Joe Perches <joe@perches.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
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
Message-ID: <202109020904.976207C@keescook>
References: <20210902155429.3987201-1-keithp@keithp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902155429.3987201-1-keithp@keithp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 08:54:26AM -0700, Keith Packard wrote:
> Placing thread_info in the kernel stack leaves it vulnerable to stack
> overflow attacks. This short series addresses that by using the
> existing THREAD_INFO_IN_TASK infrastructure.

Very cool! Thanks for working on this. If you want, you can refer to the
KSPP bug for this too:
https://github.com/KSPP/linux/issues/1

(Anyone want to do MIPS?)

-Kees

-- 
Kees Cook
