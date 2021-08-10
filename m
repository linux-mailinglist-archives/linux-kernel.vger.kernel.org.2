Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBC53E2674
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243753AbhHFIvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhHFIve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:51:34 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6FDC061798
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 01:51:17 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j2so10059641wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 01:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=i3HIreYA7e+PTu1uya0LcVYjOhfUuTdBKhb3eZlbvSg=;
        b=zoURBE/zCK6Jg4cUCzmyQJIGyj71YgQhER3ymo6aSPDUoFev60BJfnaw+mAOCrN5fD
         bw7oIJp5qEA05l44xiD7+bns6dI9WKYIgmzZRYxrklC3YhMomgIaR+ItVJmVxMTj+S4K
         rLECMHDLQ25XJJxI4jk34iFtXQhsPtJI6xibQUhZdsngzxYdkzlu4U/MAy5AQZ+QgGlf
         Motx9cIWsbXeG0wdyDbvwblZJCf9Js3fv8AwNfyHt7j1T9UHo3LXWzvayiJ1MBZL/y4y
         py5MFPKewTyv716au90cxNhcJapwOhbBoBMKI5Hbr6MZ6mX7WUs6vfoEF27onHlIx4Nf
         5q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=i3HIreYA7e+PTu1uya0LcVYjOhfUuTdBKhb3eZlbvSg=;
        b=Kr51CTcj9fuVUhNFUFjw2G9QJvx75cuVVfi/sQngQ9RXCqKUeTsLKtZiSWkdvYA7SS
         dOoqtD6/BTthnUwE+zFCS3mLUGofDK/e/UDZwK82CZE/I+w9PCQ2TzJ7SlXQhLmTI7+2
         LDadxQ+FaSduTRuns8oQXN7BF65bMSEgRR1E1SMc4h1m1rmo6WhulPPPEz5Eb0y2Vcad
         KMbOQm5kHCWGkf56TFuCTN2eXlxVNM0mrtm55IL1wllwoVaytKkBAn2IFDokMAAzM8Ra
         YG3iIzOZRqlqbqGSrHaCMrhhcWaIO5RRHkzmMe00BzD+p0slKH8OaKttrQAVkCS6R5zB
         TAuw==
X-Gm-Message-State: AOAM531b4xtro0GevlSHhj2MFdJgRe5b7WW+x+CgVPqJz53I3YU7ecQS
        GaiY0wh73IUZwj4w5t02RR8GGQ==
X-Google-Smtp-Source: ABdhPJwJeV37G5icUbCsLwbm3RQZzW8r3qxYqn1uYTQ3qULpCThIsIRQqL6WTfH8r6I6ljU3VE1sYg==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr9577971wru.234.1628239876154;
        Fri, 06 Aug 2021 01:51:16 -0700 (PDT)
Received: from localhost ([2a01:cb19:826e:8e00:92f3:12fa:e0ef:50e9])
        by smtp.gmail.com with ESMTPSA id q14sm8988749wrm.66.2021.08.06.01.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 01:51:15 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Fabien Parent <fparent@baylibre.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Bluetooth: Shutdown controller after workqueues are
 flushed or cancelled
In-Reply-To: <CAAd53p5TVJk3G4cArS_UO7cgUpJLONNGVHnpezXy0XTYoXd_uw@mail.gmail.com>
References: <20210514071452.25220-1-kai.heng.feng@canonical.com>
 <576B26FD-81F8-4632-82F6-57C4A7C096C4@holtmann.org>
 <8735ryk0o7.fsf@baylibre.com>
 <CAAd53p7Zc3Zk21rwj_x1BLgf8tWRxaKBmXARkM6d7Kpkb+fDZA@mail.gmail.com>
 <87y29o58su.fsf@baylibre.com>
 <CAAd53p4Ss1Z-7CB4g=_xZYxo1xDz6ih6GHUuMcgncy+yNAfU4w@mail.gmail.com>
 <87a6lzx7jf.fsf@baylibre.com>
 <CAAd53p6T_K67CPthLPObF=OWWCEChW4pMFMwuq87qWmTmzP2VA@mail.gmail.com>
 <87bl6cnzy2.fsf@baylibre.com>
 <CAAd53p5TVJk3G4cArS_UO7cgUpJLONNGVHnpezXy0XTYoXd_uw@mail.gmail.com>
Date:   Fri, 06 Aug 2021 10:51:14 +0200
Message-ID: <87tuk3j6rh.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

Kai-Heng Feng <kai.heng.feng@canonical.com> writes:

> Hi Mattijs,
>
> On Thu, Aug 5, 2021 at 2:55 PM Mattijs Korpershoek
> <mkorpershoek@baylibre.com> wrote:
>>
>> Hi Kai-Heng,
>>
>> Thanks for your patch,
>>
>> Kai-Heng Feng <kai.heng.feng@canonical.com> writes:
>>
>
> [snipped]
>
>> I confirm this diff works for me:
>>
>> root@i500-pumpkin:~# hciconfig hci0 up
>> root@i500-pumpkin:~# hciconfig hci0 down
>> root@i500-pumpkin:~# hciconfig hci0 up
>> root@i500-pumpkin:~# hciconfig hci0
>> hci0:   Type: Primary  Bus: SDIO
>>         BD Address: 00:0C:E7:55:FF:12  ACL MTU: 1021:8  SCO MTU: 244:4
>>         UP RUNNING
>>         RX bytes:11268 acl:0 sco:0 events:829 errors:0
>>         TX bytes:182569 acl:0 sco:0 commands:829 errors:0
>>
>> root@i500-pumpkin:~# hcitool scan
>> Scanning ...
>>         <redacted>       Pixel 3 XL
>>
>> Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
> I found that btmtksdio_flush() only cancels the work instead of doing
> flush_work(). That probably explains why putting ->shutdown right
> before ->flush doesn't work.
> So can you please test the following again:
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> index 9872ef18f9fea..b33c05ad2150b 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -649,9 +649,9 @@ static int btmtksdio_flush(struct hci_dev *hdev)
>  {
>         struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
>
> -       skb_queue_purge(&bdev->txq);
> +       flush_work(&bdev->tx_work);
>
> -       cancel_work_sync(&bdev->tx_work);
> +       skb_queue_purge(&bdev->txq);
>
>         return 0;
>  }
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 2560ed2f144d4..a61e610a400cb 100644
>
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1785,6 +1785,14 @@ int hci_dev_do_close(struct hci_dev *hdev)
>         aosp_do_close(hdev);
>         msft_do_close(hdev);
>
> +       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
> +           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> +           test_bit(HCI_UP, &hdev->flags)) {
> +               /* Execute vendor specific shutdown routine */
> +               if (hdev->shutdown)
> +                       hdev->shutdown(hdev);
> +       }
> +
>         if (hdev->flush)
>                 hdev->flush(hdev);
>
> @@ -1798,14 +1806,6 @@ int hci_dev_do_close(struct hci_dev *hdev)
>                 clear_bit(HCI_INIT, &hdev->flags);
>         }
>
> -       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
> -           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> -           test_bit(HCI_UP, &hdev->flags)) {
> -               /* Execute vendor specific shutdown routine */
> -               if (hdev->shutdown)
> -                       hdev->shutdown(hdev);
> -       }
> -
>         /* flush cmd  work */
>         flush_work(&hdev->cmd_work);
I've tried this but I have the same (broken) symptoms as before.

Here are some logs of v3:
dmesg: https://pastebin.com/1x4UHkzy
ftrace: https://pastebin.com/Lm1d6AWy

Mattijs

>
> Kai-Heng
