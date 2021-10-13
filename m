Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E35342B398
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237675AbhJMDbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:31:32 -0400
Received: from mail-eopbgr1300122.outbound.protection.outlook.com ([40.107.130.122]:62170
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237624AbhJMDb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:31:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOXX+Dx9GIpFx374vYw/MJPPtHnHDbYDUpbiVPyOOySXE+8l+jMmOCAmiy4ZuD6nCf9mJDPbgxt1b0LYSYvoReAcXWtIwxumSo4zuCdyZOhmtDwvV/VrCOP1uueQSOf0v5r3KZjtQm/sItBrjrb/yfyP0cNRcARR4EoLdh9d3D1Gh/dGD3Cw17Vg4aG2rAFyA+pX6Q8J5PtL8KDZekoB+Z6cfH9S4wtSTD10W8+zhtN+ADUXFH0b9wCGyXXtnNvIDRcDXwiYnmn7yZojGibsyHxOva/FxaeZxs3ueCf0yITlI4l8ZIP6RACaLXP0V+EatfQinB7Lgyk7q8yPPqpQ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EvVeZfefhh988SpyihkL6e9mm10D5Fmz8RzHMhY2EME=;
 b=LPQZ8Q63cG8aqrWxuCR34V+gbXwujdz/LXb+zmFovPw8H9vfezLpuo+q9kFJokBkCg3+Ti0vv0En8B72xaXUPizuAHxy4cK0sY7xXGYZIY1bO0r2cNJIh2zXLqDJI5VKVy+3W/7Icqi+z18hyjPHutPsTC5YioEZEL5jCrWr8g4RY9Xvbgc8WXY0hXnCrC2uZPdM5e4Kx2tnm29VF1ekNtfFveZRRbsJyTasRgtDL3d4TYu8yVhxzJAOtQiG+wrfDeDe4z3rCzC/FNFc+LdgIByDYYjiPlVgI60MhGOkv37Ny6WRV6Dg8yHMUPdAMvrMqcPLvmExrBVsTfQOPskl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvVeZfefhh988SpyihkL6e9mm10D5Fmz8RzHMhY2EME=;
 b=FGj8KUVINytQ+gnSnCF8eJU55f+4DS7Vou9NccS/eC+rhkpcdIaYOmVJJt7lrO4BSrbbdLc9J+ISAC8RApzWsOjYGFVtxcw14WkVeV0FXY8JUWcLSEBLYX1Be8oFwBN1iNGdc0k2q4Yt8znvzzyMRgBBnmQ7hlML+VkpivL1SCk=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB2955.apcprd06.prod.outlook.com (2603:1096:100:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 03:29:24 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.024; Wed, 13 Oct 2021
 03:29:24 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] nilfs2: replace snprintf in show functions with sysfs_emit
Date:   Tue, 12 Oct 2021 20:29:18 -0700
Message-Id: <1634095759-4625-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::14) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2P15301CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4628.3 via Frontend Transport; Wed, 13 Oct 2021 03:29:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf96558e-7fe7-4891-3d30-08d98df9a76c
X-MS-TrafficTypeDiagnostic: SL2PR06MB2955:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB2955489553E1F9A43DBC6871BDB79@SL2PR06MB2955.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:109;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NfMHJxpUQ+jo4faQkwyqx6BedjEoM6y7BHD987CR2uTCXFCCW7Em9twfcOzWt8ovC9buw4R9wVnvE7G7aRxOTp9la93mu7IvhpoIsKdWmn2gd0MY+odfoiM3PViZpKAN83DMgtFB9pIskFy/RpiFu/21OifJbrDO3VYtuJi1/vH6wET0m1JjNpRkxsqr6L7WCj6y8TyB2Sbc2Sukoke+mKvtUDg2/89z0ZfvQg1aDS25xXdwxifXAUqNP6nb9vtP301SEzn8jsI5fUbF/fEkpkuYtEz3AtIz4j69jFo1ABT7fK2ANDC3pPblgbz8tpAfmWx55GKsMTL5dh7zO3985Qa+TekhNjL4UKczbM1VDpP8X/NyMKux6Ad7pwa6zWM2Q2QVM8NlkX4Fkn9PLEzgeckKSeZPHCj/XSloglCHz7aOgAiBivg0n/ecCo67Do18QTQkwYdOT53srYH5JxU1T2NCIOxQ1HOhLztgX9HwMouBiB6BBpIBE5kn2nQSBE+kOIRUq3D+1J0PSPT8mTv3hL+XewbxTQIu7UQJTstMkgyLa1hyX6R1WuK5QOrKrogVqFUAPBxLuNg1NlGbdDwzRBW3q+iqaYCoi3xf073OjW0kLN4aP4LZeykFzfkajczY37QTKdIJhxTjPc/2f5qyycCFn1t8spUWi/r6fG+NYK1h2Trr5Q6gxGDkIjFj7/ndml6wfizg/MCqbYms+w8xnA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(508600001)(186003)(6666004)(107886003)(66476007)(66556008)(8936002)(66946007)(26005)(2906002)(6486002)(30864003)(2616005)(36756003)(83380400001)(4326008)(52116002)(6512007)(6506007)(86362001)(8676002)(316002)(38350700002)(5660300002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wQIw9htYhDkFmSt7F9CV3EUPzcUpD4wxtWvMnV/WDbJkcItMKU9IYCT9yTCw?=
 =?us-ascii?Q?ztLuG9WdSxuab6ikHJ5Z4Q+sSsTEkS+a4x5ahl128G13oUeUJbABwD60eMqc?=
 =?us-ascii?Q?enqPLeNRR4eW4YOMvyF8cR3uLvih+7vpNsqwJdEh5r/6Tg8kp3aJaEEyO1Ie?=
 =?us-ascii?Q?EOdKgBJ1AgTRODsnGHEnuQQgZldOKI5aGQfmN9WPFj7ZsIfNs5+jPt/PBHKX?=
 =?us-ascii?Q?uwbu1sAoR7cEmlCO31exISdby7f8e3IPl/y2xdBnZUa7drntbz/3xouEkJTu?=
 =?us-ascii?Q?KWpv9GCWsb/ON+LSjyYNX+ewpiwuQh0t7HUfnwZpVVvB9+k20mCSYNFzAOdq?=
 =?us-ascii?Q?Nbho7y9adBkB1L1PXhJzRZnuuxCf07VJ9O4WuOYK47+fdEl0B4tRvbqGQXBs?=
 =?us-ascii?Q?SYs0+8nwF1ZrZBT/J3+cjC+KLy35EpP6+J57OrrtrXfmLgmWqTBnQ933pC0K?=
 =?us-ascii?Q?oqPIAfv3O/CnMwKJGogSUg044pwEGxitoYPIF6t2yWsAgxbitfeEcWy6G3cZ?=
 =?us-ascii?Q?GA6ElAA9jII3jZso2ui2oy6gfdGhXEtudzM2Qmd7NkoPukNiYpJwKBN3GxxI?=
 =?us-ascii?Q?Ogwjs3++5wyk8sFCX32DcY6qqWt6jQTvhwvlH04eWx0yVifC1mv8UwsIaNZs?=
 =?us-ascii?Q?HCKLL3B6pSM94ol25sXtLiJ9VHIA6Fgl0ORdVM3DPYsz7W6vq487jrmlMmKY?=
 =?us-ascii?Q?9kXRhqclC7jq1eASQ5IEZk77JvVhLrfeCG+7E0+IEinDNp7zmZM3g7mtsB+V?=
 =?us-ascii?Q?xGt4JiXsLRDPzoTE3kjpuHfg4ckV/57j/tvEGzVF3qjr2Kg3veDktCBOPem4?=
 =?us-ascii?Q?JeeE62w3JwuAgxN3oiUNJXUoW/Eu4cqVDN7beLj9o7EoAB/moZw/ewfxei4f?=
 =?us-ascii?Q?5Acm7inGgffEUN7x0Qfi2YwgFHw7jP302/qKgxBDaDngRzBKlmvR2KqO1Hie?=
 =?us-ascii?Q?O9oOLBRrM3fZHj8v6r8/3l1iSjsRmoygQCmWJfGG+c4j4WjsXjIVhwRco5M5?=
 =?us-ascii?Q?pJZwYuCrWDtU+AcESaC7uyeaPysCJQaPsxe9f/+I3jhC7mMYogRLk5/IsPFT?=
 =?us-ascii?Q?nFap3nrnbsCfu3kwFZ1pUAfgiyywYvCTOHOYb8U+e4rsJAc8zgUz3KpEqHlF?=
 =?us-ascii?Q?DTXZHSOY5NYU0s9VzObwsY2q6DKaBWpBhTF9As/fwErjYNUbK7D5iA36IzLI?=
 =?us-ascii?Q?gN7Jr7REKR/2t8k+kvQqcSLz8M7BJvmNOE7q62+5/xzCgm1MqDI8nrZR2BmN?=
 =?us-ascii?Q?GLgXwj0SD57YTe+5B3lTMMGqFo+u9WvBclSZ4ZuUlfe3u4EpnrbWvWBQls8I?=
 =?us-ascii?Q?JZuwCQ5Gi8Y/8Hcegg2CouaP?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf96558e-7fe7-4891-3d30-08d98df9a76c
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:29:24.6486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yuE3ozj3Xw7PzM6oJW0Mm9HMfKLUod0t/AD3AHi4FuxivQUV2qf4aHkUUQDgSOvaRcBoPqBEMXmOyUkRXZ378A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB2955
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccicheck complains about the use of snprintf() in sysfs show functions.

Fix the coccicheck warning:
WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 fs/nilfs2/sysfs.c | 76 +++++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index 68e8d61..cdb935f 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -97,7 +97,7 @@ static ssize_t
 nilfs_snapshot_inodes_count_show(struct nilfs_snapshot_attr *attr,
 				 struct nilfs_root *root, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)atomic64_read(&root->inodes_count));
 }
 
@@ -105,7 +105,7 @@ static ssize_t
 nilfs_snapshot_blocks_count_show(struct nilfs_snapshot_attr *attr,
 				 struct nilfs_root *root, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)atomic64_read(&root->blocks_count));
 }
 
@@ -118,7 +118,7 @@ static ssize_t
 nilfs_snapshot_README_show(struct nilfs_snapshot_attr *attr,
 			    struct nilfs_root *root, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, snapshot_readme_str);
+	return sysfs_emit(buf, snapshot_readme_str);
 }
 
 NILFS_SNAPSHOT_RO_ATTR(inodes_count);
@@ -219,7 +219,7 @@ static ssize_t
 nilfs_mounted_snapshots_README_show(struct nilfs_mounted_snapshots_attr *attr,
 				    struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, mounted_snapshots_readme_str);
+	return sysfs_emit(buf, mounted_snapshots_readme_str);
 }
 
 NILFS_MOUNTED_SNAPSHOTS_RO_ATTR(README);
@@ -257,7 +257,7 @@ nilfs_checkpoints_checkpoints_number_show(struct nilfs_checkpoints_attr *attr,
 
 	ncheckpoints = cpstat.cs_ncps;
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", ncheckpoints);
+	return sysfs_emit(buf, "%llu\n", ncheckpoints);
 }
 
 static ssize_t
@@ -280,7 +280,7 @@ nilfs_checkpoints_snapshots_number_show(struct nilfs_checkpoints_attr *attr,
 
 	nsnapshots = cpstat.cs_nsss;
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", nsnapshots);
+	return sysfs_emit(buf, "%llu\n", nsnapshots);
 }
 
 static ssize_t
@@ -294,7 +294,7 @@ nilfs_checkpoints_last_seg_checkpoint_show(struct nilfs_checkpoints_attr *attr,
 	last_cno = nilfs->ns_last_cno;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", last_cno);
+	return sysfs_emit(buf, "%llu\n", last_cno);
 }
 
 static ssize_t
@@ -308,7 +308,7 @@ nilfs_checkpoints_next_checkpoint_show(struct nilfs_checkpoints_attr *attr,
 	cno = nilfs->ns_cno;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", cno);
+	return sysfs_emit(buf, "%llu\n", cno);
 }
 
 static const char checkpoints_readme_str[] =
@@ -324,7 +324,7 @@ static ssize_t
 nilfs_checkpoints_README_show(struct nilfs_checkpoints_attr *attr,
 				struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, checkpoints_readme_str);
+	return sysfs_emit(buf, checkpoints_readme_str);
 }
 
 NILFS_CHECKPOINTS_RO_ATTR(checkpoints_number);
@@ -355,7 +355,7 @@ nilfs_segments_segments_number_show(struct nilfs_segments_attr *attr,
 				     struct the_nilfs *nilfs,
 				     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%lu\n", nilfs->ns_nsegments);
+	return sysfs_emit(buf, "%lu\n", nilfs->ns_nsegments);
 }
 
 static ssize_t
@@ -363,7 +363,7 @@ nilfs_segments_blocks_per_segment_show(struct nilfs_segments_attr *attr,
 					struct the_nilfs *nilfs,
 					char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%lu\n", nilfs->ns_blocks_per_segment);
+	return sysfs_emit(buf, "%lu\n", nilfs->ns_blocks_per_segment);
 }
 
 static ssize_t
@@ -377,7 +377,7 @@ nilfs_segments_clean_segments_show(struct nilfs_segments_attr *attr,
 	ncleansegs = nilfs_sufile_get_ncleansegs(nilfs->ns_sufile);
 	up_read(&NILFS_MDT(nilfs->ns_dat)->mi_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", ncleansegs);
+	return sysfs_emit(buf, "%lu\n", ncleansegs);
 }
 
 static ssize_t
@@ -397,7 +397,7 @@ nilfs_segments_dirty_segments_show(struct nilfs_segments_attr *attr,
 		return err;
 	}
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", sustat.ss_ndirtysegs);
+	return sysfs_emit(buf, "%llu\n", sustat.ss_ndirtysegs);
 }
 
 static const char segments_readme_str[] =
@@ -413,7 +413,7 @@ nilfs_segments_README_show(struct nilfs_segments_attr *attr,
 			    struct the_nilfs *nilfs,
 			    char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, segments_readme_str);
+	return sysfs_emit(buf, segments_readme_str);
 }
 
 NILFS_SEGMENTS_RO_ATTR(segments_number);
@@ -450,7 +450,7 @@ nilfs_segctor_last_pseg_block_show(struct nilfs_segctor_attr *attr,
 	last_pseg = nilfs->ns_last_pseg;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)last_pseg);
 }
 
@@ -465,7 +465,7 @@ nilfs_segctor_last_seg_sequence_show(struct nilfs_segctor_attr *attr,
 	last_seq = nilfs->ns_last_seq;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", last_seq);
+	return sysfs_emit(buf, "%llu\n", last_seq);
 }
 
 static ssize_t
@@ -479,7 +479,7 @@ nilfs_segctor_last_seg_checkpoint_show(struct nilfs_segctor_attr *attr,
 	last_cno = nilfs->ns_last_cno;
 	spin_unlock(&nilfs->ns_last_segment_lock);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", last_cno);
+	return sysfs_emit(buf, "%llu\n", last_cno);
 }
 
 static ssize_t
@@ -493,7 +493,7 @@ nilfs_segctor_current_seg_sequence_show(struct nilfs_segctor_attr *attr,
 	seg_seq = nilfs->ns_seg_seq;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", seg_seq);
+	return sysfs_emit(buf, "%llu\n", seg_seq);
 }
 
 static ssize_t
@@ -507,7 +507,7 @@ nilfs_segctor_current_last_full_seg_show(struct nilfs_segctor_attr *attr,
 	segnum = nilfs->ns_segnum;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", segnum);
+	return sysfs_emit(buf, "%llu\n", segnum);
 }
 
 static ssize_t
@@ -521,7 +521,7 @@ nilfs_segctor_next_full_seg_show(struct nilfs_segctor_attr *attr,
 	nextnum = nilfs->ns_nextnum;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", nextnum);
+	return sysfs_emit(buf, "%llu\n", nextnum);
 }
 
 static ssize_t
@@ -535,7 +535,7 @@ nilfs_segctor_next_pseg_offset_show(struct nilfs_segctor_attr *attr,
 	pseg_offset = nilfs->ns_pseg_offset;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%lu\n", pseg_offset);
+	return sysfs_emit(buf, "%lu\n", pseg_offset);
 }
 
 static ssize_t
@@ -549,7 +549,7 @@ nilfs_segctor_next_checkpoint_show(struct nilfs_segctor_attr *attr,
 	cno = nilfs->ns_cno;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", cno);
+	return sysfs_emit(buf, "%llu\n", cno);
 }
 
 static ssize_t
@@ -577,7 +577,7 @@ nilfs_segctor_last_seg_write_time_secs_show(struct nilfs_segctor_attr *attr,
 	ctime = nilfs->ns_ctime;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", ctime);
+	return sysfs_emit(buf, "%llu\n", ctime);
 }
 
 static ssize_t
@@ -605,7 +605,7 @@ nilfs_segctor_last_nongc_write_time_secs_show(struct nilfs_segctor_attr *attr,
 	nongc_ctime = nilfs->ns_nongc_ctime;
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", nongc_ctime);
+	return sysfs_emit(buf, "%llu\n", nongc_ctime);
 }
 
 static ssize_t
@@ -619,7 +619,7 @@ nilfs_segctor_dirty_data_blocks_count_show(struct nilfs_segctor_attr *attr,
 	ndirtyblks = atomic_read(&nilfs->ns_ndirtyblks);
 	up_read(&nilfs->ns_segctor_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", ndirtyblks);
+	return sysfs_emit(buf, "%u\n", ndirtyblks);
 }
 
 static const char segctor_readme_str[] =
@@ -656,7 +656,7 @@ static ssize_t
 nilfs_segctor_README_show(struct nilfs_segctor_attr *attr,
 			  struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, segctor_readme_str);
+	return sysfs_emit(buf, segctor_readme_str);
 }
 
 NILFS_SEGCTOR_RO_ATTR(last_pseg_block);
@@ -725,7 +725,7 @@ nilfs_superblock_sb_write_time_secs_show(struct nilfs_superblock_attr *attr,
 	sbwtime = nilfs->ns_sbwtime;
 	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", sbwtime);
+	return sysfs_emit(buf, "%llu\n", sbwtime);
 }
 
 static ssize_t
@@ -739,7 +739,7 @@ nilfs_superblock_sb_write_count_show(struct nilfs_superblock_attr *attr,
 	sbwcount = nilfs->ns_sbwcount;
 	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", sbwcount);
+	return sysfs_emit(buf, "%u\n", sbwcount);
 }
 
 static ssize_t
@@ -753,7 +753,7 @@ nilfs_superblock_sb_update_frequency_show(struct nilfs_superblock_attr *attr,
 	sb_update_freq = nilfs->ns_sb_update_freq;
 	up_read(&nilfs->ns_sem);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", sb_update_freq);
+	return sysfs_emit(buf, "%u\n", sb_update_freq);
 }
 
 static ssize_t
@@ -801,7 +801,7 @@ static ssize_t
 nilfs_superblock_README_show(struct nilfs_superblock_attr *attr,
 				struct the_nilfs *nilfs, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, sb_readme_str);
+	return sysfs_emit(buf, sb_readme_str);
 }
 
 NILFS_SUPERBLOCK_RO_ATTR(sb_write_time);
@@ -836,7 +836,7 @@ ssize_t nilfs_dev_revision_show(struct nilfs_dev_attr *attr,
 	u32 major = le32_to_cpu(sbp[0]->s_rev_level);
 	u16 minor = le16_to_cpu(sbp[0]->s_minor_rev_level);
 
-	return snprintf(buf, PAGE_SIZE, "%d.%d\n", major, minor);
+	return sysfs_emit(buf, "%d.%d\n", major, minor);
 }
 
 static
@@ -844,7 +844,7 @@ ssize_t nilfs_dev_blocksize_show(struct nilfs_dev_attr *attr,
 				 struct the_nilfs *nilfs,
 				 char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", nilfs->ns_blocksize);
+	return sysfs_emit(buf, "%u\n", nilfs->ns_blocksize);
 }
 
 static
@@ -855,7 +855,7 @@ ssize_t nilfs_dev_device_size_show(struct nilfs_dev_attr *attr,
 	struct nilfs_super_block **sbp = nilfs->ns_sbp;
 	u64 dev_size = le64_to_cpu(sbp[0]->s_dev_size);
 
-	return snprintf(buf, PAGE_SIZE, "%llu\n", dev_size);
+	return sysfs_emit(buf, "%llu\n", dev_size);
 }
 
 static
@@ -866,7 +866,7 @@ ssize_t nilfs_dev_free_blocks_show(struct nilfs_dev_attr *attr,
 	sector_t free_blocks = 0;
 
 	nilfs_count_free_blocks(nilfs, &free_blocks);
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)free_blocks);
 }
 
@@ -877,7 +877,7 @@ ssize_t nilfs_dev_uuid_show(struct nilfs_dev_attr *attr,
 {
 	struct nilfs_super_block **sbp = nilfs->ns_sbp;
 
-	return snprintf(buf, PAGE_SIZE, "%pUb\n", sbp[0]->s_uuid);
+	return sysfs_emit(buf, "%pUb\n", sbp[0]->s_uuid);
 }
 
 static
@@ -905,7 +905,7 @@ static ssize_t nilfs_dev_README_show(struct nilfs_dev_attr *attr,
 				     struct the_nilfs *nilfs,
 				     char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, dev_readme_str);
+	return sysfs_emit(buf, dev_readme_str);
 }
 
 NILFS_DEV_RO_ATTR(revision);
@@ -1051,7 +1051,7 @@ void nilfs_sysfs_delete_device_group(struct the_nilfs *nilfs)
 static ssize_t nilfs_feature_revision_show(struct kobject *kobj,
 					    struct attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d.%d\n",
+	return sysfs_emit(buf, "%d.%d\n",
 			NILFS_CURRENT_REV, NILFS_MINOR_REV);
 }
 
@@ -1064,7 +1064,7 @@ static ssize_t nilfs_feature_README_show(struct kobject *kobj,
 					 struct attribute *attr,
 					 char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, features_readme_str);
+	return sysfs_emit(buf, features_readme_str);
 }
 
 NILFS_FEATURE_RO_ATTR(revision);
-- 
2.7.4

