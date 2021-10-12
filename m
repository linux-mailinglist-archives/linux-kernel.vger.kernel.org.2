Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0A6442A413
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236360AbhJLMOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:14:03 -0400
Received: from mail.loongson.cn ([114.242.206.163]:57752 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236196AbhJLMOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:14:01 -0400
Received: from [10.180.13.145] (unknown [10.180.13.145])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxn2qCe2VhVrQYAA--.23052S2;
        Tue, 12 Oct 2021 20:11:53 +0800 (CST)
Subject: Re: [PATCH v5] usb: ohci: disable start-of-frame interrupt in
 ohci_rh_suspend
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <greg@kroah.com>,
        Patchwork Bot <patchwork-bot@kernel.org>
References: <1634027450-3358-1-git-send-email-zhuyinbo@loongson.cn>
From:   zhuyinbo <zhuyinbo@loongson.cn>
Message-ID: <c26e86a7-a24d-42f5-3d39-71c34f8c5e31@loongson.cn>
Date:   Tue, 12 Oct 2021 20:11:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1634027450-3358-1-git-send-email-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf9Dxn2qCe2VhVrQYAA--.23052S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW7uFyDtFWrtFy7urWktFb_yoW8Kr1DpF
        4fCr15try5Jw409F1UCF17GrWrKw15J3y7GasrCa4UAwsxtr10gFy2gFWYgF1vqrWxJw1U
        ZF48X34Uua1UuaUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv0b7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
        A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IE
        w4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMc
        vjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxkI
        ecxEwVCm-wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8
        v_M3UUUUU==
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/10/12 下午4:30, Yinbo Zhu 写道:
> The usb states of ohci controller include UsbOperational, UsbReset,
> UsbSuspend and UsbResume. Among them, only the UsbOperational state
> supports launching the start-of-frame for host controller according
> the ohci protocol spec, but in S3 and S4 (suspend to memory/suspend
> to disk) press test procedure, it may happen that the start-of-
> frame was launched in UsbSuspend status and cause ohci works failed
> that the phenomenon was hc will allways reproduce the SoF interrupt
> and consider that hc doesn't deal with the ed/td/done list in non-
> UsbOperational, and this patch was to disable SoF interrupt in ohci
> _rh_suspend so that it can fix ohci SoF abnormally interrupt issue.
>
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v5:
> 		Move the key code change into ohci_rh_suspend.
> 		Rework the commit log information.
>
>
>   drivers/usb/host/ohci-hub.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/usb/host/ohci-hub.c b/drivers/usb/host/ohci-hub.c
> index f474f2f..80a0094 100644
> --- a/drivers/usb/host/ohci-hub.c
> +++ b/drivers/usb/host/ohci-hub.c
> @@ -88,6 +88,8 @@ static int ohci_rh_suspend (struct ohci_hcd *ohci, int autostop)
>   		msleep (8);
>   		spin_lock_irq (&ohci->lock);
>   	}
> +	/* All ED unlinks should be finished, no need for SOF interrupts */
> +	ohci_writel(ohci, OHCI_INTR_SF, &ohci->regs->intrdisable);
>   	update_done_list(ohci);
>   	ohci_work(ohci);

Hi Alan Stern,

     I consider that autostop sometimes was '1' then and HC doesn't  
stop deal with the ed/td/done list , then ohci_wok will called 
start_ed_unlink and

     start_ed_unlink will enable INTR_SF as follows, so I think add 
above two line code after ohci_work it is more appropriate, Do you think so?

       static void start_ed_unlink (struct ohci_hcd *ohci, struct ed *ed)
        {

              ...

              494         /* enable SOF interrupt */
              495         ohci_writel (ohci, OHCI_INTR_SF, 
&ohci->regs->intrstatus);
              496         ohci_writel (ohci, OHCI_INTR_SF, 
&ohci->regs->intrenable);

               ...

         }


BRs,

Yinbo Zhu.

>   

