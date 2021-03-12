Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119B83386DD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 08:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231823AbhCLHwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 02:52:02 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:34034 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231889AbhCLHvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 02:51:49 -0500
Received: by sf.home (Postfix, from userid 1000)
        id 1F6DB5A22061; Fri, 12 Mar 2021 07:51:41 +0000 (GMT)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     linux-kernel@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH] ia64: tools: add generic errno.h definition
Date:   Fri, 12 Mar 2021 07:51:35 +0000
Message-Id: <20210312075136.2037915-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed missing header when build bpfilter helper:

    CC [U]  net/bpfilter/main.o
  In file included from /usr/include/linux/errno.h:1,
                   from /usr/include/bits/errno.h:26,
                   from /usr/include/errno.h:28,
                   from net/bpfilter/main.c:4:
  tools/include/uapi/asm/errno.h:13:10: fatal error:
    ../../../arch/ia64/include/uapi/asm/errno.h: No such file or directory
     13 | #include "../../../arch/ia64/include/uapi/asm/errno.h"
        |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CC: linux-kernel@vger.kernel.org
CC: netdev@vger.kernel.org
CC: bpf@vger.kernel.org
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 tools/arch/ia64/include/uapi/asm/errno.h | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/arch/ia64/include/uapi/asm/errno.h

diff --git a/tools/arch/ia64/include/uapi/asm/errno.h b/tools/arch/ia64/include/uapi/asm/errno.h
new file mode 100644
index 000000000000..4c82b503d92f
--- /dev/null
+++ b/tools/arch/ia64/include/uapi/asm/errno.h
@@ -0,0 +1 @@
+#include <asm-generic/errno.h>
-- 
2.30.2

