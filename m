Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE6D234664F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 18:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhCWR2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 13:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhCWR1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 13:27:54 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D28EC061574;
        Tue, 23 Mar 2021 10:27:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id l123so15030532pfl.8;
        Tue, 23 Mar 2021 10:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V9wYyZwU50XvLyvxnBpFc3jy0YTpGXOQ3au2zDGL08k=;
        b=LIhhfD6+lJjGU5iYCqEsrgfgxPCMea8rx1VRgT2jpfdIXV+8dQt4xDgr4W6TmSa44/
         02AB9EglmpqwR/wekqHyvmSVNccs066o5sYqM64uyUzwrC0STIR5d8rYknQrZzpk++vO
         4Fsm0skJPqUsg5v1CWA8itVE79BwYldHiJ1siCenVMDUWBGWTTlHKFblXZkK2yul7mVk
         XzVEKLmNXXVwjqHbwjJeppurAkf2rJ9oLFeaMsoMbKVqfv1CCaFIzkTdfY9i9vFpULjB
         nQT2D7a4JJyDpP9Samkej22NN/xD0MoR0MAv/t+rWUAyBcRSjnsb1jpT06gfDgDeK/Ra
         Upzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V9wYyZwU50XvLyvxnBpFc3jy0YTpGXOQ3au2zDGL08k=;
        b=L5KQ9YX5wmWviwyjybUPSMatIbVZi7cHsTNzPnL02RKLFPDumezpr+La4hHYAA1XjL
         nFV6fj0TRQJK9Gorgo98V/7B0gY5INzRpGfPVMF+9li5eLoROUEFawFPam7D6dpARI1k
         wqYtaEFCp+HIInd0AOjMebfijn87Gz4n4/YRXa0KFzzubETb6a1q1z7bZ+ki+1Kkp8mH
         Yo4RRct9XyG+Wu1+LiBOR9aZX7d1WIuA0jYEvg+zsfK8lkj/MG2f1yF7x7ru4vscm+vk
         maZ88pZOEFAaXpcMVeXMv3Z5JQEraMX9RmMPae3MJcUV6r4KLZ4b4p2E6oBFJQQh4mDU
         ldmA==
X-Gm-Message-State: AOAM531wI9ag5kjFTu329IV4eyHLj5ZRchgQbjWqc9llXH4zkQIMvaa9
        NYbx7/wH0WAXq1DKzo2/33tfc0BBoH0wUTt+CZ5FoaWXME6MiSm4
X-Google-Smtp-Source: ABdhPJz9tGrO1StXavnxOTQyCi5QMwWCOL4fTMEg9HcZMKbK4MGKZX/TZ60qc4rgaKnd1oi+7TTYMIyXc9PLf2/Qwdc=
X-Received: by 2002:a17:902:c808:b029:e6:4204:f62f with SMTP id
 u8-20020a170902c808b02900e64204f62fmr7095169plx.0.1616520473558; Tue, 23 Mar
 2021 10:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <1615507142-23097-1-git-send-email-wcheng@codeaurora.org>
 <CAHp75VfUVCB4gzgOWf=bUpCjfyerQLPN_p-vOnVfxUKHi1WJkg@mail.gmail.com>
 <716dca12-2bfc-789f-ca74-5555852e4c8b@codeaurora.org> <CAHp75VeynZArUkrogdJdR9oh+6Ocuqz3ySeDoRBFWusm8F6NRQ@mail.gmail.com>
 <39fdd3c8-9682-6109-f47d-7f7bffc4b85e@codeaurora.org> <CAHp75Vexow3KLjAueNoPrEhXmWk_4AjUpWXOyWcFLZdfB-o2iA@mail.gmail.com>
 <5252d085-bbd6-0409-a8ca-2b73fe269259@codeaurora.org>
In-Reply-To: <5252d085-bbd6-0409-a8ca-2b73fe269259@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 23 Mar 2021 19:27:37 +0200
Message-ID: <CAHp75VdR99vMOz-JPKKCfVvnsBd9SjGxhDtLsa_Zz2SKpWaZOQ@mail.gmail.com>
Subject: Re: [PATCH v3] usb: dwc3: gadget: Prevent EP queuing while stopping transfers
To:     Wesley Cheng <wcheng@codeaurora.org>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 1:19 AM Wesley Cheng <wcheng@codeaurora.org> wrote:
>
> Hi Andy,
>
> On 3/22/2021 2:14 PM, Andy Shevchenko wrote:
> > On Mon, Mar 22, 2021 at 10:06 PM Wesley Cheng <wcheng@codeaurora.org> wrote:
> >>
> >> Hi Andy,
> >>
> >> On 3/22/2021 12:34 PM, Andy Shevchenko wrote:
> >>> On Mon, Mar 22, 2021 at 8:49 PM Wesley Cheng <wcheng@codeaurora.org> wrote:
> >>>>
> >>>> Hi Andy,
> >>>>
> >>>> On 3/22/2021 5:48 AM, Andy Shevchenko wrote:
> >>>>> On Fri, Mar 12, 2021 at 2:01 AM Wesley Cheng <wcheng@codeaurora.org> wrote:
> >>>>>>
> >>>>>> In the situations where the DWC3 gadget stops active transfers, once
> >>>>>> calling the dwc3_gadget_giveback(), there is a chance where a function
> >>>>>> driver can queue a new USB request in between the time where the dwc3
> >>>>>> lock has been released and re-aquired.  This occurs after we've already
> >>>>>> issued an ENDXFER command.  When the stop active transfers continues
> >>>>>> to remove USB requests from all dep lists, the newly added request will
> >>>>>> also be removed, while controller still has an active TRB for it.
> >>>>>> This can lead to the controller accessing an unmapped memory address.
> >>>>>>
> >>>>>> Fix this by ensuring parameters to prevent EP queuing are set before
> >>>>>> calling the stop active transfers API.
> >>>>>
> >>>>>
> >>>>> commit f09ddcfcb8c569675066337adac2ac205113471f
> >>>>> Author: Wesley Cheng <wcheng@codeaurora.org>
> >>>>> Date:   Thu Mar 11 15:59:02 2021 -0800
> >>>>>
> >>>>>    usb: dwc3: gadget: Prevent EP queuing while stopping transfers
> >>>>>
> >>>>> effectively broke my gadget setup.
> >>>>>
> >>>>> The output of the kernel (followed by non responsive state of USB controller):
> >>>>>
> >>>>> [  195.228586] using random self ethernet address
> >>>>> [  195.233104] using random host ethernet address
> >>>>> [  195.245306] usb0: HOST MAC aa:bb:cc:dd:ee:f2
> >>>>> [  195.249732] usb0: MAC aa:bb:cc:dd:ee:f1
> >>>>> # [  195.773594] IPv6: ADDRCONF(NETDEV_CHANGE): usb0: link becomes ready
> >>>>> [  195.780585] ------------[ cut here ]------------
> >>>>> [  195.785217] dwc3 dwc3.0.auto: No resource for ep2in
> >>>>> [  195.790162] WARNING: CPU: 0 PID: 217 at
> >>>>> drivers/usb/dwc3/gadget.c:360 dwc3_send_gadget_ep_cmd+0x4b9/0x670
> >>>>> [  195.799760] Modules linked in: usb_f_eem u_ether libcomposite
> >>>>> brcmfmac brcmutil mmc_block pwm_lpss_pci pwm_lps
> >>>>> s snd_sof_pci_intel_tng snd_sof_pci snd_sof_acpi_intel_byt
> >>>>> snd_sof_intel_ipc snd_sof_acpi snd_sof snd_sof_nocodec
> >>>>> spi_pxa2xx_platform snd_sof_xtensa_dsp spi_pxa2xx_pci
> >>>>> extcon_intel_mrfld intel_mrfld_adc sdhci_pci cqhci sdhci m
> >>>>> mc_core intel_mrfld_pwrbtn intel_soc_pmic_mrfld hci_uart btbcm btintel
> >>>>> [  195.835604] CPU: 0 PID: 217 Comm: irq/16-dwc3 Not tainted 5.12.0-rc4+ #60
> >>>>> [  195.842403] Hardware name: Intel Corporation Merrifield/BODEGA BAY,
> >>>>> BIOS 542 2015.01.21:18.19.48
> >>>>> [  195.851191] RIP: 0010:dwc3_send_gadget_ep_cmd+0x4b9/0x670
> >>>>> [  195.856608] Code: cd 00 00 00 44 89 44 24 20 48 89 4c 24 18 e8 ee
> >>>>> f7 e4 ff 48 8b 4c 24 18 4c 89 f2 48 c7 c7 b9
> >>>>> ed 4f a0 48 89 c6 e8 ef 24 43 00 <0f> 0b 41 be ea ff ff ff 44 8b 44 24
> >>>>> 20 e9 80 fc ff ff 41 83 fe 92
> >>>>> [  195.875381] RSP: 0000:ffffa53c00373ba8 EFLAGS: 00010086
> >>>>> [  195.880617] RAX: 0000000000000000 RBX: 0000000000001387 RCX: 00000000ffffdfff
> >>>>> [  195.887755] RDX: 00000000ffffdfff RSI: 00000000ffffffea RDI: 0000000000000000
> >>>>> [  195.894893] RBP: ffff9ce8c8f2b028 R08: ffffffffa0732288 R09: 0000000000009ffb
> >>>>> [  195.902034] R10: 00000000ffffe000 R11: 3fffffffffffffff R12: 0000000000041006
> >>>>> [  195.909170] R13: ffffa53c00373c24 R14: ffff9ce8c11dadb0 R15: ffff9ce8c2861700
> >>>>> [  195.916310] FS:  0000000000000000(0000) GS:ffff9ce8fe200000(0000)
> >>>>> knlGS:0000000000000000
> >>>>> [  195.924409] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>>> [  195.930161] CR2: 00000000f7f694a0 CR3: 0000000038e0c000 CR4: 00000000001006f0
> >>>>> [  195.937300] Call Trace:
> >>>>> [  195.939755]  __dwc3_gadget_ep_enable+0x2d4/0x4e0
> >>>>> [  195.944393]  ? dwc3_remove_requests.constprop.0+0x86/0x170
> >>>>
> >>>> Odd that this change would affect the USB enablment path, as they were
> >>>> focused on the pullup disable path.  Would you happen to have any
> >>>> downstream changes on top of v5.12-rc4 we could review to see if they
> >>>> are still required? (ie where is the dwc3_remove_requests() coming from
> >>>> during ep enable)
> >>>
> >>> You may check my branch [1] on GH. Basically you may be interested in
> >>> the commit:
> >>> 0f86df1294ee7523060cc16eafaf4898c693eab0 REVERTME: usb: dwc3: gadget:
> >>> skip endpoints ep[18]{in,out}
> >>> Otherwise it's a clean v5.12-rc4 with a revert and another USB PHY
> >>> suspend fix (which also shouldn't affect this).
> >>
> >> Can you link your GH reference?
> >
> > Oops, sorry.
> > Here we are:
> >
> > [1]: https://github.com/andy-shev/linux/tree/eds-acpi
> >
> Thanks, I took a look and even tried it on my device running 5.12-rc4,
> but wasn't able to see the same problem.  Could you help collect the
> ftrace after enabling the tracing KCONFIG and running the below sequence?
>
> 1.  Mount debugfs
> 2.  Set up tracing instance
>
> mkdir /sys/kernel/debug/tracing/instances/usb
> echo 1 >
> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_complete_trb/enable
> echo 1 >
> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_ctrl_req/enable
> echo 1 >
> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_ep_dequeue/enable
> echo 1 >
> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_ep_queue/enable
> echo 1 >
> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_gadget_ep_cmd/enable
> echo 1 >
> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_gadget_ep_disable/enable
> echo 1 >
> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_gadget_ep_enable/enable
> echo 1 >
> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_gadget_giveback/enable
> echo 1 >
> /sys/kernel/debug/tracing/instances/usb/events/dwc3/dwc3_prepare_trb/enable
> echo 1 > /sys/kernel/debug/tracing/instances/usb/tracing_on
>
> 3.  Run your test, which should include:
>         - echo "" > /sys/kernel/config/usb_gadget/g1/UDC
>         - echo <UDC name> > /sys/kernel/config/usb_gadget/g1/UDC
>
> 4.  Collect the trace output:
> cat /sys/kernel/debug/tracing/instances/usb/trace

Here we are (I cherry-picked again reverted patch, other stays the same) [2].
On top I put a warning, so you may see timestamps.

Dunno how long it will stay there, please confirm that you got it.

[2]: https://paste.ubuntu.com/p/jNF565ypPp/

-- 
With Best Regards,
Andy Shevchenko
