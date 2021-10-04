Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F51420AFD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhJDMlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhJDMlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:41:21 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81FAC061749
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 05:39:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id me5-20020a17090b17c500b0019af76b7bb4so4385338pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 05:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5PG0hNVQuZSE12+d9FlPhmW1OMlHH2PE3/HV0fc7js=;
        b=zCa4dJaDImMk57hpwlY9GYF+yCSBgkEg0Nfxc2802Dc7xtNm9hz7ulY7yZThQqqME1
         Bnt3L0bltsch7KTWHr6gTC/KLnF3cu/km6Z+KrK5k4LUoI394XgsRCGDY0dJ5N436Xkv
         8Lhc2OzBnQpn0ongyLpmY0L+L+c+eqQ+XCWBL0j+dZzjTrvcIbizkm4iqjgFolrTd2nY
         xpSuDFkEhZGGLjImKUxaMIhxaJO2TvR2pawcxX7xSV18ysxJOfv8jcrG2rJ9K6XZdjKs
         o8R8e/OD3bJu+65CFky6liCc48GBwVIklaM3DEgm29tPPxWNBPpoHRNwL2vOphVbCBLn
         Qv7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=O5PG0hNVQuZSE12+d9FlPhmW1OMlHH2PE3/HV0fc7js=;
        b=xWV0Tw57ZiYMqCrCvfC1oDNU730+lNeqjPv0k9Z3wryX4Q/o4AmDEBWxvk/YK/Cnan
         27K/w/uEkZOYXhiC/aPMXmQqhUJ9OhBty7JZnqkKcW8IksJ8H3HMNRN/ULzzrz0+gQAJ
         UfIm9Q5Eq+S/AJ8WGCbIbu63it4aS322vi3Bwqyd32VlRfcPXaQ5l9aTCbNDOMCq+/67
         us4ca1YDazlS5XgrYU27JIHiNajkxQUhAqlzH18aFiOh1IZswSL4eWDMF/PSESM/W651
         qPzcANtavu4mmd2Pf+9wHFtS/Nw8K5LpA+jW8M44YTGhWnC1pRpadR0nFsy/x3pb8U46
         hbsw==
X-Gm-Message-State: AOAM530bgkoLnqdJ7butINUwiq7mmvaFXsgNOJfZMA5NrfAvsuoYR/Gc
        kbTp44yVYefytxr6WReYYtgS
X-Google-Smtp-Source: ABdhPJyR0xmWPPEnJxvOpWnT5V1wOjU5KDQKOy3+IjK6Qes2PM2DjbcIn94b5dR4UkHCgqvwfXJaMw==
X-Received: by 2002:a17:902:6545:b0:13e:51ef:3ba with SMTP id d5-20020a170902654500b0013e51ef03bamr23252391pln.61.1633351172153;
        Mon, 04 Oct 2021 05:39:32 -0700 (PDT)
Received: from localhost.localdomain ([120.138.13.170])
        by smtp.gmail.com with ESMTPSA id b15sm14103036pgs.13.2021.10.04.05.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 05:39:31 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     miquel.raynal@bootlin.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] MAINTAINERS: Add entry for Qualcomm NAND controller driver
Date:   Mon,  4 Oct 2021 18:09:26 +0530
Message-Id: <20211004123926.53462-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since I maintain the dt-binding for this controller, I'm stepping
forward to maintain the driver also.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2c9165e4e816..8cfd8ae9e69e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15580,6 +15580,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/regulator/vqmmc-ipq4019-regulator.yaml
 F:	drivers/regulator/vqmmc-ipq4019-regulator.c
 
+QUALCOMM NAND CONTROLLER DRIVER
+M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+L:	linux-mtd@lists.infradead.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
+F:	drivers/mtd/nand/raw/qcom_nandc.c
+
 QUALCOMM RMNET DRIVER
 M:	Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
 M:	Sean Tranchetti <stranche@codeaurora.org>
-- 
2.25.1

