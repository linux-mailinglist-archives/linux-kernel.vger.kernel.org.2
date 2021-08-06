Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9D743E264D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243422AbhHFImw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241889AbhHFIms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:42:48 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16046C061799
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 01:42:33 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z11so12024327edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Aug 2021 01:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hft610f3xcdm5s5Ip0V3APpR41A8cP7cQ0IovkJ9Zvg=;
        b=DF9fSiwkngjLAfHK4j5WFus4HSSRlm4+9nkjReR35bgWvZtxinpHmWR8MG7FfQPkTm
         ahg+qSji4qQW9vorzF2pZH6st1meRyTRl+KawV1sp1qXxq/SPZYfKVYUxwrEOZNdZzdW
         Sj3dAm32J+I7I2RrtgwFwCbioXjtup9pxxZ4KLSpNeF9YpfKAo6S9SrUF/aTKxfHT9iT
         jsH0uscvzvQCR8YTMY1Ly2RyKFOEPmO90wStxdvVxrU66jeDCGdRqkRxIm7H98pKlOau
         IIWpPP3JJZYMFxJAflcja9IG/updwpEbQlJr12BPMf2eT4ZO39ACclZC0fEjzPAsyFO2
         T+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=Hft610f3xcdm5s5Ip0V3APpR41A8cP7cQ0IovkJ9Zvg=;
        b=l1t0KwgOVJ6OmhCZu1ObpJ62rDweiORrHrgv2AdkptD1ZA3lihnzPKXQHSBETwWnmd
         tlzQD39tFDGhbQSCH0riohqHp9WJcXiQZ1Pi/fr71BW2Cm/i6iwjDYvunPhe+xbn8yGy
         jqN6e25J9VOX78dBfTEchnTb2WzvsytfXdvjn2ZPly0qR7inzXeelLxo2GCKUgLluGCp
         5+Gi8Hnkzx4LWeJV1u+L3hg9vlNNfYVt8KkKJdUMcuctyaiCQ6Ot47vRMpY00HPUV6As
         ULILMaXk0yvstjnmjAljY0Oz7U4mCGfzGco7xCTC6mZqfDGCozjf+h1+T7Igc9v+Dpn6
         XIvg==
X-Gm-Message-State: AOAM531/V4V0b07vD3GoMvugyshjqYFig24zIi+RrIn/kVVzEjECrd9c
        2L5FnDO0oyV8imM5lohLtPJn1+WsKaCwGi2B
X-Google-Smtp-Source: ABdhPJy4HstmhTAvYVoh8FsDrS+9PMwBfyT1meh1QVkVokQwXfzs9VW7TR3KdqYuZITS/rVNDAJrwg==
X-Received: by 2002:a05:6402:516f:: with SMTP id d15mr11952088ede.210.1628239351397;
        Fri, 06 Aug 2021 01:42:31 -0700 (PDT)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id mf1sm2643153ejb.51.2021.08.06.01.42.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Aug 2021 01:42:31 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Quanyang Wang <quanyang.wang@windriver.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64: zynqmp: Remove not documented is-dual property
Date:   Fri,  6 Aug 2021 10:42:29 +0200
Message-Id: <876c53b92f99623bae45d5c0c5ae79ee3e24f745.1628239345.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove is-dual not documented property and also update comment about QSPI
sizes to reflect dual configuration as 16MB + 16MB.
Only single configuration is supported now.

Reported-by: Quanyang Wang <quanyang.wang@windriver.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts | 3 +--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts | 3 +--
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
index becfc23a5610..3d8d14ef1ede 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu102-revA.dts
@@ -937,9 +937,8 @@ &psgtr {
 
 &qspi {
 	status = "okay";
-	is-dual = <1>;
 	flash@0 {
-		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
+		compatible = "m25p80", "jedec,spi-nor"; /* 16MB + 16MB */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x0>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
index d2219373580a..057c04352591 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu106-revA.dts
@@ -931,9 +931,8 @@ &psgtr {
 
 &qspi {
 	status = "okay";
-	is-dual = <1>;
 	flash@0 {
-		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
+		compatible = "m25p80", "jedec,spi-nor"; /* 16MB + 16MB */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x0>;
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index dac5ba67a160..e1fff62a4cd5 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -773,9 +773,8 @@ &psgtr {
 
 &qspi {
 	status = "okay";
-	is-dual = <1>;
 	flash@0 {
-		compatible = "m25p80", "jedec,spi-nor"; /* 32MB */
+		compatible = "m25p80", "jedec,spi-nor"; /* 16MB + 16MB */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		reg = <0x0>;
-- 
2.32.0

