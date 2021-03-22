Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B65B9344EC0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 19:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhCVSnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 14:43:40 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:29725 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbhCVSnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 14:43:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1616438602; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=UAE86TM7cBWMTScfwM9qAFxkopoKgSbUvffSe5UtCqU=; b=TUmk/kfZHMrEr6QCPau4Aosx2eGdkhzykliZgiWGPSJg2CnTfzFXLK/R/gEbsZ/EnotsB9Xa
 XZqvixcu3NREEp81WS4QGOr0c91UZdtpj/fFwfbnMoyzS86hvqKOqSxdDeuyeAa+anXw8SUG
 o1F2Vd3sDO8kaOuRotA4WN4RAPY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 6058e53fe2200c0a0dc3c4f1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Mar 2021 18:43:11
 GMT
Sender: mojha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 07E47C433ED; Mon, 22 Mar 2021 18:43:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mojha-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D3F55C433C6;
        Mon, 22 Mar 2021 18:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D3F55C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     linux-kernel@vger.kernel.org
Cc:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH v3] pstore: Add mem_type property DT parsing support
Date:   Tue, 23 Mar 2021 00:12:17 +0530
Message-Id: <1616438537-13719-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There could be a scenario where we define some region
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
Changes in v3:
 - Minor code and documentation update done as per comment given by Kees.

Changes in v2:
 - if-else converted to switch case
 - updated MODULE_PARM_DESC with new memory type.
 - default setting is still intact.

 Documentation/admin-guide/ramoops.rst                  |  4 +++-
 .../devicetree/bindings/reserved-memory/ramoops.txt    | 10 ++++++++--
 fs/pstore/ram.c                                        |  7 ++++++-
 fs/pstore/ram_core.c                                   | 18 ++++++++++++++++--
 4 files changed, 33 insertions(+), 6 deletions(-)

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
diff --git a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
index b7886fe..6f1cb20 100644
--- a/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
+++ b/Documentation/devicetree/bindings/reserved-memory/ramoops.txt
@@ -42,8 +42,14 @@ Optional properties:
 - pmsg-size: size in bytes of log buffer reserved for userspace messages
   (defaults to 0: disabled)
 
-- unbuffered: if present, use unbuffered mappings to map the reserved region
-  (defaults to buffered mappings)
+- mem-type: if present, sets the type of mapping is to be used to map the
+  reserved region. mem-type: 0 = write-combined (default), 1 = unbuffered,
+  2 = cached.
+
+- unbuffered: deprecated, use mem_type instead. if present, and mem_type is
+  not specified, it is equivalent to mem_type = 1 and uses unbuffered mappings
+  to map the reserved region (defaults to buffered mappings mem_type = 0). If
+  both are specified -- "mem_type" overrides "unbuffered".
 
 - max-reason: if present, sets maximum type of kmsg dump reasons to store
   (defaults to 2: log Oopses and Panics). This can be set to INT_MAX to
diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index ca6d8a8..fefe3d3 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -56,7 +56,7 @@ MODULE_PARM_DESC(mem_size,
 static unsigned int mem_type;
 module_param(mem_type, uint, 0400);
 MODULE_PARM_DESC(mem_type,
-		"set to 1 to try to use unbuffered memory (default 0)");
+		"memory type: 0=write-combined (default), 1=unbuffered, 2=cached");
 
 static int ramoops_max_reason = -1;
 module_param_named(max_reason, ramoops_max_reason, int, 0400);
@@ -648,6 +648,10 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 
 	pdata->mem_size = resource_size(res);
 	pdata->mem_address = res->start;
+	/*
+	 * Setting "unbuffered" is deprecated and will be ignored if
+	 * "mem_type" is also specified.
+	 */
 	pdata->mem_type = of_property_read_bool(of_node, "unbuffered");
 	/*
 	 * Setting "no-dump-oops" is deprecated and will be ignored if
@@ -666,6 +670,7 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 		field = value;						\
 	}
 
+	parse_u32("mem-type", pdata->record_size, pdata->mem_type);
 	parse_u32("record-size", pdata->record_size, 0);
 	parse_u32("console-size", pdata->console_size, 0);
 	parse_u32("ftrace-size", pdata->ftrace_size, 0);
diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index fff363b..fe53050 100644
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
+		pr_err("invalid mem_type=%d\n", memtype);
+		return NULL;
+	}
 
 	pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);
 	if (!pages) {
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

