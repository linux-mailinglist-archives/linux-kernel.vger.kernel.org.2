Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C12A9447D08
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238466AbhKHJsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:48:14 -0500
Received: from mx.socionext.com ([202.248.49.38]:21560 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238068AbhKHJsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:48:01 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Nov 2021 18:45:14 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 771FD206E701;
        Mon,  8 Nov 2021 18:45:14 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Mon, 8 Nov 2021 18:45:14 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 3C689B6331;
        Mon,  8 Nov 2021 18:45:14 +0900 (JST)
Received: from scorpio.e01.socionext.com (aries.syh.socionext.com [10.213.112.88])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 1F7E5B6291;
        Mon,  8 Nov 2021 18:45:14 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, orito.takao@socionext.com,
        sugaya.taichi@socionext.com,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH 2/3] ARM: dts: milbeaut: set clock phandle to timer node
Date:   Mon,  8 Nov 2021 18:45:12 +0900
Message-Id: <1636364713-21451-3-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636364713-21451-1-git-send-email-sugaya.taichi@socionext.com>
References: <1636364713-21451-1-git-send-email-sugaya.taichi@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set clock phandle to timer node for Milbeaut M10V support.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 arch/arm/boot/dts/milbeaut-m10v.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/milbeaut-m10v.dtsi b/arch/arm/boot/dts/milbeaut-m10v.dtsi
index 28aee25..c800b13 100644
--- a/arch/arm/boot/dts/milbeaut-m10v.dtsi
+++ b/arch/arm/boot/dts/milbeaut-m10v.dtsi
@@ -76,6 +76,7 @@
 			compatible = "socionext,milbeaut-timer";
 			reg = <0x1e000050 0x20>;
 			interrupts = <0 91 4>;
+			clock = <&clk 4>;
 		};
 
 		uart1: serial@1e700010 { /* PE4, PE5 */
-- 
2.7.4

