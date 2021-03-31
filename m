Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475D635031C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 17:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236290AbhCaPRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 11:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbhCaPQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 11:16:29 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E783FC061760
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 08:16:28 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id v15so29679936lfq.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 08:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rrCCca4g8x3nSpZ4k9xYBMQsVnD9YUdQsDgivHbmdns=;
        b=CeJkGk3W5vagdsyssBZvDDLgevgkwXNxgr3atdKjoJiGqgD6onsV7/AcYlBOMgk6GQ
         8tpZhonpDdXjaM1Jifo5WYoDCp2J+ewNdzvHjHz3Me/3IG3WENUoDL0syMNC5N4bIYQN
         CC2X7QzD8vY6yip8k9DyN5msq+wkqde2o+paBW0QtmB6olURGz6n4F4eo4ju4DvTLD6e
         hqzcimm8TAn65UCV1fF2SriZR4jkLV/v8aYz5QE4hh64srsW5o4o7sku2cyGNX3cDPg2
         knlOC+V3NqZ0hk3UR7Wryc/j2fMBl8AxGKQXw7d1XV6YljpFSQV2hjKyIyoeSF1kctw+
         ojUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rrCCca4g8x3nSpZ4k9xYBMQsVnD9YUdQsDgivHbmdns=;
        b=BgzrojdJwXXQzj3xmjnU9rwPRMeHkUdeN6OZbq0loZdUOV/3EIfl8QF1BL/KrIFtpN
         kmTfPzVFb8SnDJ5qBDEOEtRROclMubKIfnIjRDC05aBia5EJMcKrauTl8MsD2H3maoOH
         L7v4VTNJ6bEo9uPK4FJ3P0yUiNvce459r2PE3+B19wEA8c7F9cRwswGrR33MTxc/Ku2b
         itqTGLGKpm0Md1m+hmpQa6cwS4CwxmCi1EcNKwYicHu2+rxfVC3QLEwXQzIdh0Wv+4fP
         1j6kbpYrTlY9VBB1Rhq34mprkycRDKESFxQF9Hj4NlfgLilBiUKpfThY8doQYoJg5b3Q
         9PYQ==
X-Gm-Message-State: AOAM531zCGUqLjSXsffEmlV4HIgi1w3M8DxIZW5GjuJrHqOT5f7QTRnk
        2NeYRXuuKs7KEZybKt/9eW6Zksp4F2XQsw==
X-Google-Smtp-Source: ABdhPJxAnhTv0V89iTQPLu9J24zSvCIOlk3YbSgDwax4n/Hbknt34b9xUhDZNc7Efqpw6HkGXKP8HQ==
X-Received: by 2002:ac2:599c:: with SMTP id w28mr2492177lfn.381.1617203787139;
        Wed, 31 Mar 2021 08:16:27 -0700 (PDT)
Received: from eriador.lan ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t201sm266738lff.70.2021.03.31.08.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 08:16:26 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Manu Gautam <mgautam@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v6 2/7] dt-bindings: phy: qcom,qmp-usb3-dp: Add support for SM8250
Date:   Wed, 31 Mar 2021 18:16:09 +0300
Message-Id: <20210331151614.3810197-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210331151614.3810197-1-dmitry.baryshkov@linaro.org>
References: <20210331151614.3810197-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for SM8250 in QMP USB3 DP PHY bindings.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
index 62c0179d1765..217aa6c91893 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
@@ -15,6 +15,7 @@ properties:
     enum:
       - qcom,sc7180-qmp-usb3-dp-phy
       - qcom,sdm845-qmp-usb3-dp-phy
+      - qcom,sm8250-qmp-usb3-dp-phy
   reg:
     items:
       - description: Address and length of PHY's USB serdes block.
-- 
2.30.2

