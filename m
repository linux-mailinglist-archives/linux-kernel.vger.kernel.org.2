Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646AD3FAEF9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 00:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236041AbhH2WjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 18:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhH2WjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 18:39:10 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E9BC061575;
        Sun, 29 Aug 2021 15:38:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u16so19763181wrn.5;
        Sun, 29 Aug 2021 15:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wq6/ZrtqH+QZ2gRsIuLXWV+BbHV3zTwyTk6Ia2hzqYY=;
        b=OBAFCHlxc+1N8gGvXJWBNYE8kZ2HgUGGgB36mkptaxBPm9oOUh84RaGHiCnJm9F0CK
         uO/sMJzS9egK6o11RW1K50G1g4yh5iZgO6IdsRSltsSJBaG1YQwd6xH3uHnDwU5YAL0t
         y0K/kL6/xNw4eqkywwdzOg8FQcrvA9UkuZNGyMFtdk3kjfMGyfiHF9NCYY2Hhu0OB27p
         dB1Gjgbl8LvQ8kqcCLKNzvnsilExd9ybDDZr2kJQqJEhB4zVeWQxjx874H0QIPa5qdyw
         VDqSt+V1pTbnfb3BPruhi8Ali6C6H8w08TzCYd6d6WCLswUMKXJRsZqxSTSqpBAqfhes
         c4xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wq6/ZrtqH+QZ2gRsIuLXWV+BbHV3zTwyTk6Ia2hzqYY=;
        b=a1PoKWCgS89+0Loep5pALL88luSrCOEk4kPTMpz68MFukqcRUIUybGu4CE69Y+6G/q
         pJopXFZGmNzQQe8QvcSVmTsQ6rd3VZy4OdYz/xRbdSPbLKZ4lpzWtwUEts71BxNHIfDI
         Slqeiv0l9aFJ73ZYfN0mzP8UG87p7UHaJIyGyWRxS2shq56zfEXRU1s1xHGdodiBH8sV
         i/BHv3b16dLahclJQj3WRqmlH1GSZDsvW8HBtqxvZ8brkyFvxxv0PL21kZAA2pOmj61Q
         SVT7XyIDQS7NB43q/La6X7aOC012JLs9r9jPr8I/DgbiWrJFN1/cgPlyA4kRuG8i5/Yc
         agZw==
X-Gm-Message-State: AOAM53188/2mnMSlihujXZBpleA64P5oDJn0n8ASsm+w10nSvHbHihGX
        bP82kpSKRcDhxTJOtui/PoEnFTXmYhk=
X-Google-Smtp-Source: ABdhPJyN/7dlwvhL9vp6KsNI2Fuv+7BR6LDwEYekoouysCAWK05jJo7VHFoZBNuE/hxYkej0DGPckA==
X-Received: by 2002:a5d:6785:: with SMTP id v5mr22492455wru.261.1630276696036;
        Sun, 29 Aug 2021 15:38:16 -0700 (PDT)
Received: from oci-gb-a1.vcn08061408.oraclevcn.com ([2603:c020:c001:7eff:7c7:9b76:193f:d476])
        by smtp.googlemail.com with ESMTPSA id s7sm13603878wra.75.2021.08.29.15.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 15:38:15 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] ARM: dts: NSP: Add bcm958623hr board name to dts
Date:   Sun, 29 Aug 2021 22:37:47 +0000
Message-Id: <20210829223752.2748091-1-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This board was previously added to
Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
however the dts file was not updated to reflect this change. This patch
corrects bcm958623hr.dts by adding the board name to the compatible.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm958623hr.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm958623hr.dts b/arch/arm/boot/dts/bcm958623hr.dts
index 80556882951f..c06871915a1c 100644
--- a/arch/arm/boot/dts/bcm958623hr.dts
+++ b/arch/arm/boot/dts/bcm958623hr.dts
@@ -37,7 +37,7 @@
 
 / {
 	model = "NorthStar Plus SVK (BCM958623HR)";
-	compatible = "brcm,bcm58623", "brcm,nsp";
+	compatible = "brcm,bcm958623hr", "brcm,bcm58623", "brcm,nsp";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
-- 
2.27.0

