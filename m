Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4293C59D5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 13:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351726AbhGLJJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 05:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378855AbhGLIuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 04:50:01 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33155C0613E9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 01:42:13 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed10:f017:d84b:501f:cdd7])
        by michel.telenet-ops.be with bizsmtp
        id U8i9250043dzGBx068i9Kl; Mon, 12 Jul 2021 10:42:09 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m2rVw-000VKL-Q6; Mon, 12 Jul 2021 10:42:08 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1m2qYB-008seM-Ui; Mon, 12 Jul 2021 09:40:23 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Christoph Hellwig <hch@lst.de>, Finn Thain <fthain@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] m68k: MAC should select HAVE_PATA_PLATFORM
Date:   Mon, 12 Jul 2021 09:40:22 +0200
Message-Id: <20210712074022.2116655-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The defconfigs switched Mac from the deprecated CONFIG_BLK_DEV_PLATFORM
to CONFIG_PATA_PLATFORM.  However, the latter depends on
CONFIG_HAVE_PATA_PLATFORM, which thus must be selected first.

Fixes: b90257bfddbd01f3 ("m68k: use libata instead of the legacy ide driver")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
I thought I had sent this out before, but apparently I hadn't.
To be queued in the m68k tree as a fix for v5.14.

---
 arch/m68k/Kconfig.machine | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index 18107af0b7a368c0..142a6d208f580a5c 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -33,6 +33,7 @@ config MAC
 	depends on MMU
 	select MMU_MOTOROLA if MMU
 	select HAVE_ARCH_NVRAM_OPS
+	select HAVE_PATA_PLATFORM
 	select LEGACY_TIMER_TICK
 	help
 	  This option enables support for the Apple Macintosh series of
-- 
2.25.1

