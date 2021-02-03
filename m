Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E94D230D8C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhBCLf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:35:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44935 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234054AbhBCLf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612352070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aY4FCj6onHXTRBtwauq1YVo+dERgy4rWSjPCHajVOR0=;
        b=L7wIxNdA5wgElqA2TWdABWP7YSEiNbe+gFnNq5MPv9noATCBBDyF+xU2wIJMKQb4M8ODNB
        hiE+gpv6Vz1cObykK6Yymei1OKadx0gDfWlhGmwH+1PVqYJdrykcoY65u+Lktn+kChzo48
        n9b0XM85raDGbLWrTXjMMzvjig0iwPo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-cYxXqDIvMaG4Yun2G42lcw-1; Wed, 03 Feb 2021 06:34:28 -0500
X-MC-Unique: cYxXqDIvMaG4Yun2G42lcw-1
Received: by mail-ed1-f69.google.com with SMTP id u19so11281305edr.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 03:34:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aY4FCj6onHXTRBtwauq1YVo+dERgy4rWSjPCHajVOR0=;
        b=aDu0l6FaAa5QxMreD2LYGht8YsfjTGFUSuGFAyIw4/WcH9VcpBaRMMVrraeQwsPIH3
         5o5QviCnFt3b63gVHUG0jWVa5HzGwjSXWHEu4xiEwyN9EopgVc7364hEFVu4/EpMx/Ei
         tlNZNXqIns3Bwv4CG+LgYZnR9Bas4qQ/rYHV0SWFw9WooZVOz/NZ4VtlP2cJIsSlc0GV
         gw9KGjMozUKmNqe0Amcj0VVTxOjmnX7r7WLTNSZBI/+RDI28E8FxlzFXoRousGOSuu4A
         9o3wz/vBewGucE1cysXVhZTIx1z0qfM2ZRJEbyrwHSuWD5CyYhTvfEIbGqOqBhfuL+W4
         25sA==
X-Gm-Message-State: AOAM532Uyns1XrZ/k6Lwsv/SYMS88Wyxa9lBfoGBNlb0DBtfdINtnOfR
        GfceX+mOeRo1xrmY8tnW6j/Q+KFsn9hIbnjnkIN1rfEhBcpTXXH319CFPcn1WPb3Fk/B+/jH28o
        VRvd2guHtPLkyJ3RadvI5XYL2
X-Received: by 2002:a17:907:961b:: with SMTP id gb27mr2875830ejc.413.1612352067590;
        Wed, 03 Feb 2021 03:34:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxtuk33qXDYxD7m71ADWiWOjO6K8o5f5Mx1g0CwH8J7J7G4ioocLfFKINUGzJdyNGpQtfeZug==
X-Received: by 2002:a17:907:961b:: with SMTP id gb27mr2875801ejc.413.1612352067330;
        Wed, 03 Feb 2021 03:34:27 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f6sm741435edk.13.2021.02.03.03.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 03:34:26 -0800 (PST)
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20210202185734.1680553-1-bgardon@google.com>
 <20210202185734.1680553-26-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 25/28] KVM: x86/mmu: Allow zapping collapsible SPTEs to
 use MMU read lock
Message-ID: <e87d4a5d-f6ac-677a-87aa-0c30977c92f1@redhat.com>
Date:   Wed, 3 Feb 2021 12:34:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210202185734.1680553-26-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/21 19:57, Ben Gardon wrote:
> @@ -1485,7 +1489,9 @@ void kvm_tdp_mmu_zap_collapsible_sptes(struct kvm *kvm,
>  	struct kvm_mmu_page *root;
>  	int root_as_id;
>  
> -	for_each_tdp_mmu_root_yield_safe(kvm, root, false) {
> +	read_lock(&kvm->mmu_lock);
> +
> +	for_each_tdp_mmu_root_yield_safe(kvm, root, true) {
>  		root_as_id = kvm_mmu_page_as_id(root);
>  		if (root_as_id != slot->as_id)
>  			continue;
> @@ -1493,6 +1499,8 @@ void kvm_tdp_mmu_zap_collapsible_sptes(struct kvm *kvm,
>  		zap_collapsible_spte_range(kvm, root, slot->base_gfn,
>  					   slot->base_gfn + slot->npages);
>  	}
> +
> +	read_unlock(&kvm->mmu_lock);
>  }


I'd prefer the functions to be consistent about who takes the lock, 
either mmu.c or tdp_mmu.c.  Since everywhere else you're doing it in 
mmu.c, that would be:

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 0554d9c5c5d4..386ee4b703d9 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5567,10 +5567,13 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
  	write_lock(&kvm->mmu_lock);
  	slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
  			 kvm_mmu_zap_collapsible_spte, true);
+	write_unlock(&kvm->mmu_lock);

-	if (kvm->arch.tdp_mmu_enabled)
+	if (kvm->arch.tdp_mmu_enabled) {
+		read_lock(&kvm->mmu_lock);
  		kvm_tdp_mmu_zap_collapsible_sptes(kvm, memslot);
-	write_unlock(&kvm->mmu_lock);
+		read_unlock(&kvm->mmu_lock);
+	}
  }

  void kvm_arch_flush_remote_tlbs_memslot(struct kvm *kvm,

and just lockdep_assert_held_read here.

> -		tdp_mmu_set_spte(kvm, &iter, 0);
> -
> -		spte_set = true;

Is it correct to remove this assignment?

Paolo

