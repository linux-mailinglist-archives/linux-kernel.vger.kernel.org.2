Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80DC130A910
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 14:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbhBANt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 08:49:58 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:21433 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231587AbhBANt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 08:49:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612187376; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0h6vSmXJIywnHGo/ywgkqW2Fs8pNf3fPzIqOrsfxUCg=; b=JpzqhQxDlKI3MBNxbkkK68ynbH6PmbwLtKpPuzWwyPSQ7csgvIi7/QqObYyKZqkn5tC0ABYQ
 CQXJ7gHE5suln5lrtQCS532ctTHWeYEdq58yHEeAffjcqYPgesL9Xy9tNDzNgvpp4IifMhCa
 Ofs+YRkQMA7LpOaIY+4hQeeS1x4=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 601806d52d8ee3f99ff65740 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 01 Feb 2021 13:49:09
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2831DC43461; Mon,  1 Feb 2021 13:49:09 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from charante-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BB8E2C433CA;
        Mon,  1 Feb 2021 13:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BB8E2C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, vbabka@suse.cz, rientjes@google.com,
        mhocko@suse.com
Cc:     vinmenon@codeaurora.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH] mm: page_alloc: update the COMPACT[STALL|FAIL] events properly
Date:   Mon,  1 Feb 2021 19:18:58 +0530
Message-Id: <1612187338-19100-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By defination, COMPACT[STALL|FAIL] events needs to be counted when there
is 'At least in one zone compaction wasn't deferred or skipped from the
direct compaction'. And when compaction is skipped or deferred,
COMPACT_SKIPPED will be returned but it will still go and update these
compaction events which is wrong in the sense that COMPACT[STALL|FAIL]
is counted without even trying the compaction.

Correct this by skipping the counting of these events when
COMPACT_SKIPPED is returned for compaction. This indirectly also avoid
the unnecessary try into the get_page_from_freelist() when compaction is
not even tried.

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 519a60d..531f244 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4152,6 +4152,8 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	memalloc_noreclaim_restore(noreclaim_flag);
 	psi_memstall_leave(&pflags);
 
+	if (*compact_result == COMPACT_SKIPPED)
+		return NULL;
 	/*
 	 * At least in one zone compaction wasn't deferred or skipped, so let's
 	 * count a compaction stall
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

