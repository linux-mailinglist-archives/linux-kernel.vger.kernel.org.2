Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57033C93CA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236971AbhGNW2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbhGNW2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:28:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFC2C061764
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:25:08 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id a14so2176099pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d0LEZQXZXBUYt56KXRh0C3kDKHdIojtN6Lf/OzbsuzM=;
        b=FfQxK3SV/ESQiEb5v3FHVKWIjqOGMi4YhXCbDa/51EtfbkQHxT2bFZuQBtvVg++Xeg
         6tt92/t1RsBiKAXrzBF+W13Xl100z7HkSSk7BE9ticaVj6iq5TZK7Yg/85MWig+KqUDw
         cyh4r8o4dCYrVzEuhIF9iT9raSFKiQqQNcDLT7akQKaZ/An2B98mJOTtp0QI2qrbIFM4
         WR9L7DaXT0Vv1KusvFEYql1V5zbws+hFtvF3t8YfggWxOEhoGuBz+C+2lUnc/kEi5Ad0
         eL5L3DWqhdHe5U357bksn3v1Xz/7tZ2TBx48v3xH753GiAUfNYU73mbLS26JarnruUEu
         /B+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d0LEZQXZXBUYt56KXRh0C3kDKHdIojtN6Lf/OzbsuzM=;
        b=i/JLUjjSDd3xBxwF9I+aYmlqy90OgJEmcvIPX0r0CzxygoAliuomdPobrSyt8GkVZp
         m94WF76DU2KCmX+2AQfmUJGQBjlqg946fB+Vh7UFyT9N+Jm46eN0/uZDl2A19Qk948FL
         7/HUZu9HvzOikcKDo0x4eTmxmU9eGO/p3ynrp9p/2o1QCrO4K7tX65PF79IpggxpPMff
         GgneugzMDVjF/Pf5iVqb+rgCZHjPrvqmrRS+sWAH3T6SU6jhTl1Xq4Y9/3luQ3GgXVuV
         CrmHJ/4iLmRMx/7atGyXvT1cJPLrhjF642DAiXCmFlSCIFhyc1XgiB1keq3Po00+USD4
         4aOw==
X-Gm-Message-State: AOAM533bhzkUxm+GYci18s3Tv+R97mJc6JVwxIdwQ58RezmvU5Yb8klI
        NiHCpszoGf49slZOkmxPcSFMPg==
X-Google-Smtp-Source: ABdhPJyj12ndfez3CtyE1b5kgpw1CSsww4ClT6FKSpDwrLOL4aVpAEAP3FkBpK5S7C9HrKMRFrU05w==
X-Received: by 2002:a17:90b:1d84:: with SMTP id pf4mr140522pjb.166.1626301507743;
        Wed, 14 Jul 2021 15:25:07 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id 3sm3889790pfm.25.2021.07.14.15.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:25:07 -0700 (PDT)
Date:   Wed, 14 Jul 2021 22:25:03 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>, tony.luck@intel.com,
        npmccallum@redhat.com, brijesh.ksingh@gmail.com
Subject: Re: [PATCH Part2 RFC v4 07/40] x86/sev: Split the physmap when
 adding the page in RMP table
Message-ID: <YO9kP1v0TAFXISHD@google.com>
References: <20210707183616.5620-1-brijesh.singh@amd.com>
 <20210707183616.5620-8-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210707183616.5620-8-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2021, Brijesh Singh wrote:
> The integrity guarantee of SEV-SNP is enforced through the RMP table.
> The RMP is used in conjuntion with standard x86 and IOMMU page
> tables to enforce memory restrictions and page access rights. The
> RMP is indexed by system physical address, and is checked at the end
> of CPU and IOMMU table walks. The RMP check is enforced as soon as
> SEV-SNP is enabled globally in the system. Not every memory access
> requires an RMP check. In particular, the read accesses from the
> hypervisor do not require RMP checks because the data confidentiality
> is already protected via memory encryption. When hardware encounters
> an RMP checks failure, it raise a page-fault exception. The RMP bit in
> fault error code can be used to determine if the fault was due to an
> RMP checks failure.
> 
> A write from the hypervisor goes through the RMP checks. When the
> hypervisor writes to pages, hardware checks to ensures that the assigned
> bit in the RMP is zero (i.e page is shared). If the page table entry that
> gives the sPA indicates that the target page size is a large page, then
> all RMP entries for the 4KB constituting pages of the target must have the
> assigned bit 0. If one of entry does not have assigned bit 0 then hardware
> will raise an RMP violation. To resolve it, split the page table entry
> leading to target page into 4K.

Isn't the above just saying:

  All RMP entries covered by a large page must match the shared vs. encrypted
  state of the page, e.g. host large pages must have assigned=0 for all relevant
  RMP entries.

> This poses a challenge in the Linux memory model. The Linux kernel
> creates a direct mapping of all the physical memory -- referred to as
> the physmap. The physmap may contain a valid mapping of guest owned pages.
> During the page table walk, the host access may get into the situation
> where one of the pages within the large page is owned by the guest (i.e
> assigned bit is set in RMP). A write to a non-guest within the large page
> will raise an RMP violation. Call set_memory_4k() to split the physmap
> before adding the page in the RMP table. This ensures that the pages
> added in the RMP table are used as 4K in the physmap.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/sev.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
> index 949efe530319..a482e01f880a 100644
> --- a/arch/x86/kernel/sev.c
> +++ b/arch/x86/kernel/sev.c
> @@ -2375,6 +2375,12 @@ int rmpupdate(struct page *page, struct rmpupdate *val)
>  	if (!cpu_feature_enabled(X86_FEATURE_SEV_SNP))
>  		return -ENXIO;
>  
> +	ret = set_memory_4k((unsigned long)page_to_virt(page), 1);

IIUC, this shatters the direct map for page that's assigned to an SNP guest, and
the large pages are never recovered?

I believe a better approach would be to do something similar to memfd_secret[*],
which encountered a similar problem with the direct map.  Instead of forcing the
direct map to be forever 4k, unmap the direct map when making a page guest private,
and restore the direct map when it's made shared (or freed).

I thought memfd_secret had also solved the problem of restoring large pages in
the direct map, but at a glance I can't tell if that's actually implemented
anywhere.  But, even if it's not currently implemented, I think it makes sense
to mimic the memfd_secret approach so that both features can benefit if large
page preservation/restoration is ever added.

[*] https://lkml.kernel.org/r/20210518072034.31572-5-rppt@kernel.org

> +	if (ret) {
> +		pr_err("Failed to split physical address 0x%lx (%d)\n", spa, ret);
> +		return ret;
> +	}
> +
>  	/* Retry if another processor is modifying the RMP entry. */
>  	do {
>  		/* Binutils version 2.36 supports the RMPUPDATE mnemonic. */
> -- 
> 2.17.1
> 
