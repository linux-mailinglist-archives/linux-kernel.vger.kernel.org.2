Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBC830AE2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 18:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhBARl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 12:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhBARll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 12:41:41 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24826C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 09:41:01 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id g10so17554702wrx.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 09:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NecD4Lj2Pit6+zWdziXlW+Wn9lKyelFLyjZNsi277Ko=;
        b=saZ8e5FdXuzKn/wEQOBBdHmpMeHPCpDbAv/xRAxSPOf23fsZYMdk8Yk22lsNT8n+FL
         svRxqoOqTKJjnuSSRyZ+qRx+Efu4w8zHaWLl+bSl/ojmyvBk5bvUIkcHW+jPkaRxjPKN
         AuYSYNzxd18rPUOdsf6Txex3i+Vh3AtUKjJGo1Ow2zHCOx3wA+tdweA4Y3kmSV52XQ2a
         F1I0mbphY6MnUwjZH6PqH8XWbY3tOU4tPce17NCIV/4I7dwNeuNs39OD0g/CRKmBMrJI
         gGZ/tUgRP+6B/DdP59LjGHj87qRLEduw7FMO7hwxvY088FTQz9Qdt46slGB/Tx6BSOG9
         YIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NecD4Lj2Pit6+zWdziXlW+Wn9lKyelFLyjZNsi277Ko=;
        b=CWftTJmb0C764rv7p6OXpLod4KjMYyIL6nc2L+O89Q/7hItLFSjmqeZTat2IY/gVi9
         lvHAbJ1snDkoX3pPVARD3EgJ61HjEW5kSxZwGFKkgM/5CsocRHcbIWGy0r0JLykgVU67
         UKxjU2UAkyeS4OBymiXBrSQHi2lEYxctoP0q+PgMAl7RA9+XY/N51Meo33ecu3WiX9Cg
         LHEXq55T6hvkWGwdDMs9rPGU2Qe4INaqneZr9M0KaDMTvXe4phZNlwqklkn+kMLCwtH6
         n/klc2rTn/Ia/NzUILGd60VKrfs7xhNakmYMuDbulNM7dasUXs0ffDbYnohOnHGZ+gl4
         +8Kw==
X-Gm-Message-State: AOAM531VomOuWiXKPIhW0k0Ye1OzGo+Y37fl1BVVkW7wt/3/xVX6ck5F
        FeICLzKP5IGRYjDf7DPOqzIjZQ==
X-Google-Smtp-Source: ABdhPJyVjTMobOwpzGXZWG3t6ZHVDL2R31hio+NCbOHokYHgLSzOJpH3gDsceNyauEudNIluLfZ9+g==
X-Received: by 2002:a5d:458a:: with SMTP id p10mr19485759wrq.168.1612201259731;
        Mon, 01 Feb 2021 09:40:59 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id r25sm29850479wrr.64.2021.02.01.09.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 09:40:59 -0800 (PST)
Date:   Mon, 1 Feb 2021 17:40:56 +0000
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
Subject: Re: [RFC PATCH v2 03/26] arm64: kvm: Add standalone ticket spinlock
 implementation for use at hyp
Message-ID: <YBg9KPnKfJzraTBO@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-4-qperret@google.com>
 <20210201172833.GA15632@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201172833.GA15632@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 Feb 2021 at 17:28:34 (+0000), Will Deacon wrote:
> On Fri, Jan 08, 2021 at 12:15:01PM +0000, Quentin Perret wrote:
> > From: Will Deacon <will@kernel.org>
> > 
> > We will soon need to synchronise multiple CPUs in the hyp text at EL2.
> > The qspinlock-based locking used by the host is overkill for this purpose
> > and relies on the kernel's "percpu" implementation for the MCS nodes.
> > 
> > Implement a simple ticket locking scheme based heavily on the code removed
> > by commit c11090474d70 ("arm64: locking: Replace ticket lock implementation
> > with qspinlock").
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/include/nvhe/spinlock.h | 92 ++++++++++++++++++++++
> >  1 file changed, 92 insertions(+)
> >  create mode 100644 arch/arm64/kvm/hyp/include/nvhe/spinlock.h
> > 
> > diff --git a/arch/arm64/kvm/hyp/include/nvhe/spinlock.h b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
> > new file mode 100644
> > index 000000000000..7584c397bbac
> > --- /dev/null
> > +++ b/arch/arm64/kvm/hyp/include/nvhe/spinlock.h
> > @@ -0,0 +1,92 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * A stand-alone ticket spinlock implementation for use by the non-VHE
> > + * KVM hypervisor code running at EL2.
> > + *
> > + * Copyright (C) 2020 Google LLC
> > + * Author: Will Deacon <will@kernel.org>
> > + *
> > + * Heavily based on the implementation removed by c11090474d70 which was:
> > + * Copyright (C) 2012 ARM Ltd.
> > + */
> > +
> > +#ifndef __ARM64_KVM_NVHE_SPINLOCK_H__
> > +#define __ARM64_KVM_NVHE_SPINLOCK_H__
> > +
> > +#include <asm/alternative.h>
> > +#include <asm/lse.h>
> > +
> > +typedef union hyp_spinlock {
> > +	u32	__val;
> > +	struct {
> > +#ifdef __AARCH64EB__
> > +		u16 next, owner;
> > +#else
> > +		u16 owner, next;
> > +	};
> > +#endif
> 
> Looks like I put this #endif in the wrong place; probably needs to be a line
> higher.

Uh oh, missed that too. Fix now merged locally, thanks.

Quentin
