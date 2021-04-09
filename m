Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A711135A545
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 20:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234603AbhDISH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 14:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbhDISHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 14:07:47 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA163C0613D7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 11:07:32 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id k25so6817545iob.6
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 11:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TOH3l++0jw4JADgwzNPOO7zYc7PdMPjbZGsmYctkn9E=;
        b=zd10W9BN0tLyMuoOeWEg/iNO635zlwEZtexPDtav7TzSKX3z8C0IU7JispTTfNNliB
         XQ2+Ksd4W642woc1RJR01vkK2ajrZ2yIzsXfP6gY/DOI0SvWRHNBDcvUzmqGyMeU+K+4
         zW4jT0UpP6Bpzjvc99ACO05ydGO3eoosQ9NX3xyfRi42B0EN5Dqcqv6I4HSKkkojL1HM
         GGQ/lm9QsojPBE0dpLwAnmrBhoOIz/h7cVVNLlsBbeaoexDAY9R/09WrOlZyCkj8DUC4
         AldwkRyqn1HE2YQgkFzjhDM+YDrysN1RhdEc1CMt2T76E++HCczhwk5j4SS8bVNSedtf
         VikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TOH3l++0jw4JADgwzNPOO7zYc7PdMPjbZGsmYctkn9E=;
        b=Mddhvyjle9keA50sKaMAtQTl5r4xxbKred2HlV9CGFeHhOeODbjBDJe9vVBgYpfdGj
         Luphnf2llkb60mtwn8/sS6Kt+LjConpIUy3DJr6XBuCgpqhVEypT9/XliTugHFaQAa16
         iWcS4/RPAoTFNVu0KriLnC/la3MkBvXmQAWR81ejR0VTgSkP6nkSvInC81mbUpDhkchU
         BC8B26VpZt7/AiDusQdTVl9wY9JECmL2JWy+JRyfBaEu4eYAqW0QXaiYDd5fHE3ZWFOy
         zlDItOw0jq7O1ijnybheusZMIVz1SBU9mP2YOQIP07UYxP68En8tb3ItPwhKRbL85yta
         ZzxQ==
X-Gm-Message-State: AOAM531lyuMuVfTxbmPCWLrExdynbJU1iiZ++V+hhR4EZ7M4AyMe6uH2
        9qj0aKoz/hXH63K1JEoIv95WBg==
X-Google-Smtp-Source: ABdhPJzTeZc06YyCZzSyxFsI8x7rr1p0kBTjjomD0a8PWoU2jLQ++YrRsMZ40HlucdjQmwT51cWnug==
X-Received: by 2002:a05:6638:140e:: with SMTP id k14mr15429481jad.31.1617991652431;
        Fri, 09 Apr 2021 11:07:32 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id g12sm1412786ile.71.2021.04.09.11.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:07:32 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 7/7] net: ipa: three small fixes
Date:   Fri,  9 Apr 2021 13:07:22 -0500
Message-Id: <20210409180722.1176868-8-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210409180722.1176868-1-elder@linaro.org>
References: <20210409180722.1176868-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some time ago changes were made to stop referring to clearing the
hardware pipeline as a "tag process."  Fix a comment to use the
newer terminology.

Get rid of a pointless double-negation of the Boolean toward_ipa
flag in ipa_endpoint_config().

make ipa_endpoint_exit_one() private; it's only referenced inside
"ipa_endpoint.c".

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_endpoint.c | 6 +++---
 drivers/net/ipa/ipa_endpoint.h | 2 --
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index dd24179383c1c..72751843b2e48 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -397,7 +397,7 @@ int ipa_endpoint_modem_exception_reset_all(struct ipa *ipa)
 	/* We need one command per modem TX endpoint.  We can get an upper
 	 * bound on that by assuming all initialized endpoints are modem->IPA.
 	 * That won't happen, and we could be more precise, but this is fine
-	 * for now.  We need to end the transaction with a "tag process."
+	 * for now.  End the transaction with commands to clear the pipeline.
 	 */
 	count = hweight32(initialized) + ipa_cmd_pipeline_clear_count();
 	trans = ipa_cmd_trans_alloc(ipa, count);
@@ -1755,7 +1755,7 @@ int ipa_endpoint_config(struct ipa *ipa)
 
 		/* Make sure it's pointing in the right direction */
 		endpoint = &ipa->endpoint[endpoint_id];
-		if ((endpoint_id < rx_base) != !!endpoint->toward_ipa) {
+		if ((endpoint_id < rx_base) != endpoint->toward_ipa) {
 			dev_err(dev, "endpoint id %u wrong direction\n",
 				endpoint_id);
 			ret = -EINVAL;
@@ -1791,7 +1791,7 @@ static void ipa_endpoint_init_one(struct ipa *ipa, enum ipa_endpoint_name name,
 	ipa->initialized |= BIT(endpoint->endpoint_id);
 }
 
-void ipa_endpoint_exit_one(struct ipa_endpoint *endpoint)
+static void ipa_endpoint_exit_one(struct ipa_endpoint *endpoint)
 {
 	endpoint->ipa->initialized &= ~BIT(endpoint->endpoint_id);
 
diff --git a/drivers/net/ipa/ipa_endpoint.h b/drivers/net/ipa/ipa_endpoint.h
index f034a9e6ef215..0a859d10312dc 100644
--- a/drivers/net/ipa/ipa_endpoint.h
+++ b/drivers/net/ipa/ipa_endpoint.h
@@ -87,8 +87,6 @@ int ipa_endpoint_modem_exception_reset_all(struct ipa *ipa);
 
 int ipa_endpoint_skb_tx(struct ipa_endpoint *endpoint, struct sk_buff *skb);
 
-void ipa_endpoint_exit_one(struct ipa_endpoint *endpoint);
-
 int ipa_endpoint_enable_one(struct ipa_endpoint *endpoint);
 void ipa_endpoint_disable_one(struct ipa_endpoint *endpoint);
 
-- 
2.27.0

