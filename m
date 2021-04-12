Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C4A35CD35
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 18:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245652AbhDLQe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 12:34:57 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49697 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243998AbhDLQ20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 12:28:26 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lVzPw-00086R-Sy; Mon, 12 Apr 2021 16:28:04 +0000
From:   Colin King <colin.king@canonical.com>
To:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@nvidia.com>,
        virtualization@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] vdpa/mlx5: Fix resource leak of mgtdev due to incorrect kfree
Date:   Mon, 12 Apr 2021 17:28:04 +0100
Message-Id: <20210412162804.1628738-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Static analysis is reporting a memory leak on mgtdev, it appears
that the wrong object is being kfree'd. Fix this by kfree'ing
mgtdev rather than mdev.

Addresses-Coverity: ("Resource leak")
Fixes: c8a2d4c73e70 ("vdpa/mlx5: Enable user to add/delete vdpa device")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index 10c5fef3c020..25533db01f5f 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -2089,7 +2089,7 @@ static int mlx5v_probe(struct auxiliary_device *adev,
 	return 0;
 
 reg_err:
-	kfree(mdev);
+	kfree(mgtdev);
 	return err;
 }
 
-- 
2.30.2

