Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367433BD75F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 15:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233174AbhGFNEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 09:04:10 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:53924 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbhGFNEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 09:04:01 -0400
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 06 Jul 2021 06:01:21 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 06 Jul 2021 06:01:18 -0700
X-QCInternal: smtphost
Received: from c-sanm-linux.qualcomm.com ([10.206.25.31])
  by ironmsg02-blr.qualcomm.com with ESMTP; 06 Jul 2021 18:30:43 +0530
Received: by c-sanm-linux.qualcomm.com (Postfix, from userid 2343233)
        id AE5DB3A90; Tue,  6 Jul 2021 18:30:42 +0530 (IST)
From:   Sandeep Maheswaram <sanm@codeaurora.org>
To:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pratham Pratap <prathampratap@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>
Subject: [PATCH v5 1/3] dt-bindings: phy: qcom,qmp-usb3-dp: Add support for SC7280
Date:   Tue,  6 Jul 2021 18:30:11 +0530
Message-Id: <1625576413-12324-2-git-send-email-sanm@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1625576413-12324-1-git-send-email-sanm@codeaurora.org>
References: <1625576413-12324-1-git-send-email-sanm@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for SC7280 in QMP USB3 DP PHY bindings.

Signed-off-by: Sandeep Maheswaram <sanm@codeaurora.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
index 217aa6c..2019983 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
@@ -14,6 +14,7 @@ properties:
   compatible:
     enum:
       - qcom,sc7180-qmp-usb3-dp-phy
+      - qcom,sc7280-qmp-usb3-dp-phy
       - qcom,sdm845-qmp-usb3-dp-phy
       - qcom,sm8250-qmp-usb3-dp-phy
   reg:
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

