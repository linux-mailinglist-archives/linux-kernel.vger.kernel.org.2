Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACC436035F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 09:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhDOHc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 03:32:27 -0400
Received: from regular1.263xmail.com ([211.150.70.202]:33044 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhDOHcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 03:32:25 -0400
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Apr 2021 03:32:25 EDT
Received: from localhost (unknown [192.168.167.223])
        by regular1.263xmail.com (Postfix) with ESMTP id 741F1705;
        Thu, 15 Apr 2021 15:24:34 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.120] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P10011T140596022867712S1618471472993643_;
        Thu, 15 Apr 2021 15:24:33 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <b802ba564036979c4ab26e08981c3180>
X-RL-SENDER: kever.yang@rock-chips.com
X-SENDER: yk@rock-chips.com
X-LOGIN-NAME: kever.yang@rock-chips.com
X-FST-TO: heiko@sntech.de
X-RCPT-COUNT: 6
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [RFC] ITS fails to allocate on rk3568/rk3566
To:     Marc Zyngier <maz@kernel.org>, Peter Geis <pgwipeout@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
From:   Kever Yang <kever.yang@rock-chips.com>
Message-ID: <678e9950-dd85-abb2-a104-07a4db1fad49@rock-chips.com>
Date:   Thu, 15 Apr 2021 15:24:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <871rbdt4tu.wl-maz@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc, Peter,

     RK356x GIC has two issues:

1. GIC only support 32bit address while rk356x supports 8GB DDR SDRAM, 
so we use ZONE_DMA32 to fix this issue;

2. GIC version is r1p6-00rel0, RK356x interconnect does not support GIC 
and CPU snoop to each other, hence the GIC does not support the 
shareability feature.  The read of register value for shareability  
feature does not return as expect in GICR and GITS, so we have to 
workaround for it.

Thanks,
- Kever
On 2021/4/14 下午8:42, Marc Zyngier wrote:
> On Wed, 14 Apr 2021 12:41:20 +0100,
> Peter Geis <pgwipeout@gmail.com> wrote:
>> On Tue, Apr 13, 2021 at 11:51 AM Marc Zyngier <maz@kernel.org> wrote:
>>> On Tue, 13 Apr 2021 16:03:51 +0100,
>>> Peter Geis <pgwipeout@gmail.com> wrote:
>>>> On Tue, Apr 13, 2021 at 10:01 AM Marc Zyngier <maz@kernel.org> wrote:
>>> [...]
>>>
>>>>> What happens if you hack all the allocations to happen in the low 4GB
>>>>> of the PA space?
>>>> It seems to work correctly.
>>>> The downstream hacks used GFP_DMA32 which gets discarded by
>>>> kmalloc_fix_flags on certain allocations.
>>>> Switching to GFP_DMA seems to have satisfied it, but it feels wrong
>>>> using this code.
>>>> Need to check the corner cases to make sure I'm not missing something.
>>> The problem is that GFP_DMA doesn't always mean the same thing.
>>> Overall, we need to hear from Rockchip about the exact nature of the
>>> problem, and then we *may* be able to work something out.
>>  From what I've read, GFP_DMA allocates as low as possible, while
>> GFP_DMA32 ensures it's in the 32 bit address range, am I understanding
>> this correctly?
> ZONE_DMA{,32} aren't necessarily selected, and can vary in size (some
> equally broken systems can only DMA over 30bits...).
>
>> Is there a reason GFP_DMA is permitted while GFP_DMA32 is not, aside
>> from backwards compatibility?  (I saw the notes about how we aren't
>> really supposed to rely on these flags)
> They are completely independent, and they can either be selected or
> not. And plenty of systems do not have any memory in the low
> 4GB. FWIW, one of my main machines has its first byte of RAM at 1TB.
>
> Which means that supporting this system is going to require some very
> specific handling.
>
>> I've also confirmed that their disabling shareability and caching is
>> necessary.
> Confirmed how? For which tables? We really cannot guess this kind of
> thing.
>
>>> I'd also like to understand whether it is broken because you happen to
>>> have pre-release silicon that will never make it into the wild, or if
>>> this is the real thing that is going to ship on millions of devices.
>> My understanding is these chips are samples prior to the full
>> production run, but we are waiting on official comment from Rockchip
>> about this particular errata.
> OK. Please let me know once you get a full description of the problem
> from Rockchip. We will also need an official erratum number for this
> if this is to be worked around in mainline.
>
> 	M.
>


