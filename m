Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210C43DA9C3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhG2RLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbhG2RLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:11:06 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E958C061765
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:11:03 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id cb3-20020ad456230000b02903319321d1e3so4254166qvb.14
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=7QYjLUUqEA7QJtp6uP4L96pWeYbMtWuBy88IlWBrbUs=;
        b=GitGuPFN7VBWLpKFt0v1/hktZg429tIvceF80bLzkFbR32YQ/YcMnH8Teqgja1oso6
         s3KMBnYF5rqp5okurqP0N+mxGdLdhhMxBzlOwpA0LR5Cm2aYe9C+a948MWYoM+lCv/0c
         9sA2Y3uP+udORQmrkpo86lU33HFiU7fybTIg+W03UgB4mbI4b5TE3MkZspuwWxT/szgK
         kFFluWoT7Ma3m+ZhKwVpPOZkVoS56RUlobsfiIIzYP1k/V7b4d8mBKyFIQhTeo7rkYt5
         GjKJbKVWfYio+Qhk6KYtgIDJlKBikxy3KTL5hQvaudIaxEK/I5avhFbREGxPpmt9oX2n
         nJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=7QYjLUUqEA7QJtp6uP4L96pWeYbMtWuBy88IlWBrbUs=;
        b=aX4SL1nlCjmySw3XAZaSoOYyyZUDbX/cH35Knvuqm3pRQvcsM0LZEB5n0JCKS0AcSm
         eGYEuvSHz1NF/2HTlDm6jJ1o8apm1HIlDnYuAd1300Y1V8tfL4upI4rQp8ocdtzzQXtv
         JT9iOnNGbQsBhUH9mSSqQKdUzPUxux5erN4QOATRiZ+knIefIPzdyPSc9aJjCBtFqxoT
         9SxOZsVq4Eitf/yknlBoAATltliwSa/NlWfoMbEfhAjwWIeNglHbhHlxBY56mp8zM61H
         k+W3G2vscMuarn/oJxfgnq7vN5iQd8LMrehmcBr7AGr3+42kopyoMzZoyQYBofLCNHJA
         Bv7Q==
X-Gm-Message-State: AOAM533G4g+zoZyQX5sbQMIu7hUANvqsG7dwbxMOgm6l2BV5EkHdH+4G
        MNODheiiG6irZa5azt7T4BlZtm0mvZ43r405SA==
X-Google-Smtp-Source: ABdhPJy36b6GeGbxRVtXuY9CMyJWfNPDbOYW8W1+t+m0QitXepHvJiP1Q389FHGvtpmShE09ePMHXwqChVjxL+2CkA==
X-Received: from michaelfsun.mtv.corp.google.com ([2620:15c:202:201:9678:c075:a4e7:f144])
 (user=michaelfsun job=sendgmr) by 2002:a05:6214:1909:: with SMTP id
 er9mr6387577qvb.26.1627578662750; Thu, 29 Jul 2021 10:11:02 -0700 (PDT)
Date:   Thu, 29 Jul 2021 10:10:59 -0700
Message-Id: <20210729101036.1.I20af1cbaba1aed4ea5978c97339df5e035f08625@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [PATCH] Bluetooth: btusb: Enable MSFT extension for WCN6855 controller
From:   Michael Sun <michaelfsun@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Michael Sun <michaelfsun@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm WCN6855 Bluetooth controller supports the Microsoft vendor
extension, enable them by setting VsMsftOpCode to 0xFD70.

Verified on a WCN6855 device through bluetoothctl show

Signed-off-by: Michael Sun <michaelfsun@google.com>
---

 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1876a960b3dc..d9376380fcc2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -4735,6 +4735,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_bdaddr = btusb_set_bdaddr_wcn6855;
 		hdev->cmd_timeout = btusb_qca_cmd_timeout;
 		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
+		hci_set_msft_opcode(hdev, 0xFD70);
 	}
 
 	if (id->driver_info & BTUSB_AMP) {
-- 
2.32.0.432.gabb21c7263-goog

