Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24C444F0EB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Nov 2021 04:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhKMDGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 22:06:25 -0500
Received: from smtpbg128.qq.com ([106.55.201.39]:62504 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232113AbhKMDGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 22:06:22 -0500
X-QQ-mid: bizesmtp32t1636772602ta95ix04
Received: from localhost.localdomain (unknown [125.69.41.88])
        by esmtp6.qq.com (ESMTP) with 
        id ; Sat, 13 Nov 2021 11:03:20 +0800 (CST)
X-QQ-SSF: 01000000000000C0F000B00A0000000
X-QQ-FEAT: dpyQmELDBxG1OItickMQYTESO2OdECCehQIMsi2B1turkahKi08atFxdHOtMG
        Ex0eWfL00C0aKle3wwz032vaTrcqXyP9T7ZKkh4Qq2WDC/XzJxTHrgtOGnbx5keq91MsilD
        iVftgjVsVGzH4MuPstdMNI3Y+H976jhoksqhAAlIAHfZ92QtAdtPE8f24FWa8OsbVjoqRCC
        wxvBVnpEhKbcVdWwr3rymcvBO5jt8LPJWBFJ0J/DS/o00p6rE7RFkKAIujPIgyKx4mi/jzV
        a345drR+gx3KneRvBAae9HpfZsz4oqFAvtqOF2Qqj/dPkFtuCo1htMCHAcj+GTvmSaUmydN
        ZtefdUS
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     ardb@kernel.org
Cc:     linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] ia64: Fix typo in a comment
Date:   Sat, 13 Nov 2021 11:03:16 +0800
Message-Id: <20211113030316.22650-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' in a comment is repeated, thus it should be removed.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/ia64/kernel/uncached.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/uncached.c b/arch/ia64/kernel/uncached.c
index 51883a66aeb5..816803636a75 100644
--- a/arch/ia64/kernel/uncached.c
+++ b/arch/ia64/kernel/uncached.c
@@ -171,7 +171,7 @@ static int uncached_add_chunk(struct uncached_pool *uc_pool, int nid)
  * @n_pages: number of contiguous pages to allocate
  *
  * Allocate the specified number of contiguous uncached pages on the
- * the requested node. If not enough contiguous uncached pages are available
+ * requested node. If not enough contiguous uncached pages are available
  * on the requested node, roundrobin starting with the next higher node.
  */
 unsigned long uncached_alloc_page(int starting_nid, int n_pages)
-- 
2.33.0

