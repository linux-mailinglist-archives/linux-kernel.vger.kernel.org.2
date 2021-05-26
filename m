Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1E4391314
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 10:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbhEZIzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 04:55:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50994 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbhEZIzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 04:55:11 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1llpIJ-0001Yn-JM; Wed, 26 May 2021 08:53:39 +0000
From:   Colin King <colin.king@canonical.com>
To:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>, cluster-devel@redhat.com
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] fs: dlm: Fix spelling mistake "stucked" -> "stuck"
Date:   Wed, 26 May 2021 09:53:39 +0100
Message-Id: <20210526085339.6604-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistake in log messages. Fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/dlm/midcomms.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/dlm/midcomms.c b/fs/dlm/midcomms.c
index 35664950f6b7..4e36e418b6bf 100644
--- a/fs/dlm/midcomms.c
+++ b/fs/dlm/midcomms.c
@@ -591,7 +591,7 @@ dlm_midcomms_recv_node_lookup(int nodeid, const union dlm_packet *p,
 					 * was failed, we try to reset and
 					 * hope it will go on.
 					 */
-					log_print("reset node %d because shutdown stucked",
+					log_print("reset node %d because shutdown stuck",
 						  node->nodeid);
 
 					midcomms_node_reset(node);
@@ -1159,7 +1159,7 @@ void dlm_midcomms_add_member(int nodeid)
 			 * was failed, we try to reset and
 			 * hope it will go on.
 			 */
-			log_print("reset node %d because shutdown stucked",
+			log_print("reset node %d because shutdown stuck",
 				  node->nodeid);
 
 			midcomms_node_reset(node);
-- 
2.31.1

