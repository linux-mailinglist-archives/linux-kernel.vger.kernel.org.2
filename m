Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31973CC22D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 11:32:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbhGQJfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 05:35:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48582 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231862AbhGQJfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 05:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626514329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sNjMbKlUTmYJdQu+Ev/zt678j19UGbU7yNLsopZLxow=;
        b=bsrznb5VVD2mVMI1Fboj0qPk4u1NGwjPXoBPHwVFyvJ6tKYnvWng/xZfsRKPLT8NytVdIZ
        WGQj1aqkK9I+4kY2m/iGkxv5/M0UlxTkzaRHZz4HQTlC86CxhDx5ytqMKFD6amlSmfcvVG
        9p/hZt0xkHtCh9lGomq284KiCj5ZVsw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-T7L5uhr-N7-kW5809uPmBA-1; Sat, 17 Jul 2021 05:32:08 -0400
X-MC-Unique: T7L5uhr-N7-kW5809uPmBA-1
Received: by mail-ed1-f72.google.com with SMTP id z13-20020a05640235cdb02903aa750a46efso6124836edc.8
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 02:32:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sNjMbKlUTmYJdQu+Ev/zt678j19UGbU7yNLsopZLxow=;
        b=gHGOXCQ5Jx+JJFClAkR/j80UnbG+jS8pFiX+xZuEbIvvW2ej9XVILbapr2BaexLhHY
         HvZbHsS+oHa47m01uWKJ52PRzuLBI90Y0CwHXDSGWmizM6rIxEFnM6Q1DVWynmICG/6v
         hclJH8J6q1mLjHcCa2gPAmss6bFA1ry/OnWOMIlEFntazh6cIIj75V/JHOT6AANI2VPK
         GRZB2tOzUu1jfGnW96yWzkBqK2WkpfDck8/Xmd9lr1ewt9l5+ApNG+zTeWHSP5hXDuqk
         8mAPuhW+iQ/gswYXMZo3AsB8rETZDYiJwULhVHmSngyV+OLpWnYdLsXEv7Pi9JOujOXg
         W01A==
X-Gm-Message-State: AOAM531fo2AWJT2jpgmJ37VWbN30d+xuD4nkgnPOvYjMtnOHGo4Z6PzY
        ySvf4OKP+rZZReoWwBsVw3+cULYxgDNY0P8M40ZzbBvbBiTmMPLnttH2lg0hoTBisVDK9cwYVCo
        73+kkpfAICoNCYHW8iXlMiIV9Htev1EnO17kE5In1uewKzU7OHiNnryAqkHlJ97WGWd15polL0P
        Q5
X-Received: by 2002:a05:6402:3489:: with SMTP id v9mr5888544edc.124.1626514317819;
        Sat, 17 Jul 2021 02:31:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0wFNzsifbnm9oOXfqizEIdZoHgseiGYXa2LzF61PqUhcViIaGZDb0G4ydtqzMHFwTI35Bzg==
X-Received: by 2002:a05:6402:3489:: with SMTP id v9mr5888520edc.124.1626514317601;
        Sat, 17 Jul 2021 02:31:57 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id u9sm3457973eje.31.2021.07.17.02.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Jul 2021 02:31:57 -0700 (PDT)
Subject: Re: [PATCH] Bluetooth: btusb: Make the CSR clone chip force-suspend
 workaround more generic
To:     Ismael Ferreras Morezuelas <swyterzone@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <906e95ce-b0e5-239e-f544-f34d8424c8da@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b238f666-9238-fb42-cd46-ad628e576218@redhat.com>
Date:   Sat, 17 Jul 2021 11:31:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <906e95ce-b0e5-239e-f544-f34d8424c8da@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/17/21 1:21 AM, Ismael Ferreras Morezuelas wrote:
> Turns out Hans de Goede completed the work I started last year trying to
> improve Chinese-clone detection of CSR controller chips. Quirk after quirk
> these Bluetooth dongles are more usable now.
> 
> Even after a few BlueZ regressions; these clones are so fickle that some
> days they stop working altogether. Except on Windows, they work fine.
> 
> 
> But this force-suspend initialization quirk seems to mostly do the trick,
> after a lot of testing Bluetooth now seems to work *all* the time.
> 
> The only problem is that the solution ended up being masked under a very
> stringent check; when there are probably hundreds of fake dongle
> models out there that benefit from a good reset. Make it so.
> 
> 
> Fixes: 81cac64ba258a ("Bluetooth: Deal with USB devices that are faking CSR vendor")
> Fixes: cde1a8a992875 ("Bluetooth: btusb: Fix and detect most of the Chinese Bluetooth controllers")
> Fixes: d74e0ae7e0303 ("Bluetooth: btusb: Fix detection of some fake CSR controllers with a bcdDevice val of 0x0134")
> Fixes: 0671c0662383e ("Bluetooth: btusb: Add workaround for remote-wakeup issues with Barrot 8041a02 fake CSR controllers")
> 
> Cc: stable@vger.kernel.org
> Cc: Hans de Goede <hdegoede@redhat.com>
> Tested-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>
> Signed-off-by: Ismael Ferreras Morezuelas <swyterzone@gmail.com>

FWIW I'm fine with making the force-suspend once quirk which
I added generic to all clones.

The new code looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans





> ---
> 
> I've changed the warning line to make it easy to grep and detect if this updated
> workaround is part of the driver. Should make it much more obvious to users in
> case their dongle doesn't work for other reasons. There's a clear then-now.
> 
> Easy to narrow other future issues down. Let me know what you think.
> 
>  drivers/bluetooth/btusb.c | 61 +++++++++++++++++++++------------------
>  1 file changed, 33 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index a9855a2dd..197cafe75 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -1890,7 +1890,7 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>  		is_fake = true;
>  
>  	if (is_fake) {
> -		bt_dev_warn(hdev, "CSR: Unbranded CSR clone detected; adding workarounds...");
> +		bt_dev_warn(hdev, "CSR: Unbranded CSR clone detected; adding workarounds and force-suspending once...");
>  
>  		/* Generally these clones have big discrepancies between
>  		 * advertised features and what's actually supported.
> @@ -1907,41 +1907,46 @@ static int btusb_setup_csr(struct hci_dev *hdev)
>  		clear_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
>  
>  		/*
> -		 * Special workaround for clones with a Barrot 8041a02 chip,
> -		 * these clones are really messed-up:
> -		 * 1. Their bulk rx endpoint will never report any data unless
> -		 * the device was suspended at least once (yes really).
> +		 * Special workaround for these BT 4.0 chip clones, and potentially more:
> +		 *
> +		 * - 0x0134: a Barrot 8041a02                 (HCI rev: 0x1012 sub: 0x0810)
> +		 * - 0x7558: IC markings FR3191AHAL 749H15143 (HCI rev/sub-version: 0x0709)
> +		 *
> +		 * These controllers are really messed-up.
> +		 *
> +		 * 1. Their bulk RX endpoint will never report any data unless
> +		 * the device was suspended at least once (yes, really).
>  		 * 2. They will not wakeup when autosuspended and receiving data
> -		 * on their bulk rx endpoint from e.g. a keyboard or mouse
> +		 * on their bulk RX endpoint from e.g. a keyboard or mouse
>  		 * (IOW remote-wakeup support is broken for the bulk endpoint).
>  		 *
>  		 * To fix 1. enable runtime-suspend, force-suspend the
> -		 * hci and then wake-it up by disabling runtime-suspend.
> +		 * HCI and then wake-it up by disabling runtime-suspend.
>  		 *
> -		 * To fix 2. clear the hci's can_wake flag, this way the hci
> +		 * To fix 2. clear the HCI's can_wake flag, this way the HCI
>  		 * will still be autosuspended when it is not open.
> +		 *
> +		 * --
> +		 *
> +		 * Because these are widespread problems we prefer generic solutions; so
> +		 * apply this initialization quirk to every controller that gets here,
> +		 * it should be harmless. The alternative is to not work at all.
>  		 */
> -		if (bcdDevice == 0x8891 &&
> -		    le16_to_cpu(rp->lmp_subver) == 0x1012 &&
> -		    le16_to_cpu(rp->hci_rev) == 0x0810 &&
> -		    le16_to_cpu(rp->hci_ver) == BLUETOOTH_VER_4_0) {
> -			bt_dev_warn(hdev, "CSR: detected a fake CSR dongle using a Barrot 8041a02 chip, this chip is very buggy and may have issues");
> -
> -			pm_runtime_allow(&data->udev->dev);
> +		pm_runtime_allow(&data->udev->dev);
>  
> -			ret = pm_runtime_suspend(&data->udev->dev);
> -			if (ret >= 0)
> -				msleep(200);
> -			else
> -				bt_dev_err(hdev, "Failed to suspend the device for Barrot 8041a02 receive-issue workaround");
> -
> -			pm_runtime_forbid(&data->udev->dev);
> -
> -			device_set_wakeup_capable(&data->udev->dev, false);
> -			/* Re-enable autosuspend if this was requested */
> -			if (enable_autosuspend)
> -				usb_enable_autosuspend(data->udev);
> -		}
> +		ret = pm_runtime_suspend(&data->udev->dev);
> +		if (ret >= 0)
> +			msleep(200);
> +		else
> +			bt_dev_err(hdev, "CSR: Failed to suspend the device for our Barrot 8041a02 receive-issue workaround");
> +
> +		pm_runtime_forbid(&data->udev->dev);
> +
> +		device_set_wakeup_capable(&data->udev->dev, false);
> +
> +		/* Re-enable autosuspend if this was requested */
> +		if (enable_autosuspend)
> +			usb_enable_autosuspend(data->udev);
>  	}
>  
>  	kfree_skb(skb);
> 

