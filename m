Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B30F38B400
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 18:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbhETQE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 12:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbhETQDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 12:03:50 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC37C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:02:24 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b12so13167956ljp.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 09:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jDrgqcc3k7nepG1SkpwVsguwmrI+16TCzS7szWNRwyI=;
        b=Rrj3D5YUkkGbPMibj9/9rE1x6uQ47qTK7WTL5scybaU0hAZPAwaJaNhk259OCTkiCH
         x/KSZI5jBjMJJmL0ji1qNkYgALh+dXMAUAV7pJEcQ8Y58dXQKEkK7pbRWTCLyEgjFCHs
         zCNdF1wPhwDs+PRN5hJQzIK+dGGKw9RfLWpXQN3qpVq+muifr5MwsbzvW+Sjs6sOFbYy
         2DVuAQ2w/U/pEN3TddcBcl9AqJmvIZzuPzoiYLU5sbGuFa5se7bHNmRcABYjMWE2VLdl
         0bKhb2QxmFwo0XNDNIieS+Dtm5FIWbZghnX486m+VyWxL1/+RGEIxng85upaJw5oj60a
         FTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jDrgqcc3k7nepG1SkpwVsguwmrI+16TCzS7szWNRwyI=;
        b=lrYeFVaHbQVPdr1VmBVIHypU+7jv3a6IPCkbeNvBHPkklwvw2nCMdvgcKsqYCHokSC
         3t+aAGnzrqAaOGbf5RiQKcS93CkQe9T3+6fJEUIC0PcTiTOwsNCG/BCxyWmnrKQyjaUV
         0LeQ2dYxTnxF9gXhblhcp6ZHkFVou2VVBqgPLuAOn8U5xyIbh80rIfp6oQOGzt+zg1Ox
         L/J5Sz6hwttCxrdeVWEubyZofvvPeXQCowFUzdywBaNxXwZWGAqhbYmAl0jXzVyTNmuS
         ehJrMLhVK7nfpD3Bv47kpQaF2z/WwbRiAacdxr3/mxEgPCBDeWGI2fxNkfrAZuFE/5KB
         GPmw==
X-Gm-Message-State: AOAM531d7Lfgl+YlbzdP7d13X/wxxwobBJhk7MSl2fKKp/el/c9GFldY
        LfiG+Aqd3bnar7IRJpFwvz4Dslm6F1zstDVk69yjYQ==
X-Google-Smtp-Source: ABdhPJxLawValRrk4pcVqZuVlbRnn1ovqu8k+VbbKQZdR4STNbqcDAWfWoOdSQRUXfcCpXDAoa5v7YQOobHUSvKFTkA=
X-Received: by 2002:a2e:3305:: with SMTP id d5mr3677101ljc.102.1621526541760;
 Thu, 20 May 2021 09:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210513165327.1.I4d214bb82746fb2ed94eb1c2100dda0f63cf9a25@changeid>
 <7867EC1F-324A-4739-B5F7-DDEB3994EA7A@holtmann.org> <CAJQfnxE4PY09GpxGYLKy2kXnaCQaUmCakhCKnhqGnoK+9aSyyg@mail.gmail.com>
 <DAE03499-573B-4A72-A2A9-2E139B78AB2E@holtmann.org> <CAJQfnxHg50mKGVpQoH-dobphAzpFwyc2gQMzVkLZeNUW0Yyh3Q@mail.gmail.com>
 <CAJQfnxG1ba=imd_BiOXpuT8WF8HeWPcs5y4kdKx+fV6LEL9SyA@mail.gmail.com> <3DB375AF-3BC3-43F3-A1F5-1E3CBF17318D@holtmann.org>
In-Reply-To: <3DB375AF-3BC3-43F3-A1F5-1E3CBF17318D@holtmann.org>
From:   Archie Pusaka <apusaka@google.com>
Date:   Fri, 21 May 2021 00:02:09 +0800
Message-ID: <CAJQfnxE+qiPor8xUd8zuJH45LmbrHb8YwcvjrnhkG0LovP1vyw@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Thu, 20 May 2021 at 23:18, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Archie,
>
> >>>>>> RTL8822 chipset supports WBS, and this information is conveyed in
> >>>>>> btusb.c. However, the UART driver doesn't have this information ju=
st
> >>>>>> yet.
> >>>>>>
> >>>>>> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> >>>>>> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> >>>>>> ---
> >>>>>>
> >>>>>> drivers/bluetooth/btrtl.c  | 26 ++++++++++++++++----------
> >>>>>> drivers/bluetooth/btrtl.h  |  2 ++
> >>>>>> drivers/bluetooth/hci_h5.c |  5 +----
> >>>>>> 3 files changed, 19 insertions(+), 14 deletions(-)
> >>>>>>
> >>>>>> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> >>>>>> index e7fe5fb22753..988a09860c6b 100644
> >>>>>> --- a/drivers/bluetooth/btrtl.c
> >>>>>> +++ b/drivers/bluetooth/btrtl.c
> >>>>>> @@ -719,17 +719,8 @@ int btrtl_download_firmware(struct hci_dev *h=
dev,
> >>>>>> }
> >>>>>> EXPORT_SYMBOL_GPL(btrtl_download_firmware);
> >>>>>>
> >>>>>> -int btrtl_setup_realtek(struct hci_dev *hdev)
> >>>>>> +void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_i=
nfo *btrtl_dev)
> >>>>>> {
> >>>>>> -     struct btrtl_device_info *btrtl_dev;
> >>>>>> -     int ret;
> >>>>>> -
> >>>>>> -     btrtl_dev =3D btrtl_initialize(hdev, NULL);
> >>>>>> -     if (IS_ERR(btrtl_dev))
> >>>>>> -             return PTR_ERR(btrtl_dev);
> >>>>>> -
> >>>>>> -     ret =3D btrtl_download_firmware(hdev, btrtl_dev);
> >>>>>> -
> >>>>>>     /* Enable controller to do both LE scan and BR/EDR inquiry
> >>>>>>      * simultaneously.
> >>>>>>      */
> >>>>>> @@ -750,6 +741,21 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
> >>>>>>             rtl_dev_dbg(hdev, "WBS supported not enabled.");
> >>>>>>             break;
> >>>>>>     }
> >>>>>> +}
> >>>>>> +EXPORT_SYMBOL_GPL(btrtl_set_quirks);
> >>>>>> +
> >>>>>> +int btrtl_setup_realtek(struct hci_dev *hdev)
> >>>>>> +{
> >>>>>> +     struct btrtl_device_info *btrtl_dev;
> >>>>>> +     int ret;
> >>>>>> +
> >>>>>> +     btrtl_dev =3D btrtl_initialize(hdev, NULL);
> >>>>>> +     if (IS_ERR(btrtl_dev))
> >>>>>> +             return PTR_ERR(btrtl_dev);
> >>>>>> +
> >>>>>> +     ret =3D btrtl_download_firmware(hdev, btrtl_dev);
> >>>>>> +
> >>>>>> +     btrtl_set_quirks(hdev, btrtl_dev);
> >>>>>>
> >>>>>>     btrtl_free(btrtl_dev);
> >>>>>>     return ret;
> >>>>>> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> >>>>>> index 2a582682136d..260167f01b08 100644
> >>>>>> --- a/drivers/bluetooth/btrtl.h
> >>>>>> +++ b/drivers/bluetooth/btrtl.h
> >>>>>> @@ -54,6 +54,8 @@ struct btrtl_device_info *btrtl_initialize(struc=
t hci_dev *hdev,
> >>>>>> void btrtl_free(struct btrtl_device_info *btrtl_dev);
> >>>>>> int btrtl_download_firmware(struct hci_dev *hdev,
> >>>>>>                         struct btrtl_device_info *btrtl_dev);
> >>>>>> +void btrtl_set_quirks(struct hci_dev *hdev,
> >>>>>> +                   struct btrtl_device_info *btrtl_dev);
> >>>>>> int btrtl_setup_realtek(struct hci_dev *hdev);
> >>>>>> int btrtl_shutdown_realtek(struct hci_dev *hdev);
> >>>>>> int btrtl_get_uart_settings(struct hci_dev *hdev,
> >>>>>> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5=
.c
> >>>>>> index 27e96681d583..e0520639f4ba 100644
> >>>>>> --- a/drivers/bluetooth/hci_h5.c
> >>>>>> +++ b/drivers/bluetooth/hci_h5.c
> >>>>>> @@ -906,10 +906,7 @@ static int h5_btrtl_setup(struct h5 *h5)
> >>>>>>     /* Give the device some time before the hci-core sends it a re=
set */
> >>>>>>     usleep_range(10000, 20000);
> >>>>>>
> >>>>>> -     /* Enable controller to do both LE scan and BR/EDR inquiry
> >>>>>> -      * simultaneously.
> >>>>>> -      */
> >>>>>> -     set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->qui=
rks);
> >>>>>> +     btrtl_set_quirks(h5->hu->hdev, btrtl_dev);
> >>>>>
> >>>>> any reason why not just setting WBS quirk here?
> >>>>
> >>>> Hmm, I think WBS is the feature of the chipset and not the transport=
.
> >>>> Therefore isn't it better to just have it set in one place?
> >>>> Setting the quirks here means we need to copy paste the settings fro=
m btrtl.c.
> >>>
> >>> but since you are already setting HCI_QUIRK_SIMULTANEOUS_DISCOVERY ri=
ght now, I don=E2=80=99t see the difference.
> >>
> >> Sorry, I don't get what you mean.
> >> With this patch I also moved HCI_QUIRK_SIMULTANEOUS_DISCOVERY into
> >> btrtl.c, so it's together with the WBS quirk.
> >>
> >>> Can we actually verify that we still need the WBS quirk. I think we f=
ixed the broken errerrnous packet flag handling.
> >>
> >> To be honest, I am not aware about the story of the broken erroneous
> >> packet flag.
> >> Last time I checked I still needed the quirk to have RTL8822 on UART
> >> properly run WBS, but that was months ago...
> >> Let me verify whether this quirk is still needed.
> >
> > It looks like we still need the WBS quirk because otherwise the host
> > wouldn't know whether the controller supports WBS or not. It's used in
> > get_supported_settings() in mgmt.c.
>
> and why not set it unconditionally for all Realtek chips?

Not all Realtek chips supports WBS, therefore
HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED is only set on some of them.

Thanks
Archie
