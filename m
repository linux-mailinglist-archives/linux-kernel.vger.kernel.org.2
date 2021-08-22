Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A4D3F3D17
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 04:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhHVCOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 22:14:24 -0400
Received: from mx21.baidu.com ([220.181.3.85]:56240 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230346AbhHVCOY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 22:14:24 -0400
Received: from BJHW-Mail-Ex09.internal.baidu.com (unknown [10.127.64.32])
        by Forcepoint Email with ESMTPS id 9740B43D3CC45A7CADF2;
        Sun, 22 Aug 2021 10:13:39 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BJHW-Mail-Ex09.internal.baidu.com (10.127.64.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sun, 22 Aug 2021 10:13:39 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.62.12) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sun, 22 Aug 2021 10:13:38 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <paul@paul-moore.com>, <eparis@redhat.com>
CC:     <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>,
        Cai Huoqing <caihuoqing@baidu.com>
Subject: [PATCH] audit: Convert to SPDX identifier
Date:   Sun, 22 Aug 2021 10:13:15 +0800
Message-ID: <20210822021315.2045-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.32.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.31.62.12]
X-ClientProxiedBy: BC-Mail-Ex17.internal.baidu.com (172.31.51.11) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
X-Baidu-BdMsfe-DateCheck: 1_BJHW-Mail-Ex09_2021-08-22 10:13:39:642
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

use SPDX-License-Identifier instead of a verbose license text

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 kernel/auditsc.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8dd73a64f921..969c1613fed9 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* auditsc.c -- System-call auditing support
  * Handles all system-call specific auditing features.
  *
@@ -6,20 +7,6 @@
  * Copyright (C) 2005, 2006 IBM Corporation
  * All Rights Reserved.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- *
  * Written by Rickard E. (Rik) Faith <faith@redhat.com>
  *
  * Many of the ideas implemented here are from Stephen C. Tweedie,
-- 
2.25.1

