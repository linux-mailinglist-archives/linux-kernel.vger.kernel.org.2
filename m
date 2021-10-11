Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940B2428622
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 07:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbhJKFM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 01:12:26 -0400
Received: from mail.loongson.cn ([114.242.206.163]:59776 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230152AbhJKFMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 01:12:25 -0400
Received: from [10.180.13.145] (unknown [10.180.13.145])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxD2s6x2NhleMXAA--.22022S2;
        Mon, 11 Oct 2021 13:10:19 +0800 (CST)
Subject: Re: [PATCH v3] usb: ohci: add check for host controller functional
 states
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
References: <1633677970-10619-1-git-send-email-zhuyinbo@loongson.cn>
 <20211008142639.GA721194@rowland.harvard.edu>
 <7a505fc4-ec47-ac83-633f-7a5251bd5f82@loongson.cn>
 <20211009193901.GA753830@rowland.harvard.edu>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <adc67ae2-e162-a427-a8a9-7df55c92a00c@loongson.cn>
Date:   Mon, 11 Oct 2021 13:10:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20211009193901.GA753830@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9DxD2s6x2NhleMXAA--.22022S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr4UWF18CFWkZF43ZFWxtFb_yoW7AFWfpa
        1IkF43KrWDAF10vwnrtr1kKr9Yk3y7G3y5GryDCFW8AwnxXrySgr4IgrWY9a95XrWfK3W7
        ZF10gayUu34UCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv0b7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY
        02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU5
        PpnJUUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/10/10 上午3:39, Alan Stern 写道:
> On Sat, Oct 09, 2021 at 10:01:25AM +0800, zhuyinbo wrote:
>> 在 2021/10/8 下午10:26, Alan Stern 写道:
>>> On Fri, Oct 08, 2021 at 03:26:10PM +0800, Yinbo Zhu wrote:
>>>> The usb states of ohci controller include UsbOperational, UsbReset,
>>>> UsbSuspend and UsbResume. Among them, only the UsbOperational state
>>>> supports launching the start of frame for host controller according
>>>> the ohci protocol spec, but in S3/S4 press test procedure, it may
>>> Nobody reading this will know what "S3/S4 press test procedure" means.
>>> You have to explain it, or use a different name that people will
>>> understand.
>> okay, I got it.
>>>> happen that the start of frame was launched in other usb states and
>>>> cause ohci works abnormally then kernel will allways report rcu
>>>> call trace. This patch was to add check for host controller
>>>> functional states and if it is not UsbOperational state that need
>>>> set INTR_SF in intrdisable register to ensure SOF Token generation
>>>> was been disabled.
>>> This doesn't make sense.  You already mentioned that only the
>>> UsbOperational state supports sending start-of-frame packets.  So if the
>>> controller is in a different state then it won't send these packets,
>>> whether INTR_SF is enabled or not.
>>>
>>> What problem are you really trying to solve?
>> Only UsbOperational state supports sending start-of-frame packets, but in
>> fact, in S3/S4 press test procedure,
>>
>> usb in non-UsbOperational state that send start-of-frame packets but hc
>> driver doesn't deal with this frame. and hc will
>>
>> allways lauched the SOF for finishing the frame, the cpu will hand this sof
>> interrupt and doesn't deal with time interrupt
>>
>> that will cause rcu call trace then system doesn't suspend to memory/disk.
> I still don't understand.
>
> Are you saying that your OHCI controller behaves badly because it sends
> SOF packets even when the state is different from UsbOperational?

HC will allways report the SoF interrupt in the all time when HC was not 
in NO-UsbOperation state.

and no WritebackDoneHead interrupt that is the issue phenomenon. and 
this situation is badly state for ohci.

>
>> Hi Alan Stern,
>>
>>      even though ed_rm_list is non-NULL, if hc in non-UsbOperation state set
>> SoF status in usbsts register that is illegal,
>>
>> at this time hcd doesn't need care URB whether finished,  because hc had
>> into a wrong state. even thoug it doesn't has this patch,
>>
>> URB was not be able to finish when hc in above worng state. except software
>> can intervence this wrong state. but the SoF bit of usbsts
>>
>> register was set by HC, and this action will happen always !!! software
>> clear SoF state I think it isn't make sense. software only disable SoF
>>
>> interrupt to fix HC wrong state.
> This problem happens when you go into S3 or S4 suspend, right?  So you
> should fix the problem by disabling INTR_SF when the root hub is
> suspended.  Try adding
>
> 	/* All ED unlinks should be finished, no need for SOF interrupts */
> 	ohci_writel(ohci, OHCI_INTR_SF, &ohci->regs->intrdisable);
>
> into ohci_rh_suspend(), just before the update_done_list() call.  If you
> add this then INTR_SF will not be enabled during S3 or S4 suspend, so
> the problem shouldn't occur.  Does that work for you?

The system doesn't suspend to disk completely by my test result and hc 
will always produce SoF interrupt.

I encountered SoF interrupt  issue when HC in UsbSuspend state. and I 
think when hc in

UsbResume/UsbRest/ SoF interrupt issue may be happen so I disable 
INTR_SF in ohci_irq.

So I think disable INTR_SF in suspend function which this way isn't good 
for me.

     In addition, I hope my patch was not only fix the bug i encountered 
and it can limit HC into badly state and it should be the

base limit condition and prevent more unknown problems.  In fact, HC 
doesn't deal with ed/td list and done list by the ohci spec, so

I think my patch has no risk for ohci.

       by the way, root hub state isn't completely same with HC, but the 
root hub reset and resume signaling are controlled by the hcfs bits.

and hcd can set hcfs to decide hc usb state, so I judge whether set 
SF_INT to interrupt disable register only depend on HC state.

>
>>        In additon, when kernel include my patch, that it does't happen about
>> what you descriped that driver will not be able to finish unlinging URBs.
>>
>> Because above issue happen in S3/S4(Suspend to disk/Suspend to mem) test
>> procedure, if ed_rm_lis is no-NULL but my patch disable SoF interrupt.
>>
>> then when S3/S4 recovery to cpu idle state that usb resume will be called,
>> reume function has following logic, URB will continue to be processed.
>>
>>        static int ohci_rh_resume (struct ohci_hcd *ohci)
>>
>>       {
>>
>>          ...
>>
>>          242         if (ohci->ed_rm_list)
>>          243                 ohci_writel (ohci, OHCI_INTR_SF,
>> &ohci->regs->intrenable);
>>
>>         ...
>>
>>        }
> I'm worried that your patch may disable INTR_SF even when the controller
> has not gone into S3 or S4 suspend.  Maybe this won't cause problems,
> but it's better to be safe and do the disable _only_ when a suspend
> occurs.
>
> Alan Stern

Hi  Alan Stern,

     According to the previous statement, I think my patch has no risk 
on ohci.




