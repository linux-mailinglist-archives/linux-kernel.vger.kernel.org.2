Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0304161F9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241980AbhIWPYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:24:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58481 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233143AbhIWPYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632410592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5/wCK9GszM66NyRIxpmO26QgTu1IQH9r5GdUI8WeU8=;
        b=Rl0D/LzPoeR95buKegZiz3bLCFiskljV8nkItEcUsLn1ITP9OpnAqqVh8AAuRN+5EIui+X
        iXHeqCNNuxNhxc4+NSpr68s0OruQA1yTi2xp/8YYigPIE1OQr29NbjtSIsFytNXooDH8m4
        DrP1SKa4yaNk8gPD5pXEDvzJfOcvkWc=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-r0GxFBn0Olil41g9LXhfSw-1; Thu, 23 Sep 2021 11:23:11 -0400
X-MC-Unique: r0GxFBn0Olil41g9LXhfSw-1
Received: by mail-ed1-f69.google.com with SMTP id r7-20020aa7c147000000b003d1f18329dcso7201611edp.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 08:23:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d5/wCK9GszM66NyRIxpmO26QgTu1IQH9r5GdUI8WeU8=;
        b=HDS6sRie/3fzY5Vp56KvQ0zPblOC9kQ5BDIuJ3SbVVgVZgl3YS+f7Ywba6Epz0Qykn
         oQmEwEo7uh37O+akosVnMuW9XwN+D0FSb5cASm8QxOaH499rcFVV9ZuVW6lbW7frFyec
         61xCww29RXVoR2UMkEtrDaqq8aU1pVzqVXMotZZOHCufumn+2J3SzKVw8MQQxT31jUqr
         jkOvTri/i2G97SPQM0MoW+UpGQ0i7PadSf1YF2I1RMchsfQNRrb5CSwQMCq4ewdlsSG5
         Tx7DGveR3lX0DyTQjmaBmDhmTnLRCN55jiveLki8IAR1s3mVQNMTTvemhRHgGm+Z88c7
         IjPg==
X-Gm-Message-State: AOAM530t4yLJql8D/KV0ViH3bBOBTUH6iAfzNF0ysO7IUQjfVilnfMFl
        wViMUplPxbktk0sucxqQVMohSv9eN5VaWolrHNKYJy4qg+pq626IDCKgYDhB5FJzU9JVlgMeU4x
        6deDG/tBwxDVgivi6qzHUvrWu
X-Received: by 2002:a05:6402:2908:: with SMTP id ee8mr6260015edb.33.1632410589470;
        Thu, 23 Sep 2021 08:23:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzDSEdE2T5kzt1HjSE8giRZeeqlHAAaF/qwd9m6UR/9UVNV+oh39zmx9cdvjGmKJDHkWhr4w==
X-Received: by 2002:a05:6402:2908:: with SMTP id ee8mr6259999edb.33.1632410589282;
        Thu, 23 Sep 2021 08:23:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id mm23sm3285150ejb.78.2021.09.23.08.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 08:23:08 -0700 (PDT)
Subject: Re: [PATCH V2 03/10] KVM: Remove tlbs_dirty
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>, kvm@vger.kernel.org
References: <20210918005636.3675-1-jiangshanlai@gmail.com>
 <20210918005636.3675-4-jiangshanlai@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8dfdae11-7c51-530d-5c0d-83f778fa1e14@redhat.com>
Date:   Thu, 23 Sep 2021 17:23:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210918005636.3675-4-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/09/21 02:56, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> There is no user of tlbs_dirty.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>   include/linux/kvm_host.h | 1 -
>   virt/kvm/kvm_main.c      | 9 +--------
>   2 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index e4d712e9f760..3b7846cd0637 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -608,7 +608,6 @@ struct kvm {
>   	unsigned long mmu_notifier_range_start;
>   	unsigned long mmu_notifier_range_end;
>   #endif
> -	long tlbs_dirty;
>   	struct list_head devices;
>   	u64 manual_dirty_log_protect;
>   	struct dentry *debugfs_dentry;
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 3e67c93ca403..6d6be42ec78d 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -312,12 +312,6 @@ EXPORT_SYMBOL_GPL(kvm_make_all_cpus_request);
>   #ifndef CONFIG_HAVE_KVM_ARCH_TLB_FLUSH_ALL
>   void kvm_flush_remote_tlbs(struct kvm *kvm)
>   {
> -	/*
> -	 * Read tlbs_dirty before setting KVM_REQ_TLB_FLUSH in
> -	 * kvm_make_all_cpus_request.
> -	 */
> -	long dirty_count = smp_load_acquire(&kvm->tlbs_dirty);
> -
>   	/*
>   	 * We want to publish modifications to the page tables before reading
>   	 * mode. Pairs with a memory barrier in arch-specific code.
> @@ -332,7 +326,6 @@ void kvm_flush_remote_tlbs(struct kvm *kvm)
>   	if (!kvm_arch_flush_remote_tlb(kvm)
>   	    || kvm_make_all_cpus_request(kvm, KVM_REQ_TLB_FLUSH))
>   		++kvm->stat.generic.remote_tlb_flush;
> -	cmpxchg(&kvm->tlbs_dirty, dirty_count, 0);
>   }
>   EXPORT_SYMBOL_GPL(kvm_flush_remote_tlbs);
>   #endif
> @@ -537,7 +530,7 @@ static __always_inline int __kvm_handle_hva_range(struct kvm *kvm,
>   		}
>   	}
>   
> -	if (range->flush_on_ret && (ret || kvm->tlbs_dirty))
> +	if (range->flush_on_ret && ret)
>   		kvm_flush_remote_tlbs(kvm);
>   
>   	if (locked)
> 

Queued up to here for 5.15, thanks!

Paolo

