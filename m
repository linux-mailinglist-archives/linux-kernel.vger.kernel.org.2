Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C79353EA1BA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 11:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235875AbhHLJQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 05:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235770AbhHLJQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 05:16:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8737EC061765
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:16:15 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w14so8338835pjh.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 02:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qo2S1l3e71xDGUQfWsHR5ktR7WTQXcYye34NKBDFtAI=;
        b=deU0oWZd89aB+49trFKTOg7MKEehWm8yLg8rNgsXBEGCWV1v15OF44GlTt9DcEbp6a
         51WTBNB+buaDEiLBGv9vdNpgrCepUTvheY31H1CuK4rkNnFp4qBBEd4YRiDV4xipvyvl
         1GIrm64DUsJV2t3g7ECk4FbyrJgKHwddpTk8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qo2S1l3e71xDGUQfWsHR5ktR7WTQXcYye34NKBDFtAI=;
        b=rTToUfeuVCAbsp8DiYnfNZJd3uSH48DVWM90FPknIvjZl+zYMiGWNdbj284bi5jNVI
         8VfOgTF+Kc0X22ekbtKof9JKCiBbOCOJTbUjpSbmbhOixOVv6ps9nb0EpVhrqehzgXUj
         p8rTUfG2aP7ASZKggocEISk9Y/4h3D5nnHnSrUFrDfGt9GJoCaUdUXIhq35H7A16oyGc
         oapQrZ4GlYsyuRDh6Zuga6mQGKltdBXpzMsjWUEalZwqf5Yaas4tSvjFfk24vtNCMx8G
         iKveXqhDVUFNh053O3t9hoDnxtv83b0567je8s8OYrfX4vrbnQF7JmUUqPP2fjJziPhV
         oIIw==
X-Gm-Message-State: AOAM531P2CJC73eKoervlb+leaqulNRbjmxlKVKPdDCSUDovta+//bDz
        p4VO7w0vWXr1jSH0BrzEx89iBw==
X-Google-Smtp-Source: ABdhPJzNk2Yzm3LutyAtcCBrSoc9D+D7v05i7cWh8iXHxER79J/h5SimnxqluGa/hkGVKVgl8CYJnQ==
X-Received: by 2002:a17:90a:de8b:: with SMTP id n11mr15509950pjv.31.1628759775173;
        Thu, 12 Aug 2021 02:16:15 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:8f67:7d0e:97df:b4b4])
        by smtp.gmail.com with ESMTPSA id n32sm2563966pgl.69.2021.08.12.02.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 02:16:14 -0700 (PDT)
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
Subject: [PATCH v7 2/4] Bluetooth: btintel: support link statistics telemetry events
Date:   Thu, 12 Aug 2021 17:15:59 +0800
Message-Id: <20210812171533.v7.2.Ifb35feb49ec588106b256c508259500583582125@changeid>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
In-Reply-To: <20210812171533.v7.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210812171533.v7.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
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
2.32.0.605.g8dce9f2422-goog

