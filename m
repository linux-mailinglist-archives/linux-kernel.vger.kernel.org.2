Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CD53D1BF3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230475AbhGVCDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhGVCDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:03:36 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AADEC061757
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:44:12 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id j1-20020a0568302701b02904d1f8b9db81so3971026otu.12
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 19:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MS6mraKNigkKOXB/hgjulPSCM2yRlqN2uoBBxxKVwTA=;
        b=z5cEQ5HwZy9cTyIhfxc5PZgxuUQae88VaPXcolle0LA4mxwW5kYraR3GpN/EW8J8Eh
         IOBlIeS4wRe3w+fTRbu14xlJ38Jo9YmjMYy+tZgMisWvQ/PfPsJjCwBaxTL+aaq3xUou
         h5680hBeio40Oms+w7uNvWOmD7RaNtBVnRMfdlp/tWgjsmEUDDTafy9bytnngOF+Yxja
         gjw6vax6X2GZqox1hP0bffCa6tt2FTU/2ZvG+nYhrjpIdUGL2HKfUdmZoAl9gI7fOXiu
         fbXgs6WyE8lr+COg/7PCUV7ZMYKJtrlnWdPYm+ygMbBzGyXQwicPRjzNHeoKODRLNJWw
         MyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MS6mraKNigkKOXB/hgjulPSCM2yRlqN2uoBBxxKVwTA=;
        b=thOYccFMLK6GuEHb0YRK8269syepYaWhw7lhOT7WwmxPJnPQaDx//7ZazI4u2m8MB/
         EGigX8ptLzf+5HfqfzpBbpqr5MZ2POfbzNH1ebT+am2ZhYj1NXKDzai7AgIciiaQZgE4
         vWoTV9yHSrI44yMEzN3ddYnwKMIQSpiSAZD8p731ReXPXulBnzp49y4JlIfwF3CRgBjR
         +ihXXy5IFVlWQ2N7fDpVEuTTkgfANUmsrbBK0+Pt2ZXV3g0aNYybrDg1qh1h+Ains3Ko
         bS74ce4TW4E4wCJaeu0LlAifJxLyakwP2RV2BbPuDPi9aT6grpd293P2Kk6vHSO0SEBG
         hnkg==
X-Gm-Message-State: AOAM531AeR6ARGS6dR+u/59j20jgxoWtqNaP4FaY1T5ryfTTls9PX94l
        6BRwFWmC5aW3VnKnHB+DY1JRTg==
X-Google-Smtp-Source: ABdhPJwxJKJoRHACBlCRhC1wTHOjaagQ66oQDTdk/KvD7hHQHiuM5LOfacjgqpVgp2acBRiGESoHAQ==
X-Received: by 2002:a9d:7dcf:: with SMTP id k15mr21901596otn.201.1626921851922;
        Wed, 21 Jul 2021 19:44:11 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id u18sm5346519oif.9.2021.07.21.19.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 19:44:11 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>
Cc:     Kuogee Hsieh <khsieh@codeaurora.org>,
        Tanmay Shah <tanmay@codeaurora.org>,
        Chandan Uddaraju <chandanu@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dt-bindings: msm/dp: Change reg definition
Date:   Wed, 21 Jul 2021 19:42:23 -0700
Message-Id: <20210722024227.3313096-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210722024227.3313096-1-bjorn.andersson@linaro.org>
References: <20210722024227.3313096-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

reg was defined as one region covering the entire DP block, but the
memory map is actually split in 4 regions and obviously the size of
these regions differs between platforms.

Switch the reg to require that all four regions are specified instead.
It is expected that the implementation will handle existing DTBs, even
though the schema defines the new layout.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 .../bindings/display/msm/dp-controller.yaml           | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 64d8d9e5e47a..a6e41be038fc 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -19,7 +19,11 @@ properties:
       - qcom,sc7180-dp
 
   reg:
-    maxItems: 1
+    items:
+      - description: ahb register block
+      - description: aux register block
+      - description: link register block
+      - description: p0 register block
 
   interrupts:
     maxItems: 1
@@ -100,7 +104,10 @@ examples:
 
     displayport-controller@ae90000 {
         compatible = "qcom,sc7180-dp";
-        reg = <0xae90000 0x1400>;
+        reg = <0xae90000 0x200>,
+              <0xae90200 0x200>,
+              <0xae90400 0xc00>,
+              <0xae91000 0x400>;
         interrupt-parent = <&mdss>;
         interrupts = <12>;
         clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
-- 
2.29.2

