Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E56344E7BD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 14:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235084AbhKLNrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 08:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235061AbhKLNrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 08:47:04 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD49C061767
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:44:13 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id o8so37789243edc.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Nov 2021 05:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+11/5QhDjvHebghuXrK94NMiJV4iB56FWTY6infSJEM=;
        b=VCxAzCnKeRIEjI3hyvDrZ5J+WNdd9RaNLmwNwJmdgC0+ZnCPEFSx9c9uyeJK1scqWk
         2QNPDVV8tT37ztpw5F5RbdRAv/oqmFfxQTMKUxbI7ddrlgw1NGqsqL98LExawIvVVzTm
         fGZuswg5VPHfMcxTlJU5QHVT5xgIXU6GrcMY9xWHIZMa40NXJGO17yWIi8JooZaRV4gS
         8/5/OcwiLMs9kacJyspSPvDJbRYW91QoprdUb1Map6iPEa1BrQiv4EbQenYukutV1gwP
         PVCR3EGldCSqUDOsfSVTt/ujeCY/RSqdi7DQWTkxW4EOqCmFDbztw0F4kHG1FK5eHhmE
         IjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+11/5QhDjvHebghuXrK94NMiJV4iB56FWTY6infSJEM=;
        b=fauqOsLLTvyO5gKgHCpCR1XxN+Y7sB5eT1193GtMWDseENK3ArheRauI85/v7BufBp
         iQR+YdMXYN0IEnG7AWxF24+XCj3bNol413/baxkN6w+G9xsloKvrSCSG+7kcwQ/sIKwx
         3BJOgZgKyIJMgcUEiL0XAxbngfraJYOnwjkuJOidNP+a2eCMCzOs/BQiZtB30XVY2zy2
         f0i8GiS7evJDPltO4bYlEoRrVraT0EYZzAZTf8bWE8cmTFOiiziC6OU3CvX5T3aH1Z1X
         4Bhr/BKP6app9vBRPKNNIUPArIv/IW9NqhIXxFtSWDgjHhy/CY/bSihLb3A9MmfXcRA+
         lugg==
X-Gm-Message-State: AOAM5319ONwRZLZC+YV44rq43FFLAtGkztgAI/qG0P/QGY1/Z6MDWC/I
        jUWtoQw9ORBmO3iF/2SppChJgw==
X-Google-Smtp-Source: ABdhPJyVGL0HggktauQzfX4R4SPudEdtG9PweoAnYEfD814Ix+78MGhFz6hY+lnGlnekPElkvwLCVQ==
X-Received: by 2002:a17:907:7703:: with SMTP id kw3mr19507359ejc.34.1636724652384;
        Fri, 12 Nov 2021 05:44:12 -0800 (PST)
Received: from fedora.. (dh207-98-14.xnet.hr. [88.207.98.14])
        by smtp.googlemail.com with ESMTPSA id z6sm3142867edc.53.2021.11.12.05.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 05:44:11 -0800 (PST)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        miquel.raynal@bootlin.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        pali@kernel.org, marek.behun@nic.cz
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/2] arm64: dts: marvell: cn9130: enable CP0 GPIO controllers
Date:   Fri, 12 Nov 2021 14:44:03 +0100
Message-Id: <20211112134403.1016717-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211112134403.1016717-1-robert.marko@sartura.hr>
References: <20211112134403.1016717-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CN9130 has a built-in CP115 which has 2 GPIO controllers, but unlike in
Armada 7k and 8k both are left disabled by the SoC DTSI.

This first of all makes no sense as they are always present due to being
SoC built-in and its an issue as boards like CN9130-CRB use the CPO GPIO2
pins for regulators and SD card support without enabling them first.

So, enable both of them like Armada 7k and 8k do.

Fixes: 6b8970bd8d7a ("arm64: dts: marvell: Add support for Marvell CN9130 SoC support")

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm64/boot/dts/marvell/cn9130.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/cn9130.dtsi b/arch/arm64/boot/dts/marvell/cn9130.dtsi
index 71769ac7f058..327b04134134 100644
--- a/arch/arm64/boot/dts/marvell/cn9130.dtsi
+++ b/arch/arm64/boot/dts/marvell/cn9130.dtsi
@@ -42,3 +42,11 @@ aliases {
 #undef CP11X_PCIE0_BASE
 #undef CP11X_PCIE1_BASE
 #undef CP11X_PCIE2_BASE
+
+&cp0_gpio1 {
+	status = "okay";
+};
+
+&cp0_gpio2 {
+	status = "okay";
+};
-- 
2.33.1

