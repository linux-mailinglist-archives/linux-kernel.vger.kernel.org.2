Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1CB35B06A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 22:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235021AbhDJUai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 16:30:38 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:18771 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbhDJUah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 16:30:37 -0400
Received: from localhost.localdomain ([90.126.11.170])
        by mwinf5d28 with ME
        id r8WG2400C3g7mfN038WHrq; Sat, 10 Apr 2021 22:30:20 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Apr 2021 22:30:20 +0200
X-ME-IP: 90.126.11.170
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] crypto: crc32-generic - Use SPDX-License-Identifier
Date:   Sat, 10 Apr 2021 22:30:16 +0200
Message-Id: <c7fb3d1f92d95cedd74b5caff8dbfe2f16370814.1618086551.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use SPDX-License-Identifier: GPL-2.0-only, instead of hand writing it.

This also removes a reference to http://www.xyratex.com which seems to be
down.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 crypto/crc32_generic.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/crypto/crc32_generic.c b/crypto/crc32_generic.c
index 0e103fb5dd77..a989cb44fd16 100644
--- a/crypto/crc32_generic.c
+++ b/crypto/crc32_generic.c
@@ -1,26 +1,4 @@
-/* GPL HEADER START
- *
- * DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS FILE HEADER.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 only,
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License version 2 for more details (a copy is included
- * in the LICENSE file that accompanied this code).
- *
- * You should have received a copy of the GNU General Public License
- * version 2 along with this program; If not, see http://www.gnu.org/licenses
- *
- * Please  visit http://www.xyratex.com/contact if you need additional
- * information or have any questions.
- *
- * GPL HEADER END
- */
-
+// SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright 2012 Xyratex Technology Limited
  */
-- 
2.27.0

