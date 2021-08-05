Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EC13E11DA
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 12:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240187AbhHEKDe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 06:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240116AbhHEKDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 06:03:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87339C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 03:03:09 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mt6so7463745pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 03:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8XRuBGVk2TTwf9hGVxYImjah4Tr644Zkbwg4wofK/FY=;
        b=cx7QG8BfkGZGWzDxJty+84rmZqIXWHoanpTdk8ibesKW1mSmOx8J/JE9xciyO7sqAa
         ae641fMfbrOKA74Nlm+mCetqEhdXfyuxOSpVo1kpLvwoEbRCugaAyBLD6nGYXFC/U9Bh
         3+W6yPuxG58z0hRd3ehdh0Ri9KMYAHS4a7bKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8XRuBGVk2TTwf9hGVxYImjah4Tr644Zkbwg4wofK/FY=;
        b=cnIvWa6GZjzayGOGJ/IkSB1bsqUo3FOHDCyga4qD0TSzIQIlkSAQBx8tmR7ciorYHy
         ThtPgAFz8tAxsYg4MjkxC0Ey+A+5eacxSsaPoEZYO/fdTE9EhJ7B33TRyE4j2cCf1zOC
         w0HteahA2RwLUgnwC3gTwAyXHWkzrVAVV39lUcU42rLnrzKorCC+qCXL9ZBOR+Igd39Y
         Cgp3hzh0Iw6pGNC2chdmIpX1Hpmk8coFgaUdMb1K58PNMz/8VhRWPvKPkuBTuJq2x96I
         bw6Z1ZKXoIn6GOeWBWlHqhiy3MmR4mZnpnzf0k1zpRdbh7+6Tw6f81ZMV0HXLJMng9ol
         7IPg==
X-Gm-Message-State: AOAM533yh24ELNOtLRocVAiOMIZn3j6CetO1EV2xT6bHP3aIFnEMq1p8
        eUATfk+TQkBbK1EgjUqYc/CTDw==
X-Google-Smtp-Source: ABdhPJwY8zMelHeMSEHYuzv7SX1IK/yoIrC+1fHDKJyykogs5DKAeC6uKxJn/YFkGH2bF+DjXWJnGA==
X-Received: by 2002:a17:902:c205:b029:12c:daac:c8a0 with SMTP id 5-20020a170902c205b029012cdaacc8a0mr3260744pll.13.1628157789141;
        Thu, 05 Aug 2021 03:03:09 -0700 (PDT)
Received: from josephsih-z840.tpe.corp.google.com ([2401:fa00:1:10:2c18:41ac:c6a8:ddfe])
        by smtp.gmail.com with ESMTPSA id jz24sm5436194pjb.9.2021.08.05.03.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 03:03:08 -0700 (PDT)
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
Subject: [PATCH v6 2/4] Bluetooth: btintel: support link statistics telemetry events
Date:   Thu,  5 Aug 2021 18:02:58 +0800
Message-Id: <20210805180227.v6.2.Ifb35feb49ec588106b256c508259500583582125@changeid>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
In-Reply-To: <20210805180227.v6.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
References: <20210805180227.v6.1.I41aec59e65ffd3226d368dabeb084af13cc133c8@changeid>
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

(no changes since v1)

 drivers/bluetooth/btintel.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index e44b6993cf91..fd21ddb76928 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -1248,8 +1248,10 @@ EXPORT_SYMBOL_GPL(btintel_read_debug_features);
 int btintel_set_debug_features(struct hci_dev *hdev,
 			       const struct intel_debug_features *features)
 {
-	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x07, 0x00, 0x00, 0x00, 0x00,
+	u8 mask[11] = { 0x0a, 0x92, 0x02, 0x7f, 0x00, 0x00, 0x00, 0x00,
 			0x00, 0x00, 0x00 };
+	u8 period[5] = { 0x04, 0x91, 0x02, 0x05, 0x00 };
+	u8 trace_enable = 0x02;
 	struct sk_buff *skb;
 
 	if (!features)
@@ -1266,8 +1268,24 @@ int btintel_set_debug_features(struct hci_dev *hdev,
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
 EXPORT_SYMBOL_GPL(btintel_set_debug_features);
-- 
2.32.0.554.ge1b32706d8-goog

