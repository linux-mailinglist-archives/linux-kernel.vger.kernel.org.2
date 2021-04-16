Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEE6361B6C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 10:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240225AbhDPIJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:09:00 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:41057 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240207AbhDPII4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:08:56 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1618560512; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=3huQkCIQxwU3fG7sB0tL0HmGVzjHRE4WDz/luFfQpRk=; b=u+pseQxeS1/K/vhqyxQHZueSRjQjjP0ZuTdj/J6rVjXo1O6xkTm4zqSeJOpDGYAjJOAkajFI
 DRbfz2RYvyej8q59Bfq8FEPi6IHo7GfDAH3HfABNmK6pZ9QqUtnQkzAx33DcC45JUKoycwHq
 p//Pcd0rcplW+qK9U//DNhzd6zU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 607945f0a817abd39ad28fc3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 16 Apr 2021 08:08:16
 GMT
Sender: taozha=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E29DAC433CA; Fri, 16 Apr 2021 08:08:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from taozha-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: taozha)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76AA9C43464;
        Fri, 16 Apr 2021 08:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76AA9C43464
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
Subject: [PATCH v1 2/2] dt-bindings: arm: add property for coresight component name
Date:   Fri, 16 Apr 2021 16:07:56 +0800
Message-Id: <1618560476-28908-3-git-send-email-taozha@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1618560476-28908-1-git-send-email-taozha@codeaurora.org>
References: <1618560476-28908-1-git-send-email-taozha@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add property "coresight-name" for coresight component name. This
allows coresight driver to read device name from device entries.

Signed-off-by: Tao Zhang <taozha@codeaurora.org>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index d711676..0e980ce 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -103,6 +103,8 @@ its hardware characteristcs.
 	  powers down the coresight component also powers down and loses its
 	  context. This property is currently only used for the ETM 4.x driver.
 
+	* coresight-name: the name of the coresight devices.
+
 * Optional properties for ETM/PTMs:
 
 	* arm,cp14: must be present if the system accesses ETM/PTM management
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

