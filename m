Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEF32327E6E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235033AbhCAMdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:33:46 -0500
Received: from mail-m121143.qiye.163.com ([115.236.121.143]:56674 "EHLO
        mail-m121143.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbhCAMdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:33:43 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.250.176.228])
        by mail-m121143.qiye.163.com (Hmail) with ESMTPA id 670E2540212;
        Mon,  1 Mar 2021 20:32:53 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] mm: Return -EFAULT if copy_to_user() fails
Date:   Mon,  1 Mar 2021 20:32:43 +0800
Message-Id: <1614601963-25812-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZT0pPSk9JGB1ITk5CVkpNSk9NS0pCTEhNTktVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hNSlVLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Ohw6ASo*LT8LDxAOHkooAgg6
        LjBPCwJVSlVKTUpPTUtKQkxIQk1LVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5LVUpMTVVJSUNZV1kIAVlBSk5JSTcG
X-HM-Tid: 0a77edc6ef41b038kuuu670e2540212
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The copy_to_user() function returns the number of bytes remaining to be
copied, but we want to return -EFAULT if the copy doesn't complete.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index ab51132..a116e56
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1667,7 +1667,7 @@ COMPAT_SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
 	if (!err && nmask) {
 		unsigned long copy_size;
 		copy_size = min_t(unsigned long, sizeof(bm), alloc_size);
-		err = copy_from_user(bm, nm, copy_size);
+		err = copy_from_user(bm, nm, copy_size) ? -EFAULT : 0;
 		/* ensure entire bitmap is zeroed */
 		err |= clear_user(nmask, ALIGN(maxnode-1, 8) / 8);
 		err |= compat_put_bitmap(nmask, bm, nr_bits);
-- 
2.7.4

