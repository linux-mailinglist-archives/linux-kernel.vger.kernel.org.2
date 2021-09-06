Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA96401CF9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 16:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243228AbhIFOZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 10:25:48 -0400
Received: from smtpbg128.qq.com ([106.55.201.39]:41015 "EHLO smtpbg587.qq.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243181AbhIFOZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 10:25:47 -0400
X-QQ-mid: bizesmtp38t1630938260t4h85za2
Received: from localhost.localdomain (unknown [171.223.98.107])
        by esmtp6.qq.com (ESMTP) with 
        id ; Mon, 06 Sep 2021 22:24:19 +0800 (CST)
X-QQ-SSF: 01000000004000C0D000D00A0000000
X-QQ-FEAT: g9nl15ZGxljfoOlENwnUlRl4D911hd7+YUc9VSw/bAHddBK1BDYNP/fHFQRyJ
        xDpoLcRfETIJ79lwMDeuv7haFdWAYknnXQA/bAEGVBm7r3qlxz6Ea1at1YDRWbZGxzlNJS0
        HaY645VxGNuHo+Rti4sF/hwm45/j2445e8LFvaCKdgcWfc7u0S/meAsTZFwSedCKAZA7z4X
        6cvLaGdbws+UrzaQCc+kQbWXvQAFkJ5LEmsAky7OJtDz4Ft1Xz+GrTEn/1W2xNSO13gtOAZ
        93xXaj9z/dryzXot+lcxmQFqdy8rVtjZCY2LzERV1cKm2Hnzd32QRhxidr/n7GvESPuZwni
        B/J9vMep5bIGF4XWPdZ5yUQ2ic3cYyesrjGaJ3N
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     geert@linux-m68k.org
Cc:     arnd@arndb.de, linus.walleij@linaro.org, wangborong@cdjrlc.com,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: Add a missing SPDX license header
Date:   Mon,  6 Sep 2021 22:24:13 +0800
Message-Id: <20210906142413.130774-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing SPDX license header to arch/m68k/q40/q40ints.c.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 arch/m68k/q40/q40ints.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/m68k/q40/q40ints.c b/arch/m68k/q40/q40ints.c
index 6886a5d0007b..a0eb05079fdf 100644
--- a/arch/m68k/q40/q40ints.c
+++ b/arch/m68k/q40/q40ints.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * arch/m68k/q40/q40ints.c
  *
  * Copyright (C) 1999,2001 Richard Zidlicky
  *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive
- * for more details.
- *
  * .. used to be loosely based on bvme6000ints.c
  *
  */
-- 
2.33.0


