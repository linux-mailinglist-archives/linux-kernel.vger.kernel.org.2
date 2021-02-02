Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F70730BB9A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 11:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhBBJ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhBBJ6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:58:21 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7B7C0613ED
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 01:57:41 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id g10so19744759wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 01:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gUWdfryl2mEIDffgox1qZc46SxaAuEEaX9wvFDWySJY=;
        b=MYX4UAGuAYG76uxw79nQw0VTiLAi14nGvrvL7reS74PX07uV59kkx9lJ22e1nHUwDJ
         URKRfdZqic8BS89CRZewCvictCOw4RtZ/dFHHTvgiJIaSCwWqbFp3wNH7Iha9+WhIvkq
         ygVPMdbx/NfE1NhpjpHjwODDJEfjmxZAKotDKFcBC0CpXaruSyt7+kl1bUpMbpbHXuc5
         JtkW/ibDvryn+3Lu8RUMbzSetzUPyqjVs1oq17BUsA3yRhRbO/cegw9D6cguZheCi6tg
         xfDRuukrHmS3OjuOvl5TYSZCV+wXr2zalvRUxWhcEwAxLHAQzhjXGL7EgVCAcfvDRvB/
         G41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gUWdfryl2mEIDffgox1qZc46SxaAuEEaX9wvFDWySJY=;
        b=E+7EzZT+OMiNwC/Vtsaa2AZYugaGyStoi6VHmUXENffsXdKTb7p9BFsK0hrf7Tv9Vz
         NsZPN/3WRARR8ASllv/QMmbpFl3VcGMR0Ihun9UAeP7f8zyDY1TUmDcKgxaymK3XcHXB
         bNA2DUkVXX45MLsRkvO+AdpIKgc4gEaJqQuOqB5YTZIuLHhlZUpFPWfcqjhK4lEwTemJ
         mOs8PO+kfMNMYEbXsNjYdOjGEsb9ncWccN0BeolcztQuc/LUiI2JQsakOXcSwRkZ26f0
         PhHf606HOnhmlu88gYSbw9CrYJSFps0c4lxJnMbEUrf75G61NP/yLxC0/zl1d4gD/TY5
         QPFA==
X-Gm-Message-State: AOAM531l4d6nA2yJ/RIl7iiLTJrR/EylHoM5orTudUskTH5NB1BNCHa4
        UmJp5xAqlPEpeBYARl5z2Eqn4g==
X-Google-Smtp-Source: ABdhPJxE29ho4puVHuCIAx7AJHJgY3z3K/SPPM510lIEf5EY47+l9wT2D6bJXl5uysLvLX0dzdUNMA==
X-Received: by 2002:a5d:4e4c:: with SMTP id r12mr22738411wrt.354.1612259859803;
        Tue, 02 Feb 2021 01:57:39 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id s23sm2133774wmc.35.2021.02.02.01.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:57:39 -0800 (PST)
Date:   Tue, 2 Feb 2021 09:57:36 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, android-kvm@google.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Brazdil <dbrazdil@google.com>
Subject: Re: [RFC PATCH v2 11/26] KVM: arm64: Stub CONFIG_DEBUG_LIST at Hyp
Message-ID: <YBkiEPOYBGqfncwH@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-12-qperret@google.com>
 <20210201190620.GJ15632@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201190620.GJ15632@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 Feb 2021 at 19:06:20 (+0000), Will Deacon wrote:
> On Fri, Jan 08, 2021 at 12:15:09PM +0000, Quentin Perret wrote:
> > In order to use the kernel list library at EL2, introduce stubs for the
> > CONFIG_DEBUG_LIST out-of-lines calls.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/Makefile |  2 +-
> >  arch/arm64/kvm/hyp/nvhe/stub.c   | 22 ++++++++++++++++++++++
> >  2 files changed, 23 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/arm64/kvm/hyp/nvhe/stub.c
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/Makefile b/arch/arm64/kvm/hyp/nvhe/Makefile
> > index 1fc0684a7678..33bd381d8f73 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/Makefile
> > +++ b/arch/arm64/kvm/hyp/nvhe/Makefile
> > @@ -10,7 +10,7 @@ lib-objs := clear_page.o copy_page.o memcpy.o memset.o
> >  lib-objs := $(addprefix ../../../lib/, $(lib-objs))
> >  
> >  obj-y := timer-sr.o sysreg-sr.o debug-sr.o switch.o tlb.o hyp-init.o host.o \
> > -	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o
> > +	 hyp-main.o hyp-smp.o psci-relay.o early_alloc.o stub.o
> >  obj-y += ../vgic-v3-sr.o ../aarch32.o ../vgic-v2-cpuif-proxy.o ../entry.o \
> >  	 ../fpsimd.o ../hyp-entry.o ../exception.o
> >  obj-y += $(lib-objs)
> > diff --git a/arch/arm64/kvm/hyp/nvhe/stub.c b/arch/arm64/kvm/hyp/nvhe/stub.c
> > new file mode 100644
> > index 000000000000..c0aa6bbfd79d
> > --- /dev/null
> > +++ b/arch/arm64/kvm/hyp/nvhe/stub.c
> > @@ -0,0 +1,22 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Stubs for out-of-line function calls caused by re-using kernel
> > + * infrastructure at EL2.
> > + *
> > + * Copyright (C) 2020 - Google LLC
> > + */
> > +
> > +#include <linux/list.h>
> > +
> > +#ifdef CONFIG_DEBUG_LIST
> > +bool __list_add_valid(struct list_head *new, struct list_head *prev,
> > +		      struct list_head *next)
> > +{
> > +		return true;
> > +}
> > +
> > +bool __list_del_entry_valid(struct list_head *entry)
> > +{
> > +		return true;
> > +}
> > +#endif
> 
> Can we get away with defining our own CHECK_DATA_CORRUPTION macro instead?

Yes I think eventually it'd be nice to get there, but that has other
implications (e.g. how do you report something in dmesg from EL2?) so
perhaps we can keep that a separate series?

Cheers,
Quentin
