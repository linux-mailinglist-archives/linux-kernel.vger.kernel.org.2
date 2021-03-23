Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02AFC3461F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbhCWOxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232381AbhCWOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:51:44 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1D9C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:51:43 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id k25so5837753iob.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 07:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mz7860lZzk6VZ253Yqzghlj/rfYbeBGQaKOgyWdMwc4=;
        b=pCVav1dzOO0huV0bd1PsGoJE/DJC6UFegHK7QKjr3rUIrdA+Y5CRr6vHP1XiflCGQE
         5vRhrPYQiGd7vM6N3VMV9PQNgf+bAeUMk2cR/0EfdkdWou/uZ0Gm+gd1JApbKO0g1zPM
         xA+luQnMdkiSgtbxdTdw5QHqtgodWE6GDs3VtFTcgVfC7CanQPSP9KGqKlQ8K4gCueMP
         /3NCLpRgUjbmsfT91tcUhQkAZRX5gypDGEsTCD2cbVxQga30FqefH/5C6lI6fQtEsMLL
         F87OAM7iL3d9sGot1ZAm6H3UHQuCFd8cfPcBye+PKrHMjuhVxmfnvmUBwG2n4Jjuym3X
         c5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mz7860lZzk6VZ253Yqzghlj/rfYbeBGQaKOgyWdMwc4=;
        b=Uw13n17lzgQcHV8OIYGh6iZpKPdJWOhMu+B3LFI6cyaNPvOQ/hxVEpr5MBuR5sGr0D
         PjFWsV93csHaf9s0IxAoyJHKWr/hJBXA2kiEIlDENRq86CBwUCA+sLxw7LVHpdoH1dRk
         50aygzN9JmghhsfYwrSepFemWMxqRO/IFBEYk/ezmNHOGSkqgPJVxKG2GEP7XYhyWcAC
         wgTnzgB1G8CdP4he/th5F6Of/SDux9DevwHfDPwiCfe9xFbfqx4VKY4jK4bSF886qhxx
         SDH8GE7kGhS7PGoi9CrlYOWgj/bO+6s6InUtDCSR3+rK+VP0oHckSNct3qskjRpNxt2P
         xzDg==
X-Gm-Message-State: AOAM531AZSkj2o7dNM9j9Xs1L8xVIQGBX+TYsrDvb0wJcPOgmPqiA+FT
        OJoGrQvUMAKtQW5RuaLAHk7xSQ==
X-Google-Smtp-Source: ABdhPJwUbb2CkRxod9K93XDPC5V1Y0v85DqJTTPBlEnh0g5xnBWcFxt0/Dwpw49O8INdS8+yLpIpJg==
X-Received: by 2002:a02:9985:: with SMTP id a5mr4785921jal.122.1616511102767;
        Tue, 23 Mar 2021 07:51:42 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id o13sm8961147iob.17.2021.03.23.07.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:51:42 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/6] net: ipa: move ipa_aggr_granularity_val()
Date:   Tue, 23 Mar 2021 09:51:31 -0500
Message-Id: <20210323145132.2291316-6-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210323145132.2291316-1-elder@linaro.org>
References: <20210323145132.2291316-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We only use ipa_aggr_granularity_val() inside "ipa_main.c", so it
doesn't really need to be defined in a header file.  It makes some
sense to be grouped with the register definitions, but it is unlike
the other inline functions now defined in "ipa_reg.h".  So move it
into "ipa_main.c" where it's used.  TIMER_FREQUENCY is used only
by that function, so move that definition as well.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_main.c | 15 +++++++++++++++
 drivers/net/ipa/ipa_reg.h  | 12 ------------
 2 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 62d82d48aed69..ba1bfc30210a3 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -287,6 +287,21 @@ ipa_hardware_config_qsb(struct ipa *ipa, const struct ipa_data *data)
 	iowrite32(val, ipa->reg_virt + IPA_REG_QSB_MAX_READS_OFFSET);
 }
 
+/* The internal inactivity timer clock is used for the aggregation timer */
+#define TIMER_FREQUENCY	32000		/* 32 KHz inactivity timer clock */
+
+/* Compute the value to use in the COUNTER_CFG register AGGR_GRANULARITY
+ * field to represent the given number of microseconds.  The value is one
+ * less than the number of timer ticks in the requested period.  0 is not
+ * a valid granularity value.
+ */
+static u32 ipa_aggr_granularity_val(u32 usec)
+{
+	/* assert(usec != 0); */
+
+	return DIV_ROUND_CLOSEST(usec * TIMER_FREQUENCY, USEC_PER_SEC) - 1;
+}
+
 /* IPA uses unified Qtime starting at IPA v4.5, implementing various
  * timestamps and timers independent of the IPA core clock rate.  The
  * Qtimer is based on a 56-bit timestamp incremented at each tick of
diff --git a/drivers/net/ipa/ipa_reg.h b/drivers/net/ipa/ipa_reg.h
index cbfef27bbcf2c..86fe2978e8102 100644
--- a/drivers/net/ipa/ipa_reg.h
+++ b/drivers/net/ipa/ipa_reg.h
@@ -237,18 +237,6 @@ static inline u32 proc_cntxt_base_addr_encoded(enum ipa_version version,
 #define IPA_REG_COUNTER_CFG_OFFSET			0x000001f0
 #define AGGR_GRANULARITY_FMASK			GENMASK(8, 4)
 
-/* The internal inactivity timer clock is used for the aggregation timer */
-#define TIMER_FREQUENCY	32000		/* 32 KHz inactivity timer clock */
-
-/* Compute the value to use in the AGGR_GRANULARITY field representing the
- * given number of microseconds.  The value is one less than the number of
- * timer ticks in the requested period.  0 not a valid granularity value.
- */
-static inline u32 ipa_aggr_granularity_val(u32 usec)
-{
-	return DIV_ROUND_CLOSEST(usec * TIMER_FREQUENCY, USEC_PER_SEC) - 1;
-}
-
 /* The next register is not present for IPA v4.5 */
 #define IPA_REG_TX_CFG_OFFSET				0x000001fc
 /* The first three fields are present for IPA v3.5.1 only */
-- 
2.27.0

