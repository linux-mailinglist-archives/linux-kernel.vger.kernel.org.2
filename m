Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C33323806
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:46:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233509AbhBXHpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:45:50 -0500
Received: from z11.mailgun.us ([104.130.96.11]:47616 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230315AbhBXHpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:45:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614152721; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=+to7K/gjQwK7Mg4gqGOgM3TFlmy98hvO4+oUUNDsQzQ=; b=glQUFYNm+oRvIVbQ1LQLI2a7S76XZodBnmtMqcwD1jnLkOHV0t142+NDOmJsmgsUiP7Og24a
 08FJ2/cwgOpGs5o0KNsZV1/i9MtYrUoQ+R/B7QF/kk3DyksUAaxhN0bZA5J3qQuujTjXUetd
 GRjcS2aUgqqMWX0Bd2comFR+4b0=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 603603ea48e80e1dc5b93ea7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Feb 2021 07:44:42
 GMT
Sender: mojha=qti.qualcomm.com@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5F57DC43464; Wed, 24 Feb 2021 07:44:41 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mojha-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3A372C433C6;
        Wed, 24 Feb 2021 07:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3A372C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=qti.qualcomm.com
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mojha@qti.qualcomm.com
From:   Mukesh Ojha <mojha@qti.qualcomm.com>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH v2 1/2] pstore: Add mem_type property DT parsing support
Date:   Wed, 24 Feb 2021 13:14:25 +0530
Message-Id: <1614152666-30137-1-git-send-email-mojha@qti.qualcomm.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mukesh Ojha <mojha@codeaurora.org>

There could be a sceanario where we define some region
in normal memory and use them store to logs which is later
retrieved by bootloader during warm reset.

In this scenario, we wanted to treat this memory as normal
cacheable memory instead of default behaviour which
is an overhead. Making it cacheable could improve
performance.

This commit gives control to change mem_type from Device
tree, and also documents the value for normal memory.

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
Changes in v2:
 - if-else converted to switch case
 - updated MODULE_PARM_DESC with new memory type.
 - default setting is still intact.

 Documentation/admin-guide/ramoops.rst |  4 +++-
 fs/pstore/ram.c                       |  3 ++-
 fs/pstore/ram_core.c                  | 18 ++++++++++++++++--
 3 files changed, 21 insertions(+), 4 deletions(-)

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
index ca6d8a8..af4ca6a4 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -56,7 +56,7 @@ MODULE_PARM_DESC(mem_size,
 static unsigned int mem_type;
 module_param(mem_type, uint, 0400);
 MODULE_PARM_DESC(mem_type,
-		"set to 1 to try to use unbuffered memory (default 0)");
+		"set to 1 to use unbuffered memory, 2 for cached memory (default 0)");
 
 static int ramoops_max_reason = -1;
 module_param_named(max_reason, ramoops_max_reason, int, 0400);
@@ -666,6 +666,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 		field = value;						\
 	}
 
+	parse_u32("mem-type", pdata->record_size, pdata->mem_type);
 	parse_u32("record-size", pdata->record_size, 0);
 	parse_u32("console-size", pdata->console_size, 0);
 	parse_u32("ftrace-size", pdata->ftrace_size, 0);
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index aa8e0b6..0da012f 100644
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
@@ -409,10 +413,20 @@ static void *persistent_ram_vmap(phys_addr_t start, size_t size,
 	page_start = start - offset_in_page(start);
 	page_count = DIV_ROUND_UP(size + offset_in_page(start), PAGE_SIZE);
 
-	if (memtype)
+	switch (memtype) {
+	case MEM_TYPE_NORMAL:
+		prot = PAGE_KERNEL;
+		break;
+	case MEM_TYPE_NONCACHED:
 		prot = pgprot_noncached(PAGE_KERNEL);
-	else
+		break;
+	case MEM_TYPE_WCOMBINE:
 		prot = pgprot_writecombine(PAGE_KERNEL);
+		break;
+	default:
+		pr_err("invalid memory type\n");
+		return NULL;
+	}
 
 	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
 	if (!pages) {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

