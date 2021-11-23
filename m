Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C92459917
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 01:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbhKWAUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Nov 2021 19:20:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40612 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhKWAUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Nov 2021 19:20:49 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AN0HXWG019227;
        Mon, 22 Nov 2021 18:17:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1637626653;
        bh=K/d63la2SgDMSPcY89qc3aHO/glfywJs9Nzq76IaNXY=;
        h=From:To:CC:Subject:Date;
        b=OgaFJ3KuSc+Uol0/aShxlkWZhey2lkHdCC0bjwYTYpf7tKtuerdLE5IPV7HSsNWHW
         olpTfrEH6srkr5lG+OwLHHRydD7V30Gb+Cruv91U0cJb59HoQhOXj12KwH9XM9cxi1
         ScyXYk8UzQt+tFRv8FmSc9i1Og6xrSqUdRg8YDUw=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AN0HXw1062364
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 22 Nov 2021 18:17:33 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 22
 Nov 2021 18:17:32 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 22 Nov 2021 18:17:33 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AN0HX1M046029;
        Mon, 22 Nov 2021 18:17:33 -0600
From:   Nishanth Menon <nm@ti.com>
To:     ARM SoC Team <arm@kernel.org>, SoC Team <soc@kernel.org>
CC:     Arnd Bergmann <arnd@kernel.org>, Olof Johansson <olof@lixom.net>,
        Santosh Shilimkar <ssantosh@kernel.org>, <tony@atomide.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH] MAINTAINERS: Update maintainer entry for keystone platforms
Date:   Mon, 22 Nov 2021 18:17:25 -0600
Message-ID: <20211123001725.21422-1-nm@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch the kernel tree for keystone to the consolidated ti tree and add
myself as primary maintainer for keystone platforms to offset Santosh's
workload.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 MAINTAINERS | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5250298d2817..e251c4f23749 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2729,10 +2729,11 @@ S:	Maintained
 F:	drivers/memory/*emif*
 
 ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
+M:	Nishanth Menon <nm@ti.com>
 M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
 F:	arch/arm/boot/dts/keystone-*
 F:	arch/arm/mach-keystone/
 
@@ -19031,11 +19032,12 @@ F:	drivers/mmc/host/tifm_sd.c
 F:	include/linux/tifm.h
 
 TI KEYSTONE MULTICORE NAVIGATOR DRIVERS
+M:	Nishanth Menon <nm@ti.com>
 M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-kernel@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
 F:	drivers/soc/ti/*
 
 TI LM49xxx FAMILY ASoC CODEC DRIVERS
-- 
2.31.1

