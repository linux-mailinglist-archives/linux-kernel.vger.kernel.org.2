Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6BD41F42D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 19:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355687AbhJASBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 14:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355637AbhJASBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 14:01:00 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F32C06177D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 10:59:16 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id a3so12430556oid.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nF6LW47fQKO3rk11qFL799VxY9yECSKjA1fHehWHHiY=;
        b=LfElaVRac/rd1pa8a5fX1rNze9VGWsDJnTwe0/38y7mY4Ift6Rv2p0/0MJRGrWKadO
         RI16GHNleNanYFQYIHBEVPz73wL0xknC6WgdjoR4Pmg8/yz9k5qNLI29iRn1mYCLqizx
         zmMzb4CpQ4D2Wcw4Yiraci0rPMYVNKkHVvF3RjUBElh9eCZcYZWa7uP9v31fcHe/6OwN
         0jeNLY4UahYzbGIeIJG22QvYF53997PNq8/+Ci/autUvIIHlJvDcnMy2Dz1yf1t/0Y4V
         9hrvQgfBCYp8j8YqkD5lUOS88Me/dIra4WhaQN0cIpGtpyTBCNnh6L5JGZRNRYahdRgF
         zMQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nF6LW47fQKO3rk11qFL799VxY9yECSKjA1fHehWHHiY=;
        b=X/6P/BvwIrOo9oNHLf0pntGFFlwIF6eFicX69GtP4dy7lJM1TXGafuBUXE0ON8VGw1
         96zMVhDr6IJb6uRKJXNC5s38Mlwyev3o2tHCYCwxdlTxPb6DHlzRWFL7traSoFeWr9Fg
         EKNtPZps8r2Vv1CXFBa15oPkazr79C5JlzJxKQpOBimRX94Oe8c6j5w1EKBfWwLGNj+t
         GKMSDkB9myDK/4nXPOurAKOCr4/qdiIm32iW9d1y4odJABcnJOkfvIwja++VVp9PGIe0
         vkNFRRpZM8yDSj9llC50h53UtZNGZQD2IX14b8hXtcOpSVh+05vpo5YbESBQlHABQ+BO
         VISw==
X-Gm-Message-State: AOAM533T3ep4XmUC0kNpVyycqkT6z4loR/Sq22yZGBSHSA1kWDMahEX6
        GOJnMXpohs3ZZLjKZhDauUEYww==
X-Google-Smtp-Source: ABdhPJyRflu6emTf1eQ8g5XBdIrtHKb6KHaDYwhSuzKDBHwh9NHvtDaXTcXoG03WprD/HYPocjp2nw==
X-Received: by 2002:a05:6808:b25:: with SMTP id t5mr4965587oij.58.1633111155560;
        Fri, 01 Oct 2021 10:59:15 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id w2sm1284798oof.23.2021.10.01.10.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 10:59:15 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalyan Thota <kalyan_t@codeaurora.org>,
        Kuogee Hsieh <khsieh@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] dt-bindings: msm/dp: Add SC8180x compatibles
Date:   Fri,  1 Oct 2021 11:00:57 -0700
Message-Id: <20211001180058.1021913-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211001180058.1021913-1-bjorn.andersson@linaro.org>
References: <20211001180058.1021913-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SC8180x has 2 DP controllers and 1 eDP controller, add
compatibles for these to the msm/dp binding.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- None

 .../devicetree/bindings/display/msm/dp-controller.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index 6bb424c21340..63e585f48789 100644
--- a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
+++ b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
@@ -17,6 +17,8 @@ properties:
   compatible:
     enum:
       - qcom,sc7180-dp
+      - qcom,sc8180x-dp
+      - qcom,sc8180x-edp
 
   reg:
     items:
-- 
2.29.2

