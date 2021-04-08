Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1497E3588D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 17:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbhDHPst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 11:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhDHPsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 11:48:46 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A54A0C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 08:48:33 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id ot17-20020a17090b3b51b0290109c9ac3c34so3414172pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 08:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BGPQ5W0R+cd+6n67AaZ3In8boiJNYVfmrkdkWy36GTc=;
        b=qQN04vSWUu3zbQTJ//w5DARl2EiJ3BTTuJfuWYba3RZ+cRE4ITkF8oaOyCp9JfvuQJ
         gCJ+p54nCRCI0nlBuVacUp1w4NIqSi1KOJKbxx/7T55igzHrtwLEWUQ/lCDpEmbm1IDr
         O61Ghjt7hZx2UTo+Hztx0/vfFY0/Ci4/DM3O0GpLtZq49ts1oB4hwGk6g4nilhhCCs/R
         iS34r0FFxLQ0BR2R4msI4FSaAOeteXimZ/YT4BM6J8k/l567acpVt41xjZu1W4uWAhz+
         mp/DqP1+gBvH7Swcw9pot/JE3QGQ//niKQVVFPLRXqi9FMGRmTsD9MruMJoWPYTU9IaV
         2ruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BGPQ5W0R+cd+6n67AaZ3In8boiJNYVfmrkdkWy36GTc=;
        b=QWjKHb+WJg/0fhOV23CdkxfQFRX83iiGCHVyN4pJmtNOuR58dUDWlQjPlxHW92q9VZ
         WUOwXIK4Bn4ivCe+N7IjjXnk8kmL1z3fXZf0XnZux35GsuDgfLxVAyM2Ruj1K8R+WsJc
         HwI4q6cIkaGIy9jq4XyZbxqDIWWBujc9WXDPxsIlwtxnRvo7yb8eZ43ugj8DZsKJp3uL
         5vd0m8K7kdawIn3LAQjqoFMzuXLysSq6lotmw68AQEAQIB6JR+cN0/XHMUvd4AA6dj/I
         SLK4XevbilK/qAwVAtfbd5KRzgZL2uIw/w7hfNbRsSNnIYH13XckKNJNdsLfFArNhrqE
         b9yA==
X-Gm-Message-State: AOAM531sUfg1qXfLA2T/cSHAli4xc1DNpLBJzlZp+xJtzvcB3z8VLVWK
        y1u6sHzUvOWaO6Dvas5mCDzu4g==
X-Google-Smtp-Source: ABdhPJyrt/tPFhwrp2sE3CnrCVPG45zod+fCK3daJozlJMqifLXhq4R6dxdZOQmnDyVQvTc4mD4JMg==
X-Received: by 2002:a17:902:ed84:b029:e7:1f2b:1eb4 with SMTP id e4-20020a170902ed84b02900e71f2b1eb4mr8496161plj.74.1617896913040;
        Thu, 08 Apr 2021 08:48:33 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id w75sm5954041pfc.135.2021.04.08.08.48.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 08:48:32 -0700 (PDT)
Date:   Thu, 8 Apr 2021 15:48:28 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v2 07/17] KVM: x86/mmu: Check PDPTRs before allocating
 PAE roots
Message-ID: <YG8lzKqL32+JhY0Z@google.com>
References: <20210305011101.3597423-1-seanjc@google.com>
 <20210305011101.3597423-8-seanjc@google.com>
 <CANRm+CzUAzR+D3BtkYpe71sHf_nmtm_Qmh4neqc=US2ETauqyQ@mail.gmail.com>
 <f6ae3dbb-cfa5-4d8b-26bf-92db6fc9eab1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6ae3dbb-cfa5-4d8b-26bf-92db6fc9eab1@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021, Paolo Bonzini wrote:
> On 08/04/21 13:15, Wanpeng Li wrote:
> > I saw this splatting:
> > 
> >   BUG: sleeping function called from invalid context at
> > arch/x86/kvm/kvm_cache_regs.h:115
> >    kvm_pdptr_read+0x20/0x60 [kvm]
> >    kvm_mmu_load+0x3bd/0x540 [kvm]
> > 
> > There is a might_sleep() in kvm_pdptr_read(), however, the original
> > commit didn't explain more. I can send a formal one if the below fix
> > is acceptable.

We don't want to drop mmu_lock, even temporarily.  The reason for holding it
across the entire sequence is to ensure kvm_mmu_available_pages() isn't violated.

> I think we can just push make_mmu_pages_available down into
> kvm_mmu_load's callees.  This way it's not necessary to hold the lock
> until after the PDPTR check:

...

> @@ -4852,14 +4868,10 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
>  	r = mmu_alloc_special_roots(vcpu);
>  	if (r)
>  		goto out;
> -	write_lock(&vcpu->kvm->mmu_lock);
> -	if (make_mmu_pages_available(vcpu))
> -		r = -ENOSPC;
> -	else if (vcpu->arch.mmu->direct_map)
> +	if (vcpu->arch.mmu->direct_map)
>  		r = mmu_alloc_direct_roots(vcpu);
>  	else
>  		r = mmu_alloc_shadow_roots(vcpu);
> -	write_unlock(&vcpu->kvm->mmu_lock);
>  	if (r)
>  		goto out;

Freaking PDPTRs.  I was really hoping we could keep the lock and pages_available()
logic outside of the helpers.  What if kvm_mmu_load() reads the PDPTRs and
passes them into mmu_alloc_shadow_roots()?  Or is that too ugly?

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index efb41f31e80a..e3c4938cd665 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3275,11 +3275,11 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
        return 0;
 }

-static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
+static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu, u64 pdptrs[4])
 {
        struct kvm_mmu *mmu = vcpu->arch.mmu;
-       u64 pdptrs[4], pm_mask;
        gfn_t root_gfn, root_pgd;
+       u64 pm_mask;
        hpa_t root;
        int i;

@@ -3291,11 +3291,8 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)

        if (mmu->root_level == PT32E_ROOT_LEVEL) {
                for (i = 0; i < 4; ++i) {
-                       pdptrs[i] = mmu->get_pdptr(vcpu, i);
-                       if (!(pdptrs[i] & PT_PRESENT_MASK))
-                               continue;
-
-                       if (mmu_check_root(vcpu, pdptrs[i] >> PAGE_SHIFT))
+                       if ((pdptrs[i] & PT_PRESENT_MASK) &&
+                           mmu_check_root(vcpu, pdptrs[i] >> PAGE_SHIFT))
                                return 1;
                }
        }
@@ -4844,21 +4841,33 @@ EXPORT_SYMBOL_GPL(kvm_mmu_reset_context);

 int kvm_mmu_load(struct kvm_vcpu *vcpu)
 {
-       int r;
+       struct kvm_mmu *mmu = vcpu->arch.mmu;
+       u64 pdptrs[4];
+       int r, i;

-       r = mmu_topup_memory_caches(vcpu, !vcpu->arch.mmu->direct_map);
+       r = mmu_topup_memory_caches(vcpu, !mmu->direct_map);
        if (r)
                goto out;
        r = mmu_alloc_special_roots(vcpu);
        if (r)
                goto out;
+
+       /*
+        * On SVM, reading PDPTRs might access guest memory, which might fault
+        * and thus might sleep.  Grab the PDPTRs before acquiring mmu_lock.
+        */
+       if (!mmu->direct_map && mmu->root_level == PT32E_ROOT_LEVEL) {
+               for (i = 0; i < 4; ++i)
+                       pdptrs[i] = mmu->get_pdptr(vcpu, i);
+       }
+
        write_lock(&vcpu->kvm->mmu_lock);
        if (make_mmu_pages_available(vcpu))
                r = -ENOSPC;
        else if (vcpu->arch.mmu->direct_map)
                r = mmu_alloc_direct_roots(vcpu);
        else
-               r = mmu_alloc_shadow_roots(vcpu);
+               r = mmu_alloc_shadow_roots(vcpu, pdptrs);
        write_unlock(&vcpu->kvm->mmu_lock);
        if (r)
                goto out;
