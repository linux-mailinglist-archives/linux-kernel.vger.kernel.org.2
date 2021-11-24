Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03AE345C74A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345600AbhKXObK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352359AbhKXOa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:30:58 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F03C127927
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:55:20 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id v11so4007409wrw.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LgR4zVRDulA8gC5R2s4r4rKvFBQIfT0WoQQE/x493d0=;
        b=abaCmqkSTPH8QAdBq+WrbTjKIfEKB5/Ya1O7jo8HXJCOs8K4WUY/Vwvr2ABPzWJe19
         cNZQYkXC3FeD/4EI98Qg/rPhXS7RijjJtvfFlQ91LJtcSHdIEYok4diCt1WUHih8HEJN
         x7vFHlSsdUFRD9n/P8qJ6AtKeME3FjX42EFYFz9m6rNchPyT1PgZXEcudlC7oEPcdA5c
         hJuUTevztMazDEebDjU5WWJtQBmCcYVG3woRGw+lLvVCfc/xjypheaalLuuPnYBOkn5d
         sWDpLvzo61i3TlnNL9z0lbmlXLYncIYtzcXVni/0X769jAuyPWYkLavPSXOXpBPTr39W
         yElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LgR4zVRDulA8gC5R2s4r4rKvFBQIfT0WoQQE/x493d0=;
        b=Gm7P1kLEZ4YMHmptQUF8nbAqNs3ydZJSR5L5lcHK83Ppb6BzI+8hVWXX8gRq5uNKWN
         qLnBtgvrY3vSqtp9iSKbo+spTFBEyvlBkak33f9FqK0jH04aTWVIBcMS05Nu9xwjdtFx
         LzxL0T39cOGCpVa9NzjsF0iAfP8DzrQw8T4guGaFwthvLwZf96lFP+E+jHq5ZkX75Vh7
         5Cw5ZZzxkF50OzC0vqIgxESNUBeeRyVUJwsfhAG17RXnzmVX/Re2Ia4eJ0dXhQxD9VMl
         UUmfrS9zIRd2fLVs213YQnmEEnercs3m7likSwE1yh+GxvQ5/OjDM4/78geLbgDrYLyI
         ilAA==
X-Gm-Message-State: AOAM530x/ELAqBKmJuG+b1feW38NS4zjj8WDk5+zhaVax5wH1emkBUKt
        3N7cMmMbpu4VPyNmgFFi5Y3itQ==
X-Google-Smtp-Source: ABdhPJyBOq3r41KhKmh6W8BZ/YOE08tDP3rKNxXcT6p4RvY3Z+YbX48zxtemRlO+xIw6Dz5JeH8Scg==
X-Received: by 2002:a5d:648e:: with SMTP id o14mr19430256wri.69.1637758518792;
        Wed, 24 Nov 2021 04:55:18 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:3395:9073:b941:501e])
        by smtp.gmail.com with ESMTPSA id v8sm14916443wrd.84.2021.11.24.04.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 04:55:18 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org
Cc:     robh@kernel.org, arnd@linaro.org, heiko@sntech.de,
        ulf.hansson@linaro.org, rjw@rjwysocki.net,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com,
        Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH 2/5] arm64: dts: rockchip: Add powerzones definition for rock960
Date:   Wed, 24 Nov 2021 13:55:01 +0100
Message-Id: <20211124125506.2971069-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211124125506.2971069-1-daniel.lezcano@linaro.org>
References: <20211124125506.2971069-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the powerzones description. This first step introduces the big,
the little and the gpu as a powerzone place.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../boot/dts/rockchip/rk3399-rock960.dts      | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
index 1a23e8f3cdf6..83540bdb64cd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
@@ -61,6 +61,51 @@ bt_active_led: led-6 {
 		};
 	};
 
+	powerzones {
+
+		PKG_PZ: pkg {
+			#powerzone-cells = <0>;
+                        powerzone = <&SOC_PZ>;
+		};
+
+		SOC_PZ: soc {
+		};
+	};
+};
+
+&cpu_b0 {
+	#powerzone-cells = <0>;
+	powerzone = <&PKG_PZ>;
+};
+
+&cpu_b1 {
+	#powerzone-cells = <0>;
+	powerzone = <&PKG_PZ>;
+};
+
+&cpu_l0 {
+	#powerzone-cells = <0>;
+	powerzone = <&PKG_PZ>;
+};
+
+&cpu_l1 {
+	#powerzone-cells = <0>;
+	powerzone = <&PKG_PZ>;
+};
+
+&cpu_l2 {
+	#powerzone-cells = <0>;
+	powerzone = <&PKG_PZ>;
+};
+
+&cpu_l3 {
+	#powerzone-cells = <0>;
+	powerzone = <&PKG_PZ>;
+};
+
+&gpu {
+	#powerzone-cells = <0>;
+	powerzone = <&PKG_PZ>;
 };
 
 &cpu_alert0 {
-- 
2.25.1

