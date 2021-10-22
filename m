Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52D7843754B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 12:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbhJVKO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 06:14:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58359 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232531AbhJVKO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 06:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634897559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m9RugSDer7RJ0VTCrZoMBdAEz7BvSX18hwT5ubFXgK8=;
        b=JwM2eWNOfI7EfrJknMx0C2r6+g1HE/ZnBfcgxqPZPrwM0h/SxBDqGdDqmxiia7qhPL5NRB
        4nbNCyy67HGMFrkRY82h0d65Yco11owVZy6jTkBnatmeRh7d9WNPjZACxFf9opG8bJ/8xl
        Fc8RmQdqOjINveSu2dCCHEHss67BxGY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-cAAxMG4UM2S1qVOUuck8vQ-1; Fri, 22 Oct 2021 06:12:38 -0400
X-MC-Unique: cAAxMG4UM2S1qVOUuck8vQ-1
Received: by mail-ed1-f71.google.com with SMTP id l10-20020a056402230a00b003db6977b694so3167957eda.23
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 03:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=m9RugSDer7RJ0VTCrZoMBdAEz7BvSX18hwT5ubFXgK8=;
        b=rNZNZuN+gxo5HzHz4wd8NwNwwJyJvb3AZxpBHa5YjKtEyoHsouxE/NVKhz/Fo3xIME
         E0664wdN1x+BsrA0/vQEyM5vn1vEraJ3pftAFd3Bpf9sI9EVgXuU1Rm+Zxx66Ng0BQtf
         f+pRGws/ahcFK6Juxj9fyuZuP06ud5W1DklfW8yXuRbbs031pfcpMND3hWdgwfo+udKN
         e7BPhHdwVRxLHi2aiqCQzt3XMTO6qj6s1Eo0L/5YUeO2ADqa8nblVI4sKfS+sQnBM8u+
         iwJYI9+6VqMTs1k9uSs4p5ZqOeURxgzrw7oBHFv7RssSAhUCJUtu+duIZBKly11RS1Dy
         H44w==
X-Gm-Message-State: AOAM5318zdwuwAAQO0xMq+kql7Fnfapd4E+lJjRV/Hsxu4HT5AOyXKZ3
        JbBatmxjuo6h8kSlg4whk1DlICyy6r1BSjOLAM0DmzU0Ws8kEWAM6gKOBnD0QFxDIk+3f3g5jd1
        zx/GajxzQTxPKiGNYa7Il5p+r
X-Received: by 2002:a17:906:1c43:: with SMTP id l3mr2665061ejg.248.1634897557288;
        Fri, 22 Oct 2021 03:12:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAfZktJXuPCDHaZPcHu6CUYaNovhzRdAvTwiBezZpyP20PINdyYr8D38Mqu5aL272pdGnJaw==
X-Received: by 2002:a17:906:1c43:: with SMTP id l3mr2665042ejg.248.1634897557094;
        Fri, 22 Oct 2021 03:12:37 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id h10sm4293228edk.41.2021.10.22.03.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 03:12:36 -0700 (PDT)
Message-ID: <23d9b009-2b48-d93c-3c24-711c4757ca1b@redhat.com>
Date:   Fri, 22 Oct 2021 12:12:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH v2 0/4] KVM: x86: APICv cleanups
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Maxim Levitsky <mlevitsk@redhat.com>
References: <20211022004927.1448382-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211022004927.1448382-1-seanjc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/21 02:49, Sean Christopherson wrote:
> APICv cleanups and a dissertation on handling concurrent APIC access page
> faults and APICv inhibit updates.
> 
> I've tested this but haven't hammered the AVIC stuff, I'd appreciate it if
> someone with the Hyper-V setup can beat on the AVIC toggling.
> 
> Sean Christopherson (4):
>    KVM: x86/mmu: Use vCPU's APICv status when handling APIC_ACCESS
>      memslot
>    KVM: x86: Move SVM's APICv sanity check to common x86
>    KVM: x86: Move apicv_active flag from vCPU to in-kernel local APIC
>    KVM: x86: Use rw_semaphore for APICv lock to allow vCPU parallelism
> 
>   arch/x86/include/asm/kvm_host.h |  3 +-
>   arch/x86/kvm/hyperv.c           |  4 +--
>   arch/x86/kvm/lapic.c            | 46 ++++++++++---------------
>   arch/x86/kvm/lapic.h            |  5 +--
>   arch/x86/kvm/mmu/mmu.c          | 29 ++++++++++++++--
>   arch/x86/kvm/svm/avic.c         |  2 +-
>   arch/x86/kvm/svm/svm.c          |  2 --
>   arch/x86/kvm/vmx/vmx.c          |  4 +--
>   arch/x86/kvm/x86.c              | 59 ++++++++++++++++++++++-----------
>   9 files changed, 93 insertions(+), 61 deletions(-)
> 

Queued, thanks.  I only made small edits to the comment in patch
1, to make it very slightly shorter.

	 * 2a. APICv is globally disabled but locally enabled, and this
	 *     vCPU acquires mmu_lock before __kvm_request_apicv_update
	 *     calls kvm_zap_gfn_range().  This vCPU will install a stale
	 *     SPTE, but no one will consume it as (a) no vCPUs can be
	 *     running due to the kick from KVM_REQ_APICV_UPDATE, and
	 *     (b) because KVM_REQ_APICV_UPDATE is raised before the VM
	 *     state is update, vCPUs attempting to service the request
	 *     will block on apicv_update_lock.  The update flow will
	 *     then zap the SPTE and release the lock.

Paolo

