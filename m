Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8359338F8E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 15:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbhCLOMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 09:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhCLOMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 09:12:15 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2304CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 12 Mar 2021 06:12:14 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:f9e2:c536:b8cc:fbbc])
        by andre.telenet-ops.be with bizsmtp
        id fSCA2400i1ACAb301SCAWP; Fri, 12 Mar 2021 15:12:11 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lKiWQ-0078a8-Fi; Fri, 12 Mar 2021 15:12:10 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1lKiWP-00EXYF-Qd; Fri, 12 Mar 2021 15:12:09 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] mm: Remove default DISCONTIGMEM_MANUAL
Date:   Fri, 12 Mar 2021 15:12:08 +0100
Message-Id: <20210312141208.3465520-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 214496cb18700fd7 ("ia64: make SPARSEMEM default and disable
DISCONTIGMEM") removed the last enabler of ARCH_DISCONTIGMEM_DEFAULT,
hence the memory model can no longer default to DISCONTIGMEM_MANUAL.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
DISCONTIGMEM_MANUAL depends on ARCH_DISCONTIGMEM_ENABLE, which in turns
depends on BROKEN, so probably all discontig memory support can be
removed, too?
---
 mm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index 24c045b24b95069b..579254f10fb1bac6 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -9,7 +9,6 @@ config SELECT_MEMORY_MODEL
 choice
 	prompt "Memory model"
 	depends on SELECT_MEMORY_MODEL
-	default DISCONTIGMEM_MANUAL if ARCH_DISCONTIGMEM_DEFAULT
 	default SPARSEMEM_MANUAL if ARCH_SPARSEMEM_DEFAULT
 	default FLATMEM_MANUAL
 	help
-- 
2.25.1

