Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97DC9311AC3
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 05:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhBFEQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 23:16:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhBFCpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:45:53 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E350C08EE29
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 16:29:17 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id my11so7338109pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 16:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T7sb6ncr5R6wfUcQGMveYp/z+yGX8ZVufAGOzAOyT3k=;
        b=h0gWg+Hg5xu/Yy2S6jOGQaWPkX14GYYxCS6NWxJLotd8KUKczFGhG2pqg8j1VPsYBa
         U4KDRQ6QNIp8g43R3aT/kUnYoTlFtBznbnf/dIDoi6Y0SXddsK9U0zJxh8kN8NoGWCLy
         R6JTP6LztRdG2yi+qfmXaU2q05fLTbH1jS0mVulEuLDv9+fJeRFwLUzQl6SIw/yM99u7
         +hNNWKXhaPrJMyny8FCmCJgDom/9buVKN/q0448RcasAh6d16ZNbLRB0uQpm6UjnMh+H
         lAojBuXgoL1qN7a/aoE+5U6N7xgMfovtrimShCPe1N8raoimErLrlKRBwSMJvp6VajJM
         QUug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T7sb6ncr5R6wfUcQGMveYp/z+yGX8ZVufAGOzAOyT3k=;
        b=GfziprzUQ3xgQ6aaQSfcO1MV9oGzuN4Gs7aNYqUbqgq5LQDRFeCetIytaqGsGA3QiJ
         82q8CpDSRIHkRbTLDJliXXnNmI618/xyb3foorgylskgouJm6q5HPsZoz7QYDB5u/CC8
         i2RhRgHjr2ID6yZz0K/bWNEvH6uYp++GjrcxorptKm3qAMnnmKuSSaCYSb/2ShZ+0c02
         S7PIXTyBjTFqCzraLWSYwxXkc0x3xPrDg+fSu83uUqQUG1zwuRRbDN9qb5VNh7rjb+a0
         Cl1S+w2u0ltbxrUMhq44joaLgBejtM76uyna5AJA26eR6mm0wMQCuvAMjoaWeDZoAalL
         wBHw==
X-Gm-Message-State: AOAM531iAWMfL8OZg2FJtV0eVieKSaFpln7qUKRQE2tm6QtcFEprykaR
        geDvdp480YgyhJalZMawM52ATw==
X-Google-Smtp-Source: ABdhPJw1OIcTGX649D2tHxeoNCRGC+hK7tKAtFvzxDG4DvBViD7hvDhdB3hwb06AxvnafUGuRcrmTA==
X-Received: by 2002:a17:902:fe09:b029:e1:6964:98dc with SMTP id g9-20020a170902fe09b02900e1696498dcmr6634863plj.24.1612571356921;
        Fri, 05 Feb 2021 16:29:16 -0800 (PST)
Received: from google.com ([2620:15c:f:10:d169:a9f7:513:e5])
        by smtp.gmail.com with ESMTPSA id o190sm11780244pgo.50.2021.02.05.16.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 16:29:16 -0800 (PST)
Date:   Fri, 5 Feb 2021 16:29:09 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
Subject: Re: [PATCH v2 21/28] KVM: x86/mmu: Flush TLBs after zap in TDP MMU
 PF handler
Message-ID: <YB3i1UXM/uIzHJuD@google.com>
References: <20210202185734.1680553-1-bgardon@google.com>
 <20210202185734.1680553-22-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202185734.1680553-22-bgardon@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021, Ben Gardon wrote:
> +static inline bool tdp_mmu_zap_spte_atomic(struct kvm *kvm,
> +					   struct tdp_iter *iter)
> +{
> +	/*
> +	 * Freeze the SPTE by setting it to a special,
> +	 * non-present value. This will stop other threads from
> +	 * immediately installing a present entry in its place
> +	 * before the TLBs are flushed.
> +	 */
> +	if (!tdp_mmu_set_spte_atomic(kvm, iter, REMOVED_SPTE))
> +		return false;
> +
> +	kvm_flush_remote_tlbs_with_address(kvm, iter->gfn,
> +					   KVM_PAGES_PER_HPAGE(iter->level));
> +
> +	/*
> +	 * No other thread can overwrite the removed SPTE as they
> +	 * must either wait on the MMU lock or use
> +	 * tdp_mmu_set_spte_atomic which will not overrite the
> +	 * special removed SPTE value. No bookkeeping is needed
> +	 * here since the SPTE is going from non-present
> +	 * to non-present.
> +	 */

Can we expand these comments out to 80 chars before the final/official push?

> +	WRITE_ONCE(*iter->sptep, 0);
> +
> +	return true;
> +}
> +
>  
>  /*
>   * __tdp_mmu_set_spte - Set a TDP MMU SPTE and handle the associated bookkeeping
> @@ -523,6 +562,15 @@ static inline void __tdp_mmu_set_spte(struct kvm *kvm, struct tdp_iter *iter,
>  
>  	lockdep_assert_held_write(&kvm->mmu_lock);
>  
> +	/*
> +	 * No thread should be using this function to set SPTEs to the
> +	 * temporary removed SPTE value.
> +	 * If operating under the MMU lock in read mode, tdp_mmu_set_spte_atomic
> +	 * should be used. If operating under the MMU lock in write mode, the
> +	 * use of the removed SPTE should not be necessary.
> +	 */
> +	WARN_ON(iter->old_spte == REMOVED_SPTE);
> +
>  	WRITE_ONCE(*rcu_dereference(iter->sptep), new_spte);
>  
>  	__handle_changed_spte(kvm, as_id, iter->gfn, iter->old_spte, new_spte,
> @@ -790,12 +838,9 @@ int kvm_tdp_mmu_map(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>  		 */
>  		if (is_shadow_present_pte(iter.old_spte) &&
>  		    is_large_pte(iter.old_spte)) {
> -			if (!tdp_mmu_set_spte_atomic(vcpu->kvm, &iter, 0))
> +			if (!tdp_mmu_zap_spte_atomic(vcpu->kvm, &iter))
>  				break;
>  
> -			kvm_flush_remote_tlbs_with_address(vcpu->kvm, iter.gfn,
> -					KVM_PAGES_PER_HPAGE(iter.level));
> -
>  			/*
>  			 * The iter must explicitly re-read the spte here
>  			 * because the new value informs the !present
> -- 
> 2.30.0.365.g02bc693789-goog
> 
