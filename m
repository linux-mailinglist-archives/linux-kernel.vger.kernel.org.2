Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D578356280
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 06:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244020AbhDGE03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 00:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbhDGE02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 00:26:28 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287C8C06174A;
        Tue,  6 Apr 2021 21:26:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id x7so16372341wrw.10;
        Tue, 06 Apr 2021 21:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5KdDU7bWmStE3swA6bDIP4C2YreOYbP8fSjU6f5jMDY=;
        b=ir6wejPtNEQn/ajXwLSx/OHNMCEV0BVm/bYoIJZ4d7dVXy17VYrlvyLE9dQ6+T5zrR
         AE4wSsq0fb8oGb08676TOK3ljBgej5cMobKpqVdO6a67SL8A4M7cEsOPMm1QhBxyx+Jr
         RV5TnxjTyrHTLuvoJay/fgtesLkX60RPrHwu1ByW5ywf44Mdht13yZTIJmorcQezsP3t
         u3ucZZ74jKyO5aJPhLiy0/rVLimQEc8qk1W2rE/OG/5NWGmXj7LM38x2rcSufk+8ijXX
         U2S3Z2YEtAZKJXSfkXEMWjFSib8YpHwZAQLhD+Hmqlevwy7W3ku2KXS05OT8IzfbFoNq
         ya2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5KdDU7bWmStE3swA6bDIP4C2YreOYbP8fSjU6f5jMDY=;
        b=IpDB/t8BRIx9FWoTuA0w8r0VXIihN1JYgmGRlT2V2qGIiYG9E8zITKKda58aLhRniP
         b0DgIL0qLM9fo6abyCFztr9qcU34XbLwLXCj0UkPjv+vsVkiijjq3z8GcylU3MLy/SrS
         IK0NEymWgMSbNyJGuBz0BwkQ6vrheBCPD4ogsuuhfKla1A9PwsHMqnPa83sdIQgWghSS
         YpI12/7djOrgJ25vZD7UnHHBzPpM0DsRfONPJCYleQQUzm28XD8zq8O2R5ZrBRdoWkxQ
         6w6XbTYdiMOQme7vLVTBIsT1587mOf6KYGk6ayHveibFjzxLz+90msFHjFmCnE7MsUyq
         qDvA==
X-Gm-Message-State: AOAM53189GDlaufjd91IsvfCrE5adrSHbzajlDS2m8oKFGcVp1UaTGvY
        fnLCcjYv3iKKZGOJ//FACGw=
X-Google-Smtp-Source: ABdhPJxwt/QTf9jnkvwysMy8N0WkMbKvrDaZvwchBpmxsCQ8UBW84c55tpooQVZQgoHKey0EoFDdCQ==
X-Received: by 2002:a5d:53cd:: with SMTP id a13mr1735800wrw.273.1617769577938;
        Tue, 06 Apr 2021 21:26:17 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id k3sm16487112wrc.67.2021.04.06.21.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 21:26:17 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Hyeonki Hong <hhk7734@gmail.com>
Subject: [PATCH v2 2/3] arm64: dts: meson: add saradc node to ODROID N2/N2+
Date:   Wed,  7 Apr 2021 04:26:08 +0000
Message-Id: <20210407042609.9736-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210407042609.9736-1-christianshewitt@gmail.com>
References: <20210407042609.9736-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hyeonki Hong <hhk7734@gmail.com>

Add the meson saradc node to the ODROID N2/N2+ common dtsi.

Signed-off-by: Hyeonki Hong <hhk7734@gmail.com>
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 2f8d574c30c0..0a994668e707 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -508,6 +508,11 @@
 	status = "okay";
 };
 
+&saradc {
+	status = "okay";
+	vref-supply = <&vddao_1v8>;
+};
+
 /* SD card */
 &sd_emmc_b {
 	status = "okay";
-- 
2.17.1

