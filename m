Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48210358D54
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 21:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232403AbhDHTPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 15:15:42 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:48756 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231451AbhDHTPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 15:15:41 -0400
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Thu, 8 Apr 2021 12:15:26 -0700
Received: from vertex.vmware.com (unknown [10.16.120.5])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id B9945211E8;
        Thu,  8 Apr 2021 12:15:29 -0700 (PDT)
From:   Zack Rusin <zackr@vmware.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
        <linux-mm@kvack.org>
Subject: [PATCH] mm/mapping_dirty_helpers: Guard hugepage pud's usage
Date:   Thu, 8 Apr 2021 15:15:29 -0400
Message-ID: <20210408191529.677958-1-zackr@vmware.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (EX13-EDG-OU-002.vmware.com: zackr@vmware.com does not
 designate permitted sender hosts)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lets make sure we don't use pud hugepage helpers on architectures
which do not support it. This fixes the code on arm64.

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

