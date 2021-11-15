Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F8C45017A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 10:32:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbhKOJfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 04:35:15 -0500
Received: from mx.socionext.com ([202.248.49.38]:15863 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236730AbhKOJeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 04:34:17 -0500
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 15 Nov 2021 18:30:57 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id A1662205C83D;
        Mon, 15 Nov 2021 18:30:57 +0900 (JST)
Received: from 172.31.9.53 (172.31.9.53) by m-FILTER with ESMTP; Mon, 15 Nov 2021 18:30:57 +0900
Received: from yuzu2.css.socionext.com (yuzu2 [172.31.9.57])
        by iyokan2.css.socionext.com (Postfix) with ESMTP id 8DF1D3DD5F;
        Mon, 15 Nov 2021 18:30:57 +0900 (JST)
Received: from scorpio.e01.socionext.com (aries.syh.socionext.com [10.213.112.88])
        by yuzu2.css.socionext.com (Postfix) with ESMTP id 7315FB6291;
        Mon, 15 Nov 2021 18:30:57 +0900 (JST)
From:   Sugaya Taichi <sugaya.taichi@socionext.com>
To:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     soc@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, orito.takao@socionext.com,
        sugaya.taichi@socionext.com,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: [PATCH v2 4/4] MAINTAINERS: Add entry to MAINTAINERS for Milbeaut
Date:   Mon, 15 Nov 2021 18:30:56 +0900
Message-Id: <1636968656-14033-5-git-send-email-sugaya.taichi@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1636968656-14033-1-git-send-email-sugaya.taichi@socionext.com>
References: <1636968656-14033-1-git-send-email-sugaya.taichi@socionext.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add entry to MAINTAINERS for Milbeaut that supported minimal drivers.

Signed-off-by: Sugaya Taichi <sugaya.taichi@socionext.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a2345c..a9387cc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2263,6 +2263,15 @@ L:	linux-iio@vger.kernel.org
 S:	Maintained
 F:	drivers/counter/microchip-tcb-capture.c
 
+ARM/MILBEAUT ARCHITECTURE
+M:	Taichi Sugaya <sugaya.taichi@socionext.com>
+M:	Takao Orito <orito.takao@socionext.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Maintained
+F:	arch/arm/boot/dts/milbeaut*
+F:	arch/arm/mach-milbeaut/
+N:	milbeaut
+
 ARM/MIOA701 MACHINE SUPPORT
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.7.4

