Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BD1438DBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 05:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhJYDUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Oct 2021 23:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhJYDU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Oct 2021 23:20:29 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96619C061745
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 20:18:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id f11so9346940pfc.12
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 20:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nsGfQnXWSm62AW+QNrvXvH+eBp/zC3qWToj/YACxaB8=;
        b=JYoB+vgxzNII/q7TzoPz3nKk2wwekI0SLs+3rB/OLGHJDfgL/esH4v4zyD1Bh0PgWv
         BTlf/d56rffFTFQEmZOfdodVpT06VQLmHIJcJPCxI8mpmTnrmZo/JKLNeSpu3/CROf5V
         1r2Lp+P4cDlkpOPQj7oPpLqXfF5r/uGygx2rwMlfqQ2BPdcIrS08ySDxpZQJPEgCZAgP
         Kc4uXkPDmRvVf06bqOM0oTwH1t9dr22pZqWkj9Nsgs1cVI4bkUjL/c23TBEjIaY2hAhP
         wrZiTc4piINJKLEldDSY7gDN/K/cylRnSLEFuAkq0SgbyvpYU0mc/QTXkMaGcQ2oX19t
         x4XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nsGfQnXWSm62AW+QNrvXvH+eBp/zC3qWToj/YACxaB8=;
        b=O2CRzWGfH7ZaStx//0vmnM8qgBMbAp/XhKmIRSI9+ewo5SNpaNolgyiJJ+STTBUPkM
         B8Xc5kDIoyWhm7TaFnxBNdMDeWRu1eE4qDN2kGbB9Fc0khXj7E5pjSX1/lnSqFWxKQVS
         4JfqgnGRzt7pJMhxbK3JTBkKFu9XRfF/lGtkjstzfXpR4SRZ2gHF1g64wApk+S8mg+CW
         iiePtLPRjfpbmtfUd+n2Vs2cXF5Zug8UXPsGz8qcl6/I4zKoXHQaTNJ/lfHfvokD1dvu
         AAg6h5Kmm14MZNlamBk5paboiKxPMZPYNOyz0T9Hd70oVmVYrFG2XPbEt0WZAXmv/wFn
         uwMg==
X-Gm-Message-State: AOAM531Ng9oWsCqbOegac1A0EwnBh6FWJQ3UHmtuy7HQx5+YKqd1rP1R
        Nrx/VS/gYHqhIsyxjpxPFAplVg==
X-Google-Smtp-Source: ABdhPJwbwShw0VfqPM4Odn5xsAapjaBU4pYODbV2tgfstvScWSUyIrN/spGEGDjRkxWr8+jWgDMfdw==
X-Received: by 2002:aa7:8189:0:b0:44c:293a:31e4 with SMTP id g9-20020aa78189000000b0044c293a31e4mr15458017pfi.51.1635131887047;
        Sun, 24 Oct 2021 20:18:07 -0700 (PDT)
Received: from [10.2.24.177] ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id l12sm18165113pfu.100.2021.10.24.20.18.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 20:18:06 -0700 (PDT)
Subject: Re: [PATCH] x86/kvm: Introduce boot parameter no-kvm-pvipi
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     Wanpeng Li <kernellwp@gmail.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wanpeng Li <wanpengli@tencent.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
References: <20211020120726.4022086-1-pizhenwei@bytedance.com>
 <CANRm+CxAVA-L0wjm72eohXXWvh9fS7wVFzfKHuEjrsiRFuk9fg@mail.gmail.com>
 <YXB4FHfzh99707EH@google.com>
 <08757159-1673-5c7b-3efc-e5b54e82d6c3@bytedance.com>
 <CANRm+CzcTUWYJeaj3eWKH84YZYgeMZz3kbpn13c8i97iYGGHFQ@mail.gmail.com>
 <5b718b32-cd92-920e-c474-27b9cafeec60@bytedance.com>
Message-ID: <ec014e8d-eb5f-03cc-3ed1-da58039ef034@bytedance.com>
Date:   Mon, 25 Oct 2021 11:14:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <5b718b32-cd92-920e-c474-27b9cafeec60@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/21 3:17 PM, zhenwei pi wrote:
> On 10/21/21 1:03 PM, Wanpeng Li wrote:
>> On Thu, 21 Oct 2021 at 11:05, zhenwei pi <pizhenwei@bytedance.com> wrote:
>>>
>>>
>>> On 10/21/21 4:12 AM, Sean Christopherson wrote:
>>>> On Wed, Oct 20, 2021, Wanpeng Li wrote:
>>>>> On Wed, 20 Oct 2021 at 20:08, zhenwei pi <pizhenwei@bytedance.com> 
>>>>> wrote:
>>>>>>
>>>>>> Although host side exposes KVM PV SEND IPI feature to guest side,
>>>>>> guest should still have a chance to disable it.
>>>>>>
>>>>>> A typicall case of this parameter:
>>>>>> If the host AMD server enables AVIC feature, the flat mode of APIC
>>>>>> get better performance in the guest.
>>>>>
>>>>> Hmm, I didn't find enough valuable information in your posting. We
>>>>> observe AMD a lot before.
>>>>> https://lore.kernel.org/all/CANRm+Cx597FNRUCyVz1D=B6Vs2GX3Sw57X7Muk+yMpi_hb+v1w@mail.gmail.com/T/#u 
>>>>>
>>>>
>>>> I too would like to see numbers.  I suspect the answer is going to 
>>>> be that
>>>> AVIC performs poorly in CPU overcommit scenarios because of the cost 
>>>> of managing
>>>> the tables and handling "failed delivery" exits, but that AVIC does 
>>>> quite well
>>>> when vCPUs are pinned 1:1 and IPIs rarely require an exit to the host.
>>>>
>>>
>>> Test env:
>>> CPU: AMD EPYC 7642 48-Core Processor
>>>
>>> Kmod args(enable avic and disable nested):
>>> modprobe kvm-amd nested=0 avic=1 npt=1
>>>
>>> QEMU args(disable x2apic):
>>> ... -cpu host,x2apic=off ...
>>>
>>> Benchmark tool:
>>> https://github.com/bytedance/kvm-utils/tree/master/microbenchmark/apic-ipi 
>>>
>>>
>>> ~# insmod apic_ipi.ko options=5 && dmesg -c
>>>
>>>    apic_ipi: 1 NUMA node(s)
>>>    apic_ipi: apic [flat]
>>>    apic_ipi: apic->send_IPI[default_send_IPI_single+0x0/0x40]
>>>    apic_ipi: apic->send_IPI_mask[kvm_send_ipi_mask+0x0/0x10]
>>>    apic_ipi:     IPI[kvm_send_ipi_mask] from CPU[0] to CPU[1]
>>>    apic_ipi:             total cycles 375671259, avg 3756
>>>    apic_ipi:     IPI[flat_send_IPI_mask] from CPU[0] to CPU[1]
>>>    apic_ipi:             total cycles 221961822, avg 2219
>>>
>>>
>>> apic->send_IPI_mask[kvm_send_ipi_mask+0x0/0x10]
>>>     -> This line show current send_IPI_mask is kvm_send_ipi_mask(because
>>> of PV SEND IPI FEATURE)
>>>
>>> apic_ipi:       IPI[kvm_send_ipi_mask] from CPU[0] to CPU[1]
>>> apic_ipi:               total cycles 375671259, avg 3756
>>>     -->These lines show the average cycles of each kvm_send_ipi_mask: 
>>> 3756
>>>
>>> apic_ipi:       IPI[flat_send_IPI_mask] from CPU[0] to CPU[1]
>>> apic_ipi:               total cycles 221961822, avg 2219
>>>     -->These lines show the average cycles of each 
>>> flat_send_IPI_mask: 2219
>>
>> Just single target IPI is not eough.
>>
>>      Wanpeng
>>
> 
> Benchmark smp_call_function_single 
> (https://github.com/bytedance/kvm-utils/blob/master/microbenchmark/ipi-bench/ipi_bench.c): 
> 
> 
>   Test env:
>   CPU: AMD EPYC 7642 48-Core Processor
> 
>   Kmod args(enable avic and disable nested):
>   modprobe kvm-amd nested=0 avic=1 npt=1
> 
>   QEMU args(disable x2apic):
>   ... -cpu host,x2apic=off ...
> 
> 1> without no-kvm-pvipi:
> ipi_bench_single wait[1], CPU0[NODE0] -> CPU1[NODE0], loop = 100000
>       elapsed =        424945631 cycles, average =     4249 cycles
>       ipitime =        385246136 cycles, average =     3852 cycles
> ipi_bench_single wait[0], CPU0[NODE0] -> CPU1[NODE0], loop = 100000
>       elapsed =        419057953 cycles, average =     4190 cycles
> 
> 2> with no-kvm-pvipi:
> ipi_bench_single wait[1], CPU0[NODE0] -> CPU1[NODE0], loop = 100000
>       elapsed =        321756407 cycles, average =     3217 cycles
>       ipitime =        299433550 cycles, average =     2994 cycles
> ipi_bench_single wait[0], CPU0[NODE0] -> CPU1[NODE0], loop = 100000
>       elapsed =        295382146 cycles, average =     2953 cycles
> 
> 
Hi, Wanpeng & Sean

Also benchmark redis(by 127.0.0.1) in a guest(2vCPU), 'no-kvm-pvipi' 
gets better performance.

Test env:
Host side: pin 2vCPU on 2core in a die.
Guest side: run command:
   taskset -c 1 ./redis-server --appendonly no
   taskset -c 0 ./redis-benchmark -h 127.0.0.1 -d 1024 -n 10000000 -t get

1> without no-kvm-pvipi:
redis QPS: 193203.12 requests per second
kvm_pv_send_ipi exit: ~18K/s

2> with no-kvm-pvipi:
redis QPS: 196028.47 requests per second
avic_incomplete_ipi_interception exit: ~5K/s

-- 
zhenwei pi
