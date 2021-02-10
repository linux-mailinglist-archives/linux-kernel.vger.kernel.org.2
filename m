Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD3431697C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 15:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhBJOxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 09:53:30 -0500
Received: from so15.mailgun.net ([198.61.254.15]:23857 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231543AbhBJOx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 09:53:27 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612968787; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4MNOhqTSQMWaMMPmDACgTsRQFKSbXMW9XGxojqcW4dk=; b=lkFsFhREsa2GwSFS09qkP6IgRnyHjtgOxIfIx6lc/qJsF3hmCAp4HXw2168VbCKC4xtbAR5o
 GgK3kJeS4Rw+AvZFSuEbG1C6SMiXkaLoLkdhZljTLh+zOH0imdz6sUcv1DOopvq4BLK49paW
 bSNhJZxEmJzLhJO29lJaNoN0Mgw=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 6023f33334db06ef790a76f8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 14:52:35
 GMT
Sender: mojha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 85516C43463; Wed, 10 Feb 2021 14:52:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mojha-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 34E1BC433C6;
        Wed, 10 Feb 2021 14:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 34E1BC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     tony.luck@intel.com, ccross@android.com, anton@enomsg.org,
        keescook@chromium.org, Mukesh Ojha <mojha@codeaurora.org>,
        Huang Yiwei <hyiwei@codeaurora.org>
Subject: [PATCH] pstore/ram : Add support for cached pages
Date:   Wed, 10 Feb 2021 20:22:21 +0530
Message-Id: <1612968741-1692-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be a sceanario where we define some region
in normal memory and use them store to logs which is later
retrieved by bootloader during warm reset.

In this scenario, we wanted to treat this memory as normal
cacheable memory instead of default behaviour which
is an overhead. Making it cacheable could improve
performance.

This commit gives control to change mem_type from Device
tree, and also documents the value for normal memory.

Signed-off-by: Huang Yiwei <hyiwei@codeaurora.org>
Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 Documentation/admin-guide/ramoops.rst |  4 +++-
 fs/pstore/ram.c                       |  1 +
 fs/pstore/ram_core.c                  | 10 ++++++++--
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/ramoops.rst b/Documentation/admin-guide/ramoops.rst
index b0a1ae7..8f107d8 100644
--- a/Documentation/admin-guide/ramoops.rst
+++ b/Documentation/admin-guide/ramoops.rst
@@ -3,7 +3,7 @@ Ramoops oops/panic logger
 
 Sergiu Iordache <sergiu@chromium.org>
 
-Updated: 17 November 2011
+Updated: 10 Feb 2021
 
 Introduction
 ------------
@@ -30,6 +30,8 @@ mapping to pgprot_writecombine. Setting ``mem_type=1`` attempts to use
 depends on atomic operations. At least on ARM, pgprot_noncached causes the
 memory to be mapped strongly ordered, and atomic operations on strongly ordered
 memory are implementation defined, and won't work on many ARMs such as omaps.
+Setting ``mem_type=2`` attempts to treat the memory region as normal memory,
+which enables full cache on it. This can improve the performance.
 
 The memory area is divided into ``record_size`` chunks (also rounded down to
 power of two) and each kmesg dump writes a ``record_size`` chunk of
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index ca6d8a8..b262c57 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -666,6 +666,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 		field = value;						\
 	}
 
+	parse_u32("mem-type", pdata->record_size, pdata->mem_type);
 	parse_u32("record-size", pdata->record_size, 0);
 	parse_u32("console-size", pdata->console_size, 0);
 	parse_u32("ftrace-size", pdata->ftrace_size, 0);
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index aa8e0b6..83cd612 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -396,6 +396,10 @@ void persistent_ram_zap(struct persistent_ram_zone *prz)
 	persistent_ram_update_header_ecc(prz);
 }
 
+#define MEM_TYPE_WCOMBINE	0
+#define MEM_TYPE_NONCACHED	1
+#define MEM_TYPE_NORMAL		2
+
 static void *persistent_ram_vmap(phys_addr_t start, size_t size,
 		unsigned int memtype)
 {
@@ -409,9 +413,11 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size,
 	page_start = start - offset_in_page(start);
 	page_count = DIV_ROUND_UP(size + offset_in_page(start), PAGE_SIZE);
 
-	if (memtype)
+	if (memtype == MEM_TYPE_NORMAL)
+		prot = PAGE_KERNEL;
+	else if (memtype == MEM_TYPE_NONCACHED)
 		prot = pgprot_noncached(PAGE_KERNEL);
-	else
+	else if (memtype == MEM_TYPE_WCOMBINE)
 		prot = pgprot_writecombine(PAGE_KERNEL);
 
 	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

