Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586953E8BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 10:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbhHKIZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 04:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236088AbhHKIZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 04:25:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF76EC0613D3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:25:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f5so1816627wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 01:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JopxvpFcF/xGESdrh4YQ6rS5KF8DueMkBM15FR5p2zI=;
        b=n3GjMA9nWMZfHn1qsTgkJAuyGzL7OvGstvZa+uwtSC2+i980Z9CA2iu8oOVRxObgnI
         Aezd0jo4cnZVKdtebsXlMzqO10Q6xB2O8BzwtbmHl24c9jv5M6oyfUUaAH7bxs6uIenr
         PbJclzvvkgFR4FwGJ5ueJGIurDvI092GZu3MAvZr5zYCIO2ndBJd/aCoHNOSOV9kEBUB
         eqE78uIrrVM4Xd9n3xrmpsEfjY6oPgBlmdOGzcG9w5XyTZ9PTG19MMPUmjpRJPEqTrNQ
         gRe7+3ARCXmXuoIe8vsh5v4FslmItbLzrM3ZumlK2nit9Fm5W2D2ovf5PV++CBuAfL+1
         pmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JopxvpFcF/xGESdrh4YQ6rS5KF8DueMkBM15FR5p2zI=;
        b=hez5wx04tqlsCQKHoXlTQWyY/wzQfeBCmbfytrm7pHT3OemYhgIaffpqkUDT7L/Z0n
         6THcrdPIlZSAMz2c8eZF2XAkZCZy1R0DsDInhE8gYkimwej3xdtHwwCKuvfcNL+UwgRC
         XI0evcO/rEeegrirOXzg9UgIQkGQtqcaCWzKHO22ynMU+xD+ZhLWJ8MMSqyMcBmdT9oD
         C1b5ihJF299iFi4QjjZoOA1rym5roPNok2XkcWLF7xFrBV0Axrmiu9Xf6rqeGzVTi4fx
         a6yY4h12lKg6ZLBM45vKvnXR/GinfNFaUMTowbuVtqB0FENXbadnfA2T9auXIJtg2t05
         SObQ==
X-Gm-Message-State: AOAM530lSdp8HTEuAeUGa1HA2OUzl9idTHZ82d9HDVXZM6p8qL5S/QyL
        uNFC64sw1b/2KcWqdlPa8pObRQ==
X-Google-Smtp-Source: ABdhPJzo1gv8/4u+SF3MPLGpjMOnRJmhlmd5mciRp3hwMU3HZV8PLwwodWiHGXiQrJKVriPPdr7lIg==
X-Received: by 2002:a05:6000:120d:: with SMTP id e13mr11205849wrx.6.1628670318484;
        Wed, 11 Aug 2021 01:25:18 -0700 (PDT)
Received: from localhost ([2a01:cb19:826e:8e00:7c84:47f9:c111:a679])
        by smtp.gmail.com with ESMTPSA id n8sm25498969wrx.46.2021.08.11.01.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 01:25:18 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] Bluetooth: Move shutdown callback before flushing tx
 and rx queue
In-Reply-To: <20210810045315.184383-1-kai.heng.feng@canonical.com>
References: <20210810045315.184383-1-kai.heng.feng@canonical.com>
Date:   Wed, 11 Aug 2021 10:25:09 +0200
Message-ID: <87pmuk75i2.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

Thank you for your patch.

Kai-Heng Feng <kai.heng.feng@canonical.com> writes:

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
> Cc: Guenter Roeck <linux@roeck-us.net>
> Fixes: 0ea9fd001a14 ("Bluetooth: Shutdown controller after workqueues are flushed or cancelled")
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v2: 
>  Move the shutdown callback before clearing HCI_UP, otherwise 1)
>  shutdown callback won't be called and 2) other routines that depend on
>  HCI_UP won't work.
>
>  net/bluetooth/hci_core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index cb2e9e513907..8622da2d9395 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1727,6 +1727,14 @@ int hci_dev_do_close(struct hci_dev *hdev)
>  	hci_request_cancel_all(hdev);
>  	hci_req_sync_lock(hdev);
>  
> +	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
> +	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> +	    test_bit(HCI_UP, &hdev->flags)) {
> +		/* Execute vendor specific shutdown routine */
> +		if (hdev->shutdown)
> +			hdev->shutdown(hdev);
> +	}
> +
>  	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
>  		cancel_delayed_work_sync(&hdev->cmd_timer);
>  		hci_req_sync_unlock(hdev);
> @@ -1798,14 +1806,6 @@ int hci_dev_do_close(struct hci_dev *hdev)
>  		clear_bit(HCI_INIT, &hdev->flags);
>  	}
>  
> -	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
> -	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
> -	    test_bit(HCI_UP, &hdev->flags)) {
> -		/* Execute vendor specific shutdown routine */
> -		if (hdev->shutdown)
> -			hdev->shutdown(hdev);
> -	}
> -
>  	/* flush cmd  work */
>  	flush_work(&hdev->cmd_work);
I confirm this works fine on mt8183-pumpkin using the btmtksdio driver.

Tested-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>  
> -- 
> 2.31.1
