Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB893E83AD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 21:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbhHJT1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 15:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbhHJT1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 15:27:35 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF124C0617A1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 12:27:11 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y1so372451iod.10
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 12:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ux+nWXRpxXp+ZCGVEu2iXcKzONeSoEn/jJZkwn5TrXk=;
        b=TElDuM1UeTsRvMrycPcQskB+U9XpBJYPazUYvbmZYLGoAD0F6ANvKkVepnO4I32r+g
         AIw4kPCx1SNru8H5sjMgQngmx7Qe6S0oRcDNIFtwEvtJScx4QftVslIDq6dG+iUSKRFa
         pQkfQJjqKhhY9aSp3VlAo1ZeIIO5oVN0xRUVh3WLvCzLUX/PZedMvjuWS3oxTYxOifJb
         crTOzO33sv2FCk9X3LyGeS2q8EmnzwcXBDjIWodzmOAUs8N1Lhx/IRbk+TiaRMrkJsOT
         xsjauy/O0cPUS1qZiq/q3hBufkcvsMfyJy5WmRnYxMTtPttSVLmzhYQ2Z15M1iwl5e1U
         kVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ux+nWXRpxXp+ZCGVEu2iXcKzONeSoEn/jJZkwn5TrXk=;
        b=VhGezYrs1G15pqdSnHSVOSQUAbpZxG1hYsQePlE+LZTfZgIVAIptgSgdtiA+MK73s4
         55H1f9LLiL0LIDYFDjUvLuq+zPKWFAtvUKQ2Z27gygGNJqnuun8i481kYGrCHgIt8bq6
         +9qaRrgqhM153u9kIg7pxzK5M0j+vwYSBPL1m6B/CUACLqzjSuThVk08eGAQVjCjSlzF
         SSMqFKdj88DkqFCGF2tIXYzEfREVU/mEdcaEtbMqUDJKUKN7iA7uXFJTanjnb38irl54
         gSW01GCZbNZ8ulT/HWLw4QcdZvAaGbfq9COl2/pfZ1fgdBSw0J6CZPa0QDYMqj+3Gjm2
         j0yQ==
X-Gm-Message-State: AOAM531rehfeuMe/LaQBf0Yu6YfEuxdjKdGXKGWqAMzD0fdiZNzQgfkv
        5s0XzXoI4X3a5nUYmNxGd7zf3Q==
X-Google-Smtp-Source: ABdhPJzDSRenVif50GkEjz2CpjhjQrnCmXmud36z6nf9KEn8DyOirYQjrg6HgdSdf7qILR+KWaiU6g==
X-Received: by 2002:a5d:8b51:: with SMTP id c17mr1311236iot.119.1628623631159;
        Tue, 10 Aug 2021 12:27:11 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c5sm3025356ioz.25.2021.08.10.12.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 12:27:10 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/7] net: ipa: get rid of extra clock reference
Date:   Tue, 10 Aug 2021 14:27:02 -0500
Message-Id: <20210810192704.2476461-6-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210810192704.2476461-1-elder@linaro.org>
References: <20210810192704.2476461-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suspending the IPA hardware is now managed by the runtime PM core
code.  The ->runtime_idle callback returns a non-zero value, so it
will never suspend except when forced.  As a result, there's no need
to take an extra "do not suspend" clock reference.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_main.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 64112a6767743..f332210ce5354 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -427,14 +427,6 @@ static int ipa_config(struct ipa *ipa, const struct ipa_data *data)
 {
 	int ret;
 
-	/* Get a clock reference to allow initialization.  This reference
-	 * is held after initialization completes, and won't get dropped
-	 * unless/until a system suspend request arrives.
-	 */
-	ret = ipa_clock_get(ipa);
-	if (WARN_ON(ret < 0))
-		goto err_clock_put;
-
 	ipa_hardware_config(ipa, data);
 
 	ret = ipa_mem_config(ipa);
@@ -477,8 +469,6 @@ static int ipa_config(struct ipa *ipa, const struct ipa_data *data)
 	ipa_mem_deconfig(ipa);
 err_hardware_deconfig:
 	ipa_hardware_deconfig(ipa);
-err_clock_put:
-	(void)ipa_clock_put(ipa);
 
 	return ret;
 }
@@ -496,7 +486,6 @@ static void ipa_deconfig(struct ipa *ipa)
 	ipa->interrupt = NULL;
 	ipa_mem_deconfig(ipa);
 	ipa_hardware_deconfig(ipa);
-	(void)ipa_clock_put(ipa);
 }
 
 static int ipa_firmware_load(struct device *dev)
-- 
2.27.0

