Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F47530F4A6
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236527AbhBDOLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbhBDOHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:07:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FB0C061786
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:07:11 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b3so3652464wrj.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SWIWwQW6c5y88ky/tGs9MVqHhJ06CmDpooCYplmMmBc=;
        b=swdDPht2Lmes3NRKcd0D09P2eSo7wqGrMvXBzwBahtocMqUz+PI3h7a1j4QF/1I+2F
         Napqaio3hbJU4FaWdTljFdT9GQEZLvRS2h15ZQnH6CgIIyoEuAd9oVuTryYOrk2mlzcF
         4u4NRnQWccLZ/rGyeMPPM5NktE919Q9ePn5TGIbNI2WNom9nuxz3/KZmQ/SufLbfB12S
         Ly/4MOavDtEIX0aX1Np/uAf71oetpRkIKsdgFrARq3vxM7pdDWGsc2uHbNUKLq/OTn0L
         VAjX7bCcdKx0mbm1Mkx8pXn7cC2YbWImcou37XatElDjg+3bt2sAFEy3U6T8ZFa/9vf9
         4mcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SWIWwQW6c5y88ky/tGs9MVqHhJ06CmDpooCYplmMmBc=;
        b=mvbw0NpdkSWxYVI1xmR0oa+k8WmKFeFTc9KhsBymGMwqdIBMdfrEZ4ynQXKl3hEeiM
         ltg369k88UdOrnOLys1DTd7jvHyq8OGAGMJ5Q9URwEYY8zhRo2wKx+ouEelffRl9PLSk
         veDijSbxP7ypSXHKwSR/0wGjKgyqAYMZdzfRmoBPqZoEHa2GLS6m4dXm9v+oK7OSQVm4
         kJPuhjazAGa8I7WMkSNKiCIGZ67JZdWwoUwvYK9rhX/TTudExXRnir70tYvr0lkM04E7
         PY2JvH7F8fNWspG4xlsQvOO6LhMk/hVBLI0/KRK7PjorMdBJN6ZUK1sX7gB0O3UmA5Ry
         AZig==
X-Gm-Message-State: AOAM532mYhQipOBblSg5CuP8MMvAEEsA4tgQPjscFN7Uo2Guvx/b5JzH
        5E3kygPbPCN2wyYdWyKgZz704Q==
X-Google-Smtp-Source: ABdhPJwc/XtLGWIgPXmeIBHTVUramPSFwm7Rted+Qltv0unFuXU/mKs7ZFZVO+X5jCKlbBWoiTTkVw==
X-Received: by 2002:a5d:49cf:: with SMTP id t15mr9407446wrs.217.1612447630175;
        Thu, 04 Feb 2021 06:07:10 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id b19sm6002248wmj.22.2021.02.04.06.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 06:07:08 -0800 (PST)
Date:   Thu, 4 Feb 2021 14:07:04 +0000
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
Subject: Re: [RFC PATCH v2 21/26] KVM: arm64: Refactor kvm_arm_setup_stage2()
Message-ID: <YBv/iEl/Bjlte+yq@google.com>
References: <20210108121524.656872-1-qperret@google.com>
 <20210108121524.656872-22-qperret@google.com>
 <20210203155354.GE18974@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203155354.GE18974@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 Feb 2021 at 15:53:54 (+0000), Will Deacon wrote:
> On Fri, Jan 08, 2021 at 12:15:19PM +0000, Quentin Perret wrote:
> > In order to re-use some of the stage 2 setup at EL2, factor parts of
> > kvm_arm_setup_stage2() out into static inline functions.
> > 
> > No functional change intended.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/include/asm/kvm_mmu.h | 48 ++++++++++++++++++++++++++++++++
> >  arch/arm64/kvm/reset.c           | 42 +++-------------------------
> >  2 files changed, 52 insertions(+), 38 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> > index 662f0415344e..83b4c5cf4768 100644
> > --- a/arch/arm64/include/asm/kvm_mmu.h
> > +++ b/arch/arm64/include/asm/kvm_mmu.h
> > @@ -280,6 +280,54 @@ static inline int kvm_write_guest_lock(struct kvm *kvm, gpa_t gpa,
> >  	return ret;
> >  }
> >  
> > +static inline u64 kvm_get_parange(u64 mmfr0)
> > +{
> > +	u64 parange = cpuid_feature_extract_unsigned_field(mmfr0,
> > +				ID_AA64MMFR0_PARANGE_SHIFT);
> > +	if (parange > ID_AA64MMFR0_PARANGE_MAX)
> > +		parange = ID_AA64MMFR0_PARANGE_MAX;
> > +
> > +	return parange;
> > +}
> > +
> > +/*
> > + * The VTCR value is common across all the physical CPUs on the system.
> > + * We use system wide sanitised values to fill in different fields,
> > + * except for Hardware Management of Access Flags. HA Flag is set
> > + * unconditionally on all CPUs, as it is safe to run with or without
> > + * the feature and the bit is RES0 on CPUs that don't support it.
> > + */
> > +static inline u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
> > +{
> > +	u64 vtcr = VTCR_EL2_FLAGS;
> > +	u8 lvls;
> > +
> > +	vtcr |= kvm_get_parange(mmfr0) << VTCR_EL2_PS_SHIFT;
> > +	vtcr |= VTCR_EL2_T0SZ(phys_shift);
> > +	/*
> > +	 * Use a minimum 2 level page table to prevent splitting
> > +	 * host PMD huge pages at stage2.
> > +	 */
> > +	lvls = stage2_pgtable_levels(phys_shift);
> > +	if (lvls < 2)
> > +		lvls = 2;
> > +	vtcr |= VTCR_EL2_LVLS_TO_SL0(lvls);
> > +
> > +	/*
> > +	 * Enable the Hardware Access Flag management, unconditionally
> > +	 * on all CPUs. The features is RES0 on CPUs without the support
> > +	 * and must be ignored by the CPUs.
> > +	 */
> > +	vtcr |= VTCR_EL2_HA;
> > +
> > +	/* Set the vmid bits */
> > +	vtcr |= (get_vmid_bits(mmfr1) == 16) ?
> > +		VTCR_EL2_VS_16BIT :
> > +		VTCR_EL2_VS_8BIT;
> > +
> > +	return vtcr;
> > +}
> 
> Although I think this is functionally fine, I think it's unusual to see
> large "static inline" functions like this in shared header files. One
> alternative approach would be to follow the example of
> kernel/locking/qspinlock_paravirt.h, where the header is guarded in such a
> way that is only ever included by kernel/locking/qspinlock.c and therefore
> doesn't need the "inline" at all. That separation really helps, I think.

Alternatively, I might be able to have an mmu.c file in the hyp/ folder,
and to compile it for both the host kernel and the EL2 obj as we do for
a few things already. Or maybe I'll just stick it in pgtable.c. Either
way, it'll add a function call, but I can't really see that having any
measurable impact, so we should be fine.

Cheers,
Quentin
