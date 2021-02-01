Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF38530AEEA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232602AbhBASQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbhBASOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:14:55 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED9FC0617AB
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:07 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id g15so84779pjd.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4RRBlCah2JVCFYBxRJ0/Km6eRiEmJrEsdil+05pqvOQ=;
        b=CWkBaGU1a734N6xxQeXe/aHAKk6b+aehd+zcqVO4EDVYd18IvYky+rCH7IWxqH/uPY
         +MQoE2QMdy4aWuKUSp0Bq4ZhXdvpj97fGIOw+RYCey3r23Ye3K+O0MblUjaocZA+zi1m
         nGhpqEt4RFq9eKHfK1DcLmGbexPH6HcRwuTuvW+IUCRVAOe+mrNCcogYIXAvIpKlQN/m
         t0DAIZRZyul/JjCFROTsQcvVAR63fCttHosuC7L+egNYSiRCiATgiv3yW5/AvMM8A51E
         uIz5WP46VKzE2k6pPi1QL8a0noh5LXTp1VRw33Dxw8Zt7Iqja4TM7foeIqVQ+blscyZu
         aj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4RRBlCah2JVCFYBxRJ0/Km6eRiEmJrEsdil+05pqvOQ=;
        b=lY8DSEWAl2TBu3ifCF7R24GZuQ637hPVAqkhKCMhVZ5aeTmZRHmXqBmXRWkKtVSF8E
         iKZPLdgw1fYAD/1EXXGdQxsn0yf/b8AWPpdCGzPfNv8rPtXmFb2DHijTfszQPkN7S7X/
         xGwbnjxQZd65YxJYLFj8fEZT0zov/ejrbmIGKlrcY2koYdBAWfVVz4TZoqkZghDuIy2t
         ozZWvnUaJR44lJO+n7Ww/itvs21/25NfzlpuMfKD48VVurllsS/Q0PSJoyxJbnmBKzlW
         cGNMgVH0v2TWaLIMeKVuGdNMKjkfOF5URdLKoctnCENRKWHgse/9UURvnVh7qAR0eFrj
         uBPQ==
X-Gm-Message-State: AOAM533656pSYH722wzBe9HqbUlNK3rn9T2RDM4GXqa6f5EREtTYbJio
        SXIu7Zt0EG/pytaj1vAa5/nR5Hel8UIrmg==
X-Google-Smtp-Source: ABdhPJwhiLmlEKeWZ3or5vPbFtmvgw3cBjMJe7GnknS2fyY+ry+h/ScadxXjs0jezy4BIdQI3EeG1A==
X-Received: by 2002:a17:902:778b:b029:df:e7bf:d660 with SMTP id o11-20020a170902778bb02900dfe7bfd660mr19101025pll.43.1612203246698;
        Mon, 01 Feb 2021 10:14:06 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:05 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/31] coresight: etm4x: Add commentary on the registers
Date:   Mon,  1 Feb 2021 11:13:32 -0700
Message-Id: <20210201181351.1475223-13-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

As we are about define a switch..case table for individual register
access by offset for implementing the system instruction support,
document the possible set of registers for each group to make
it easier to correlate.

Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-11-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x.h | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index b6854f6fd666..3c2b49ffabc8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -45,13 +45,13 @@
 #define TRCVDSACCTLR			0x0A4
 #define TRCVDARCCTLR			0x0A8
 /* Derived resources registers */
-#define TRCSEQEVRn(n)			(0x100 + (n * 4))
+#define TRCSEQEVRn(n)			(0x100 + (n * 4)) /* n = 0-2 */
 #define TRCSEQRSTEVR			0x118
 #define TRCSEQSTR			0x11C
 #define TRCEXTINSELR			0x120
-#define TRCCNTRLDVRn(n)			(0x140 + (n * 4))
-#define TRCCNTCTLRn(n)			(0x150 + (n * 4))
-#define TRCCNTVRn(n)			(0x160 + (n * 4))
+#define TRCCNTRLDVRn(n)			(0x140 + (n * 4)) /* n = 0-3 */
+#define TRCCNTCTLRn(n)			(0x150 + (n * 4)) /* n = 0-3 */
+#define TRCCNTVRn(n)			(0x160 + (n * 4)) /* n = 0-3 */
 /* ID registers */
 #define TRCIDR8				0x180
 #define TRCIDR9				0x184
@@ -60,7 +60,7 @@
 #define TRCIDR12			0x190
 #define TRCIDR13			0x194
 #define TRCIMSPEC0			0x1C0
-#define TRCIMSPECn(n)			(0x1C0 + (n * 4))
+#define TRCIMSPECn(n)			(0x1C0 + (n * 4)) /* n = 1-7 */
 #define TRCIDR0				0x1E0
 #define TRCIDR1				0x1E4
 #define TRCIDR2				0x1E8
@@ -69,9 +69,12 @@
 #define TRCIDR5				0x1F4
 #define TRCIDR6				0x1F8
 #define TRCIDR7				0x1FC
-/* Resource selection registers */
+/*
+ * Resource selection registers, n = 2-31.
+ * First pair (regs 0, 1) is always present and is reserved.
+ */
 #define TRCRSCTLRn(n)			(0x200 + (n * 4))
-/* Single-shot comparator registers */
+/* Single-shot comparator registers, n = 0-7 */
 #define TRCSSCCRn(n)			(0x280 + (n * 4))
 #define TRCSSCSRn(n)			(0x2A0 + (n * 4))
 #define TRCSSPCICRn(n)			(0x2C0 + (n * 4))
@@ -81,11 +84,13 @@
 #define TRCPDCR				0x310
 #define TRCPDSR				0x314
 /* Trace registers (0x318-0xEFC) */
-/* Comparator registers */
+/* Address Comparator registers n = 0-15 */
 #define TRCACVRn(n)			(0x400 + (n * 8))
 #define TRCACATRn(n)			(0x480 + (n * 8))
+/* Data Value Comparator Value registers, n = 0-7 */
 #define TRCDVCVRn(n)			(0x500 + (n * 16))
 #define TRCDVCMRn(n)			(0x580 + (n * 16))
+/* ContextID/Virtual ContextID comparators, n = 0-7 */
 #define TRCCIDCVRn(n)			(0x600 + (n * 8))
 #define TRCVMIDCVRn(n)			(0x640 + (n * 8))
 #define TRCCIDCCTLR0			0x680
-- 
2.25.1

