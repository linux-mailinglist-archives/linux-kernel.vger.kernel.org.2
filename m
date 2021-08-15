Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C11C3EC8EB
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 14:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238090AbhHOMR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 08:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237968AbhHOMR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 08:17:56 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B661C061764
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 05:17:26 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id e15so17648677plh.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Aug 2021 05:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eFA69i6hcXDHmIcHg92qE1Me9tWDfkAMJZYxzK2xT7U=;
        b=klMfIjeVpam8pT5arjIEW49vm/9ag/9V62RMumJ9lbuKijF9Zd6XHjjUhsG/cGBRe/
         7h6qPKiWGP1c06B7Wg797fvFz79+SYvTr//XH1zLiFbLUCKHQPGh6SyE1vGd7MjqLvx+
         p/rk6BzVHpbxz6pbm38CF/KXfraSQm//v/ev4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eFA69i6hcXDHmIcHg92qE1Me9tWDfkAMJZYxzK2xT7U=;
        b=k6WmKLP3cXsFM47rctrRM5eTu56FdWTZYLOfGyt/plspRhVnuUyS5o6FoSHIPpu+Rj
         JBvtZAyh/11drZaP0t9yawLoK+9mvzBKiiJvTe3cZ4xqB5dw+Xb8J5Mrj6puK+xrMXaa
         PrAlgK9MOP8Ru2EsdKkSFDsT6E4fysUDEij6m2XnsRIDPoNeLLSA8nQkGXD5xG+lP4kp
         ML+C0G5C8Nzh1g5ieZ7DYt6LJ845ziDi0hjWJIM1ncF8i8wAra7BYxtAwq/19ZJpQd1h
         DEAinzhjrmAOboCXXBE6t0t4Klmo5IEeDgvwpVWUwH+uvkNFKkUKhLWmRiVOeKCXy/Tc
         tzvg==
X-Gm-Message-State: AOAM530vzpyv1GIwkIE18tN308BCuEjYDRBqxVOazZK1FCC3YjG2Y7PQ
        +c/Mo8wD9uKLBY+ssQ5KMjw67Q==
X-Google-Smtp-Source: ABdhPJxqkV5RcplPXSijny0oPio503+9aIz3axKmrr7c6QDFYGiRSETKBZkvhThq11NMzETOmyXdmw==
X-Received: by 2002:a62:dd57:0:b029:3cd:c96e:625e with SMTP id w84-20020a62dd570000b02903cdc96e625emr10935357pff.45.1629029846133;
        Sun, 15 Aug 2021 05:17:26 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:9cee:5877:e805:fe2b])
        by smtp.gmail.com with ESMTPSA id v20sm9773170pgi.39.2021.08.15.05.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 05:17:25 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     josephsih@google.com, chromeos-bluetooth-upstreaming@chromium.org,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Kiran K <kiran.k@intel.com>,
        Joseph Hwang <josephsih@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/5] Bluetooth: btintel: support link statistics telemetry events
Date:   Sun, 15 Aug 2021 20:17:14 +0800
Message-Id: <20210815201611.v9.2.Ifb35feb49ec588106b256c508259500583582125@changeid>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210815201611.v9.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210815201611.v9.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chethan T N <chethan.tumkur.narayan@intel.com>

This patch supports the link statistics telemetry events for
intel controllers

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Signed-off-by: Kiran K <kiran.k@intel.com>
Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

(no changes since v7)

Changes in v7:
- Rebase on Tedd's patches that moved functionality from btusb to
  btintel.

 drivers/bluetooth/btintel.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 0fe093fa5158..643e2194ca01 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1285,8 +1285,10 @@ static int btintel_read_debug_features(struct hci_dev *hdev,
 static int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features)
 {
-	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x07, 0x00, 0x00, 0x00, 0x00,
+	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x7f, 0x00, 0x00, 0x00, 0x00,
 			0x00, 0x00, 0x00 };
+	u8 period[5] = { 0x04, 0x91, 0x02, 0x05, 0x00 };
+	u8 trace_enable = 0x02;
 	struct sk_buff *skb;
 
 	if (!features)
@@ -1303,8 +1305,24 @@ static int btintel_set_debug_features(struct hci_dev *hdev,
 			   PTR_ERR(skb));
 		return PTR_ERR(skb);
 	}
+	kfree_skb(skb);
+
+	skb = __hci_cmd_sync(hdev, 0xfc8b, 5, period, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Setting periodicity for link statistics traces failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
+	kfree_skb(skb);
 
+	skb = __hci_cmd_sync(hdev, 0xfca1, 1, &trace_enable, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		bt_dev_err(hdev, "Enable tracing of link statistics events failed (%ld)",
+			   PTR_ERR(skb));
+		return PTR_ERR(skb);
+	}
 	kfree_skb(skb);
+
 	return 0;
 }
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

