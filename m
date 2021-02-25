Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B84325893
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 22:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234055AbhBYVY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 16:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233248AbhBYVYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 16:24:24 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C759C061574
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:23:43 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id r23so8203748ljh.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 13:23:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2W9mYsFcnJXVFNTaQWfslLMblusb1q2fKiT5ua94ENs=;
        b=ATLnwbUwp4jcA0fAaaywBCUT2P9oXGAKvyyOW3EfbYRnGqIZQKeDYcvwnckB9prQPA
         GSeiQc9XCFiqPz+xcfiJnpgCb/LCsID6WivmGEwGbqGUjcaASDhAz3d7k2B4FEv5STTO
         s0lYOLf45+t8emz5C0OZInH5IcQ/I6IDMzmx8jic++iuRJcnuMrJunv7kIuhBEkqAO22
         wNbwo88e3YEj9AsKOF6H3ozOFEC9MBO0ataGezH8a7QhCPCin1A/NPwTcoiWbZRakiNo
         QJBHiZK9YKAQeEjdOzQFT0yy80VC3eZjQmSqV475L63YNdUJZWVo12A2PGbAnOKZncRA
         1uFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2W9mYsFcnJXVFNTaQWfslLMblusb1q2fKiT5ua94ENs=;
        b=JQJ+61njRoedg8kCnYpVx2pdol5szGOeHQACTHC8tJkI7Dv8kkjEAuTjYnPeDLUFPX
         1ldVJWcgPdF0VOsqfqt0hVukTn62w4nJGKd99x1aGFU/02J9TSAQtdYwIhYKGNMqc4Yh
         UFiBT3ZRNkhAHzzPI2Yq8eLJxCoQeK4SlC/CHODXHWlHoxG9xv4oFPYD5Ru4CkgnvYg7
         drtsnD1lr8UKtAp+35wN7Tgb3l1Keg0780KIaUK4inI1jaQM+YfqH0PwfvvrGzKK2L4R
         zx/jOswFdq6CEUeiOGUCfH/KesYe+XfXPJWTmqWSvRx/8vfnJU6vTt7o3qwYU1tAYRZZ
         KAzA==
X-Gm-Message-State: AOAM530qMNHe20cJZSyc2ZxQ+fqZq7S99O6ZlzcDQ5yBMgOJRUAQwmlk
        iyk+B5LA0xHSnWIMTkBhhXOnExCXd5G9F56uC2s/PA==
X-Google-Smtp-Source: ABdhPJyNDEpjNI3d77JS9Vmv0ZpRge81wt25ZlS0g7kAq8vePalKsOKCNPvq2zUO5k00Ns0ar7qbYQ5BtIXe1yGoJE0=
X-Received: by 2002:a2e:2a83:: with SMTP id q125mr2585287ljq.244.1614288221350;
 Thu, 25 Feb 2021 13:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20210225094324.3542511-1-arnd@kernel.org> <20210225164522.GA3554437@xps15>
In-Reply-To: <20210225164522.GA3554437@xps15>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 Feb 2021 13:23:30 -0800
Message-ID: <CAKwvOdm_yh6gw_ecjeKgepRb12Q69Wk64x7xj=L2CDjBekiioA@mail.gmail.com>
Subject: Re: [PATCH] coresight: etm4x: work around clang-12+ build failure
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        coresight@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Bill Wendling <morbo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 8:45 AM Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> Good morning,
>
> On Thu, Feb 25, 2021 at 10:42:58AM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > clang-12 fails to build the etm4x driver with -fsanitize=array-bounds:
> >
> > <instantiation>:1:7: error: expected constant expression in '.inst' directive
> > .inst (0xd5200000|((((2) << 19) | ((1) << 16) | (((((((((((0x160 + (i * 4))))) >> 2))) >> 7) & 0x7)) << 12) | ((((((((((0x160 + (i * 4))))) >> 2))) & 0xf)) << 8) | (((((((((((0x160 + (i * 4))))) >> 2))) >> 4) & 0x7)) << 5)))|(.L__reg_num_x8))
> >       ^
> > drivers/hwtracing/coresight/coresight-etm4x-core.c:702:4: note: while in macro instantiation
> >                         etm4x_relaxed_read32(csa, TRCCNTVRn(i));
> >                         ^
> > drivers/hwtracing/coresight/coresight-etm4x.h:403:4: note: expanded from macro 'etm4x_relaxed_read32'
> >                  read_etm4x_sysreg_offset((offset), false)))
> >                  ^
> > drivers/hwtracing/coresight/coresight-etm4x.h:383:12: note: expanded from macro 'read_etm4x_sysreg_offset'
> >                         __val = read_etm4x_sysreg_const_offset((offset));       \
> >                                 ^
> > drivers/hwtracing/coresight/coresight-etm4x.h:149:2: note: expanded from macro 'read_etm4x_sysreg_const_offset'
> >         READ_ETM4x_REG(ETM4x_OFFSET_TO_REG(offset))
> >         ^
> > drivers/hwtracing/coresight/coresight-etm4x.h:144:2: note: expanded from macro 'READ_ETM4x_REG'
> >         read_sysreg_s(ETM4x_REG_NUM_TO_SYSREG((reg)))
> >         ^
> > arch/arm64/include/asm/sysreg.h:1108:15: note: expanded from macro 'read_sysreg_s'
> >         asm volatile(__mrs_s("%0", r) : "=r" (__val));                  \
> >                      ^
> > arch/arm64/include/asm/sysreg.h:1074:2: note: expanded from macro '__mrs_s'
> > "       mrs_s " v ", " __stringify(r) "\n"                      \
> >  ^
> >
> > It appears that the __builin_constant_p() check in
> > read_etm4x_sysreg_offset() falsely returns 'true' here because clang
> > decides finds that an out-of-bounds access to config->cntr_val[] cannot
> > happen, and then it unrolls the loop with constant register numbers. Then

Is a sanitizer enabled, that would trap on OOB?

> > when actually emitting the output, it fails to figure out the value again.
> >
> > While this is incorrect behavior in clang, it is easy to work around
> > by avoiding the out-of-bounds array access. Do this by limiting the
> > loop counter to the actual dimension of the array.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1310
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/hwtracing/coresight/coresight-etm4x-core.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > index 15016f757828..4cccf874a602 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > @@ -691,13 +691,13 @@ static void etm4_disable_hw(void *info)
> >                       "timeout while waiting for PM stable Trace Status\n");
> >
> >       /* read the status of the single shot comparators */
> > -     for (i = 0; i < drvdata->nr_ss_cmp; i++) {
> > +     for (i = 0; i < min_t(u32, drvdata->nr_ss_cmp, ETM_MAX_SS_CMP); i++) {
> >               config->ss_status[i] =
> >                       etm4x_relaxed_read32(csa, TRCSSCSRn(i));
> >       }
> >
> >       /* read back the current counter values */
> > -     for (i = 0; i < drvdata->nr_cntr; i++) {
> > +     for (i = 0; i < min_t(u32, drvdata->nr_cntr, ETMv4_MAX_CNTR); i++) {
>
> This patch will work and I'd be happy to apply it if this was the only instance,
> but there are dozens of places in the coresight drivers where such patterns are
> used.  Why are those not flagged as well?  And shouldn't the real fix be with
> clang?

It's important to understand the __builtin_constant_p is highly
sensitive to optimizations; code using it typically relies on
optimizations being performed before it's evaluated.  Which
optimizations, applied successfully or not, in what order, by which
compiler or versions of the same compiler can affect what
__builtin_constant_p evaluates to.  Code generally needs to be written
to assume that failure for __builtin_constant_p to evaluate to a
specific value or not is _not a bug_.

>
> Thanks,
> Mathieu
>
> >               config->cntr_val[i] =
> >                       etm4x_relaxed_read32(csa, TRCCNTVRn(i));
> >       }
> > --
> > 2.29.2
> >



-- 
Thanks,
~Nick Desaulniers
