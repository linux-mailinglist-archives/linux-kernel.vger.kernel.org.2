Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAFC40A4A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 05:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239165AbhINDfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 23:35:20 -0400
Received: from mx20.baidu.com ([111.202.115.85]:56090 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239185AbhINDfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 23:35:06 -0400
Received: from BC-Mail-Ex22.internal.baidu.com (unknown [172.31.51.16])
        by Forcepoint Email with ESMTPS id DAF5B42F58B5B2CC6978;
        Tue, 14 Sep 2021 11:33:45 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex22.internal.baidu.com (172.31.51.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 14 Sep 2021 11:33:45 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Tue, 14 Sep 2021 11:33:45 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>,
        <linux-audit@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] audit: Convert to SPDX identifier
Date:   Tue, 14 Sep 2021 11:33:38 +0800
Message-ID: <20210914033339.134-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BJHW-Mail-Ex10.internal.baidu.com (10.127.64.33) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SPDX-License-Identifier instead of a verbose license text.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
v1->v2: Change recommended token from "GPL-2.0+" to "GPL-2.0-or-later"

 kernel/auditsc.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8dd73a64f921..969c1613fed9 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
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

