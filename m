Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFC4361714
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 03:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbhDPBOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 21:14:25 -0400
Received: from regular1.263xmail.com ([211.150.70.195]:55072 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235109AbhDPBOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 21:14:24 -0400
Received: from localhost (unknown [192.168.167.172])
        by regular1.263xmail.com (Postfix) with ESMTP id AA5E61CB4;
        Fri, 16 Apr 2021 09:13:39 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P18449T140669553202944S1618535618574890_;
        Fri, 16 Apr 2021 09:13:39 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <f8360a91e61024aadd0a1e46da1be00b>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 6
X-SENDER-IP: 58.22.7.114
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
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <8d2e22f5-1c1b-e795-8757-ae078446d961@rock-chips.com>
Date:   Fri, 16 Apr 2021 09:13:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87k0p4m0gm.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2021/4/15 下午4:11, Marc Zyngier wrote:
> Hi Kever,
>
> On Thu, 15 Apr 2021 08:24:33 +0100,
> Kever Yang <kever.yang@rock-chips.com> wrote:
>> Hi Marc, Peter,
>>
>>      RK356x GIC has two issues:
>>
>> 1. GIC only support 32bit address while rk356x supports 8GB DDR SDRAM,
>> so we use ZONE_DMA32 to fix this issue;
> What transactions does this affect exactly?
The GIC on rk356x is a 32bit master, which means all the space its logic 
need to access should be in the 4GB range.
> Only some ITS tables? Or
> all of them, including the command queue? What about the configuration
> and pending tables associated with the redistributors?
>
>> 2. GIC version is r1p6-00rel0, RK356x interconnect does not support
>> GIC and CPU snoop to each other, hence the GIC does not support the
>> shareability feature.  The read of register value for shareability
>> feature does not return as expect in GICR and GITS, so we have to
>> workaround for it.
> How about the cacheability attribute? Can you please provide the exact
> set of attributes that this system actually supports for each of the
> ITS and redistributor base registers?

The shareability attributes in GICR_PENDBASEER, GICR_PROPBASER, 
GITS_BASERn, GITS_CBASER default value is 0b00, when we set 0b01 then 
read returns 0b01.

Since there is no ACE coherency interface for this GIC controller, all 
the cacheability in the GIC is not support in hardware.

>
> Also, please provide errata numbers for these two issues so that we
> can properly document them and track the workarounds.

What kind of errata do you need, could you please share any kind of 
example close to this case?

We consider this as a SoC implement design instead of a bug, so we will 
add document in RK356X  TRM to describe the GIC design, but no idea how 
to provide the errata.

Here is the shareabily attribute from ARM GIC architecture specification:
Shareability, bits [11:10] (from GITS_CBASER)
Indicates the Shareability attributes of accesses to the command queue. 
The possible values of this field are:
0b00 Non-shareable.
0b01 Inner Shareable.
0b10 Outer Shareable.
0b11 Reserved. Treated as 0b00.
It is IMPLEMENTATION DEFINED whether this field has a fixed value or can 
be programmed by software. Implementing this field with a fixed value is 
deprecated.
On a Warm reset, this field resets to an architecturally UNKNOWN value

As you can see, "Implementing this field with a fixed value is 
deprecated", so software should program this field to '0b00 
Non-shareable' if the SoC design does not support the cache shareability.

Thanks,
- Kever
>
> Thanks,
>
> 	M.
>


