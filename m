Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C8C345614
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhCWDOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:14:49 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:56528 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbhCWDOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:14:21 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id A79129805E2;
        Tue, 23 Mar 2021 11:14:05 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] include: linux: Remove duplicate include of pgtable.h
Date:   Tue, 23 Mar 2021 11:13:52 +0800
Message-Id: <20210323031352.258587-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHUkaH01NTEMdGB4dVkpNSk1PTUJJTklJSENVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDo6Nww5Ez8XFjowIz4dAywd
        F0gaChhVSlVKTUpNT01CSU5JQ0NKVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKTk5INwY+
X-HM-Tid: 0a785d135535d992kuwsa79129805e2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/pgtable.h has been included at line 11 with annotation.
So we remove the duplicate one at line 8.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 include/linux/crash_dump.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
index a5192b718dbe..be79a45d7aa3 100644
--- a/include/linux/crash_dump.h
+++ b/include/linux/crash_dump.h
@@ -5,7 +5,6 @@
 #include <linux/kexec.h>
 #include <linux/proc_fs.h>
 #include <linux/elf.h>
-#include <linux/pgtable.h>
 #include <uapi/linux/vmcore.h>
 
 #include <linux/pgtable.h> /* for pgprot_t */
-- 
2.25.1

