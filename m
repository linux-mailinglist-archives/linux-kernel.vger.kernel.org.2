Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDBF34143A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 05:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbhCSE3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 00:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233744AbhCSE3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 00:29:31 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BE5C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:29:31 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id t18so6914625iln.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 21:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hDG6PIHC7KpW9wWS8Pp6sLnLw2dJbPgbTk+XMu+T/nA=;
        b=tvHoeIoo0qoEWzSw5VP/s1UhNOT6XZmP4zTSXD+hO/jDQsVFq7RlNpWz4hsliEISGm
         kxCsJWb9S/c+XV66AcUc5j1Vmybd262FP3BM5i7UsaWVBVC5PwNaCPKfIhUBg+VQaYvD
         x5qajfhRkRCsJvj6f5UJhi1MKKd8+CPRj5xgSP3okluniuNUGQhjxlKU0bNRzgQuzaW8
         3glYLkFkxhlQChFi+Jv3n3YXDko+y4RD0vtaA7vpCW+W015asCiwdj+aTtQWhSOMZlkK
         HFk5dnJ4ZaUvVDej6NdXd+DUvuc6hESVH9pgkJCEyYKcoHTUd9TZTxnJzpEae9r/u1b+
         g40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hDG6PIHC7KpW9wWS8Pp6sLnLw2dJbPgbTk+XMu+T/nA=;
        b=mWctnLKLC7fRZnzoyyZEG43tmFJWqPZRqXiSGdxD3bYPZ/Ocr0EegMkaOjY+e4VT+M
         tTPzzhJBFwFjNHTBhJOOyCI84KfRokBp8K51xs/Id3dAAEnQo/5n+rzaMq5KG+jmlxNm
         HJfY5K6d5g6Z6ol8CHnO/CSVon5g/F/ffCk+U68dXgMD5NAvjIHq/y8MNQfTvnaQPq7g
         Z+F3CRM4UCY7a32attnTYFuZ63b1l/eKaWAyFAXBji8vNBWxeHgbmpW8DmcShIdARHae
         9Yg/4W8tKAJPnawlG6XBZbxMv+wmpOUFJQIkHW2TnSf0t7irbS0Vf04rGKzGWKwHYy8f
         8qBw==
X-Gm-Message-State: AOAM530ChbfWABHQ7HDcuO+DHJhKhQZbQE7Co+vqK1j7x2rWwp+rryVs
        iILwyKA2h2HjcgkTI3LYRLw3HA==
X-Google-Smtp-Source: ABdhPJxwbHRv77KfvCLXgYEuujv3BBSkAgjP8NLx4hPcOgMCUj7rZflEYXvV6DC+xHcTOvz++X7ybg==
X-Received: by 2002:a92:444e:: with SMTP id a14mr1371727ilm.215.1616128170515;
        Thu, 18 Mar 2021 21:29:30 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id k3sm1985940ioj.35.2021.03.18.21.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 21:29:30 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/4] net: ipa: activate some commented assertions
Date:   Thu, 18 Mar 2021 23:29:23 -0500
Message-Id: <20210319042923.1584593-5-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210319042923.1584593-1-elder@linaro.org>
References: <20210319042923.1584593-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert some commented assertion statements into real calls to
ipa_assert().  If the IPA device pointer is available, provide it,
otherwise pass NULL for that.

There are lots more places to convert, but this serves as an initial
verification of the new mechanism.  The assertions here implement
both runtime and build-time assertions, both with and without the
device pointer.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_reg.h   | 7 ++++---
 drivers/net/ipa/ipa_table.c | 5 ++++-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
index 732e691e9aa62..d0de85de9f08d 100644
--- a/drivers/net/ipa/ipa_reg.h
+++ b/drivers/net/ipa/ipa_reg.h
@@ -9,6 +9,7 @@
 #include <linux/bitfield.h>
 
 #include "ipa_version.h"
+#include "ipa_assert.h"
 
 struct ipa;
 
@@ -212,7 +213,7 @@ static inline u32 ipa_reg_bcr_val(enum ipa_version version)
 			BCR_HOLB_DROP_L2_IRQ_FMASK |
 			BCR_DUAL_TX_FMASK;
 
-	/* assert(version != IPA_VERSION_4_5); */
+	ipa_assert(NULL, version != IPA_VERSION_4_5);
 
 	return 0x00000000;
 }
@@ -413,7 +414,7 @@ static inline u32 ipa_header_size_encoded(enum ipa_version version,
 
 	val = u32_encode_bits(size, HDR_LEN_FMASK);
 	if (version < IPA_VERSION_4_5) {
-		/* ipa_assert(header_size == size); */
+		ipa_assert(NULL, header_size == size);
 		return val;
 	}
 
@@ -433,7 +434,7 @@ static inline u32 ipa_metadata_offset_encoded(enum ipa_version version,
 
 	val = u32_encode_bits(off, HDR_OFST_METADATA_FMASK);
 	if (version < IPA_VERSION_4_5) {
-		/* ipa_assert(offset == off); */
+		ipa_assert(NULL, offset == off);
 		return val;
 	}
 
diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index aa8b3ce7e21d9..7784b42fbaccc 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -23,6 +23,7 @@
 #include "ipa_cmd.h"
 #include "gsi.h"
 #include "gsi_trans.h"
+#include "ipa_assert.h"
 
 /**
  * DOC: IPA Filter and Route Tables
@@ -237,11 +238,13 @@ static void ipa_table_validate_build(void)
 static dma_addr_t ipa_table_addr(struct ipa *ipa, bool filter_mask, u16 count)
 {
 	u32 skip;
+	u32 max;
 
 	if (!count)
 		return 0;
 
-/* assert(count <= max_t(u32, IPA_FILTER_COUNT_MAX, IPA_ROUTE_COUNT_MAX)); */
+	max = max_t(u32, IPA_FILTER_COUNT_MAX, IPA_ROUTE_COUNT_MAX);
+	ipa_assert(&ipa->pdev->dev, max);
 
 	/* Skip over the zero rule and possibly the filter mask */
 	skip = filter_mask ? 1 : 2;
-- 
2.27.0

