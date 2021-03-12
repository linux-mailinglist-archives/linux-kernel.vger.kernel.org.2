Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DFFF33907F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbhCLO4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:41722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232005AbhCLO4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:56:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94D2C64FDD;
        Fri, 12 Mar 2021 14:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615560974;
        bh=ifVjIRBycLednUeFJybHn/MpoBYTnrWvaqMZFuw5nk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YIhIdSMV4J4FGbGrJ7PBVLkPjHllhez3mjcmjY+l8HYB50TIWR0JWEaTe3WG+zXe+
         X6JYe/UV019NtfDLULRVAlszt5MvsudRyJDCv/e+fR9azaPszucIHYXKRyVKIW2uHx
         liCYf2dBDNkCUrJK/N63VW4R0PH/XqHiNDcVsNkNyWYfR7tDSYIx0yP6phKfiZAze9
         8mTGGe+w3kkI3X+UVLBrjnSYZG6U0yJXzsauSUjiAv8l1OnePcW8Ck02SzzOiT+wsd
         DZGYfdNZ6ZAll7KMyl8QSzLbGheT7PuLRtQY1trHHTgi6scuER/ke5bpUZPGwww9ns
         qP7QGxoOjZe+Q==
From:   matthias.bgg@kernel.org
To:     lee.jones@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH 5/7] arm: dts: mt6323: Drop OF compatible
Date:   Fri, 12 Mar 2021 15:55:43 +0100
Message-Id: <20210312145545.26050-5-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312145545.26050-1-matthias.bgg@kernel.org>
References: <20210312145545.26050-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <mbrugger@suse.com>

The regulator framework does not need compatible, it's acutall
superfluous. Drop it from the DT.

Signed-off-by: Matthias Brugger <mbrugger@suse.com>
---
 arch/arm/boot/dts/mt6323.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/mt6323.dtsi b/arch/arm/boot/dts/mt6323.dtsi
index 7fda40ab5fe83..d37f118a663a9 100644
--- a/arch/arm/boot/dts/mt6323.dtsi
+++ b/arch/arm/boot/dts/mt6323.dtsi
@@ -21,9 +21,7 @@ mt6323_leds: leds {
 			status = "disabled";
 		};
 
-		mt6323regulator: mt6323regulator{
-			compatible = "mediatek,mt6323-regulator";
-
+		mt6323regulator {
 			mt6323_vproc_reg: buck_vproc{
 				regulator-name = "vproc";
 				regulator-min-microvolt = < 700000>;
-- 
2.30.1

