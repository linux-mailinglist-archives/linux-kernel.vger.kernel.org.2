Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF2734DD25
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 02:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhC3Akd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 20:40:33 -0400
Received: from sonic316-55.consmr.mail.gq1.yahoo.com ([98.137.69.31]:33677
        "EHLO sonic316-55.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230333AbhC3AkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 20:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1617064800; bh=39SjLUG+F1MJ0MV+k8zJjnHyUTE2U7Arb3Ed5fZzMjg=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tp/Ee4LxHtbsluxl2Ys9d+sMZx+X+/cyjx8q3zrLeaJr3wsFsCGd15+kNulBgS3YaZaMyLr7eZXwioaaY7Lx/lPH7DVYyhVCVB1VkTxZtmNdYKu/HKAxt9AJ2eEBYZzMvsSqZ8kwBCT8iTlK+O+DkWrTv6g87WvkNZ4h/xPqA/bUK6R4P8PgZeSb2/KurPvRuz/KsXxeNbMbirLSZH+tRrRlk0M4WFFszAGUoqPhvnhHF/WSNPUgexOweckE3RkGcwDr3Ciux/ShzWAqZG2jdwINs7dRfMgCjLsIacKIj8zqunmG30wuGfy6DJ9rz8Vj8WKYkK94r0HwPj+Xf/+wlA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617064800; bh=lW/3Zp/6sa8+UfF0trP3bRZtK8QzktxAQz4brGaHw05=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=hxHalGVRvykbi8Jk6dPVLBEk/R6OoIp/HTPyLpDus7h9NemryR00bKPilx97MhGw2JfjODaydDQVGyWVgOJ8hm/RWFDb5BKVm0hPU9pkFs+2WFWGQ/myfuQc+OTkYp6IKhT9mskevXO4C6djH9iI3K5JHdkGKPz+YVpXYgVzAOI0XTaAJbSyCtkf7M+Unnu5OydsBLY5VkbBdVVtElkvUXF1J3cANTxUYPJpmuXeh8Y3rE1RyDmnUCdPmY7hsolqdO0q+hzSgKKdehFeKbYWzTExJ8KrrmCQAZUKa0W7tJFemCutXs/5GqNvEe+TyBKipEuMlUnN26r2+jPSlVL/bg==
X-YMail-OSG: 5RjiNy0VM1kZjFX_77G7tcYS8COELc3bzzsAQyq5rDpFG4TjT9WCJImgb9k8DYf
 cYaXFgvDU9mdh_.MQ3ewPoS9z44MquV3yd97yvUK.g6dXbkAIAmlGHMoN.3It6isogoO0iK5mmfW
 yqBFR4Uad1Psz__QBSymvmqG9u9AkfHijCVrVHX_h0Oj_3fBSwhNJgAY4WP..pKmVBb4qSZyrLIU
 PeWnCbsqAnMoJTHsc8z_1hMk8cbvv1arU2etyMskqsz2_ENexvHPNDNjdGRcXhT7h6pXcgsg9lr7
 EY0nyYArRyplEUjy_3FExUoF9tHRBf1WfV94U9XJwDxRjsPY7BJg6fiBFEfQN4TJdqjj2ZYAlv22
 S_b.8MMe_b7ZKzaAkElT9.Y6hpWvafeCC9v00rABgNEHFAD6yYoPlH5dLZdCsXnPlVEI2c1SShzR
 BZnkEqNVw2sMeMV7ioQ9tmkibEELf1dAGx_BXr8zYmEwLugR8I5gAjRythnvqzpiYxf.DdVVTuNc
 oSCV8e0t7lh2UzJ.k7W0TD5iXjx4ptJEd12oPfisT2LOZkGJNGuWrUwmLzzAf6f6vzhP0nwuWgTJ
 iUYrEhMz1zRlt.edy8dP7O.Na_zWMdk_JNjW03GyFCfQixkWN.lXDu5mTIDrSX1Ce8Ia12OD87Dh
 2XgT6HVBWLJenNpgh.nUOJccM2x47HZ7r5RL6LAkgLJrmdWfKwm1k6DmutgmYXwm4yYVcCsL3ewu
 oxY3VYfi5fo7bXYK0ckxyFWr6BPd9iXnRjScbD3FpicHJImlZp8j1eauNgY4cDG6N4BnkQ3pNyiv
 SIYaAwpUX.M0x6zAVcPwaJv.An4Lb5sjhjXr9M8C_YB.ZLhPM.siTUnNAE0ku.tJIpC1lw5MTXlj
 jT6jMpf0ys2NPboc47pqSqmbsBZS5u55mR9rZKhVsfGgAzizoM.yj8c.6YOyxmLIVM.SHUImHKK4
 DwLsnQnb.VvB7LZuk.8cNIqC_ByxTN5Kikxgm9ukTrCdP6HzcQcaHv_k.tXn1yz2IgPDc_MJqDMm
 00_fdpb814EhN8.lQDEqTpDlofEv19gAAu1Q.l6SaEjA8nuuEoJsLOExa8SQ8ov1Dst01NN.3fz4
 y5oN1uqJ59TDVOx7OVhvJE1FqHKcm2SsTi1.DF8sP.r0AUSWDUCHlQc.nge1GVT6aYBSiA78gkYj
 3zMP_310eNvSRk9IdhgFeuUfHs7uY7x3gVRB6bLnpf7v9JF7J6US6HU4zKXY4cRq2f32OiZto9BO
 kq31qvcWFQaVSdEW50O0oFksWUk8FlkOEcgjQxDTMGjECgHn72.nQTUAa5qlE.TP7z1InUD5uDSY
 UKmhlyDILLdPXtaTrF_e04F07aExk.mw6u4bj9GgsncnWMm2nrBoGb6kPz8nvqBPd3i5r9D3dYbR
 7agVa3_2RoBGFSbltp6kn_JXDmLg3VCFjnQF.Zh3a4oMGywuNkPfpVazcCvJLmzaQpIXlZYJ0z83
 EjU9DLzppdZUE78K6Zz3KZDqOM_UX2uQFz_98xjD2Jv9KRJxInaUHahpRcSOG5E99vTi3LwGoWr5
 YMnPbm5uEY0u5Fqg1NLBAejgFnM2tWAcuKc3R_7P._q04D6DV08Hh6Ix.uNQTinxECnmJrMrPnAq
 oqXI1SByKFjqHWQz79EzNiCs3.ColHYk_Wzn_VoG2z6a5oFw1GLNKgQekvWRyNqv8iiq_x4BEpoW
 EPFacrCgsuEuePB__vjWpAXRUERN3IBTURQXdtxK6IUTi.YGWgMXsHf7mMgKmVj7uDVqWOLEkBbq
 i9z2GWw0xRjp8wWn40VXgTI.G8T6DhVAtd_MyoG39OxqzrIvLYUeZ1yQ1ZLVmszZLRMIbtX_i8Qk
 1Aip_Arb8zD6NzOCNntFP7gDoDshGc6yDN8O76b.Dqd.4wHTZIwu7MtfrQlzQrFCOx_a45y5Tvfn
 59Q0FsKgWCOw6a9lMryyX3eR4PHPcg1RYnF07tRO1ArjigYkO955B1f7okW07qOliCCcY0aB6MyG
 SoY8Emcnnxb._wJ8HlZ6g5CnhuONmkw3u_EY5OtRb_pKUukcW_AmPx7nmK9Zo.0Co0CgAyJk8rLo
 _tn.Ljp6FheHcuDNj2BM3Xbw7oT0SMXDX3LHp3qQmej4YS_idvcs4NiyD7XeXLcYJrAM5pNZwR.o
 rrXFYZXfRv7BreYBPfd4uM7AxMmInz4c_h7C2qyN2crgtgMnvajlmi9FGO.FQMXT_NuuAW.QRnKB
 IixincULI26YVzKiNdlevBgJJoA7jkl.gPlIoBautovulKeT7AqnTFqmkOjfLV5qqo2.1rPbA8JP
 i0HMLxcT52.ioWxm4UGijMmF3ujDulsbLPrm6LwfJ_BtdhiZwvZJf6NcrL8vZzSvXaLjBXis.0se
 cgW07bYkNY8Pl26503I_FiWz1WSzfS9r0eJW8ABLfV_K1tFMyQhkkzk9VOJ2wvfZlZVuTqOYkk8a
 xERU_oIiBzlWu7hvRMcUEpQevLuVntg8vq69g9hn2rNkid.yoaRQ.UkBHQv7mNF45QdvQWffCoVW
 ut4v7YaiYTV5.mxxXbTH.Y5uRJG3ojzbOUG6zwiMasKYKBsFWOsrgUtHAGK.keFa4zhkEgI4q3Ts
 qI_0dt5Gh.pBNOXJEdmty0rxUfeIgpKT1hUD_alUD1CswZ7gKgVuRtbEkv1foeyc.zW.UZviz11B
 .etISzKu_GCukmollrLCqLo1xpklHAtp0gvCrJuv9rQel3rdVNr7VtUuEKXXiHZkjm3Zvx_InP0l
 FURQumEP.ns_lAfPAkcHYP9VznP.c1V6sBT1FTZXqXC0dDhczi9rbngLLrOkjc79vnW7OiGxKiEM
 dy57yniSfXxQurdc3N6OzdFupjX8_sBe4wuWst8jh01UgiKQgjguCXCA6SapGbMnK.TkEri0fzMN
 3pggZpey9xQR_wSN3dv.ZjTkWa_TnzN7wSm8ty6Lz5Q6n9rXIoQil9xEmriqcLzLaSdEzcc94Zb8
 87SF.3z_Aj5Eo89wSwN3Bqb08d4fs5UhtcfSLxRQkyZQWux9yXhi3cMW8WzBiP4bUdm6tPg0hGOy
 NJVhtvHorkyeRQvY0JMbrmgRs7NZe3KgYOUz4j54OGjYrtMpNRebmRTMpc2Mft39nOIfAorZ3rjx
 F1tXm.Usomm7bg8eVOiZRyMjZsP.QhA--
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Tue, 30 Mar 2021 00:40:00 +0000
Received: by kubenode579.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 27cc0a93ae52fff3a17931d8aba7bccb;
          Tue, 30 Mar 2021 00:39:58 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
        Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Fang Wei <fangwei1@huawei.com>,
        Guo Weichao <guoweichao@oppo.com>,
        Huang Jianan <huangjianan@oppo.com>,
        Lasse Collin <lasse.collin@tukaani.org>,
        Li Guifu <bluce.liguifu@huawei.com>,
        Miao Xie <miaoxie@huawei.com>, nl6720 <nl6720@gmail.com>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH 07/10] erofs: support parsing big pcluster compress indexes
Date:   Tue, 30 Mar 2021 08:39:05 +0800
Message-Id: <20210330003908.22842-8-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210330003908.22842-1-hsiangkao@aol.com>
References: <20210330003908.22842-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@redhat.com>

When INCOMPAT_BIG_PCLUSTER sb feature is enabled, legacy compress indexes
will also have the same on-disk header compact indexes to keep per-file
configurations instead of leaving it zeroed.

If ADVISE_BIG_PCLUSTER is set for a file, CBLKCNT will be loaded for each
pcluster in this file by parsing 1st non-head lcluster.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zmap.c | 79 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index bd7e10c2fdd3..d34ff810cc15 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -11,8 +11,10 @@
 int z_erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
-	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+	if (!erofs_sb_has_big_pcluster(sbi) &&
+	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
 		vi->z_advise = 0;
 		vi->z_algorithmtype[0] = 0;
 		vi->z_algorithmtype[1] = 0;
@@ -49,7 +51,8 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags))
 		goto out_unlock;
 
-	DBG_BUGON(vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
+	DBG_BUGON(!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
+		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
 
 	pos = ALIGN(iloc(EROFS_SB(sb), vi->nid) + vi->inode_isize +
 		    vi->xattr_isize, 8);
@@ -96,7 +99,7 @@ struct z_erofs_maprecorder {
 	u8  type;
 	u16 clusterofs;
 	u16 delta[2];
-	erofs_blk_t pblk;
+	erofs_blk_t pblk, compressedlcs;
 };
 
 static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
@@ -159,6 +162,15 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		m->clusterofs = 1 << vi->z_logical_clusterbits;
 		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
+		if (m->delta[0] & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+			if (!(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
+				DBG_BUGON(1);
+				return -EFSCORRUPTED;
+			}
+			m->compressedlcs = m->delta[0] &
+				~Z_EROFS_VLE_DI_D0_CBLKCNT;
+			m->delta[0] = 1;
+		}
 		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
 		break;
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
@@ -366,6 +378,58 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
 	return 0;
 }
 
+static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
+					    unsigned int initial_lcn)
+{
+	struct erofs_inode *const vi = EROFS_I(m->inode);
+	struct erofs_map_blocks *const map = m->map;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	unsigned long lcn;
+	int err;
+
+	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
+		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
+	if (!(map->m_flags & EROFS_MAP_ZIPPED) ||
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
+		map->m_plen = 1 << lclusterbits;
+		return 0;
+	}
+
+	lcn = m->lcn + 1;
+	if (m->compressedlcs)
+		goto out;
+	if (lcn == initial_lcn)
+		goto err_bonus_cblkcnt;
+
+	err = z_erofs_load_cluster_from_disk(m, lcn);
+	if (err)
+		return err;
+
+	switch (m->type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		if (m->delta[0] != 1)
+			goto err_bonus_cblkcnt;
+		if (m->compressedlcs)
+			break;
+		fallthrough;
+	default:
+		erofs_err(m->inode->i_sb,
+			  "cannot found CBLKCNT @ lcn %lu of nid %llu",
+			  lcn, vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+out:
+	map->m_plen = m->compressedlcs << lclusterbits;
+	return 0;
+err_bonus_cblkcnt:
+	erofs_err(m->inode->i_sb,
+		  "bogus CBLKCNT @ lcn %lu of nid %llu",
+		  lcn, vi->nid);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
+}
+
 int z_erofs_map_blocks_iter(struct inode *inode,
 			    struct erofs_map_blocks *map,
 			    int flags)
@@ -377,6 +441,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	};
 	int err = 0;
 	unsigned int lclusterbits, endoff;
+	unsigned long initial_lcn;
 	unsigned long long ofs, end;
 
 	trace_z_erofs_map_blocks_iter_enter(inode, map, flags);
@@ -395,10 +460,10 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 
 	lclusterbits = vi->z_logical_clusterbits;
 	ofs = map->m_la;
-	m.lcn = ofs >> lclusterbits;
+	initial_lcn = ofs >> lclusterbits;
 	endoff = ofs & ((1 << lclusterbits) - 1);
 
-	err = z_erofs_load_cluster_from_disk(&m, m.lcn);
+	err = z_erofs_load_cluster_from_disk(&m, initial_lcn);
 	if (err)
 		goto unmap_out;
 
@@ -442,10 +507,12 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	}
 
 	map->m_llen = end - map->m_la;
-	map->m_plen = 1 << lclusterbits;
 	map->m_pa = blknr_to_addr(m.pblk);
 	map->m_flags |= EROFS_MAP_MAPPED;
 
+	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
+	if (err)
+		goto out;
 unmap_out:
 	if (m.kaddr)
 		kunmap_atomic(m.kaddr);
-- 
2.20.1

