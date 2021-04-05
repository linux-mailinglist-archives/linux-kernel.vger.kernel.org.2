Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943033540ED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 12:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239744AbhDEJfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 05:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbhDEJfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 05:35:54 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53712C061756;
        Mon,  5 Apr 2021 02:35:48 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id x16so11452810iob.1;
        Mon, 05 Apr 2021 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pI6wpbyKAKJr8u5bwRwqEtouNzQI7RRIJklwhnvlD+8=;
        b=qYhBPrIYDODOgyjH/fwTrHzmBbfhghAoDTSO07D8sO4DPgCJMqO+4FIQel/6Acj7ga
         w8rKjw0Weby3rw7lsReQ2ku34RCaNYQ0bjN9Q9fBQx8sh4vN+jB4sDDxDVaksh5lqtH5
         7yphh8s4GT1sj4mHh5LnectyNus/NLFjTpSZOVq+QxADbXuauGmGrocv0dQ55PVbQSQf
         8D7Sq8CBgx6mDDLuSc1kgM3mVT0HgFSVG1KfX20I7igiIjWtNC0R2b5txkO+Fo8lx726
         dpSk8RqCPcbgxyK198DqVjnEfbEmH8YKjkpSLwaPFA08iu77PAm19nepstrEM6RMMt0a
         MyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pI6wpbyKAKJr8u5bwRwqEtouNzQI7RRIJklwhnvlD+8=;
        b=ATfanEnlSkzCb0X5LFuAeCLZkV9sEThYgEf/Z7dZTMM9kYBWer9PFm/DHFOCG4pgZR
         elr9tOkUZcUggXQwEzSeG210jrm+yMp36Oj8XMGx2RqZmvtBizZ+g3pzaEZLm+zoWRUJ
         SnzD8NtVgdvZNTKKKFX7uNDCU4BeLqqwqSO/MqPGGe9VO/cXgr6KLB0p7kB2riFN4928
         JNFBoBAwWqs+ZTCS8xlRL4QbpBEC7e+s0qtKDQDNPq4HDM6ID5XI+7OzuG1/YKJVwIyq
         q9t2Iir80P4Xq4MbKLjnBgsc9QVIXrRo+f9nGgrBnnzpJ7CQEGE8kFmriNwdVpzbKULR
         n2/g==
X-Gm-Message-State: AOAM533G++bVeLxNhH+hluZlNmSiUWC2fri9y9yy0ieRQoNimJtkMdBl
        JlKREZt44eO6TwUGAAAllWpOiMB529vV4g==
X-Google-Smtp-Source: ABdhPJxlqGpociWipndS2n4+rqakUS/MfgEBzRaZq0pou1XROcu9/kdMZvTqLQMhr+w5l+bxqQ+Mgg==
X-Received: by 2002:a05:6602:17cd:: with SMTP id z13mr19537547iox.109.1617615347695;
        Mon, 05 Apr 2021 02:35:47 -0700 (PDT)
Received: from localhost.localdomain (tunnel525895-pt.tunnel.tserv15.lax1.ipv6.he.net. [2001:470:c:1200::2])
        by smtp.googlemail.com with ESMTPSA id b9sm12027614ioz.49.2021.04.05.02.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 02:35:47 -0700 (PDT)
From:   Tianling Shen <cnsztl@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        David Bauer <mail@david-bauer.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Chen-Yu Tsai <wens@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tianling Shen <cnsztl@gmail.com>
Subject: [PATCH v2] rockchip: enabled LAN port on NanoPi R2S
Date:   Mon,  5 Apr 2021 17:34:23 +0800
Message-Id: <20210405093423.16149-1-cnsztl@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Bauer <mail@david-bauer.net>

Enable the USB3 port on the FriendlyARM NanoPi R2S.
This is required for the USB3 attached LAN port to work.

Signed-off-by: David Bauer <mail@david-bauer.net>
[added device node for USB Ethernet controller]
Signed-off-by: Tianling Shen <cnsztl@gmail.com>
---
 .../boot/dts/rockchip/rk3328-nanopi-r2s.dts   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
index faf496d789cf..18936b393d9d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-nanopi-r2s.dts
@@ -13,6 +13,10 @@
 	model = "FriendlyElec NanoPi R2S";
 	compatible = "friendlyarm,nanopi-r2s", "rockchip,rk3328";
 
+	aliases {
+		ethernet1 = &r8153;
+	};
+
 	chosen {
 		stdout-path = "serial2:1500000n8";
 	};
@@ -37,6 +41,16 @@
 		};
 	};
 
+	vcc_rtl8153: vcc-rtl8153-regulator {
+		compatible = "regulator-fixed";
+		gpio = <&gpio2 RK_PC6 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtl8153_en_drv>;
+		regulator-always-on;
+		regulator-name = "vcc_rtl8153";
+		enable-active-high;
+	};
+
 	leds {
 		compatible = "gpio-leds";
 		pinctrl-0 = <&lan_led_pin>,  <&sys_led_pin>, <&wan_led_pin>;
@@ -265,6 +279,12 @@
 			};
 		};
 	};
+
+	usb {
+		rtl8153_en_drv: rtl8153-en-drv {
+			rockchip,pins = <2 RK_PC6 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
 };
 
 &io_domains {
@@ -364,6 +384,18 @@
 	dr_mode = "host";
 };
 
+&usbdrd3 {
+	dr_mode = "host";
+	status = "okay";
+
+	r8153: usb-eth@2 {
+		compatible = "realtek,rtl8153";
+		reg = <2>;
+
+		local-mac-address = [ 00 00 00 00 00 00 ]; /* Filled in by U-Boot */
+	};
+};
+
 &usb_host0_ehci {
 	status = "okay";
 };
-- 
2.17.1

