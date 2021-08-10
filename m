Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 436033E51CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 06:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235513AbhHJELZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 00:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbhHJELN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 00:11:13 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECB1C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 21:10:52 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id d22so30473514ioy.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 21:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Np0f18ZFlXmVe8dVpMu2fWUn3OdUUMnRBlt9eEUVc9Q=;
        b=FDo82R3+gzErO0YtuHji4oPRmykg+aMaEAbpRX3sfZ+CtijaZIq6cFmI3nEWa1CLkC
         aLTcILu+RnmFNIalWVJt+DIOqPpx7BEZ6j4sTvR35w7Fu0mqEogBIlsVEwcPGFF1xKpZ
         uFPAVHDVYdFrtpHh+HnUg5OMXXP+NuywtVu0w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Np0f18ZFlXmVe8dVpMu2fWUn3OdUUMnRBlt9eEUVc9Q=;
        b=hjFiicJ+X+nVTOdl33ky2StgWdfFFzYkPrIlqVHeTCSCurwPPBpXMoG9WyrPrwer/h
         RidLeplzDbpyfyQ+Sx+prCSBALfsMt6uygFBgUQJjCnoTdxRKbZ/V3ebdtP8QOObkCv5
         Dld67Gbz5xLX3PgyR+B34t1pez0ikCtwptpvXegnLp71GFOKDzlWsscmiMHjT3bxE2OC
         JT70mNLj0h8FL8IOTWtBWs5W6U/PB6iNyqEkZ2eiq4/BOzWlt9RYo7w+fDyD5LObntmX
         GrKnBhAIt9W3OyruV7tbsJv5bTp5+WvbKKV9sPLe5Yswd8ojp3UCGRVshdDkN8xSO/x9
         RKEQ==
X-Gm-Message-State: AOAM532sSd0y7VW7mhi/TqD+Oqqe14Ay0unm+qhkCZ12AOsmsEaItpFn
        sMuOkF9/17vRcR/isj1hv2pFfefj3cepG+X/ngMt3A==
X-Google-Smtp-Source: ABdhPJzYf1vzSJMUvVEiRjXqWv755BGtmDOWeEqcFFW1Hkb6cR15tyNXtYbCSlAXc4WwGaHefqQGTWIZ7YlVY7tGORw=
X-Received: by 2002:a5d:938a:: with SMTP id c10mr114512iol.0.1628568651827;
 Mon, 09 Aug 2021 21:10:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210809174358.163525-1-kai.heng.feng@canonical.com>
In-Reply-To: <20210809174358.163525-1-kai.heng.feng@canonical.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Tue, 10 Aug 2021 12:10:26 +0800
Message-ID: <CAJMQK-gNk8LmguOQ+iDxGtJCwCUcM3rPQ0CJs=kRZzv81nso4g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Move shutdown callback before flushing tx and
 rx queue
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 1:44 AM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Commit 0ea9fd001a14 ("Bluetooth: Shutdown controller after workqueues
> are flushed or cancelled") introduced a regression that makes mtkbtsdio
> driver stops working:
> [   36.593956] Bluetooth: hci0: Firmware already downloaded
> [   46.814613] Bluetooth: hci0: Execution of wmt command timed out
> [   46.814619] Bluetooth: hci0: Failed to send wmt func ctrl (-110)
>
> The shutdown callback depends on the result of hdev->rx_work, so we
> should call it before flushing rx_work:
> -> btmtksdio_shutdown()
>  -> mtk_hci_wmt_sync()
>   -> __hci_cmd_send()
>    -> wait for BTMTKSDIO_TX_WAIT_VND_EVT gets cleared
>
> -> btmtksdio_recv_event()
>  -> hci_recv_frame()
>   -> queue_work(hdev->workqueue, &hdev->rx_work)
>    -> clears BTMTKSDIO_TX_WAIT_VND_EVT
>
> So move the shutdown callback before flushing TX/RX queue to resolve the
> issue.
>
> Reported-and-tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Tested-by: Hsin-Yi Wang <hsinyi@chromium.org>

Hello,

Sorry for confusion, but the version I tested is this one:
https://lkml.org/lkml/2021/8/4/486 (shutdown is prior to the
test_and_clear HCI_UP)
I tested this version and still see the error I've seen before.




> Cc: Guenter Roeck <linux@roeck-us.net>
> Fixes: 0ea9fd001a14 ("Bluetooth: Shutdown controller after workqueues are flushed or cancelled")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  net/bluetooth/hci_core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index cb2e9e513907..8da04c899197 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1735,6 +1735,14 @@ int hci_dev_do_close(struct hci_dev *hdev)
>
>         hci_leds_update_powered(hdev, false);
>
> +       if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
> +           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> +           test_bit(HCI_UP, &hdev->flags)) {
> +               /* Execute vendor specific shutdown routine */
> +               if (hdev->shutdown)
> +                       hdev->shutdown(hdev);
> +       }
> +
>         /* Flush RX and TX works */
>         flush_work(&hdev->tx_work);
>         flush_work(&hdev->rx_work);
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
>
> --
> 2.31.1
>
