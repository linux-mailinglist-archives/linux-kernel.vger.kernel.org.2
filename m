Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5943BA0E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 20:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238445AbhJZTCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 15:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbhJZTB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 15:01:59 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0383DC061745
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:59:35 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 75so460593pga.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OUtXKDfwROclVXg7NlW3DIt7U+eqIXthvFR6buHyDoA=;
        b=bKPpbTCz4hlYFag9BhzbxFL3ekENWVmE7zokGDd2k+Bo4Q38U8Or35HwBIpB9F89e9
         181GFN9dwIvggOsFfzXmTZg4yQWx1lx91aFJgp78u9ppApKuNIB2HrMwAIAoddskgqDJ
         hDiKRc+irPYtJsymjex1SQ2bXQcndBDoWI4JAQQdTZjhzD2iW8zvsGSNBe0pXzndOQ1w
         Q1V/TclRhOVCM1hPYhUma3XsRO/TnRQXoA1G3auvEno9wwMAkqk1e9Al08MISdnWl794
         1w26Qcm8lEwIJD1i4CCohyBUfuEBIVxYIujnAzVPBENCE+dm+Bq1g8pRAhtU7fpu/J2t
         bNDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OUtXKDfwROclVXg7NlW3DIt7U+eqIXthvFR6buHyDoA=;
        b=hPQEiq5Z5cFqsiLOtQSRMxBeV4EKXc4Ht2IYJ34XqFwzKRzFKBACmTUOUNVI1JIBr+
         vNaph+GztTkLdy7IgebQGLwSG79TaDvO40X34tzDZ8qIrFaWrtfriV9Cb0apGdRyJhpU
         tzBGjfQ672JvL4ADoc5HjKk4RrpH884zUVbUTw1KIB+9B6G3S3gp5l8T1N8CBPQsNmvM
         bXfYKMF0iEO4DHRpU7L0psxL6cWkH50AUtmcwV5070OxARFPNK6wU4PZ53eYXFJOfb3B
         0T86k+BR7JtBmEpojV/AqrWHHBiLhPch69dVbQyOnD7v/5NubgwrbMOPadImBK5vqcMT
         JQTQ==
X-Gm-Message-State: AOAM531tiJzkZrskt3nsUmCDv3XdzcOsH3lOb6kQB3j12RHc/YssWcxw
        j5cTbY4/mri/gFtDCNycEIgc4g==
X-Google-Smtp-Source: ABdhPJxLJpwgi7sPiQ7DQnadRmTST5jwmy/xByXWZOdZz6ymNKhOL/JPYHvGG2qyaYZkxyYGeuKNaw==
X-Received: by 2002:aa7:9197:0:b0:44d:a2e9:72cf with SMTP id x23-20020aa79197000000b0044da2e972cfmr27766363pfa.38.1635274774214;
        Tue, 26 Oct 2021 11:59:34 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id g37sm2634394pgg.89.2021.10.26.11.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 11:59:33 -0700 (PDT)
Date:   Tue, 26 Oct 2021 18:59:29 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 13/13] KVM: Optimize overlapping memslots check
Message-ID: <YXhQEeNxi2+fAQPM@google.com>
References: <cover.1632171478.git.maciej.szmigiero@oracle.com>
 <4f8718fc8da57ab799e95ef7c2060f8be0f2391f.1632171479.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f8718fc8da57ab799e95ef7c2060f8be0f2391f.1632171479.git.maciej.szmigiero@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Do a quick lookup for possibly overlapping gfns when creating or moving
> a memslot instead of performing a linear scan of the whole memslot set.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  virt/kvm/kvm_main.c | 36 +++++++++++++++++++++++++++---------
>  1 file changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 5fea467d6fec..78dad8c6376f 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1667,6 +1667,30 @@ static int kvm_delete_memslot(struct kvm *kvm,
>  	return kvm_set_memslot(kvm, mem, old, &new, as_id, KVM_MR_DELETE);
>  }
>  
> +static bool kvm_check_memslot_overlap(struct kvm_memslots *slots,
> +				      struct kvm_memory_slot *nslot)
> +{
> +	int idx = slots->node_idx;
> +	gfn_t nend = nslot->base_gfn + nslot->npages;
> +	struct rb_node *node;
> +
> +	kvm_for_each_memslot_in_gfn_range(node, slots, nslot->base_gfn, nend) {
> +		struct kvm_memory_slot *cslot;
> +		gfn_t cend;
> +
> +		cslot = container_of(node, struct kvm_memory_slot, gfn_node[idx]);
> +		cend = cslot->base_gfn + cslot->npages;
> +		if (cslot->id == nslot->id)
> +			continue;
> +
> +		/* kvm_for_each_in_gfn_no_more() guarantees that cslot->base_gfn < nend */
> +		if (cend > nslot->base_gfn)

Hmm, IMO the need for this check means that kvm_for_each_memslot_in_gfn_range()
is flawed.  The user of kvm_for_each...() should not be responsible for skipping
memslots that do not actually overlap the requested range.  I.e. this function
should be no more than:

static bool kvm_check_memslot_overlap(struct kvm_memslots *slots,
				      struct kvm_memory_slot *slot)
{
	gfn_t start = slot->base_gfn;
	gfn_t end = start + slot->npages;

	kvm_for_each_memslot_in_gfn_range(&iter, slots, start, end) {
		if (iter.slot->id != slot->id)
			return true;
	}

	return false;
}


and I suspect kvm_zap_gfn_range() could be further simplified as well.

Looking back at the introduction of the helper, its comment's highlighting of
"possibily" now makes sense.

  /* Iterate over each memslot *possibly* intersecting [start, end) range */
  #define kvm_for_each_memslot_in_gfn_range(node, slots, start, end)	\

That's an unnecessarily bad API.  It's a very solvable problem for the iterator
helpers to advance until there's actually overlap, not doing so violates the
principle of least surprise, and unless I'm missing something, there's no use
case for an "approximate" iteration.

> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /*
>   * Allocate some memory and give it an address in the guest physical address
>   * space.
> @@ -1752,16 +1776,10 @@ int __kvm_set_memory_region(struct kvm *kvm,
>  	}
>  
>  	if ((change == KVM_MR_CREATE) || (change == KVM_MR_MOVE)) {
> -		int bkt;
> -
>  		/* Check for overlaps */

This comment can be dropped, the new function is fairly self-documenting.

> -		kvm_for_each_memslot(tmp, bkt, __kvm_memslots(kvm, as_id)) {
> -			if (tmp->id == id)
> -				continue;
> -			if (!((new.base_gfn + new.npages <= tmp->base_gfn) ||
> -			      (new.base_gfn >= tmp->base_gfn + tmp->npages)))
> -				return -EEXIST;
> -		}
> +		if (kvm_check_memslot_overlap(__kvm_memslots(kvm, as_id),
> +					      &new))

And then with the comment dropped, the wrap can be avoided by folding the check
into the outer if statement, e.g.

	if (((change == KVM_MR_CREATE) || (change == KVM_MR_MOVE)) &&
	    kvm_check_memslot_overlap(__kvm_memslots(kvm, as_id), &new))
		return -EEXIST;

> +			return -EEXIST;
>  	}
>  
>  	/* Allocate/free page dirty bitmap as needed */
