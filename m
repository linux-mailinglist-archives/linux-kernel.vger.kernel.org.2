Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA53A2F58
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhFJPc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:32:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43157 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230406AbhFJPcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:32:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623339027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=efu0ovz0vZUhixdvJGO/t500e4Gp3r4qJAzIoFIgwe8=;
        b=AOZhG7wyYZdH9nrXVvLO/ZW8+5GpR0CxflWKFmsdkfgCl9I1sbNXiuYeAqBhZYc3hv0L8X
        FheSKvvjFdb5HSL6k+Ct3Q4iaqHvcWpJ9N4N355yFYI8AnqkMYvhEI0y2LFPPYbFoygos0
        OPfHjnzP1VgGlCeUW55qwPEaz6Wx7xY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-NY2TlmTRM2OmTW42-a433w-1; Thu, 10 Jun 2021 11:30:26 -0400
X-MC-Unique: NY2TlmTRM2OmTW42-a433w-1
Received: by mail-wr1-f72.google.com with SMTP id d5-20020a0560001865b0290119bba6e1c7so1029224wri.20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=efu0ovz0vZUhixdvJGO/t500e4Gp3r4qJAzIoFIgwe8=;
        b=YUkcmAiqb9x8SzBD94qAQvp3cn2Lkk6yEGNFpvymIA9ciQY46lqL1gqS8P6AqITWIv
         74Y9NtJD981N/D+toimUhBRlUuObLT4tNEsEpPXT1t2Z31oNksX7SpkDEs9c4dwfrF8G
         rTvUQANxHl05sbdPlw+vI0SqdbNf/zs7WFNGHRJFTXvFVxu0YYOBAk5vxtl9KG78B+R9
         ia9pubQUckqeKwbeP6QoNt8roF4woZ6Egw+ebDe+XRoovc9XG/IywwcVETIuEiWfoXsp
         AAfVG4j7vsX9fquFMSKcN+3cO2YaN/AooPn/JXpAZ71jJ2TD0WmEoW/q3LbJjCp5aNFA
         b41A==
X-Gm-Message-State: AOAM530eXii+6Ixws39MlJy0hDornotoE4H0a+tT9zGpW7CBeXSaYclI
        RCeQeqsPu46IArjup6bxQwbyyk4gMcXCR3BX62Bo9Y5w9PQHzQyT1XdjNMCpEYoZpZO/Ewg/W4S
        6I8jdZNMSyIDOs1jyR9BUG+fVizSt4E6r7t49kU2wRLUry1xnNme4sD8J5rPtPzCs3DIzaQ4zZA
        I7
X-Received: by 2002:adf:e4cf:: with SMTP id v15mr6224484wrm.162.1623339025202;
        Thu, 10 Jun 2021 08:30:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyO53B14NKb+dj8B/WC9SPGoBXPPDQsDU3yXMKCASDihm/CZPI6/WCk940iZg5h2xZjOW8ioA==
X-Received: by 2002:adf:e4cf:: with SMTP id v15mr6224441wrm.162.1623339024898;
        Thu, 10 Jun 2021 08:30:24 -0700 (PDT)
Received: from ?IPv6:2001:b07:add:ec09:c399:bc87:7b6c:fb2a? ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
        by smtp.gmail.com with ESMTPSA id x18sm3931783wrw.19.2021.06.10.08.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Jun 2021 08:30:23 -0700 (PDT)
Subject: Re: [PATCH v2 00/30] KVM: x86: hyper-v: Fine-grained access check to
 Hyper-V hypercalls and MSRs
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        linux-kernel@vger.kernel.org
References: <20210521095204.2161214-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <71508674-e20f-f133-3aec-455936d35ff4@redhat.com>
Date:   Thu, 10 Jun 2021 17:30:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210521095204.2161214-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/21 11:51, Vitaly Kuznetsov wrote:
> Changes since v1:
> - Rebase to kvm/next.
> 
> Original description:
> 
> Currently, all implemented Hyper-V features (MSRs and hypercalls) are
> available unconditionally to all Hyper-V enabled guests. This is not
> ideal as KVM userspace may decide to provide only a subset of the
> currently implemented features to emulate an older Hyper-V version,
> to reduce attack surface,... Implement checks against guest visible
> CPUIDs for all currently implemented MSRs and hypercalls.
> 
> Vitaly Kuznetsov (30):
>    asm-generic/hyperv: add HV_STATUS_ACCESS_DENIED definition
>    KVM: x86: hyper-v: Introduce KVM_CAP_HYPERV_ENFORCE_CPUID
>    KVM: x86: hyper-v: Cache guest CPUID leaves determining features
>      availability
>    KVM: x86: hyper-v: Prepare to check access to Hyper-V MSRs
>    KVM: x86: hyper-v: Honor HV_MSR_HYPERCALL_AVAILABLE privilege bit
>    KVM: x86: hyper-v: Honor HV_MSR_VP_RUNTIME_AVAILABLE privilege bit
>    KVM: x86: hyper-v: Honor HV_MSR_TIME_REF_COUNT_AVAILABLE privilege bit
>    KVM: x86: hyper-v: Honor HV_MSR_VP_INDEX_AVAILABLE privilege bit
>    KVM: x86: hyper-v: Honor HV_MSR_RESET_AVAILABLE privilege bit
>    KVM: x86: hyper-v: Honor HV_MSR_REFERENCE_TSC_AVAILABLE privilege bit
>    KVM: x86: hyper-v: Honor HV_MSR_SYNIC_AVAILABLE privilege bit
>    KVM: x86: hyper-v: Honor HV_MSR_SYNTIMER_AVAILABLE privilege bit
>    KVM: x86: hyper-v: Honor HV_MSR_APIC_ACCESS_AVAILABLE privilege bit
>    KVM: x86: hyper-v: Honor HV_ACCESS_FREQUENCY_MSRS privilege bit
>    KVM: x86: hyper-v: Honor HV_ACCESS_REENLIGHTENMENT privilege bit
>    KVM: x86: hyper-v: Honor HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE
>      privilege bit
>    KVM: x86: hyper-v: Honor HV_FEATURE_DEBUG_MSRS_AVAILABLE privilege bit
>    KVM: x86: hyper-v: Inverse the default in hv_check_msr_access()
>    KVM: x86: hyper-v: Honor HV_STIMER_DIRECT_MODE_AVAILABLE privilege bit
>    KVM: x86: hyper-v: Prepare to check access to Hyper-V hypercalls
>    KVM: x86: hyper-v: Check access to HVCALL_NOTIFY_LONG_SPIN_WAIT
>      hypercall
>    KVM: x86: hyper-v: Honor HV_POST_MESSAGES privilege bit
>    KVM: x86: hyper-v: Honor HV_SIGNAL_EVENTS privilege bit
>    KVM: x86: hyper-v: Honor HV_DEBUGGING privilege bit
>    KVM: x86: hyper-v: Honor HV_X64_REMOTE_TLB_FLUSH_RECOMMENDED bit
>    KVM: x86: hyper-v: Honor HV_X64_CLUSTER_IPI_RECOMMENDED bit
>    KVM: x86: hyper-v: Honor HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED bit
>    KVM: selftests: move Hyper-V MSR definitions to hyperv.h
>    KVM: selftests: Move evmcs.h to x86_64/
>    KVM: selftests: Introduce hyperv_features test
> 
>   Documentation/virt/kvm/api.rst                |  11 +
>   arch/x86/include/asm/kvm_host.h               |   9 +
>   arch/x86/kvm/hyperv.c                         | 216 +++++-
>   arch/x86/kvm/hyperv.h                         |   1 +
>   arch/x86/kvm/x86.c                            |   4 +
>   include/asm-generic/hyperv-tlfs.h             |   1 +
>   include/uapi/linux/kvm.h                      |   1 +
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../kvm/include/{ => x86_64}/evmcs.h          |   2 +-
>   .../selftests/kvm/include/x86_64/hyperv.h     | 185 +++++
>   .../selftests/kvm/x86_64/hyperv_clock.c       |   8 +-
>   .../selftests/kvm/x86_64/hyperv_features.c    | 649 ++++++++++++++++++
>   13 files changed, 1071 insertions(+), 18 deletions(-)
>   rename tools/testing/selftests/kvm/include/{ => x86_64}/evmcs.h (99%)
>   create mode 100644 tools/testing/selftests/kvm/include/x86_64/hyperv.h
>   create mode 100644 tools/testing/selftests/kvm/x86_64/hyperv_features.c
> 

Queued, thanks.

Paolo

