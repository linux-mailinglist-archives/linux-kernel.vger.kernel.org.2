Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F4534DD23
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 02:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbhC3AkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 20:40:10 -0400
Received: from sonic304-25.consmr.mail.gq1.yahoo.com ([98.137.68.206]:40475
        "EHLO sonic304-25.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230282AbhC3Ajs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 20:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1617064788; bh=iuJBVPpQ5ElO59vCLfLHjpWmk89MW1gH4S5F1FEmjs4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=l1fCi3WaddON9gjeylHNiqJEu4zW+I1pEoO/OBZ/DdExFu8492z4G7PN/DCV0yv9+q/MaEQijhgyUpCbJckmpKUI8+H4WPZ1vqcC65VIK84llyXJ3+5WOT78ASlzm7XjzjjoOmilzOAsseTblHYQvZR86OMgMBlo/8D6n1M1CASdFlZCWbNYjJPHH9swd8elxX5yZ5T8mGLsuS/UhTdbawkdW3oiwCJkD3NGo83SmLu/E0M74je48MSCuJOeZGaQrCbloX7KsHA370VvcKqQrhOQaO3Qh9C2ooaisoML/hiA3WGIcV7JxA3LWMws2/RyZ8e2dqHSG1nuoJARUMEQLQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1617064788; bh=ubXOObk6gZyRygVpgbqBCjf/A8tD5zaVHvEMzLvLETE=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=EDh7USgHR4J+PdVzrwawSVtMC38ihycUXEx/Cxngy8RLFzOeGxcx1xw4kBpFqkAgHktovB7+hOBdxG9hp1R8STJtz3HztB/8OOytnouXv+EF74vjecZ2/CI5LX8QBI7EFX207AYAqNsBb1SrPWp9teYqDZ6yWF/yuGzrTYm78j6nt4Z91lxi3zevfdGwKNf/5IeU766MBB5yNS1PV5qEsUFqkzWAn2RTjICEGXqkfkjsjbr+2bxHiEaV/dnPI4sCkjFZ0fUt5c6jIoHhR9RdxePxGTH5QnrTaMSBAhg73ew2xMqhPxKTse78g5wBCQD2f4wMSNppodxsxMnpkaJYjw==
X-YMail-OSG: csn7918VM1lJXOSklyWkUnDb74qUTbvYM_haal5JMdrQIjdbGGRL4CRT4lhFJFm
 HYPPOdFw3AUkTzhixti2N8Gfmbe5b6Cr7WxmTR6zdNYIqlUhEn.pS50Gtl_ue_fFIFcfprR449jx
 s32lE2KkxXK.rQHOCCqjTCOPmTjm2mdNYIJx.gg1RFQhZHGx3Nla9UqO5EjaNhp2nSnJw85eQ0SQ
 zNIxg3xUCuxJ7Y5jwid9MDXSmax7fifRCMvcGBPUpLEhxUKjx64fYoS..7l5XFo6dFJ.KGiTgIS2
 O0P0tHPX92s0KtDsQo7rhqctD7M6Hi8SZQuMwNaR90s17KgqaElg44gIzak1J8CXcfne7p3rDmbK
 g.k_1Wdmw.gFXYtUAcg8fh.muXSW0hPtaDgefrwlC8i6bFh1wAnE9hG15eDUzCd2JV2.XrTtmOOs
 zyF.pfyapbj2hw2zaVEoZ_4cnd1kTphKo__5ainObBikcO0lz_zODUIa1VKpYU_9wlRf0IBnLYER
 pUULWIqQlnu0QJPU68dWPmUKJ99GC_KIxZ4VjpSQFRlb7x5lnG3KDLDf2_.9lGmGs8bepcuFn79e
 f9B0sNiAcaszGdyNkj4ZnNzKQHuME.GgTDCb.B8A1PqD9tA1FmDDs5NM0JnP4zRM_9jEz7yqnGpO
 Y2AnrqQhQu5ToLxWlQgCw4dmJpvSNSnwudRzpdgo.rcwyeE.wtTCf1TvrKgnmSSL9iyOnXuYv1cd
 SUpuDgDRlThZh.64HTrksRyHeQZnpjXpNxDVnS5IyiibafUVkawvkEIL98vrQyRqe9ij3GF5tSSd
 zWd7FpPB.1CCuvL9AZAYFphQEB7DtcbbjuejmrRXQ0FhY0GbYugc_Ib2VYwQZGxcNilr7QVQbUNS
 XZH3p5e6RjVCk9vkitHH.PD7T72DQFsFf2.LI1BGhza98vwJxs4Tjr692DlJV5LuEqnWpGfkn_1R
 G0PXHvbLtFjBgL8Yz66HQw_EVr7EbjUKsyD2jisc0xvHkVLemQ2QjccJfnE9H75KjuYv7IIgl5vG
 a.m9OYv9tPw.epFi5GldZcf5ch2v0_0Tfq0nmHkvJGawc5SuvlEUiCCia5E5JXjncbKRMi_5N77C
 KGwH2qHyMnKcqym417bqqIkZfhKE37Cs1hTToM9hwRX06u_OU2PDaKWebMxt5eUOAsmexXtt.yFd
 j0TbfhXnUv_4uaSxuypTIbwBlGW.hcyTv8vyWul94eke578NVu6TVXK8pFOeSa7jyd2luzzIWlip
 axSz62I3HSURgR0L8kZkDjdl7gMk8yQ3.ZwUJpLzb7CvjFW5HNpDacrlMYdO1ISaQKDI0vIsRhJI
 BPMyD6l5paWgGKzXoChWXydiGxSNG3ULv9LHVnFFyet.lNUs6.X3xJCrCGB6sZjpLJRxU84RJPPo
 G44Iy4GQY5ptv4yufdxGRRj6uXm1f4YkktI.7EPgSpxFz6aIVsr2Rgv_ln8JdvWFfqDf8mbv6Ttw
 P68JzXZDMlBNq6ykXNFd6dHs0l4zqUGDd7Ud46v3.3XepqgUqvTLDBuEco2TrPDlNTjachMktRhk
 RifM9UCB2i191JM5.uLeAcFmIwuIjeWSZCxvWAJYywLdQughXUz5MWZ3Xfep4M_QjLp2nCMpQmf2
 fYbp1qOOuqQR_uxRCzs5O.H7bBMIF5m00jmKUliPrD2rFIMyN34YqG3zRJokwUbO5tSrHL2hZQJB
 x3AvDThI3p4Y24KnLYBwoOtIwYHuHENZb4wedSnWFYV60irCwDXAKl2f.N88r1TzxBrUl1mUzLKO
 3mX2Q1ZXg6UoHISCWzIUrOwJ13l9PEDOz0.LIH6O3_c7IZ221GI8_AZrYRfi_zzkhqFV3mxfld_K
 VYgb8jNCDWjipuNvUwOQR4nWUWx7oj__OR8V8lkYIhsU_zSlYDSW8rTndDjTjdqZUuZG73Xuegrs
 aIx94Dz9PSpoE_3UlLs9w_F2JQ.hygyRJ7cti9p0Wys7JEF8MndZwnfsXQgu9teWx1Axw6P3.Cv4
 VfHP9s4jdnDn0v3ozOU3qVbb4wEisSPd1fuqe_qp4VC48vo2O5UuXZrxmwLPWqIZKYsgYU9SOyA8
 pRrxenSYjfddY1wWFgmQqhpOEltS7uth6zd2HyPwFtjKW_2VpEMGcqdpyYGeomv884bOqzi.prET
 R.8UBBTwfsXhjHfh.7EixlBpBMpNEkveeHBIBWmY3JIOUxYkKypQldj62IurSlUwMwEiOtQJmUli
 i._b4xCSBbJJpGSHf.xQI8xmXmolKiZhsPC1W7L5EIFxta9UnCttpfKc81lCoR3tTsU58Ctmmrk3
 wTWGF.1UtBYnzT0eFIMu9kISrQaFl5gvqTtI0.deEmCUPVjc0wS4UpKdCTYSDtXIsmi9qdqBmdtg
 .wvIC9QLBqa4JrChEP8XrbbmVfD2nJOpAW3a0d5GgsI9L._lkC206ge5pyMxdEqTdSJmjS1hCfyz
 psixd5nG0P9eHZMgUBA4GMIActyyQ.xxpUwzSvS4rl2u6kRntUWWfu2izeSLd.k7b39CqJ9UMoSK
 TxZ5GO4nil5wdUirIt16ROGJBrK9jMfLKD5ja9VRC0fjqca8.ReiZITiU9J2mtE2dOJ.quHhFSnG
 kMuyeKUhMXKPPhM3bQyrAknwVGfYf8Y39Npze_9Nh9rnBzL6ehcGzobB5CeaQoXq4GWbDSf25Tub
 IL3h8NyQci8jG3hGoM7EW5j8oBepicWT7azP0i0wTegIYIEVqDAfOk8xO.FajnPouS93Rag.XoEU
 OFqIQSFOoogNSEKmbxXaBJ41p1L826j_dES8VKlxnZ5uzhsGnQaFAHWw5wpy71TI5x53whygIOf9
 U138OVAqe5BwbHdRNrLguNOyYfU8Q0ez6u_jJ5J0Ww5F1_16xavf33.fB34vCsW2oDX47c1WDq3K
 1T1JVBDAl.72dLs.wCTMSSxcwa.lFZZvpqynJEiM6aO9sbXw1zPXXLQh_2QcXeS0nR7Zn0o3e9Y7
 OV9Ts1x3zL810DrXvd71Ch0fR7vzkNZkGkvK1L56WImw0PPUT1HGQ6qHeKVS96JenpWR_XchbBVP
 bruZANmkYcY5b8q23pzI1jQ3if6s4X6TnuDBpyeS1BrJgvz10eWI1aUKSVwTnSl1UbstfVo9wE55
 hmyPJv5pikd7qTBPHve5Gg0mqk0BVDRr306RswqboRgi0XX2QrxKLvkM.mDhZx9I_rbn363Y-
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.gq1.yahoo.com with HTTP; Tue, 30 Mar 2021 00:39:48 +0000
Received: by kubenode579.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 27cc0a93ae52fff3a17931d8aba7bccb;
          Tue, 30 Mar 2021 00:39:43 +0000 (UTC)
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
Subject: [PATCH 05/10] erofs: add big physical cluster definition
Date:   Tue, 30 Mar 2021 08:39:03 +0800
Message-Id: <20210330003908.22842-6-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210330003908.22842-1-hsiangkao@aol.com>
References: <20210330003908.22842-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@redhat.com>

Big pcluster indicates the size of compressed data for each physical
pcluster is no longer fixed as block size, but could be more than 1
block (more accurately, 1 logical pcluster)

When big pcluster feature is enabled for head0/1, delta0 of the 1st
non-head lcluster index will keep block count of this pcluster in
lcluster size instead of 1. Or, the compressed size of pcluster
should be 1 lcluster if pcluster has no non-head lcluster index.

Also note that BIG_PCLUSTER feature reuses COMPR_CFGS feature since
it depends on COMPR_CFGS and will be released together.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/erofs_fs.h | 19 +++++++++++++++----
 fs/erofs/internal.h |  1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 76777673eb63..ecc3a0ea0bc4 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -19,6 +19,7 @@
  */
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
+#define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
 #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
 
 #define EROFS_SB_EXTSLOT_SIZE	16
@@ -214,17 +215,20 @@ enum {
 /* 14 bytes (+ length field = 16 bytes) */
 struct z_erofs_lz4_cfgs {
 	__le16 max_distance;
-	u8 reserved[12];
+	__le16 max_pclusterblks;
+	u8 reserved[10];
 } __packed;
 
 /*
  * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
  *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
  *                                  (4B) + 2B + (4B) if compacted 2B is on.
+ * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
+ * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
  */
-#define Z_EROFS_ADVISE_COMPACTED_2B_BIT         0
-
-#define Z_EROFS_ADVISE_COMPACTED_2B     (1 << Z_EROFS_ADVISE_COMPACTED_2B_BIT)
+#define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
+#define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
+#define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
 
 struct z_erofs_map_header {
 	__le32	h_reserved1;
@@ -279,6 +283,13 @@ enum {
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS        2
 #define Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT         0
 
+/*
+ * D0_CBLKCNT will be marked _only_ at the 1st non-head lcluster to store the
+ * compressed block count of a compressed extent (in logical clusters, aka.
+ * block count of a pcluster).
+ */
+#define Z_EROFS_VLE_DI_D0_CBLKCNT		(1 << 11)
+
 struct z_erofs_vle_decompressed_index {
 	__le16 di_advise;
 	/* where to decompress in the head cluster */
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 06c294929069..c4b3938a7e56 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -230,6 +230,7 @@ static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
 
 EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
+EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 /* atomic flag definitions */
-- 
2.20.1

