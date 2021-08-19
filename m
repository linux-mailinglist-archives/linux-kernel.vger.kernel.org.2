Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793ED3F10FA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 05:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236027AbhHSDD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 23:03:58 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40053 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235770AbhHSDDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 23:03:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1629342196; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=+uqIKs+1YDY0QygKwZ/HoPC7ACFQJxCKJ60abTTEeqc=; b=dKbRxOufR04fJYnpfyEKpuw8ntyDUQ4G/9+zzrd4XhC6h5szA4n4HYLrTGccHA3S4rH+S7rR
 ksWWoqISYDAJ8w4Ko1gNYD7gLrNr7zwE/2o9bvHaHIaICuzm99E5gmXvn7CUaeYuE6pDBOkp
 hUk4EiHEyQ9PT8IwfLhG13CdcfU=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 611dc9f266ff107904274e39 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 19 Aug 2021 03:03:14
 GMT
Sender: sibis=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 782ADC4361C; Thu, 19 Aug 2021 03:03:13 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from blr-ubuntu-87.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24D5DC43616;
        Thu, 19 Aug 2021 03:03:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 24D5DC43616
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     mka@chromium.org, swboyd@chromium.org, bjorn.andersson@linaro.org,
        robh+dt@kernel.org
Cc:     ulf.hansson@linaro.org, rjw@rjwysocki.net, agross@kernel.org,
        ohad@wizery.com, mathieu.poirier@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rishabhb@codeaurora.org,
        sidgup@codeaurora.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v5 01/13] dt-bindings: soc: qcom: aoss: Drop the load state power-domain
Date:   Thu, 19 Aug 2021 08:32:04 +0530
Message-Id: <1629342136-3667-2-git-send-email-sibis@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1629342136-3667-1-git-send-email-sibis@codeaurora.org>
References: <1629342136-3667-1-git-send-email-sibis@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The power-domains exposed by AOSS QMP node are used to notify the Always
on Subsystem (AOSS) that a particular co-processor is up/down. These
co-processors enter low-power modes independent to that of the application
processor and their states are expected to remain unaltered across system
suspend/resume cycles. To achieve this behavior let's drop the load
power-domain and replace them with generic qmp_send interface instead.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
index 93e4b737ee1b..c55e98fc14fa 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -19,8 +19,7 @@ description:
 
   The AOSS side channel exposes control over a set of resources, used to control
   a set of debug related clocks and to affect the low power state of resources
-  related to the secondary subsystems. These resources are exposed as a set of
-  power-domains.
+  related to the secondary subsystems.
 
 properties:
   compatible:
@@ -57,13 +56,6 @@ properties:
     description:
       The single clock represents the QDSS clock.
 
-  "#power-domain-cells":
-    const: 1
-    description: |
-        The provided power-domains are:
-        CDSP state (0), LPASS state (1), modem state (2), SLPI
-        state (3), SPSS state (4) and Venus state (5).
-
 required:
   - compatible
   - reg
@@ -101,7 +93,6 @@ examples:
       mboxes = <&apss_shared 0>;
 
       #clock-cells = <0>;
-      #power-domain-cells = <1>;
 
       cx_cdev: cx {
         #cooling-cells = <2>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

