Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 077943DDEEE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 20:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhHBSJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 14:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhHBSJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 14:09:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76242C06175F;
        Mon,  2 Aug 2021 11:09:14 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id e21so20577631pla.5;
        Mon, 02 Aug 2021 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=T2v/c84JGgZj8frH8nCtCcL6naJ0wiQBy76zvSdrpt0=;
        b=JlNE/WLk87Wu2Wsfx1md0X2XnnGc4XtjkXVv1c0A/uyB8pMdhhlq/JHomOX/IqskPU
         p7jbBxco4djceLFb7pfxzFqpKFqRf5cGAwMx656yWmrO/RKUVyd9hsi67sruX0OeJX7b
         /YSdpnlmREUD/x4E5HmoZ2Zbwm/bjEgb/564reAIYjdU0Zvvce9bMylGCQlaB+BZO+/x
         jIYVDR66XhlMGKLgJxF1fU5wNQV50wvzLrJv1gg5qmBmF8UNGbX6kaEzAT+r/Exk47BI
         oUxORf2S9ji7xJYEiyJ1VMp1oyd36mJx45zjmltU1BJETwWu1bGghRWloO9srbsjZTbV
         qGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=T2v/c84JGgZj8frH8nCtCcL6naJ0wiQBy76zvSdrpt0=;
        b=KazcSCraZ+isItBLI0l+lZVr1SeDQXz+QQxBjL0nxd4Pw0uXIM8hO//42dLhrstKop
         P3shGLNLzTdhPnJgw1GRb2f5M1FYNFOP6N/4jfuV7+QTS+LGdXwad0DQSMe0TzwCytjT
         n93t1CMWIrIBGC9Fa9kEw3zK3eWkNtwqej4btwGOwqLJa+TJsQkiRjOIl4yNcIkRRZGr
         ddlJSIsAYqrYKMIcNbqpIcWzw+bhCdpRW/UeFmez4hONuqjzWCRC841kLRmpudoP9Ban
         dGLeVMjCwHU8597K89Wnvow7+qBGgZinhpoTytimXI5gEYPT+vIKegwiz4NXY8MoSNcu
         9h+Q==
X-Gm-Message-State: AOAM533BWYIEyHAMAhJEXNoaXGCPi79pNDSOhj9CpVaLhMZ1BcomTBAx
        5WQJhSdfOM3GX5/6Qbn7gZQ=
X-Google-Smtp-Source: ABdhPJwlOQXf/tuXtqwaHwV52O2Rnw9+gwyxKG+X4MW5FvmW0aAMt6vDnC8Y3faKtiuOVlOlE4H9AQ==
X-Received: by 2002:a63:f62:: with SMTP id 34mr2460375pgp.159.1627927754057;
        Mon, 02 Aug 2021 11:09:14 -0700 (PDT)
Received: from localhost.localdomain ([49.36.83.2])
        by smtp.gmail.com with ESMTPSA id d2sm14333379pgk.57.2021.08.02.11.09.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Aug 2021 11:09:13 -0700 (PDT)
From:   Raag Jadav <raagjadav@gmail.com>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Raag Jadav <raagjadav@gmail.com>
Subject: [PATCH] arm64: dts: ls1046a: fix eeprom entries
Date:   Mon,  2 Aug 2021 23:39:02 +0530
Message-Id: <1627927742-8675-1-git-send-email-raagjadav@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ls1046afrwy and ls1046ardb boards have CAT24C04[1] and CAT24C05[2]
eeproms respectively. Both are 4Kb (512 bytes) in size.
Remove multi-address entries, as we have auto-rollover support
in at24 driver.

[1] https://www.onsemi.com/pdf/datasheet/cat24c01-d.pdf
[2] https://www.onsemi.com/pdf/datasheet/cat24c03-d.pdf

Signed-off-by: Raag Jadav <raagjadav@gmail.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts | 8 +-------
 arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts  | 7 +------
 2 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
index db3d303..83afe21 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-frwy.dts
@@ -83,15 +83,9 @@
 			};
 
 			eeprom@52 {
-				compatible = "atmel,24c512";
+				compatible = "atmel,24c04";
 				reg = <0x52>;
 			};
-
-			eeprom@53 {
-				compatible = "atmel,24c512";
-				reg = <0x53>;
-			};
-
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
index 60acdf0..d220f98 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a-rdb.dts
@@ -59,14 +59,9 @@
 	};
 
 	eeprom@52 {
-		compatible = "atmel,24c512";
+		compatible = "atmel,24c04";
 		reg = <0x52>;
 	};
-
-	eeprom@53 {
-		compatible = "atmel,24c512";
-		reg = <0x53>;
-	};
 };
 
 &i2c3 {
-- 
2.7.4

