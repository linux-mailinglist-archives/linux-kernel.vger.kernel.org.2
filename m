Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0AD37FB8B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 18:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235143AbhEMQe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 12:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbhEMQeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 12:34:19 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5559C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:33:08 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id f12so21877739ljp.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 May 2021 09:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C/QfLWD8Xqt9UIViKXUrLpblQdXSN/8NOgs6zBwx2hw=;
        b=jlROOaZBhibsAw09TeKIm7N+084+yhKb3hhgDv9pioMpQ0xKfjboIV+l1Wp9gMXaUo
         WoG+PoJ9UUPsVHVz19vTvuqOIgRAf1pTNwjugG3n0MfF9XxAsqMJnsWWVcXKPDZs3uZz
         EP3KtK/g6zuN81Ex/o9OOJzTw5XdaojCfTNzml9sKfkyFNnBocF0C5I1mW82Epu6RlzH
         RjHutg8IFMyFve11b4JNZDleFFSBPfZ7cuggYmLmEC71dHy4IZx9ckyBp6OpoxDXQe8B
         J5oSwBsixNrvudNVm8Cv+Wz7V973D4YsAbVZMnO+p3ZqvZYBm3D/AePM1ke4Fdm0oTVJ
         NDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C/QfLWD8Xqt9UIViKXUrLpblQdXSN/8NOgs6zBwx2hw=;
        b=O108pxJI397edaq3YutnSk0bsWmabDuhk3Ee4fqnerSm16XVYF0vX5XGNGj9jgIakj
         t4fTU8F72XBOQWHFUhEkJe13wrdv9liG2kXquhv/dSlhwpv+BdpkuJjnzz4+FFmDTYDk
         hhENVEsUd/01uGFynrcXl5ynw+yi4pzv6gyS2BvZg3RzfVpeo005/pFPARbkk9IvyNXy
         JfnPG4wedUiN42lsZ4MkXxoxUOS/dDj0Ht7HNmj0pjeqIf1rr/YB5dtYVSKa6wjnEMwQ
         L/knyHd2xrZOTFWmKBAPOzFe01ZtBAWqpoKY/9BQxTK4cktX2FUxR6RpgL19gGfm2AW+
         6uVA==
X-Gm-Message-State: AOAM530JFjGvfn4x/z1IKdo0Qfockp+5/j4ltoPAnEs2r7oGaY1TXNX5
        FKqfOH1XIcTlnI4LHAEZRVgNSYA35iDoKvK1zh+Aog==
X-Google-Smtp-Source: ABdhPJxX+++UrOr4PBMqz8ryAEAyNFDDmAZcNogphFHWVVhZGRHB+PqnUDmWJKFYvaDzoCtdSOTupy4dMqSAR/QvI5Q=
X-Received: by 2002:a2e:3305:: with SMTP id d5mr35245102ljc.102.1620923587060;
 Thu, 13 May 2021 09:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210513165327.1.I4d214bb82746fb2ed94eb1c2100dda0f63cf9a25@changeid>
 <7867EC1F-324A-4739-B5F7-DDEB3994EA7A@holtmann.org>
In-Reply-To: <7867EC1F-324A-4739-B5F7-DDEB3994EA7A@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 14 May 2021 00:32:55 +0800
Message-ID: <CAJQfnxE4PY09GpxGYLKy2kXnaCQaUmCakhCKnhqGnoK+9aSyyg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_h5: Add RTL8822CS capabilities
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re-sending in plaintext, sorry for spam]
Hi Marcel,

On Thu, 13 May 2021 at 23:14, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> > RTL8822 chipset supports WBS, and this information is conveyed in
> > btusb.c. However, the UART driver doesn't have this information just
> > yet.
> >
> > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> >
> > drivers/bluetooth/btrtl.c  | 26 ++++++++++++++++----------
> > drivers/bluetooth/btrtl.h  |  2 ++
> > drivers/bluetooth/hci_h5.c |  5 +----
> > 3 files changed, 19 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> > index e7fe5fb22753..988a09860c6b 100644
> > --- a/drivers/bluetooth/btrtl.c
> > +++ b/drivers/bluetooth/btrtl.c
> > @@ -719,17 +719,8 @@ int btrtl_download_firmware(struct hci_dev *hdev,
> > }
> > EXPORT_SYMBOL_GPL(btrtl_download_firmware);
> >
> > -int btrtl_setup_realtek(struct hci_dev *hdev)
> > +void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
> > {
> > -     struct btrtl_device_info *btrtl_dev;
> > -     int ret;
> > -
> > -     btrtl_dev = btrtl_initialize(hdev, NULL);
> > -     if (IS_ERR(btrtl_dev))
> > -             return PTR_ERR(btrtl_dev);
> > -
> > -     ret = btrtl_download_firmware(hdev, btrtl_dev);
> > -
> >       /* Enable controller to do both LE scan and BR/EDR inquiry
> >        * simultaneously.
> >        */
> > @@ -750,6 +741,21 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
> >               rtl_dev_dbg(hdev, "WBS supported not enabled.");
> >               break;
> >       }
> > +}
> > +EXPORT_SYMBOL_GPL(btrtl_set_quirks);
> > +
> > +int btrtl_setup_realtek(struct hci_dev *hdev)
> > +{
> > +     struct btrtl_device_info *btrtl_dev;
> > +     int ret;
> > +
> > +     btrtl_dev = btrtl_initialize(hdev, NULL);
> > +     if (IS_ERR(btrtl_dev))
> > +             return PTR_ERR(btrtl_dev);
> > +
> > +     ret = btrtl_download_firmware(hdev, btrtl_dev);
> > +
> > +     btrtl_set_quirks(hdev, btrtl_dev);
> >
> >       btrtl_free(btrtl_dev);
> >       return ret;
> > diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> > index 2a582682136d..260167f01b08 100644
> > --- a/drivers/bluetooth/btrtl.h
> > +++ b/drivers/bluetooth/btrtl.h
> > @@ -54,6 +54,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
> > void btrtl_free(struct btrtl_device_info *btrtl_dev);
> > int btrtl_download_firmware(struct hci_dev *hdev,
> >                           struct btrtl_device_info *btrtl_dev);
> > +void btrtl_set_quirks(struct hci_dev *hdev,
> > +                   struct btrtl_device_info *btrtl_dev);
> > int btrtl_setup_realtek(struct hci_dev *hdev);
> > int btrtl_shutdown_realtek(struct hci_dev *hdev);
> > int btrtl_get_uart_settings(struct hci_dev *hdev,
> > diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> > index 27e96681d583..e0520639f4ba 100644
> > --- a/drivers/bluetooth/hci_h5.c
> > +++ b/drivers/bluetooth/hci_h5.c
> > @@ -906,10 +906,7 @@ static int h5_btrtl_setup(struct h5 *h5)
> >       /* Give the device some time before the hci-core sends it a reset */
> >       usleep_range(10000, 20000);
> >
> > -     /* Enable controller to do both LE scan and BR/EDR inquiry
> > -      * simultaneously.
> > -      */
> > -     set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->quirks);
> > +     btrtl_set_quirks(h5->hu->hdev, btrtl_dev);
>
> any reason why not just setting WBS quirk here?

Hmm, I think WBS is the feature of the chipset and not the transport.
Therefore isn't it better to just have it set in one place?
Setting the quirks here means we need to copy paste the settings from btrtl.c.

Cheers,
Archie
