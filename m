Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30CE366369
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 03:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbhDUBlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 21:41:42 -0400
Received: from regular1.263xmail.com ([211.150.70.196]:34738 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbhDUBll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 21:41:41 -0400
Received: from localhost (unknown [192.168.167.32])
        by regular1.263xmail.com (Postfix) with ESMTP id 5ADEE1FB7;
        Wed, 21 Apr 2021 09:40:34 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [192.168.60.65] (unknown [103.29.142.67])
        by smtp.263.net (postfix) whith ESMTP id P18573T140528554710784S1618969227797629_;
        Wed, 21 Apr 2021 09:40:33 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <5db166d1d96e10a4db9cac74f19984fa>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 6
X-SENDER-IP: 103.29.142.67
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [RFC] ITS fails to allocate on rk3568/rk3566
To:     Marc Zyngier <maz@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>
References: <CAMdYzYrQ5f-mv_VmTq_CRf9tR=j3mwRpKHNLmPFgCF9whsGFRw@mail.gmail.com>
 <871rbeo7wf.wl-maz@kernel.org>
 <CAMdYzYruPyiT89FrbJhuV=c36PyRwZ7sT45abnv8rTv85AKRow@mail.gmail.com>
 <87y2dmmggt.wl-maz@kernel.org>
 <CAMdYzYrNa_wJa9mvBkhDrvdNaDugR9Y=LEnbcVHxjxJS0UFcMg@mail.gmail.com>
 <87tuoambdb.wl-maz@kernel.org>
 <CAMdYzYo2+h+=39cw1t=11HUih-O+NUs4hhNaPbrU6si-AbqNiA@mail.gmail.com>
 <871rbdt4tu.wl-maz@kernel.org>
 <678e9950-dd85-abb2-a104-07a4db1fad49@rock-chips.com>
 <87k0p4m0gm.wl-maz@kernel.org>
 <8d2e22f5-1c1b-e795-8757-ae078446d961@rock-chips.com>
 <878s5i2qyw.wl-maz@kernel.org>
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <2791594e-db60-e1d0-88e5-7e5bbd98ae4d@rock-chips.com>
Date:   Wed, 21 Apr 2021 09:40:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <878s5i2qyw.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2021/4/16 下午11:23, Marc Zyngier wrote:
> On Fri, 16 Apr 2021 02:13:38 +0100,
> Kever Yang <kever.yang@rock-chips.com> wrote:
>> Hi Marc,
>>
>> On 2021/4/15 下午4:11, Marc Zyngier wrote:
>>> Hi Kever,
>>>
>>> On Thu, 15 Apr 2021 08:24:33 +0100,
>>> Kever Yang <kever.yang@rock-chips.com> wrote:
>>>> Hi Marc, Peter,
>>>>
>>>>       RK356x GIC has two issues:
>>>>
>>>> 1. GIC only support 32bit address while rk356x supports 8GB DDR SDRAM,
>>>> so we use ZONE_DMA32 to fix this issue;
>>> What transactions does this affect exactly?
>> The GIC on rk356x is a 32bit master, which means all the space its
>> logic need to access should be in the 4GB range.
> Well, at least this is consistently broken.

There are many legacy IPs which only support 32bit bus, we have to use 
them as is in the new

64bit SoCs, I think the 32bit GIC can be considered the same as those 
case, can we add CONFIG_ZONE_DMA32

support in GIC driver?

eg. Other peripheral driver use dma_alloc_coherent() instead of 
alloc_pages(), so then can support

ZONE_DMA32 without any code change.


>>> Only some ITS tables? Or
>>> all of them, including the command queue? What about the configuration
>>> and pending tables associated with the redistributors?
>>>
>>>> 2. GIC version is r1p6-00rel0, RK356x interconnect does not support
>>>> GIC and CPU snoop to each other, hence the GIC does not support the
>>>> shareability feature.  The read of register value for shareability
>>>> feature does not return as expect in GICR and GITS, so we have to
>>>> workaround for it.
>>> How about the cacheability attribute? Can you please provide the exact
>>> set of attributes that this system actually supports for each of the
>>> ITS and redistributor base registers?
>> The shareability attributes in GICR_PENDBASEER, GICR_PROPBASER,
>> GITS_BASERn, GITS_CBASER default value is 0b00, when we set 0b01 then
>> read returns 0b01.
> And I claim that this is a perfectly broken behaviour. How do you
> expect software to find about the gory details of the integration?
> That's the only way for SW to find out what the HW is capable of...

As a software engineer, I totally agree with you on this point, but when 
we back to the truth,

we should know that these registers has never been defined as "module 
capability for shareability"

in hardware. The software use it as capability detect, and it works 
before, but not means this

match the original hardware design, in this case the new hardware may 
not follow the legacy

design because it's not a standard or a clear enough guide for it.

The capability register should always read-only instead of read-write, 
the understanding from

software engineer and from hardware engineer always have a gap.

I would proposal to add a optional dts property for driver to identify 
if the board's GIC support

shareability or not, which is a method used by many other module drivers.

>> Since there is no ACE coherency interface for this GIC controller, all
>> the cacheability in the GIC is not support in hardware.
>>
>>> Also, please provide errata numbers for these two issues so that we
>>> can properly document them and track the workarounds.
>> What kind of errata do you need, could you please share any kind of
>> example close to this case?
> I would like something that says:
>
> "ROCKCHIP_ERRATUM_123456: The GIC600 integration in RK356x doesn't
>   support any of the shareability or cacheability attributes, and
>   requires both values to be set to 0b00 for all the ITS and
>   Redistributor tables."
>
> This is pretty similar to the bug affecting ThunderX with its "erratum
> 24313" (covered by CONFIG_CAVIUM_ERRATUM_22375), where the tables have
> to be flagged as non-cacheable. The Rockchip one is just worse.
>
> We need an official erratum number so that we can refer to it in the
> source, commit log and documentation, as well as cross-reference it
> with the TRM. This number will be part of a configuration symbol that
> will make the compilation conditional so that people don't have to
> carry the extra burden generated by this bug if they don't need to.
>
> Same thing goes for the 32bit bug.
>
>> We consider this as a SoC implement design instead of a bug, so we
>> will add document in RK356X  TRM to describe the GIC design, but no
>> idea how to provide the errata.
>>
>> Here is the shareabily attribute from ARM GIC architecture specification:
>> Shareability, bits [11:10] (from GITS_CBASER)
>> Indicates the Shareability attributes of accesses to the command
>> queue. The possible values of this field are:
>> 0b00 Non-shareable.
>> 0b01 Inner Shareable.
>> 0b10 Outer Shareable.
>> 0b11 Reserved. Treated as 0b00.
>> It is IMPLEMENTATION DEFINED whether this field has a fixed value or
>> can be programmed by software. Implementing this field with a fixed
>> value is deprecated.
>> On a Warm reset, this field resets to an architecturally UNKNOWN value
>>
>> As you can see, "Implementing this field with a fixed value is
>> deprecated", so software should program this field to '0b00
>> Non-shareable' if the SoC design does not support the cache
>> shareability.
> [I really feel special when people quote the GIC spec at me]
>
> That isn't what it says. Hardcoding the field with a fixed value is
> indeed deprecated, but that doesn't mean this field should accept
> values that the HW cannot support. If anything, what this says is "try
> and implement the options that SW is going to use".
>
> But you need to give SW an indication of what is usable, because there
> is no other way to *discover* what the SoC is capable of at runtime.
> Otherwise, we would need to carry a per-SoC list of what the HW
> supports. I don't think that's the right thing to do (and you're about
> 8 years too late anyway).
>
> Other GIC600 integrations got it perfectly right, by the way. Same for
> other GIC implementations, with the notable exception of Cavium and
> their first GIC in ThunderX, as described above.

I'm not sure if you still work for ARM or not, but we do have double 
check again and again

with IP vendor about this point, the GIC500 works because it's hardware 
bind to a fix value inside the IP,

but GIC600 does not do the same binding, and there is no any config 
option to hardcode the reg field

to a fixed value in the IP when we don't need the ACE-lite.

This is why I insist that this is a different SoC implementation instead 
of a SoC bug, we should add the

support in the GIC driver for different hardware case.

When you say we're about 8 years too late, I think there still not much 
SoCs using GIC600, maybe the GIC600 IP

is available for user at mid of 2017?


Thanks,
- Kever
>
> Thanks,
>
> 	M.
>


