Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965D839786A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 18:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhFAQuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 12:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhFAQt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:49:56 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD96EC061756;
        Tue,  1 Jun 2021 09:48:14 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id dj8so5956528edb.6;
        Tue, 01 Jun 2021 09:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N9ujW2Qt+Tu2jJvNcfLPCqaX9eDRsnHYASEY0yw0Dq8=;
        b=o7quV5jp4VzQYkV7ItBmk0LigYxjpvV6MOinQgyohY4XXi5LdDpu0ymP6oziCl67Of
         2OzhfYIRj3/q9if9B0aS0fMUiPWeBulFoxJQ1qr+bAoUqqrQdnjU/GvpjUTnRufsiSHu
         vV6p7YTEki7WP9MdVdvMRWt+VuEBWSKbHtnttveATcXSHiI1jTZq3uCWXpXEMh1VTVH7
         zhT9mHlCCvgMkqRXP+9j0vNnMBdhXz1OePQ9C95vXd9L0W7w2JA6k6CIYHGzq3gcEUzY
         ND/H5qSQv0rZ5OTmJq+U5D6tXcxH0PaXlrYd5C6EajDjus0DKaZo7RZpDUGLfykUG8bG
         uAIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N9ujW2Qt+Tu2jJvNcfLPCqaX9eDRsnHYASEY0yw0Dq8=;
        b=ihI6zeayA0HikJzpe62Lo2gbirzSuAK70pOwotWL44VBMaISuwx5nKqyGQyM15BJmn
         dh/Ba4FdvA2NdkFtpeKKg16lMuQKq7F7ggo12n3HxKVj9R9z7eilXUrmHsltkoxHMx7s
         Uupo68aqfLFbB/XnYbmArtpEi54gp7WtCp6S6SBWlQbnYAeolVEEpZCYEAoqLo2U6HfK
         qDNJ1TiMQQ+1tTrhwRTg5QrkvsgkYsRGjz/Tt0Rv7pRr1wft1oaIuYPuKrzxssiZeb7n
         HYJRe7g8xaYNXNMUWoLdEfdlgsEHNhPph8CX8n0ItsKJiQ57Qvm972wErZGZuWGsMApy
         bexg==
X-Gm-Message-State: AOAM533t2Ou8pkwCXYp/Ck+gStzxue4U4oFax+3NZ5bCIOk0EtupDISc
        r+3B9IEKPY3m60UqKyDUedPQmjdTk38IGA==
X-Google-Smtp-Source: ABdhPJwmFvPqwCyzRBI5mROfF8pb56oDh+5wBx1i0BuLG+wDCDFurbvvYZ0imlKFHyr9o+d+tqIAog==
X-Received: by 2002:a05:6402:510b:: with SMTP id m11mr33229905edd.26.1622566093458;
        Tue, 01 Jun 2021 09:48:13 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q18sm8327750edd.3.2021.06.01.09.48.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jun 2021 09:48:13 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        t.schramm@manjaro.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/5] ARM: dts: rockchip: rename nodename for phy-rockchip-inno-usb2
Date:   Tue,  1 Jun 2021 18:47:58 +0200
Message-Id: <20210601164800.7670-4-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20210601164800.7670-1-jbx6244@gmail.com>
References: <20210601164800.7670-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pattern: "^(|usb-|usb2-|usb3-|pci-|pcie-|sata-)phy(@[0-9a-f,]+)*$"
in phy-provider.yaml has required "#phy-cells" for phy nodes.
The "phy-cells" in rockchip-inno-usb2 nodes are located in subnodes.
Rename the nodename to pattern "usb2phy@[0-9a-f]+$" to prevent
notifications.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 4 ++--
 arch/arm/boot/dts/rv1108.dtsi | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 5774bc309..cffd7acfb 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -190,7 +190,7 @@
 			status = "disabled";
 		};
 
-		u2phy0: usb2-phy@760 {
+		u2phy0: usb2phy@760 {
 			compatible = "rockchip,rk3228-usb2phy";
 			reg = <0x0760 0x0c>;
 			clocks = <&cru SCLK_OTGPHY0>;
@@ -217,7 +217,7 @@
 			};
 		};
 
-		u2phy1: usb2-phy@800 {
+		u2phy1: usb2phy@800 {
 			compatible = "rockchip,rk3228-usb2phy";
 			reg = <0x0800 0x0c>;
 			clocks = <&cru SCLK_OTGPHY1>;
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 884872ca5..9bd0acf3b 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -265,7 +265,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 
-		u2phy: usb2-phy@100 {
+		u2phy: usb2phy@100 {
 			compatible = "rockchip,rv1108-usb2phy";
 			reg = <0x100 0x0c>;
 			clocks = <&cru SCLK_USBPHY>;
-- 
2.11.0

