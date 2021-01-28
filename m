Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D43D5306E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 08:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbhA1HJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 02:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbhA1HIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 02:08:04 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6182AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:07:22 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id a25so5096563ljn.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 23:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U4Le4OADQ4X6UWQn59tMgq3QYv0xokdX9NaCQXSLbA4=;
        b=brLlSjOpHJW7xOqtvDyhDlKqhlcVrEUVlUgVf59vM6wrpbarF5/kxUUxweuZYfCL0K
         YNgMX0I+IyHS84Q4drYLBz2a6gQtPY5K5kBi1YhwbhcvVlWJoxoQhl0ukV869E+QkCxx
         MHFREUuF6+DlSj6FYjPiIAohSeUTd10VXmg5Nv8x5JBlNSebwC2MkIIGT3gldIsOVci/
         k8Cc1OybZAj13DIHJv/coyi9RFqJJKIfm6FPPEADY5wtBgDIT9Xsdbj7uCBlqhDI8zBK
         tchMEq34WlGyIFMGqni9sSXWQNvxnQ2sr8ksVm3JJfQia08+J167dtHsaI7HbFp+2wkc
         /5ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U4Le4OADQ4X6UWQn59tMgq3QYv0xokdX9NaCQXSLbA4=;
        b=GgV20Nykugn9Dq7HN4gag23wc8g5C0IY+5tW16vaVUF4X4o4UtppLQ36AdORZLPhSc
         F6iUQ2IcrE/NOEd06HJYrQu3GiRmNbzOmUAEuOm89t7GzkicskZ6q6eZkbdXIWILtCLw
         mn8m1duj2r5Ny+BD9Y1RjpZf3t3KWgeSUXssehAIda3tvNGWjO1zE+bYjAA26WBk2/zE
         6XCp41n9YBnpcwZN4zwoOXMUG0JbjNh++5yr27Zy8sP9r1d+WoKsSVs/jHIjxQ1u9qNu
         3Kh7FqL5PudUBTqKdMPnzrtshtuTuZLlY5uiEs7zNqGieRWp5i2vFFlVmcmlp7yszXMm
         RxHQ==
X-Gm-Message-State: AOAM533aEePIww1KORGoY3Zi+hzR/PGOjqJ9ItkRAK4S6xwz0EotMcrN
        r5EQeOnHT3fcy58wHHiPguTxdJ/PiX2CChLHQawybQ==
X-Google-Smtp-Source: ABdhPJyTeRWB2ugAst/H6rGNbz2aCzpR8+No66qDk0TfdmSulbKXbiH7KwrNR50HjwrGd+zytXhZ9MqGLDB2l7LMNLI=
X-Received: by 2002:a2e:9b57:: with SMTP id o23mr7948569ljj.314.1611817640923;
 Wed, 27 Jan 2021 23:07:20 -0800 (PST)
MIME-Version: 1.0
References: <1610712101-14929-1-git-send-email-sumit.garg@linaro.org> <20210126141818.GC29956@willie-the-truck>
In-Reply-To: <20210126141818.GC29956@willie-the-truck>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 28 Jan 2021 12:37:09 +0530
Message-ID: <CAFA6WYNdasL4SZ3f1TyEs3C1B_jHjxVi2stKofXuGD=AZUx_ZQ@mail.gmail.com>
Subject: Re: [PATCH v5] arm64: Enable perf events based hard lockup detector
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Jian-Lin Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Tue, 26 Jan 2021 at 19:48, Will Deacon <will@kernel.org> wrote:
>
> Hi Sumit,
>
> On Fri, Jan 15, 2021 at 05:31:41PM +0530, Sumit Garg wrote:
> > With the recent feature added to enable perf events to use pseudo NMIs
> > as interrupts on platforms which support GICv3 or later, its now been
> > possible to enable hard lockup detector (or NMI watchdog) on arm64
> > platforms. So enable corresponding support.
> >
> > One thing to note here is that normally lockup detector is initialized
> > just after the early initcalls but PMU on arm64 comes up much later as
> > device_initcall(). So we need to re-initialize lockup detection once
> > PMU has been initialized.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
>
> [...]
>
> > diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> > index 3605f77a..bafb7c8 100644
> > --- a/arch/arm64/kernel/perf_event.c
> > +++ b/arch/arm64/kernel/perf_event.c
> > @@ -23,6 +23,8 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/sched_clock.h>
> >  #include <linux/smp.h>
> > +#include <linux/nmi.h>
> > +#include <linux/cpufreq.h>
> >
> >  /* ARMv8 Cortex-A53 specific event types. */
> >  #define ARMV8_A53_PERFCTR_PREF_LINEFILL                              0xC2
> > @@ -1246,12 +1248,30 @@ static struct platform_driver armv8_pmu_driver = {
> >       .probe          = armv8_pmu_device_probe,
> >  };
> >
> > +static int __init lockup_detector_init_fn(void *data)
> > +{
> > +     lockup_detector_init();
> > +     return 0;
> > +}
> > +
> >  static int __init armv8_pmu_driver_init(void)
> >  {
> > +     int ret;
> > +
> >       if (acpi_disabled)
> > -             return platform_driver_register(&armv8_pmu_driver);
> > +             ret = platform_driver_register(&armv8_pmu_driver);
> >       else
> > -             return arm_pmu_acpi_probe(armv8_pmuv3_init);
> > +             ret = arm_pmu_acpi_probe(armv8_pmuv3_init);
> > +
> > +     /*
> > +      * Try to re-initialize lockup detector after PMU init in
> > +      * case PMU events are triggered via NMIs.
> > +      */
> > +     if (ret == 0 && arm_pmu_irq_is_nmi())
> > +             smp_call_on_cpu(raw_smp_processor_id(), lockup_detector_init_fn,
> > +                             NULL, false);
> > +
> > +     return ret;
>
> What's wrong with the alternative approach outlined by Mark:
>
> https://lore.kernel.org/r/20210113130235.GB19011@C02TD0UTHF1T.local
>
> ?

I have replied on this thread.

-Sumit

>
> Will
