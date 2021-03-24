Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFE8434795F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:16:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235253AbhCXNQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbhCXNPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:15:36 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A41C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:15:35 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id r193so21408946ior.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mz7860lZzk6VZ253Yqzghlj/rfYbeBGQaKOgyWdMwc4=;
        b=SfYkeKXApi7lSZKgVpP2M8uiYF1rBLg4p9+gmn9IUpwPXMoq00r16kxp3vCdmAW2Gz
         JIIqu02uE7Tf6n6dCfjqvb0etdxlSWOSq7lBrpS0wBOaKrQuSWPc49g+3GzvqwOuLcnc
         /Rcm8CdDB7yJg8Ah+8SP+um7FVyE/k72032V9dKXx/3VmYzX6+YMoiquNchfa/B2mQNq
         R1GlCjfPciEd9XJ6gTnE9ggJFIBlHi24db9B7W1MVwHncVVGDFRnPPjtY4n9DXbSU1SN
         jsKN0a8YdXC5YxnmCPsdS2eQdYvN6HmLWTKQTIggN+9ae2TckUNaPHfPOAVl06c6wxYx
         oA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mz7860lZzk6VZ253Yqzghlj/rfYbeBGQaKOgyWdMwc4=;
        b=uRKUQM7+pOIOkGG20GA+fYGh1ZoW5lkfUZDvTqxtVKS7/AeSI7w3XxV94uAA3QOA9t
         9Jv+kD5/paGekvSu1azY7z2PrpWS1+P64ge/Q607o98quHb3+wRZVBd4sJVFIAtAJWCr
         eKuaqKnm5JW0QkcR9zom5p/6jBxtdnht9g5kQ4jB82Ac001WYFjuPZf9Po/LlZjY048c
         l59DLO6vy3IXiGndrPT3Cx7VT+OU/AkUTgWtebxpOiQymqjMIO543d+6zRiQn6VBvhRQ
         jL7RrpkOf2MnFqepm8xJDsp7jGhVnnayb8MuvG0NEz5mlBePLbQE1cIJVagMqAt70hOV
         urnA==
X-Gm-Message-State: AOAM530t8uZBN0hyYkUt0q5jNXMpwcUnZuvf2WiAJo74DgMDZaWaJ+b8
        xC8uaMEtFKWBdBOgC4sOHQXN5g==
X-Google-Smtp-Source: ABdhPJxTfRhz12RmMPUuybokjmzbbesH/g0RtrmjDVhfbrTUp0p/ZGLZVWgmNjuC1cacLZ0zTNle4g==
X-Received: by 2002:a02:aa92:: with SMTP id u18mr2797673jai.119.1616591735389;
        Wed, 24 Mar 2021 06:15:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id n7sm1160486ile.12.2021.03.24.06.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 06:15:35 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 5/6] net: ipa: move ipa_aggr_granularity_val()
Date:   Wed, 24 Mar 2021 08:15:27 -0500
Message-Id: <20210324131528.2369348-6-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210324131528.2369348-1-elder@linaro.org>
References: <20210324131528.2369348-1-elder@linaro.org>
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

