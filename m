Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781013F7F21
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 01:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234664AbhHYXmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 19:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbhHYXmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 19:42:12 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755D4C061796
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 16:41:25 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 6so1778303oiy.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 16:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Qbn6rk6sj87tSTKdnnYPYuRTniKiqOezdw+dFrRZCg=;
        b=Vm4G3uftCW/T6dCqbkA7vokLZMlA9pX5RbXLwF33YGHY9/epjZ2UZRq5k7X3sXH2RQ
         4+j+0+P2XLOlMPSqqzjNNRFMB/sIERKlX72b+Eeou62AjSWYpl4HwXsgkShSu/ocFCP0
         +fTSaHJTwWznLYOaQMKHxMmyAQobljjla/3hbvDh73lP2ApfNpf5ph3Ie/ucWtBwQ2S0
         NbkVeJQAvKsCUMKHe1xLa8liMwqfwWgkzF68oUGavZjOxTIfdwFnnqEC1VggZpcwu56V
         1feLQBw5xIKHNORbnU9/8AMfk3UdSZUHrO+707Wz1k9Vp00gj+Wf+qCj312VNn0EXzzh
         BmZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Qbn6rk6sj87tSTKdnnYPYuRTniKiqOezdw+dFrRZCg=;
        b=E9S587jZZo3bE87Zhssypu8putNK/ddli03kG3etEEVdSUC4d3oPOVZhCWT0/353rB
         hufCSFjXLehPR9mnelsgLtva1kWBKE2W1EsjvhRdwTpYaP2pXj/aDjGF/x9auYqGTwMD
         19mMpbTATtO8bFMb58DFcjE1+m+6axiSwuxqEFIMJXzWBet4nsgj5FWKB9ldfRhUWoD0
         rXZ43BaAOpfIwePJsyAgM/DTq1k1EqxSZ0UFFN61oO41Ej0wYWV/M1uZI1Wf1KKqWLsr
         KYNuVV0Ttwst0d5AuzkPx1FVrNDkul+R48yiTwQH2MJqUuizEX0dg/G1LGIEQFlS5UXn
         l30w==
X-Gm-Message-State: AOAM530XDh/O0TIURCu0b8b4KCLBS6NZA2DmcY30Hd9pr/Mn4UiPX0tK
        7qbHFwn3/QYXG391O8dypmHFOg==
X-Google-Smtp-Source: ABdhPJyFkHXrqo/1gbNpklgbgydgMUEHj+c+RHwxsH9rWtBe4qTlWfvRrH5wOgrgwP5OTelW+GQ8rw==
X-Received: by 2002:a05:6808:2ca:: with SMTP id a10mr427499oid.44.1629934884855;
        Wed, 25 Aug 2021 16:41:24 -0700 (PDT)
Received: from localhost.localdomain (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id g10sm267136oof.37.2021.08.25.16.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:41:24 -0700 (PDT)
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
Subject: [PATCH v2 4/5] dt-bindings: msm/dp: Add SC8180x compatibles
Date:   Wed, 25 Aug 2021 16:42:32 -0700
Message-Id: <20210825234233.1721068-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210825234233.1721068-1-bjorn.andersson@linaro.org>
References: <20210825234233.1721068-1-bjorn.andersson@linaro.org>
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

Changes since v1:
- Picked up Stephen's R-b

 .../devicetree/bindings/display/msm/dp-controller.yaml          | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/dp-controller.yaml b/Documentation/devicetree/bindings/display/msm/dp-controller.yaml
index f915dc080cbc..b36d74c1da7c 100644
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

