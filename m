Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B401361B80
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239957AbhDPIXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:23:35 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31720 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229706AbhDPIXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:23:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618561387; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=tBKdd4/GyUMVTeJZBzfZH4rm839u9pM6K3ncjXPkHlg=; b=vaa1UzacaIDqszXkNOvAl0/jaSKa8uKHrL7cO4BdKSKK85Tymu9w0cMMiZ5eJujKWn8Aoa6q
 ynlIU0a4KK664oj+RWItcmt3VyUyx94iOJ8YwAjToAQMwguCrqLMdPRDqDdMuzHIe+djBAS4
 mVqC7k6qdyG90eRU/J4LhkflEac=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60794967e0e9c9a6b6ce8724 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Apr 2021 08:23:03
 GMT
Sender: taozha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CDC64C43463; Fri, 16 Apr 2021 08:23:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from taozha-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: taozha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CDBC0C43461;
        Fri, 16 Apr 2021 08:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CDBC0C43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=taozha@codeaurora.org
From:   Tao Zhang <taozha@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     Tao Zhang <taozha@codeaurora.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Yuanfang Zhang <zhangyuanfang@codeaurora.org>
Subject: [PATCH v1 1/2] coresight: Add support for device names
Date:   Fri, 16 Apr 2021 16:22:41 +0800
Message-Id: <1618561362-1561-2-git-send-email-taozha@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618561362-1561-1-git-send-email-taozha@codeaurora.org>
References: <1618561362-1561-1-git-send-email-taozha@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to read device names from device tree entries. Before
the previous process of allocating coresight device name, try to
read the coresight device name from device tree entries. If it is
read, the device name will be returned directly. If it is not read,
the original allocation name process will be followed.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Signed-off-by: Tao Zhang <taozha@codeaurora.org>
---
 drivers/hwtracing/coresight/coresight-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 4ba801d..b79c726 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1640,6 +1640,12 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
 	int idx;
 	char *name = NULL;
 	struct fwnode_handle **list;
+	struct device_node *node = dev->of_node;
+
+	if (!node) {
+		if (!of_property_read_string(node, "coresight-name", &name))
+			return name;
+	}
 
 	mutex_lock(&coresight_mutex);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

