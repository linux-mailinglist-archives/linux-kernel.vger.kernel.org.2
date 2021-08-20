Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854003F2864
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235321AbhHTI0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:26:36 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:52588
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232484AbhHTI0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:26:23 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B7440407A7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629447460;
        bh=yOjRHckXfh8MDflQfjYiz4YEqE8miSPemjVb3I/vxsA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=eaYAscjuYfGn2rT3CShNkH3wtzz0qeRtYUq0xlv9w2FTfs/W22AxhjpI/Phd0g1tl
         i8uoghXCrgCRw316LBHt7RG3h1zHQRxrmu1IazzFxnnOYQI2mTCv/eHrDRhnUA2yyl
         nxHIQ8VrVqLK8nGhLatriB0N2tWobm3sPaO4vbDb3t3uMw25/fGyopE+XtkEIFw251
         TtRciM0ZfFbzvuedOET9FWmofD46dzVBselr1KH+4unOpuNIqFhXrC0EBHdTyt92tS
         HbAyOlB7XIP7WzFVSNySFBsYC6mQkN3kzg+sBYil76rJnj67boIiICvFqiwGAcKCek
         Wn9kU1MB/5koQ==
Received: by mail-ed1-f72.google.com with SMTP id k13-20020aa7c04d000000b003bf04c03fc4so4173264edo.22
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 01:17:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOjRHckXfh8MDflQfjYiz4YEqE8miSPemjVb3I/vxsA=;
        b=gYHZc4wmoSvAcolfW/P73fgsS4EwXvZwjHtsPguDf0Zwtvs/Gl2MEsUM8Khw0VGJCd
         ze4TR9oygs/apvF1Qai2DUhVzmikHGeOL34MpC5+7j4LgQc7gyDUSNEMnQ8mGLSKpOSt
         i72UQWo+wjKkshvMfkM+ms/z5qPJRS8aibj30YjtGaJR8z68dTh57rBKkZOEbarbWXub
         cm6HbKXNnoXswMWNXQ+gN70oAGsQZ7ZVvr0skEemtkBkUr0XdyK19LkMSqH2wQXDlwNZ
         BbpLwDWTYF9ZWvPykgcImA7dW5mRfH3azOwh21/g31AgRoUzLLu/UcFSL+Pq7hgwJnP2
         uqjA==
X-Gm-Message-State: AOAM533bUsDpIBlFK5wJoww+AyG6pLAxA4elMKCm5kaPxTQC9aqeTI98
        nqA1Om+7AOKe8+tl622gBQfaILWqHbLh15lHPlMrS8Opq6wd3hVR/YII05rbBNQ+7dM3HhoCim3
        cvUEAMJ7UXxP4LpQZKlfdz8ybp6Y3+zKbqLp7B9We3A==
X-Received: by 2002:a05:6402:160a:: with SMTP id f10mr540042edv.355.1629447460460;
        Fri, 20 Aug 2021 01:17:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTKhIXh/wQkiam+jDiIJMsZytCrGinhmIixM8tb1chHNWPio4haTinyP7ejx20wdIF1XMViA==
X-Received: by 2002:a05:6402:160a:: with SMTP id f10mr540024edv.355.1629447460363;
        Fri, 20 Aug 2021 01:17:40 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id d22sm2488041ejk.5.2021.08.20.01.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 01:17:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 2/3] ARM: dts: arm: align watchdog and mmc node names with dtschema
Date:   Fri, 20 Aug 2021 10:17:32 +0200
Message-Id: <20210820081733.83976-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210820081733.83976-1-krzysztof.kozlowski@canonical.com>
References: <20210820081733.83976-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the watchdog and mmc device node names with the schema to fix
warnings like:

  mmci@50000: $nodename:0: 'mmci@50000' does not match '^mmc(@.*)?$'
  wdt@f0000: $nodename:0: 'wdt@f0000' does not match '^watchdog(@.*|-[0-9a-f])?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
index 2ad9fd7c94ec..bcb3f581977a 100644
--- a/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
+++ b/arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
@@ -215,7 +215,7 @@ aaci@40000 {
 					clock-names = "apb_pclk";
 				};
 
-				mmci@50000 {
+				mmc@50000 {
 					compatible = "arm,pl180", "arm,primecell";
 					reg = <0x050000 0x1000>;
 					interrupts = <9>, <10>;
@@ -275,7 +275,7 @@ v2m_serial3: serial@c0000 {
 					clock-names = "uartclk", "apb_pclk";
 				};
 
-				wdt@f0000 {
+				watchdog@f0000 {
 					compatible = "arm,sp805", "arm,primecell";
 					reg = <0x0f0000 0x1000>;
 					interrupts = <0>;
-- 
2.30.2

