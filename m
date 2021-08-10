Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465783E83A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 21:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbhHJT1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 15:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232550AbhHJT1b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:27:31 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52860C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 12:27:09 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id y3so181622ilm.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m7UrH6Lu6RFgMKSZzNICn6qFCfAM54XgBDQbFAy1V9I=;
        b=JcWF5d4X2TO9r2glvm1MaRyb5qrHOgteLdlcnODRFO7ny4Csz4byiwmj31ZxdP5yjR
         OaGCxcbDskh/2mzO9XgYFJ8KolBgMN7OEteMG3BtLd5oRYBvKnvyjGDoI65jrHmAyjWF
         6cGzp5YHYhyAH/aSe0+dN9R9NgtFMKsDUltsbFKLHh+utYivxfiG/WwRTGSiVxPrRqky
         Td2w18FXE9o6i8DiPVw4N5LYBQp9wbzt1LnybCAXXA5peeptF3MQk5LZFqPTed/Bg7ru
         POEZ0pHiZMARWAza/YAf471xlONGyxzQDjoW6H15FhubVhd7OYBhsHpBDbGXI3AGInmm
         Uu8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m7UrH6Lu6RFgMKSZzNICn6qFCfAM54XgBDQbFAy1V9I=;
        b=tJsRPjBJnqJv8bfYBZOd7W/yyDF7LF32kYdN928ZIO3wSFypm6UN13l6n9eJF6m0k1
         DRmk3Ux9uLQFizDZ768fpKOC93bwUnUuGmDFAc4yH7umYRNLmtN+8b81+hMucApcJhEi
         9cHAtPsii0UBxPxi4dmlKe/sx1NxLAWJv9BhYtUWwLABrDORw6Zk1IH3GwuTnV0/itt5
         TZBXkFLNIDixELBsC39OKpA+ZqoNuTv9C/+yNoLfeV9MQFVI5V33wYXQO2nYD/SMZf+3
         lPSdfknglmg8gen3JuyrZfBXeQJGQiZdvDpdwAL1O7qCb0igbNaoMTbCG3mqTP2fOUSi
         GQ5Q==
X-Gm-Message-State: AOAM53246IZPW5b8fIonsHsb68m1qMFb5qXvURI+OMmMtaFgFuPMFQqw
        Nzm7omv3GPf0IREvpTp//pPz7A==
X-Google-Smtp-Source: ABdhPJz/q3V9sMameNIE4YmRtJY8eUmqsve6zNgWyVDBbU+ikYexkCLfAewakimWwMPIXM4ofSsLFw==
X-Received: by 2002:a92:c912:: with SMTP id t18mr360333ilp.152.1628623628748;
        Tue, 10 Aug 2021 12:27:08 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c5sm3025356ioz.25.2021.08.10.12.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 12:27:08 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/7] net: ipa: disable clock in suspend
Date:   Tue, 10 Aug 2021 14:26:59 -0500
Message-Id: <20210810192704.2476461-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210810192704.2476461-1-elder@linaro.org>
References: <20210810192704.2476461-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Disable the IPA clock rather than dropping a reference to it in the
system suspend callback.  This forces the suspend to occur without
affecting existing references.

Similarly, enable the clock rather than taking a reference in
ipa_resume(), forcing a resume without changing the reference count.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_clock.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index d5a8b45ee59d1..864991f7ba4b5 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -414,7 +414,7 @@ static int ipa_suspend(struct device *dev)
 		gsi_suspend(&ipa->gsi);
 	}
 
-	return ipa_clock_put(ipa);
+	return ipa_clock_disable(ipa);
 }
 
 /**
@@ -432,14 +432,9 @@ static int ipa_resume(struct device *dev)
 	struct ipa *ipa = dev_get_drvdata(dev);
 	int ret;
 
-	/* This clock reference will keep the IPA out of suspend
-	 * until we get a power management suspend request.
-	 */
-	ret = ipa_clock_get(ipa);
-	if (WARN_ON(ret < 0)) {
-		(void)ipa_clock_put(ipa);
+	ret = ipa_clock_enable(ipa);
+	if (WARN_ON(ret < 0))
 		return ret;
-	}
 
 	/* Endpoints aren't usable until setup is complete */
 	if (ipa->setup_complete) {
-- 
2.27.0

