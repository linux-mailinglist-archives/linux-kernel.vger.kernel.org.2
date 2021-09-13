Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52BF74089CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 13:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239390AbhIMLD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 07:03:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37368 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239199AbhIMLDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 07:03:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631530958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UcaAmp2UV/j1fAZf2A/geXuqR6tfxn4XXi3wYCx67uQ=;
        b=Ks/ujoq6q4ivN5Thrg51HXQ0AIp+v0+cOqnwDpyOm7ycEwPsvtLlj4JoD3EL/h2fiODy68
        FCC9cV4r1vJAh3J8irSBlGgljRWKPiy6UIwx+c8deTPCMDzAXL3w7IRYXkFsRT5TJLgoXh
        QfujlFliwwkDqyjPsDf7M+SA+pv/U08=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-g2Usuf3lP1SLB6Ty05iDtw-1; Mon, 13 Sep 2021 07:02:37 -0400
X-MC-Unique: g2Usuf3lP1SLB6Ty05iDtw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 212F41015DA2;
        Mon, 13 Sep 2021 11:02:35 +0000 (UTC)
Received: from starship (unknown [10.35.206.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7BFD77F3C;
        Mon, 13 Sep 2021 11:02:29 +0000 (UTC)
Message-ID: <2f32727a108a626b71ab63b61cee567853ef2fdf.camel@redhat.com>
Subject: Re: [PATCH 5/7] KVM: X86: Don't unsync pagetables when speculative
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        kvm@vger.kernel.org
Date:   Mon, 13 Sep 2021 14:02:28 +0300
In-Reply-To: <20210824075524.3354-6-jiangshanlai@gmail.com>
References: <20210824075524.3354-1-jiangshanlai@gmail.com>
         <20210824075524.3354-6-jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-08-24 at 15:55 +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> We'd better only unsync the pagetable when there just was a really
> write fault on a level-1 pagetable.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/kvm/mmu/mmu.c          | 6 +++++-
>  arch/x86/kvm/mmu/mmu_internal.h | 3 ++-
>  arch/x86/kvm/mmu/spte.c         | 2 +-
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index a165eb8713bc..e5932af6f11c 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2600,7 +2600,8 @@ static void kvm_unsync_page(struct kvm_vcpu *vcpu, struct kvm_mmu_page *sp)
>   * were marked unsync (or if there is no shadow page), -EPERM if the SPTE must
>   * be write-protected.
>   */
> -int mmu_try_to_unsync_pages(struct kvm_vcpu *vcpu, gfn_t gfn, bool can_unsync)
> +int mmu_try_to_unsync_pages(struct kvm_vcpu *vcpu, gfn_t gfn, bool can_unsync,
> +			    bool speculative)
>  {
>  	struct kvm_mmu_page *sp;
>  	bool locked = false;
> @@ -2626,6 +2627,9 @@ int mmu_try_to_unsync_pages(struct kvm_vcpu *vcpu, gfn_t gfn, bool can_unsync)
>  		if (sp->unsync)
>  			continue;
>  
> +		if (speculative)
> +			return -EEXIST;

Woudn't it be better to ensure that callers set can_unsync = false when speculating?

Also if I understand correctly this is not fixing a bug, but an optimization?

Best regards,
	Maxim Levitsky


> +
>  		/*
>  		 * TDP MMU page faults require an additional spinlock as they
>  		 * run with mmu_lock held for read, not write, and the unsync
> diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
> index 658d8d228d43..f5d8be787993 100644
> --- a/arch/x86/kvm/mmu/mmu_internal.h
> +++ b/arch/x86/kvm/mmu/mmu_internal.h
> @@ -116,7 +116,8 @@ static inline bool kvm_vcpu_ad_need_write_protect(struct kvm_vcpu *vcpu)
>  	       kvm_x86_ops.cpu_dirty_log_size;
>  }
>  
> -int mmu_try_to_unsync_pages(struct kvm_vcpu *vcpu, gfn_t gfn, bool can_unsync);
> +int mmu_try_to_unsync_pages(struct kvm_vcpu *vcpu, gfn_t gfn, bool can_unsync,
> +			    bool speculative);
>  
>  void kvm_mmu_gfn_disallow_lpage(const struct kvm_memory_slot *slot, gfn_t gfn);
>  void kvm_mmu_gfn_allow_lpage(const struct kvm_memory_slot *slot, gfn_t gfn);
> diff --git a/arch/x86/kvm/mmu/spte.c b/arch/x86/kvm/mmu/spte.c
> index 3e97cdb13eb7..b68a580f3510 100644
> --- a/arch/x86/kvm/mmu/spte.c
> +++ b/arch/x86/kvm/mmu/spte.c
> @@ -159,7 +159,7 @@ int make_spte(struct kvm_vcpu *vcpu, unsigned int pte_access, int level,
>  		 * e.g. it's write-tracked (upper-level SPs) or has one or more
>  		 * shadow pages and unsync'ing pages is not allowed.
>  		 */
> -		if (mmu_try_to_unsync_pages(vcpu, gfn, can_unsync)) {
> +		if (mmu_try_to_unsync_pages(vcpu, gfn, can_unsync, speculative)) {
>  			pgprintk("%s: found shadow page for %llx, marking ro\n",
>  				 __func__, gfn);
>  			ret |= SET_SPTE_WRITE_PROTECTED_PT;


