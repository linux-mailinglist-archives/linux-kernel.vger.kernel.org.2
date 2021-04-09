Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D0735A406
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234224AbhDIQwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:52:11 -0400
Received: from ex13-edg-ou-001.vmware.com ([208.91.0.189]:3092 "EHLO
        EX13-EDG-OU-001.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233038AbhDIQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:52:08 -0400
Received: from sc9-mailhost3.vmware.com (10.113.161.73) by
 EX13-EDG-OU-001.vmware.com (10.113.208.155) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 9 Apr 2021 09:51:48 -0700
Received: from vertex.localdomain (unknown [10.16.119.23])
        by sc9-mailhost3.vmware.com (Postfix) with ESMTP id 4078520DB0;
        Fri,  9 Apr 2021 09:51:52 -0700 (PDT)
From:   Zack Rusin <zackr@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        <linux-mm@kvack.org>
Subject: [PATCH v2] mm/mapping_dirty_helpers: Guard hugepage pud's usage
Date:   Fri, 9 Apr 2021 12:51:51 -0400
Message-ID: <20210409165151.694574-1-zackr@vmware.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (EX13-EDG-OU-001.vmware.com: zackr@vmware.com does not
 designate permitted sender hosts)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mapping dirty helpers have, so far, been only used on X86, but
a port of vmwgfx to ARM64 exposed a problem which results
in a compilation error on ARM64 systems:
mm/mapping_dirty_helpers.c: In function ‘wp_clean_pud_entry’:
mm/mapping_dirty_helpers.c:172:32: error: implicit declaration of function ‘pud_dirty’; did you mean ‘pmd_dirty’? [-Werror=implicit-function-declaration]

This is due to the fact that mapping_dirty_helpers code assumes
that pud_dirty is always defined, which is not the case for
architectures that don't define CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD.

ARM64 arch is a little inconsistent when it comes to PUD
hugepage helpers, e.g. it defines pud_young but not pud_dirty
but regardless of that the core kernel code shouldn't assume
that any of the PUD hugepage helpers are available unless
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD is defined. This
prevents compilation errors whenever one of the drivers
is ported to new architectures.

Signed-off-by: Zack Rusin <zackr@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Hellström (Intel) <thomas_os@shipmail.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
---
 mm/mapping_dirty_helpers.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mapping_dirty_helpers.c b/mm/mapping_dirty_helpers.c
index b59054ef2e10..b890854ec761 100644
--- a/mm/mapping_dirty_helpers.c
+++ b/mm/mapping_dirty_helpers.c
@@ -165,10 +165,12 @@ static int wp_clean_pud_entry(pud_t *pud, unsigned long addr, unsigned long end,
 		return 0;
 	}
 
+#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
 	/* Huge pud */
 	walk->action = ACTION_CONTINUE;
 	if (pud_trans_huge(pudval) || pud_devmap(pudval))
 		WARN_ON(pud_write(pudval) || pud_dirty(pudval));
+#endif
 
 	return 0;
 }
-- 
2.27.0

