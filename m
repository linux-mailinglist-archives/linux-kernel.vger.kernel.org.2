Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F8F38B2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 17:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243715AbhETPT1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 20 May 2021 11:19:27 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:55597 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbhETPTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 11:19:25 -0400
Received: from smtpclient.apple (p4fefc9d6.dip0.t-ipconnect.de [79.239.201.214])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9BD4ACECEA;
        Thu, 20 May 2021 17:25:56 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.80.0.2.43\))
Subject: Re: [PATCH] Bluetooth: hci_h5: Add RTL8822CS capabilities
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAJQfnxG1ba=imd_BiOXpuT8WF8HeWPcs5y4kdKx+fV6LEL9SyA@mail.gmail.com>
Date:   Thu, 20 May 2021 17:18:02 +0200
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <3DB375AF-3BC3-43F3-A1F5-1E3CBF17318D@holtmann.org>
References: <20210513165327.1.I4d214bb82746fb2ed94eb1c2100dda0f63cf9a25@changeid>
 <7867EC1F-324A-4739-B5F7-DDEB3994EA7A@holtmann.org>
 <CAJQfnxE4PY09GpxGYLKy2kXnaCQaUmCakhCKnhqGnoK+9aSyyg@mail.gmail.com>
 <DAE03499-573B-4A72-A2A9-2E139B78AB2E@holtmann.org>
 <CAJQfnxHg50mKGVpQoH-dobphAzpFwyc2gQMzVkLZeNUW0Yyh3Q@mail.gmail.com>
 <CAJQfnxG1ba=imd_BiOXpuT8WF8HeWPcs5y4kdKx+fV6LEL9SyA@mail.gmail.com>
To:     Archie Pusaka <apusaka@google.com>
X-Mailer: Apple Mail (2.3654.80.0.2.43)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Archie,

>>>>>> RTL8822 chipset supports WBS, and this information is conveyed in
>>>>>> btusb.c. However, the UART driver doesn't have this information just
>>>>>> yet.
>>>>>> 
>>>>>> Signed-off-by: Archie Pusaka <apusaka@chromium.org>
>>>>>> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>>>>>> ---
>>>>>> 
>>>>>> drivers/bluetooth/btrtl.c  | 26 ++++++++++++++++----------
>>>>>> drivers/bluetooth/btrtl.h  |  2 ++
>>>>>> drivers/bluetooth/hci_h5.c |  5 +----
>>>>>> 3 files changed, 19 insertions(+), 14 deletions(-)
>>>>>> 
>>>>>> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
>>>>>> index e7fe5fb22753..988a09860c6b 100644
>>>>>> --- a/drivers/bluetooth/btrtl.c
>>>>>> +++ b/drivers/bluetooth/btrtl.c
>>>>>> @@ -719,17 +719,8 @@ int btrtl_download_firmware(struct hci_dev *hdev,
>>>>>> }
>>>>>> EXPORT_SYMBOL_GPL(btrtl_download_firmware);
>>>>>> 
>>>>>> -int btrtl_setup_realtek(struct hci_dev *hdev)
>>>>>> +void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *btrtl_dev)
>>>>>> {
>>>>>> -     struct btrtl_device_info *btrtl_dev;
>>>>>> -     int ret;
>>>>>> -
>>>>>> -     btrtl_dev = btrtl_initialize(hdev, NULL);
>>>>>> -     if (IS_ERR(btrtl_dev))
>>>>>> -             return PTR_ERR(btrtl_dev);
>>>>>> -
>>>>>> -     ret = btrtl_download_firmware(hdev, btrtl_dev);
>>>>>> -
>>>>>>     /* Enable controller to do both LE scan and BR/EDR inquiry
>>>>>>      * simultaneously.
>>>>>>      */
>>>>>> @@ -750,6 +741,21 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
>>>>>>             rtl_dev_dbg(hdev, "WBS supported not enabled.");
>>>>>>             break;
>>>>>>     }
>>>>>> +}
>>>>>> +EXPORT_SYMBOL_GPL(btrtl_set_quirks);
>>>>>> +
>>>>>> +int btrtl_setup_realtek(struct hci_dev *hdev)
>>>>>> +{
>>>>>> +     struct btrtl_device_info *btrtl_dev;
>>>>>> +     int ret;
>>>>>> +
>>>>>> +     btrtl_dev = btrtl_initialize(hdev, NULL);
>>>>>> +     if (IS_ERR(btrtl_dev))
>>>>>> +             return PTR_ERR(btrtl_dev);
>>>>>> +
>>>>>> +     ret = btrtl_download_firmware(hdev, btrtl_dev);
>>>>>> +
>>>>>> +     btrtl_set_quirks(hdev, btrtl_dev);
>>>>>> 
>>>>>>     btrtl_free(btrtl_dev);
>>>>>>     return ret;
>>>>>> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
>>>>>> index 2a582682136d..260167f01b08 100644
>>>>>> --- a/drivers/bluetooth/btrtl.h
>>>>>> +++ b/drivers/bluetooth/btrtl.h
>>>>>> @@ -54,6 +54,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>>>>>> void btrtl_free(struct btrtl_device_info *btrtl_dev);
>>>>>> int btrtl_download_firmware(struct hci_dev *hdev,
>>>>>>                         struct btrtl_device_info *btrtl_dev);
>>>>>> +void btrtl_set_quirks(struct hci_dev *hdev,
>>>>>> +                   struct btrtl_device_info *btrtl_dev);
>>>>>> int btrtl_setup_realtek(struct hci_dev *hdev);
>>>>>> int btrtl_shutdown_realtek(struct hci_dev *hdev);
>>>>>> int btrtl_get_uart_settings(struct hci_dev *hdev,
>>>>>> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
>>>>>> index 27e96681d583..e0520639f4ba 100644
>>>>>> --- a/drivers/bluetooth/hci_h5.c
>>>>>> +++ b/drivers/bluetooth/hci_h5.c
>>>>>> @@ -906,10 +906,7 @@ static int h5_btrtl_setup(struct h5 *h5)
>>>>>>     /* Give the device some time before the hci-core sends it a reset */
>>>>>>     usleep_range(10000, 20000);
>>>>>> 
>>>>>> -     /* Enable controller to do both LE scan and BR/EDR inquiry
>>>>>> -      * simultaneously.
>>>>>> -      */
>>>>>> -     set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &h5->hu->hdev->quirks);
>>>>>> +     btrtl_set_quirks(h5->hu->hdev, btrtl_dev);
>>>>> 
>>>>> any reason why not just setting WBS quirk here?
>>>> 
>>>> Hmm, I think WBS is the feature of the chipset and not the transport.
>>>> Therefore isn't it better to just have it set in one place?
>>>> Setting the quirks here means we need to copy paste the settings from btrtl.c.
>>> 
>>> but since you are already setting HCI_QUIRK_SIMULTANEOUS_DISCOVERY right now, I don’t see the difference.
>> 
>> Sorry, I don't get what you mean.
>> With this patch I also moved HCI_QUIRK_SIMULTANEOUS_DISCOVERY into
>> btrtl.c, so it's together with the WBS quirk.
>> 
>>> Can we actually verify that we still need the WBS quirk. I think we fixed the broken errerrnous packet flag handling.
>> 
>> To be honest, I am not aware about the story of the broken erroneous
>> packet flag.
>> Last time I checked I still needed the quirk to have RTL8822 on UART
>> properly run WBS, but that was months ago...
>> Let me verify whether this quirk is still needed.
> 
> It looks like we still need the WBS quirk because otherwise the host
> wouldn't know whether the controller supports WBS or not. It's used in
> get_supported_settings() in mgmt.c.

and why not set it unconditionally for all Realtek chips?

Regards

Marcel

