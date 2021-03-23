Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638B334562F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 04:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbhCWDYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 23:24:37 -0400
Received: from mail-m17637.qiye.163.com ([59.111.176.37]:44338 "EHLO
        mail-m17637.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbhCWDYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 23:24:13 -0400
Received: from wanjb-virtual-machine.localdomain (unknown [36.152.145.182])
        by mail-m17637.qiye.163.com (Hmail) with ESMTPA id 4B3B3980567;
        Tue, 23 Mar 2021 11:23:53 +0800 (CST)
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] mm: process_vm_access: Remove duplicate include of compat.h
Date:   Tue, 23 Mar 2021 11:23:22 +0800
Message-Id: <20210323032322.262579-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZSE5NSEJJSkIfSRhCVkpNSk1PTUJDT0tPTEpVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzY6ITo*Kz8TODpLIyw2SCEP
        FEhPCwFVSlVKTUpNT01CQ09JSU5JVTMWGhIXVQwaFRESGhkSFRw7DRINFFUYFBZFWVdZEgtZQVlI
        TVVKTklVSk9OVUpDSVlXWQgBWUFKT0tONwY+
X-HM-Tid: 0a785d1c4e8fd992kuws4b3b3980567
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux/compat.h has been included at line 8.So we remove 
the duplicate one at line 12.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 mm/process_vm_access.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/process_vm_access.c b/mm/process_vm_access.c
index f5fee9cf90f8..4bcc11958089 100644
--- a/mm/process_vm_access.c
+++ b/mm/process_vm_access.c
@@ -9,7 +9,6 @@
 #include <linux/mm.h>
 #include <linux/uio.h>
 #include <linux/sched.h>
-#include <linux/compat.h>
 #include <linux/sched/mm.h>
 #include <linux/highmem.h>
 #include <linux/ptrace.h>
-- 
2.25.1

