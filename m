Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B875311F86
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 19:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbhBFSxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 13:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhBFSvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 13:51:54 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1131C061793;
        Sat,  6 Feb 2021 10:50:32 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p20so18291332ejb.6;
        Sat, 06 Feb 2021 10:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VKpw+TGxcSonBmJvYVbjnLKEXkavUls9cDkglgeREzs=;
        b=dxnRtsYmoNO08QDTm2EZFmG/T23JMcH5IQolk9/b0IoNtT5EFbyKFtRfgdirtktHdg
         QS0Kyg6BQoCR6hrtkpphM9v0vA9+KnndfyAs12PitPwIvQl76NNbUMmrti5m84D+KU0+
         JdYmTqINPLzMqd9tzWVusZHAk3WzHRHVhKksOH5KqJUm6UZv0gzMpng0VWVk7PNEpgr4
         CHKaU208IpfJjWT+0Yyq0tn6Wucg8O2BLeWn+f49bLU+JDzVkxpMP2xrBQswIQh3OSie
         VDeEtgHLrIn5nBQsJ+/5eMhJcDVv8hAaRTl4bOrmds9yACjz8CQavz3sX8bAwmbfDQzm
         ytFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VKpw+TGxcSonBmJvYVbjnLKEXkavUls9cDkglgeREzs=;
        b=BmvczFrsjMkaQ2S05p2tW9ek0qIEuLYNDkOUWn+TG+eQaY7wGz9dkICFj0EkxqPpxP
         KLacbmOUYaCTSwGi/OZvj1Un+jsnpayF/gNjnRq2T/GD3bfxPXul3lc80Aodo6UsAIBu
         JaSuLauUMdi4GaD3yLiQyio80hCYJn4Ihk/FEok7YsDld/TNxHKl/79ZVy/Fuo7FEh3d
         u/H7f/GrPueka0kbLwWyVP9oh9MzmerWz+7ptAIUmYqLfdK5HHXmBpWJFyzrnZPdAogh
         v2hGeLnBw4B4Ra03sh+VH+xYovtbj5Ne5bysYZLUsai6VnY9hFRF8raNQLsZOzHefJ2T
         rEkA==
X-Gm-Message-State: AOAM531T7BXzcyESOgyqs6IQ2uHV2/JqR39/bsnHec+pIwkCVTnh41ZH
        /1tlAhnKhYKjolDcc1iGbWpD8PfClA4=
X-Google-Smtp-Source: ABdhPJzeqxbxxXcW77TaBb3tEnIZmr97HAxQZzXcFqol723r3W9n0T3CYbLDmWAah/M+tRsSHEZ5Ig==
X-Received: by 2002:a17:906:f102:: with SMTP id gv2mr9769363ejb.47.1612637431762;
        Sat, 06 Feb 2021 10:50:31 -0800 (PST)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id cb21sm5890005edb.57.2021.02.06.10.50.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Feb 2021 10:50:31 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, balbi@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 8/8] dts64: rockchip: enable dwc3 usb for A95X Z2
Date:   Sat,  6 Feb 2021 19:50:17 +0100
Message-Id: <20210206185017.1817-8-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210206185017.1817-1-jbx6244@gmail.com>
References: <20210206185017.1817-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable dwc3 usb for A95X Z2.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Changed V2:
  remove node wrapper
---
 arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
index 30c73ef25..e71870768 100644
--- a/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3318-a95x-z2.dts
@@ -357,6 +357,11 @@
 	status = "okay";
 };
 
+&usbdrd3 {
+	dr_mode = "host";
+	status = "okay";
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
-- 
2.11.0

