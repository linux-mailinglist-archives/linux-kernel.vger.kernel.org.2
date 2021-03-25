Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F88349468
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Mar 2021 15:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhCYOpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Mar 2021 10:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230458AbhCYOoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Mar 2021 10:44:44 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90016C061761
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:44:43 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id w2so1860502ilj.12
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 07:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nqFrXfpahfV89BBNu78yhc9pFje3UVbeXgp05nbnBTc=;
        b=S6yUXLHVpFz5PoG3ccz0r51X8ljE7ikppau9HigvVju0lTwG24m7qDB1LchhB6IAbF
         fJU1Ri3pqyBcflN5VrnBU/8kHlXvdBhglKzLzOYBpk4L/bUA7DkNz+ypAJT63N0+4NHJ
         +94l8i8sfUtovZ4QwoPLGS3FL70t7e3zgslpZwLf1c9P4KFDKx8GwxR4/AR7OTONkvks
         aATm3aGg0wJKKz5xel9AHZYVQsMFXbcAUW5OoODZ9vUCnlEuqSx4933DWde5ErW8OkXz
         YU9ch84DhMydlptTzE+WOEDmr6BsxgQKT0/smkSmHJzVx/p9i2v/KLIqEZ3nEgkhSFgv
         T58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nqFrXfpahfV89BBNu78yhc9pFje3UVbeXgp05nbnBTc=;
        b=ttZu1GdaUt33R9WbuDpMO1Hfzx8Z3w2Y4Y8bIflqxiswPxbqeocRBi4Vhzuo7nQa/u
         8rk+C0kZ7wjG67IQJJn7aw6YMuNuPXXZ4AgplOByaSP86wT7cZQZvOdfc8MOcPd2P75R
         oGjG0IlcLej0G6euSkknHTDg+689nNSomvhi25xmWh9r5DK0b/sXktE3/NzJJDJV8Owg
         K+4ly6m4In1DMed1U3k17oWJ6UKFlkfHehze3+JabWHzxvv5a2V6iLgQNBrezqxQaDHf
         69PLE8tW1jrUrfA/iPSy0j1522efRur1xx3yuo5DDpkmI57G9mTxdFL9riX4Kps6vOMM
         n2kQ==
X-Gm-Message-State: AOAM531Mw3rtu3xfdujhoz3W9cSTQ6gr2ge5svlxL7iDjJpsvZB72h6Y
        ptpa3qD8hlDEWnj5UwpD+i30Kw==
X-Google-Smtp-Source: ABdhPJyI2RwUDIiZcRJkcEr/V10IvS5dJuwN8rOpOqDHV0sPm1TVvFmwi4G7CuzfIjEIqQyQYCbVGg==
X-Received: by 2002:a92:c24c:: with SMTP id k12mr7061333ilo.282.1616683482974;
        Thu, 25 Mar 2021 07:44:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id x20sm2879196ilc.88.2021.03.25.07.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 07:44:42 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/6] net: ipa: update component config register
Date:   Thu, 25 Mar 2021 09:44:33 -0500
Message-Id: <20210325144437.2707892-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210325144437.2707892-1-elder@linaro.org>
References: <20210325144437.2707892-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IPA version 4.9 and later use a different layout of some fields
found in the COMP_CFG register.

Define arbitration_lock_disable_encoded(), and use it to encode a
value into the ATOMIC_FETCHER_ARB_LOCK_DIS field based on the IPA
version.

And define full_flush_rsc_closure_en_encoded() to encode a value
into the FULL_FLUSH_WAIT_RSC_CLOSE_EN field based on the IPA
version.

The values of these fields are neither modified nor extracted by
current code, but this patch makes this possible for all supported
versions.

Fix a mistaken comment above ipa_hardware_config_comp() intended to
describe the purpose for the register.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_main.c |  2 +-
 drivers/net/ipa/ipa_reg.h  | 32 +++++++++++++++++++++++++++++---
 2 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index ba1bfc30210a3..f071e90de5409 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -222,7 +222,7 @@ static void ipa_teardown(struct ipa *ipa)
 	gsi_teardown(&ipa->gsi);
 }
 
-/* Configure QMB Core Master Port selection */
+/* Configure bus access behavior for IPA components */
 static void ipa_hardware_config_comp(struct ipa *ipa)
 {
 	u32 val;
diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
index 735f6e809e042..8a654ccda49eb 100644
--- a/drivers/net/ipa/ipa_reg.h
+++ b/drivers/net/ipa/ipa_reg.h
@@ -88,9 +88,6 @@ struct ipa;
 #define GSI_SNOC_CNOC_LOOP_PROT_DISABLE_FMASK	GENMASK(14, 14)
 #define GSI_MULTI_AXI_MASTERS_DIS_FMASK		GENMASK(15, 15)
 #define IPA_QMB_SELECT_GLOBAL_EN_FMASK		GENMASK(16, 16)
-#define IPA_ATOMIC_FETCHER_ARB_LOCK_DIS_FMASK	GENMASK(20, 17)
-/* The next field is present for IPA v4.5 and IPA v4.7 */
-#define IPA_FULL_FLUSH_WAIT_RSC_CLOSE_EN_FMASK	GENMASK(21, 21)
 /* The next five fields are present for IPA v4.9+ */
 #define QMB_RAM_RD_CACHE_DISABLE_FMASK		GENMASK(19, 19)
 #define GENQMB_AOOOWR_FMASK			GENMASK(20, 20)
@@ -98,6 +95,35 @@ struct ipa;
 #define GEN_QMB_1_DYNAMIC_ASIZE_FMASK		GENMASK(30, 30)
 #define GEN_QMB_0_DYNAMIC_ASIZE_FMASK		GENMASK(31, 31)
 
+/* Encoded value for COMP_CFG register ATOMIC_FETCHER_ARB_LOCK_DIS field */
+static inline u32 arbitration_lock_disable_encoded(enum ipa_version version,
+						   u32 mask)
+{
+	/* assert(version >= IPA_VERSION_4_0); */
+
+	if (version < IPA_VERSION_4_9)
+		return u32_encode_bits(mask, GENMASK(20, 17));
+
+	if (version == IPA_VERSION_4_9)
+		return u32_encode_bits(mask, GENMASK(24, 22));
+
+	return u32_encode_bits(mask, GENMASK(23, 22));
+}
+
+/* Encoded value for COMP_CFG register FULL_FLUSH_WAIT_RS_CLOSURE_EN field */
+static inline u32 full_flush_rsc_closure_en_encoded(enum ipa_version version,
+						    bool enable)
+{
+	u32 val = enable ? 1 : 0;
+
+	/* assert(version >= IPA_VERSION_4_5); */
+
+	if (version == IPA_VERSION_4_5 || version == IPA_VERSION_4_7)
+		return u32_encode_bits(val, GENMASK(21, 21));
+
+	return u32_encode_bits(val, GENMASK(17, 17));
+}
+
 #define IPA_REG_CLKON_CFG_OFFSET			0x00000044
 #define RX_FMASK				GENMASK(0, 0)
 #define PROC_FMASK				GENMASK(1, 1)
-- 
2.27.0

