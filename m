Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D183A33F9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 21:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhFJT0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 15:26:37 -0400
Received: from mail-il1-f180.google.com ([209.85.166.180]:35772 "EHLO
        mail-il1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhFJT03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 15:26:29 -0400
Received: by mail-il1-f180.google.com with SMTP id b9so2921852ilr.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 12:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4/t4sCO8hQSs7ROFTaaBJV7ulZEJYwQ8iet8BnuZgGk=;
        b=RzSk2322WnM1iVkHW1uBofB1ujueFj1W/pbj0oQ2e9XYC+ffyOtiSS4kMWtvPX6zUG
         eLR1VgahrCCM7Yqgr6Jy8wO9/zwc10QL4Ms+L43O/d7zdjs2kQwrp+52k143QMfcq+n7
         G3hvUUSFBwkXH8e1r9RAUaVlvI3bpjOFSaVyABM8lG6NGpUBhPumilBO+yX02NscqIvS
         VN2Q3naCo3yfuo1Ekeaq+kF7dD7+ozJPcA9HpDJ+iA3YoiTkftdFgv//glx8aM0jDIwj
         LS37PTvGmATkNhAWDjqGG5LgI19Fr7As1LSnlBLhTw7beMIsfGATFH7VAN4RGEKwgM7A
         qrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4/t4sCO8hQSs7ROFTaaBJV7ulZEJYwQ8iet8BnuZgGk=;
        b=fGG1A8+ryfdJM5DSX/40AgnBGBHliacwA4uuItHcSLoXytBAirZA7PZNrDGrtyeC0u
         ddh/4eMCP/lecERsScOnx41NB5gJLgmsHxB6x/ptc9Pk4IdfnBXeKbfrrTrTR811093H
         XrzaUV//oy9q/THWIArSkYp9tZeWus4oDd/gk1AOYOnYI7am9k4md3PD/dQlg7MiDfMu
         dlwZwXCtwQYBY/Fm704hYWcQ6VSgc33bTe/pd6akDMC6JhJ9cF5ouE5L5BLbgaOTicHv
         ODB5ByUj/M0W0h1sgb3DZaNKLUlsXH9ddSmZoZdxOL0IP3rd1L3+jkq9pTQd+3FpKVlT
         91yw==
X-Gm-Message-State: AOAM531Jhfnx5DYhSbmLqQoUY3SqTUR3ttGFAWxsN8ZTgUGhjMlMlRCW
        EUKl/LXFcgKRfFlRbvp56SIRNg==
X-Google-Smtp-Source: ABdhPJzcNCcJp24CU3+h3HGFaQ/vUUNEYxmQlfJLA4Syd4yDyZfs7bqjZpMfEy4j7eYOJinnLus3wQ==
X-Received: by 2002:a05:6e02:c4:: with SMTP id r4mr300184ilq.76.1623352995686;
        Thu, 10 Jun 2021 12:23:15 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id w21sm2028684iol.52.2021.06.10.12.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 12:23:15 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 3/8] net: ipa: pass mem_id to ipa_filter_reset_table()
Date:   Thu, 10 Jun 2021 14:23:03 -0500
Message-Id: <20210610192308.2739540-4-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210610192308.2739540-1-elder@linaro.org>
References: <20210610192308.2739540-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pass a memory region ID rather than the address of a memory region
descriptor to ipa_filter_reset_table(), to simplify callers.

We can eliminate the check for a zero region size in this function
because ipa_table_reset_add() checks that before adding anything to
the transaction.

Note that here and in subsequent commits there is no need to check
whether a memory region exists, because we will have already
verified that during initialization.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_table.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index 3168d72f42450..95a4c2aceb010 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -282,16 +282,14 @@ static void ipa_table_reset_add(struct gsi_trans *trans, bool filter,
  * for the IPv4 and IPv6 non-hashed and hashed filter tables.
  */
 static int
-ipa_filter_reset_table(struct ipa *ipa, const struct ipa_mem *mem, bool modem)
+ipa_filter_reset_table(struct ipa *ipa, enum ipa_mem_id mem_id, bool modem)
 {
+	const struct ipa_mem *mem = &ipa->mem[mem_id];
 	u32 ep_mask = ipa->filter_map;
 	u32 count = hweight32(ep_mask);
 	struct gsi_trans *trans;
 	enum gsi_ee_id ee_id;
 
-	if (!mem->size)
-		return 0;
-
 	trans = ipa_cmd_trans_alloc(ipa, count);
 	if (!trans) {
 		dev_err(&ipa->pdev->dev,
@@ -327,20 +325,18 @@ static int ipa_filter_reset(struct ipa *ipa, bool modem)
 {
 	int ret;
 
-	ret = ipa_filter_reset_table(ipa, &ipa->mem[IPA_MEM_V4_FILTER], modem);
+	ret = ipa_filter_reset_table(ipa, IPA_MEM_V4_FILTER, modem);
 	if (ret)
 		return ret;
 
-	ret = ipa_filter_reset_table(ipa, &ipa->mem[IPA_MEM_V4_FILTER_HASHED],
-				     modem);
+	ret = ipa_filter_reset_table(ipa, IPA_MEM_V4_FILTER_HASHED, modem);
 	if (ret)
 		return ret;
 
-	ret = ipa_filter_reset_table(ipa, &ipa->mem[IPA_MEM_V6_FILTER], modem);
+	ret = ipa_filter_reset_table(ipa, IPA_MEM_V6_FILTER, modem);
 	if (ret)
 		return ret;
-	ret = ipa_filter_reset_table(ipa, &ipa->mem[IPA_MEM_V6_FILTER_HASHED],
-				     modem);
+	ret = ipa_filter_reset_table(ipa, IPA_MEM_V6_FILTER_HASHED, modem);
 
 	return ret;
 }
-- 
2.27.0

