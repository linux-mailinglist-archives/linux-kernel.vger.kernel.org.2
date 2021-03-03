Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C79332C1AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387370AbhCCTYA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 14:24:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26148 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350093AbhCCTFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 14:05:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614798216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UoLMKstBrKdSmL1aXA1VyV0RNHRz4sF2B9MnCUrQmn0=;
        b=caJTaH9jJR9HW0Hez6Cd8sQ4tlv8qihyigkP/4GGQlv6y6830jZi+AbFKrGmqI5MOKOvcR
        echxg0uEQf48ZyY9KlbwXikBRflM3w47yNHrjvZNslvKzQgini0BP9ICC6kDia75f9lzkb
        PYcu+5Ggjyx7LbG8rmMCy0Ql1tnXdEE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-vbJUZrwnNx6cfN5eVsHKyw-1; Wed, 03 Mar 2021 14:03:35 -0500
X-MC-Unique: vbJUZrwnNx6cfN5eVsHKyw-1
Received: by mail-qt1-f200.google.com with SMTP id k10so15612834qte.17
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 11:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UoLMKstBrKdSmL1aXA1VyV0RNHRz4sF2B9MnCUrQmn0=;
        b=jBRF7K9CLF3gaZgqSyw3aFi7Rhm5xUVcHPlhMp6upyu5xxjZMLbvnGU284zcfhcqo3
         bZ8qgmGh/1z262R72l6G4GHcKAyw3Rit38eCk84XJMYsUWLMCqalFpF1OFdqdnGiI/qI
         M+rPb1SQ6t0xKood/JHo3TUjGhHfILtZ05qsDtPWUt8Bq/D9MSqEzAjKK5D34vEDblE7
         9Jz+uuISVYCfpQRoInDSoEM/2ZTOZ9PAOopusiwxrXTeFv3/VuwlKNk8/mzGU670CZww
         F7oYHfKgLq81mtSyRUSX7vz3aW39WKEauzNvm3At1Rb8L2VHD9VIHEN2tPxv36YaAiOY
         UdFA==
X-Gm-Message-State: AOAM530hquzpetFpZf8p22P+nIZqha5Ce2y+xGXckL3BRAf4LFb2tfEc
        0v1dbiy0nTAg7BYWnPSNlD99UADUBhqMUBe1z7LnDAbNY0TP6wqQqXY/oQcqvVwIl73UsyTHvEx
        x8As888Gqv57h1qx7rK4xOYT5
X-Received: by 2002:a0c:b49f:: with SMTP id c31mr604257qve.35.1614798213377;
        Wed, 03 Mar 2021 11:03:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5PF37P+ynLvSYll0RMVL0A9E5K1GNnpbcQIBu/Q3dkFlUVNkM/Ivi1uWHgnQdBHCXB/sDwA==
X-Received: by 2002:a0c:b49f:: with SMTP id c31mr603966qve.35.1614798209781;
        Wed, 03 Mar 2021 11:03:29 -0800 (PST)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-25-174-95-95-253.dsl.bell.ca. [174.95.95.253])
        by smtp.gmail.com with ESMTPSA id z65sm15976988qtd.15.2021.03.03.11.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 11:03:28 -0800 (PST)
Date:   Wed, 3 Mar 2021 14:03:27 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH RESEND v3] mm/userfaultfd: fix memory corruption due to
 writeprotect
Message-ID: <20210303190327.GV397383@xz-x1>
References: <20210303095702.3814618-1-namit@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210303095702.3814618-1-namit@vmware.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 01:57:02AM -0800, Nadav Amit wrote:
> From: Nadav Amit <namit@vmware.com>
> 
> Userfaultfd self-test fails occasionally, indicating a memory
> corruption.

It's failing very constantly now for me after I got it run on a 40 cores
system...  While indeed not easy to fail on my laptop.

[...]

> Fixes: 292924b26024 ("userfaultfd: wp: apply _PAGE_UFFD_WP bit")
> Signed-off-by: Nadav Amit <namit@vmware.com>
> 
> ---
> v2->v3:
> * Do not acquire mmap_lock for write, flush conditionally instead [Yu]
> * Change the fixes tag to the patch that made the race apparent [Yu]

Did you forget about this one?  It would still be good to point to 09854ba94c6a
just to show that 5.7/5.8 stable branches shouldn't need this patch as they're
not prone to the tlb data curruption.  Maybe also cc stable with 5.9+?

> * Removing patch to avoid write-protect on uffd unprotect. More
>   comprehensive solution to follow (and avoid the TLB flush as well).
> ---
>  mm/memory.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 9e8576a83147..06da04f98936 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3092,6 +3092,13 @@ static vm_fault_t do_wp_page(struct vm_fault *vmf)
>  		return handle_userfault(vmf, VM_UFFD_WP);
>  	}
>  
> +	/*
> +	 * Userfaultfd write-protect can defer flushes. Ensure the TLB
> +	 * is flushed in this case before copying.
> +	 */
> +	if (userfaultfd_wp(vmf->vma) && mm_tlb_flush_pending(vmf->vma->vm_mm))
> +		flush_tlb_page(vmf->vma, vmf->address);
> +
>  	vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
>  	if (!vmf->page) {
>  		/*
> -- 
> 2.25.1
> 

Thanks for being consistent on fixing this problem.

Maybe it's even better to put that into a "unlikely" to reduce the affect of
normal do_wp_page as much as possible?  But I'll leave it to others.

If with the fixes tag modified:

Reviewed-by: Peter Xu <peterx@redhat.com>
Tested-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

