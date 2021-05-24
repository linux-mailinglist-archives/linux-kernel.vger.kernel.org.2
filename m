Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E2438E663
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 14:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbhEXMOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 08:14:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:56462 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232734AbhEXMOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 08:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621858382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MCm7qit8ZYLShiRct9tpllpW2huWEfdYgkF33c711U=;
        b=TOkyKJ3M1prwA9FFe8GCtnO3IfoLZCEW/VQFFhFVgwuFIDYNZN2AVFYCQnE0vWFeviIYI0
        Vew6lugqxUQhKj97i2YvbUkN5BnWhA3qTBhvTZhvcZXasE8Ggpn5/GFNPqUwLiZtfm4V8g
        WTUG2xen5tkkUCZ1lWhG+rz5irSaH1E=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-im-3tOsFNmua9lQ_ZihXLw-1; Mon, 24 May 2021 08:13:01 -0400
X-MC-Unique: im-3tOsFNmua9lQ_ZihXLw-1
Received: by mail-ed1-f69.google.com with SMTP id da10-20020a056402176ab029038f0fea1f51so7272195edb.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 05:13:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2MCm7qit8ZYLShiRct9tpllpW2huWEfdYgkF33c711U=;
        b=ieK6QSBRwa4qR12TTd9a0bx1+srCx+mpN40O+y+O8q35965mGcU3MUzg8WcThy0SB/
         3c0FM1D47NprysjyG3xPZ/8PmvAxAVGobLXKsFBmPpQot1/NwT4/zhUKDTjnNJWWWSFG
         SLR9PBxwgQmxDRxO3qeGlCXHFOrNhYMp4dJgtMcv/m8qbuoxpYfGaCDRU2M87o7UYRvH
         oEIlScQJnPT/OhGoxItO0YfWlzPUZAhvaSNsvhIjk6ToEQJ2MkF6dbKr1c5iK9Rkz4xY
         6KwZe4TEvAPssI6zB/nbHaYV2AUvNQQFlKSldFbuivocPX0JduEjpg53dpMWIlsYRgk1
         KyIg==
X-Gm-Message-State: AOAM530FOFX1/w9OnLUHHfNNFZ5whc1Z1F5aWgBXSbSkYKvwph+X4tih
        uljTIERBGG1zz4lOJWSboMYptc7kKYcMiIfaADI+fcjbf8W4C3okhkXL+rB59nol0M1thnvSsCN
        4UFRWxvjNKZBALvKLdgPCN8ni
X-Received: by 2002:a05:6402:1686:: with SMTP id a6mr25319772edv.123.1621858380014;
        Mon, 24 May 2021 05:13:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaQRCD3471EAwtjBrPBX9jqu40j0iyRCZazTEGTdNG/r3uQFJNUsgTC++PsfmRbLXHekG9sw==
X-Received: by 2002:a05:6402:1686:: with SMTP id a6mr25319754edv.123.1621858379827;
        Mon, 24 May 2021 05:12:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r17sm9137183edt.33.2021.05.24.05.12.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 May 2021 05:12:59 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] KVM: x86: Not wr-protect huge page with
 init_all_set dirty log
To:     Keqian Zhu <zhukeqian1@huawei.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Cc:     wanghaibin.wang@huawei.com
References: <20210429034115.35560-1-zhukeqian1@huawei.com>
 <20210429034115.35560-3-zhukeqian1@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <acc35587-1fbe-3101-d3cc-86327ebb5837@redhat.com>
Date:   Mon, 24 May 2021 14:12:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210429034115.35560-3-zhukeqian1@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/21 05:41, Keqian Zhu wrote:
> Currently during start dirty logging, if we're with init-all-set,
> we write protect huge pages and leave normal pages untouched, for
> that we can enable dirty logging for these pages lazily.
> 
> Actually enable dirty logging lazily for huge pages is feasible
> too, which not only reduces the time of start dirty logging, also
> greatly reduces side-effect on guest when there is high dirty rate.
> 
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>   arch/x86/kvm/mmu/mmu.c | 29 +++++++++++++++++++++++++----
>   arch/x86/kvm/x86.c     | 37 ++++++++++---------------------------
>   2 files changed, 35 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 2ce5bc2ea46d..f52c7ceafb72 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1188,8 +1188,7 @@ static bool __rmap_clear_dirty(struct kvm *kvm, struct kvm_rmap_head *rmap_head,
>    * @gfn_offset: start of the BITS_PER_LONG pages we care about
>    * @mask: indicates which pages we should protect
>    *
> - * Used when we do not need to care about huge page mappings: e.g. during dirty
> - * logging we do not have any such mappings.
> + * Used when we do not need to care about huge page mappings.
>    */
>   static void kvm_mmu_write_protect_pt_masked(struct kvm *kvm,
>   				     struct kvm_memory_slot *slot,
> @@ -1246,13 +1245,35 @@ static void kvm_mmu_clear_dirty_pt_masked(struct kvm *kvm,
>    * It calls kvm_mmu_write_protect_pt_masked to write protect selected pages to
>    * enable dirty logging for them.
>    *
> - * Used when we do not need to care about huge page mappings: e.g. during dirty
> - * logging we do not have any such mappings.
> + * We need to care about huge page mappings: e.g. during dirty logging we may
> + * have any such mappings.
>    */
>   void kvm_arch_mmu_enable_log_dirty_pt_masked(struct kvm *kvm,
>   				struct kvm_memory_slot *slot,
>   				gfn_t gfn_offset, unsigned long mask)
>   {
> +	/*
> +	 * Huge pages are NOT write protected when we start dirty log with
> +	 * init-all-set, so we must write protect them at here.
> +	 *
> +	 * The gfn_offset is guaranteed to be aligned to 64, but the base_gfn
> +	 * of memslot has no such restriction, so the range can cross two large
> +	 * pages.
> +	 */
> +	if (kvm_dirty_log_manual_protect_and_init_set(kvm)) {
> +		gfn_t start = slot->base_gfn + gfn_offset + __ffs(mask);
> +		gfn_t end = slot->base_gfn + gfn_offset + __fls(mask);
> +
> +		kvm_mmu_slot_gfn_write_protect(kvm, slot, start, PG_LEVEL_2M);
> +
> +		/* Cross two large pages? */
> +		if (ALIGN(start << PAGE_SHIFT, PMD_SIZE) !=
> +		    ALIGN(end << PAGE_SHIFT, PMD_SIZE))
> +			kvm_mmu_slot_gfn_write_protect(kvm, slot, end,
> +						       PG_LEVEL_2M);
> +	}
> +
> +	/* Then we can handle the PT level pages */
>   	if (kvm_x86_ops.cpu_dirty_log_size)
>   		kvm_mmu_clear_dirty_pt_masked(kvm, slot, gfn_offset, mask);
>   	else
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index eca63625aee4..dfd676ffa7da 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -10888,36 +10888,19 @@ static void kvm_mmu_slot_apply_flags(struct kvm *kvm,
>   		 */
>   		kvm_mmu_zap_collapsible_sptes(kvm, new);
>   	} else {
> -		/* By default, write-protect everything to log writes. */
> -		int level = PG_LEVEL_4K;
> +		/*
> +		 * If we're with initial-all-set, we don't need to write protect
> +		 * any page because they're reported as dirty already.
> +		 */
> +		if (kvm_dirty_log_manual_protect_and_init_set(kvm))
> +			return;
>   
>   		if (kvm_x86_ops.cpu_dirty_log_size) {
> -			/*
> -			 * Clear all dirty bits, unless pages are treated as
> -			 * dirty from the get-go.
> -			 */
> -			if (!kvm_dirty_log_manual_protect_and_init_set(kvm))
> -				kvm_mmu_slot_leaf_clear_dirty(kvm, new);
> -
> -			/*
> -			 * Write-protect large pages on write so that dirty
> -			 * logging happens at 4k granularity.  No need to
> -			 * write-protect small SPTEs since write accesses are
> -			 * logged by the CPU via dirty bits.
> -			 */
> -			level = PG_LEVEL_2M;
> -		} else if (kvm_dirty_log_manual_protect_and_init_set(kvm)) {
> -			/*
> -			 * If we're with initial-all-set, we don't need
> -			 * to write protect any small page because
> -			 * they're reported as dirty already.  However
> -			 * we still need to write-protect huge pages
> -			 * so that the page split can happen lazily on
> -			 * the first write to the huge page.
> -			 */
> -			level = PG_LEVEL_2M;
> +			kvm_mmu_slot_leaf_clear_dirty(kvm, new);
> +			kvm_mmu_slot_remove_write_access(kvm, new, PG_LEVEL_2M);
> +		} else {
> +			kvm_mmu_slot_remove_write_access(kvm, new, PG_LEVEL_4K);
>   		}
> -		kvm_mmu_slot_remove_write_access(kvm, new, level);
>   	}
>   }
>   
> 

Queued (with a few adjustments to the comments and commit messages), thanks.

Paolo

