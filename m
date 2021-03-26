Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3840934AAB2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 15:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhCZO7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 10:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhCZO6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 10:58:52 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BE4C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:58:52 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id r20so7740896ljk.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 07:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=py+qMxCtB0tXumIyMaImIWCtQAbDaCSrR1VHRXcWfkQ=;
        b=piz+EhCdGgs+W4DM3BI/Pi3mRABk97mFyQhFgwGFbdvF9IIxDetQLG3lOw8pZfoIXE
         wIe06Oxdis5Nais2txoCu4kq+ga8hqEOw5wxJJ1Wt2hN8caFUSUrdQZ1kEzW2bNkiYDC
         z6pAjINg87Im+W6qUA6xHJJOO47Vttyz5b+sIq3GVjbswLEvDZB2EQQkdOvfmoPwmj1g
         3xZT22k3oQCUeR7rtuxYGkcdqGSFMviCY34KoZXE6KZBCdB7FeIkS6YLR/2o7SgkU4PC
         uJsQBdWU+yCxZW87S4tLGnKnlbjmhjkCT7H/6aL9XyO9+SOruvtM0yTDfrvS8GShgTE3
         vKwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=py+qMxCtB0tXumIyMaImIWCtQAbDaCSrR1VHRXcWfkQ=;
        b=n99/xRveI34oK+coOX3SkgIlGgDyAfdFO7O3P7kX3/ebeV+aAIks2h6fmZEvAk1x5A
         gIwZsDamHW7S3qRYp3PTVrHezvhZmUaAmRAbrQRB7VKBB4WpwNOeP63/5NjhvEI7lypC
         YT9ATYXGULoLMWOWa9BIG2Fic6BuuO5L/dCeNDAWa2CxI4kJGXkSHgtU2YalXrRVsr1L
         bA88CBCE7+k3dM6B1+SR826QjMJg+oAzc6FVf2HIb4kAbIjAFKEFVSoA1ygCr80dijHv
         W1lTdrtUYEn5krCgxNCvrtTFqmE/xJ4gRQXThHWYvMFeX0S2BP4XYfEB+BHnUJA3ddls
         /wnQ==
X-Gm-Message-State: AOAM530w5DC1fVCoyVPSj00HBlapxHlPyFR5ILM/mZcC8wl7V2KK5UB8
        mZmqrkn/e4JtTEpRcL5gIayfHg==
X-Google-Smtp-Source: ABdhPJxTF6yb7fhM87ddnw9AISQEpIwe0//jTtPtigKlnVyJT45kkcVBneq4DQ8QOGXTUfIaEkK6SA==
X-Received: by 2002:a2e:3206:: with SMTP id y6mr8972663ljy.208.1616770730696;
        Fri, 26 Mar 2021 07:58:50 -0700 (PDT)
Received: from PackardBell ([82.160.139.10])
        by smtp.googlemail.com with ESMTPSA id k2sm893382lfm.174.2021.03.26.07.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 07:58:50 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id b8e0cdc9;
        Fri, 26 Mar 2021 14:58:48 +0000 (UTC)
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Bartosz Dudziak <bartosz.dudziak@snejp.pl>
Subject: [PATCH 1/5] dt-bindings: clock: qcom: Add MSM8226 GCC clock bindings
Date:   Fri, 26 Mar 2021 15:58:12 +0100
Message-Id: <20210326145816.9758-2-bartosz.dudziak@snejp.pl>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326145816.9758-1-bartosz.dudziak@snejp.pl>
References: <20210326145816.9758-1-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible device strings and the include files for the MSM8226 GCC.
Also add missing includes for MSM8916 and MSM8960 SoCs.

Signed-off-by: Bartosz Dudziak <bartosz.dudziak@snejp.pl>
---
 .../devicetree/bindings/clock/qcom,gcc.yaml         | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
index ee0467fb5e..1f609b40c2 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
@@ -22,12 +22,16 @@ description: |
   - dt-bindings/reset/qcom,gcc-ipq6018.h
   - dt-bindings/clock/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
   - dt-bindings/reset/qcom,gcc-ipq806x.h (qcom,gcc-ipq8064)
-  - dt-bindings/clock/qcom,gcc-msm8939.h
-  - dt-bindings/reset/qcom,gcc-msm8939.h
   - dt-bindings/clock/qcom,gcc-msm8660.h
   - dt-bindings/reset/qcom,gcc-msm8660.h
-  - dt-bindings/clock/qcom,gcc-msm8974.h
-  - dt-bindings/reset/qcom,gcc-msm8974.h
+  - dt-bindings/clock/qcom,gcc-msm8916.h
+  - dt-bindings/reset/qcom,gcc-msm8916.h
+  - dt-bindings/clock/qcom,gcc-msm8939.h
+  - dt-bindings/reset/qcom,gcc-msm8939.h
+  - dt-bindings/clock/qcom,gcc-msm8960.h
+  - dt-bindings/reset/qcom,gcc-msm8960.h
+  - dt-bindings/clock/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
+  - dt-bindings/reset/qcom,gcc-msm8974.h (qcom,gcc-msm8226 and qcom,gcc-msm8974)
   - dt-bindings/clock/qcom,gcc-msm8994.h
   - dt-bindings/clock/qcom,gcc-mdm9615.h
   - dt-bindings/reset/qcom,gcc-mdm9615.h
@@ -41,6 +45,7 @@ properties:
       - qcom,gcc-ipq4019
       - qcom,gcc-ipq6018
       - qcom,gcc-ipq8064
+      - qcom,gcc-msm8226
       - qcom,gcc-msm8660
       - qcom,gcc-msm8916
       - qcom,gcc-msm8939
-- 
2.25.1

