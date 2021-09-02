Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C42573FF821
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 01:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345935AbhIBXzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 19:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbhIBXza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 19:55:30 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36079C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 16:54:31 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n18so2211004plp.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 16:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ALCe2Y9tD7D4EzHwRtzJyz3KblrehEB2Tj1eJEVNa2I=;
        b=F9uMSgxlOHs9ljrCqUQG+ZckVxyaKUVScP3Lrq20y/phQWhe3Kv9bYgSTv88cvhACu
         +n0Hf2A9XCNyX686+4h9dLrWtYisIBI/m30uAbic+xAQuN7/KGPBNi2QdhQRYdmJ4yZO
         gWQKfqhD91rw/33sbKXrvL9jYuwcXMO/EW6ghYTO3FplmXUvI7Xj9Q82ePSutrJLb/D0
         BYPEob89dHdCg/MAhhfFucZl3EAuJ/kM3jvAV5ZROd2JLFLPv8RTXGD+sl1CqX4CuyDm
         A0997Oo6cltrkryX0P4aj0DjHCwhEGY+fPUswWFzllhIyJ5Ygb5jfwhcNIDTxu/HK3Qt
         bDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ALCe2Y9tD7D4EzHwRtzJyz3KblrehEB2Tj1eJEVNa2I=;
        b=rZwfo1/f/cmiFyqqN3zPpIS72toUsq66w9uTd1RQtTL7RWs7D/ymVCzR+vxhHW5H33
         yhRAH3/c0GoiOS4jIT5wro/q3XWCLm3901qJyQ/f8K7sXzGeQmnPgfyvhZUUaKS3vB2k
         DKiyEUC+CoxoTBs3ipjQ1T/CZE9WuHeAy+VDHp4vg3KAxi/n8YEFVsaBnyw+a0FP6Alo
         IOvKr+0UbgFqag+V3sncbVQW1Bmh1v5FyfKFuSG4r3InG1pV4/z5aNEpHtmh4u1mIS/J
         UFuNOIqX1IEHb8uvDMvNTyHEoBsOsJlzqF0hcuhqZx8pZ/bY4qbQka1vLm0rxAwGt/aX
         pBUQ==
X-Gm-Message-State: AOAM532PdsOg/kQOUasehTkKqA0VYXVijEppxw1EwIUE6mPFiekMorct
        7B1vloU8Fn+OzoB+ZKdR3zy0Hw==
X-Google-Smtp-Source: ABdhPJyCLGhwa4xKFLXtfHZJ+MCgNXISiGHM4wK6jDNCZxqajozANwdIfdXxV24Pji2DFnP0OAXgGA==
X-Received: by 2002:a17:902:ed8b:b0:138:b1c7:f3ab with SMTP id e11-20020a170902ed8b00b00138b1c7f3abmr441629plj.77.1630626870371;
        Thu, 02 Sep 2021 16:54:30 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id r2sm3881988pgn.8.2021.09.02.16.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 16:54:29 -0700 (PDT)
Date:   Thu, 2 Sep 2021 23:54:26 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH 2/7] KVM: X86: Synchronize the shadow pagetable before
 link it
Message-ID: <YTFkMvdGug3uS2e4@google.com>
References: <20210824075524.3354-1-jiangshanlai@gmail.com>
 <20210824075524.3354-3-jiangshanlai@gmail.com>
 <YTFhCt87vzo4xDrc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTFhCt87vzo4xDrc@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021, Sean Christopherson wrote:
> On Tue, Aug 24, 2021, Lai Jiangshan wrote:
> Rather than force the sync here, what about kicking all vCPUs and retrying the
> page fault?  The only gross part is that kvm_mmu_get_page() can now fail :-(
> 
> ---
>  arch/x86/include/asm/kvm_host.h | 3 ++-
>  arch/x86/kvm/mmu/mmu.c          | 9 +++++++--
>  arch/x86/kvm/mmu/paging_tmpl.h  | 4 ++++
>  3 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 09b256db394a..332b9fb3454c 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -57,7 +57,8 @@
>  #define KVM_REQ_MIGRATE_TIMER		KVM_ARCH_REQ(0)
>  #define KVM_REQ_REPORT_TPR_ACCESS	KVM_ARCH_REQ(1)
>  #define KVM_REQ_TRIPLE_FAULT		KVM_ARCH_REQ(2)
> -#define KVM_REQ_MMU_SYNC		KVM_ARCH_REQ(3)
> +#define KVM_REQ_MMU_SYNC \
> +	KVM_ARCH_REQ_FLAGS(3, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>  #define KVM_REQ_CLOCK_UPDATE		KVM_ARCH_REQ(4)
>  #define KVM_REQ_LOAD_MMU_PGD		KVM_ARCH_REQ(5)
>  #define KVM_REQ_EVENT			KVM_ARCH_REQ(6)
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 4853c033e6ce..03293cd3c7ae 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2143,8 +2143,10 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>  			kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
>  		}
> 
> -		if (sp->unsync_children)
> -			kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
> +		if (sp->unsync_children) {
> +			kvm_make_all_cpus_request(KVM_REQ_MMU_SYNC, vcpu);
> +			return NULL;
> +		}
> 
>  		__clear_sp_write_flooding_count(sp);
> 
> @@ -2999,6 +3001,7 @@ static int __direct_map(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
> 
>  		sp = kvm_mmu_get_page(vcpu, base_gfn, it.addr,
>  				      it.level - 1, true, ACC_ALL);
> +		BUG_ON(!sp);
> 
>  		link_shadow_page(vcpu, it.sptep, sp);
>  		if (fault->is_tdp && fault->huge_page_disallowed &&
> @@ -3383,6 +3386,8 @@ static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, gva_t gva,
>  	struct kvm_mmu_page *sp;
> 
>  	sp = kvm_mmu_get_page(vcpu, gfn, gva, level, direct, ACC_ALL);
> +	BUG_ON(!sp);

Gah, this is obviously wrong when allocating an indirect root.  On the happy side,
it points out a cleaner approach.  I think this is what we want?

---
 arch/x86/kvm/mmu/mmu.c         | 3 ---
 arch/x86/kvm/mmu/paging_tmpl.h | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4853c033e6ce..f24e8088192c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2143,9 +2143,6 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 			kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 		}

-		if (sp->unsync_children)
-			kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
-
 		__clear_sp_write_flooding_count(sp);

 trace_get_page:
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 50ade6450ace..5b13918a55c2 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -704,6 +704,10 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault,
 			access = gw->pt_access[it.level - 2];
 			sp = kvm_mmu_get_page(vcpu, table_gfn, fault->addr,
 					      it.level-1, false, access);
+			if (sp->unsync_children) {
+				kvm_make_all_cpus_request(KVM_REQ_MMU_SYNC, vcpu);
+				return RET_PF_RETRY;
+			}
 		}

 		/*
--
