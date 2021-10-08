Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C352426520
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 09:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhJHHUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 03:20:19 -0400
Received: from mail.loongson.cn ([114.242.206.163]:60326 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231979AbhJHHUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 03:20:18 -0400
Received: from [10.180.13.128] (unknown [10.180.13.128])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9DxT2ux8F9h3nAWAA--.33883S2;
        Fri, 08 Oct 2021 15:18:15 +0800 (CST)
Subject: Re: [PATCH v2] usb: ohci: add check for start frame in host
 controller functional states
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
References: <1632910167-23554-1-git-send-email-zhuyinbo@loongson.cn>
 <20210929145905.GA428239@rowland.harvard.edu>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <0cbc2fc2-4e33-5529-a07a-8c0ee41c800e@loongson.cn>
Date:   Fri, 8 Oct 2021 15:18:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210929145905.GA428239@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9DxT2ux8F9h3nAWAA--.33883S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF1UZFW7XF4fuw47Ar1DKFg_yoWrAr1kpr
        4Iyr4YkrWDJw18Xr1xJrn7JFyrKw48J3y7G34xGa47Jr4Yqryjqry0grWFgF1kWr4fJw12
        vF4jqrW5u3W7AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4
        vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
        xUcDDGUUUUU
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/9/29 下午10:59, Alan Stern 写道:
> On Wed, Sep 29, 2021 at 06:09:27PM +0800, Yinbo Zhu wrote:
>> The pm states of ohci controller include UsbOperational, UsbReset, UsbSuspend
> > Those aren't really PM states.  The specification calls them "USB 
> > states".
I had replace "PM states" with "USB states" in v3 version patch
>
>> , and UsbResume. Among them, only the UsbOperational state supports launching
> --^
>
> > This comma should come directly after the word "launching", with no 
> > space in between.
> okay, I got it.
>> the start frame for host controller according the ohci protocol spec, but in
>> S3/S4 press test procedure, it may happen that the start frame was launched
> > What is the S3/S4 press test?  I don't recall hearing of it before.
S3 test is that suspend to memory, S4 test is that system suspend to disk.
>
>> in other pm states and cause ohci works abnormally then kernel will allways
>> report rcu CallTrace. This patch was to add check for start frame in host
>> controller functional states for fixing above issue.
> > The patch doesn't check for start of frames, that is, it doesn't check 
> > the INTR_SF bit in the intrstatus register.  Instead it checks whether 
> > controller is in the UsbOperational state.  And the patch also sets 
> > INTR_SF in the intrdisable register -- you do not mention this in the 
> > description.
> okay, I got it, and I had made a appropriate commit changes that according to what you advice in v3 version patch.
>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>> ---
>> Change in v2:
>> 		Revise the punctuation.	
>>
>>   drivers/usb/host/ohci-hcd.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/usb/host/ohci-hcd.c b/drivers/usb/host/ohci-hcd.c
>> index 1f5e693..f0aeae5 100644
>> --- a/drivers/usb/host/ohci-hcd.c
>> +++ b/drivers/usb/host/ohci-hcd.c
>> @@ -881,6 +881,13 @@ static irqreturn_t ohci_irq (struct usb_hcd *hcd)
>>   	struct ohci_regs __iomem *regs = ohci->regs;
>>   	int			ints;
>>   
>> +	ints = ohci_readl(ohci, &regs->control);
>> +
>> +	if ((ints & OHCI_CTRL_HCFS) != OHCI_USB_OPER) {
>> +		ohci_writel(ohci, OHCI_INTR_SF, &regs->intrdisable);
>> +		(void)ohci_readl(ohci, &regs->intrdisable);
>> +	}
> > The driver is already supposed to prevent this problem by writing the 
> > OHCI_INTR_SF flag to the intrdisable register when start-of-frame 
> > interrupts aren't needed.  Maybe what you should do is change this code 
> > lower down in ohci_irq():
>
> >	if ((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
> >			&& ohci->rh_state == OHCI_RH_RUNNING)
> >		ohci_writel (ohci, OHCI_INTR_SF, &regs->intrdisable);
>
> > by getting rid of the test for OHCI_RH_RUNNING.
>
> > Alan Stern

Hi Alan Stern,

       Above code condition that the key point is ohci->ed_rm_list is 
NULL, but my target of my patch is to disable SoF interrupt when hc isn't

UsbOperation state and it doesn't matter with that ohci->ed_rm_list 
whether is NULL. In addition the ohci->rh_state is to describe root hub

state that include halt, suspend,run and  it isn't exactly the same as 
hc state.

      following code is the v3 version patch,  please you check.

         ohci_work(ohci);
-       if ((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
-                       && ohci->rh_state == OHCI_RH_RUNNING)
+
+       ctl = ohci_readl(ohci, &regs->control);
+
+       if (((ints & OHCI_INTR_SF) != 0 && !ohci->ed_rm_list
+                       && ohci->rh_state == OHCI_RH_RUNNING) ||
+                       ((ctl & OHCI_CTRL_HCFS) != OHCI_USB_OPER)) {
                 ohci_writel (ohci, OHCI_INTR_SF, &regs->intrdisable);
+               (void)ohci_readl(ohci, &regs->intrdisable);
+       }

>
>> +
>>   	/* Read interrupt status (and flush pending writes).  We ignore the
>>   	 * optimization of checking the LSB of hcca->done_head; it doesn't
>>   	 * work on all systems (edge triggering for OHCI can be a factor).
>> -- 
>> 1.8.3.1
>>

