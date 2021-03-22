Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95595344FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 20:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbhCVTe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 15:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbhCVTea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 15:34:30 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67A3C061574;
        Mon, 22 Mar 2021 12:34:29 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g15so11761504pfq.3;
        Mon, 22 Mar 2021 12:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GWs7OU5C7CncS3zef9P4gzYiLCFh0IxfaKqlLxLrf/k=;
        b=U3hguqnFpWb/oivwee32UyknDJlQHPBa3hw/vEEKySM6Tr4K3vlRVoi5httElWNmMt
         meih0pMBsTQu4cUhS+UYquroQQXKJaj1FJG3xlGkfyog+PaPgo1c6rLmaAAjAJzqUhsc
         Wpg0zPtodA3R2uVEsj4oFHdGD4bw0c+i7Qm3ww+jpt2A/Q4QZRXvjfHxf820bFc01tfd
         XiEHxJV3wZzLSj9AdrocGN8zWQrBbUp05aFkofaag7zi9wwlhqMRuhRXdNC/i9f/Smmh
         sR5M0rrXFOoCVJI2lSk/HYlhgXjtMfpE/4C7TxNFZLsAktRfyV/4ZASZz/Ya5XhQ0wKd
         gyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GWs7OU5C7CncS3zef9P4gzYiLCFh0IxfaKqlLxLrf/k=;
        b=dFTyAnN5XR7EqEaiflHPRJMoeO1sPi70bcoO4XEGDgl1Ji2zsouQoE0P5Q3o9dW/fY
         hfLxz/n+qeR/7UXOoj+9M8Rd2+Z0zHrSy+SXzkx1zMKIJmxu+WqZtniRNY38R5AwNUdb
         3qpIIv04bKjRyamntnqtaR85SeSINBG1LZ8UqTM0mVTERHcKcAReweCh+zaWCVfJHmuw
         Xi0h4cI0JEyTcszhAAk1X5mP4hzwxHimEcRUqP8IBJg2jnFUKng1adUQ8nlfe4C/tLMq
         JBYrEVq49XFSbsnY02M/yXRHd9p3kALgVWmBYnvX8hSlA05NspBzAD7WiUUlAtryTzYQ
         MzuQ==
X-Gm-Message-State: AOAM533zSwHU283Ojv2S8QRoj7PYgAwHUrttTKAlyVeHhBqtD1huPIJc
        GvOaZkNxT8BAvStXHJRBXkUtVvCLaHoQAO48vV8=
X-Google-Smtp-Source: ABdhPJybhsRuVTHjX5wevhODrw6xYx3Ka0P8ZPA7nvmt9xCWfwIdwfrpnAaugPNsQxuUTniyoFBzI4hC8mCCxeXksuU=
X-Received: by 2002:a65:4bc5:: with SMTP id p5mr987229pgr.74.1616441669067;
 Mon, 22 Mar 2021 12:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <1615507142-23097-1-git-send-email-wcheng@codeaurora.org>
 <CAHp75VfUVCB4gzgOWf=bUpCjfyerQLPN_p-vOnVfxUKHi1WJkg@mail.gmail.com> <716dca12-2bfc-789f-ca74-5555852e4c8b@codeaurora.org>
In-Reply-To: <716dca12-2bfc-789f-ca74-5555852e4c8b@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 22 Mar 2021 21:34:12 +0200
Message-ID: <CAHp75VeynZArUkrogdJdR9oh+6Ocuqz3ySeDoRBFWusm8F6NRQ@mail.gmail.com>
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

On Mon, Mar 22, 2021 at 8:49 PM Wesley Cheng <wcheng@codeaurora.org> wrote:
>
> Hi Andy,
>
> On 3/22/2021 5:48 AM, Andy Shevchenko wrote:
> > On Fri, Mar 12, 2021 at 2:01 AM Wesley Cheng <wcheng@codeaurora.org> wr=
ote:
> >>
> >> In the situations where the DWC3 gadget stops active transfers, once
> >> calling the dwc3_gadget_giveback(), there is a chance where a function
> >> driver can queue a new USB request in between the time where the dwc3
> >> lock has been released and re-aquired.  This occurs after we've alread=
y
> >> issued an ENDXFER command.  When the stop active transfers continues
> >> to remove USB requests from all dep lists, the newly added request wil=
l
> >> also be removed, while controller still has an active TRB for it.
> >> This can lead to the controller accessing an unmapped memory address.
> >>
> >> Fix this by ensuring parameters to prevent EP queuing are set before
> >> calling the stop active transfers API.
> >
> >
> > commit f09ddcfcb8c569675066337adac2ac205113471f
> > Author: Wesley Cheng <wcheng@codeaurora.org>
> > Date:   Thu Mar 11 15:59:02 2021 -0800
> >
> >    usb: dwc3: gadget: Prevent EP queuing while stopping transfers
> >
> > effectively broke my gadget setup.
> >
> > The output of the kernel (followed by non responsive state of USB contr=
oller):
> >
> > [  195.228586] using random self ethernet address
> > [  195.233104] using random host ethernet address
> > [  195.245306] usb0: HOST MAC aa:bb:cc:dd:ee:f2
> > [  195.249732] usb0: MAC aa:bb:cc:dd:ee:f1
> > # [  195.773594] IPv6: ADDRCONF(NETDEV_CHANGE): usb0: link becomes read=
y
> > [  195.780585] ------------[ cut here ]------------
> > [  195.785217] dwc3 dwc3.0.auto: No resource for ep2in
> > [  195.790162] WARNING: CPU: 0 PID: 217 at
> > drivers/usb/dwc3/gadget.c:360 dwc3_send_gadget_ep_cmd+0x4b9/0x670
> > [  195.799760] Modules linked in: usb_f_eem u_ether libcomposite
> > brcmfmac brcmutil mmc_block pwm_lpss_pci pwm_lps
> > s snd_sof_pci_intel_tng snd_sof_pci snd_sof_acpi_intel_byt
> > snd_sof_intel_ipc snd_sof_acpi snd_sof snd_sof_nocodec
> > spi_pxa2xx_platform snd_sof_xtensa_dsp spi_pxa2xx_pci
> > extcon_intel_mrfld intel_mrfld_adc sdhci_pci cqhci sdhci m
> > mc_core intel_mrfld_pwrbtn intel_soc_pmic_mrfld hci_uart btbcm btintel
> > [  195.835604] CPU: 0 PID: 217 Comm: irq/16-dwc3 Not tainted 5.12.0-rc4=
+ #60
> > [  195.842403] Hardware name: Intel Corporation Merrifield/BODEGA BAY,
> > BIOS 542 2015.01.21:18.19.48
> > [  195.851191] RIP: 0010:dwc3_send_gadget_ep_cmd+0x4b9/0x670
> > [  195.856608] Code: cd 00 00 00 44 89 44 24 20 48 89 4c 24 18 e8 ee
> > f7 e4 ff 48 8b 4c 24 18 4c 89 f2 48 c7 c7 b9
> > ed 4f a0 48 89 c6 e8 ef 24 43 00 <0f> 0b 41 be ea ff ff ff 44 8b 44 24
> > 20 e9 80 fc ff ff 41 83 fe 92
> > [  195.875381] RSP: 0000:ffffa53c00373ba8 EFLAGS: 00010086
> > [  195.880617] RAX: 0000000000000000 RBX: 0000000000001387 RCX: 0000000=
0ffffdfff
> > [  195.887755] RDX: 00000000ffffdfff RSI: 00000000ffffffea RDI: 0000000=
000000000
> > [  195.894893] RBP: ffff9ce8c8f2b028 R08: ffffffffa0732288 R09: 0000000=
000009ffb
> > [  195.902034] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: 0000000=
000041006
> > [  195.909170] R13: ffffa53c00373c24 R14: ffff9ce8c11dadb0 R15: ffff9ce=
8c2861700
> > [  195.916310] FS:  0000000000000000(0000) GS:ffff9ce8fe200000(0000)
> > knlGS:0000000000000000
> > [  195.924409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  195.930161] CR2: 00000000f7f694a0 CR3: 0000000038e0c000 CR4: 0000000=
0001006f0
> > [  195.937300] Call Trace:
> > [  195.939755]  __dwc3_gadget_ep_enable+0x2d4/0x4e0
> > [  195.944393]  ? dwc3_remove_requests.constprop.0+0x86/0x170
>
> Odd that this change would affect the USB enablment path, as they were
> focused on the pullup disable path.  Would you happen to have any
> downstream changes on top of v5.12-rc4 we could review to see if they
> are still required? (ie where is the dwc3_remove_requests() coming from
> during ep enable)

You may check my branch [1] on GH. Basically you may be interested in
the commit:
0f86df1294ee7523060cc16eafaf4898c693eab0 REVERTME: usb: dwc3: gadget:
skip endpoints ep[18]{in,out}
Otherwise it's a clean v5.12-rc4 with a revert and another USB PHY
suspend fix (which also shouldn't affect this).

But I don't believe it should have affected this.

> > [  195.949897]  dwc3_gadget_ep_enable+0x5d/0x120
> > [  195.954274]  usb_ep_enable+0x27/0x80
> > [  195.957869]  gether_connect+0x32/0x1f0 [u_ether]
> > [  195.962512]  eem_set_alt+0x6d/0x140 [usb_f_eem]
> > [  195.967061]  composite_setup+0x224/0x1ba0 [libcomposite]
> > [  195.972405]  ? debug_dma_unmap_page+0x79/0x80
> > [  195.976782]  ? configfs_composite_setup+0x6b/0x90 [libcomposite]
> > [  195.982811]  configfs_composite_setup+0x6b/0x90 [libcomposite]
> > [  195.988668]  dwc3_ep0_interrupt+0x459/0xa50
> > [  195.992869]  dwc3_thread_interrupt+0x8e2/0xee0
> > [  195.997327]  ? __schedule+0x237/0x6d0
> > [  196.001005]  ? disable_irq_nosync+0x10/0x10
> > [  196.005200]  irq_thread_fn+0x1b/0x60
> > [  196.008789]  irq_thread+0xd6/0x170
> > [  196.012202]  ? irq_thread_check_affinity+0x70/0x70
> > [  196.017004]  ? irq_forced_thread_fn+0x70/0x70
> > [  196.021373]  kthread+0x116/0x130
> > [  196.024617]  ? kthread_create_worker_on_cpu+0x60/0x60
> > [  196.029680]  ret_from_fork+0x22/0x30
> > [  196.033272] ---[ end trace 8dd104a950d8d248 ]---
> >
> >
> Also, as I mentioned above, the changes should affect the pullup disable
> path, so when you 'echo "" > UDC' or something similar to that
> operation, did you see any errors?

After your patch I see a warning as above. Before =E2=80=94 no errors or wa=
rnings.

> Can you provide a ftrace output w/
> the DWC3 tracing enabled once removing the UDC?

Can you provide step-by-step instructions what should I do?

> > Revert helps (I'm on v5.12-rc4 now with a revert).
> >
> > The script to enable gadget:
> >
> > #!/bin/sh -efu
> >
> > # Mounting CONFIGFS
> > grep -q -w /sys/kernel/config /proc/mounts || mount -t configfs none
> > /sys/kernel/config
> >
> > # Addresses and files
> > readonly GADGET_BASE_DIR=3D"/sys/kernel/config/usb_gadget/g1"
> > readonly DEV_ETH_ADDR=3D"aa:bb:cc:dd:ee:f1"
> > readonly HOST_ETH_ADDR=3D"aa:bb:cc:dd:ee:f2"
> > readonly USBDISK=3D"/usbdisk.img"
> >
> > # Insert modules
> > modprobe libcomposite
> >
> > # Create directory structure
> > mkdir "${GADGET_BASE_DIR}"
> > cd "${GADGET_BASE_DIR}"
> > mkdir -p configs/c.1/strings/0x409
> > mkdir -p strings/0x409
> >
> > # Ethernet device
> > mkdir functions/eem.usb0
> > echo "${DEV_ETH_ADDR}" > functions/eem.usb0/dev_addr
> > echo "${HOST_ETH_ADDR}" > functions/eem.usb0/host_addr
> > ln -s functions/eem.usb0 configs/c.1/
> >
> > # Composite Gadget Setup
> > echo 0x1d6b > idVendor          # Linux Foundation
> > echo 0x0104 > idProduct         # Multifunction Composite Gadget
> > echo 0x0100 > bcdDevice         # v1.0.0
> > echo 0x0200 > bcdUSB            # USB2
> > echo "0123456789abcdef" > strings/0x409/serialnumber
> > echo "USBArmory"        > strings/0x409/manufacturer
> > echo "USBArmory Gadget" > strings/0x409/product
> > echo "Conf1"            > configs/c.1/strings/0x409/configuration
> > echo 120                > configs/c.1/MaxPower
> >
> > # Activate gadgets
> > echo dwc3.0.auto > UDC
> >
> > Please, tell me how to fix this, otherwise I will have to send a revert=
.
> >
> This also fixes a potential SMMU fault on targets with that enabled.  It
> causes the controller to access a stale TRB DMA address after it has
> already been unmapped.  I think we should figure out what is causing the
> issue on your set up instead of reverting the entire change.

If we find a cause and have a fix during this week, otherwise it's
rc5:ish timing when we may not have more time to play.

--=20
With Best Regards,
Andy Shevchenko
