Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A633E0452
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239284AbhHDPg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239170AbhHDPgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:36:49 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC46FC0613D5
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 08:36:32 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id n19so2959126ioz.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 08:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0ORQADKMrB8WnJjXtRJ19aGpSRDE6kwVQjbknX6w+0=;
        b=n/uWlEkm7XKu/2h40pw0rlVHdIIKW1N/XX2i3dvGQzYOhOa58g0a2qzwYzl71tHUY1
         wFKOeWGm1cv5/bdLm7IbF6SBcITLiqLWA5ycgPqxzJyfuMulGgAgcR0bySJEvywWTnAv
         HhLKm+cZAsd8ZMYk4sag3eGmd6nw8hnQzx0zZW4rt3ZlBKo4ABJgMumtAgEwzXInQhpQ
         iJ3KwWjCRmgPTALOfMwepuVx+KSN1mfPzT3wrPLd41dfgz4wQWCWmiP+hs8XtZQrRy8M
         XifUEjHfYv5vrBNHeRttAlyHPlmfg+181MmqAXr/zPzyt08FWp1GZBUy/6Np0o6uvvJ0
         WN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0ORQADKMrB8WnJjXtRJ19aGpSRDE6kwVQjbknX6w+0=;
        b=XjUqZ9E20ZkSXil9qISmPCWZkp/pV2wmowspOdNgdqRYZcWSiKPnH67/oI8zOVdwXl
         vCip3EUW4mhrWkpEd6fqciGS6wXP+AVBJS/b5P9DxPIn6FB5BKeVcEMkAxquSKkTrz1I
         huO61OSaXR76qevEmSdvkdRsYUWZ7rOhtyNmrjqXzS8GeHM3blTdFUm45/78Z6cpU1hu
         +VAWuVgAVPHde68ODmSrNxhyW0QdHhl07FZCG26p3aWNBRonRzssOJk5Ild9AgpGl4M1
         CcHAdU2acz3tND/kssJst2UoEtUAa6OLxai8l7B2Cjy+C3Hv64L08ox72mKz5FxVpwk0
         VQxw==
X-Gm-Message-State: AOAM533jgJ6zwOWwdk83c1heHvvtz/+HaLgPz5ZSwfCLKvt0eQ21BbAL
        YleHQltprQ1MLFndo9Va6yi+uQ==
X-Google-Smtp-Source: ABdhPJzomRaa3mASOSFb1gNArAICM4aHrmx+rchKx8LU2nl8KhkM/VsLskfh+uHzSYQjACEB0evP1g==
X-Received: by 2002:a02:6a24:: with SMTP id l36mr113117jac.4.1628091392293;
        Wed, 04 Aug 2021 08:36:32 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id z11sm1687480ioh.14.2021.08.04.08.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 08:36:32 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/6] net: ipa: improve IPA clock error messages
Date:   Wed,  4 Aug 2021 10:36:23 -0500
Message-Id: <20210804153626.1549001-4-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210804153626.1549001-1-elder@linaro.org>
References: <20210804153626.1549001-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange messages reported when errors occur in the IPA clock code,
so that the specific interconnect is identified when an error occurs
enabling or disabling it, or the core clock is indicated when an
error occurs enabling it.

Have ipa_interconnect_disable() return zero or the negative error
value returned by the first interconnect that produced an error
when disabled.  For now, the callers ignore the returned value.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_clock.c | 39 +++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ipa/ipa_clock.c b/drivers/net/ipa/ipa_clock.c
index 69ef6ea41e619..849b6ec671a4d 100644
--- a/drivers/net/ipa/ipa_clock.c
+++ b/drivers/net/ipa/ipa_clock.c
@@ -144,8 +144,12 @@ static int ipa_interconnect_enable(struct ipa *ipa)
 		ret = icc_set_bw(interconnect->path,
 				 interconnect->average_bandwidth,
 				 interconnect->peak_bandwidth);
-		if (ret)
+		if (ret) {
+			dev_err(&ipa->pdev->dev,
+				"error %d enabling %s interconnect\n",
+				ret, icc_get_name(interconnect->path));
 			goto out_unwind;
+		}
 		interconnect++;
 	}
 
@@ -159,10 +163,11 @@ static int ipa_interconnect_enable(struct ipa *ipa)
 }
 
 /* To disable an interconnect, we just its bandwidth to 0 */
-static void ipa_interconnect_disable(struct ipa *ipa)
+static int ipa_interconnect_disable(struct ipa *ipa)
 {
 	struct ipa_interconnect *interconnect;
 	struct ipa_clock *clock = ipa->clock;
+	struct device *dev = &ipa->pdev->dev;
 	int result = 0;
 	u32 count;
 	int ret;
@@ -172,13 +177,16 @@ static void ipa_interconnect_disable(struct ipa *ipa)
 	while (count--) {
 		interconnect--;
 		ret = icc_set_bw(interconnect->path, 0, 0);
-		if (ret && !result)
-			result = ret;
+		if (ret) {
+			dev_err(dev, "error %d disabling %s interconnect\n",
+				ret, icc_get_name(interconnect->path));
+			/* Try to disable all; record only the first error */
+			if (!result)
+				result = ret;
+		}
 	}
 
-	if (result)
-		dev_err(&ipa->pdev->dev,
-			"error %d disabling IPA interconnects\n", ret);
+	return result;
 }
 
 /* Turn on IPA clocks, including interconnects */
@@ -191,8 +199,10 @@ static int ipa_clock_enable(struct ipa *ipa)
 		return ret;
 
 	ret = clk_prepare_enable(ipa->clock->core);
-	if (ret)
-		ipa_interconnect_disable(ipa);
+	if (ret) {
+		dev_err(&ipa->pdev->dev, "error %d enabling core clock\n", ret);
+		(void)ipa_interconnect_disable(ipa);
+	}
 
 	return ret;
 }
@@ -201,7 +211,7 @@ static int ipa_clock_enable(struct ipa *ipa)
 static void ipa_clock_disable(struct ipa *ipa)
 {
 	clk_disable_unprepare(ipa->clock->core);
-	ipa_interconnect_disable(ipa);
+	(void)ipa_interconnect_disable(ipa);
 }
 
 /* Get an IPA clock reference, but only if the reference count is
@@ -238,13 +248,8 @@ void ipa_clock_get(struct ipa *ipa)
 		goto out_mutex_unlock;
 
 	ret = ipa_clock_enable(ipa);
-	if (ret) {
-		dev_err(&ipa->pdev->dev, "error %d enabling IPA clock\n", ret);
-		goto out_mutex_unlock;
-	}
-
-	refcount_set(&clock->count, 1);
-
+	if (!ret)
+		refcount_set(&clock->count, 1);
 out_mutex_unlock:
 	mutex_unlock(&clock->mutex);
 }
-- 
2.27.0

