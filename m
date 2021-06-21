Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3AC3AEC36
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 17:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhFUPZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 11:25:13 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50931 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhFUPZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 11:25:11 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lvLlB-0001q5-GW; Mon, 21 Jun 2021 15:22:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     Richard Weinberger <richard@nod.at>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-mtd@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ubifs: Remove a redundant null check on pointer lp
Date:   Mon, 21 Jun 2021 16:22:49 +0100
Message-Id: <20210621152249.20901-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

An earlier fix to replace an IS_ERR check on lp with a null check
on lp didn't remove a following null check on lp. The second null
check is redundant and can be removed.

Addresses-Coverity: ("Logically dead code")
Fixes: c770cd5190ba ("ubifs: fix an IS_ERR() vs NULL check")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ubifs/gc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ubifs/gc.c b/fs/ubifs/gc.c
index 7cc22d7317ea..465beea52176 100644
--- a/fs/ubifs/gc.c
+++ b/fs/ubifs/gc.c
@@ -899,8 +899,6 @@ int ubifs_gc_start_commit(struct ubifs_info *c)
 			err = -ENOMEM;
 			goto out;
 		}
-		if (!lp)
-			break;
 		idx_gc = kmalloc(sizeof(struct ubifs_gced_idx_leb), GFP_NOFS);
 		if (!idx_gc) {
 			err = -ENOMEM;
-- 
2.31.1

