Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F8D356297
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 06:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234031AbhDGEjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 00:39:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhDGEjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 00:39:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CE665613C2;
        Wed,  7 Apr 2021 04:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617770375;
        bh=YrRCGXJu60FHZKCdIPVUIJLofjXfL30/Oc+uXMU8P/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJbr5wrsjYnAW8cHz5BnfqySdMLhtS2fqYPJogZUcCVMx4TbD6xoIhCzBIiexv9Eu
         hQzfvoalqkN2uheviDOy8VJzhbFlRDl2O4xdrJfHPTnQzkJl+0+fJlWz47oOULU5nl
         gICo3NC710KmRFSfvDysp4TDMUNkbV9J3kwdP2owztKT3kQjaJrNVtgQpNUkGGtVeE
         Tq/ZNLwiiZd7NksgAc+Egod1O8IaMkDA65L6VrPwODo6log/iidFVVDCnuwbXKj1kJ
         Zd6b5XxkXGsJO7k7FVyITWqoLHovOkYHDmTtVroxhfAOwV/dvWWRX+e17ZL+4Zbkkb
         MUrjbgMtcCd7w==
From:   Gao Xiang <xiang@kernel.org>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v3 01/10] erofs: reserve physical_clusterbits[]
Date:   Wed,  7 Apr 2021 12:39:18 +0800
Message-Id: <20210407043927.10623-2-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210407043927.10623-1-xiang@kernel.org>
References: <20210407043927.10623-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@redhat.com>

Formal big pcluster design is actually more powerful / flexable than
the previous thought whose pclustersize was fixed as power-of-2 blocks,
which was obviously inefficient and space-wasting. Instead, pclustersize
can now be set independently for each pcluster, so various pcluster
sizes can also be used together in one file if mkfs wants (for example,
according to data type and/or compression ratio).

Let's get rid of previous physical_clusterbits[] setting (also notice
that corresponding on-disk fields are still 0 for now). Therefore,
head1/2 can be used for at most 2 different algorithms in one file and
again pclustersize is now independent of these.

Acked-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/erofs_fs.h |  4 +---
 fs/erofs/internal.h |  1 -
 fs/erofs/zdata.c    |  3 +--
 fs/erofs/zmap.c     | 15 ---------------
 4 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 17bc0b5f117d..626b7d3e9ab7 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -233,9 +233,7 @@ struct z_erofs_map_header {
 	__u8	h_algorithmtype;
 	/*
 	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
-	 * bit 3-4 : (physical - logical) cluster bits of head 1:
-	 *       For example, if logical clustersize = 4096, 1 for 8192.
-	 * bit 5-7 : (physical - logical) cluster bits of head 2.
+	 * bit 3-7 : reserved.
 	 */
 	__u8	h_clusterbits;
 };
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 60063bbbb91a..05b02f99324c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -266,7 +266,6 @@ struct erofs_inode {
 			unsigned short z_advise;
 			unsigned char  z_algorithmtype[2];
 			unsigned char  z_logical_clusterbits;
-			unsigned char  z_physical_clusterbits[2];
 		};
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	};
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 4226f4115981..e3f0100d82d1 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -430,8 +430,7 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
 	else
 		pcl->algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
 
-	pcl->clusterbits = EROFS_I(inode)->z_physical_clusterbits[0];
-	pcl->clusterbits -= PAGE_SHIFT;
+	pcl->clusterbits = 0;
 
 	/* new pclusters should be claimed as type 1, primary and followed */
 	pcl->next = clt->owned_head;
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index b384f546d368..7fd6bd843471 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -17,11 +17,8 @@ int z_erofs_fill_inode(struct inode *inode)
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
 		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
-		vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits;
-		vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits;
 		set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
 	}
-
 	inode->i_mapping->a_ops = &z_erofs_aops;
 	return 0;
 }
@@ -77,18 +74,6 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	}
 
 	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
-	vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits +
-					((h->h_clusterbits >> 3) & 3);
-
-	if (vi->z_physical_clusterbits[0] != LOG_BLOCK_SIZE) {
-		erofs_err(sb, "unsupported physical clusterbits %u for nid %llu, please upgrade kernel",
-			  vi->z_physical_clusterbits[0], vi->nid);
-		err = -EOPNOTSUPP;
-		goto unmap_done;
-	}
-
-	vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits +
-					((h->h_clusterbits >> 5) & 7);
 	/* paired with smp_mb() at the beginning of the function */
 	smp_mb();
 	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
-- 
2.20.1

