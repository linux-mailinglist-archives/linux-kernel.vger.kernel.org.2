Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A57DE32E49E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 10:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhCEJTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 04:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhCEJTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 04:19:01 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FFBC061574
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 01:19:00 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id k66so800549wmf.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 01:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8vJPV4FFwyt82QjbLhQn3+aWfcjT4u1dwj3bRwwYUZg=;
        b=nCBqUkSK4KKfw+b3O4dSAu30OZObhhK/hc1tmfr0QT3OO6SNikoNtfNIf4ImrZaBuw
         fOGpB6D3w5mu1Gp2MxOq3MgCDDGuwJ4sCyCvPaqVq0/Mr95qRW6kzhjE4JV2Ve+f0v5J
         R1yoy9l/FhsBx2wCqKFePLGMw8c82/N2GMro9PFvhk/1uLsiyorZZspXPxcK9ddNXO62
         XvuFtQ3byMIjjlpM7qT2JSuOPoxkzi+/bZQWjzWi3ks52l9wPzTV9ZqEliqraKdqbR14
         35v+2X0/aVQyqEfV5/UlTH2rUQpz7AL4/vw4r4DdG8ugNfROUrkY2vGE3LsGATptCuz7
         77Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8vJPV4FFwyt82QjbLhQn3+aWfcjT4u1dwj3bRwwYUZg=;
        b=ZR3NWJ3aaxubqU/iKCmVG/WN9Y9EpYYp2WK3IrikJuiJ6fHG/uA6yjcbnnt/qjgcDD
         /J/bHQpmzUWD/05pvRaXuVd9tiWCwaJBYsuoQuxbOMyDq+AEUJsRsA0iK6qn/KsZspPs
         X3m8A69K78lvqrHLgBjeFCJZtlPeGBY5irs75yb8oui6w5Yo7or+Db6DCvDL7q9DaDgi
         +YT2H6z531ovID1RkSRRZ7L7R++ipmfrgaWTiTt9TuydERihNWmjpV1b8/h+xFQApWkz
         T/irXdw9nk3HMJxTkkKgKdkvpFB2IsOQJE6d12ozEH1tH/GWxOLPjAeoewjmuhpPM/BU
         epNA==
X-Gm-Message-State: AOAM532+/W32DNWjrz5LJstRY6EAbG7EVWn5EeHxFUIv2s8vFDXZyV9Z
        57SFS0n6huXAPUC5D4NNDARbiA==
X-Google-Smtp-Source: ABdhPJwrDZdyUEX/CX8cn+VF0ajEbirzA9wYgQWCTVvm8e666ZxT2NbDPANZG6FBAnU7u4fM8Tdvcw==
X-Received: by 2002:a1c:2155:: with SMTP id h82mr8014110wmh.169.1614935939487;
        Fri, 05 Mar 2021 01:18:59 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id k11sm3545806wmj.1.2021.03.05.01.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 01:18:59 -0800 (PST)
Date:   Fri, 5 Mar 2021 09:18:56 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v3 27/32] KVM: arm64: Refactor stage2_map_set_prot_attr()
Message-ID: <YEH3gKYY/Rz7W+50@google.com>
References: <20210302150002.3685113-1-qperret@google.com>
 <20210302150002.3685113-28-qperret@google.com>
 <20210304200335.GG21950@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210304200335.GG21950@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 Mar 2021 at 20:03:36 (+0000), Will Deacon wrote:
> On Tue, Mar 02, 2021 at 02:59:57PM +0000, Quentin Perret wrote:
> > In order to ease its re-use in other code paths, refactor
> > stage2_map_set_prot_attr() to not depend on a stage2_map_data struct.
> > No functional change intended.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/pgtable.c | 19 ++++++++-----------
> >  1 file changed, 8 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index 8e7059fcfd40..8aa01a9e2603 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -494,8 +494,7 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
> >  	return vtcr;
> >  }
> >  
> > -static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
> > -				    struct stage2_map_data *data)
> > +static kvm_pte_t stage2_get_prot_attr(enum kvm_pgtable_prot prot)
> >  {
> >  	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
> >  	kvm_pte_t attr = device ? PAGE_S2_MEMATTR(DEVICE_nGnRE) :
> > @@ -504,15 +503,15 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
> >  
> >  	if (prot & KVM_PGTABLE_PROT_NONE) {
> >  		if (prot != KVM_PGTABLE_PROT_NONE)
> > -			return -EINVAL;
> > +			return 0;
> 
> Hmm, does the architecture actually say that having all these attributes
> as 0 is illegal?

Hmm, that's a good point, that might not be the case. I assumed we would
have no use for this, but there we can easily avoid the restriction
so...

> If not, I think it would be better to keep the int return
> code and replace the 'data' parameter with a pointer to a kvm_pte_t.
> 
> Does that work?

I think so yes, I'll fix it up.

Cheers,
Quentin
