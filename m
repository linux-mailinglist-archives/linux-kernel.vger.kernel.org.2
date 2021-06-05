Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AAF39C532
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 04:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbhFECpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 22:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhFECpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 22:45:20 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85764C061766;
        Fri,  4 Jun 2021 19:43:22 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id t9so9317827pgn.4;
        Fri, 04 Jun 2021 19:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1f90Mva9ReuDNqMb7g12jTb4T/8wcPfWg+nhhZqJDgk=;
        b=vSsAWF5hV9+LTYoXLppeFHkLYY54a7Xif/wejfFmgwu7T/qo+zZhiDMo2gTJ8MfBoR
         G4I3lwJjR1u+ytugt4arnDtN4KOSQM375WXjln2saJaTRvafWao5bsy29LD8iZHBzOdI
         PTmwaTJp8iql14rQx0nM7A4nWIXokc0HwyPwQR4WuxrKK7MiRqz+Sic+9VicMgEyQUo8
         +QKc8PQch359XGWE6G8d1VxlA5gX8CZZi7QXsFYORjE95X9eO6QuMCQSWFGrklWmfrE4
         eZFKFS5r/XUAm5JxSFtNJG1CgtFtkSj7EssecZT8V2vkDhalPzvqSHbFwirTf/n2h1kZ
         Hj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1f90Mva9ReuDNqMb7g12jTb4T/8wcPfWg+nhhZqJDgk=;
        b=OnHwY7W5gzcGqu0+ROIBaKRwoprcgR0JEC9lSprsSeFQG5Iz9i3mDHKYd97KbwQd3T
         qRYyntbM2E8UO93zulCLJkRojEKoibQt+0PcmMkgKqyx9z8D2tKHmc6m8tLa811cJaVq
         1p+tbxdSdbm2hkabov5Szj3+JZGYU6YJyeq6XHaiCcGFN9lJeWWwTnDQH3WfAcNj3gIQ
         Uwyqhud7G1CjXb+rTouPXjBuSV/zh4tBwRX494M/c7N1h30qMER9SFs8aA3xO5YkSKYZ
         aDnMg7sPur9TukjaaHK8BjDnZxwFuckL8Kc/kqsyw5E3CA0BcyrPw2hPljMHPStxhCnG
         JVnw==
X-Gm-Message-State: AOAM531jmHxKvJUUgua6whL8FMGTiUTnw/QxDpOCeMdqyt8/ZkvsR7Ei
        zg18mrWVCTN39lUPoZnClXs=
X-Google-Smtp-Source: ABdhPJwn/bLLG2jxKA4T1rQqSmDsCCLYkuynNVLOZlLJBHj+tiZdjh4ntiqoEmhsvdmOWYp8t6zoIQ==
X-Received: by 2002:a63:b40d:: with SMTP id s13mr7786242pgf.271.1622861002037;
        Fri, 04 Jun 2021 19:43:22 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id c20sm5511540pjr.35.2021.06.04.19.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 19:43:21 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH] arm64: dts: meson: vim3: add serial aliases
Date:   Sat,  5 Jun 2021 10:43:10 +0800
Message-Id: <20210605024310.409430-1-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Xie <nick@khadas.com>

Add serial aliases for Khadas VIM3/3L.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 66d67524b031..4686ea7abe0b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -13,6 +13,10 @@
 / {
 	aliases {
 		serial0 = &uart_AO;
+		serial1 = &uart_A;
+		serial2 = &uart_B;
+		serial3 = &uart_C;
+		serial4 = &uart_AO_B;
 		ethernet0 = &ethmac;
 		rtc0 = &rtc;
 		rtc1 = &vrtc;
-- 
2.25.1

