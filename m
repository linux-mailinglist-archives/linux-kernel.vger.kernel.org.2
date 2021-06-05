Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10A7839C642
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 08:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhFEG1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Jun 2021 02:27:03 -0400
Received: from mail-pj1-f52.google.com ([209.85.216.52]:45589 "EHLO
        mail-pj1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhFEG1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jun 2021 02:27:02 -0400
Received: by mail-pj1-f52.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso3674396pjb.4;
        Fri, 04 Jun 2021 23:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/4gtuT3qIireG3x7h44jTs73Upz/ez6wI7xxmdqwiQ=;
        b=MvI5AFzL6iGO30UsE/59Cs+YLshuejKEYHlkyj88RJvsvRZ3OV4I8bH5f+ZREOtFmg
         nGqFM6RyO3pE7v5OgltdJRHJT3CWMdwTrEkNB+o2Q9RnNvP6fV7NJOOp8xaU2Ac8f5vv
         GHaU+8rDLbUV/nLDxfHWp2IlO7DoxWDrYDbCP+UYtvz+H46JLctZCCsVF07hGJ8b0FwU
         Ir4Odo1v9ceIp3hUH5q7s7xoJPl+3JokH5/QXl4aKlFIBcqED5q+UM5e4P4V1G4gFbMv
         SXKgddqkYUFr1OMwfmnNR7wzJiGnlO2fdUouXlD1PvqVGtJm8Y+XbIiOPfMQ5PcMa/CW
         dI9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/4gtuT3qIireG3x7h44jTs73Upz/ez6wI7xxmdqwiQ=;
        b=pq1A63486jfWsyedbYynd01v6yRQ6CGtPsQBssXx0Arpsi2gymrkTHuOiM/oAlzHVC
         ySOUORipPHkKjAeMYptQ5K8mrqY/cbopOvYywkCocvBZjhxtkQE+oonwMAUtqe/BqCa5
         rCBx2L4s5ljAPQUyCuiT7mG1LSVV/TvhiV75JLeNjfECyAGxHdUSiiVWK4dBUYegTC+9
         M6wXlghGnmAh1JTXG4G+m7/gRT8GsdAcotN6/eYUp8Fjb1VJtW2ZsqKSLSG4s5vd52s0
         9E023HWY2ifsKi3SjLUZZUV0xkho+Lm+0RyY4mH2Dy04/fvw548nFOHA+Xn1aa1reGf1
         /XXA==
X-Gm-Message-State: AOAM532uSMdaHPaNxoZFSZASKJYXNJ4fG7IE31zJeeupQSQ3QP5mmgFi
        +awv9pa2Nr0KW2/tyCas+8U=
X-Google-Smtp-Source: ABdhPJyxNP+i9W3LDwW41qJsPNepcYBCRaUlnffS990O2KQIQvKXm/1z7tN82cTXDUVcGmtlBgABrw==
X-Received: by 2002:a17:90a:7f81:: with SMTP id m1mr20246482pjl.23.1622874241402;
        Fri, 04 Jun 2021 23:24:01 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id v14sm2800870pgo.89.2021.06.04.23.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 23:24:01 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH 4/6] arm64: dts: meson: vim3: add i2c aliases
Date:   Sat,  5 Jun 2021 14:23:11 +0800
Message-Id: <20210605062313.418343-5-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210605062313.418343-1-xieqinick@gmail.com>
References: <20210605062313.418343-1-xieqinick@gmail.com>
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

