Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 328BD367A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 08:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbhDVG40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 02:56:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31198 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234816AbhDVG4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619074529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m/pu0p1gTOS1PS7XsxBUkS37Pa/ylXdidImYYckq7UY=;
        b=BPooJ18AJeCRJZAJxL77fUiuX4MEWwHGHeebEncrkVe52t7wqGwLlPhakAXm0FvVwAlbQY
        HOaCx6AMHWrR4OdFbczr5yHkAT8yFAALBJxM8OaOmzLkN8+MGdDrImHOTDxdxXVxEc5LLW
        Bs6o346BYb5rp69AQbZqjzCeJ9C0QsY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-wCTrgDh_Nm6R13nWlnEPGA-1; Thu, 22 Apr 2021 02:55:27 -0400
X-MC-Unique: wCTrgDh_Nm6R13nWlnEPGA-1
Received: by mail-ed1-f71.google.com with SMTP id l22-20020a0564021256b0290384ebfba68cso12364826edw.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 23:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=m/pu0p1gTOS1PS7XsxBUkS37Pa/ylXdidImYYckq7UY=;
        b=rfnYOSjXoPh/T/rmCIgYcf17a4hnEmuEsAJt6YGZ7lTjJynU7oZNCV4H8rPmV71RIt
         0Zp3rKpCGGIlHoX4UkMR0CKmS/AyYqNMIH7sNPPb5f/flOatL2VAR+YawZn5NjV4LWMs
         jR7M4oTF3XWm+wYFGIThhEDIbR32IG6bLKG/Vfh+DtdXwsVKpVwBfExgMnex1zHjkkKf
         wSGkfLS0YW3GrPg9EDiiX0SpH8DeRE0/ZUDF94XLEjcYPjSHC/UZ5heim74w5EvIdtqS
         3o3P214UCtHwPo+eNettNeLiBrDT/+b2kCx+2la0odG9XV/UY4qe23bsilZBS/ZpjThh
         By+A==
X-Gm-Message-State: AOAM530xEOVt8JEGO6ET8FCqNNG28hC1N6wjd+ycpalr6m7Cc+SW0SXZ
        QHTQbbg8hwHGqXZlFa0PLrtI1Qzd5lP9pimKfJyO0QeXYLCKeWEz/+cXd67yg2/k1e9Q6tl9q0m
        JOdRDZkbMKmDjlN4hxVipnFi/
X-Received: by 2002:a17:906:c04:: with SMTP id s4mr1797005ejf.410.1619074526450;
        Wed, 21 Apr 2021 23:55:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzht7VAajXmdGxeQ1H5uS6egzt5iz8Mx+EaCVwvzRSrQ0cjkFg+yduXRXej/91oj8T45q0gqQ==
X-Received: by 2002:a17:906:c04:: with SMTP id s4mr1796986ejf.410.1619074526298;
        Wed, 21 Apr 2021 23:55:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id mj7sm1181802ejb.39.2021.04.21.23.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Apr 2021 23:55:25 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] KVM: x86: Fixes for (benign?) truncation bugs
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Babu Moger <babu.moger@amd.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        David Woodhouse <dwmw@amazon.co.uk>
References: <20210422022128.3464144-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <61e0dd04-a91a-1946-d694-2ed2fce4abb5@redhat.com>
Date:   Thu, 22 Apr 2021 08:55:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210422022128.3464144-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/21 04:21, Sean Christopherson wrote:
> Patches 01 and 02 fix theoretical bugs related to loading CRs through
> the emulator.  The rest of the patches are a bunch of small fixes for
> cases where KVM reads/writes a 64-bit register outside of 64-bit mode.
> 
> I stumbled on this when puzzling over commit 0107973a80ad ("KVM: x86:
> Introduce cr3_lm_rsvd_bits in kvm_vcpu_arch"), which stated that SEV
> guests failed to boot on PCID-enabled hosts.  Why only PCID hosts?
> 
> After much staring, I realized that the initial CR3 load in
> rsm_enter_protected_mode() would skip the MAXPHYADDR check due to the
> vCPU not being in long mode.  But due to the ordering problems with
> PCID, when PCID is enabled in the guest, the second load of CR3 would
> be done with long mode enabled and thus hit the SEV C-bit bug.
> 
> Changing kvm_set_cr3() made me look at the callers, and seeing that
> SVM didn't properly truncate the value made me look at everything else,
> and here we are.
> 
> Note, I strongly suspect the emulator still has bugs.  But, unless the
> guest is deliberately trying to hit these types of bugs, even the ones
> fixed here, they're likely benign.  I figured I was more likely to break
> something than I was to fix something by diving into the emulator, so I
> left it alone.  For now. :-)
> 
> v2: Rebase to kvm/queue, commit 89a22e37c8c2 ("KVM: avoid "deadlock"
>      between install_new_memslots and MMU notifier")
> 
> v1: https://lkml.kernel.org/r/20210213010518.1682691-1-seanjc@google.com
> 
> Sean Christopherson (9):
>    KVM: x86: Remove emulator's broken checks on CR0/CR3/CR4 loads
>    KVM: x86: Check CR3 GPA for validity regardless of vCPU mode
>    KVM: SVM: Truncate GPR value for DR and CR accesses in !64-bit mode
>    KVM: VMX: Truncate GPR value for DR and CR reads in !64-bit mode
>    KVM: nVMX: Truncate bits 63:32 of VMCS field on nested check in
>      !64-bit
>    KVM: nVMX: Truncate base/index GPR value on address calc in !64-bit
>    KVM: x86/xen: Drop RAX[63:32] when processing hypercall
>    KVM: SVM: Use default rAX size for INVLPGA emulation
>    KVM: x86: Rename GPR accessors to make mode-aware variants the
>      defaults
> 
>   arch/x86/kvm/emulate.c        | 68 +----------------------------------
>   arch/x86/kvm/kvm_cache_regs.h | 19 ++++++----
>   arch/x86/kvm/svm/svm.c        | 12 +++++--
>   arch/x86/kvm/vmx/nested.c     | 14 ++++----
>   arch/x86/kvm/vmx/vmx.c        |  6 ++--
>   arch/x86/kvm/x86.c            | 19 ++++++----
>   arch/x86/kvm/x86.h            |  8 ++---
>   7 files changed, 48 insertions(+), 98 deletions(-)
> 

Queued, thanks.

Paolo

