Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 974A342758A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 04:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhJICD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 22:03:29 -0400
Received: from mail.loongson.cn ([114.242.206.163]:46442 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231947AbhJICD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 22:03:27 -0400
Received: from [10.180.13.128] (unknown [10.180.13.128])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxH2v192BhVdwWAA--.34518S2;
        Sat, 09 Oct 2021 10:01:26 +0800 (CST)
Subject: Re: [PATCH v3] usb: ohci: add check for host controller functional
 states
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
References: <1633677970-10619-1-git-send-email-zhuyinbo@loongson.cn>
 <20211008142639.GA721194@rowland.harvard.edu>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <7a505fc4-ec47-ac83-633f-7a5251bd5f82@loongson.cn>
Date:   Sat, 9 Oct 2021 10:01:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20211008142639.GA721194@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9DxH2v192BhVdwWAA--.34518S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw4kZr15Wry8Kry8Zw18Krg_yoWrtFW5pF
        4Skw43KryUJr109r17trn7JF9Ykw4xJ34UGa4Ika4Utrs0q34IqryIgFWj93Z5XrWfK3W2
        vF1jqrWUu3WDAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjc
        xK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxv
        r21lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        AVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
        9x07bOoGdUUUUU=
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/10/8 下午10:26, Alan Stern 写道:
> On Fri, Oct 08, 2021 at 03:26:10PM +0800, Yinbo Zhu wrote:
>> The usb states of ohci controller include UsbOperational, UsbReset,
>> UsbSuspend and UsbResume. Among them, only the UsbOperational state
>> supports launching the start of frame for host controller according
>> the ohci protocol spec, but in S3/S4 press test procedure, it may
> Nobody reading this will know what "S3/S4 press test procedure" means.
> You have to explain it, or use a different name that people will
> understand.
okay, I got it.
>> happen that the start of frame was launched in other usb states and
>> cause ohci works abnormally then kernel will allways report rcu
>> call trace. This patch was to add check for host controller
>> functional states and if it is not UsbOperational state that need
>> set INTR_SF in intrdisable register to ensure SOF Token generation
>> was been disabled.
> This doesn't make sense.  You already mentioned that only the
> UsbOperational state supports sending start-of-frame packets.  So if the
> controller is in a different state then it won't send these packets,
> whether INTR_SF is enabled or not.
>
> What problem are you really trying to solve?

Only UsbOperational state supports sending start-of-frame packets, but 
in fact, in S3/S4 press test procedure,

usb in non-UsbOperational state that send start-of-frame packets but hc 
driver doesn't deal with this frame. and hc will

allways lauched the SOF for finishing the frame, the cpu will hand this 
sof interrupt and doesn't deal with time interrupt

that will cause rcu call trace then system doesn't suspend to memory/disk.

>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>> Change in v3:
>> 		Rework the commit information.
>> 		Move the patch code change to lower down position in ohci_irq.
>>
>>
>>   drivers/usb/host/ohci-hcd.c | 13 ++++++++++---
>>   1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
>> index 1f5e693..87aa9bb 100644
>> --- a/drivers/usb/host/ohci-hcd.c
>> +++ b/drivers/usb/host/ohci-hcd.c
>> @@ -879,7 +879,8 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>>   {
>>   	struct ohci_hcd		*ohci = hcd_to_ohci (hcd);
>>   	struct ohci_regs __iomem *regs = ohci->regs;
>> -	int			ints;
>> +	int			ints, ctl;
>> +
> Extra blank line not needed.
>
>>   
>>   	/* Read interrupt status (and flush pending writes).  We ignore the
>>   	 * optimization of checking the LSB of hcca->done_head; it doesn't
>> @@ -969,9 +970,15 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>>   	 * when there's still unlinking to be done (next frame).
>>   	 */
>>   	ohci_work(ohci);
>> -	if ((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
>> -			&& ohci->rh_state == OHCI_RH_RUNNING)
>> +
>> +	ctl = ohci_readl(ohci, &regs->control);
>> +
> Blank lines not needed.
>
>> +	if (((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
>> +			&& ohci->rh_state == OHCI_RH_RUNNING) ||
>> +			((ctl & OHCI_CTRL_HCFS) != OHCI_USB_OPER)) {
>>   		ohci_writel (ohci, OHCI_INTR_SF, &regs->intrdisable);
>> +		(void)ohci_readl(ohci, &regs->intrdisable);
>> +	}
> This is definitely wrong.  You must not turn off SF interrupts when
> ed_rm_list is non-NULL.  If you do, the driver will not be able to
> finish unlinking URBs.
>
> Alan Stern

Hi Alan Stern,

     even though ed_rm_list is non-NULL, if hc in non-UsbOperation state 
set SoF status in usbsts register that is illegal,

at this time hcd doesn't need care URB whether finished,  because hc had 
into a wrong state. even thoug it doesn't has this patch,

URB was not be able to finish when hc in above worng state. except 
software can intervence this wrong state. but the SoF bit of usbsts

register was set by HC, and this action will happen always !!! software 
clear SoF state I think it isn't make sense. software only disable SoF

interrupt to fix HC wrong state.

       In additon, when kernel include my patch, that it does't happen 
about what you descriped that driver will not be able to finish 
unlinging URBs.

Because above issue happen in S3/S4(Suspend to disk/Suspend to mem) test 
procedure, if ed_rm_lis is no-NULL but my patch disable SoF interrupt.

then when S3/S4 recovery to cpu idle state that usb resume will be 
called, reume function has following logic, URB will continue to be 
processed.

       static int ohci_rh_resume (struct ohci_hcd *ohci)

      {

         ...

         242         if (ohci->ed_rm_list)
         243                 ohci_writel (ohci, OHCI_INTR_SF, 
&ohci->regs->intrenable);

        ...

       }

BRS,

Yinbo Zhu.

