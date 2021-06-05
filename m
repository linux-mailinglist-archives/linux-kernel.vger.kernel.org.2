Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BB339C562
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Jun 2021 05:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhFEDLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 23:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhFEDLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 23:11:39 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231B0C061766;
        Fri,  4 Jun 2021 20:09:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l23-20020a17090a0717b029016ae774f973so6280612pjl.1;
        Fri, 04 Jun 2021 20:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8AkX7yScaldi+7GL99EP+gl0QK2qsS9wnoAmRYrRMw=;
        b=FFrM/1R5iGYBQHayGsJtLwbbteR7lDb30n/XNp/w3NE3DfqVWgtjJa8K6fdplNUppY
         RkcYQKCSL7uFi1Ll/bEFHncMxlfub7a11UxtBnXHEWX+iKo9F1uWudp4IyI9OKsUHfJl
         N/JY2+CDOzkDKhbWr1qtNL8P6sf+HsGm+RDSFDm/ZOn77tRlcU9uoM13yPsMl6jA35Dv
         XlT3AIKfTuYT+TTjvegpMe87fAz7hvQSUcKpmTiNwa96qZ0Grt/yPX00HQuQqcs9CjUu
         yVNUONyVzXb6MFvwC+KK+IKzwiAe/rn+Zdli+OP81w6LE3bq45ua65ulOSlyszp/peUw
         wC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o8AkX7yScaldi+7GL99EP+gl0QK2qsS9wnoAmRYrRMw=;
        b=aERtdTtv+K5HjZmcTzdzXHmXq7dLb7MPlgvcV1bVNUXBrwd7HmLcTAnTKf9tQ34yNG
         AEnIH6edmLCwuCAlVYS5AkZ5HN55UkIPFMZcrSdmETEJ66mM6m30R+6HeA9rr0I3JOwI
         jwb2TSNAW0SOMLAhng5Jb0NbcVY4ZtkX0r8R+W0QrKRHTucRNShgqumvett1G5356DXs
         6cOPDSwI+CrXYMcVf4hwxO+566wLfCf+Cik/doFySkE0mzPZr2qAzh/rMaWyB10J1fzu
         f2w48eC/KFhOy5U4vZ4dRB/cOKQsOIkubmC0BqsBRRasizMb6MCe/+OWnmJc7oHq9ptI
         rDyA==
X-Gm-Message-State: AOAM533yGKz+9M+RKqu8F6LvhXWW7z/usjPz3EUfgrNmvHgvC7phFkml
        AMAnlYIrhQtpOXA5dtTjfko=
X-Google-Smtp-Source: ABdhPJzr00o1PC13aCExWnGG81e/h62Rw/VeROmwoDXzaPLthMT4gRPMvIJThlVCjjWqbFh0RAej1A==
X-Received: by 2002:a17:902:f546:b029:101:fa49:3fd5 with SMTP id h6-20020a170902f546b0290101fa493fd5mr492855plf.34.1622862581649;
        Fri, 04 Jun 2021 20:09:41 -0700 (PDT)
Received: from localhost.localdomain (199.19.111.227.16clouds.com. [199.19.111.227])
        by smtp.gmail.com with ESMTPSA id d15sm2720005pfd.35.2021.06.04.20.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 20:09:41 -0700 (PDT)
From:   xieqinick@gmail.com
To:     robh+dt@kernel.org, narmstrong@baylibre.com, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     nick@khadas.com, artem@khadas.com
Subject: [PATCH] arm64: dts: meson: vim3l: add NNA node
Date:   Sat,  5 Jun 2021 11:09:15 +0800
Message-Id: <20210605030915.411391-1-xieqinick@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Xie <nick@khadas.com>

Add Neural Network Accelerator device tree node
for Khadas VIM3L.

Signed-off-by: Nick Xie <nick@khadas.com>
---
 .../dts/amlogic/meson-sm1-khadas-vim3l.dts    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
index 06de0b1ce726..8a4abb61432e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-khadas-vim3l.dts
@@ -14,6 +14,29 @@ / {
 	compatible = "khadas,vim3l", "amlogic,sm1";
 	model = "Khadas VIM3L";
 
+	galcore {
+		compatible = "amlogic, galcore";
+		dev_name = "galcore";
+		status = "okay";
+		clocks = <&clkc CLKID_NNA_AXI_CLK>,
+			<&clkc CLKID_NNA_CORE_CLK>;
+		clock-names = "cts_vipnanoq_axi_clk_composite",
+			"cts_vipnanoq_core_clk_composite";
+		interrupts = <0 186 4>;
+		interrupt-names = "galcore";
+		reg = <0x0 0xff100000 0x0 0x800
+			0x0 0xff000000 0x0 0x400000
+			0x0 0xff63c118 0x0 0x0
+			0x0 0xff63c11c 0x0 0x0
+			0x0 0xffd01088 0x0 0x0
+			0x0 0xff63c1c8 0x0 0x0
+			>;
+		reg-names = "NN_REG","NN_SRAM","NN_MEM0",
+			"NN_MEM1","NN_RESET","NN_CLK";
+		nn_power_version = <3>;
+		nn_efuse = <0xff63003c 0x20>;
+	};
+
 	vddcpu: regulator-vddcpu {
 		/*
 		 * Silergy SY8030DEC Regulator.
-- 
2.25.1

