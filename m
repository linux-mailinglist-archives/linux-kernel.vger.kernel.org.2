Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E13437191D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 18:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhECQVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 12:21:12 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:39784 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhECQVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 12:21:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620058811; h=References: In-Reply-To: References:
 In-Reply-To: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=hEE3w8HTASHETEiuf9bTDObpKPT8w+L8zVEz6r58fms=; b=EhP7zuyVnkPYIOeZFdX49lSXp4h5YQYeC+cRWIXs3BfMVQGXEXUwCm+nNSIt+wT9vifzwebC
 HBnnyOy7/tChBpeJToSW1lmWhGeRQJqJKYJmI/mUM7/gS5G5885fmEQsKxouMR8rb1tUk0Ib
 w1HqLYkyTlRptR0HadiTV2JFM6E=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 609022b3c06dd10a2d56c700 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 03 May 2021 16:20:03
 GMT
Sender: schowdhu=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 88FB4C43145; Mon,  3 May 2021 16:20:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-525.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: schowdhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F43BC4323A;
        Mon,  3 May 2021 16:19:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F43BC4323A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=schowdhu@codeaurora.org
From:   Souradeep Chowdhury <schowdhu@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, vkoul@kernel.org,
        Souradeep Chowdhury <schowdhu@codeaurora.org>
Subject: [PATCH V4 3/4] MAINTAINERS: Add the entry for DCC(Data Capture and Compare) driver support
Date:   Mon,  3 May 2021 21:47:29 +0530
Message-Id: <05d37ff0525e781fd28179e187dc1d554ac23985.1620056206.git.schowdhu@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1620056206.git.schowdhu@codeaurora.org>
References: <cover.1620056206.git.schowdhu@codeaurora.org>
In-Reply-To: <cover.1620056206.git.schowdhu@codeaurora.org>
References: <cover.1620056206.git.schowdhu@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added the entries for all the files added as a part of driver support for
DCC(Data Capture and Compare).

Signed-off-by: Souradeep Chowdhury <schowdhu@codeaurora.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d92f85c..fb28218 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4969,6 +4969,14 @@ F:	include/linux/tfrc.h
 F:	include/uapi/linux/dccp.h
 F:	net/dccp/
 
+QTI DCC DRIVER
+M:	Souradeep Chowdhury <schowdhu@codeaurora.org>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/sysfs-driver-dcc
+F:	Documentation/devicetree/bindings/arm/msm/qcom,dcc.yaml
+F:	drivers/soc/qcom/dcc.c
+
 DECnet NETWORK LAYER
 L:	linux-decnet-user@lists.sourceforge.net
 S:	Orphan
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

