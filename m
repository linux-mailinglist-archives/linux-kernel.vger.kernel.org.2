Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F9733960C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhCLSR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:17:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232384AbhCLSRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615573072;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/bpqX6KpVAcJooE3Lw0u6jY6Pd5GmW23X66ZAV0EAQ4=;
        b=APtiUFRyuLjiESil/+xJgv9Fq0RnQEZhK9XQZ3DhI2BtEZbSnjgi9KLwVBsLq9z0in2voW
        kVOLBKYg+pLLoj+vM+BqFOMRhhU9I1SsEi++VVC+2hlsCtoHcjMF2eq7SsHfLJYzq2qf6K
        aOOxelFqx1eCwJOnBprNfbrFiWOwE9Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-zkouZVurOkSW0ZQOWk74JA-1; Fri, 12 Mar 2021 13:17:50 -0500
X-MC-Unique: zkouZVurOkSW0ZQOWk74JA-1
Received: by mail-wr1-f70.google.com with SMTP id z17so11501744wrv.23
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 10:17:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/bpqX6KpVAcJooE3Lw0u6jY6Pd5GmW23X66ZAV0EAQ4=;
        b=Rwz5+1eKhzWhxRsElwjLsbAZexUjkxnkzRzqPnSbI8hHGOYRmJCcgffNq1eD28oWu+
         oYhHXej6FRovqcc71tyR6bihejRlSOkKi0zERPvdkMsFloxJbdGoYYVr9bUBCWRDOUep
         pp/j69AlezY1gD6lSGwdayTDDrIMtAhWUsYPMyW1PL0G67UjbpnEW72Rd6/BaBSkhqIt
         4uPsOJSM7Gwv57Ywdmi1E/1PJHw2Q0JZMR9ccCVSZzHLAk/DwbUsfH7SfeUdwytksQdL
         PaLpVNamH7yILINO2r/bEa6wG3z+ilEVWRaHKuk9is7uMac+a6ktMQL0NS4h2gg7mkAR
         c0dQ==
X-Gm-Message-State: AOAM531tTj2o8q7t3cQ8cUFsToAmoHctiUKX1MSCixFQ6LSWJqxddW2C
        jGJDr9DBHthGj6V6uN/4EpaPT7YEatKGPtRRieGtNK+UN7oiVNWUKB99V2QjFEd1E4p82lXlSlY
        86PJ04PfJ7C/sJKgbTX/KI8S0XoSJ/QOyxfnahT6832Qk/VlhgMVkL1Zijho61iE2tGsRFuVpeI
        CC
X-Received: by 2002:a1c:7714:: with SMTP id t20mr13963521wmi.107.1615573069153;
        Fri, 12 Mar 2021 10:17:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkVSKKwTT3S+pCDD8y3HtI9gfadnTm02c6rV1orP9fLcRk5nT4VssXqu5JJE3IeEKzQ2KuKw==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr13963501wmi.107.1615573068894;
        Fri, 12 Mar 2021 10:17:48 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j30sm10080622wrj.62.2021.03.12.10.17.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Mar 2021 10:17:48 -0800 (PST)
Subject: Re: [PATCH] kvm: x86: annotate RCU pointers
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
References: <20210305191123.GA497469@LEGION>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7ba3b977-d6a3-3518-7426-42e36ec546fc@redhat.com>
Date:   Fri, 12 Mar 2021 19:17:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210305191123.GA497469@LEGION>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/21 20:11, Muhammad Usama Anjum wrote:
> This patch adds the annotation to fix the following sparse errors:
> arch/x86/kvm//x86.c:8147:15: error: incompatible types in comparison expression (different address spaces):
> arch/x86/kvm//x86.c:8147:15:    struct kvm_apic_map [noderef] __rcu *
> arch/x86/kvm//x86.c:8147:15:    struct kvm_apic_map *
> arch/x86/kvm//x86.c:10628:16: error: incompatible types in comparison expression (different address spaces):
> arch/x86/kvm//x86.c:10628:16:    struct kvm_apic_map [noderef] __rcu *
> arch/x86/kvm//x86.c:10628:16:    struct kvm_apic_map *
> arch/x86/kvm//x86.c:10629:15: error: incompatible types in comparison expression (different address spaces):
> arch/x86/kvm//x86.c:10629:15:    struct kvm_pmu_event_filter [noderef] __rcu *
> arch/x86/kvm//x86.c:10629:15:    struct kvm_pmu_event_filter *
> arch/x86/kvm//lapic.c:267:15: error: incompatible types in comparison expression (different address spaces):
> arch/x86/kvm//lapic.c:267:15:    struct kvm_apic_map [noderef] __rcu *
> arch/x86/kvm//lapic.c:267:15:    struct kvm_apic_map *
> arch/x86/kvm//lapic.c:269:9: error: incompatible types in comparison expression (different address spaces):
> arch/x86/kvm//lapic.c:269:9:    struct kvm_apic_map [noderef] __rcu *
> arch/x86/kvm//lapic.c:269:9:    struct kvm_apic_map *
> arch/x86/kvm//lapic.c:637:15: error: incompatible types in comparison expression (different address spaces):
> arch/x86/kvm//lapic.c:637:15:    struct kvm_apic_map [noderef] __rcu *
> arch/x86/kvm//lapic.c:637:15:    struct kvm_apic_map *
> arch/x86/kvm//lapic.c:994:15: error: incompatible types in comparison expression (different address spaces):
> arch/x86/kvm//lapic.c:994:15:    struct kvm_apic_map [noderef] __rcu *
> arch/x86/kvm//lapic.c:994:15:    struct kvm_apic_map *
> arch/x86/kvm//lapic.c:1036:15: error: incompatible types in comparison expression (different address spaces):
> arch/x86/kvm//lapic.c:1036:15:    struct kvm_apic_map [noderef] __rcu *
> arch/x86/kvm//lapic.c:1036:15:    struct kvm_apic_map *
> arch/x86/kvm//lapic.c:1173:15: error: incompatible types in comparison expression (different address spaces):
> arch/x86/kvm//lapic.c:1173:15:    struct kvm_apic_map [noderef] __rcu *
> arch/x86/kvm//lapic.c:1173:15:    struct kvm_apic_map *
> arch/x86/kvm//pmu.c:190:18: error: incompatible types in comparison expression (different address spaces):
> arch/x86/kvm//pmu.c:190:18:    struct kvm_pmu_event_filter [noderef] __rcu *
> arch/x86/kvm//pmu.c:190:18:    struct kvm_pmu_event_filter *
> arch/x86/kvm//pmu.c:251:18: error: incompatible types in comparison expression (different address spaces):
> arch/x86/kvm//pmu.c:251:18:    struct kvm_pmu_event_filter [noderef] __rcu *
> arch/x86/kvm//pmu.c:251:18:    struct kvm_pmu_event_filter *
> arch/x86/kvm//pmu.c:522:18: error: incompatible types in comparison expression (different address spaces):
> arch/x86/kvm//pmu.c:522:18:    struct kvm_pmu_event_filter [noderef] __rcu *
> arch/x86/kvm//pmu.c:522:18:    struct kvm_pmu_event_filter *
> arch/x86/kvm//pmu.c:522:18: error: incompatible types in comparison expression (different address spaces):
> arch/x86/kvm//pmu.c:522:18:    struct kvm_pmu_event_filter [noderef] __rcu *
> arch/x86/kvm//pmu.c:522:18:    struct kvm_pmu_event_filter *
> 
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
>   arch/x86/include/asm/kvm_host.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 84499aad01a4..ad675c8c05e7 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -958,7 +958,7 @@ struct kvm_arch {
>   	struct kvm_pit *vpit;
>   	atomic_t vapics_in_nmi_mode;
>   	struct mutex apic_map_lock;
> -	struct kvm_apic_map *apic_map;
> +	struct kvm_apic_map __rcu *apic_map;
>   	atomic_t apic_map_dirty;
>   
>   	bool apic_access_page_done;
> @@ -1030,7 +1030,7 @@ struct kvm_arch {
>   
>   	bool bus_lock_detection_enabled;
>   
> -	struct kvm_pmu_event_filter *pmu_event_filter;
> +	struct kvm_pmu_event_filter __rcu *pmu_event_filter;
>   	struct task_struct *nx_lpage_recovery_thread;
>   
>   #ifdef CONFIG_X86_64
> 

Queued, thanks.

Paolo

