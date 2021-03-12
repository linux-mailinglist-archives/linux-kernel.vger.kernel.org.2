Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C7E3384EB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 06:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhCLFKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 00:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbhCLFKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 00:10:14 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42EDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 21:10:13 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id g8so3028020wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 21:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8rin+aXdpiE+90osiPBBCiB/kzC/wvTFDlufzLkieLY=;
        b=RLh9oG+E0NRrQf3D4jDx/361FM3yrK1EmWOIlmVfSLVlQ+cwHf8/nT+4l2Ked5A0jn
         rPXhwUvZI8dZFd+C9S0oLI35nPymHdflaDiaKvMxBRzS9+7b2Rc7Wc0TED6EGeaxElzU
         fuJDo6skHJcy8k+l0WkEvRYlNZW0yzvWkTmFTXZfa7dNNDtB8cfNhHFYqIJSFnKEaE7S
         eknHTHSYo9aefxdnodvlaAGCvIGEq+///KeqOBK3+/RP8HIQ/8X78lRz7lcrdQpdBw3Z
         UvcHOPEkT27Cpm0ySKV+1Z2QjbVJOd/YCDYoKUme+3IM6dUGRZir3YPt/iSDmXGquFSR
         6D2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8rin+aXdpiE+90osiPBBCiB/kzC/wvTFDlufzLkieLY=;
        b=B9j8GskQOvfB6OAazyLTwj3XoGag9rw6+eFL7j+Eme8eKPWIIpDTMPZJuyxiORR0Xv
         2f0Vc2Mv5wSvZHSFrMuGQvkFjlA2XaCfRE8Rk5kHbCp5YRe1FUpvvAXgH50LGCayq0Qm
         eguiLU7atuiU4teQ/YoDkkUBIHR1cL8A1GTA/NHThaliEgv4mpi/imlM/Uqr7Rcmaj2N
         qVABTOYj6LWQtl3UcPwnNDzcP3Wmt3I7y5TydS4S6z796vEmibhS4hknVrdGOYVmsbkF
         X2CsZy7SUrpO643SQazyRNMoCywtOHAK38umTbG7QVuSppt64V8tR5kLWA7SS/FAkDRB
         9YVQ==
X-Gm-Message-State: AOAM531ChTocscyv6bbigjgHAB7A9Eco2T3vv4pbaPGfHp2Z5GZxFDrL
        zCTWe74Ta089HpIuknktHokFWg==
X-Google-Smtp-Source: ABdhPJyJGE0OAQ0hL9P4QLn56wDbAlpAsInbXKRuWm98JDjTcUCCOJER4MsvkY9zyWkTfWx2MDNxvw==
X-Received: by 2002:a1c:a985:: with SMTP id s127mr10952353wme.158.1615525812255;
        Thu, 11 Mar 2021 21:10:12 -0800 (PST)
Received: from google.com (230.69.233.35.bc.googleusercontent.com. [35.233.69.230])
        by smtp.gmail.com with ESMTPSA id d85sm871075wmd.15.2021.03.11.21.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Mar 2021 21:10:11 -0800 (PST)
Date:   Fri, 12 Mar 2021 05:10:09 +0000
From:   Quentin Perret <qperret@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, maz@kernel.org, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        android-kvm@google.com, linux-kernel@vger.kernel.org,
        kernel-team@android.com, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, tabba@google.com,
        mark.rutland@arm.com, dbrazdil@google.com, mate.toth-pal@arm.com,
        seanjc@google.com, robh+dt@kernel.org, ardb@kernel.org
Subject: Re: [PATCH v4 29/34] KVM: arm64: Refactor stage2_map_set_prot_attr()
Message-ID: <YEr3sa0U2NnXqGUP@google.com>
References: <20210310175751.3320106-1-qperret@google.com>
 <20210310175751.3320106-30-qperret@google.com>
 <20210311184836.GA31586@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311184836.GA31586@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 11 Mar 2021 at 18:48:36 (+0000), Will Deacon wrote:
> On Wed, Mar 10, 2021 at 05:57:46PM +0000, Quentin Perret wrote:
> > In order to ease its re-use in other code paths, refactor
> > stage2_map_set_prot_attr() to not depend on a stage2_map_data struct.
> > No functional change intended.
> > 
> > Signed-off-by: Quentin Perret <qperret@google.com>
> > ---
> >  arch/arm64/kvm/hyp/pgtable.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
> > index e4670b639726..c16e0306dd9a 100644
> > --- a/arch/arm64/kvm/hyp/pgtable.c
> > +++ b/arch/arm64/kvm/hyp/pgtable.c
> > @@ -489,8 +489,7 @@ u64 kvm_get_vtcr(u64 mmfr0, u64 mmfr1, u32 phys_shift)
> >  	return vtcr;
> >  }
> >  
> > -static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
> > -				    struct stage2_map_data *data)
> > +static int stage2_set_prot_attr(enum kvm_pgtable_prot prot, kvm_pte_t *ptep)
> >  {
> >  	bool device = prot & KVM_PGTABLE_PROT_DEVICE;
> >  	kvm_pte_t attr = device ? PAGE_S2_MEMATTR(DEVICE_nGnRE) :
> > @@ -510,7 +509,8 @@ static int stage2_map_set_prot_attr(enum kvm_pgtable_prot prot,
> >  
> >  	attr |= FIELD_PREP(KVM_PTE_LEAF_ATTR_LO_S2_SH, sh);
> >  	attr |= KVM_PTE_LEAF_ATTR_LO_S2_AF;
> > -	data->attr = attr;
> > +	*ptep = attr;
> > +
> >  	return 0;
> >  }
> >  
> > @@ -728,7 +728,7 @@ int kvm_pgtable_stage2_map(struct kvm_pgtable *pgt, u64 addr, u64 size,
> >  		.arg		= &map_data,
> >  	};
> >  
> > -	ret = stage2_map_set_prot_attr(prot, &map_data);
> > +	ret = stage2_set_prot_attr(prot, &map_data.attr);
> >  	if (ret)
> >  		return ret;
> 
> (nit: this is now different to hyp_map_set_prot_attr() -- can we do the same
> thing there, please?)

Will do.

Thanks,
Quentin
