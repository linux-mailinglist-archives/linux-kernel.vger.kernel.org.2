Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBA1B344F04
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhCVSsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:48:51 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:64595 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230177AbhCVSso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:48:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616438924; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=eUTMRTGwOnBE6YUlWcW6k6MvFsslU1W7XaDtjXfpIaI=; b=FSF4V9fgrDyOnft3PRsn/Lr1UxN0f0zQHINbmqQDdBTujgnLs6RNWsG+3BB2JPscaxJ7AHcx
 cyS3yrDFBKq6D0X0Bx04GKTf++oukR9fjPmcnY1z6kCbDG9KDFoisXe3qWA+PpABQPAm1S/u
 1hvzx7IaoqyOEgSVGqMGX658Wn4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 6058e68a1de5dd7b99db9d1d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Mar 2021 18:48:42
 GMT
Sender: wcheng=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C2A7DC43465; Mon, 22 Mar 2021 18:48:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.110.91.149] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wcheng)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 529B1C43461;
        Mon, 22 Mar 2021 18:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 529B1C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=wcheng@codeaurora.org
Subject: Re: [PATCH v3] usb: dwc3: gadget: Prevent EP queuing while stopping
 transfers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
References: <1615507142-23097-1-git-send-email-wcheng@codeaurora.org>
 <CAHp75VfUVCB4gzgOWf=bUpCjfyerQLPN_p-vOnVfxUKHi1WJkg@mail.gmail.com>
From:   Wesley Cheng <wcheng@codeaurora.org>
Message-ID: <716dca12-2bfc-789f-ca74-5555852e4c8b@codeaurora.org>
Date:   Mon, 22 Mar 2021 11:48:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfUVCB4gzgOWf=bUpCjfyerQLPN_p-vOnVfxUKHi1WJkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 3/22/2021 5:48 AM, Andy Shevchenko wrote:
> On Fri, Mar 12, 2021 at 2:01 AM Wesley Cheng <wcheng@codeaurora.org> wrote:
>>
>> In the situations where the DWC3 gadget stops active transfers, once
>> calling the dwc3_gadget_giveback(), there is a chance where a function
>> driver can queue a new USB request in between the time where the dwc3
>> lock has been released and re-aquired.  This occurs after we've already
>> issued an ENDXFER command.  When the stop active transfers continues
>> to remove USB requests from all dep lists, the newly added request will
>> also be removed, while controller still has an active TRB for it.
>> This can lead to the controller accessing an unmapped memory address.
>>
>> Fix this by ensuring parameters to prevent EP queuing are set before
>> calling the stop active transfers API.
> 
> 
> commit f09ddcfcb8c569675066337adac2ac205113471f
> Author: Wesley Cheng <wcheng@codeaurora.org>
> Date:   Thu Mar 11 15:59:02 2021 -0800
> 
>    usb: dwc3: gadget: Prevent EP queuing while stopping transfers
> 
> effectively broke my gadget setup.
> 
> The output of the kernel (followed by non responsive state of USB controller):
> 
> [  195.228586] using random self ethernet address
> [  195.233104] using random host ethernet address
> [  195.245306] usb0: HOST MAC aa:bb:cc:dd:ee:f2
> [  195.249732] usb0: MAC aa:bb:cc:dd:ee:f1
> # [  195.773594] IPv6: ADDRCONF(NETDEV_CHANGE): usb0: link becomes ready
> [  195.780585] ------------[ cut here ]------------
> [  195.785217] dwc3 dwc3.0.auto: No resource for ep2in
> [  195.790162] WARNING: CPU: 0 PID: 217 at
> drivers/usb/dwc3/gadget.c:360 dwc3_send_gadget_ep_cmd+0x4b9/0x670
> [  195.799760] Modules linked in: usb_f_eem u_ether libcomposite
> brcmfmac brcmutil mmc_block pwm_lpss_pci pwm_lps
> s snd_sof_pci_intel_tng snd_sof_pci snd_sof_acpi_intel_byt
> snd_sof_intel_ipc snd_sof_acpi snd_sof snd_sof_nocodec
> spi_pxa2xx_platform snd_sof_xtensa_dsp spi_pxa2xx_pci
> extcon_intel_mrfld intel_mrfld_adc sdhci_pci cqhci sdhci m
> mc_core intel_mrfld_pwrbtn intel_soc_pmic_mrfld hci_uart btbcm btintel
> [  195.835604] CPU: 0 PID: 217 Comm: irq/16-dwc3 Not tainted 5.12.0-rc4+ #60
> [  195.842403] Hardware name: Intel Corporation Merrifield/BODEGA BAY,
> BIOS 542 2015.01.21:18.19.48
> [  195.851191] RIP: 0010:dwc3_send_gadget_ep_cmd+0x4b9/0x670
> [  195.856608] Code: cd 00 00 00 44 89 44 24 20 48 89 4c 24 18 e8 ee
> f7 e4 ff 48 8b 4c 24 18 4c 89 f2 48 c7 c7 b9
> ed 4f a0 48 89 c6 e8 ef 24 43 00 <0f> 0b 41 be ea ff ff ff 44 8b 44 24
> 20 e9 80 fc ff ff 41 83 fe 92
> [  195.875381] RSP: 0000:ffffa53c00373ba8 EFLAGS: 00010086
> [  195.880617] RAX: 0000000000000000 RBX: 0000000000001387 RCX: 00000000ffffdfff
> [  195.887755] RDX: 00000000ffffdfff RSI: 00000000ffffffea RDI: 0000000000000000
> [  195.894893] RBP: ffff9ce8c8f2b028 R08: ffffffffa0732288 R09: 0000000000009ffb
> [  195.902034] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: 0000000000041006
> [  195.909170] R13: ffffa53c00373c24 R14: ffff9ce8c11dadb0 R15: ffff9ce8c2861700
> [  195.916310] FS:  0000000000000000(0000) GS:ffff9ce8fe200000(0000)
> knlGS:0000000000000000
> [  195.924409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  195.930161] CR2: 00000000f7f694a0 CR3: 0000000038e0c000 CR4: 00000000001006f0
> [  195.937300] Call Trace:
> [  195.939755]  __dwc3_gadget_ep_enable+0x2d4/0x4e0
> [  195.944393]  ? dwc3_remove_requests.constprop.0+0x86/0x170

Odd that this change would affect the USB enablment path, as they were
focused on the pullup disable path.  Would you happen to have any
downstream changes on top of v5.12-rc4 we could review to see if they
are still required? (ie where is the dwc3_remove_requests() coming from
during ep enable)

> [  195.949897]  dwc3_gadget_ep_enable+0x5d/0x120
> [  195.954274]  usb_ep_enable+0x27/0x80
> [  195.957869]  gether_connect+0x32/0x1f0 [u_ether]
> [  195.962512]  eem_set_alt+0x6d/0x140 [usb_f_eem]
> [  195.967061]  composite_setup+0x224/0x1ba0 [libcomposite]
> [  195.972405]  ? debug_dma_unmap_page+0x79/0x80
> [  195.976782]  ? configfs_composite_setup+0x6b/0x90 [libcomposite]
> [  195.982811]  configfs_composite_setup+0x6b/0x90 [libcomposite]
> [  195.988668]  dwc3_ep0_interrupt+0x459/0xa50
> [  195.992869]  dwc3_thread_interrupt+0x8e2/0xee0
> [  195.997327]  ? __schedule+0x237/0x6d0
> [  196.001005]  ? disable_irq_nosync+0x10/0x10
> [  196.005200]  irq_thread_fn+0x1b/0x60
> [  196.008789]  irq_thread+0xd6/0x170
> [  196.012202]  ? irq_thread_check_affinity+0x70/0x70
> [  196.017004]  ? irq_forced_thread_fn+0x70/0x70
> [  196.021373]  kthread+0x116/0x130
> [  196.024617]  ? kthread_create_worker_on_cpu+0x60/0x60
> [  196.029680]  ret_from_fork+0x22/0x30
> [  196.033272] ---[ end trace 8dd104a950d8d248 ]---
> 
> 
Also, as I mentioned above, the changes should affect the pullup disable
path, so when you 'echo "" > UDC' or something similar to that
operation, did you see any errors? Can you provide a ftrace output w/
the DWC3 tracing enabled once removing the UDC?

> Revert helps (I'm on v5.12-rc4 now with a revert).
> 
> The script to enable gadget:
> 
> #!/bin/sh -efu
> 
> # Mounting CONFIGFS
> grep -q -w /sys/kernel/config /proc/mounts || mount -t configfs none
> /sys/kernel/config
> 
> # Addresses and files
> readonly GADGET_BASE_DIR="/sys/kernel/config/usb_gadget/g1"
> readonly DEV_ETH_ADDR="aa:bb:cc:dd:ee:f1"
> readonly HOST_ETH_ADDR="aa:bb:cc:dd:ee:f2"
> readonly USBDISK="/usbdisk.img"
> 
> # Insert modules
> modprobe libcomposite
> 
> # Create directory structure
> mkdir "${GADGET_BASE_DIR}"
> cd "${GADGET_BASE_DIR}"
> mkdir -p configs/c.1/strings/0x409
> mkdir -p strings/0x409
> 
> # Ethernet device
> mkdir functions/eem.usb0
> echo "${DEV_ETH_ADDR}" > functions/eem.usb0/dev_addr
> echo "${HOST_ETH_ADDR}" > functions/eem.usb0/host_addr
> ln -s functions/eem.usb0 configs/c.1/
> 
> # Composite Gadget Setup
> echo 0x1d6b > idVendor          # Linux Foundation
> echo 0x0104 > idProduct         # Multifunction Composite Gadget
> echo 0x0100 > bcdDevice         # v1.0.0
> echo 0x0200 > bcdUSB            # USB2
> echo "0123456789abcdef" > strings/0x409/serialnumber
> echo "USBArmory"        > strings/0x409/manufacturer
> echo "USBArmory Gadget" > strings/0x409/product
> echo "Conf1"            > configs/c.1/strings/0x409/configuration
> echo 120                > configs/c.1/MaxPower
> 
> # Activate gadgets
> echo dwc3.0.auto > UDC
> 
> Please, tell me how to fix this, otherwise I will have to send a revert.
> 
This also fixes a potential SMMU fault on targets with that enabled.  It
causes the controller to access a stale TRB DMA address after it has
already been unmapped.  I think we should figure out what is causing the
issue on your set up instead of reverting the entire change.

Thanks
Wesley Cheng

>> Fixes: ae7e86108b12 ("usb: dwc3: Stop active transfers before halting the controller")
>> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
>> ---
>> Changes since V2:
>>  - Removed duplicate dwc->connected = false setting in pullup routine
>>
>> Changes since V1:
>>  - Added Fixes tag to point to the commit this is addressing
>>
>>  drivers/usb/dwc3/gadget.c | 11 +++++------
>>  1 file changed, 5 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
>> index 4780983..2c94cc9 100644
>> --- a/drivers/usb/dwc3/gadget.c
>> +++ b/drivers/usb/dwc3/gadget.c
>> @@ -783,8 +783,6 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
>>
>>         trace_dwc3_gadget_ep_disable(dep);
>>
>> -       dwc3_remove_requests(dwc, dep);
>> -
>>         /* make sure HW endpoint isn't stalled */
>>         if (dep->flags & DWC3_EP_STALL)
>>                 __dwc3_gadget_ep_set_halt(dep, 0, false);
>> @@ -803,6 +801,8 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
>>                 dep->endpoint.desc = NULL;
>>         }
>>
>> +       dwc3_remove_requests(dwc, dep);
>> +
>>         return 0;
>>  }
>>
>> @@ -1617,7 +1617,7 @@ static int __dwc3_gadget_ep_queue(struct dwc3_ep *dep, struct dwc3_request *req)
>>  {
>>         struct dwc3             *dwc = dep->dwc;
>>
>> -       if (!dep->endpoint.desc || !dwc->pullups_connected) {
>> +       if (!dep->endpoint.desc || !dwc->pullups_connected || !dwc->connected) {
>>                 dev_err(dwc->dev, "%s: can't queue to disabled endpoint\n",
>>                                 dep->name);
>>                 return -ESHUTDOWN;
>> @@ -2247,6 +2247,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>         if (!is_on) {
>>                 u32 count;
>>
>> +               dwc->connected = false;
>>                 /*
>>                  * In the Synopsis DesignWare Cores USB3 Databook Rev. 3.30a
>>                  * Section 4.1.8 Table 4-7, it states that for a device-initiated
>> @@ -2271,7 +2272,6 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
>>                         dwc->ev_buf->lpos = (dwc->ev_buf->lpos + count) %
>>                                                 dwc->ev_buf->length;
>>                 }
>> -               dwc->connected = false;
>>         } else {
>>                 __dwc3_gadget_start(dwc);
>>         }
>> @@ -3329,8 +3329,6 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
>>  {
>>         u32                     reg;
>>
>> -       dwc->connected = true;
>> -
>>         /*
>>          * WORKAROUND: DWC3 revisions <1.88a have an issue which
>>          * would cause a missing Disconnect Event if there's a
>> @@ -3370,6 +3368,7 @@ static void dwc3_gadget_reset_interrupt(struct dwc3 *dwc)
>>          * transfers."
>>          */
>>         dwc3_stop_active_transfers(dwc);
>> +       dwc->connected = true;
>>
>>         reg = dwc3_readl(dwc->regs, DWC3_DCTL);
>>         reg &= ~DWC3_DCTL_TSTCTRL_MASK;
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
>> a Linux Foundation Collaborative Project
>>
> 
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
