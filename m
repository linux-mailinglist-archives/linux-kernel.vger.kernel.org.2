Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD262435B90
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 09:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhJUHXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 03:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhJUHXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 03:23:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B28AC06161C
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 00:21:06 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id f11so5081214pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 00:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HqBHLqwwr+ko0hKn1SGvuqbP8NIUIoixaku53/kbAb0=;
        b=PUr3JwS9ESdq0+Ehhr7y26LHzIrPn3zmjF8b0PKIbMpEOpwCkWfpyvhXiR11nBWWhH
         fBPVp/susk/5nRTNPVcvgCsYJwrkZwva7c/2Han0vjDtZC09FDgI3nGKU8V3QhLnWOsD
         D9YazPifQlkFmVUrF1StMi+GT8J1B16KJD5wJ/dcSzfpYQtrSHfVXedlAUl3AEFpaZRr
         E3OFuS44b61mfNDRMHPtFTiV3UjjdhWCXc1oiNEEI2UfqKc41JvZusJuXL0JplGX1hiA
         GsZe86rlpaRFsMNq2QfubHz0Zoznf50OmGOFaP1DnQlIykxfElkIybDoAXREb9JyjlUN
         uBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HqBHLqwwr+ko0hKn1SGvuqbP8NIUIoixaku53/kbAb0=;
        b=BSOrZDi8M15lrkVby1CGQrjVXoPGk7ayBNSOK5NwHVBMs2L6qyPhpHWM2xrv2WmHep
         opz0x02jOcX4Q4wvaids61/gObBA8PmGQL3DCljwvgvHe3xutqBC6Z+m2t5fkhua+amb
         lHa9CEyv7cm+lWMSyucObswj44TtmwqIe7pwrsGtUMo7/9VFTxZ6RgmUOHgGfrEkjcxL
         WjK9gkZLwhX42/CHVo1eg/kaJtI2c09zO12yLdVFpVWeytQjMNI9vZSVB3XRcVE2Ua7l
         pWnnhe/+Ng3W1tgOLuZCImOU+aiQHgQ5K4bzmFGE9gz3ph8J7iN/Cw6kblxN4HoJSutz
         ot/A==
X-Gm-Message-State: AOAM533VaL1IXDed2XxSyIY1kHf/OxL8DbVZGqhIGkmzl5pGLr5QErwC
        J1cY8qbdTOkfeNL5vrOY6VeNgQ==
X-Google-Smtp-Source: ABdhPJw6U6zsLMUsFT1dmUQxmeij3RvOikJRFdxyw7tUviPjlruquQE5fl4czgRbWBfL4c28GulOvg==
X-Received: by 2002:a63:b246:: with SMTP id t6mr1846077pgo.378.1634800865837;
        Thu, 21 Oct 2021 00:21:05 -0700 (PDT)
Received: from [10.2.24.177] ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id h4sm4396719pgn.6.2021.10.21.00.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 00:21:05 -0700 (PDT)
Subject: Re: Re: Re: [PATCH] x86/kvm: Introduce boot parameter no-kvm-pvipi
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wanpeng Li <wanpengli@tencent.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org
References: <20211020120726.4022086-1-pizhenwei@bytedance.com>
 <CANRm+CxAVA-L0wjm72eohXXWvh9fS7wVFzfKHuEjrsiRFuk9fg@mail.gmail.com>
 <YXB4FHfzh99707EH@google.com>
 <08757159-1673-5c7b-3efc-e5b54e82d6c3@bytedance.com>
 <CANRm+CzcTUWYJeaj3eWKH84YZYgeMZz3kbpn13c8i97iYGGHFQ@mail.gmail.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <5b718b32-cd92-920e-c474-27b9cafeec60@bytedance.com>
Date:   Thu, 21 Oct 2021 15:17:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CzcTUWYJeaj3eWKH84YZYgeMZz3kbpn13c8i97iYGGHFQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/21 1:03 PM, Wanpeng Li wrote:
> On Thu, 21 Oct 2021 at 11:05, zhenwei pi <pizhenwei@bytedance.com> wrote:
>>
>>
>> On 10/21/21 4:12 AM, Sean Christopherson wrote:
>>> On Wed, Oct 20, 2021, Wanpeng Li wrote:
>>>> On Wed, 20 Oct 2021 at 20:08, zhenwei pi <pizhenwei@bytedance.com> wrote:
>>>>>
>>>>> Although host side exposes KVM PV SEND IPI feature to guest side,
>>>>> guest should still have a chance to disable it.
>>>>>
>>>>> A typicall case of this parameter:
>>>>> If the host AMD server enables AVIC feature, the flat mode of APIC
>>>>> get better performance in the guest.
>>>>
>>>> Hmm, I didn't find enough valuable information in your posting. We
>>>> observe AMD a lot before.
>>>> https://lore.kernel.org/all/CANRm+Cx597FNRUCyVz1D=B6Vs2GX3Sw57X7Muk+yMpi_hb+v1w@mail.gmail.com/T/#u
>>>
>>> I too would like to see numbers.  I suspect the answer is going to be that
>>> AVIC performs poorly in CPU overcommit scenarios because of the cost of managing
>>> the tables and handling "failed delivery" exits, but that AVIC does quite well
>>> when vCPUs are pinned 1:1 and IPIs rarely require an exit to the host.
>>>
>>
>> Test env:
>> CPU: AMD EPYC 7642 48-Core Processor
>>
>> Kmod args(enable avic and disable nested):
>> modprobe kvm-amd nested=0 avic=1 npt=1
>>
>> QEMU args(disable x2apic):
>> ... -cpu host,x2apic=off ...
>>
>> Benchmark tool:
>> https://github.com/bytedance/kvm-utils/tree/master/microbenchmark/apic-ipi
>>
>> ~# insmod apic_ipi.ko options=5 && dmesg -c
>>
>>    apic_ipi: 1 NUMA node(s)
>>    apic_ipi: apic [flat]
>>    apic_ipi: apic->send_IPI[default_send_IPI_single+0x0/0x40]
>>    apic_ipi: apic->send_IPI_mask[kvm_send_ipi_mask+0x0/0x10]
>>    apic_ipi:     IPI[kvm_send_ipi_mask] from CPU[0] to CPU[1]
>>    apic_ipi:             total cycles 375671259, avg 3756
>>    apic_ipi:     IPI[flat_send_IPI_mask] from CPU[0] to CPU[1]
>>    apic_ipi:             total cycles 221961822, avg 2219
>>
>>
>> apic->send_IPI_mask[kvm_send_ipi_mask+0x0/0x10]
>>     -> This line show current send_IPI_mask is kvm_send_ipi_mask(because
>> of PV SEND IPI FEATURE)
>>
>> apic_ipi:       IPI[kvm_send_ipi_mask] from CPU[0] to CPU[1]
>> apic_ipi:               total cycles 375671259, avg 3756
>>     -->These lines show the average cycles of each kvm_send_ipi_mask: 3756
>>
>> apic_ipi:       IPI[flat_send_IPI_mask] from CPU[0] to CPU[1]
>> apic_ipi:               total cycles 221961822, avg 2219
>>     -->These lines show the average cycles of each flat_send_IPI_mask: 2219
> 
> Just single target IPI is not eough.
> 
>      Wanpeng
> 

Benchmark smp_call_function_single 
(https://github.com/bytedance/kvm-utils/blob/master/microbenchmark/ipi-bench/ipi_bench.c):

  Test env:
  CPU: AMD EPYC 7642 48-Core Processor

  Kmod args(enable avic and disable nested):
  modprobe kvm-amd nested=0 avic=1 npt=1

  QEMU args(disable x2apic):
  ... -cpu host,x2apic=off ...

1> without no-kvm-pvipi:
ipi_bench_single wait[1], CPU0[NODE0] -> CPU1[NODE0], loop = 100000
      elapsed =        424945631 cycles, average =     4249 cycles
      ipitime =        385246136 cycles, average =     3852 cycles
ipi_bench_single wait[0], CPU0[NODE0] -> CPU1[NODE0], loop = 100000
      elapsed =        419057953 cycles, average =     4190 cycles

2> with no-kvm-pvipi:
ipi_bench_single wait[1], CPU0[NODE0] -> CPU1[NODE0], loop = 100000
      elapsed =        321756407 cycles, average =     3217 cycles
      ipitime =        299433550 cycles, average =     2994 cycles
ipi_bench_single wait[0], CPU0[NODE0] -> CPU1[NODE0], loop = 100000
      elapsed =        295382146 cycles, average =     2953 cycles


-- 
zhenwei pi
