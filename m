Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A07A3E4A12
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 18:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhHIQfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 12:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhHIQfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 12:35:00 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A78EC061796
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 09:34:40 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id u13so24478772lje.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 09:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K7YOdACwjhSqCE+6pPfew3F4ACBqKW2uMGtfkgFzo0w=;
        b=fhZqxhwCVCkjULz1lBuhBxpPbR8EAqjfx0TyzDlH3BpKKaFSyYEgo9vzzEDQkl/Qsp
         WvOusRc7qX1J33vjnBsDxwqwTxlE6eny/2dogsC83S6MQWOTmQTQCTsl9zs/HrY3pWyu
         SARFdJgtliK5rDQir1KgsJkcNZmBB99hIO8o5mQdBRJQRZMq3OAcJYDoUS9aeplesrAS
         Deerdv8TG6GSCJgdC5Z/2WD8rmZ/9RszUhpVyYpuTWOCBFWc3zOmL3Kz1N3V8IczoAGy
         PIzM7hQajz1CPPCMFK8MO+J+OEA+9tShJH3DjlxNnMNPRNe/nX/86CBRgvVWjzG+haJH
         mPIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K7YOdACwjhSqCE+6pPfew3F4ACBqKW2uMGtfkgFzo0w=;
        b=Z/iAftEmuIcOcRH5LZqrLzMXVHqTcaJAQfGb1almKRxGp2heBOqc8XeIopymAI1gC2
         RdZb3V5SbbsRzTeeBtXxKT8Cmu/IjTVJYoapyiXMdKmWErQKGIpXrReldIsDkoJh33dQ
         gAPC6jkLXwW8a5s/pNzO0ZKnS4qNYqqbtXjlaESp0I+4MYKyykJ7JDQKQs7cNty/bH3Y
         lNkpMrIYp/8Sm5MZyT5lTB+hKarPHb/IstN2eWoJWQkmkm8AN/R2DEOY/uCD/GknqMow
         +t43pJiMcPR7vN7/nkPreNqRD2Z7p8peuWUZLFDSD3ogJWncNsCmX+vSSY/Azfoz0kkY
         JDRQ==
X-Gm-Message-State: AOAM533Kps76zK8ZKPc8xAjKgwWLnJtAm9sAUHHLu2P9lwgj7Tl/HqlY
        WrHIGte/nWuvdWAg9+ZwR0GvkI3Wmx55toBXU1uBww==
X-Google-Smtp-Source: ABdhPJw4FURviq1RV5ndLqnqrm/+yRNAahPebIx2LrJKDzUd4iEkMfw+M2QqhDob2oylU0aZprvmijb9d/EoMTRj4ac=
X-Received: by 2002:a2e:b8d3:: with SMTP id s19mr13820923ljp.388.1628526878265;
 Mon, 09 Aug 2021 09:34:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210809152651.2297337-1-maz@kernel.org> <20210809152651.2297337-13-maz@kernel.org>
 <CAOQ_QsjT8DUoXQsxWGgGiZkwNe2itRswGomtq6-p+7_oU01orQ@mail.gmail.com>
In-Reply-To: <CAOQ_QsjT8DUoXQsxWGgGiZkwNe2itRswGomtq6-p+7_oU01orQ@mail.gmail.com>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 9 Aug 2021 09:34:26 -0700
Message-ID: <CAOQ_QshvUVB-Ey3P0MJbj9OxU46kis6=Lo4soz_g_WebgRuvyg@mail.gmail.com>
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

On Mon, Aug 9, 2021 at 9:30 AM Oliver Upton <oupton@google.com> wrote:
>
> Hi Marc,
>
> On Mon, Aug 9, 2021 at 8:48 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > Add a new capability to detect the Enhanced Counter Virtualization
> > feature (FEAT_EVC).
> >
>
> s/FEAT_EVC/FEAT_ECV/g
>
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> >  arch/arm64/kernel/cpufeature.c | 10 ++++++++++
> >  arch/arm64/tools/cpucaps       |  1 +
> >  2 files changed, 11 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 0ead8bfedf20..9c2ce5408811 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -1899,6 +1899,16 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
> >                 .sign = FTR_UNSIGNED,
> >                 .min_field_value = 1,
> >         },
> > +       {
> > +               .desc = "Enhanced counter virtualization",
> > +               .capability = ARM64_HAS_ECV,
> > +               .type = ARM64_CPUCAP_SYSTEM_FEATURE,
> > +               .matches = has_cpuid_feature,
> > +               .sys_reg = SYS_ID_AA64MMFR0_EL1,
> > +               .field_pos = ID_AA64MMFR0_ECV_SHIFT,
> > +               .sign = FTR_UNSIGNED,
> > +               .min_field_value = 1,
> > +       },
>
> Per one of your other patches in the series, it sounds like userspace
> access to the self-synchronized registers hasn't been settled yet.
> However, if/when available to userspace, should this cpufeature map to
> an ELF HWCAP?
>
> Also, w.r.t. my series I have out for ECV in KVM. All the controls
> used in EL2 depend on ECV=0x2. I agree that ECV=0x1 needs a cpufeature
> bit, but what about EL2's use case?

Forgot to link the series:

http://lore.kernel.org/r/20210804085819.846610-1-oupton@google.com

>
> Besides the typo:
>
> Reviewed-by: Oliver Upton <oupton@google.com>
>
> --
> Thanks,
> Oliver
>
> >  #ifdef CONFIG_ARM64_PAN
> >         {
> >                 .desc = "Privileged Access Never",
> > diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> > index 49305c2e6dfd..7a7c58acd8f0 100644
> > --- a/arch/arm64/tools/cpucaps
> > +++ b/arch/arm64/tools/cpucaps
> > @@ -18,6 +18,7 @@ HAS_CRC32
> >  HAS_DCPODP
> >  HAS_DCPOP
> >  HAS_E0PD
> > +HAS_ECV
> >  HAS_EPAN
> >  HAS_GENERIC_AUTH
> >  HAS_GENERIC_AUTH_ARCH
> > --
> > 2.30.2
> >
