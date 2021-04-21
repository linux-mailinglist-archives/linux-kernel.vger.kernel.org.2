Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F385E366B88
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbhDUNDP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:03:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:42502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240270AbhDUNC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:02:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9ADC561453;
        Wed, 21 Apr 2021 13:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619010145;
        bh=mlvgh/5X2D1SDew9xI2nRIFar8xphqWx4+ZFwrHlqKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A10whcluz9qOLJVlV8w2Gd6xh9H4/vjyw4h0dHk5tIai0cB0+Q4FebIcPjdMNB0J7
         p3I79RljSYz+BgA/83vawuTVAI0XBbNQ6nBkJwo4xV1jbAy4XYU+EBiKD145NkyLR2
         V58+1VRHSgp5pTyeG6dX/zwooH8wm6R5XDke2kno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 028/190] Revert "RDMA/rvt: Fix potential memory leak caused by rvt_alloc_rq"
Date:   Wed, 21 Apr 2021 14:58:23 +0200
Message-Id: <20210421130105.1226686-29-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 90a239ee25fa3a483facec3de7c144361a3d3a51.

Commits from @umn.edu addresses have been found to be submitted in "bad
faith" to try to test the kernel community's ability to review "known
malicious" changes.  The result of these submissions can be found in a
paper published at the 42nd IEEE Symposium on Security and Privacy
entitled, "Open Source Insecurity: Stealthily Introducing
Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
of Minnesota) and Kangjie Lu (University of Minnesota).

Because of this, all submissions from this group must be reverted from
the kernel tree and will need to be re-reviewed again to determine if
they actually are a valid fix.  Until that work is complete, remove this
change to ensure that no problems are being introduced into the
codebase.

Cc: https
Cc: Aditya Pakki <pakki001@umn.edu>
Cc: Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/rdmavt/qp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index 9d13db68283c..5476dd37e421 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -1207,7 +1207,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 		err = alloc_ud_wq_attr(qp, rdi->dparms.node);
 		if (err) {
 			ret = (ERR_PTR(err));
-			goto bail_rq_rvt;
+			goto bail_driver_priv;
 		}
 
 		if (init_attr->create_flags & IB_QP_CREATE_NETDEV_USE)
@@ -1317,10 +1317,8 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
 	rvt_free_qpn(&rdi->qp_dev->qpn_table, qp->ibqp.qp_num);
 
 bail_rq_wq:
-	free_ud_wq_attr(qp);
-
-bail_rq_rvt:
 	rvt_free_rq(&qp->r_rq);
+	free_ud_wq_attr(qp);
 
 bail_driver_priv:
 	rdi->driver_f.qp_priv_free(rdi, qp);
-- 
2.31.1

