Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB663EBA6E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 18:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbhHMQwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 12:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237100AbhHMQw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 12:52:26 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45FAC061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 09:51:57 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id oa17so16175952pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 09:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eFA69i6hcXDHmIcHg92qE1Me9tWDfkAMJZYxzK2xT7U=;
        b=TpUTdVOIxxBS5XmDY4DUA0cn8A8aMa07BozY2b7t3/yGqObHPKbn8+gm3m1gVFVA2G
         xE3NPnB7OQVXXdZ7eXWQhDzZ1aZ5i7oeuszKvvNK8rySlKies3w9FRDsHiYn7ypudYxU
         skPgbZgLyWlrhfEPFtMWeHlYINFQrlx63t+Us=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eFA69i6hcXDHmIcHg92qE1Me9tWDfkAMJZYxzK2xT7U=;
        b=I/GiMpOWHsL1v7Sn2cA2IlO//8fjKqS9tWZKRBGSSdQVmT20vYYjsuYDA4RF6n1k9U
         hoqcS5JbJiDPxhFHKfO5TAd6wfeUd4vuiCpVK63Zf45/j3sMLQ52iyMuHkblpd+JcpD2
         McmrLRORtQlYI8Hf+dCc9KNQJcuwA3dJMJPC4B5AIuCHIOgjMMDzXayMFjuMOnQCwDnP
         P6ekP2S/zLP1YAz/hlhfIDo0sf3dcFylz/0m0bsZGQbuElPu3f1XzBpUMRoBWpMn0Yyu
         UV7dQeqirr/OVldximDm+UWOaIcXJ7MQIkxV1EIOLFdOIYGC4veH4dURIsKJjARvqCxN
         u6jw==
X-Gm-Message-State: AOAM530djBTd3j5zJY9fUA/8LinZ5uRxqL24gPZl0rwsNiOUdAyKRmFo
        9lYz/fYmH22zsh26ePcZyJ2tXg==
X-Google-Smtp-Source: ABdhPJyzpsSp56wh1Z/mvYZpCbXFVN98KOQk5meAGM3c0erEge7pod4tzz0VC2Q6osb2nxuPNF4WIw==
X-Received: by 2002:a17:90a:d181:: with SMTP id fu1mr3429050pjb.137.1628873517273;
        Fri, 13 Aug 2021 09:51:57 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:755d:cdee:3203:71c5])
        by smtp.gmail.com with ESMTPSA id w3sm2907407pfn.96.2021.08.13.09.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 09:51:56 -0700 (PDT)
From:   Joseph Hwang <josephsih@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        Kiran K <kiran.k@intel.com>,
        Joseph Hwang <josephsih@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/5] Bluetooth: btintel: support link statistics telemetry events
Date:   Sat, 14 Aug 2021 00:51:45 +0800
Message-Id: <20210814005024.v8.2.Ifb35feb49ec588106b256c508259500583582125@changeid>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
In-Reply-To: <20210814005024.v8.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210814005024.v8.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
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

