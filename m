Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239553FF4F9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 22:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343915AbhIBUeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 16:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239449AbhIBUef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 16:34:35 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD44C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 13:33:36 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id z24-20020a17090acb1800b0018e87a24300so2412159pjt.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 13:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WMHDe+B/QHVMoa6rzQQS13DP0+l51/+I+Sfw7Tx2c/8=;
        b=rU2L1mZSAHYMoZJ9gx9fZ91xkckimo09OPTE0gqMS7Xt9llxRz8dWEliJLHFe0VUtc
         CV0cRPvDAGqhFJB/M4vPk84e9RDhSPHo6MxOWGJqT6rTHYXdHyo2ijjSzRMKCaWZidwO
         dJc8l4NXLqQtC3KdHmt8jFIDH8V8W8n2W/5rc543HwKliUSDjztK61jDECFyZBfVKSHR
         V3gd6WTwubm5l0jqKsrfywccKMkKsg0oVFjjQOOzizDSKLfGAaSq8JFfHaKLJt8yuLyf
         76O2oKXEJ8E9dh+fW9yxDy8nkUUKGvB/4wxwpwPzPFKMhCoZm4zNobShGYCOxTEMd4He
         8xYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WMHDe+B/QHVMoa6rzQQS13DP0+l51/+I+Sfw7Tx2c/8=;
        b=O8v05GolTKOGKdR7IxeL6EApa80WlaXy6L0zIhRyqn/RP+y9cVVg7iW9QdSi/OgqRv
         AR9LATE9hXo6oHUwKd6EtPkthiajS/9/30JSQ6x+YE5bbtyqlN6fAe2iw1d0CxndWZyK
         mPhbvedIdhFnFGvM5UPqXhfiTtDXHIz48CmQTgYNzunlwQMnhDhsfAQxrkGrdcLJoxX9
         guIR8xEXSdxMXJEZILslGvxCJSsC/QpQcVmAzgvS+H6JfgEPvST65U5yGgeFRXcFO1rx
         +e16P/Qx7fKO/WBd7Fhm0JIxt9rIFRP/bCG+fbSvvXVdG7E3GFAbNAbUfvUwK24/9SGS
         8fiw==
X-Gm-Message-State: AOAM531yzxaVy0BA90CF6B0qOtCTwtDqcBnmSv02MaU7/5ofwkEuVC6I
        NeNNVhoKyECNZ1krbAyf9nhd3Q==
X-Google-Smtp-Source: ABdhPJxLz/XT64uf0+1+MuPI8Eym0X/T+avXyPeyqXI2R65veOt3faGcHH5VXlwnHl9DQOZieYUIqA==
X-Received: by 2002:a17:902:e790:b0:12c:c0f3:605c with SMTP id cp16-20020a170902e79000b0012cc0f3605cmr4540065plb.70.1630614816161;
        Thu, 02 Sep 2021 13:33:36 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d17sm3055927pfn.110.2021.09.02.13.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 13:33:35 -0700 (PDT)
Date:   Thu, 2 Sep 2021 20:33:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>,
        Andi Kleen <ak@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Dario Faggioli <dfaggioli@suse.com>, x86@kernel.org,
        linux-mm@kvack.org, linux-coco@lists.linux.dev,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>
Subject: Re: [RFC] KVM: mm: fd-based approach for supporting KVM guest
 private memory
Message-ID: <YTE1GzPimvUB1FOF@google.com>
References: <20210824005248.200037-1-seanjc@google.com>
 <20210902184711.7v65p5lwhpr2pvk7@box.shutemov.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902184711.7v65p5lwhpr2pvk7@box.shutemov.name>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021, Kirill A. Shutemov wrote:
> Hi folks,
> 
> I try to sketch how the memfd changes would look like.
> 
> I've added F_SEAL_GUEST. The new seal is only allowed if there's no
> pre-existing pages in the fd (i_mapping->nrpages check) and there's
> no existing mapping of the file (RB_EMPTY_ROOT(&i_mapping->i_mmap.rb_root check).
> 
> After the seal is set, no read/write/mmap from userspace is allowed.
> 
> Although it's not clear how to serialize read check vs. seal setup: seal
> is protected with inode_lock() which we don't hold in read path because it
> is expensive. I don't know yet how to get it right. For TDX, it's okay to
> allow read as it cannot trigger #MCE. Maybe we can allow it?

Would requiring the size to be '0' at F_SEAL_GUEST time solve that problem?

> Truncate and punch hole are tricky.
> 
> We want to allow it to save memory if substantial range is converted to
> shared. Partial truncate and punch hole effectively writes zeros to
> partially truncated page and may lead to #MCE. We can reject any partial
> truncate/punch requests, but it doesn't help the situation with THPs.
> 
> If we truncate to the middle of THP page, we try to split it into small
> pages and proceed as usual for small pages. But split is allowed to fail.
> If it happens we zero part of THP.
> I guess we may reject truncate if split fails. It should work fine if we
> only use it for saving memory.

FWIW, splitting a THP will also require a call into KVM to demote the huge page
to the equivalent small pages.

> We need to modify truncation/punch path to notify kvm that pages are about
> to be freed. I think we will register callback in the memfd on adding the
> fd to KVM memslot that going to be called for the notification. That means
> 1:1 between memfd and memslot. I guess it's okay.

Hmm, 1:1 memfd to memslot will be problematic as that would prevent punching a
hole in KVM's memslots, e.g. to convert a subset to shared.  It would also
disallow backing guest memory with a single memfd that's split across two
memslots for <4gb and >4gb.

But I don't think we need a 1:1 relationship.  To keep KVM sane, we can require
each private memslot to be wholly contained in a single memfd, I can't think of
any reason that would be problematic for userspace.

For the callbacks, I believe the rule should be 1:1 between memfd and KVM instance.
That would allow mapping multiple memslots to a single memfd so long as they're
all coming from the same KVM instance.

> Migration going to always fail on F_SEAL_GUEST for now. Can be modified to
> use a callback in the future.
> 
> Swapout will also always fail on F_SEAL_GUEST. It seems trivial. Again, it
> can be a callback in the future.
> 
> For GPA->PFN translation KVM could use vm_ops->fault(). Semantically it is
> a good fit, but we don't have any VMAs around and ->mmap is forbidden for
> F_SEAL_GUEST.
> Other option is call shmem_getpage() directly, but it looks like a
> layering violation to me. And it's not available to modules :/

My idea for this was to have the memfd:KVM exchange callbacks, i.e. memfd would
have callbacks into KVM, but KVM would also have callbacks into memfd.  To avoid
circular refcounts, KVM would hold a reference to the memfd (since it's the
instigator) and KVM would be responsible for unregistering itself before freeing
it's reference to the memfd.

The memfd callbacks would be tracked per private memslot, which meshes nicely
without how KVM uses memslots to translate gfn->pfn.  In effect, the ops pointer
in the memslots replaces the host virtual address that's used to get the pfn for
non-private memslots.

@@ -2428,8 +2453,12 @@ kvm_pfn_t __gfn_to_pfn_memslot(struct kvm_memory_slot *slot, gfn_t gfn,
                               bool atomic, bool *async, bool write_fault,
                               bool *writable, hva_t *hva)
 {
-       unsigned long addr = __gfn_to_hva_many(slot, gfn, NULL, write_fault);
+       unsigned long addr;

+       if (memslot_is_private(slot))
+               return slot->private_ops->gfn_to_pfn(...);
+
+       addr = __gfn_to_hva_many(slot, gfn, NULL, write_fault);
        if (hva)
                *hva = addr;

> 
> Any comments?
> 
> -- 
>  Kirill A. Shutemov
