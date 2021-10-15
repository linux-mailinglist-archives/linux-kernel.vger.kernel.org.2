Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D917542FC8B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 21:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242864AbhJOTwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 15:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242860AbhJOTwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 15:52:32 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A4CC061764
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 12:50:25 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id y1so7017555plk.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 12:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fpAPb87Hk9o66Grt82T0IufVe0UlC3v7GuLijQHjsuM=;
        b=s91UAFdZ0ieUkVMi/2y1gV171XFmSagz9DzrdkjBllPoja6oY6pH31eOBDMBpWYX5w
         7ond1lSxAgtYPO7AzQS55a0Xu7anIxMM0spq0lk55KPDwoxsdRnzN2qF1L6qNoDp2bCE
         SXX+P3tBGs5Rak0EdqIDzqU0IG8o9HO0LXMkGMMZ5O/3TYk+sfSyOyZoSQDBdAsin+2x
         IGVIpcWOOn7Fq5839UCSH/bMEiImuB5a9H8wB0Ldj/AMJMR9JiUYDjPywVWM3ZCbaqVy
         jzOVIPu8q4tuFiYHJjYXUDQM2EG1b6ImUItGu5T32tP1wb+rxesFRBTGDINtJ2ll/4SA
         PTeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fpAPb87Hk9o66Grt82T0IufVe0UlC3v7GuLijQHjsuM=;
        b=b7rC+GnPuyibZoWIYqThS+jeUB43TaVE+EX0VlglHWtJ6F9kS1M/T30ew9ar6GIYsg
         Tw33UbulhJLYxE/xBQlUsg3ZfS0b+IPeE3Am18LuNXJejvyIniBUttu3U1YJmyyjtiXf
         Ni1hWMpahjkMSn/1mM5miJU9pamI5VyB/UEPA7aNYSWQZV6WnW5yLiRjobu6LS9QYJp4
         2F5ePQSzUIf19IfDDn4BqvVcWM3yf0JaxfqKzi/rWs7J9lbtRJr2nwp3Ui8gKS30m59h
         idRabcrsJz4K1g9zwG42Srp5GHGWXxh0JUFzfJ3YPgxR6IZf1rhV7gBvUQ5U+3bURW2f
         2LBw==
X-Gm-Message-State: AOAM5331YwKzity2+54lnkGwGZ/r/HS6XJQs5dJPGXhWftFu+FDmPq8E
        i/jwzWVSK4rJ0H7OKPeEFHb4gA5+PRorOA==
X-Google-Smtp-Source: ABdhPJw2G9y/Z/b0IraYD7/qreyNrdK0v+KRIhDIt2ZDYy6P8l5hjLFaShTRRqYo0lpwUn+42CFScg==
X-Received: by 2002:a17:90b:17ce:: with SMTP id me14mr15754357pjb.112.1634327424985;
        Fri, 15 Oct 2021 12:50:24 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id f30sm5819571pfq.142.2021.10.15.12.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 12:50:24 -0700 (PDT)
Date:   Fri, 15 Oct 2021 19:50:20 +0000
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
Subject: Re: [PATCH Part2 v5 44/45] KVM: SVM: Support SEV-SNP AP Creation NAE
 event
Message-ID: <YWnbfCet84Vup6q9@google.com>
References: <20210820155918.7518-1-brijesh.singh@amd.com>
 <20210820155918.7518-45-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820155918.7518-45-brijesh.singh@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021, Brijesh Singh wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> Add support for the SEV-SNP AP Creation NAE event. This allows SEV-SNP
> guests to alter the register state of the APs on their own. This allows
> the guest a way of simulating INIT-SIPI.
> 
> A new event, KVM_REQ_UPDATE_PROTECTED_GUEST_STATE, is created and used
> so as to avoid updating the VMSA pointer while the vCPU is running.
> 
> For CREATE
>   The guest supplies the GPA of the VMSA to be used for the vCPU with the
>   specified APIC ID. The GPA is saved in the svm struct of the target
>   vCPU, the KVM_REQ_UPDATE_PROTECTED_GUEST_STATE event is added to the
>   vCPU and then the vCPU is kicked.
> 
> For CREATE_ON_INIT:
>   The guest supplies the GPA of the VMSA to be used for the vCPU with the
>   specified APIC ID the next time an INIT is performed. The GPA is saved
>   in the svm struct of the target vCPU.
> 
> For DESTROY:
>   The guest indicates it wishes to stop the vCPU. The GPA is cleared from
>   the svm struct, the KVM_REQ_UPDATE_PROTECTED_GUEST_STATE event is added
>   to vCPU and then the vCPU is kicked.
> 
> 
> The KVM_REQ_UPDATE_PROTECTED_GUEST_STATE event handler will be invoked as
> a result of the event or as a result of an INIT. The handler sets the vCPU
> to the KVM_MP_STATE_UNINITIALIZED state, so that any errors will leave the
> vCPU as not runnable. Any previous VMSA pages that were installed as
> part of an SEV-SNP AP Creation NAE event are un-pinned. If a new VMSA is
> to be installed, the VMSA guest page is pinned and set as the VMSA in the
> vCPU VMCB and the vCPU state is set to KVM_MP_STATE_RUNNABLE. If a new
> VMSA is not to be installed, the VMSA is cleared in the vCPU VMCB and the
> vCPU state is left as KVM_MP_STATE_UNINITIALIZED to prevent it from being
> run.

LOL, this part of the GHCB is debatable, though I guess it does say "may"...

  Using VMGEXIT SW_EXITCODE 0x8000_0013, an SEV-SNP guest can create or update the
  vCPU state of an AP, which may allow for a simpler and more secure method of
                                             ^^^^^^^
  booting an AP.

> +	if (VALID_PAGE(svm->snp_vmsa_pfn)) {

KVM's VMSA page should be freed on a successful "switch", because AFAICT it's
incorrect for KVM to ever go back to the original VMSA.

> +		/*
> +		 * The snp_vmsa_pfn fields holds the hypervisor physical address
> +		 * of the about to be replaced VMSA which will no longer be used
> +		 * or referenced, so un-pin it.
> +		 */
> +		kvm_release_pfn_dirty(svm->snp_vmsa_pfn);
> +		svm->snp_vmsa_pfn = INVALID_PAGE;
> +	}
> +
> +	if (VALID_PAGE(svm->snp_vmsa_gpa)) {
> +		/*
> +		 * The VMSA is referenced by the hypervisor physical address,
> +		 * so retrieve the PFN and pin it.
> +		 */
> +		pfn = gfn_to_pfn(vcpu->kvm, gpa_to_gfn(svm->snp_vmsa_gpa));

Oh yay, a gfn.  That means that the page is subject to memslot movement.  I don't
think the code will break per se, but it's a wrinkle that's not handled.

I'm also pretty sure the page will effectively be leaked, I don't see a

	kvm_release_pfn_dirty(svm->snp_vmsa_pfn);

in vCPU teardown.

Furthermore, letting the guest specify the page would open up to exploits of the
erratum where a spurious RMP violation is signaled if an in-use page, a.k.a. VMSA
page, is 2mb aligned.  That also means the _guest_ needs to be somehow be aware
of the erratum.

And digging through the guest patches, this gives the guest _full_ control over
the VMSA contents.  That is bonkers.  At _best_ it gives the guest the ability to
fuzz VMRUN ucode by stuffing garbage into the VMSA.

Honestly, why should KVM even support guest-provided VMSAs?  It's far, far simpler
to handle this fully in the guest with a BIOS<=>kernel mailbox; see the MP wakeup
protocol being added for TDX.  That would allow improving the security for SEV-ES
as well, though I'm guessing no one actually cares about that in practice.

IIUC, the use case for VMPLs is that VMPL0 would be fully trusted by both the host
and guest, i.e. attacks via the VMSA are out-of-scope.  That is very much not the
case here.
