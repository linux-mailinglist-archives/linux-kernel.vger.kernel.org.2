Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83251345E38
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230516AbhCWMdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:33:15 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59026 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbhCWMcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:32:54 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lOgDF-0007Om-UZ; Tue, 23 Mar 2021 12:32:46 +0000
From:   Colin King <colin.king@canonical.com>
To:     Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rakesh Babu <rsaladi2@marvell.com>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] octeontx2-af: Fix memory leak of object buf
Date:   Tue, 23 Mar 2021 12:32:45 +0000
Message-Id: <20210323123245.346491-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the error return path when lfs fails to allocate is not free'ing
the memory allocated to buf. Fix this by adding the missing kfree.

Addresses-Coverity: ("Resource leak")
Fixes: f7884097141b ("octeontx2-af: Formatting debugfs entry rsrc_alloc.")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
index 8ec17ee72b5d..9bf8eaabf9ab 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_debugfs.c
@@ -253,8 +253,10 @@ static ssize_t rvu_dbg_rsrc_attach_status(struct file *filp,
 		return -ENOSPC;
 
 	lfs = kzalloc(lf_str_size, GFP_KERNEL);
-	if (!lfs)
+	if (!lfs) {
+		kfree(buf);
 		return -ENOMEM;
+	}
 	off +=	scnprintf(&buf[off], buf_size - 1 - off, "%-*s", lf_str_size,
 			  "pcifunc");
 	for (index = 0; index < BLK_COUNT; index++)
-- 
2.30.2

