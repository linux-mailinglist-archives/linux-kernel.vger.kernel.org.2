Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451BE3E4C0C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbhHISYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhHISYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:24:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7C4C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 11:23:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z2so19054949lft.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 11:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mFcKESg95OwOYvBEQmC1K8/lkQRN79KHNMct+H7dZpY=;
        b=F8xMkSA9KuBNxwvB5S+VZVhU0Tkpl7SrJAHO+7fWRETiNSEPyinKP7doN55OcY/L5p
         w5pfSqdk65RimLCgaIzW8yRZmPmuNYsbhuhx6YiZ9lMK0RCDT6gOgyffGal2jRtp68Jn
         NnuI2oA0sFigdROL4qFJJQ5w5dHF4S3sHVolhs1qO7j4jN/enY4HkOCaf9CtZ4OasJSK
         stG4INs9rWpoR1Op2ALT4HerSIbPCP1rJJHMSCHPIDAUOdMMOoN28cCJpGH2M5AmhzZG
         VvFkiS+nsZCM6jpz4G3VmLkb+5IsZl6j42tXVno+MfO36+mvmF1BT+0xK7NPQyM35bKS
         f8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mFcKESg95OwOYvBEQmC1K8/lkQRN79KHNMct+H7dZpY=;
        b=iX8nZmILpMP078S93qx2aVCm3yA3rqrEj5RT08YuoHJdxppjh92BLZqadLscshIX+Q
         Waa0r2RTiDyRhPdil+tT30EzU3hp9PHPRITBlmOBkgAeEpDkZKIVR3ehhmVjYgI5ezyH
         ZICEkNNPps+CMwFWTNFrGSxAxe6O2v7XMHGzIbgTalopY/CCB2IkQaBDDp3eoncQynxA
         AziKCX3dcD+zJnKB0BPdbFSX1oIcCXipko+3NoIZSInxXVK1bwCuaXtxERRCo6Jtt/rv
         4JQ4kGKXfvDtr8Ftp2ihDf06fxAMAdFD1riOwJeUEn2Gnw83X+bL8GSVai1hY5UhJq0C
         nPwg==
X-Gm-Message-State: AOAM530Nfm1D4q2Yeo9VUeq0H67Y6ThKV7d3vHbDB9Qjajmgdy6uNrLJ
        pvhI67G/vuIOvc2TSU5jYXpFF3+mN6DQbnIwrBgb2g==
X-Google-Smtp-Source: ABdhPJwTDnmIIfgECfQhfq0EuGZBlkxRmSMZ+ZMrgPrZQZndzGhBRv1m0hhEvTj3ONdPa2l3/gb7qsynyE+P/oTWvz0=
X-Received: by 2002:ac2:57cd:: with SMTP id k13mr18945893lfo.117.1628533423663;
 Mon, 09 Aug 2021 11:23:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152651.2297337-1-maz@kernel.org> <20210809152651.2297337-13-maz@kernel.org>
 <CAOQ_QsjT8DUoXQsxWGgGiZkwNe2itRswGomtq6-p+7_oU01orQ@mail.gmail.com>
 <87k0kubio6.wl-maz@kernel.org> <CAOQ_Qsi6gL9R4Hc2-Ljc0E2uN4qu5upsxaEHTz0fY9CWuF1rVQ@mail.gmail.com>
In-Reply-To: <CAOQ_Qsi6gL9R4Hc2-Ljc0E2uN4qu5upsxaEHTz0fY9CWuF1rVQ@mail.gmail.com>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 9 Aug 2021 11:23:32 -0700
Message-ID: <CAOQ_QsgQhBcnOxbanhmWoNQsKUQJUkLJZCOOBDtOC29guugKrA@mail.gmail.com>
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

Oh, one more thing,

On Mon, Aug 9, 2021 at 11:21 AM Oliver Upton <oupton@google.com> wrote:
>
> On Mon, Aug 9, 2021 at 11:02 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > Hi Oliver,
> >
> > Thanks for having a look.
> >
> > On Mon, 09 Aug 2021 17:30:45 +0100,
> > Oliver Upton <oupton@google.com> wrote:
> > >
> > > Hi Marc,
> > >
> > > On Mon, Aug 9, 2021 at 8:48 AM Marc Zyngier <maz@kernel.org> wrote:
> > > >
> > > > Add a new capability to detect the Enhanced Counter Virtualization
> > > > feature (FEAT_EVC).
> > > >
> > >
> > > s/FEAT_EVC/FEAT_ECV/g
> >
> > I'm the knig fo tpyoes :).
> >
> > >
> > > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > > ---
> > > >  arch/arm64/kernel/cpufeature.c | 10 ++++++++++
> > > >  arch/arm64/tools/cpucaps       |  1 +
> > > >  2 files changed, 11 insertions(+)
> > > >
> > > > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > > > index 0ead8bfedf20..9c2ce5408811 100644
> > > > --- a/arch/arm64/kernel/cpufeature.c
> > > > +++ b/arch/arm64/kernel/cpufeature.c
> > > > @@ -1899,6 +1899,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> > > >                 .sign = FTR_UNSIGNED,
> > > >                 .min_field_value = 1,
> > > >         },
> > > > +       {
> > > > +               .desc = "Enhanced counter virtualization",

Pesky nit: "Enhanced Counter Virtualization"

> > > > +               .capability = ARM64_HAS_ECV,
> > > > +               .type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > > > +               .matches = has_cpuid_feature,
> > > > +               .sys_reg = SYS_ID_AA64MMFR0_EL1,
> > > > +               .field_pos = ID_AA64MMFR0_ECV_SHIFT,
> > > > +               .sign = FTR_UNSIGNED,
> > > > +               .min_field_value = 1,
> > > > +       },
> > >
> > > Per one of your other patches in the series, it sounds like userspace
> > > access to the self-synchronized registers hasn't been settled yet.
> > > However, if/when available to userspace, should this cpufeature map to
> > > an ELF HWCAP?
> >
> > We can't prevent the access to userspace, unless we also trap
> > cntvct_el0 and cntfreq_el0. Which we try not to do. But you are indeed
> > correct, we probably have a HWCAP if we decide to advertise it to
> > userspace.
> >
> > > Also, w.r.t. my series I have out for ECV in KVM. All the controls
> > > used in EL2 depend on ECV=0x2. I agree that ECV=0x1 needs a cpufeature
> > > bit, but what about EL2's use case?
> >
> > My idea was to have a ARM64_HAS_ECV2 to capture the EL2 extensions
> > with min_field_value=2.
>
> This SGTM. I imagine with your HWCAP patch you will be passing through
> ID_AA64MMFR0_EL1.ECV to userspace too. Dunno if we should clamp to 1
> or let userspace see ECV=2 when we enumerate the second cpufeature.
> Definitely not worthy of a HWCAP, though.
>
> --
> Thanks,
> Oliver
>
>
> > > Besides the typo:
> > >
> > > Reviewed-by: Oliver Upton <oupton@google.com>
> >
> > Thanks,
> >
> >         M.
> >
> > --
> > Without deviation from the norm, progress is not possible.
