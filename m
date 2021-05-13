Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F14B37F6EE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 13:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhEMLlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 07:41:21 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:32836 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbhEMLlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 07:41:16 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lh9h7-0007eb-Ko; Thu, 13 May 2021 11:39:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        ocfs2-devel@oss.oracle.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: remove redundant assignment to pointer queue
Date:   Thu, 13 May 2021 12:39:57 +0100
Message-Id: <20210513113957.57539-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer queue is being initialized with a value that is never read
and it is being updated later with a new value. The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ocfs2/dlm/dlmmaster.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/dlm/dlmmaster.c b/fs/ocfs2/dlm/dlmmaster.c
index 4960a6de768d..9b88219febb5 100644
--- a/fs/ocfs2/dlm/dlmmaster.c
+++ b/fs/ocfs2/dlm/dlmmaster.c
@@ -2977,7 +2977,7 @@ static u8 dlm_pick_migration_target(struct dlm_ctxt *dlm,
 				    struct dlm_lock_resource *res)
 {
 	enum dlm_lockres_list idx;
-	struct list_head *queue = &res->granted;
+	struct list_head *queue;
 	struct dlm_lock *lock;
 	int noderef;
 	u8 nodenum = O2NM_MAX_NODES;
-- 
2.30.2

