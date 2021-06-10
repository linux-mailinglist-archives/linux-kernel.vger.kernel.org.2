Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 765AC3A2F25
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhFJPTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:19:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37835 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231615AbhFJPTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623338228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/xSRrIzE81bGjheuhkYoLTnfO0+k1xVrIn8oCBsTpxY=;
        b=Rn3djReRoY2zijzE3m5LEIOzzZzyCRipW+9a/zWdQZDnzImJicQgNJddm9NX+YDFXvsulf
        4FyYGZhB8yIQ1in5q0NidRmntyIvBKVYoVT86GA9SjlOqEtAijg1EqEIhdcJBzXRJSMfBp
        ddk6ZdUeKePirs3OERjL0B9PDkuOvws=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-Y3B2515LOdm_9sAYq5OYBg-1; Thu, 10 Jun 2021 11:17:06 -0400
X-MC-Unique: Y3B2515LOdm_9sAYq5OYBg-1
Received: by mail-wm1-f71.google.com with SMTP id h9-20020a05600c3509b02901b985251fdcso2048167wmq.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:17:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/xSRrIzE81bGjheuhkYoLTnfO0+k1xVrIn8oCBsTpxY=;
        b=CypbhsvT2Pbw6V5gn4o6fGVSE9JSZls7ux8Sh0+zbFFDlznzq+duoerEmq5q5ogc5k
         iyOshNpYSPG+//j2HVqj5GLD+Zz0MkE6+sogg9jefzVpRoyjzfvCNJEkASfz5vet7udQ
         E4njcp7OCNAQ1P4xBguup2EAq6Py50KFP3rU5eo+hS7NCD5NYY7xwpAEbd4LhYQEqNq7
         Sh8ksk5KJhQIAJJmEZCalhsHwUMP5OjP896w2lvA3skA1PSZPs7DwSvUJ8XmXNDiSJjF
         JVAO3BtFdYCuYfzb5U87R1fLc202LwJw6drkROfl4c+Qa1rT4SexsfyXWn2xwemRzHJH
         ugqg==
X-Gm-Message-State: AOAM531K+lou7PEHKntMUBT7y6rceKiQWdq/s5GIlXzFvSevT5W3w9Xz
        QksxU7/FUi1kx2bwFJlnsN7NxXYTqZzuzh31NAsp0CJhov6rU0KJVeZUpemclBBXdBq/zX/tLUz
        fvFA4iqB371S1049aImtTjnzf
X-Received: by 2002:a1c:770f:: with SMTP id t15mr5469012wmi.182.1623338225477;
        Thu, 10 Jun 2021 08:17:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyniLL7r+DAEaQMlKPgbj1DYzIM+sEF3iD8sNZCqVDC2l+Oig0TrJxUUoQsUdhp7IQe4no2gA==
X-Received: by 2002:a1c:770f:: with SMTP id t15mr5468989wmi.182.1623338225284;
        Thu, 10 Jun 2021 08:17:05 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id 89sm4200534wrq.14.2021.06.10.08.17.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 08:17:04 -0700 (PDT)
Subject: Re: [PATCH v5 0/7] Hyper-V nested virt enlightenments for SVM
To:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Wei Liu <wei.liu@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
References: <cover.1622730232.git.viremana@linux.microsoft.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5af1ccce-a07d-5a13-107b-fc4c4553dd4d@redhat.com>
Date:   Thu, 10 Jun 2021 17:17:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <cover.1622730232.git.viremana@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/21 17:14, Vineeth Pillai wrote:
> This patch series enables the nested virtualization enlightenments for
> SVM. This is very similar to the enlightenments for VMX except for the
> fact that there is no enlightened VMCS. For SVM, VMCB is already an
> architectural in-memory data structure.
> 
> Note: v5 is just a rebase on hyperv-next(5.13-rc1) and needed a rework
> based on the patch series: (KVM: VMX: Clean up Hyper-V PV TLB flush)
> https://lore.kernel.org/lkml/20210305183123.3978098-1-seanjc@google.com/
> 
> The supported enlightenments are:
> 
> Enlightened TLB Flush: If this is enabled, ASID invalidations invalidate
> only gva -> hpa entries. To flush entries derived from NPT, hyper-v
> provided hypercalls (HvFlushGuestPhysicalAddressSpace or
> HvFlushGuestPhysicalAddressList) should be used.
> 
> Enlightened MSR bitmap(TLFS 16.5.3): "When enabled, L0 hypervisor does
> not monitor the MSR bitmaps for changes. Instead, the L1 hypervisor must
> invalidate the corresponding clean field after making changes to one of
> the MSR bitmaps."
> 
> Direct Virtual Flush(TLFS 16.8): The hypervisor exposes hypercalls
> (HvFlushVirtualAddressSpace, HvFlushVirtualAddressSpaceEx,
> HvFlushVirtualAddressList, and HvFlushVirtualAddressListEx) that allow
> operating systems to more efficiently manage the virtual TLB. The L1
> hypervisor can choose to allow its guest to use those hypercalls and
> delegate the responsibility to handle them to the L0 hypervisor. This
> requires the use of a partition assist page."
> 
> L2 Windows boot time was measured with and without the patch. Time was
> measured from power on to the login screen and was averaged over a
> consecutive 5 trials:
>    Without the patch: 42 seconds
>    With the patch: 29 seconds
> --
> 
> Changes from v4
> - Rebased on top of 5.13-rc1 and reworked based on the changes in the
>    patch series: (KVM: VMX: Clean up Hyper-V PV TLB flush)
>    
> Changes from v3
> - Included definitions for software/hypervisor reserved fields in SVM
>    architectural data structures.
> - Consolidated Hyper-V specific code into svm_onhyperv.[ch] to reduce
>    the "ifdefs". This change applies only to SVM, VMX is not touched and
>    is not in the scope of this patch series.
> 
> Changes from v2:
> - Refactored the Remote TLB Flush logic into separate hyperv specific
>    source files (kvm_onhyperv.[ch]).
> - Reverted the VMCB Clean bits macro changes as it is no longer needed.
> 
> Changes from v1:
> - Move the remote TLB flush related fields from kvm_vcpu_hv and kvm_hv
>    to kvm_vcpu_arch and kvm_arch.
> - Modify the VMCB clean mask runtime based on whether L1 hypervisor
>    is running on Hyper-V or not.
> - Detect Hyper-V nested enlightenments based on
>    HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS.
> - Address other minor review comments.
> ---
> 
> Vineeth Pillai (7):
>    hyperv: Detect Nested virtualization support for SVM
>    hyperv: SVM enlightened TLB flush support flag
>    KVM: x86: hyper-v: Move the remote TLB flush logic out of vmx
>    KVM: SVM: Software reserved fields
>    KVM: SVM: hyper-v: Remote TLB flush for SVM
>    KVM: SVM: hyper-v: Enlightened MSR-Bitmap support
>    KVM: SVM: hyper-v: Direct Virtual Flush support
> 
>   arch/x86/include/asm/hyperv-tlfs.h |   9 ++
>   arch/x86/include/asm/kvm_host.h    |   9 ++
>   arch/x86/include/asm/svm.h         |   9 +-
>   arch/x86/include/uapi/asm/svm.h    |   3 +
>   arch/x86/kernel/cpu/mshyperv.c     |  10 ++-
>   arch/x86/kvm/Makefile              |   9 ++
>   arch/x86/kvm/kvm_onhyperv.c        |  93 +++++++++++++++++++++
>   arch/x86/kvm/kvm_onhyperv.h        |  32 +++++++
>   arch/x86/kvm/svm/svm.c             |  14 ++++
>   arch/x86/kvm/svm/svm.h             |  22 ++++-
>   arch/x86/kvm/svm/svm_onhyperv.c    |  41 +++++++++
>   arch/x86/kvm/svm/svm_onhyperv.h    | 129 +++++++++++++++++++++++++++++
>   arch/x86/kvm/vmx/vmx.c             | 105 +----------------------
>   arch/x86/kvm/vmx/vmx.h             |   9 --
>   arch/x86/kvm/x86.c                 |   9 ++
>   15 files changed, 384 insertions(+), 119 deletions(-)
>   create mode 100644 arch/x86/kvm/kvm_onhyperv.c
>   create mode 100644 arch/x86/kvm/kvm_onhyperv.h
>   create mode 100644 arch/x86/kvm/svm/svm_onhyperv.c
>   create mode 100644 arch/x86/kvm/svm/svm_onhyperv.h
> 

Queued, thanks.

Paolo

