Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D44832BE0F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344634AbhCCQ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 11:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377234AbhCCMWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 07:22:36 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7A7C0617AA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 04:20:59 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b1so25985447lfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 04:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lD9APgZ2jhcnYCgOIeOpXqVPb3v1Goo0x0OpO8dXVPQ=;
        b=esW4B307jxAwSGPOl0hNyuol71pvJKogmDuDaPA54yUJHJrM3nvwlFIuL76Nlwalq/
         JWvdwuMpCdt6kJxkcvncGDud3z4yWyIU7w7upwmK2SfZ8BzGT4KxzUKEwDLGDK4NgMBD
         Dyg1n8aN5Bf+NI2Gdd8qNo7LLBPs+v6oYG77/Md9QOtMh0VmEoXipcjlg9v1keeTWI46
         XvKBEgV5v/mm1zCgpyBcHhed7kEXdyNW3s2Jv8amuGzPWPI8sZgu6I/H3mVejToMTd4Y
         egFkwDlKjBvoQ9mGdiauhpLF9mOAnYEL69HP+kh6FlQivqEqHerwiqVP3RpLgece0tU8
         1M+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lD9APgZ2jhcnYCgOIeOpXqVPb3v1Goo0x0OpO8dXVPQ=;
        b=iEBPE/OY+U4kTMNds3080MCxvt0QkP0cQMi/sYxMPV+76sYlGjZ+Y/en9uttfa0hyo
         N6+jMdcmVPcSmX4Atlgv2YvJH2usVX1Hyr3S6EEwKKK+TRn7RvNjejCaOJiRoqhzpHTB
         3RBADEKRYcTNuR58Nr+4RrayUV+p0hPSJd/FuD7Or/7i7JfjzUDvxwRXyTWhPxos9mCY
         y7VU5Quj2Iu3oa5WHXSPCeWTQnGjN8EAw49K4Nsl2rawialGijWmmIJtSbxta0LbOEG7
         DeN2nD3rpx7PqTa/UEsq9Jm2SJJi8TXukslbchnfA5sOW3kSEcc52z7Wk5aaSRY9BfsO
         C9Ng==
X-Gm-Message-State: AOAM530GY7voSFBVvM4Ec1IEixka69cY5MMIFJwT18DKI53EpNnjK2x2
        g4jnXCQdVL7KQX/C5qlBNKvILA==
X-Google-Smtp-Source: ABdhPJz3ZN1+8FheWJZpyLBpnGV/RnMW3VOVx9DzzJOy9r0WPzdCqF3RuL4kdnjCbeNNFO44GRKE7w==
X-Received: by 2002:a05:6512:3055:: with SMTP id b21mr14618790lfb.356.1614774058409;
        Wed, 03 Mar 2021 04:20:58 -0800 (PST)
Received: from localhost.localdomain (h-155-4-129-234.NA.cust.bahnhof.se. [155.4.129.234])
        by smtp.gmail.com with ESMTPSA id d3sm811519lfq.249.2021.03.03.04.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 04:20:57 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] mmc: block: Fix error path in mmc_blk_probe()
Date:   Wed,  3 Mar 2021 13:20:49 +0100
Message-Id: <20210303122049.151986-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210303122049.151986-1-ulf.hansson@linaro.org>
References: <20210303122049.151986-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Returning zero to indicate success, when we actually have failed to probe
is wrong. As a matter of fact, it leads to that mmc_blk_remove() gets
called at a card removal and then triggers "NULL pointer dereference"
splats. This is because mmc_blk_remove() relies on data structures and
pointers to be setup from mmc_blk_probe(), of course.

There have been no errors reported about this, which is most likely because
mmc_blk_probe() never fails like this. Nevertheless, let's fix the code by
propagating the error codes correctly and prevent us from leaking memory by
calling also destroy_workqueue() in the error path.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/block.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 39308b35a1fb..02b656305042 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2876,6 +2876,7 @@ static void mmc_blk_remove_debugfs(struct mmc_card *card,
 static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md, *part_md;
+	int ret = 0;
 
 	/*
 	 * Check that the card supports the command class(es) we need.
@@ -2893,19 +2894,24 @@ static int mmc_blk_probe(struct mmc_card *card)
 	}
 
 	md = mmc_blk_alloc(card);
-	if (IS_ERR(md))
-		return PTR_ERR(md);
+	if (IS_ERR(md)) {
+		ret = PTR_ERR(md);
+		goto out_free;
+	}
 
-	if (mmc_blk_alloc_parts(card, md))
+	ret = mmc_blk_alloc_parts(card, md);
+	if (ret)
 		goto out;
 
 	dev_set_drvdata(&card->dev, md);
 
-	if (mmc_add_disk(md))
+	ret = mmc_add_disk(md);
+	if (ret)
 		goto out;
 
 	list_for_each_entry(part_md, &md->part, part) {
-		if (mmc_add_disk(part_md))
+		ret = mmc_add_disk(part_md);
+		if (ret)
 			goto out;
 	}
 
@@ -2926,10 +2932,12 @@ static int mmc_blk_probe(struct mmc_card *card)
 
 	return 0;
 
- out:
+out:
 	mmc_blk_remove_parts(card, md);
 	mmc_blk_remove_req(md);
-	return 0;
+out_free:
+	destroy_workqueue(card->complete_wq);
+	return ret;
 }
 
 static void mmc_blk_remove(struct mmc_card *card)
-- 
2.25.1

