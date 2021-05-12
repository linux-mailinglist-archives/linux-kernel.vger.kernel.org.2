Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5E2B37B548
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 07:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhELFDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 01:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhELFDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 01:03:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F77C061574
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 22:01:56 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id h16so4909570pfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 May 2021 22:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wk1ENZDBAFMU6w2gyvcYa/1jSkHOtxtQDBw+BmtwlGU=;
        b=DQuzxqW4+0js9J2BcgQRPteRY2Mh2dT6DWXY2YZjeDHTZrTw8JFJ4QqK44cpSyxyox
         8UstzCJw627afRRGyogd+75XLhHvqkm3UKSOB4b2Qd4Vi8CAgmA8Voqm4UJpfjhrZSI4
         kAA6e7k+8g38KIE9UyI+wwNfGG4nR7WYoW90nWQbcFMq43/TIvEs/CPirCkwn4zcG0CA
         tI4RTGcQAv1Flpk1L7CysFE2V6OZVZESprT3Od/ivTSt4/lYRYEnjCICL9gLlJnqm3fI
         lOokthnI4lFsdewdjsE0LCy5A4MkPSSjingMZtLg3SDnZVniNVkkTL5oYegiPzUnOZkS
         W93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wk1ENZDBAFMU6w2gyvcYa/1jSkHOtxtQDBw+BmtwlGU=;
        b=NlNpEPnKV0QPcp96sOln+Zx8IbaMmy2/MN7sUTmQ4LhisYD9IKh2uwge21aMT46Dqh
         oxHe1tH1xsxdwthEPKwrYslzOzhu8AWUFCYY0NgQJ/Z3aH1Hv0XSV0kqd+9PRdTBei5F
         ckw3BXt5c947X9i7H2ymvGcGsqWH43VaYqnpfWOypbAJjfWFT44wi/PASMDF7Yb+hc9c
         fhNpWXcav4Ok92yZ8vMZqv+bpXD4H96FjBQNJ8gsS6wh0qROCE+nSubQnoDwbz85HXvB
         CGvOAgFxkE9G0/SzXwppxqhPr4T6kdFkCgUe0G2J8qctqTmjs5D8WF2Th8dHJF2rP1UM
         7L7g==
X-Gm-Message-State: AOAM532ovQyUIzVHIXZ5MDwg1hwG6nZfhwu50uDKjuZ13fT2CF8Rn5+U
        N2wQk6Xba8q6OEI+aDYz1cxz
X-Google-Smtp-Source: ABdhPJzYH/kP+PChTqQsbIn+71z7fW24n3ILff66BzQCXLH+mY2Cxl5SAzqgNhoyX/ydn5+bR41GVw==
X-Received: by 2002:a63:38d:: with SMTP id 135mr34716690pgd.285.1620795716340;
        Tue, 11 May 2021 22:01:56 -0700 (PDT)
Received: from localhost.localdomain ([103.77.37.142])
        by smtp.gmail.com with ESMTPSA id g2sm8115559pfj.218.2021.05.11.22.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 22:01:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/2] ARM: dts: qcom: sdx55-t55: Represent secure-regions as 64-bit elements
Date:   Wed, 12 May 2021 10:31:40 +0530
Message-Id: <20210512050141.43338-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The corresponding MTD code expects the regions to be of 64-bit elements.
Hence, prefix "/bits/ 64", otherwise the regions will not be parsed
correctly.

Fixes: 3263d4be5788 ("ARM: dts: qcom: sdx55: Add basic devicetree support for Thundercomm T55")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-t55.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom-sdx55-t55.dts b/arch/arm/boot/dts/qcom-sdx55-t55.dts
index ddcd53aa533d..2ffcd085904d 100644
--- a/arch/arm/boot/dts/qcom-sdx55-t55.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-t55.dts
@@ -250,7 +250,7 @@ nand@0 {
 		nand-ecc-step-size = <512>;
 		nand-bus-width = <8>;
 		/* efs2 partition is secured */
-		secure-regions = <0x500000 0xb00000>;
+		secure-regions = /bits/ 64 <0x500000 0xb00000>;
 	};
 };
 
-- 
2.25.1

