Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A929401CE2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243295AbhIFOTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:19:25 -0400
Received: from smtpbg604.qq.com ([59.36.128.82]:36501 "EHLO smtpbg604.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243274AbhIFOTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:19:24 -0400
X-QQ-mid: bizesmtp31t1630937894tqd3ljyf
Received: from localhost.localdomain (unknown [171.223.98.107])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 06 Sep 2021 22:18:13 +0800 (CST)
X-QQ-SSF: 01000000004000C0D000D00A0000000
X-QQ-FEAT: XIEqvPtYnoESALOqJM8zby0mGIqz+JW4HD8cM3RdTk9wNkcSl/5J2aDJY75zI
        MCLQ/xkZZxArEtT9hzUDA6nYw6eyoqhwO0sudSbb+ryApmJDfCf1ONugNf6k9O3a/JNwFYE
        94H1zdkH+MeaWhfLoejToczMH2hczljHRi1UxSQC1sc0ltuoNmGHK1oa4VzCh8hrACkZVWn
        AFIk/JlQr7WOVSrYPZ9Yyyn0ZtX1zcEtU00i4uxVSPF2ZYA5phFdmbx+NRaz/ATLI4dw38Z
        xXeHIUXpzeFTxRSl9gd6ArjLvaKK0BawO7keW9PhnAXb0FSG5lIgK5+l3eev5EoM9zralns
        UJ9GJTgyaSafe52E4s/XIlSXuKXV7W2s8YJLlDy
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     ysato@users.sourceforge.jp
Cc:     wangborong@cdjrlc.com, uclinux-h8-devel@lists.sourceforge.jp,
        linux-kernel@vger.kernel.org
Subject: [PATCH] h8300: Add a missing SPDX license header
Date:   Mon,  6 Sep 2021 22:17:58 +0800
Message-Id: <20210906141758.125382-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing SPDX license header to arch/h8300/kernel/kgdb.c.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/h8300/kernel/kgdb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/h8300/kernel/kgdb.c b/arch/h8300/kernel/kgdb.c
index 602e478afbd5..0a1b6d41ec67 100644
--- a/arch/h8300/kernel/kgdb.c
+++ b/arch/h8300/kernel/kgdb.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * H8/300 KGDB support
  *
-- 
2.33.0

