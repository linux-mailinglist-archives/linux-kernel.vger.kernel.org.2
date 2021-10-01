Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02B0F41F359
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355423AbhJARoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 13:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhJARoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 13:44:00 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224E6C06177D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 10:42:16 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id x124so12315966oix.9
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 10:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1XfRi83lxmTXo1mPygdX7KTNkhcpA1zU3QO1+ROpzaM=;
        b=BjV/LAd5fMomk9CbkbZKRN1uPjTa7v3BRm90A2QbqxBtlPl4Ni9iDnE+c2Oqfgt8Y5
         hAkvSt/rafwEPaawca5eo3p/IGZH6fiDeTm26ytEV3Zw+X1q2g50HOoldTXNwiRLnqy1
         cGXIM8tSivoVPDrAPTJIiA1e6dttoq+LwXDZVX4pnxCX7nr9C2x97M/iQa+mWAMMzh/j
         gy+rxYYWOohi+7TL/Un3OYYdBmWZ9MGi2hD7uZOvWrcATewcmSq+4gDL7jhoLAg49ddH
         g5YG+b31MtqoI6ip7vhMTtf/PjdhwVfpIsy6MX+IVHU/SCAA1QKmXi3SHoB2DUKjGGPe
         3v/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1XfRi83lxmTXo1mPygdX7KTNkhcpA1zU3QO1+ROpzaM=;
        b=6yFMZX6aWp0RWEzdWk4KryWSoo7gqf6yCCnF2W59Q0743XP8JbPWLmw3YeMT895glO
         3OJDnDX8i8lPzxyl0rXp1uj/oRaQW9vTRuP0hacAW6NyvlkEwgRwJli5Tt8QrSwcYXvf
         Fr4UrfyjnaSyJo+e0TP7nOPBwvqGG0uZugqrT36M03wW7JytCU1TDsVeVZJshJcErrud
         h5S5BKae0HT83mbINca+pVXQOotdpd6Tx3m090OZB9vkXtLk07NIbWvoil2jcCAElET+
         OWWlQOjCCOeUqqWS4SOXETCA0Moi9vtwr2LF66U4eVQtrymDO9v96cpnIiJDreaj4NWs
         EZCA==
X-Gm-Message-State: AOAM530f1szQ1SI3D6/c07ysBiJtH08OWxSnxAb6VjpNNRxccO/p4wip
        8CgdzXGS7TkgbMF+WZrVHnxcfA==
X-Google-Smtp-Source: ABdhPJyuU/BD/AoGnySYTk7e7I237mOB/XEoTAJAh3ya/qX1KRqJk7Fv3baULTt7qZ0GjaMfZmcstQ==
X-Received: by 2002:a54:410b:: with SMTP id l11mr4806256oic.74.1633110135506;
        Fri, 01 Oct 2021 10:42:15 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id u15sm1369264oon.35.2021.10.01.10.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 10:42:15 -0700 (PDT)
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
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v3 1/5] dt-bindings: msm/dp: Change reg definition
Date:   Fri,  1 Oct 2021 10:43:56 -0700
Message-Id: <20211001174400.981707-2-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211001174400.981707-1-bjorn.andersson@linaro.org>
References: <20211001174400.981707-1-bjorn.andersson@linaro.org>
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

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- None

 .../bindings/display/msm/dp-controller.yaml         | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index d89b3c510c27..6bb424c21340 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -19,7 +19,12 @@ properties:
       - qcom,sc7180-dp
 
   reg:
-    maxItems: 1
+    items:
+      - description: ahb register block
+      - description: aux register block
+      - description: link register block
+      - description: p0 register block
+      - description: p1 register block
 
   interrupts:
     maxItems: 1
@@ -99,7 +104,11 @@ examples:
 
     displayport-controller@ae90000 {
         compatible = "qcom,sc7180-dp";
-        reg = <0xae90000 0x1400>;
+        reg = <0xae90000 0x200>,
+              <0xae90200 0x200>,
+              <0xae90400 0xc00>,
+              <0xae91000 0x400>,
+              <0xae91400 0x400>;
         interrupt-parent = <&mdss>;
         interrupts = <12>;
         clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
-- 
2.29.2

