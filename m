Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF1383D81B1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jul 2021 23:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235139AbhG0VVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jul 2021 17:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232487AbhG0VVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jul 2021 17:21:15 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8ECC0619FA
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:19:41 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id u15so366348iol.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jul 2021 14:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ctl/Z08dFkY9O1sSrsyFhIw0eSry4lTuONlS/T0EM90=;
        b=XTURmhTwiW7Hfg9YNHm1nO1MyeyZHZtacTSnvfLAUsS21ypTKoAJZOaQ0NFqn09yaI
         bJbtJTI+9TbdpZPiDjhqXpvgaD4sF5OWPzayo04r79NNien2rcx2kLa1ldnwX6kEp4K3
         tZ6vxqO3NyuB39tHLly9fKtEMTlhiNf71nRZ2xGXFowj8W09bEJz3QcO7gijMOznNr9k
         sQrEIun0zb9MSO14Y2r/oULsQ9b6uwRhyDPvsvSe1vwzByhPi+K7bfu6KxLmDIPH/1bd
         cvgJ5nD78hppb+xpxN9xjfQPGyN/6NiKfblMs1PZdwIDaUTQzeSw4WlMk5bzsPT0thVU
         m2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ctl/Z08dFkY9O1sSrsyFhIw0eSry4lTuONlS/T0EM90=;
        b=dtbNX05IEWxgYBhHf8FjJG8jfRGA+cLG646ffEBnXetT+er4kunwi6ilsn8DshmWk6
         aELRGFuZXlwpwJtEkvm2bvZq1Hg/6l9wwbH1TVEE6/aKvQuwU9wxb4pneGznk3mBvbGL
         FWTfsGjxlor7pwLwv4P6jSKyyTGgEhh99jZf3obE7Bs1JBz6BQMrV2xu1CTNn+QZwSij
         gNIP8BkEkxut/DiNjQxeNdVJa+lYJVTcDkRaxe2XebnU3NVIEgFmsmXrqn41nz04lxgC
         m9MzasvKaa3i5undoIsOWKXuR6nnllX4fzUnPVF640xpZqDcrIB4kzNWdqzHZev6OtBH
         w8ww==
X-Gm-Message-State: AOAM530QpFDNI/a8eDE8FDHFyezK3K2YHbYcpjyo2YFQMRvq52uV9DLR
        sx5HDbhKXLCsj6OXzc4jW6Zz4A==
X-Google-Smtp-Source: ABdhPJxytZGBFgWUpCMTwqSZ7DYsGjFJm+faRhVvJfue3Dx6YMm/Pz8PXjlydHvHbS0qw6bXjhiuiA==
X-Received: by 2002:a05:6602:248f:: with SMTP id g15mr6353033ioe.198.1627420780474;
        Tue, 27 Jul 2021 14:19:40 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id s21sm3136068iot.33.2021.07.27.14.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:19:40 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/5] net: ipa: don't suspend endpoints if setup not complete
Date:   Tue, 27 Jul 2021 16:19:33 -0500
Message-Id: <20210727211933.926593-6-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210727211933.926593-1-elder@linaro.org>
References: <20210727211933.926593-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until we complete the setup stage of initialization, GSI is not
initialized and therefore endpoints aren't usable.  So avoid
suspending endpoints during system suspend unless setup is complete.

Clear the setup_complete flag at the top of ipa_teardown() to
reflect the fact that things are no longer in setup state.

Get rid of a misplaced (and superfluous) comment.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_main.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 67aba68e6e3b4..2e728d4914c82 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -194,6 +194,9 @@ static void ipa_teardown(struct ipa *ipa)
 	struct ipa_endpoint *exception_endpoint;
 	struct ipa_endpoint *command_endpoint;
 
+	/* We're going to tear everything down, as if setup never completed */
+	ipa->setup_complete = false;
+
 	ipa_qmi_teardown(ipa);
 	ipa_endpoint_default_route_clear(ipa);
 	exception_endpoint = ipa->name_map[IPA_ENDPOINT_AP_LAN_RX];
@@ -885,13 +888,11 @@ static int ipa_suspend(struct device *dev)
 {
 	struct ipa *ipa = dev_get_drvdata(dev);
 
-	/* When a suspended RX endpoint has a packet ready to receive, we
-	 * get an IPA SUSPEND interrupt.  We trigger a system resume in
-	 * that case, but only on the first such interrupt since suspend.
-	 */
-	__clear_bit(IPA_FLAG_RESUMED, ipa->flags);
-
-	ipa_endpoint_suspend(ipa);
+	/* Endpoints aren't usable until setup is complete */
+	if (ipa->setup_complete) {
+		__clear_bit(IPA_FLAG_RESUMED, ipa->flags);
+		ipa_endpoint_suspend(ipa);
+	}
 
 	ipa_clock_put(ipa);
 
@@ -917,7 +918,9 @@ static int ipa_resume(struct device *dev)
 	 */
 	ipa_clock_get(ipa);
 
-	ipa_endpoint_resume(ipa);
+	/* Endpoints aren't usable until setup is complete */
+	if (ipa->setup_complete)
+		ipa_endpoint_resume(ipa);
 
 	return 0;
 }
-- 
2.27.0

