Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A783E44D173
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 06:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhKKFYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 00:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233711AbhKKFYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 00:24:00 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C933C061767
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 21:21:11 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g36-20020a25ae64000000b005c1f46f7ee6so7623278ybe.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 21:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bXvoGq85SjQrZE2UDJdD7tTQN0yXDS84CPrsHpU2ecg=;
        b=VNAzwo5Shkdg3dxf283rVfyylmMu5nAfaDf2I9NCkyk6Q8WBduzquCY9bhxqMRm3zd
         xNiLSjaTz+J6xeselnY+5QrX/WSJdTyyJvV4SPaw2m52+g6nyoLWGkjJbzg/dhQ/6INH
         5e3bgNOrylE88J5y/aS09oaUFoVdf9C8Nc9FPg5dHncD7X4q/McY1pf0jpv1AYxchz2X
         qkBDKJn/Cgunsnj3IiFE6ACpIOWdmKvKZ3uBunsljSpRuYttgbgzLbXdUuWUM9AKMqCm
         2mgkqFO1mOIQfj8eHp50jVv+lDP1fX2FEQIFhERMri+Ua4CTh0QyKB8J5gM7inE0Qokc
         ONug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bXvoGq85SjQrZE2UDJdD7tTQN0yXDS84CPrsHpU2ecg=;
        b=UG5rJCaKyhpXfzJkta44BQESJhfcNSZrXw7fKK7yG727LwwSkgNoBEU1q82th048hC
         ko1Yf3l90QH6MB5PwiLBcTH2N2dSAj8yxwGlbuBwahV8YElVo58hP35LH7r9LPXkacJe
         Gz4ArEh3rDWGXjGDKIwuobGc5Gqot/hxst4KK5disUklljWPf+5t3SlqCHWkL49c6B9B
         asqOu902F80CbF/xHlaHOAimiN6dps488ko+Eg5yb8v0HxubRyK/hsycZWayVAnpSUJU
         ltySJZOxq5dR5Re8TysoO6ERIWAzcPax+45cdDY1Bjb5a8MSk2/01CcAIPlbUSiur7lm
         LPjQ==
X-Gm-Message-State: AOAM532BFRqlR4B1AIl2eEF+du5GRCEGTsLQ9Fb182VUThStPAUZTB41
        P0B/dYv0xPkPlO7O0A8nHtL7Y+0C4dEo
X-Google-Smtp-Source: ABdhPJzLucYZdSz607KwUMA4pm8NAhPadPIQEQpMeYRLmJSFH9e2Hgaj8d39ogIHjaaLoIIHGDS24o0y/RuI
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b87e:3eb:e17e:1273])
 (user=apusaka job=sendgmr) by 2002:a25:3252:: with SMTP id
 y79mr5132719yby.5.1636608070701; Wed, 10 Nov 2021 21:21:10 -0800 (PST)
Date:   Thu, 11 Nov 2021 13:20:54 +0800
In-Reply-To: <20211111132045.v3.1.I3ba1a76d72da5a813cf6e6f219838c9ef28c5eaa@changeid>
Message-Id: <20211111132045.v3.2.I4e34d9e5fdd7515aa15d0ee2ef94d57dcb48a927@changeid>
Mime-Version: 1.0
References: <20211111132045.v3.1.I3ba1a76d72da5a813cf6e6f219838c9ef28c5eaa@changeid>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v3 2/2] Bluetooth: Attempt to clear HCI_LE_ADV on adv set
 terminated error event
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

We should clear the flag if the adv instance removed due to receiving
this error status is the last one we have.

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

Changes in v3:
* Check adv->enabled rather than just checking for list empty

 net/bluetooth/hci_event.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7d875927c48b..6cf882e6d7e7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5532,7 +5532,7 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_evt_le_ext_adv_set_term *ev = (void *) skb->data;
 	struct hci_conn *conn;
-	struct adv_info *adv;
+	struct adv_info *adv, *n;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -5558,6 +5558,13 @@ static void hci_le_ext_adv_term_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		hci_remove_adv_instance(hdev, ev->handle);
 		mgmt_advertising_removed(NULL, hdev, ev->handle);
 
+		list_for_each_entry_safe(adv, n, &hdev->adv_instances, list) {
+			if (adv->enabled)
+				return;
+		}
+
+		/* We are no longer advertising, clear HCI_LE_ADV */
+		hci_dev_clear_flag(hdev, HCI_LE_ADV);
 		return;
 	}
 
-- 
2.34.0.rc0.344.g81b53c2807-goog

