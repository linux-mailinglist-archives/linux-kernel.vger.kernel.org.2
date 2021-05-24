Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEC238EFB0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 17:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhEXP67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 11:58:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234508AbhEXPxE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 11:53:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 58A07616E8;
        Mon, 24 May 2021 15:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1621870755;
        bh=5BIjGO/HfJ+QLLHPRH0DK/giklItFH5er/uviNOaCb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ia+cuevf+h/o/Opv55ekTmQqqLbDUJhMNUwD639YtZTs424Z2nsk0ZxNp4TA7YU+A
         06YpBIC3Z30j589Ryp/3D81nnnAke6CxIHJ7x1Ddr8b0THgLBK+UyLp0Ii1YefPDOw
         VB+uwFFB7or1HGOLknDUBpXi0YA7LpbBeAtjs77g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@nvidia.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 005/104] RDMA/siw: Release xarray entry
Date:   Mon, 24 May 2021 17:25:00 +0200
Message-Id: <20210524152333.026054428@linuxfoundation.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210524152332.844251980@linuxfoundation.org>
References: <20210524152332.844251980@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit a3d83276d98886879b5bf7b30b7c29882754e4df ]

The xarray entry is allocated in siw_qp_add(), but release was
missed in case zero-sized SQ was discovered.

Fixes: 661f385961f0 ("RDMA/siw: Fix handling of zero-sized Read and Receive Queues.")
Link: https://lore.kernel.org/r/f070b59d5a1114d5a4e830346755c2b3f141cde5.1620560472.git.leonro@nvidia.com
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Bernard Metzler <bmt@zurich.ibm.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 11bd3205dbc6..34e847a91eb8 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -372,7 +372,7 @@ struct ib_qp *siw_create_qp(struct ib_pd *pd,
 	else {
 		/* Zero sized SQ is not supported */
 		rv = -EINVAL;
-		goto err_out;
+		goto err_out_xa;
 	}
 	if (num_rqe)
 		num_rqe = roundup_pow_of_two(num_rqe);
-- 
2.30.2



