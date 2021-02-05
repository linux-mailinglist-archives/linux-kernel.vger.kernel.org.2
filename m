Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC8F310BFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 14:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbhBENkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 08:40:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50201 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229988AbhBENgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:36:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612532079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+FKg2DTzgviX+HjS8G7qH+HGbWsC/RfTXSUIVNIG9yc=;
        b=jUVsXq7vj/Bs+RsnA54ayZwcTWh3GL/MASOZDEbWk0GnXrNg6KNlM9CaKWT3gJdBwVqh5N
        BiYdcNRTj8RR1ChzFLyHZP2wjFNAHcnmfG8obpY1yS1VV17kGMdQkkmX1X1b49cOHu2qcH
        HIY5YEk1UsDy9ByFaLLAGjlQaJXfoHM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-570-UY2DmFPnNSeToJfNaHH2-Q-1; Fri, 05 Feb 2021 08:34:37 -0500
X-MC-Unique: UY2DmFPnNSeToJfNaHH2-Q-1
Received: by mail-ej1-f69.google.com with SMTP id by20so6737558ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 05:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+FKg2DTzgviX+HjS8G7qH+HGbWsC/RfTXSUIVNIG9yc=;
        b=NmP3P3VjSRLhRajQP+uMJZX7T1hvkAhc/ESghq/FmSKPaW5ba5HFDLA49v9wluTcb1
         lkdCEPOFfyWuU2JrBA3yS7rjBihXIXGGukUNiUWw59r32CM9hPT3FrsHGvm+f5yh0T6G
         IX4oLNTWyGR5EHXXiHy8RWQUAOgpboA/t6rLLJGQfdWQ41LGiNs/nIeQdIH8WE40464X
         cTlRvZrUX1M09BJt1PDuN306SNQPOkKxE6nJ9EZeHyUpCESgk4DlVC6jcRarXHvaIFrE
         tL8tDuNo7dOAjrGlrqfRzey3xOSZMbd5ebjHTksr94pbio3sSFRCSpSyo5iaIPVkDFwG
         BXeg==
X-Gm-Message-State: AOAM532ZFZjcLFm2WJMJ3jARQNKBhVyDIVZ/S0yzp8TmfYZMr6QiyTQj
        sD5xRgq5zvcCYjJaC3oL97PDloBSbkj3xSK4CeQ6vU+awjv2SSrX9thNPgUXbn7GLQf0cqD8+bY
        O7I7donpxd+XBQfrxp7zRAifl
X-Received: by 2002:aa7:dc17:: with SMTP id b23mr3572471edu.139.1612532076605;
        Fri, 05 Feb 2021 05:34:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHRaQZ6QkM5lJwBQoi1W7M9I9XGnD4C4hGg+cwtWLLAv4TNugbGm9Im1snFAe/Z2jIKqZbDQ==
X-Received: by 2002:aa7:dc17:: with SMTP id b23mr3572459edu.139.1612532076428;
        Fri, 05 Feb 2021 05:34:36 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id x14sm3906639ejb.0.2021.02.05.05.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Feb 2021 05:34:35 -0800 (PST)
To:     Zhimin Feng <fengzhimin@bytedance.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     seanjc@google.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, fweisbec@gmail.com,
        zhouyibo@bytedance.com, zhanghaozhong@bytedance.com
References: <20210205100317.24174-1-fengzhimin@bytedance.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RESEND RFC: timer passthrough 0/9] Support timer passthrough for
 VM
Message-ID: <1ec32a4a-8f05-c840-8c8e-29c9c2a7f868@redhat.com>
Date:   Fri, 5 Feb 2021 14:34:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210205100317.24174-1-fengzhimin@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/21 11:03, Zhimin Feng wrote:
> The main motivation for this patch is to improve the performance of VM.
> This patch series introduces how to enable the timer passthrough in
> non-root mode.
> 
> The main idea is to offload the host timer to the preemtion timer in
> non-root mode. Through doing this, guest can write tscdeadline msr directly
> in non-root mode and host timer isn't lost. If CPU is in root mode,
> guest timer is switched to software timer.
> 
> Testing on Intel(R) Xeon(R) Platinum 8260 server.
> 
> The guest OS is Debian(kernel: 4.19.28). The specific configuration is
>   is as follows: 8 cpu, 16GB memory, guest idle=poll
> memcached in guest(memcached -d -t 8 -u root)
> 
> I use the memtier_benchmark tool to test performance
> (memtier_benchmark -P memcache_text -s guest_ip -c 16 -t 32
>   --key-maximum=10000000000 --random-data --data-size-range=64-128 -p 11211
>   --generate-keys --ratio 5:1 --test-time=500)
> 
> Total Ops can be improved 25% and Avg.Latency can be improved 20% when
> the timer-passthrough is enabled.

As Peter noticed, this is very invasive.  Perhaps you could try 
organizing the code like this:

1) just for the sake of these patches, completely disable the usage of 
the preemption timer

2) add a module parameter that:

- reads the TSC deadline MSR on vmentry and uses it to program the VMX 
preemption timer

- disables the host APIC timer while the guest runs

- injects a timer interrupt on preemption timer vmexits

3) also if the module parameter is 1, use the MSR autoload feature to 
use TSC_ADJUST instead of the VMCS TSC offset

4) also if the module parameter is 1 reintroduce the hv_timer callbacks, 
but this time to program the TSC deadline timer via MSR autoload

5) only when everything else is in place, figure out how to avoid the 
RDMSR for the TSC deadline MSR.

Thanks,

Paolo

