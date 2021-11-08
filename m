Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66AF447D05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 10:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238456AbhKHJsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 04:48:13 -0500
Received: from mx.socionext.com ([202.248.49.38]:62305 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238285AbhKHJsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 04:48:05 -0500
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 08 Nov 2021 18:45:14 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 7A62A206E704;
        Mon,  8 Nov 2021 18:45:14 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 8 Nov 2021 18:45:14 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id 57D689D68A;
        Mon,  8 Nov 2021 18:45:14 +0900 (JST)
Received: from scorpio.e01.socionext.com (aries.syh.socionext.com [10.213.112.88])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 3BCB0B6292;
        Mon,  8 Nov 2021 18:45:14 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, orito.takao@socionext.com,
        sugaya.taichi@socionext.com,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH 3/3] ARM: dts: milbeaut: set clock phandle to uart node
Date:   Mon,  8 Nov 2021 18:45:13 +0900
Message-Id: <1636364713-21451-4-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636364713-21451-1-git-send-email-sugaya.taichi@socionext.com>
References: <1636364713-21451-1-git-send-email-sugaya.taichi@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set clock phandle to uart node for Milbeaut M10V support.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 arch/arm/boot/dts/milbeaut-m10v.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/milbeaut-m10v.dtsi b/arch/arm/boot/dts/milbeaut-m10v.dtsi
index c800b13..e592fe0 100644
--- a/arch/arm/boot/dts/milbeaut-m10v.dtsi
+++ b/arch/arm/boot/dts/milbeaut-m10v.dtsi
@@ -85,6 +85,7 @@
 			reg = <0x1e700010 0x10>;
 			interrupts = <0 141 0x4>, <0 149 0x4>;
 			interrupt-names = "rx", "tx";
+			clock = <&clk 2>;
 		};
 
 	};
-- 
2.7.4

