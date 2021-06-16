Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 815A23AA441
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 21:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhFPT0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 15:26:52 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:34336 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbhFPT0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 15:26:51 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d88 with ME
        id HvQi2500821Fzsu03vQiMT; Wed, 16 Jun 2021 21:24:43 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 16 Jun 2021 21:24:43 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Julia.Lawall@inria.fr, Gilles.Muller@inria.fr,
        nicolas.palix@imag.fr, michal.lkml@markovi.net
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] Coccinelle: Update and rename api/alloc/pci_free_consistent.cocci
Date:   Wed, 16 Jun 2021 21:24:39 +0200
Message-Id: <edc2fdb429d184d05a70956ced00845bca2d4fe9.1623871406.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'pci_alloc_consistent()' is about to be removed from the kernel.
It is now more useful to check for dma_alloc_coherent/dma_free_coherent.

So change the script accordingly and rename it.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Not sure that the script works.
There are 718 'dma_alloc_coherent' calls in 5.13-rc6. It is surprising
to have no match at all, not even a single false positive.
---
 ..._consistent.cocci => dma_free_coherent.cocci} | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)
 rename scripts/coccinelle/free/{pci_free_consistent.cocci => dma_free_coherent.cocci} (52%)

diff --git a/scripts/coccinelle/free/pci_free_consistent.cocci b/scripts/coccinelle/free/dma_free_coherent.cocci
similarity index 52%
rename from scripts/coccinelle/free/pci_free_consistent.cocci
rename to scripts/coccinelle/free/dma_free_coherent.cocci
index d51e92556b42..75f159e7b6d7 100644
--- a/scripts/coccinelle/free/pci_free_consistent.cocci
+++ b/scripts/coccinelle/free/dma_free_coherent.cocci
@@ -1,10 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/// Find missing pci_free_consistent for every pci_alloc_consistent.
+/// Find missing dma_free_coherent for every dma_alloc_coherent.
 ///
 // Confidence: Moderate
 // Copyright: (C) 2013 Petr Strnad.
 // URL: http://coccinelle.lip6.fr/
-// Keywords: pci_free_consistent, pci_alloc_consistent
+// Keywords: dma_free_coherent, dma_alloc_coherent
 // Options: --no-includes --include-headers
 
 virtual report
@@ -17,12 +17,12 @@ position p1,p2;
 type T;
 @@
 
-id = pci_alloc_consistent@p1(x,y,&z)
+id = dma_alloc_coherent@p1(x,y,&z)
 ... when != e = id
 if (id == NULL || ...) { ... return ...; }
-... when != pci_free_consistent(x,y,id,z)
-    when != if (id) { ... pci_free_consistent(x,y,id,z) ... }
-    when != if (y) { ... pci_free_consistent(x,y,id,z) ... }
+... when != dma_free_coherent(x,y,id,z)
+    when != if (id) { ... dma_free_coherent(x,y,id,z) ... }
+    when != if (y) { ... dma_free_coherent(x,y,id,z) ... }
     when != e = (T)id
     when exists
 (
@@ -40,7 +40,7 @@ p1 << search.p1;
 p2 << search.p2;
 @@
 
-msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
+msg = "ERROR: missing dma_free_coherent; dma_alloc_coherent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
 coccilib.report.print_report(p2[0],msg)
 
 @script:python depends on org@
@@ -48,6 +48,6 @@ p1 << search.p1;
 p2 << search.p2;
 @@
 
-msg = "ERROR: missing pci_free_consistent; pci_alloc_consistent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
+msg = "ERROR: missing dma_free_coherent; dma_alloc_coherent on line %s and return without freeing on line %s" % (p1[0].line,p2[0].line)
 cocci.print_main(msg,p1)
 cocci.print_secs("",p2)
-- 
2.30.2

