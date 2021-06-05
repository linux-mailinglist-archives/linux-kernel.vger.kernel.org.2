Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83D3139C53E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 04:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbhFECu5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 22:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhFECu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 22:50:56 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC59C061766;
        Fri,  4 Jun 2021 19:48:57 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id v12so5582939plo.10;
        Fri, 04 Jun 2021 19:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/4gtuT3qIireG3x7h44jTs73Upz/ez6wI7xxmdqwiQ=;
        b=nYrr9Now3unyQ+G1dLje0D9bKc0IFpanOBxrEabtL2X3L9MjDIfi4WskDT/jZkcQkq
         U+uDMdMXSQH67ZHLsBmXST1ThjzUtm2HEYAQhRRBwM4whhX2zrYaEJpHBpjoOZXkrF+6
         dGBihI9b9qrnfVAEgYYg7ACVKsO+dCirdXF1Y5U/42RkO8vKUQAQPIXnMBD7a/vRxk15
         uUdtFp8iZmkpb+vxofN5ma2C4giBiw0d+hOiw2vOrAUnKS22SSCbk6IsTeOgjFJ2b8tJ
         q4fDKFE+1EvVzdnmD+nRGQfxOASL95Vx6KCFWeJGoJy+57edHOfrEQK28+BBUBkgY14J
         62Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s/4gtuT3qIireG3x7h44jTs73Upz/ez6wI7xxmdqwiQ=;
        b=o/x2ilFpLvQqQrGbo6eR/p6CANwIn/huOA8lbvERh/7GlkGWhaZSyvrV53zH5ExT8Z
         syJT8RXYZoMIT7UsOaB5Hjz+dKRS6tWUwMEkUyLCzTJHjB89ClzAi1NIW5fU6X237Ux7
         GKgAegnpafSuGI3Vt3Yz7xiLd2IHOeXJZxKx9mGEVEebteymdR4jhxsey45PPGSbGACV
         lC6nHK80S5gyTQ3sbmaNUHCjrJvCcN9RDrln4vyrdLr0i7Bxqo1Bh0HpezLkDYibkAFr
         4CgYZzuAchORqVtF9Htp3+RXgdoKgrnC3SULy6tSIRqjKVGhrRubs0tNPLsCPCAvlEiS
         4cvA==
X-Gm-Message-State: AOAM532FTaVILok2bQoGfHZNVzAaB7rOc3S+PzP8lSME0wsZQMPdcI/y
        8YF2jGIUWWnHqtmSR37j7jQ=
X-Google-Smtp-Source: ABdhPJz02rz2AzqT1NXP1wtshu16bOL52pLPKM7O6EjXnal2UNOH3Z2JzZceQES9z7jEDd82CZj3kg==
X-Received: by 2002:a17:902:bb8e:b029:f4:58d1:5170 with SMTP id m14-20020a170902bb8eb02900f458d15170mr7252353pls.84.1622861335126;
        Fri, 04 Jun 2021 19:48:55 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id a9sm3016323pga.43.2021.06.04.19.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 19:48:54 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH] arm64: dts: meson: vim3: add i2c aliases
Date:   Sat,  5 Jun 2021 10:48:48 +0800
Message-Id: <20210605024848.409923-1-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Xie <nick@khadas.com>

Add i2c aliases for Khadas VIM3/3L.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 4686ea7abe0b..b285341f862a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -17,6 +17,11 @@ aliases {
 		serial2 = &uart_B;
 		serial3 = &uart_C;
 		serial4 = &uart_AO_B;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
+		i2c4 = &i2c_AO;
 		ethernet0 = &ethmac;
 		rtc0 = &rtc;
 		rtc1 = &vrtc;
-- 
2.25.1

