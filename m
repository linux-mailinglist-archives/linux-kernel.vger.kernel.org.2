Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EA5443D928
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 04:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhJ1CJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 22:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJ1CJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 22:09:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D12CEC061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 19:07:10 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id u18so7330455wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 19:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=q11tY1kGQW9LucW8sG+xXia7coWutkfUkM0ceajT1RA=;
        b=owuNgYs6U6AaLEb+ag9tJ1PROAS+bUOqJXwofksm3VDghWPaKWGxlkV98pM7Nfk64s
         GipkV8MZmxI5AjD5KnI1NcrMiQr/ZTecfzRdfmZEUI0bASj5aMhQiro1fK2SBCrqdx0n
         CxHsFE71vnyHGJlTTd8QenW5Gq7DFhlthy4EULGVJraN5euuBvlExJKtpKKJiMDju/WB
         zpbIRyZuiCC3V9izpA8iEsAJiTZn1Oc09TUTrFDrlxZal3yD2gXLE746IObz0I/trJQZ
         ZWWcIwh4Z+uJR4mXR3Mg+DPNmNOpYg0x9Kg4Ok90PYgSSwuuhWPpQVkpWs8mVA2rJM7W
         uzRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=q11tY1kGQW9LucW8sG+xXia7coWutkfUkM0ceajT1RA=;
        b=VDJo6ObXLPBSuyHpDCYcfcjDTJoM1k96/qvXV4iNN9GbJNfRFvhtVEqsTu/RAhe81n
         tDex9flQ4Yb/oGTobLMGEzA2VZaBIkpDTgLAfs56Z0+9CH7YnOCqPnYOFxLuJivcCpIN
         MrWXi6mMdawDmGQfqTRHTmrngESI/z8dLkzdKvSB1RVTQUpTXq5E3K9oAd3DZWsvTA52
         ehRZXpCplQ026ZG+MtEsJgtNaliD6Emyw9w1emz2mY6y4hlmdaqvMluAA37uxgBXD/6N
         cQDuCmAnVW0FJQ/Xov2iw7XsIzR8mxHcsKKqrAlAKTlx7NSTy88+EhwBu077NGrsxRAR
         exnw==
X-Gm-Message-State: AOAM531Nf4Sg170D9npA1MfPYazOArv+ZcDjYC9b5XjTtFe/AaatOchr
        WBjJ5/HeKWFpbAOiP6c/dnEQ1QFcbq4XbeH1WscTug==
X-Google-Smtp-Source: ABdhPJzAn1/eEcEqbjXB6Do9zC+qw7f2VNzAuMmoU/faRGnQBW2s5WEIklTeU+hlmZ4p0w+Tk1ualxzCBhquObBY4bc=
X-Received: by 2002:a5d:64c8:: with SMTP id f8mr1812767wri.398.1635386829134;
 Wed, 27 Oct 2021 19:07:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210723193137.v3.1.I68649745bd11a83265f1e816bf34ecc82775e95a@changeid>
 <20210723193137.v3.3.I4b323d2adf1dca62777c41de344a7d2f79b7f908@changeid>
 <20211027222326.e55g26ezaxpk7kkm@core> <20211027234722.2rjmxhivrkae2fai@core>
In-Reply-To: <20211027234722.2rjmxhivrkae2fai@core>
From:   Archie Pusaka <apusaka@google.com>
Date:   Thu, 28 Oct 2021 10:06:58 +0800
Message-ID: <CAJQfnxFt5OVs1Tw9q6JVkQeKpEFfjyX6MM4qLkDLf02rRL7gew@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] Bluetooth: hci_h5: Add runtime suspend
To:     =?UTF-8?Q?Ond=C5=99ej_Jirman?= <megi@xff.cz>,
        Archie Pusaka <apusaka@google.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Hilda Wu <hildawu@realtek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,

There's a mistake on my side with the WAKEUP_DISABLE flag, but it's
fixed by Hans in this patch.
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/drivers/bluetooth/hci_h5.c?id=3D9a9023f314873241a43b5a2b96e9c0caaa=
958433
Could you try and see whether that fixes your issue?

Thanks,
Archie


On Thu, 28 Oct 2021 at 07:47, Ond=C5=99ej Jirman <megi@xff.cz> wrote:
>
> On Thu, Oct 28, 2021 at 12:23:26AM +0200, megi xff wrote:
> > Hello Archie,
> >
> > On Fri, Jul 23, 2021 at 07:31:57PM +0800, Archie Pusaka wrote:
> > > From: Archie Pusaka <apusaka@chromium.org>
> > >
> > > This patch allows the controller to suspend after a short period of
> > > inactivity.
> >
> > I see this pattern in dmesg after this patch: (I've added printks
> > to many hci_h5 functions to see what's going on)
> >
> > [  493.150325] h5_dequeue
> > [  493.150332] h5_dequeue
> > [  493.150336] h5_dequeue
> > [  493.150340] h5_dequeue
> > [  493.150370] h5_dequeue
> > [  493.150547] h5_recv
> > [  493.150863] h5_recv
> > [  493.150878] h5_dequeue
> > [  493.150885] h5_dequeue
> > [  493.150888] h5_dequeue
> > [  493.151315] h5_enqueue
> > [  493.151328] h5_dequeue
> > [  493.151350] h5_dequeue
> > [  493.151447] h5_dequeue
> > [  493.151612] h5_recv
> > [  493.151945] h5_recv
> > [  493.151961] h5_dequeue
> > [  493.151967] h5_dequeue
> > [  493.151970] h5_dequeue
> > [  495.171812] h5_flush
> > [  495.171845] h5_flush
> > [  499.267473] h5_serdev_suspend
> > [  499.267490] h5_btrtl_suspend
> > [  499.273784] h5_recv
> > [  499.273828] h5_serdev_resume
> > [  499.273833] h5_btrtl_resume
> > [  499.273837] h5_btrtl_resume / reprobe
> > [  499.273855] h5_btrtl_reprobe_worker
> > [  499.273913] h5_serdev_remove
> > [  499.274997] h5_close
> > [  499.275010] h5_btrtl_close
> > [  499.275624] h5_serdev_probe
> > [  499.276126] h5_open
> > [  499.276132] h5_btrtl_open
> > [  499.915820] h5_dequeue
> > [  499.915857] h5_dequeue
> > [  499.915863] h5_dequeue
> > [  499.916212] h5_dequeue
> > [  499.919643] h5_recv
> > [  499.919675] h5_dequeue
> > [  499.919682] h5_dequeue
> > [  499.919687] h5_dequeue
> > [  499.919692] h5_dequeue
> >
> > repeating ad nauseam every 6s.
> >
> > Basically bluetooth device reprobes every 6s. Looks like h5_recv call
> > after h5_btrtl_suspend wakes the device immediately after suspend.
> >
> > (there are no users of bluetooth in my userspace) I'd expect the
> > device to stay suspended after suspend.
> >
> > I have some extra patches to support 8723cs but nothing that
> > would affect this codepath. https://megous.com/git/linux/log/?h=3Dbt-5.=
15
> >
> > I assume it will have the same behavior with 8723bs which is already
> > mainline. I guess this issue is specific to devices with H5_INFO_WAKEUP=
_DISABLE
> > flag set.
> >
> > Do you have any ideas?
>
> I've added dump_stack() to first h5_recv call after suspend (the one
> that's causing the immediate wakeup after runtime PM suspend), and it ret=
urns:
>
> [    5.938258] recv
> [   13.377775] suspend
> [   13.384106] recv
> [   13.384120] CPU: 1 PID: 83 Comm: kworker/u8:1 Tainted: G         C    =
    5.15.0-rc7-00002-g64f2c49e8400 #23
> [   13.384141] Hardware name: Pine64 PinePhone (1.2) (DT)
> [   13.384151] Workqueue: events_unbound flush_to_ldisc
> [   13.384196] Call trace:
> [   13.384199]  dump_backtrace+0x0/0x15c
> [   13.384224]  show_stack+0x14/0x20
> [   13.384232]  dump_stack_lvl+0x64/0x7c
> [   13.384250]  dump_stack+0x14/0x2c
> [   13.384258]  h5_recv+0x44/0xdbc [hci_uart]
> [   13.384288]  hci_uart_receive_buf+0x6c/0x94 [hci_uart]
> [   13.384298]  ttyport_receive_buf+0x60/0xf4
> [   13.384318]  flush_to_ldisc+0xb0/0x160
> [   13.384324]  process_one_work+0x1d8/0x380
> [   13.384339]  worker_thread+0x178/0x4e0
> [   13.384348]  kthread+0x11c/0x130
> [   13.384359]  ret_from_fork+0x10/0x20
>
> It's comming from here https://elixir.bootlin.com/linux/latest/source/dri=
vers/tty/tty_buffer.c#L510
>
> Which can be scheduled from these places:
>
> - https://elixir.bootlin.com/linux/latest/source/drivers/tty/tty_buffer.c=
#L65
> - https://elixir.bootlin.com/linux/latest/source/drivers/tty/tty_buffer.c=
#L413
>
> And that's where I lose a thread of what can be happening. :)
>
> Maybe h5_recv is not a good function to mark activity on the device,
> due to tty_buffer code just calling it to check if some data are
> available, even if none are? Even if nothing uses bluetooth from
> userspace...
>
> kind regards,
>         o.
>
> > kind regards,
> >       o.
> >
> >
> > > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > > Reviewed-by: Hilda Wu <hildawu@realtek.com>
> > >
> > > ---
> > >
> > > Changes in v3:
> > > * Reordering #include
> > >
> > >  drivers/bluetooth/hci_h5.c | 20 ++++++++++++++++++++
> > >  1 file changed, 20 insertions(+)
> > >
> > > diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> > > index cbc63b057f33..0c0dedece59c 100644
> > > --- a/drivers/bluetooth/hci_h5.c
> > > +++ b/drivers/bluetooth/hci_h5.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/kernel.h>
> > >  #include <linux/mod_devicetable.h>
> > >  #include <linux/of_device.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/serdev.h>
> > >  #include <linux/skbuff.h>
> > >
> > > @@ -21,6 +22,8 @@
> > >  #include "btrtl.h"
> > >  #include "hci_uart.h"
> > >
> > > +#define SUSPEND_TIMEOUT_MS 6000
> > > +
> > >  #define HCI_3WIRE_ACK_PKT  0
> > >  #define HCI_3WIRE_LINK_PKT 15
> > >
> > > @@ -584,6 +587,10 @@ static int h5_recv(struct hci_uart *hu, const vo=
id *data, int count)
> > >             count -=3D processed;
> > >     }
> > >
> > > +   pm_runtime_get(&hu->serdev->dev);
> > > +   pm_runtime_mark_last_busy(&hu->serdev->dev);
> > > +   pm_runtime_put_autosuspend(&hu->serdev->dev);
> > > +
> > >     return 0;
> > >  }
> > >
> > > @@ -620,6 +627,10 @@ static int h5_enqueue(struct hci_uart *hu, struc=
t sk_buff *skb)
> > >             break;
> > >     }
> > >
> > > +   pm_runtime_get_sync(&hu->serdev->dev);
> > > +   pm_runtime_mark_last_busy(&hu->serdev->dev);
> > > +   pm_runtime_put_autosuspend(&hu->serdev->dev);
> > > +
> > >     return 0;
> > >  }
> > >
> > > @@ -951,6 +962,12 @@ static void h5_btrtl_open(struct h5 *h5)
> > >     serdev_device_set_parity(h5->hu->serdev, SERDEV_PARITY_EVEN);
> > >     serdev_device_set_baudrate(h5->hu->serdev, 115200);
> > >
> > > +   pm_runtime_set_active(&h5->hu->serdev->dev);
> > > +   pm_runtime_use_autosuspend(&h5->hu->serdev->dev);
> > > +   pm_runtime_set_autosuspend_delay(&h5->hu->serdev->dev,
> > > +                                    SUSPEND_TIMEOUT_MS);
> > > +   pm_runtime_enable(&h5->hu->serdev->dev);
> > > +
> > >     /* The controller needs up to 500ms to wakeup */
> > >     gpiod_set_value_cansleep(h5->enable_gpio, 1);
> > >     gpiod_set_value_cansleep(h5->device_wake_gpio, 1);
> > > @@ -959,6 +976,8 @@ static void h5_btrtl_open(struct h5 *h5)
> > >
> > >  static void h5_btrtl_close(struct h5 *h5)
> > >  {
> > > +   pm_runtime_disable(&h5->hu->serdev->dev);
> > > +
> > >     gpiod_set_value_cansleep(h5->device_wake_gpio, 0);
> > >     gpiod_set_value_cansleep(h5->enable_gpio, 0);
> > >  }
> > > @@ -1066,6 +1085,7 @@ MODULE_DEVICE_TABLE(acpi, h5_acpi_match);
> > >
> > >  static const struct dev_pm_ops h5_serdev_pm_ops =3D {
> > >     SET_SYSTEM_SLEEP_PM_OPS(h5_serdev_suspend, h5_serdev_resume)
> > > +   SET_RUNTIME_PM_OPS(h5_serdev_suspend, h5_serdev_resume, NULL)
> > >  };
> > >
> > >  static const struct of_device_id rtl_bluetooth_of_match[] =3D {
> > > --
> > > 2.32.0.432.gabb21c7263-goog
> > >
