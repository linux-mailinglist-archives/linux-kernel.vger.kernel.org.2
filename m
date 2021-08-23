Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7B13F4E0A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 18:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhHWQLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 12:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbhHWQLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 12:11:30 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF181C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 09:10:47 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q2so17080494pgt.6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jGmbzviqWn2myoss+SliOPWH/SHZgh+AI6V3Q1gvNEQ=;
        b=poFX8+XHFq4U93MQW5xHTCCSB5K6yHjAkYcOIEMEaz05LFviIgdN2cTvCL7jWDwuPg
         T4KGNybNYKrBtIrPiPExMuYTkA6wQTJ69QPwLWa/Ro6Lq6bTB7rpdSuWM9QA2Dwcwy6U
         6I3LvOGU4Id2dFpgA2OoUpKVX2FehCQBwloXsFPpww16YrBYFRLjyDBTTIKzevCk7+ao
         AB2SutlVEfQaeGnYq+octlQoaEacqYkcK5lLRY4xWf/jAEriX99zEpYNwApAf2/YUgb4
         i9nXbvSWuI1TdyLA/8zZa7aGX3O5Kr5YdE5n6OM7i+iPtbvGOrRFbVH1zs+Ons0o2je4
         lTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jGmbzviqWn2myoss+SliOPWH/SHZgh+AI6V3Q1gvNEQ=;
        b=dbqfxgdL5CQtQ50xjLzUVknNoz60PIqJNKykOKT0/6uEufm6/3yND/rEmPwZaVKc7L
         /tdo1GFU1yksMxzQIkeVjmoiM1dk0sROXoSiNI11wrAVWQv2hEh4YHnENmt8r75ARAXi
         Z+eLhU2eWu6W/8fZ5Ce8+0qh4xmlwr1Lj2OPv/BleUG3FLP3A2XFct4xxL3l1inUkbbK
         diOZ+n4+b3GDHUYpI4S6EGsYkK7RrgD9kDDkOg8xLFdT9W+VpXxiIVlYPRJMlmiiqpX1
         lq/C3JiOF+uSs4FwRBgWucj/iYjP3Wjv+sPLWIGU/XiHVL6jJYbMOmIF+EDjFYETFV7Q
         nhPA==
X-Gm-Message-State: AOAM533d7QNRx7R5ewsT/dhsDieepL5frfXL6xeloxEru3js9vRkMKOB
        DsKfU/419NDkKOEZxP38bdqJow==
X-Google-Smtp-Source: ABdhPJyDRLUb89nW6/5dHVbTOnk9DCBHnRskADapAc2hPSL0OVH0E1lm9WUfyoCTO5m63xIpaFSBGA==
X-Received: by 2002:aa7:90cd:0:b029:333:baa9:87b7 with SMTP id k13-20020aa790cd0000b0290333baa987b7mr34498040pfk.23.1629735047148;
        Mon, 23 Aug 2021 09:10:47 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s26sm18572118pgv.46.2021.08.23.09.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 09:10:46 -0700 (PDT)
Date:   Mon, 23 Aug 2021 16:10:40 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Wei Huang <wei.huang2@amd.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Subject: Re: [PATCH v3 0/3] SVM 5-level page table support
Message-ID: <YSPIgBNiMZkwAOSG@google.com>
References: <20210818165549.3771014-1-wei.huang2@amd.com>
 <46a54a13-b934-263a-9539-6c922ceb70d3@redhat.com>
 <c10faf24c11fc86074945ca535572a8c5926dcf9.camel@redhat.com>
 <20210823151549.rkkrktvtpu6yapmd@weiserver.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210823151549.rkkrktvtpu6yapmd@weiserver.amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021, Wei Huang wrote:
> On 08/23 12:20, Maxim Levitsky wrote:
> > This hack makes it work again for me (I don't yet use TDP mmu).
> > 
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index caa3f9aee7d1..c25e0d40a620 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -3562,7 +3562,7 @@ static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
> >             mmu->shadow_root_level < PT64_ROOT_4LEVEL)
> >                 return 0;
> >  
> > -       if (mmu->pae_root && mmu->pml4_root && mmu->pml5_root)

Maxim, I assume you hit this WARN and bail?

        if (WARN_ON_ONCE(!tdp_enabled || mmu->pae_root || mmu->pml4_root ||
                         mmu->pml5_root))
		return -EIO;

Because as the comment states, KVM expects all the special roots to be allocated
together.  The 5-level paging supported breaks that assumption because pml5_root
will be allocated iff the host is using 5-level paging.

        if (mmu->shadow_root_level > PT64_ROOT_4LEVEL) {
                pml5_root = (void *)get_zeroed_page(GFP_KERNEL_ACCOUNT);
                if (!pml5_root)
                        goto err_pml5;
        }

I think this is the least awful fix, I'll test and send a proper patch later today.

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4853c033e6ce..93b2ed422b48 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3548,6 +3548,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
 static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
 {
        struct kvm_mmu *mmu = vcpu->arch.mmu;
+       bool need_pml5 = mmu->shadow_root_level > PT64_ROOT_4LEVEL;
        u64 *pml5_root = NULL;
        u64 *pml4_root = NULL;
        u64 *pae_root;
@@ -3562,7 +3563,14 @@ static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
            mmu->shadow_root_level < PT64_ROOT_4LEVEL)
                return 0;

-       if (mmu->pae_root && mmu->pml4_root && mmu->pml5_root)
+       /*
+        * NPT, the only paging mode that uses this horror, uses a fixed number
+        * of levels for the shadow page tables, e.g. all MMUs are 4-level or
+        * all MMus are 5-level.  Thus, this can safely require that pml5_root
+        * is allocated if the other roots are valid and pml5 is needed, as any
+        * prior MMU would also have required pml5.
+        */
+       if (mmu->pae_root && mmu->pml4_root && (!need_pml5 || mmu->pml5_root))
                return 0;

        /*
@@ -3570,7 +3578,7 @@ static int mmu_alloc_special_roots(struct kvm_vcpu *vcpu)
         * bail if KVM ends up in a state where only one of the roots is valid.
         */
        if (WARN_ON_ONCE(!tdp_enabled || mmu->pae_root || mmu->pml4_root ||
-                        mmu->pml5_root))
+                        (need_pml5 && mmu->pml5_root)))
                return -EIO;

        /*

> > +       if (mmu->pae_root && mmu->pml4_root)
> >                 return 0;
> >  
> >         /*
> > 
> > 
> > 
> > Best regards,
> > 	Maxim Levitsky
> >
