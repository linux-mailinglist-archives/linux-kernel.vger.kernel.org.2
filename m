Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B42392F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 15:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbhE0NSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 09:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236405AbhE0NS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 09:18:29 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF62C061763;
        Thu, 27 May 2021 06:16:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id s22so7961390ejv.12;
        Thu, 27 May 2021 06:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S3aHrQGf4p/xVmD0XaAfsGhbFbf6GNiuGUtg3eCRd38=;
        b=k5xrEDxj0gWeyBttAbhARWTKhiJLjrhEsqtg0tqVCqyE1iu/C4cIFNGZQTUdfGSNP1
         OyetBFAHOZg51L+UvkPFPZEyPVNj6WQGdIijLNJg96YWwlFTkZ/HlDBTWuX9mLtC0WAc
         RPsVmZmkK63gx2kAhJJjw42tw8/EZXmz0QHFx1RoDPaLFKaBFENXn40wiQ1ch0gtXa/H
         I63FpIfAAvcwb8hN4/GvCoXFAIj5yxUefaxEUzUgKHPC+BkCMw8FrbrBHIWxQcJN+971
         S8hYc7/VuvadNwohY74U0sZXb4ktBmLJq4n+OQuLsB+rH4Q5q5n/7TX7T7clURmTXuJU
         z1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S3aHrQGf4p/xVmD0XaAfsGhbFbf6GNiuGUtg3eCRd38=;
        b=tjmwPlcAkbTM1m72dq+Rae/dWnj28PTBOzL1y6+2EEtaKsNp5FfndZqWE6El0KYRCy
         qmvxe7t7K4DpIYw/SE24xCaIf1g3KCnY00a5VIll4/dnEn/I6X6USijroqS8Qni7Dk25
         /O1ytZA2gKJsSCPH5wb0CFSkkr1LIgLuNh5ZVnjPbv7nz3VGPxpnFvvwVTRTuLkqOMpm
         WpC0/UI0ol2JKj/UTlx/7lbU7jqu3UERMbZztaW1YWoK78LTWH6a353FQlKKbDtj8a0g
         kwGgl6P13RN/TKdw4TELnoGwyBNqbnh1/jxyuUlvZ9JvSfaaq72AKIrayoApwOFfqn/i
         +CcQ==
X-Gm-Message-State: AOAM53361E+LYvmsfGi7/ua0893DA1iMMBPtmnQTw8mYwlZnfIQNdKAB
        SjdjAFlvcDrsg16ORq0Jmqg=
X-Google-Smtp-Source: ABdhPJwoP+XikdfWtRTxbQfXgf0nNJBGWOQ24EoA5v5gK2F7Zz6+w2udwJoS57XOVcmVg4YLguYnBQ==
X-Received: by 2002:a17:906:dfc1:: with SMTP id jt1mr3753762ejc.473.1622121413958;
        Thu, 27 May 2021 06:16:53 -0700 (PDT)
Received: from localhost.localdomain ([188.24.140.160])
        by smtp.gmail.com with ESMTPSA id r23sm1104206edq.59.2021.05.27.06.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 06:16:53 -0700 (PDT)
From:   Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Subject: [PATCH v2 5/6] dt-bindings: clock: Add NIC and ETHERNET bindings for Actions S500 SoC
Date:   Thu, 27 May 2021 16:16:43 +0300
Message-Id: <b76ceb8849370943e675e5ea1a34a25cb513faec.1622119892.git.cristian.ciocaltea@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
References: <cover.1622119892.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing NIC and ETHERNET clock bindings constants for Actions
Semi Owl S500 SoC.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
 - Added Acked-by from Rob

 include/dt-bindings/clock/actions,s500-cmu.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/actions,s500-cmu.h b/include/dt-bindings/clock/actions,s500-cmu.h
index a250a52a6192..a237eb26accb 100644
--- a/include/dt-bindings/clock/actions,s500-cmu.h
+++ b/include/dt-bindings/clock/actions,s500-cmu.h
@@ -74,10 +74,12 @@
 #define CLK_RMII_REF		54
 #define CLK_GPIO		55
 
-/* system clock (part 2) */
+/* additional clocks */
 #define CLK_APB			56
 #define CLK_DMAC		57
+#define CLK_NIC			58
+#define CLK_ETHERNET		59
 
-#define CLK_NR_CLKS		(CLK_DMAC + 1)
+#define CLK_NR_CLKS		(CLK_ETHERNET + 1)
 
 #endif /* __DT_BINDINGS_CLOCK_S500_CMU_H */
-- 
2.31.1

