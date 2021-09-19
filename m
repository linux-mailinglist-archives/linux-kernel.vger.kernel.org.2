Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30BE1410980
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 05:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236251AbhISDM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 23:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236138AbhISDMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 23:12:50 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3346C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 20:11:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t4so8858746plo.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 20:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oPqupYvWeeM6Lwb6PK6UvVXuUOXRPg/zPprNicPOHWg=;
        b=k+g8OKL/o1sOLr3m0r/7nP/kYz+ye3X4ipmAUJIdKOOLuurPPY78Lr0dn+Sai4L9bH
         PbpM+GfvQzOYWEgr0sZ8n0OOphksRDWQqXDjaHNJDuFTfWh5TgqfBwV5J5oU08oIsqvS
         KMT5GZoie47r/pkp6bB085e9bkbIfYoHyMOjGUfLSPHL73kENnwcGsyW9LcQneFDinKN
         VoYuanWmaFiBj3kruzvlC4TDtPZyP51G4lRlYCKorowpL7vuP1RPgosks5TX0QYnG0Mw
         kNQqh6wyNAPYRHGNoNj/osejns0r2HpMdVZE6IE3MHd2KnPNRwUekd3ReiZXGNBBzXTc
         U9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oPqupYvWeeM6Lwb6PK6UvVXuUOXRPg/zPprNicPOHWg=;
        b=ukm4p6Ws45Kkbg3zvtlnQoZE4cq/HA+ObsTLk1P7nQ3CqQf3YKXYDJgW46FW2TB3ak
         kLG1OTDuDja9Fb3EjferflkZyCDSbW6QLolSnCJM+TNXcUHixaA0RCSqiRyIwT1SZzos
         133lFP5aYOh40UknNmbxIuFkor6HPQL6ud5sNeXXtT7s8N5TMXs+aIyVLO3KiypPOvnf
         4osH7tNAW+QupsHdrMArNvd4s67OhF8UyffiH8f2FvUAXxpyGxbab/+ibovhKRnzjhPJ
         ivf1d+KVlAeMzx948mZ8b0a8DIQzL+2fHfcC8eij7+PiVNoTduB2lbMbGS34T+VpclsD
         UmHA==
X-Gm-Message-State: AOAM530D/UtGxD5+U6/QBOQdh/GviYs3O/os2VhViLQQfR5wRt9SAK5C
        vwz3gvoOi7tfF5gRtiHRdAkHOTuyHdZWjA==
X-Google-Smtp-Source: ABdhPJwJQkcDr6YFBErGRS8giww3miLjQuT0rU6PoonKewdgt+yaVE7VYJp/AbGkxrglgV0nx2IrVg==
X-Received: by 2002:a17:902:7fc6:b0:13c:a855:6b76 with SMTP id t6-20020a1709027fc600b0013ca8556b76mr12851817plb.61.1632021085507;
        Sat, 18 Sep 2021 20:11:25 -0700 (PDT)
Received: from localhost.localdomain (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id 132sm10224931pfy.190.2021.09.18.20.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 20:11:25 -0700 (PDT)
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/2] phy: qcom-qusb2: Add compatible for QCM2290
Date:   Sun, 19 Sep 2021 11:11:10 +0800
Message-Id: <20210919031110.25064-3-shawn.guo@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210919031110.25064-1-shawn.guo@linaro.org>
References: <20210919031110.25064-1-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible for QCM2290 QUSB2 device which reuses SM6115
configuration.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index 3c1d3b71c825..ae063a8b3e28 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -913,6 +913,9 @@ static const struct of_device_id qusb2_phy_of_match_table[] = {
 	}, {
 		.compatible	= "qcom,msm8998-qusb2-phy",
 		.data		= &msm8998_phy_cfg,
+	}, {
+		.compatible	= "qcom,qcm2290-qusb2-phy",
+		.data		= &sm6115_phy_cfg,
 	}, {
 		.compatible	= "qcom,sdm660-qusb2-phy",
 		.data		= &sdm660_phy_cfg,
-- 
2.17.1

