Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE3039B4D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 10:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhFDI23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 04:28:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbhFDI22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 04:28:28 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749F6C061761
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 01:26:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u48-20020a25ab330000b029053982019c2dso10654029ybi.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 01:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+AyhPjQAPW++p5K3nJ03WOoCDBfn/0eNV9Q9A7qWaqw=;
        b=b7GtoEq98rIjsqgXlDNOWMrCe5aDE2gemhqDuDRVfKbICCzjeNUg5BKLC7B1Q7Qwp+
         w5ohxdM+zHtWGR2boYr3j9b+KHrSH62g/rGgpg5FjQXL53cYiDEiMeA3g/Brib1nwOZ6
         CPcHVMmw7uDynDA27Rq4UQnqyQS0v/enq+5B3k33nKMQfb0yPsfZ2U0r648ApIuklfpM
         d/odMHgWIwkQ5kQu3HYOAbRArgKKvTex0+VAIyVLqLEMkjU5U4bEIF/oAnzI/oVGFwSr
         0VwHcCCCkeFBnJEzi4GSNY9iOhC7wTuUs3zy08lrpHWQop5uIbgx5XYYRVth3gp64p5U
         pC8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+AyhPjQAPW++p5K3nJ03WOoCDBfn/0eNV9Q9A7qWaqw=;
        b=Hnay4dFC7nFwA6BzYEJD+rOliAzyVbce5Dj4pBZ6M086oPjumNYHLPEW+bP/akDFru
         JCBfiBGJfisapODGMjqDJNbVx8Vr2+DkyHs6MwgvCUJBxlQcT0r/MkNntg2BcbZn16z7
         YB1mPpF7wZj48G48YdEYKEg/5D0wPl+zgqfec2syr5v/Xm2w1SANs/SkOqDw7boJ2Zj9
         9UCb32cJc7B3AJ/IncJ+kguuYYnzztbp/4MTFw57Wf0Nq3c3s73cAO7Ky48VXjFDKn/w
         2T+jVyoLWECTvOuDHm/3yiUJDUiqTF39Zd6UK4m8VCFBcTXo33xtIKdCVIJF3RWnTc1+
         pNIg==
X-Gm-Message-State: AOAM5312nhubSMdKUSgGkVksStodl+zX7AndeL0TrrkjrfLB/Xi1Nkud
        RjiI2Ch6YoqVpd0YwnGfKDudqgUn5prc
X-Google-Smtp-Source: ABdhPJxQUzOTMWH90q4/iupjoGoNEQgxTDc/V+R7TgCPjXrBYMGDO2l3RzihTA3ngt5CUfaLCxBwZTE8MO6o
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:c6ff:1ed3:74cf:2ae3])
 (user=apusaka job=sendgmr) by 2002:a25:b8c5:: with SMTP id
 g5mr3784584ybm.57.1622795201615; Fri, 04 Jun 2021 01:26:41 -0700 (PDT)
Date:   Fri,  4 Jun 2021 16:26:26 +0800
In-Reply-To: <20210604162616.v3.1.I444f42473f263fed77f2586eb4b01d6752df0de4@changeid>
Message-Id: <20210604162616.v3.2.I4401b43eaf53e45e02ccaadef43cdcd3396173be@changeid>
Mime-Version: 1.0
References: <20210604162616.v3.1.I444f42473f263fed77f2586eb4b01d6752df0de4@changeid>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v3 2/3] Bluetooth: use inclusive language when tracking connections
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

This patch replaces some non-inclusive terms based on the appropriate
language mapping table compiled by the Bluetooth SIG:
https://specificationrefs.bluetooth.com/language-mapping/Appropriate_Language_Mapping_Table.pdf

Specifically, these terms are replaced:
master -> central
slave  -> peripheral

Signed-off-by: Archie Pusaka <apusaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>

---

Changes in v3:
* Resolve conflict

Changes in v2:
* Add details in commit message

 include/net/bluetooth/hci_core.h |  6 +++---
 net/bluetooth/hci_event.c        |  4 ++--
 net/bluetooth/hci_request.c      | 17 +++++++++--------
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c9ec06997e1c..fe5f3a9d9924 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -122,7 +122,7 @@ struct hci_conn_hash {
 	unsigned int     amp_num;
 	unsigned int     sco_num;
 	unsigned int     le_num;
-	unsigned int     le_num_slave;
+	unsigned int     le_num_peripheral;
 };
 
 struct bdaddr_list {
@@ -894,7 +894,7 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 	case LE_LINK:
 		h->le_num++;
 		if (c->role == HCI_ROLE_SLAVE)
-			h->le_num_slave++;
+			h->le_num_peripheral++;
 		break;
 	case SCO_LINK:
 	case ESCO_LINK:
@@ -920,7 +920,7 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 	case LE_LINK:
 		h->le_num--;
 		if (c->role == HCI_ROLE_SLAVE)
-			h->le_num_slave--;
+			h->le_num_peripheral--;
 		break;
 	case SCO_LINK:
 	case ESCO_LINK:
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index da013d485f14..e479dc44e572 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5384,9 +5384,9 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 		return NULL;
 
 	/* Most controller will fail if we try to create new connections
-	 * while we have an existing one in slave role.
+	 * while we have an existing one in peripheral role.
 	 */
-	if (hdev->conn_hash.le_num_slave > 0 &&
+	if (hdev->conn_hash.le_num_peripheral > 0 &&
 	    (!test_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks) ||
 	     !(hdev->le_states[3] & 0x10)))
 		return NULL;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 3465862429fb..a5d55175176e 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1519,13 +1519,14 @@ static bool is_advertising_allowed(struct hci_dev *hdev, bool connectable)
 	if (hci_conn_num(hdev, LE_LINK) == 0)
 		return true;
 
-	/* Check le_states if there is any connection in slave role. */
-	if (hdev->conn_hash.le_num_slave > 0) {
-		/* Slave connection state and non connectable mode bit 20. */
+	/* Check le_states if there is any connection in peripheral role. */
+	if (hdev->conn_hash.le_num_peripheral > 0) {
+		/* Peripheral connection state and non connectable mode bit 20.
+		 */
 		if (!connectable && !(hdev->le_states[2] & 0x10))
 			return false;
 
-		/* Slave connection state and connectable mode bit 38
+		/* Peripheral connection state and connectable mode bit 38
 		 * and scannable bit 21.
 		 */
 		if (connectable && (!(hdev->le_states[4] & 0x40) ||
@@ -1533,13 +1534,13 @@ static bool is_advertising_allowed(struct hci_dev *hdev, bool connectable)
 			return false;
 	}
 
-	/* Check le_states if there is any connection in master role. */
-	if (hci_conn_num(hdev, LE_LINK) != hdev->conn_hash.le_num_slave) {
-		/* Master connection state and non connectable mode bit 18. */
+	/* Check le_states if there is any connection in central role. */
+	if (hci_conn_num(hdev, LE_LINK) != hdev->conn_hash.le_num_peripheral) {
+		/* Central connection state and non connectable mode bit 18. */
 		if (!connectable && !(hdev->le_states[2] & 0x02))
 			return false;
 
-		/* Master connection state and connectable mode bit 35 and
+		/* Central connection state and connectable mode bit 35 and
 		 * scannable 19.
 		 */
 		if (connectable && (!(hdev->le_states[4] & 0x08) ||
-- 
2.32.0.rc1.229.g3e70b5a671-goog

