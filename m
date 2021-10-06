Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12791423DE4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 14:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbhJFMmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 08:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhJFMmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 08:42:18 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5543AC061749
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 05:40:26 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:dcc1:3235:c5c1:b8e0])
        by albert.telenet-ops.be with bizsmtp
        id 2cgP2600P1CcfcG06cgPbz; Wed, 06 Oct 2021 14:40:24 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mY6Df-002UvT-Fv; Wed, 06 Oct 2021 14:40:23 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mY6Df-0064GA-54; Wed, 06 Oct 2021 14:40:23 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] compiler-intel: Remove duplicate RELOC_HIDE()
Date:   Wed,  6 Oct 2021 14:40:22 +0200
Message-Id: <691ab4fcf6b6b69d1db91b94d404cb80fca36f6c.1633523760.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RELOC_HIDE() implementation for the Intel compiler is identical to
the generic version in <linux/compiler.h>, so the former can just be
removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Not even compile-tested.
---
 include/linux/compiler-intel.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/compiler-intel.h b/include/linux/compiler-intel.h
index b17f3cd18334df3d..efc8fafb58f595b2 100644
--- a/include/linux/compiler-intel.h
+++ b/include/linux/compiler-intel.h
@@ -16,11 +16,6 @@
 #define barrier() __memory_barrier()
 #define barrier_data(ptr) barrier()
 
-#define RELOC_HIDE(ptr, off)					\
-  ({ unsigned long __ptr;					\
-     __ptr = (unsigned long) (ptr);				\
-    (typeof(ptr)) (__ptr + (off)); })
-
 /* This should act as an optimization barrier on var.
  * Given that this compiler does not have inline assembly, a compiler barrier
  * is the best we can do.
-- 
2.25.1

