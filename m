Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911B93451A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbhCVVO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCVVO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:14:28 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F56EC061574;
        Mon, 22 Mar 2021 14:14:28 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t18so9116451pjs.3;
        Mon, 22 Mar 2021 14:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1HH0lyGuOTHXjOOoF9H6s1j2BlyvHxcO7BknqINHIUA=;
        b=d4PdzkYWwuYvym92nYqcjVBQPcdMZL28mPlGYuZDLrFFesgLdI//4BO2m2Bb9WPXiy
         erFn2u5Y5/CuKuJOUI4diQKF+3qc18uiqZhD1jn+8Hm8JaExYv1ItpRZsvSu54eKm916
         aJOhmeLFpdGB/5f4POWw4/DCkfrvJ3VzHQL4vDTfHubJ+aOcKdSGkLx//8ptEJD0TVyq
         oT0BBTNIYHK4zLooBbTSuyRpeFzGqSNEbpFSz7tdEM6aS+e2lyyV5sy8xgibRSNpWDB1
         0IQiSk6YoVKXhlL9lHO11lRRkXwjztMfvyRH327z8jW27/RGEqTvW/ywRlcKVqxJrVIY
         yefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1HH0lyGuOTHXjOOoF9H6s1j2BlyvHxcO7BknqINHIUA=;
        b=TGWYTjCJHJbrQxXaPMHw2G1e9fjci3T2Ti5g4ryFTj1lGvSL1zrYhnXQqX2gbCHoxz
         ptoioALR7tIbRVAcNr0cC4KwilleWm6XwycNX4qjGPUB02GlclnfyiducHhqaJAm0Ttg
         2/M4f3H4nwJwhJRiBY7/ahN03HJAHJeSxUXQBEnwnc61n2Zr1gYzpaUuAe9f2MCZxX36
         cVpj59Valv3Nz4WiQF/Nz4UttPxW8QClE3TOET11Y68WNQm7z+9AuHZ1vEtjAg3wDOZa
         PZMCCZawdspzca29MNOgDQ8Y+U7Mpfy+UaPpmC5c9BL8Vc3/uOTwvClSIyXfK0WbpRMh
         WSKA==
X-Gm-Message-State: AOAM5339Roi02Smwn/9rvT55cJnc1yRNPNcpvdCa6njTZHY93pZLb2um
        pKRFq1LDuOiUV8nvU4HZ1iyePgXfEt+Edtw8UMOBdzX1ZA/bXbpX
X-Google-Smtp-Source: ABdhPJxWbv2NehWmgWHvlQ3kxcF2ZH6gb/PJiMlN9hkhcgnM8WVJIBc0KVnEqBgqN8f856xIgdVVtSQ8iTOYPHw2rVY=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr1018734pjx.181.1616447667957;
 Mon, 22 Mar 2021 14:14:27 -0700 (PDT)
MIME-Version: 1.0
References: <1615507142-23097-1-git-send-email-wcheng@codeaurora.org>
 <CAHp75VfUVCB4gzgOWf=bUpCjfyerQLPN_p-vOnVfxUKHi1WJkg@mail.gmail.com>
 <716dca12-2bfc-789f-ca74-5555852e4c8b@codeaurora.org> <CAHp75VeynZArUkrogdJdR9oh+6Ocuqz3ySeDoRBFWusm8F6NRQ@mail.gmail.com>
 <39fdd3c8-9682-6109-f47d-7f7bffc4b85e@codeaurora.org>
In-Reply-To: <39fdd3c8-9682-6109-f47d-7f7bffc4b85e@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Mar 2021 23:14:11 +0200
Message-ID: <CAHp75Vexow3KLjAueNoPrEhXmWk_4AjUpWXOyWcFLZdfB-o2iA@mail.gmail.com>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Prevent EP queuing while stopping transfers
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:06 PM Wesley Cheng <wcheng@codeaurora.org> wrote=
:
>
> Hi Andy,
>
> On 3/22/2021 12:34 PM, Andy Shevchenko wrote:
> > On Mon, Mar 22, 2021 at 8:49 PM Wesley Cheng <wcheng@codeaurora.org> wr=
ote:
> >>
> >> Hi Andy,
> >>
> >> On 3/22/2021 5:48 AM, Andy Shevchenko wrote:
> >>> On Fri, Mar 12, 2021 at 2:01 AM Wesley Cheng <wcheng@codeaurora.org> =
wrote:
> >>>>
> >>>> In the situations where the DWC3 gadget stops active transfers, once
> >>>> calling the dwc3_gadget_giveback(), there is a chance where a functi=
on
> >>>> driver can queue a new USB request in between the time where the dwc=
3
> >>>> lock has been released and re-aquired.  This occurs after we've alre=
ady
> >>>> issued an ENDXFER command.  When the stop active transfers continues
> >>>> to remove USB requests from all dep lists, the newly added request w=
ill
> >>>> also be removed, while controller still has an active TRB for it.
> >>>> This can lead to the controller accessing an unmapped memory address=
.
> >>>>
> >>>> Fix this by ensuring parameters to prevent EP queuing are set before
> >>>> calling the stop active transfers API.
> >>>
> >>>
> >>> commit f09ddcfcb8c569675066337adac2ac205113471f
> >>> Author: Wesley Cheng <wcheng@codeaurora.org>
> >>> Date:   Thu Mar 11 15:59:02 2021 -0800
> >>>
> >>>    usb: dwc3: gadget: Prevent EP queuing while stopping transfers
> >>>
> >>> effectively broke my gadget setup.
> >>>
> >>> The output of the kernel (followed by non responsive state of USB con=
troller):
> >>>
> >>> [  195.228586] using random self ethernet address
> >>> [  195.233104] using random host ethernet address
> >>> [  195.245306] usb0: HOST MAC aa:bb:cc:dd:ee:f2
> >>> [  195.249732] usb0: MAC aa:bb:cc:dd:ee:f1
> >>> # [  195.773594] IPv6: ADDRCONF(NETDEV_CHANGE): usb0: link becomes re=
ady
> >>> [  195.780585] ------------[ cut here ]------------
> >>> [  195.785217] dwc3 dwc3.0.auto: No resource for ep2in
> >>> [  195.790162] WARNING: CPU: 0 PID: 217 at
> >>> drivers/usb/dwc3/gadget.c:360 dwc3_send_gadget_ep_cmd+0x4b9/0x670
> >>> [  195.799760] Modules linked in: usb_f_eem u_ether libcomposite
> >>> brcmfmac brcmutil mmc_block pwm_lpss_pci pwm_lps
> >>> s snd_sof_pci_intel_tng snd_sof_pci snd_sof_acpi_intel_byt
> >>> snd_sof_intel_ipc snd_sof_acpi snd_sof snd_sof_nocodec
> >>> spi_pxa2xx_platform snd_sof_xtensa_dsp spi_pxa2xx_pci
> >>> extcon_intel_mrfld intel_mrfld_adc sdhci_pci cqhci sdhci m
> >>> mc_core intel_mrfld_pwrbtn intel_soc_pmic_mrfld hci_uart btbcm btinte=
l
> >>> [  195.835604] CPU: 0 PID: 217 Comm: irq/16-dwc3 Not tainted 5.12.0-r=
c4+ #60
> >>> [  195.842403] Hardware name: Intel Corporation Merrifield/BODEGA BAY=
,
> >>> BIOS 542 2015.01.21:18.19.48
> >>> [  195.851191] RIP: 0010:dwc3_send_gadget_ep_cmd+0x4b9/0x670
> >>> [  195.856608] Code: cd 00 00 00 44 89 44 24 20 48 89 4c 24 18 e8 ee
> >>> f7 e4 ff 48 8b 4c 24 18 4c 89 f2 48 c7 c7 b9
> >>> ed 4f a0 48 89 c6 e8 ef 24 43 00 <0f> 0b 41 be ea ff ff ff 44 8b 44 2=
4
> >>> 20 e9 80 fc ff ff 41 83 fe 92
> >>> [  195.875381] RSP: 0000:ffffa53c00373ba8 EFLAGS: 00010086
> >>> [  195.880617] RAX: 0000000000000000 RBX: 0000000000001387 RCX: 00000=
000ffffdfff
> >>> [  195.887755] RDX: 00000000ffffdfff RSI: 00000000ffffffea RDI: 00000=
00000000000
> >>> [  195.894893] RBP: ffff9ce8c8f2b028 R08: ffffffffa0732288 R09: 00000=
00000009ffb
> >>> [  195.902034] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: 00000=
00000041006
> >>> [  195.909170] R13: ffffa53c00373c24 R14: ffff9ce8c11dadb0 R15: ffff9=
ce8c2861700
> >>> [  195.916310] FS:  0000000000000000(0000) GS:ffff9ce8fe200000(0000)
> >>> knlGS:0000000000000000
> >>> [  195.924409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>> [  195.930161] CR2: 00000000f7f694a0 CR3: 0000000038e0c000 CR4: 00000=
000001006f0
> >>> [  195.937300] Call Trace:
> >>> [  195.939755]  __dwc3_gadget_ep_enable+0x2d4/0x4e0
> >>> [  195.944393]  ? dwc3_remove_requests.constprop.0+0x86/0x170
> >>
> >> Odd that this change would affect the USB enablment path, as they were
> >> focused on the pullup disable path.  Would you happen to have any
> >> downstream changes on top of v5.12-rc4 we could review to see if they
> >> are still required? (ie where is the dwc3_remove_requests() coming fro=
m
> >> during ep enable)
> >
> > You may check my branch [1] on GH. Basically you may be interested in
> > the commit:
> > 0f86df1294ee7523060cc16eafaf4898c693eab0 REVERTME: usb: dwc3: gadget:
> > skip endpoints ep[18]{in,out}
> > Otherwise it's a clean v5.12-rc4 with a revert and another USB PHY
> > suspend fix (which also shouldn't affect this).
>
> Can you link your GH reference?

Oops, sorry.
Here we are:

[1]: https://github.com/andy-shev/linux/tree/eds-acpi

> >
> > But I don't believe it should have affected this.
> >
> >>> [  195.949897]  dwc3_gadget_ep_enable+0x5d/0x120
> >>> [  195.954274]  usb_ep_enable+0x27/0x80
> >>> [  195.957869]  gether_connect+0x32/0x1f0 [u_ether]
> >>> [  195.962512]  eem_set_alt+0x6d/0x140 [usb_f_eem]
> >>> [  195.967061]  composite_setup+0x224/0x1ba0 [libcomposite]
> >>> [  195.972405]  ? debug_dma_unmap_page+0x79/0x80
> >>> [  195.976782]  ? configfs_composite_setup+0x6b/0x90 [libcomposite]
> >>> [  195.982811]  configfs_composite_setup+0x6b/0x90 [libcomposite]
> >>> [  195.988668]  dwc3_ep0_interrupt+0x459/0xa50
> >>> [  195.992869]  dwc3_thread_interrupt+0x8e2/0xee0
> >>> [  195.997327]  ? __schedule+0x237/0x6d0
> >>> [  196.001005]  ? disable_irq_nosync+0x10/0x10
> >>> [  196.005200]  irq_thread_fn+0x1b/0x60
> >>> [  196.008789]  irq_thread+0xd6/0x170
> >>> [  196.012202]  ? irq_thread_check_affinity+0x70/0x70
> >>> [  196.017004]  ? irq_forced_thread_fn+0x70/0x70
> >>> [  196.021373]  kthread+0x116/0x130
> >>> [  196.024617]  ? kthread_create_worker_on_cpu+0x60/0x60
> >>> [  196.029680]  ret_from_fork+0x22/0x30
> >>> [  196.033272] ---[ end trace 8dd104a950d8d248 ]---
> >>>
> >>>
> >> Also, as I mentioned above, the changes should affect the pullup disab=
le
> >> path, so when you 'echo "" > UDC' or something similar to that
> >> operation, did you see any errors?
> >
> > After your patch I see a warning as above. Before =E2=80=94 no errors o=
r warnings.
> >
> >> Can you provide a ftrace output w/
> >> the DWC3 tracing enabled once removing the UDC?
> >
> > Can you provide step-by-step instructions what should I do?
> >
> Let me try with your kernel, and steps below first.
>
> Thanks
> Wesley Cheng
>
> >>> Revert helps (I'm on v5.12-rc4 now with a revert).
> >>>
> >>> The script to enable gadget:
> >>>
> >>> #!/bin/sh -efu
> >>>
> >>> # Mounting CONFIGFS
> >>> grep -q -w /sys/kernel/config /proc/mounts || mount -t configfs none
> >>> /sys/kernel/config
> >>>
> >>> # Addresses and files
> >>> readonly GADGET_BASE_DIR=3D"/sys/kernel/config/usb_gadget/g1"
> >>> readonly DEV_ETH_ADDR=3D"aa:bb:cc:dd:ee:f1"
> >>> readonly HOST_ETH_ADDR=3D"aa:bb:cc:dd:ee:f2"
> >>> readonly USBDISK=3D"/usbdisk.img"
> >>>
> >>> # Insert modules
> >>> modprobe libcomposite
> >>>
> >>> # Create directory structure
> >>> mkdir "${GADGET_BASE_DIR}"
> >>> cd "${GADGET_BASE_DIR}"
> >>> mkdir -p configs/c.1/strings/0x409
> >>> mkdir -p strings/0x409
> >>>
> >>> # Ethernet device
> >>> mkdir functions/eem.usb0
> >>> echo "${DEV_ETH_ADDR}" > functions/eem.usb0/dev_addr
> >>> echo "${HOST_ETH_ADDR}" > functions/eem.usb0/host_addr
> >>> ln -s functions/eem.usb0 configs/c.1/
> >>>
> >>> # Composite Gadget Setup
> >>> echo 0x1d6b > idVendor          # Linux Foundation
> >>> echo 0x0104 > idProduct         # Multifunction Composite Gadget
> >>> echo 0x0100 > bcdDevice         # v1.0.0
> >>> echo 0x0200 > bcdUSB            # USB2
> >>> echo "0123456789abcdef" > strings/0x409/serialnumber
> >>> echo "USBArmory"        > strings/0x409/manufacturer
> >>> echo "USBArmory Gadget" > strings/0x409/product
> >>> echo "Conf1"            > configs/c.1/strings/0x409/configuration
> >>> echo 120                > configs/c.1/MaxPower
> >>>
> >>> # Activate gadgets
> >>> echo dwc3.0.auto > UDC
> >>>
> >>> Please, tell me how to fix this, otherwise I will have to send a reve=
rt.
> >>>
> >> This also fixes a potential SMMU fault on targets with that enabled.  =
It
> >> causes the controller to access a stale TRB DMA address after it has
> >> already been unmapped.  I think we should figure out what is causing t=
he
> >> issue on your set up instead of reverting the entire change.
> >
> > If we find a cause and have a fix during this week, otherwise it's
> > rc5:ish timing when we may not have more time to play.
> >
>
> --
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum=
,
> a Linux Foundation Collaborative Project



--=20
With Best Regards,
Andy Shevchenko
