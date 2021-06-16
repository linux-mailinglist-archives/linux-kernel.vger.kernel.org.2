Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561C83AA3A2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 20:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbhFPS4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 14:56:45 -0400
Received: from smtp08.smtpout.orange.fr ([80.12.242.130]:54011 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbhFPS4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 14:56:44 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d88 with ME
        id Huub2500G21Fzsu03uucKk; Wed, 16 Jun 2021 20:54:36 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 16 Jun 2021 20:54:36 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Julia.Lawall@inria.fr, Gilles.Muller@inria.fr,
        nicolas.palix@imag.fr, michal.lkml@markovi.net
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] Coccinelle: remove pci_[z]alloc_consistent from api/alloc/alloc_cast.cocci
Date:   Wed, 16 Jun 2021 20:54:34 +0200
Message-Id: <9ea05b27750d20f61217c88c3ec63f3e2420678a.1623869587.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'pci_alloc_consistent()' and 'pci_zalloc_consistent()' are about to be
removed from the kernel.
So, there is no point any more for searching for these identifiers.

Simplify the script.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 scripts/coccinelle/api/alloc/alloc_cast.cocci | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/coccinelle/api/alloc/alloc_cast.cocci b/scripts/coccinelle/api/alloc/alloc_cast.cocci
index f6f0ccdb6409..ef8a97bb5f38 100644
--- a/scripts/coccinelle/api/alloc/alloc_cast.cocci
+++ b/scripts/coccinelle/api/alloc/alloc_cast.cocci
@@ -34,8 +34,8 @@ type T;
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
    dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
-   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
-   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
+   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
+   kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
 
 //----------------------------------------------------------
@@ -57,8 +57,8 @@ type r1.T;
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
    dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
-   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
-   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
+   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
+   kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
 
 //----------------------------------------------------------
@@ -80,8 +80,8 @@ type r1.T;
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
    dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
-   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
-   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
+   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
+   kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
 
 //----------------------------------------------------------
@@ -97,8 +97,8 @@ position p;
   \(kmalloc\|kzalloc\|kcalloc\|kmem_cache_alloc\|kmem_cache_zalloc\|
    kmem_cache_alloc_node\|kmalloc_node\|kzalloc_node\|vmalloc\|vzalloc\|
    dma_alloc_coherent\|devm_kmalloc\|devm_kzalloc\|
-   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|pci_alloc_consistent\|
-   pci_zalloc_consistent\|kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
+   kvmalloc\|kvzalloc\|kvmalloc_node\|kvzalloc_node\|
+   kmem_alloc\|kmem_zalloc\|kmem_zone_alloc\|
    kmem_zone_zalloc\|vmalloc_node\|vzalloc_node\)(...)
 
 @script:python depends on org@
-- 
2.30.2

