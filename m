Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E131387ACC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349863AbhEROO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349875AbhEROOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:14:17 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D278C061756
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:12:58 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id v4so7517159qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reaganmcf.com; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=KxUrJHmK65TUPhstPO4qv9AyRaQQt5FUyzzptUDCDVs=;
        b=dGS1CUsAyt5WH6CwLtWjRMx+wKJ5NJs4q+Eqi6Qld7mq+iKin2FTJsxRpSPr1MNvEq
         SolYyWAcb3S57slXilTwmmP74oXfqe8LMjb2ncND/pkITgEpfCo+XKZrn9E6EIFdbD9S
         PCsLP9Pb9CxwUURqh1OMvYxmJijWmUNrj7ww2xfqCbOwQZB4kgPX0UtocAN4jCXXUnmN
         UdLS9MszOOUAShZjxObVL/hWDvJo2c/vpdAWBeZlUXbvsvdu8qfp1Uf6OLTJu5+wj4FF
         d0cUbvwNe7eb7NMSdFGCMaGEc6DFhud7JkxHy+pwNSWXijTosm1ZgnQqKh8+qb0aKs8C
         nCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KxUrJHmK65TUPhstPO4qv9AyRaQQt5FUyzzptUDCDVs=;
        b=iM3rVgxYuSipp8O+fAPGaSSUyqhfWX5SSESdf7aNoL/qcBcygsjVTp99zrqiNkXnJJ
         IEzoRHo78L4jN3OePXT/PYcMzdT4kabyjb1YvT0BIBScqAuv3j6ZgDoUZq6GWWeE0+pM
         As/bVL/vfcW/5mBstCzCN2DXd/NYlq2szrdIldHUXlhkinWXtkIKMNxShuIP1+9cwbPH
         DCi0UmLNo8Qdxf6ALIaI4ybWekCqHxf7iNDQHtpNzuvaJTjtpUYBEm7YsAO+tUkj4PQC
         wM6IR4hrBjrL2kLmfar+p479rOM2CkHDlcC+MVH7f4LulGrfmz1IKRL9GDkdbd0xFRoD
         V34w==
X-Gm-Message-State: AOAM533jOlNJcZSnxrD/ynNcEcjvfGdVZszsLldro8fgc0iW2htQ1MXT
        8wk6haV33g+HlWoSf552iW/kRiHBDHO3MuCSsCw=
X-Google-Smtp-Source: ABdhPJzePXqU7JOLB9Nzju7YbIQtifKC7+rzO6bB+Y1JtNXzJZCiBSjjLLqvK7gGiF/JQs44hmwsMQ==
X-Received: by 2002:a05:622a:289:: with SMTP id z9mr5012030qtw.325.1621347177389;
        Tue, 18 May 2021 07:12:57 -0700 (PDT)
Received: from [192.168.1.18] (c-73-112-152-161.hsd1.nj.comcast.net. [73.112.152.161])
        by smtp.gmail.com with ESMTPSA id e19sm1343447qtr.45.2021.05.18.07.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 May 2021 07:12:57 -0700 (PDT)
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Reagan McFarland <me@reaganmcf.com>
Subject: [PATCH] Bluetooth: bfusb.c code style cleanup
Message-ID: <c4755ff4-3bae-a5c8-a081-78cd2e0c52f5@reaganmcf.com>
Date:   Tue, 18 May 2021 10:12:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code styling / formatting changes made to drivers/bluetooth/bfusb.c to get rid of the warnings
when running the checkpatch.pl script.

Signed-off-by: Reagan McFarland <me@reaganmcf.com>
---
 drivers/bluetooth/bfusb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index 5a321b4076aa..b4da848bdcf5 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -275,6 +275,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
                case HCI_EVENT_PKT:
                        if (len >= HCI_EVENT_HDR_SIZE) {
                                struct hci_event_hdr *hdr = (struct hci_event_hdr *) buf;
+
                                pkt_len = HCI_EVENT_HDR_SIZE + hdr->plen;
                        } else {
                                bt_dev_err(data->hdev, "event block is too short");
@@ -285,6 +286,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
                case HCI_ACLDATA_PKT:
                        if (len >= HCI_ACL_HDR_SIZE) {
                                struct hci_acl_hdr *hdr = (struct hci_acl_hdr *) buf;
+
                                pkt_len = HCI_ACL_HDR_SIZE + __le16_to_cpu(hdr->dlen);
                        } else {
                                bt_dev_err(data->hdev, "data block is too short");
@@ -295,6 +297,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
                case HCI_SCODATA_PKT:
                        if (len >= HCI_SCO_HDR_SIZE) {
                                struct hci_sco_hdr *hdr = (struct hci_sco_hdr *) buf;
+
                                pkt_len = HCI_SCO_HDR_SIZE + hdr->dlen;
                        } else {
                                bt_dev_err(data->hdev, "audio block is too short");
@@ -365,9 +368,8 @@ static void bfusb_rx_complete(struct urb *urb)
                        buf   += 3;
                }

-               if (count < len) {
+               if (count < len)
                        bt_dev_err(data->hdev, "block extends over URB buffer ranges");
-               }

                if ((hdr & 0xe1) == 0xc1)
                        bfusb_recv_block(data, hdr, buf, len);
--
2.31.1
