Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401433E4C08
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbhHISV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhHISV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:21:57 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FE0C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 11:21:36 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id h11so9894778ljo.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 11:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o5zuuiSqkt5CQVCQBhxzBgsUDDyFkQR2T8UACZkRMSI=;
        b=u++lQ9brhwsAryqHgoRXQTQWvVVkQXJCNPH1qa11WDWUmkkI699NKXpmFhSXywe99R
         H2WM+qFiSSqYaJJygpNh/PEdVatdZA9Ed7JD9UUz7J+ZkSsIix0tl4hE9fndjVasYWX7
         Ac92CwmQc5yhopPY0tiJSa8GJRyVeJIh5ogAT7qGX0628g+zWg6hhng/yu3Djr7mGtva
         JWTxFNUQCOe4q+zi+wQ9uXiLdjTxTk2l5yvXnnY5unpJA8W8aSmgzE85t6qlTCICIRF/
         4uc/pnXzv5PLYIG0DWwp/WR+DvNw4FpOKrDlTYtOVWEs/egwn49BPT6enNrEAPsNiisc
         XA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o5zuuiSqkt5CQVCQBhxzBgsUDDyFkQR2T8UACZkRMSI=;
        b=O237k2+0jPCDwnG6rf13xi18wy5c8t/In9nqUjIeLI/DRPRWBrNet4bO5upcgtl50R
         g1Au1aIbERZXKwoUXoB462GBYrS7yYIYtRZr7+f+6TA/swiv0PSMFD1HmNkhXjcXdQtR
         qAlzLdAehIQrdDHwEBEQ5a9pD3dO19HqAboDDQxQ6loYGpJwsn5uiC47R/iIcCPbavsH
         AGx32BWmYNm/7bzcV94Rg5LVY4UnwAk+IxCHsp8fWuvDTBhSNCBL4OePkUwrv8CEYyof
         HJSMG7TV6DvqnGVyZjEQPImn7clPGLNpi+N9DFxanUYbtHzNTZ61NblSAqDM9DyWPuL5
         vElw==
X-Gm-Message-State: AOAM532DDBrx15P15rjztcOXpY0J5ADdw9hzZVC6DSm51R5nlvV+H3AV
        zf81WihyKGP51MvXmiK9mPZtupDP5kC2O1I3D4S6uQ==
X-Google-Smtp-Source: ABdhPJwKCmFjf/jOPLLfK5qU2IjNmkhd+660Pt9ZW3PtBy9zN+BcEZmxcFteo3+UmUNsgUDRNQ5W1tGrdY6jex54djw=
X-Received: by 2002:a2e:89c4:: with SMTP id c4mr16306583ljk.275.1628533293197;
 Mon, 09 Aug 2021 11:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152651.2297337-1-maz@kernel.org> <20210809152651.2297337-13-maz@kernel.org>
 <CAOQ_QsjT8DUoXQsxWGgGiZkwNe2itRswGomtq6-p+7_oU01orQ@mail.gmail.com> <87k0kubio6.wl-maz@kernel.org>
In-Reply-To: <87k0kubio6.wl-maz@kernel.org>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 9 Aug 2021 11:21:22 -0700
Message-ID: <CAOQ_Qsi6gL9R4Hc2-Ljc0E2uN4qu5upsxaEHTz0fY9CWuF1rVQ@mail.gmail.com>
Subject: Re: [PATCH 12/13] arm64: Add a capability for FEAT_EVC
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Shier <pshier@google.com>,
        Raghavendra Rao Ananta <rananta@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 11:02 AM Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Oliver,
>
> Thanks for having a look.
>
> On Mon, 09 Aug 2021 17:30:45 +0100,
> Oliver Upton <oupton@google.com> wrote:
> >
> > Hi Marc,
> >
> > On Mon, Aug 9, 2021 at 8:48 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > Add a new capability to detect the Enhanced Counter Virtualization
> > > feature (FEAT_EVC).
> > >
> >
> > s/FEAT_EVC/FEAT_ECV/g
>
> I'm the knig fo tpyoes :).
>
> >
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > ---
> > >  arch/arm64/kernel/cpufeature.c | 10 ++++++++++
> > >  arch/arm64/tools/cpucaps       |  1 +
> > >  2 files changed, 11 insertions(+)
> > >
> > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > index 0ead8bfedf20..9c2ce5408811 100644
> > > --- a/arch/arm64/kernel/cpufeature.c
> > > +++ b/arch/arm64/kernel/cpufeature.c
> > > @@ -1899,6 +1899,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> > >                 .sign = FTR_UNSIGNED,
> > >                 .min_field_value = 1,
> > >         },
> > > +       {
> > > +               .desc = "Enhanced counter virtualization",
> > > +               .capability = ARM64_HAS_ECV,
> > > +               .type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > > +               .matches = has_cpuid_feature,
> > > +               .sys_reg = SYS_ID_AA64MMFR0_EL1,
> > > +               .field_pos = ID_AA64MMFR0_ECV_SHIFT,
> > > +               .sign = FTR_UNSIGNED,
> > > +               .min_field_value = 1,
> > > +       },
> >
> > Per one of your other patches in the series, it sounds like userspace
> > access to the self-synchronized registers hasn't been settled yet.
> > However, if/when available to userspace, should this cpufeature map to
> > an ELF HWCAP?
>
> We can't prevent the access to userspace, unless we also trap
> cntvct_el0 and cntfreq_el0. Which we try not to do. But you are indeed
> correct, we probably have a HWCAP if we decide to advertise it to
> userspace.
>
> > Also, w.r.t. my series I have out for ECV in KVM. All the controls
> > used in EL2 depend on ECV=0x2. I agree that ECV=0x1 needs a cpufeature
> > bit, but what about EL2's use case?
>
> My idea was to have a ARM64_HAS_ECV2 to capture the EL2 extensions
> with min_field_value=2.

This SGTM. I imagine with your HWCAP patch you will be passing through
ID_AA64MMFR0_EL1.ECV to userspace too. Dunno if we should clamp to 1
or let userspace see ECV=2 when we enumerate the second cpufeature.
Definitely not worthy of a HWCAP, though.

--
Thanks,
Oliver


> > Besides the typo:
> >
> > Reviewed-by: Oliver Upton <oupton@google.com>
>
> Thanks,
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
