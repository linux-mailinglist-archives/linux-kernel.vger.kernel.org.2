Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB3E32F1E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 18:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhCERxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 12:53:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32558 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229854AbhCERxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 12:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614966797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m2HaaGfwBRue33Bv5Xznkqf0FCPjcM0bZjI9u/C8jJE=;
        b=aInSmGWg9tR7Hzg12nNcXqyCtqKPghKr7SsKlupubOeqtX9726mvMbAmbCcr87wd3God7O
        X7FDf3o47+wgwV5DSc58qCP5ksha01eZ2K4r4Ngz4F6kxTPoRsaqjR9+9FlaJPEy7Qpovq
        4xbWf1JUy0vIite3Nhfurl4vwXGZeys=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-qDpInaBmN2eImMXkXGN-uQ-1; Fri, 05 Mar 2021 12:53:14 -0500
X-MC-Unique: qDpInaBmN2eImMXkXGN-uQ-1
Received: by mail-wm1-f69.google.com with SMTP id f9so1126164wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 09:53:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m2HaaGfwBRue33Bv5Xznkqf0FCPjcM0bZjI9u/C8jJE=;
        b=VHHTghn1ZJGIW+bEf5oYidis1HXbKqD5hjIlMgorXPBVtBhLj7rIzEuoRlySODp18C
         7MIAkvSmHOFsVjWnnHMfYi6/Simlv0XjHW+ZUzDWBZR8fcCpEtM8AD4rANw32D7ziq7p
         bAO5AOJH4O5oq717337ATgDTIa7K1cIVNo51u9OK/7TmeyKKIVFrStDiXUp1c+HMv/MI
         P/fT/BJN/B4hs93Vt4+AcDknXJJniLJjgK/6E+vZGcHfGxRv39XVOsZtVyWX+1mlxc5C
         CPdC6M1Rf+w6TDfqsVhZGOmvLOHdCV2sBH35kL39zELURo7pomTexPuknYGJJwfcen4D
         Ovpw==
X-Gm-Message-State: AOAM5334TmwW3FmjMt2L9INClTVoNsUqUCTQfXHrrADbed5KRIQ9pPEq
        imdbXqb1qQ6aLjA25X99EKtUB0vCBvQP6hXGEwxR45m4Q0fGUwZJNQkUvx+upol4mD418iEjjGw
        pz09zDxYyvGAFSctYCRqJ9ih8
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr10094053wmj.73.1614966792728;
        Fri, 05 Mar 2021 09:53:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwxy5nT7R9/GFasmHSej+pydUjGlFdDuIbcAMfVeAUDquBoT9Xc+rQ8vnZNfdvj8ahA4TDm0Q==
X-Received: by 2002:a7b:c24e:: with SMTP id b14mr10094039wmj.73.1614966792547;
        Fri, 05 Mar 2021 09:53:12 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id 1sm5434627wmj.2.2021.03.05.09.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 09:53:12 -0800 (PST)
Subject: Re: [PATCH v2 00/17] KVM: x86/mmu: Lots of bug fixes
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20210305011101.3597423-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <556fe37f-02ba-5852-05b6-e1e57b275460@redhat.com>
Date:   Fri, 5 Mar 2021 18:53:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210305011101.3597423-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/21 02:10, Sean Christopherson wrote:
> Fix nested NPT (nSVM) with 32-bit L1 and SME with shadow paging, which
> are completely broken.  Opportunistically fix theoretical bugs related to
> prematurely reloading/unloading the MMU.
> 
> If nNPT is enabled, L1 can crash the host simply by using 32-bit NPT to
> trigger a null pointer dereference on pae_root.
> 
> SME with shadow paging (including nNPT) fails to set the C-bit in the
> shadow pages that don't go through standard MMU flows (PDPTPRs and the
> PML4 used by nNPT to shadow legacy NPT).  It also failes to account for
> CR3[63:32], and thus the C-bit, being ignored outside of 64-bit mode.
> 
> Patches 01 and 02 fix the null pointer bugs.
> 
> Patches 03-09 fix mostly-benign related memory leaks.
> 
> Patches 10-12 fix the SME shadow paging bugs, which are also what led me to
> the nNPT null pointer bugs.
> 
> Patches 13 and 14 fix theoretical bugs with PTP_SWITCH and INVPCID that
> I found when auditing flows that touch the MMU context.
> 
> Patches 14-17 do additional clean up to hopefully make it harder to
> introduce bugs in the future.
> 
> On the plus side, I finally understand why KVM supports shadowing 2-level
> page tables with 4-level page tables...
> 
> Based on kvm/queue, commit fe5f0041c026 ("KVM/SVM: Move vmenter.S exception
> fixups out of line").  The null pointer fixes cherry-pick cleanly onto
> kvm/master, haven't tried the other bug fixes (I doubt they're worth
> backporting even though I tagged 'em with stable).
> 
> v2:
>    - Collect a review from Ben (did not include his review of patch 03
>      since the patch and its direct dependencies were changed).
>    - Move pae_root and lm_root allocation to a separate helper to avoid
>      sleeping via get_zeroed_page() while holding mmu_lock.
>    - Add a patch to grab 'mmu' in a local variable.
>    - Remove the BUILD_BUG_ON() in make_mmu_pages_available() since the
>      final check wouldn't actually guarnatee 4 pages were "available".
>      Instead, add a comment about the limit being soft.
> 
> v1:
>    - https://lkml.kernel.org/r/20210302184540.2829328-1-seanjc@google.com
>   
> Sean Christopherson (17):
>    KVM: nSVM: Set the shadow root level to the TDP level for nested NPT
>    KVM: x86/mmu: Alloc page for PDPTEs when shadowing 32-bit NPT with
>      64-bit
>    KVM: x86/mmu: Capture 'mmu' in a local variable when allocating roots
>    KVM: x86/mmu: Allocate the lm_root before allocating PAE roots
>    KVM: x86/mmu: Allocate pae_root and lm_root pages in dedicated helper
>    KVM: x86/mmu: Ensure MMU pages are available when allocating roots
>    KVM: x86/mmu: Check PDPTRs before allocating PAE roots
>    KVM: x86/mmu: Fix and unconditionally enable WARNs to detect PAE leaks
>    KVM: x86/mmu: Use '0' as the one and only value for an invalid PAE
>      root
>    KVM: x86/mmu: Set the C-bit in the PDPTRs and LM pseudo-PDPTRs
>    KVM: x86/mmu: Mark the PAE roots as decrypted for shadow paging
>    KVM: SVM: Don't strip the C-bit from CR2 on #PF interception
>    KVM: nVMX: Defer the MMU reload to the normal path on an EPTP switch
>    KVM: x86: Defer the MMU unload to the normal path on an global INVPCID
>    KVM: x86/mmu: Unexport MMU load/unload functions
>    KVM: x86/mmu: Sync roots after MMU load iff load as successful
>    KVM: x86/mmu: WARN on NULL pae_root or lm_root, or bad shadow root
>      level
> 
>   arch/x86/include/asm/kvm_host.h |   3 -
>   arch/x86/kvm/mmu.h              |   4 +
>   arch/x86/kvm/mmu/mmu.c          | 273 ++++++++++++++++++++------------
>   arch/x86/kvm/mmu/tdp_mmu.c      |  23 +--
>   arch/x86/kvm/svm/svm.c          |   9 +-
>   arch/x86/kvm/vmx/nested.c       |   9 +-
>   arch/x86/kvm/x86.c              |   2 +-
>   7 files changed, 192 insertions(+), 131 deletions(-)
> 

Queued all except 9 and 11, thanks.

Paolo

