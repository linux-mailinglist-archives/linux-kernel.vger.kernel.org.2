Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E618442C368
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbhJMOg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235247AbhJMOgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:36:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E2AC061764
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 07:34:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id qe4-20020a17090b4f8400b0019f663cfcd1so4593234pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 07:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NtWwj0vH7UOJ5LLhXdT42vgomo2Iy/QVg4NPh0ov+mc=;
        b=i4jHCEDMgA0MeyPQyBueIE183Ak+qcCdarKYGWRPkUbsoFRpR/IIG8+yyWU35jZA8N
         qt9Gsc06jQoaDSjLFsLCun/odI+PcXwZjX3t/l0tvyRGsZy5eJkHGIaoOYzvlDuYFFlN
         MIdgOfHGuvy0SL810seRJWQ7DYQjta/zNTMMSmK6c8FQ7aCskR3S+wHNOnfHwVBmn4nC
         fcO+YFvOPF2nSgSjlcYflMzl45jRp0Mnd8pwsT1TKR4l5J/m6KwuTUFFu8v1BBHaqVgS
         gJwIcf16TQtrx/rQbdxOOhHx35TR6YwE9FsnuZ0PLGlfrmNm1jT4+585xBMNJDVcMI2F
         1Q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NtWwj0vH7UOJ5LLhXdT42vgomo2Iy/QVg4NPh0ov+mc=;
        b=by88MaqUSeHWQMX3Cdpi9xGxXDTrU3Z2gAvcY+vHPt/Fo4FqSyX6LxMX0wvrmYPNE+
         tk4rZFHvA7Xu78aOo2Pp/7AwJvyYXMEibUhwlh93x0Jf2f6Ywp+zVT70xIXEYAavVsSG
         qRQL8vECG8EU8dMClbIEPvdXtHQxVagTt5p+Wuca6DljH/1zRI+H5OIkWHDTytvpa7Hh
         KbZ0kklYjBaB8TpP/HcusTDl9ReiDBYssTztI95hjwDdDZ7ihvFtNjy+znRZTkURJlRD
         l3rGyZVCGdMzBbxJtA+HPVmnOwAFxY3028Hg4BFYcKdqI/NKuZMEE6zrdkFJz1B63znY
         OxmQ==
X-Gm-Message-State: AOAM533HjRtYLG85al5YLX6MwoDmUY30Lfl8w/r3Puofa++qZmOmsvf9
        +rXVsPEaal95WalVaoUQ+KQmIQ==
X-Google-Smtp-Source: ABdhPJzXquuTdstXVSZvIV0M6MqLZDQyiQjbvZJVMnoSimk+WNvLh/HqKlBXlRLoKggQChsXsNnzHg==
X-Received: by 2002:a17:902:8d8c:b0:13d:be20:e279 with SMTP id v12-20020a1709028d8c00b0013dbe20e279mr36053185plo.5.1634135681790;
        Wed, 13 Oct 2021 07:34:41 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id d60sm6114241pjk.49.2021.10.13.07.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 07:34:41 -0700 (PDT)
Date:   Wed, 13 Oct 2021 14:34:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part2 v5 26/45] KVM: SVM: Mark the private vma unmerable
 for SEV-SNP guests
Message-ID: <YWbufTl2CKwJ2uzw@google.com>
References: <20210820155918.7518-1-brijesh.singh@amd.com>
 <20210820155918.7518-27-brijesh.singh@amd.com>
 <YWXYIWuK2T8Kejng@google.com>
 <2a8bf18e-1413-f884-15c4-0927f34ee3b9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a8bf18e-1413-f884-15c4-0927f34ee3b9@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021, Brijesh Singh wrote:
> 
> On 10/12/21 11:46 AM, Sean Christopherson wrote:
> > On Fri, Aug 20, 2021, Brijesh Singh wrote:
> >> When SEV-SNP is enabled, the guest private pages are added in the RMP
> >> table; while adding the pages, the rmp_make_private() unmaps the pages
> >> from the direct map. If KSM attempts to access those unmapped pages then
> >> it will trigger #PF (page-not-present).
> >>
> >> Encrypted guest pages cannot be shared between the process, so an
> >> userspace should not mark the region mergeable but to be safe, mark the
> >> process vma unmerable before adding the pages in the RMP table.
> > To be safe from what?  Does the !PRESENT #PF crash the kernel?
> 
> Yes, kernel crashes when KSM attempts to access to an unmaped pfn.

Is this problem unique to nuking the direct map (patch 05), or would it also be
a problem (in the form of an RMP violation) if the direct map were demoted to 4k
pages?
 
> [...]
> >> +	mmap_write_lock(kvm->mm);
> >> +	ret = snp_mark_unmergable(kvm, params.uaddr, params.len);
> >> +	mmap_write_unlock(kvm->mm);
> > This does not, and practically speaking cannot, work.  There are multiple TOCTOU
> > bugs, here and in __snp_handle_page_state_change().  Userspace can madvise() the
> > range at any later point, munmap()/mmap() the entire range, mess with the memslots
> > in the PSC case, and so on and so forth.  Relying on MADV_UNMERGEABLE for functional
> > correctness simply cannot work in KVM, barring mmu_notifier and a big pile of code.
> 
> AFAICT, ksm does not exclude the unmapped pfn from its scan list. We
> need to tell ksm somehow to exclude the unmapped pfn from its scan list.
> I understand that if userspace is messing with us, we have an issue, but
> it's a userspace bug ;) To fix it right, we need to enhance ksm to
> exclude the pfn when it is getting unmapped from the direct map. I
> believe that work can be done outside of the SNP series. I am okay to
> drop snp_mark_unmerable(), and until then, we just run with KSM
> disabled. Thoughts?
> 
> thanks
