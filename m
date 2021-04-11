Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61D0035B0D4
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Apr 2021 02:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234975AbhDKAM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 20:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234680AbhDKAM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 20:12:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826E0C06138B;
        Sat, 10 Apr 2021 17:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=c+1uiD+E+I3h5W0kFsTlgpmVK7goYpFQjg+5sNaZqp0=; b=MK3D2LBExv0el1yGut7joM9kXr
        kEjsBBiAAYtSdglYxiUMnVjMelnR5apMs0XJf5yXv79GSVOJbMRs4jREaldm/XUlsC//91QzHaj3m
        PwvR/iGl7EbrlxS9OAH26ZIUfumzETh5ENvDY6rr4jvXR4+q9GK7drruJrCwKIUys/MU09/HWvwz4
        XC++YCmTaqq4jtYlXKIZsECMbRi9GaNZV0pImkyj5T6A3RITXY9js0TJe4jhhES458sjIgUuUgCbH
        3QntrcZX1ueEK15awTDblyaY9uSETEC1gCUzLQ62X8v5SCTvTr8bS42LrNmYUXuFWsII7XrNUfZzL
        wdrKbEyA==;
Received: from [2601:1c0:6280:3f0::e0e1] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lVNhs-002Izl-T6; Sun, 11 Apr 2021 00:12:07 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-ia64@vger.kernel.org
Subject: [PATCH] ia64: fix discontig.c section mismatches
Date:   Sat, 10 Apr 2021 17:12:01 -0700
Message-Id: <20210411001201.3069-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix IA64 discontig.c Section mismatch warnings.

When CONFIG_SPARSEMEM=y and CONFIG_MEMORY_HOTPLUG=y, the functions
computer_pernodesize() and scatter_node_data() should not be marked
as __meminit because they are needed after init, on any memory
hotplug event. Also, early_nr_cpus_node() is called by
compute_pernodesize(), so early_nr_cpus_node() cannot be __meminit either.

WARNING: modpost: vmlinux.o(.text.unlikely+0x1612): Section mismatch in reference from the function arch_alloc_nodedata() to the function .meminit.text:compute_pernodesize()
The function arch_alloc_nodedata() references
the function __meminit compute_pernodesize().
This is often because arch_alloc_nodedata lacks a __meminit
annotation or the annotation of compute_pernodesize is wrong.

WARNING: modpost: vmlinux.o(.text.unlikely+0x1692): Section mismatch in reference from the function arch_refresh_nodedata() to the function .meminit.text:scatter_node_data()
The function arch_refresh_nodedata() references
the function __meminit scatter_node_data().
This is often because arch_refresh_nodedata lacks a __meminit
annotation or the annotation of scatter_node_data is wrong.

WARNING: modpost: vmlinux.o(.text.unlikely+0x1502): Section mismatch in reference from the function compute_pernodesize() to the function .meminit.text:early_nr_cpus_node()
The function compute_pernodesize() references
the function __meminit early_nr_cpus_node().
This is often because compute_pernodesize lacks a __meminit 
annotation or the annotation of early_nr_cpus_node is wrong.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-ia64@vger.kernel.org
---
 arch/ia64/mm/discontig.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20210409.orig/arch/ia64/mm/discontig.c
+++ linux-next-20210409/arch/ia64/mm/discontig.c
@@ -95,7 +95,7 @@ static int __init build_node_maps(unsign
  * acpi_boot_init() (which builds the node_to_cpu_mask array) hasn't been
  * called yet.  Note that node 0 will also count all non-existent cpus.
  */
-static int __meminit early_nr_cpus_node(int node)
+static int early_nr_cpus_node(int node)
 {
 	int cpu, n = 0;
 
@@ -110,7 +110,7 @@ static int __meminit early_nr_cpus_node(
  * compute_pernodesize - compute size of pernode data
  * @node: the node id.
  */
-static unsigned long __meminit compute_pernodesize(int node)
+static unsigned long compute_pernodesize(int node)
 {
 	unsigned long pernodesize = 0, cpus;
 
@@ -367,7 +367,7 @@ static void __init reserve_pernode_space
 	}
 }
 
-static void __meminit scatter_node_data(void)
+static void scatter_node_data(void)
 {
 	pg_data_t **dst;
 	int node;
