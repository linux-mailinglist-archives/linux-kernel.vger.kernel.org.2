Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0B63A2F07
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbhFJPIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:08:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231603AbhFJPIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:08:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623337579;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cf6hot6ZLRcduczNi4lA10wsSd7+V1kWMUGJekCYcy4=;
        b=T0Us7d5eYqvBMz3nV5Enu6ASdANwysXgnbaeyFNKJaAHJHcu8tplionE61l9tFZOa72s4i
        tBPIz458c39TEUw9l9y2F1OaeXF7ijcUawhSt6TRqXrMdyOcrPSQ0bzpHMbeAlOKATQKRb
        E/2Tlnfr6yteNwnwdRKhKyf6+5bTPls=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-mQe1ExQxNP6mlyxyDN8UFw-1; Thu, 10 Jun 2021 11:06:16 -0400
X-MC-Unique: mQe1ExQxNP6mlyxyDN8UFw-1
Received: by mail-wr1-f71.google.com with SMTP id h10-20020a5d688a0000b0290119c2ce2499so989292wru.19
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cf6hot6ZLRcduczNi4lA10wsSd7+V1kWMUGJekCYcy4=;
        b=bNHEL3BqpFIBHm8flshu+pMfJ5HxcBHdMA9Znw+jM9VhDCgC744AsUzUavHw3qDc3M
         cckYiv4LPXNsvvZENs6y7V7om7s7YqijPEKKfRRXL5mLObFUSd88eo+k3bMPm+T3IW+9
         Yo8HUKU0iM+oGWrTi/8esmEFF8ku1k+aR6yXxYz7ZIcvact0wnfVrAN/Ah56w8BTSO0l
         eiMFUvcXPq3akvbuQPEozxeIFRxO+f1ixH8wCiindxXHIoSncZoIVSF0gGMmOyJ39SKc
         IkVa+uIjCrNhnpba3VvmprHLSlmW0i65bkHLXrlqWh/kglHOOVPrKOmp4+xOrL4Le9pK
         K6gw==
X-Gm-Message-State: AOAM531IzWYIc2MNuTaOz1r4tjPHH9xQiXxQ8kx05QMTq5ZCbkpdyiU1
        NpX+yl4mkE10QCy0L0LX5OqI/Ys41AyZiE//+OXjXy+sxc6h3m9Fwq5cnFiH9h3dApitXcXyKP1
        f13GKlCgBKQ492u/RGDW8LSzh
X-Received: by 2002:a1c:2507:: with SMTP id l7mr5529083wml.188.1623337575750;
        Thu, 10 Jun 2021 08:06:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw3c6aC4X4il2k5fq/qtSdT+15bADFk4BGyt6elhfFXTSPG/U5yVnl1Y004HOWePu0JJfDfUA==
X-Received: by 2002:a1c:2507:: with SMTP id l7mr5529068wml.188.1623337575587;
        Thu, 10 Jun 2021 08:06:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id m23sm3214631wmc.29.2021.06.10.08.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 08:06:13 -0700 (PDT)
Subject: Re: [PATCH v3 0/8] Introduce KVM_{GET|SET}_SREGS2 and fix PDPTR
 migration
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Jim Mattson <jmattson@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20210607090203.133058-1-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <90393d4d-2057-b8d1-6867-275ba99efe3f@redhat.com>
Date:   Thu, 10 Jun 2021 17:06:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210607090203.133058-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/21 11:01, Maxim Levitsky wrote:
> This patch set aims to fix few flaws that were discovered
> in KVM_{GET|SET}_SREGS on x86:
> 
> * There is no support for reading/writing PDPTRs although
>    these are considered to be part of the guest state.
> 
> * There is useless interrupt bitmap which isn't needed
> 
> * No support for future extensions (via flags and such)
> 
> Also if the user doesn't use the new SREG2 api, the PDPTR
> load after migration is now done on KVM_REQ_GET_NESTED_STATE_PAGES
> to at least read them correctly in cases when guest memory
> map is not up to date when nested state is loaded.
> 
> This patch series was tested by doing nested migration test
> of 32 bit PAE L1 + 32 bit PAE L2 on AMD and Intel and by
> nested migration test of 64 bit L1 + 32 bit PAE L2 on AMD.
> The later test currently fails on Intel (regardless of my patches).
> 
> Changes from V2:
>    - I took in the patch series from Sean Christopherson that
>      removes the pdptrs_changed function and rebased my code
>      on top of it.
>    - I updated the SET_SREGS2 ioctl to load PDPTRS from memory
>      when user haven't given PDPTRS.
>    - Minor refactoring all over the place.
> 
> Changes from V1:
>    - move only PDPTRS load to KVM_REQ_GET_NESTED_STATE_PAGES on VMX
>    - rebase on top of kvm/queue
>    - improve the KVM_GET_SREGS2 to have flag for PDPTRS
>      and remove padding
> 
> Patches to qemu to enable this feature were sent as well.
> 
> Maxim Levitsky (5):
>    KVM: nSVM: refactor the CR3 reload on migration
>    KVM: nVMX: delay loading of PDPTRs to KVM_REQ_GET_NESTED_STATE_PAGES
>    KVM: x86: introduce kvm_register_clear_available
>    KVM: x86: Introduce KVM_GET_SREGS2 / KVM_SET_SREGS2
>    KVM: x86: avoid loading PDPTRs after migration when possible
> 
> Sean Christopherson (3):
>    KVM: nVMX: Drop obsolete (and pointless) pdptrs_changed() check
>    KVM: nSVM: Drop pointless pdptrs_changed() check on nested transition
>    KVM: x86: Always load PDPTRs on CR3 load for SVM w/o NPT and a PAE
>      guest
> 
>   Documentation/virt/kvm/api.rst  |  48 +++++++++
>   arch/x86/include/asm/kvm_host.h |   7 +-
>   arch/x86/include/uapi/asm/kvm.h |  13 +++
>   arch/x86/kvm/kvm_cache_regs.h   |  12 +++
>   arch/x86/kvm/svm/nested.c       |  39 +++++--
>   arch/x86/kvm/svm/svm.c          |   6 +-
>   arch/x86/kvm/vmx/nested.c       |  32 ++++--
>   arch/x86/kvm/x86.c              | 176 +++++++++++++++++++++-----------
>   include/uapi/linux/kvm.h        |   4 +
>   9 files changed, 253 insertions(+), 84 deletions(-)
> 

Queued, thanks.

Paolo

