Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 880FE42344E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 01:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhJEXN4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 19:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbhJEXNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 19:13:39 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBB6C061762
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 16:11:48 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 77-20020a9d0ed3000000b00546e10e6699so970416otj.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 16:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oCnAkB79mR5AIU388UdqiAr4F0EbajvP3UTjYzPVMRg=;
        b=v4yz3RLfL3PsAlLFQWT3nSDM2WuRh8pc8/8ovsW3DrLwQatbzWkmtHeLUZf9130mTV
         QH1RLcP6pbO3a5D1VZ6kWWtqkssfSL/OMjpDo9rWB/42fjKcBpLlUFlJUds18dmfSnoV
         bxC0w2r1T6iOAZWH7pRq1VSgsRkKLKNhmMj/Arvu2dNdenLGzI9kUUhlSwr8cLfQUx1S
         4nzeIpkLy3u0NT2Fv0h65beNwUirlxLfIBRkH0LjeaN63BQBxdIAzbvbA0YSBRYsA6CA
         jx7ulieBRmhpfQA7rkDiUc2bRNCLANdfUwb03gfPgHKmLkO4Yn7atmNCnwpZfIhPTcwI
         f1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCnAkB79mR5AIU388UdqiAr4F0EbajvP3UTjYzPVMRg=;
        b=Rdmm+gCFSXWgVMpv9I5upY5Iv9a/IhP3REoP8uU35VPud0HKO81kqNu0dU1euf/hr1
         1jUiBC2+FhxBmOQg7Bt7DEt/cyeQ8igojEp6qCxizHQm1H29HNYog80nxqX+ojzF2LkL
         5F7Fd2J9D1G+FTdN7O+IY85Jt+tZ3iAv0PfNEC6Pn0Vj1rCXMvLuGep+RbM7218Ds/Cs
         7BCibm7nGLxQWvQK8pYwe2tDWduDwYUmH5NDWLuSHFyVNExMuyJJItpSF6qfCX3ARXjt
         97YDBPPIKP4IjGJ7UFuhsDnbiPAuy7kpU4e78RJNCyfPS7cqpc47SZE1D5mP2PmCOx7b
         Mruw==
X-Gm-Message-State: AOAM530oVjuKqyRcaFnAfyRw/sRONRWz2g51WtMgPhlMJes21Hnb/xqU
        AZV8fIVGzVfg8FxyMCNEr5RBjw==
X-Google-Smtp-Source: ABdhPJwJ0djzrwEgyE1w+FdTMnmE5IMZWexC0nsKUKi2b/dAc+DsZ4kwaVhiurz4/q6FqF0BZBuZWA==
X-Received: by 2002:a9d:1402:: with SMTP id h2mr16374492oth.3.1633475508065;
        Tue, 05 Oct 2021 16:11:48 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id v9sm1665141oth.62.2021.10.05.16.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 16:11:47 -0700 (PDT)
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
Subject: [PATCH v4 6/7] dt-bindings: msm/dp: Add SC8180x compatibles
Date:   Tue,  5 Oct 2021 16:13:22 -0700
Message-Id: <20211005231323.2663520-7-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211005231323.2663520-1-bjorn.andersson@linaro.org>
References: <20211005231323.2663520-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SC8180x has 2 DP controllers and 1 eDP controller, add
compatibles for these to the msm/dp binding.

Reviewed-by: Abhinav Kumar <abhinavk@codeaurora.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v3:
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

