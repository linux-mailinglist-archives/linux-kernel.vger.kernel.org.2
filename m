Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56C7D31A3B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 18:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhBLRe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 12:34:26 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:27321 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231258AbhBLReV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 12:34:21 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613151237; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=K2S35ZMNfNKZ70ztSuai8wLbHzfvfWAbdZyFwSz4e3Q=; b=oqQ3IdJ+ISFP42MHUsWAqOFSZ4HSvxtquZ0gbk8gxVrfMuBv/aYJkX5gSA1Cj41T0jq+clq/
 AiMpmIgKsrkRYsUM2fH5hgVJEiYfZVhG/whefI2m5O+4DJ82eEopj2XGB+YuJoFzcU07AD4f
 JFm5bijeuLY6Ib+9lk5LM0lmgEE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 6026bbea81f6c45dceb468c5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Feb 2021 17:33:30
 GMT
Sender: charante=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 98748C433ED; Fri, 12 Feb 2021 17:33:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from charante-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82B37C433CA;
        Fri, 12 Feb 2021 17:33:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82B37C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, rientjes@google.com, vbabka@suse.cz,
        linux-mm@kvack.org
Cc:     vinmenon@codeaurora.org, linux-kernel@vger.kernel.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH V2] mm: compaction: update the COMPACT[STALL|FAIL] events properly
Date:   Fri, 12 Feb 2021 23:03:04 +0530
Message-Id: <1613151184-21213-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By definition, COMPACT[STALL|FAIL] events needs to be counted when there
is 'At least in one zone compaction wasn't deferred or skipped from the
direct compaction'. And when compaction is skipped or deferred,
COMPACT_SKIPPED will be returned but it will still go and update these
compaction events which is wrong in the sense that COMPACT[STALL|FAIL]
is counted without even trying the compaction.

Correct this by skipping the counting of these events when
COMPACT_SKIPPED is returned for compaction. This indirectly also avoid
the unnecessary try into the get_page_from_freelist() when compaction is
not even tried.

There is a corner case where compaction is skipped but still count
COMPACTSTALL event, which is that IRQ came and freed the page and the
same is captured in capture_control.

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---

changes in V1: https://lore.kernel.org/patchwork/patch/1373665/

 mm/compaction.c | 8 ++++++++
 mm/page_alloc.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/mm/compaction.c b/mm/compaction.c
index 190ccda..104ebef 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -2487,6 +2487,14 @@ static enum compact_result compact_zone_order(struct zone *zone, int order,
 	 */
 	WRITE_ONCE(current->capture_control, NULL);
 	*capture = READ_ONCE(capc.page);
+	/*
+	 * Technically, it is also possible that compaction is skipped but
+	 * the page is still captured out of luck(IRQ came and freed the page).
+	 * Returning COMPACT_SUCCESS in such cases helps in properly accounting
+	 * the COMPACT[STALL|FAIL] when compaction is skipped.
+	 */
+	if (*capture)
+		ret = COMPACT_SUCCESS;
 
 	return ret;
 }
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

