Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA9434DD24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 02:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhC3AkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 20:40:12 -0400
Received: from sonic310-22.consmr.mail.gq1.yahoo.com ([98.137.69.148]:39021
        "EHLO sonic310-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230294AbhC3Ajw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 20:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1617064792; bh=3R1xhPrnPHD3kS4ZMACrkPZh2W/KwmHNvT4VFLspK4k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=gYrX5c6uQ2tqy1GzrI8ZFXKd893F2kHnfczRw2rDoz9zMwOE9wzRMJ+e9PuQuS4XPmsC4PAJ2Lq+fBhCge9tQUSa4J9eBfU0WrmRRarRADhfDLEe/fDT1RMslna65cb5FpC6Rx7DrLhPWrl7fQHaeM/uqSqiWLCinFV+n2PENSsF21Utyq8KwiJ9HrzREN+oQ6n87kPS5AaJVqXjeQ7b4Qnqi0mA07/EXJEyyoObHmmrKnYzISB6B/aTOrHvVDRJX+OhYrT/8yDtHug/omJdgxZNl+WBiSsdzCY3L6U4pVy5VvfWtw4PGcB/4bGP78rj1aTPo7qCFLDeqiXGmm2EjA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617064792; bh=3OcgE8oVPPcEIrAeH2TCS/x5nFNlkKcs4inGHunbW6Y=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=NOCQjPCxEtfEpCY1l2oqsJ0ET2R6GI5LH01KLmkuwVznKkcI/P1Rd3r6+FQawWk/EuwvpzaR49PsUih4Ph0dJulVEDUlE66KyJfCXwqx1GrscCkAKIhJcm9BnA7QPvUrTgbWgX+007RD8YHNPYFpyAvMC/7mvDUSz795nna+0tp5Tkmjjizompila5KAwAZLXkPh9/5RB5p6P0R7fPs/59xJobvb/KWDp/zzaNCF2zXv0H29EBcqm1+3EK4+jOzKIIe87ZjpHF/CXyQfpGSeihJ35p3VDRcqMiJPDka6Mpd+64lLhx+/lOicDJo0bh7JNOrz/JSCBT5wx/kQVD6R6Q==
X-YMail-OSG: BX1DYJgVM1nG7w_RURHCxJyrq9pk40t4u220yTIjbFYcBChVfVv.rfstCix_NfR
 g5kCiacpJR9isY76x_VVZF33xPk2OXDz4oqL2dGvybgdJJPKz4nJ9WFgUUfks.DFsw2q7aX9A3YW
 kxucS6m4pYPkkhvh_345VWpoIbIoaAUwRtgBEU3lSPkRQ3D_suYAI5NYoUcbJ.vY4E4QytoRPb58
 MIO6wPtnDHZElt3WUfoxyv2S.hogG_VhUi.2ZFyzFDmhl1jhSh7tqZcloaIkeeYQPqmQGagqD05T
 F51m7GYzB1C.6qWBiTp3uKdw1BT33pGotGU4fJeVhZub9CWkfslRdfCY22pQUrU6wLKMU2TAhGHL
 J8zNVi9ezOthRdYzkOEVBsa2pRlT.ljN4pA8eH6U8SigqbW1oBYfjaEMJkZkaupEIKiqOJw3cGzq
 BdcouxxBme6TSH_QeJgGTIujROISTVfhXr2roBwZXuW.RXlnPJWCTD5wRNPUBKV_G.OzDAbeix1c
 nGNzo6pbwSF7xbJWjThQdt9wYL0.lAhEXq2fWit4pNt0ehAtoLj89GY7xVK1o.e5utX4MFGxMrms
 1rWUQkNdhGlMKXULslNTGtQxO0CPL5TFgi5mGt.tnQRXRfBLiC5rjabYB9WKVpAqhWYir1i7izXx
 BFqvkblXpicbXa06FzdhIhLfBakLvZ8i4pGLmC4k3_GGkFQL4Sane9a2lULa78OLvomtXC3dsdlw
 1_jvS9apRRYRZ2DpproVk1quTRXYfRgX8I3X8cw4EhxWGIJEevT.yYDHMla8XpNI7lK0kJEzwwZX
 vamJ4L.Jhv9GoFJ2IzNXOtv06D2BxszXlfhsYBkiqW6yaniVDNY7q77GSlN5MGQQ6kxWdsJREeW3
 08N_2lLxLn_CDfnM2dxr8_yrweVItUeDiQ8TBJNeStIlomQ9p4j8LKfh.Chih6_1VM0DQOnbqUJb
 lVgmaGKDA8T4qqT8rwgRLcxfxrPy_DGOObMZZOkvFAVOk2OE8V5ciIOsjE6zs1Q_ETtiTMfWMuZg
 Ssglq0RNv0z5lrkjJ2dZ1nDYi7bxdgcvVhupN82o.f5XvTIJOuneAdFncVa1Izo16yd53ggrxhxj
 tzmzTniATiGi3h2M9HSKjcyjMxIW25_EaJb_vaMm15uy.NbFqr6TR6U27p8X92gc8VM76WP7Rw6h
 1hSJGZ8brRhPBlU8_wJHGp2dz580GlOkXzhbYgMJilxsgj9Ff8hRLbh0ha.6243ToEevvqP5w5ju
 CdcVkbHeGixUb2hadaSt.dSOa8snmWVyT.f2YwlQnHWXoULvCUqI7wk1RH8RnxY3vwYFPhfYM5xo
 OGhK8JpfojV0xm5_8tm.mLKyvwskteaKQs.fKregAzHkW.O_RcGPBPKSRnfoIunmUKxlbryiScVb
 sigHYRudpBke66CyYX8veXIu5Ldfi1Nig76FPxcFoWLnUSXl5KGwzRkPtkVUHJ6XrVS6b2bXNTUS
 AbH3NBKuTH.fp.HTEU6onHXl_0peQuI7WvKYPNV5HAM9efJYMaUgDprPCYYAUGIqZd1NcAynf1uM
 ej_7BKnYhA7fb7Qtqtr7zD4F8_ZyO_bdsuJNAgCvr2hhIi4Ii4wycut4sIvZH9p2m6ly1V_kSDtr
 DD5AHLb4Fc3p97OCeacLCMmP6sEZnvZkGTFV3JxPVOlaH2dIwTXkFJ7_XkC2DN9g.mryj_pHVyNd
 RnoitxLj4wYPrJGA9r7.JYjeRzqkeJ5pS_xQ4iK6_o7ZAVxK4g7IdloxG5w0Wsphd6hvSMveBPxD
 .Kw.pxIspmpOt_QwXT10DoQo4p3DgthHiltp7lBQ9dhpFiuIXur2TbSZbg04Kj9q1Mi5pESnN0eo
 .JkpFQFXNVwDl24414PI1tZ39UsFpBa3WJEi9HXeRDkghIYi3QorBrZrUWOUzHhR_5P8qKuWMuOt
 hg7S50vER4NpbrSRn25kRZTh.PAnvLiDRUygk3KK._LSaJvH4DrBi2x2oHG5iueIymgh601o1_AK
 Zhn7kQdI3lWZauCxtcMO44qbZjupAzmITlKy5z65I1TEgnEte69AX1rwjiLeK3X3pwDb2K62_e6h
 YyUzkSWpgVwQa5ZQEqj.TL6MRUPyocDf4w88_y7IvtwsHbSwhqhTjRQv2YrvbUz0h.WanQtcKzjq
 rtP0l_Rlm_KxR9RubT_8QM75QXXpzpuZhC3gZK3JIhOpddlKtj6l_3K4FHAyferCUYao3nckJRxy
 hSGxiFXqOpcdwoFXP0GohYlNP2qVF4oqs6SFjrdN8w7Qi9mRaCQ_3NhGEzQU3rD7fWOG.KBwxgxs
 vZGFSgkL2dx6uYQou8X7Rn_T64vGpCgJcUjSONCQsUbqmHyNf08EsVrd2iC8mLWrTh9R_gpd6GOa
 Gmlku.OQY26vcyYjd7kRUvQG3gqZX__O.I.FtIcPa.DKASiMFdxRFV4WyCQW6uxki1qazVxB27Gm
 UCgUcpXdL0baFC3bnmbTUcARphMckMVsy4S3MakqdLsYrzM7p7w8w0GS3kYcloCL_91o.4sizxP7
 B8L0VaOod_wK0Lby56a1sv7uI2RflntM1JWXisEIpGi9NmHREMfqNWOyCe_F6N3F8BG_H.g5w6Pq
 QYmEhiJF987RCb5pI53GuWUKtuDWlraLr3ihZA7loWZtMWi_UUVJmY5qMUb4b7sKl9dUAhoeJyrF
 rZEWAsO2oDk1wAOwdBHgDiXfd9i6tE0D9C8BEjQLjNL7rpxTapTdy7H1v5jeGNQAR5vAsYGd0iKq
 GmrPopFsJKmkVu_SDm5kWmZnVO3b3x_ustkwxOQVThG0ziQ9vyI46PHfWrjA3chSvu99vW1ITEW5
 dZrWAFnB0L5cUaSrBw80v9iifG5M_dQAl._GtPGGcNCONvBQK9ZSNswMoo7nn5AnLFQ5RNoU4Mlm
 ASAzLM9d5cHiumf8haGJOgYdpnuRHslr7y_mV3NwEaJO_wOIIpSYwJeVW825sfcv.HdmxWUsEXuI
 gJl43QVwW3ja4qwuWqmeXNvHxd0TwJ2k6qdU0cFankb41DBj4JHfF_HFmxdZwvzNQYLAt3SOYGxP
 9oXuo9FtJhJ74a.qB3tkXVJgikIB6nKujaZp_UTv8CgZwl08GjN_c2fJ9Qss_4JRiiB.rVEolOhr
 lUon0iZ3f4O.n9tOKpW228oN.tdZoJ_L3Pb00mAT6RuqHzqgx0ReyzMeSmXGnCLabrINCBMP4AFz
 5XXX6DI7HMVRarzwKF_Y-
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.gq1.yahoo.com with HTTP; Tue, 30 Mar 2021 00:39:52 +0000
Received: by kubenode579.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 27cc0a93ae52fff3a17931d8aba7bccb;
          Tue, 30 Mar 2021 00:39:48 +0000 (UTC)
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
Subject: [PATCH 06/10] erofs: adjust per-CPU buffers according to max_pclusterblks
Date:   Tue, 30 Mar 2021 08:39:04 +0800
Message-Id: <20210330003908.22842-7-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210330003908.22842-1-hsiangkao@aol.com>
References: <20210330003908.22842-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@redhat.com>

Adjust per-CPU buffers on demand since big pcluster definition is
available. Also, bail out unsupported pcluster size according to
Z_EROFS_PCLUSTER_MAX_SIZE.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/decompressor.c | 16 ++++++++++++----
 fs/erofs/internal.h     |  2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index fb4838c0f0df..5d9f9dbd3681 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -32,6 +32,7 @@ int z_erofs_load_lz4_config(struct super_block *sb,
 			    struct erofs_super_block *dsb,
 			    struct z_erofs_lz4_cfgs *lz4, int size)
 {
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	u16 distance;
 
 	if (lz4) {
@@ -40,16 +41,23 @@ int z_erofs_load_lz4_config(struct super_block *sb,
 			return -EINVAL;
 		}
 		distance = le16_to_cpu(lz4->max_distance);
+
+		sbi->lz4.max_pclusterblks = le16_to_cpu(lz4->max_pclusterblks);
+		if (sbi->lz4.max_pclusterblks >
+		    Z_EROFS_PCLUSTER_MAX_SIZE / EROFS_BLKSIZ) {
+			erofs_err(sb, "too large lz4 pcluster blocks %u",
+				  sbi->lz4.max_pclusterblks);
+			return -EINVAL;
+		}
 	} else {
 		distance = le16_to_cpu(dsb->u1.lz4_max_distance);
+		sbi->lz4.max_pclusterblks = 1;
 	}
 
-	EROFS_SB(sb)->lz4.max_distance_pages = distance ?
+	sbi->lz4.max_distance_pages = distance ?
 					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
 					LZ4_MAX_DISTANCE_PAGES;
-
-	/* TODO: use max pclusterblks after bigpcluster is enabled */
-	return erofs_pcpubuf_growsize(1);
+	return erofs_pcpubuf_growsize(sbi->lz4.max_pclusterblks);
 }
 
 static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index c4b3938a7e56..f1305af50f67 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -63,6 +63,8 @@ struct erofs_fs_context {
 struct erofs_sb_lz4_info {
 	/* # of pages needed for EROFS lz4 rolling decompression */
 	u16 max_distance_pages;
+	/* maximum possible blocks for pclusters in the filesystem */
+	u16 max_pclusterblks;
 };
 
 struct erofs_sb_info {
-- 
2.20.1

