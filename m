Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5A6429F98
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 10:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234716AbhJLISN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 04:18:13 -0400
Received: from mail.loongson.cn ([114.242.206.163]:57180 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234707AbhJLISM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 04:18:12 -0400
Received: from [10.180.13.145] (unknown [10.180.13.145])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxL2s_RGVhTpcYAA--.37061S2;
        Tue, 12 Oct 2021 16:15:59 +0800 (CST)
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
 <adc67ae2-e162-a427-a8a9-7df55c92a00c@loongson.cn>
 <20211011161732.GA822456@rowland.harvard.edu>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <e8aef4ff-5d5c-9330-a736-aa3586cba0ca@loongson.cn>
Date:   Tue, 12 Oct 2021 16:15:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20211011161732.GA822456@rowland.harvard.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9DxL2s_RGVhTpcYAA--.37061S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWxAw1kKw1kWw1fKw4rZrb_yoW7JryrpF
        W2kanaka1DJr1FvrnFqw1kKr9Y9rW7t3y5Wr98CrW7Awn0q34agrs7KrWrCa95WrySg3W7
        ZF4j9ay3Ww4UAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvYb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l
        c2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
        twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AK
        xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07
        bOoGdUUUUU=
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/10/12 上午12:17, Alan Stern 写道:
> On Mon, Oct 11, 2021 at 01:10:18PM +0800, zhuyinbo wrote:
>> 在 2021/10/10 上午3:39, Alan Stern 写道:
>>> On Sat, Oct 09, 2021 at 10:01:25AM +0800, zhuyinbo wrote:
>>>> 在 2021/10/8 下午10:26, Alan Stern 写道:
>>>>> On Fri, Oct 08, 2021 at 03:26:10PM +0800, Yinbo Zhu wrote:
>>>>>> The usb states of ohci controller include UsbOperational, UsbReset,
>>>>>> UsbSuspend and UsbResume. Among them, only the UsbOperational state
>>>>>> supports launching the start of frame for host controller according
>>>>>> the ohci protocol spec, but in S3/S4 press test procedure, it may
>>>>> Nobody reading this will know what "S3/S4 press test procedure" means.
>>>>> You have to explain it, or use a different name that people will
>>>>> understand.
>>>> okay, I got it.
>>>>>> happen that the start of frame was launched in other usb states and
>>>>>> cause ohci works abnormally then kernel will allways report rcu
>>>>>> call trace. This patch was to add check for host controller
>>>>>> functional states and if it is not UsbOperational state that need
>>>>>> set INTR_SF in intrdisable register to ensure SOF Token generation
>>>>>> was been disabled.
>>>>> This doesn't make sense.  You already mentioned that only the
>>>>> UsbOperational state supports sending start-of-frame packets.  So if the
>>>>> controller is in a different state then it won't send these packets,
>>>>> whether INTR_SF is enabled or not.
>>>>>
>>>>> What problem are you really trying to solve?
>>>> Only UsbOperational state supports sending start-of-frame packets, but in
>>>> fact, in S3/S4 press test procedure,
>>>>
>>>> usb in non-UsbOperational state that send start-of-frame packets but hc
>>>> driver doesn't deal with this frame. and hc will
>>>>
>>>> allways lauched the SOF for finishing the frame, the cpu will hand this sof
>>>> interrupt and doesn't deal with time interrupt
>>>>
>>>> that will cause rcu call trace then system doesn't suspend to memory/disk.
>>> I still don't understand.
>>>
>>> Are you saying that your OHCI controller behaves badly because it sends
>>> SOF packets even when the state is different from UsbOperational?
>> HC will allways report the SoF interrupt in the all time when HC was not in
>> NO-UsbOperation state.
> How did your host controller get into the non-UsbOperational state?
> What part of the code is responsible for changing to a different state?
>
> It looks like the only place where this could happen is in
> ohci_rh_suspend().  So if you disable SOF interrupts there, it should
> fix your problem.

in fact, I want to consider all non-UsbOperational state for my patch, 
as for UsbSuspend state and my issue that

your advice is the pefect solution, and apply for the change according 
to your advice, it can fix my problem by my test.

in addition, I got the non-UsbOperationnal state was by read hcfs bits 
in ohci control register, for the UsbSuspend status that

it is only changed in ohci_rh_suspend. and other states was changed in 
multiple place that seems disable sof interrupt was only

in ohci_irq. but if you still think it  has risk i want to following 
your advice and as it v5 version.

>
>> and no WritebackDoneHead interrupt that is the issue phenomenon. and this
>> situation is badly state for ohci.
>>
>>>> Hi Alan Stern,
>>>>
>>>>       even though ed_rm_list is non-NULL, if hc in non-UsbOperation state set
>>>> SoF status in usbsts register that is illegal,
>>>>
>>>> at this time hcd doesn't need care URB whether finished,  because hc had
>>>> into a wrong state. even thoug it doesn't has this patch,
>>>>
>>>> URB was not be able to finish when hc in above worng state. except software
>>>> can intervence this wrong state. but the SoF bit of usbsts
>>>>
>>>> register was set by HC, and this action will happen always !!! software
>>>> clear SoF state I think it isn't make sense. software only disable SoF
>>>>
>>>> interrupt to fix HC wrong state.
>>> This problem happens when you go into S3 or S4 suspend, right?  So you
>>> should fix the problem by disabling INTR_SF when the root hub is
>>> suspended.  Try adding
>>>
>>> 	/* All ED unlinks should be finished, no need for SOF interrupts */
>>> 	ohci_writel(ohci, OHCI_INTR_SF, &ohci->regs->intrdisable);
>>>
>>> into ohci_rh_suspend(), just before the update_done_list() call.  If you
>>> add this then INTR_SF will not be enabled during S3 or S4 suspend, so
>>> the problem shouldn't occur.  Does that work for you?
>> The system doesn't suspend to disk completely by my test result and hc will
>> always produce SoF interrupt.
> Have you tried adding those two lines of code shown above?
>
> If you haven't tested them, please don't write back until you have.
>
> Alan Stern

Hi Alan stern,

     I have a try that follow your advice and the s3/s4 test result is 
good for me.


Thanks,

Yinbo Zhu.

