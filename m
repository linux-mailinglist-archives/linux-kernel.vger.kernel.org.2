Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACF7D31A3AE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbhBLRb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbhBLRbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:31:22 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EADC0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 09:30:42 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u16so329921wmq.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 09:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m26TZ2tJuGxHBQo60qfAvVdy7loPGID74+UtZKlfkOg=;
        b=Qfnmud5g3lCzCePjlJrPbZtUmeeJR8MxWC9cXk14YQdskS8dsXWY1w17KCQwnHc2Hz
         jZnbB1OkLK36/68EMpyLPCv5iF9m33zhbWAzTf1v6wo9eZy2lzEcctCtrrkt53I91zNc
         eD9Y1Wd0etCGfEs/pZDzNcwvPMyIcbJlm38GWbg6dTxu2yILiMp1OybumgoJT7DvIRgV
         23zhen8nr6Rm/qHhVoX9yMTKK95WY8VX0YlQ2kOeYlnTSBhZtcWeIhqwpzksoF4dtceo
         CBaX+sWlRpdCrInLYacJnotHP4cUDsGlqwqY+joMmnZJcvfyXAIwJfx6DO8nnVg4vIyv
         6/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m26TZ2tJuGxHBQo60qfAvVdy7loPGID74+UtZKlfkOg=;
        b=XmcZ5RQprE4r0purvHDOwOqMxwQ5Wds0dbB04Ms5/3B/M8BjRABiPTItTGe0rqySXR
         X5n+F+xYqiPMfUrEhXa50czeRHEC82fttEcUr1Gh+1uGhzOsw7A/WKqvWw/jMf8XeD0r
         hy/UXu+SRbu/i13lSzlMUsUaXFcD7YsOu9gNv8DrKM71oe+VcBsB5CBeF8gW/SX7H8cq
         IP1Lawja8LOzNo8HDC5YiXsc0UXnW7z9wo6ByDHSFE+JK81z7N1zWE7bVGfLn4rrbkNd
         ON6E07+yEoXErOud6rxq57pxvAxPo6pQHnC93qPNn7PKOAxmMVBNBhJ/ViiVcm0jw6KO
         JLLg==
X-Gm-Message-State: AOAM532U4DAbZlDchqipAW97rRz3g9cJZISdjYJpVQjNLNmVFY31lboc
        pMgQE66XsD+fmyUzz8kRsk/JKo59K2fBoKjH0asWsw==
X-Google-Smtp-Source: ABdhPJy52YXbmOf00JWxlF3hemo/oj+rIHdEoWUO9Pr70Gx3wPY4oq9ObryiZJyNQPBO2ODs9Ho/MP/A9bIPQzCvgJc=
X-Received: by 2002:a7b:c952:: with SMTP id i18mr3177294wml.5.1613151041500;
 Fri, 12 Feb 2021 09:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
 <20210110224850.1880240-29-suzuki.poulose@arm.com> <CAJ9a7ViwNA__+5f7-DehM6OtGer3DjdZfWsgHc9EOcr5-vQXgA@mail.gmail.com>
 <72f85de4-5b39-c963-78cf-2f8347e21268@arm.com>
In-Reply-To: <72f85de4-5b39-c963-78cf-2f8347e21268@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Fri, 12 Feb 2021 17:30:30 +0000
Message-ID: <CAJ9a7Vh-CkYQrxgTv-erb6MBXkXWkFg6xF5vEem4iQyOx9LYkw@mail.gmail.com>
Subject: Re: [PATCH v7 28/28] coresight: Add support for v8.4 SelfHosted tracing
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Zhou <jonathan.zhouwen@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Fri, 12 Feb 2021 at 15:36, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi Mike
>
> On 2/12/21 10:34 AM, Mike Leach wrote:
> > Hi Mathieu, Suzuki,
> >
> > Sorry for the really late response on this patch, but I noticed a
> > problem while doing a review of the ETE / TRBE set. (TRBE specs
> > mention TRFCR_ELx, so I was confirming a couple of things).
> >
> > On Sun, 10 Jan 2021 at 22:49, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> >>
> >> From: Jonathan Zhou <jonathan.zhouwen@huawei.com>
> >>
> >> v8.4 tracing extensions added support for trace filtering controlled
> >> by TRFCR_ELx. This must be programmed to allow tracing at EL1/EL2 and
> >> EL0. The timestamp used is the virtual time. Also enable CONTEXIDR_EL2
> >> tracing if we are running the kernel at EL2.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Mike Leach <mike.leach@linaro.org>
> >> Cc: Will Deacon <will@kernel.org>
> >> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >> Signed-off-by: Jonathan Zhou <jonathan.zhouwen@huawei.com>
> >> [ Move the trace filtering setup etm_init_arch_data() and
> >>   clean ups]
> >> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> ---
> >>   .../coresight/coresight-etm4x-core.c          | 25 +++++++++++++++++++
> >>   1 file changed, 25 insertions(+)
> >>
> >> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> index 3d3165dd09d4..18c1a80abab8 100644
> >> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> >> @@ -859,6 +859,30 @@ static bool etm4_init_csdev_access(struct etmv4_drvdata *drvdata,
> >>          return false;
> >>   }
> >>
> >> +static void cpu_enable_tracing(void)
> >> +{
> >> +       u64 dfr0 = read_sysreg(id_aa64dfr0_el1);
> >> +       u64 trfcr;
> >> +
> >> +       if (!cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_TRACE_FILT_SHIFT))
> >> +               return;
> >> +
> >> +       /*
> >> +        * If the CPU supports v8.4 SelfHosted Tracing, enable
> >> +        * tracing at the kernel EL and EL0, forcing to use the
> >> +        * virtual time as the timestamp.
> >> +        */
> >> +       trfcr = (TRFCR_ELx_TS_VIRTUAL |
> >> +                TRFCR_ELx_ExTRE |
> >> +                TRFCR_ELx_E0TRE);
> >> +
> >> +       /* If we are running at EL2, allow tracing the CONTEXTIDR_EL2. */
> >> +       if (is_kernel_in_hyp_mode())
> >> +               trfcr |= TRFCR_EL2_CX;
> >> +
> >
> > This is wrong - CX bit is present on TRFCR_EL2, not TRFCR_EL1.
>
> Why is this wrong ? We do this only when we are in EL2.
>

Sorry  - must have been looking at an older version of the ARMARM when
I looked for EL1 registers that are aliased to EL2.  So this does
indeed work!

> > Moreover, TRFCR_EL2 has a separate enables for tracing at EL0 and EL2.
> >
>
> True, that is for EL0&2 translation regimes. i.e, tracing EL0 with
> the kernel running at EL2. But bits TRFCR_EL2.E2TRE == TRFCR_EL1.E1TRE
> If notice, we name the bit TRFCR_ELx_ExTRE. And E0TRE == E0HTRE.
>
> So we do the following :
>
>    1) When kernel running at EL2:
>      Enable tracing at EL2 and EL0 and context tracking
>    2) When kernel running at EL1:
>      Enable tracing at EL1 and EL0.
>
>
> > Secondly - is this correct in principal?  Should the driver not be
> > reading the access it is permitted by the kernel, rather than giving
> > itself unfettered access to trace where it wants to.
>
> I dont follow the "access permitted by the kernel" here. What are we referrring to ?
>

By that I mean that as I suggest below this should be controlled by
what we could call the hypervisor, rather than a driver.

> > Surely TRFCR_ELx  levels should be chosen in KConfig  and then should
> > be set up in kernel initialisation?
>
> I disagree with yet another Kconfig. This basic requirement for
> enabling the trace collection. It is not something that we can optionally
> use from the architecture. So we should transparently do the right
> thing for making sure that we set up the system for something that
> didn't require any other steps. Or in other words, if we add a Kconfig
> option for TRFCR programming, if someone forgets to select it
> when they upgraded the kernel they are in for a surprisingly long
> debugging to find why the trace doesnt work.
>
> As for the TRFCR programming, we have two choices. etm4x driver
> or generic boot up for the CPU. I preferred to do this in the
> driver as we can enable it only if trace drivers are available.
>

The point is that TRFCR are not part of the controlling registers for
the ETE or any trace source device. The architecture manual seems to
regard them as being controlled by the hypervisor, rather than the PE
trace device. This implies that the control feature is designed to be
independent from the trace generation features.

I thought they were there to allow virtualisation code to determine
what gets traced and what is prohibited, and what view the trace sees
of the clock. If you simple switch everything on from the driver and
control the ELs traced from the ETE / ETM registers then what are they
there for?

This solution could be a first pass at this to get trace working, but
I think it will have to change in future.

Regards

Mike



> Cheers
> Suzuki
>
> >
> > Regards
> >
> > Mike
> >
> >
> >
> >> +       write_sysreg_s(trfcr, SYS_TRFCR_EL1);
> >> +}
> >> +
> >>   static void etm4_init_arch_data(void *info)
> >>   {
> >>          u32 etmidr0;
> >> @@ -1044,6 +1068,7 @@ static void etm4_init_arch_data(void *info)
> >>          /* NUMCNTR, bits[30:28] number of counters available for tracing */
> >>          drvdata->nr_cntr = BMVAL(etmidr5, 28, 30);
> >>          etm4_cs_lock(drvdata, csa);
> >> +       cpu_enable_tracing();
> >>   }
> >>
> >>   static inline u32 etm4_get_victlr_access_type(struct etmv4_config *config)
> >> --
> >> 2.24.1
> >>
> >
> >
> > --
> > Mike Leach
> > Principal Engineer, ARM Ltd.
> > Manchester Design Centre. UK
> >
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
