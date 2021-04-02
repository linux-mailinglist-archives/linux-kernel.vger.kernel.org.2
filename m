Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327C535271B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 09:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbhDBHxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 03:53:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60754 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233521AbhDBHxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 03:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617349992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gtlzy39YQrbCMuQYvhfLP48+qlrC818fAyrVAMieLYQ=;
        b=ce0KNr4GswLnuPpeHRbqWL/NLpTkClhgx4WxKtQUG/oQ89xTwF5ybUifpqBrcKzO/qJgSu
        RXA3CwCMhMYodZAobvV0mh5ajIblRiTQPZnXV7Ga34HGWox+OhLe5A4CUvqTpX+LbvtDI1
        8O57l9YK43Jwb5UTXzpqNtwL40BR+X4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-3Kw4rabzMSeVxwRI_1vZ1g-1; Fri, 02 Apr 2021 03:53:11 -0400
X-MC-Unique: 3Kw4rabzMSeVxwRI_1vZ1g-1
Received: by mail-wr1-f71.google.com with SMTP id t14so4003784wrx.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 00:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gtlzy39YQrbCMuQYvhfLP48+qlrC818fAyrVAMieLYQ=;
        b=SqrAt59foMdUp56jh61mGE0YwxkKg5ivwzRkJFmczQ9mMTwDRrQ3WkN02yCotegVJF
         /izQ1oZf67uW/vaumAY5Qux9PtTy55WD8xFZPkThQmHkk0NVIPBz2GWjLRnhL+r6t6YV
         bCKtQyAkbswsR25kkHBpPqzFGPEYUyxBJbRe6dGwWM5b0zyhO+iIDpQWxESVbuTNfIBA
         KzAQ6ZEM3VehQ6IZIQCUPGhqztbNaVazWeWFIhD+yUpjWxDkH1vFLCZL9OzVdRoE+5Pz
         n1Js492C2HTPNIG/c28G3KwOYdv7t1N28oyQEPpXalneufugf2/Y+dQm7wu0wUt4SaWd
         Uc3A==
X-Gm-Message-State: AOAM5308YcoTzdHNTX570rCYeqjUPl4/p338xYYiisbhEcR/FR3f3YBN
        rN4v+Yo1wfp4C4Iyl2urhmfJPb7h7Y8BShx9YrNq8Z56vjwWdUKzULxM+4fSVJosdin0pI+7H2n
        VbeFnSQXWndbLzd9HYekkg6Sy
X-Received: by 2002:a5d:4905:: with SMTP id x5mr13819205wrq.201.1617349990154;
        Fri, 02 Apr 2021 00:53:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKsVTbe00EAM6Tl2WO4eTIgLUD1AUXdrIgvm8mmZyB3vvOZpWnzr9nDa6kSpWjOBIimoZwuw==
X-Received: by 2002:a5d:4905:: with SMTP id x5mr13819188wrq.201.1617349990009;
        Fri, 02 Apr 2021 00:53:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id v3sm11584184wmj.25.2021.04.02.00.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 00:53:09 -0700 (PDT)
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
References: <20210401233736.638171-1-bgardon@google.com>
 <20210401233736.638171-10-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 09/13] KVM: x86/mmu: Allow zap gfn range to operate
 under the mmu read lock
Message-ID: <4fc5960f-0b64-1cf5-d2c1-080d82d226a0@redhat.com>
Date:   Fri, 2 Apr 2021 09:53:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210401233736.638171-10-bgardon@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/21 01:37, Ben Gardon wrote:
> +void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root,
> +			  bool shared)
>   {
>   	gfn_t max_gfn = 1ULL << (shadow_phys_bits - PAGE_SHIFT);
>   
> -	lockdep_assert_held_write(&kvm->mmu_lock);
> +	kvm_lockdep_assert_mmu_lock_held(kvm, shared);
>   
>   	if (!refcount_dec_and_test(&root->tdp_mmu_root_count))
>   		return;
> @@ -81,7 +92,7 @@ void kvm_tdp_mmu_put_root(struct kvm *kvm, struct kvm_mmu_page *root)
>   	list_del_rcu(&root->link);
>   	spin_unlock(&kvm->arch.tdp_mmu_pages_lock);
>   
> -	zap_gfn_range(kvm, root, 0, max_gfn, false, false);
> +	zap_gfn_range(kvm, root, 0, max_gfn, false, false, shared);
>   
>   	call_rcu(&root->rcu_head, tdp_mmu_free_sp_rcu_callback);

Instead of patch 13, would it make sense to delay the zap_gfn_range and 
call_rcu to a work item (either unconditionally, or only if 
shared==false)?  Then the zap_gfn_range would be able to yield and take 
the mmu_lock for read, similar to kvm_tdp_mmu_zap_invalidated_roots.

If done unconditionally, this would also allow removing the "shared" 
argument to kvm_tdp_mmu_put_root, tdp_mmu_next_root and 
for_each_tdp_mmu_root_yield_safe, so I would place that change before 
this patch.

Paolo

