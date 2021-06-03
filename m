Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A44039A080
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 14:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhFCMGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 08:06:09 -0400
Received: from foss.arm.com ([217.140.110.172]:39602 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFCMGI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 08:06:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B0451063;
        Thu,  3 Jun 2021 05:04:23 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 644973F774;
        Thu,  3 Jun 2021 05:04:22 -0700 (PDT)
Subject: Re: [BUG] usb: dwc3: Kernel NULL pointer dereference in dwc3_remove()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@kernel.org>, p.zabel@pengutronix.de,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        sanm@codeaurora.org
References: <c3c75895-313a-5be7-6421-b32bac741a88@arm.com>
 <87r1hjcvf6.fsf@kernel.org> <70be179c-d36b-de6f-6efc-2888055b1312@arm.com>
 <YLi/u9J5f+nQO4Cm@kroah.com>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <8272121c-ac8a-1565-a047-e3a16dcf13b0@arm.com>
Date:   Thu, 3 Jun 2021 13:05:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <YLi/u9J5f+nQO4Cm@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 6/3/21 12:40 PM, Greg Kroah-Hartman wrote:
> On Thu, Jun 03, 2021 at 11:41:45AM +0100, Alexandru Elisei wrote:
>> Hello Felipe,
>>
>> Thank you for having a look!
>>
>> On 6/3/21 7:30 AM, Felipe Balbi wrote:
>>> Hi,
>>>
>>> Alexandru Elisei <alexandru.elisei@arm.com> writes:
>>>> I've been seeing the following panic when shutting down my rockpro64:
>>>>
>>>> [ï¿½ï¿½ 21.459064] xhci-hcd xhci-hcd.0.auto: USB bus 5 deregistered
>>>> [ï¿½ï¿½ 21.683077] Unable to handle kernel NULL pointer dereference at virtual address
>>>> 00000000000000a0
>>>> [ï¿½ï¿½ 21.683858] Mem abort info:
>>>> [ï¿½ï¿½ 21.684104]ï¿½ï¿½ ESR = 0x96000004
>>>> [ï¿½ï¿½ 21.684375]ï¿½ï¿½ EC = 0x25: DABT (current EL), IL = 32 bits
>>>> [ï¿½ï¿½ 21.684841]ï¿½ï¿½ SET = 0, FnV = 0
>>>> [ï¿½ï¿½ 21.685111]ï¿½ï¿½ EA = 0, S1PTW = 0
>>>> [ï¿½ï¿½ 21.685389] Data abort info:
>>>> [ï¿½ï¿½ 21.685644]ï¿½ï¿½ ISV = 0, ISS = 0x00000004
>>>> [ï¿½ï¿½ 21.686024]ï¿½ï¿½ CM = 0, WnR = 0
>>>> [ï¿½ï¿½ 21.686288] user pgtable: 4k pages, 48-bit VAs, pgdp=000000000757a000
>>>> [ï¿½ï¿½ 21.686853] [00000000000000a0] pgd=0000000000000000, p4d=0000000000000000
>>>> [ï¿½ï¿½ 21.687452] Internal error: Oops: 96000004EEMPT SMP
>>>> [ï¿½ï¿½ 21.687941] Modules linked in:
>>>> [ï¿½ï¿½ 21.688214] CPU: 4 PID: 1 Comm: shutdown Not tainted
>>>> 5.12.0-rc7-00262-g568262bf5492 #33
>>>> [ï¿½ï¿½ 21.688915] Hardware name: Pine64 RockPro64 v2.0 (DT)
>>>> [ï¿½ï¿½ 21.689357] pstate: 60000005 (nZCv daif -PAN -UAO -TCO BTYPE=--)
>>>> [ï¿½ï¿½ 21.689884] pc : down_read_interruptible+0xec/0x200
>>>> [ï¿½ï¿½ 21.690321] lr : simple_recursive_removal+0x48/0x280
>>>> [ï¿½ï¿½ 21.690761] sp : ffff800011f4b940
>>>> [ï¿½ï¿½ 21.691053] x29: ffff800011f4b940 x28: ffff000000809b40
>>>> [ï¿½ï¿½ 21.691522] x27: ffff000000809b98 x26: ffff8000114f5170
>>>> [ï¿½ï¿½ 21.691990] x25: 00000000000000a0 x24: ffff800011e84030
>>>> [ï¿½ï¿½ 21.692459] x23: 0000000000000080 x22: 0000000000000000
>>>> [ï¿½ï¿½ 21.692927] x21: ffff800011ecaa5c x20: ffff800011ecaa60
>>>> [ï¿½ï¿½ 21.693395] x19: ffff000000809b40 x18: ffffffffffffffff
>>>> [ï¿½ï¿½ 21.693863] x17: 0000000000000000 x16: 0000000000000000
>>>> [ï¿½ï¿½ 21.694331] x15: ffff800091f4ba6d x14: 0000000000000004
>>>> [ï¿½ï¿½ 21.694799] x13: 0000000000000000 x12: 0000000000000020
>>>> [ï¿½ï¿½ 21.695267] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
>>>> [ï¿½ï¿½ 21.695735] x9 : 6f6c746364716e62 x8 : 7f7f7f7f7f7f7f7f
>>>> [ï¿½ï¿½ 21.696203] x7 : fefefeff6364626d x6 : 0000000000001bd8
>>>> [ï¿½ï¿½ 21.696671] x5 : 0000000000000000 x4 : 0000000000000000
>>>> [ï¿½ï¿½ 21.697138] x3 : 00000000000000a0 x2 : 0000000000000001
>>>> [ï¿½ï¿½ 21.697606] x1 : 0000000000000000 x0 : 00000000000000a0
>>>> [ï¿½ï¿½ 21.698075] Call trace:
>>>> [ï¿½ï¿½ 21.698291]ï¿½ down_read_interruptible+0xec/0x200
>>>> [ï¿½ï¿½ 21.698690]ï¿½ debugfs_remove+0x60/0x84
>>>> [ï¿½ï¿½ 21.699016]ï¿½ dwc3_debugfs_exit+0x1c/0x6c
>>>> [ï¿½ï¿½ 21.699363]ï¿½ dwc3_remove+0x34/0x1a0
>>>> [ï¿½ï¿½ 21.699672]ï¿½ platform_remove+0x28/0x60
>>>> [ï¿½ï¿½ 21.700005]ï¿½ __device_release_driver+0x188/0x230
>>>> [ï¿½ï¿½ 21.700414]ï¿½ device_release_driver+0x2c/0x44
>>>> [ï¿½ï¿½ 21.700791]ï¿½ bus_remove_device+0x124/0x130
>>>> [ï¿½ï¿½ 21.701154]ï¿½ device_del+0x168/0x420
>>>> [ï¿½ï¿½ 21.701462]ï¿½ platform_device_del.part.0+0x1c/0x90
>>>> [ï¿½ï¿½ 21.701877]ï¿½ platform_device_unregister+0x28/0x44
>>>> [ï¿½ï¿½ 21.702291]ï¿½ of_platform_device_destroy+0xe8/0x100
>>>> [ï¿½ï¿½ 21.702716]ï¿½ device_for_each_child_reverse+0x64/0xb4
>>>> [ï¿½ï¿½ 21.703153]ï¿½ of_platform_depopulate+0x40/0x84
>>>> [ï¿½ï¿½ 21.703538]ï¿½ __dwc3_of_simple_teardown+0x20/0xd4
>>>> [ï¿½ï¿½ 21.703945]ï¿½ dwc3_of_simple_shutdown+0x14/0x20
>>>> [ï¿½ï¿½ 21.704337]ï¿½ platform_shutdown+0x28/0x40
>>>> [ï¿½ï¿½ 21.704683]ï¿½ device_shutdown+0x158/0x330
>>>> [ï¿½ï¿½ 21.705029]ï¿½ kernel_power_off+0x38/0x7c
>>>> [ï¿½ï¿½ 21.705372]ï¿½ __do_sys_reboot+0x16c/0x2a0
>>>> [ï¿½ï¿½ 21.705719]ï¿½ __arm64_sys_reboot+0x28/0x34
>>>> [ï¿½ï¿½ 21.706074]ï¿½ el0_svc_common.constprop.0+0x60/0x120
>>>> [ï¿½ï¿½ 21.706499]ï¿½ do_el0_svc+0x28/0x94
>>>> [ï¿½ï¿½ 21.706794]ï¿½ el0_svc+0x2c/0x54
>>>> [ï¿½ï¿½ 21.707067]ï¿½ el0_sync_handler+0xa4/0x130
>>>> [ï¿½ï¿½ 21.707414]ï¿½ el0_sync+0x170/0x180
>>>> [ï¿½ï¿½ 21.707711] Code: c8047c62 35ffff84 17fffe5f f9800071 (c85ffc60)
>>>> [ï¿½ï¿½ 21.708250] ---[ end trace 5ae08147542eb468 ]---
>>>> [ï¿½ï¿½ 21.708667] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
>>>> [ï¿½ï¿½ 21.709456] Kernel Offset: disabled
>>>> [ï¿½ï¿½ 21.709762] CPU features: 0x00240022,2100600c
>>>> [ï¿½ï¿½ 21.710146] Memory Limit: 2048 MB
>>>> [ï¿½ï¿½ 21.710443] ---[ end Kernel panic - not syncing: Attempted to kill init!
>>>> exitcode=0x0000000b ]---
>>>>
>>>> I've been able to bisect the panic and the offending commit is 568262bf5492 ("usb:
>>>> dwc3: core: Add shutdown callback for dwc3"). I can provide more diagnostic
>>>> information if needed and I can help test the fix.
>>> if you simply revert that commit in HEAD, does the problem really go
>>> away?
>> Kernel built from commit 324c92e5e0ee, which is the kernel tip today, the panic is
>> there. Reverting the offending commit, 568262bf5492, makes the panic disappear.
> Want to send a revert so I can take it now?

I can send a revert, but Felipe was asking Sandeep (the commit author) for a fix,
so I'll leave it up to Felipe to decide how to proceed.

Thanks,

Alex

