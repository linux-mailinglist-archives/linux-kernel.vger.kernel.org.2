Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AEB3B425F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 13:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhFYLUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 07:20:46 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51605 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231240AbhFYLUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 07:20:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1624619900; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=EiawOXeRsWAsggfGbA3DPuPoX2C49B6CHTKpGCLXz5U=; b=tCWoR8l9oJdmd5KnBhCZN07CylLXqfqd5JWcxdYiOhhnoTP5s7sTXKTxij+hQaMmImQf+XYJ
 GoeyIRcPdBw1f+BwdwhmxnPQmn3BPLFH/zRvHlMnniBCja+h9b5D6BBPB0wHoOAQeQBk++hS
 M7KVE2/4tgN4wYpaQkft78hKZKc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 60d5bb663a8b6d0a45a48ae7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 25 Jun 2021 11:17:58
 GMT
Sender: mojha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E3BF7C4323A; Fri, 25 Jun 2021 11:17:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from mojha-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BE875C433F1;
        Fri, 25 Jun 2021 11:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BE875C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     keescook@chromium.org, anton@enomsg.org, ccross@android.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org
Cc:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH] pstore/ram: Rework logic for detecting ramoops reserved memory region
Date:   Fri, 25 Jun 2021 16:47:18 +0530
Message-Id: <1624619838-2578-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Isaac J. Manjarres" <isaacm@codeaurora.org>

The reserved memory region for ramoops is assumed to be at a fixed
and known location when read from the devicetree. This is not desirable
in environments where it is preferred for the region to be dynamically
allocated at runtime, as opposed to it being fixed at compile time.

Change the logic for detecting the start and size of the ramoops
memory region by looking up the reserved memory region instead of
using platform_get_resource(), which assumes that the location
of the memory is known ahead of time.

Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 fs/pstore/ram.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index fefe3d3..5f90455 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -21,6 +21,7 @@
 #include <linux/pstore_ram.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
+#include <linux/of_reserved_mem.h>
 #include "internal.h"
 
 #define RAMOOPS_KERNMSG_HDR "===="
@@ -633,21 +634,21 @@ static int ramoops_parse_dt(struct platform_device *pdev,
 {
 	struct device_node *of_node = pdev->dev.of_node;
 	struct device_node *parent_node;
-	struct resource *res;
+	struct reserved_mem *rmem;
 	u32 value;
 	int ret;
 
 	dev_dbg(&pdev->dev, "using Device Tree\n");
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
+	rmem = of_reserved_mem_lookup(of_node);
+	if (!rmem) {
 		dev_err(&pdev->dev,
 			"failed to locate DT /reserved-memory resource\n");
 		return -EINVAL;
 	}
 
-	pdata->mem_size = resource_size(res);
-	pdata->mem_address = res->start;
+	pdata->mem_size = rmem->size;
+	pdata->mem_address = rmem->base;
 	/*
 	 * Setting "unbuffered" is deprecated and will be ignored if
 	 * "mem_type" is also specified.
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

