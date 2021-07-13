Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E513C6FED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 13:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235919AbhGMLtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 07:49:43 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:11456 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235797AbhGMLtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 07:49:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626176813; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=zqFL0K40ucNLaW/YDFV3wxDvNTBjPj344YdNZFt7kLw=; b=XBtpvndljT/Qu18UkelZFYTRDZdFEHPNpm2GXaMR3NutzHp+A2SuOjneYvFjajkR0H2pPCFX
 wB4IoyeuBv2kgxx5rbffgFu5PCWUysCiEgTBXy4HAAYFKnv+uGfL9ub/Np6AnI2nAicu94L6
 IW2O8MoegZ9oxVmCIuvO/VOoYDI=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60ed7cff5e3e57240b4ccc83 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 13 Jul 2021 11:46:07
 GMT
Sender: vjitta=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9458EC4360C; Tue, 13 Jul 2021 11:46:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from vjitta-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6932CC433F1;
        Tue, 13 Jul 2021 11:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6932CC433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        vinmenon@codeaurora.org, vjitta@codeaurora.org
Subject: [PATCH] mm: slub: Fix slub_debug disablement for list of slabs
Date:   Tue, 13 Jul 2021 17:15:50 +0530
Message-Id: <1626176750-13099-1-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayanand Jitta <vjitta@codeaurora.org>

Consider the scenario where CONFIG_SLUB_DEBUG_ON is set
and we would want to disable slub_debug for few slabs.
Using boot parameter with slub_debug=-,slab_name syntax
doesn't work as expected i.e; only disabling debugging for
the specified list of slabs, instead it disables debugging
for all slabs. Fix this.

Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 mm/slub.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index dc863c1..5a88418 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1429,6 +1429,7 @@ static int __init setup_slub_debug(char *str)
 	char *slab_list;
 	bool global_slub_debug_changed = false;
 	bool slab_list_specified = false;
+	bool slab_list_debug_disable = true;
 
 	slub_debug = DEBUG_DEFAULT_FLAGS;
 	if (*str++ != '=' || !*str)
@@ -1436,7 +1437,6 @@ static int __init setup_slub_debug(char *str)
 		 * No options specified. Switch on full debugging.
 		 */
 		goto out;
-
 	saved_str = str;
 	while (str) {
 		str = parse_slub_debug_flags(str, &flags, &slab_list, true);
@@ -1445,6 +1445,8 @@ static int __init setup_slub_debug(char *str)
 			slub_debug = flags;
 			global_slub_debug_changed = true;
 		} else {
+			if (flags || !IS_ENABLED(CONFIG_SLUB_DEBUG_ON))
+				slab_list_debug_disable = false;
 			slab_list_specified = true;
 		}
 	}
@@ -1456,7 +1458,7 @@ static int __init setup_slub_debug(char *str)
 	 * long as there is no option specifying flags without a slab list.
 	 */
 	if (slab_list_specified) {
-		if (!global_slub_debug_changed)
+		if (!global_slub_debug_changed && !slab_list_debug_disable)
 			slub_debug = 0;
 		slub_debug_string = saved_str;
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
2.7.4

