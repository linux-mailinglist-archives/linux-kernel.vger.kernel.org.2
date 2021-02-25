Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE512324D00
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236454AbhBYJfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:35:07 -0500
Received: from m42-2.mailgun.net ([69.72.42.2]:32950 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236437AbhBYJc3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:32:29 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614245527; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=WHtfJahktE3aa/wLaUk+ldAV3dxxmVj5oU7YvbIAnnM=; b=ZCNc+mfPriMzIs/Fbp+5DDRIR3TSRlJFj33GW5LPWcKTp1FICYb+tnO/qcTdZt4C7sMKMJxH
 usiHMm4A22WrHF7DjV6j4YNBACCI9QSMNXawwtl+flh/vQm3DeUhR91ddje2PIqNFjC88/xo
 6DQ1MPJW1VwOlox98tUh6AfTy7M=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60376e776bec4e44c6ded388 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 25 Feb 2021 09:31:35
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 74AE2C433CA; Thu, 25 Feb 2021 09:31:35 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 39BFCC433C6;
        Thu, 25 Feb 2021 09:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 39BFCC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     devicetree@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH 6/9] dt-bindings: soc: qcom: aoss: Add SC7280 compatible
Date:   Thu, 25 Feb 2021 15:00:22 +0530
Message-Id: <8584e915f42405a7a4a799133a09d0d4aa65d2a8.1614244789.git.saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <cover.1614244789.git.saiprakash.ranjan@codeaurora.org>
References: <cover.1614244789.git.saiprakash.ranjan@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SC7280 AOSS QMP compatible to the list of possible bindings.

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
index 19c059e44681..783dc81b0f26 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.txt
@@ -17,6 +17,7 @@ power-domains.
 	Value type: <string>
 	Definition: must be one of:
 		    "qcom,sc7180-aoss-qmp"
+		    "qcom,sc7280-aoss-qmp"
 		    "qcom,sdm845-aoss-qmp"
 		    "qcom,sm8150-aoss-qmp"
 		    "qcom,sm8250-aoss-qmp"
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

