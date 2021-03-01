Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B4B3276C6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 06:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbhCAFBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 00:01:10 -0500
Received: from mail-eopbgr1310049.outbound.protection.outlook.com ([40.107.131.49]:31392
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229455AbhCAFBI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 00:01:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=go/YqsKU8Dc33h8QJfFuaZnhVtoyWCPAqHXJ2mxk4xMh0+gNaAf+EKWrzy39ZHpy0NcsJaS2tNSbEMTE7H5jmUoJWC7TzkP7prs4A/EXHRI+Kzb0qi4zOGFOSF8U0nr4o3rkxTgq6SHLwJkhCnA++nQLtXAtJY5izl2V3G+8q3SouVODaYBQqHlJmX0iU6wp5OR0GmcBb0mACBNTbRD7nfOrgYWKgi6awXzjuAUvpQec7DYGICkY+HOTLKHiSWIexeY0YLdNLnbkJFlpGx4B8Px393bEbKomw5/cNrdtziTzeZjYHnLLmUvG79RawwFUYFhNXdSIS94HxXcE/0oBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDA3t9cvgidp8PexrgSPxfx6HlsmtszWaDqiiboiOt8=;
 b=NpLu+r8s+BGd0cNQ6F7UKbnA3+YaRIA8xbUUO0hL2nmhqc0TyA7O2n1NTYaP8KAP7qmOIqFrilHbAxLXvDRV0PrIxHVw+cJLBz//7HQtQSG81owCFa3btQWmabS9UhWt+wFGe/MzjYE7E6prVSyTqUXlrun6e3rqtUPUt52RchMS9BRnVf6Gzx3F4OzwqFEUhFRQwa2+tWYkGmOoiWVLZwxupkWaZos6gAQw1ZxnbBlik1J2gXC18Ck2pF1x3I+KmV7JbSokol3tZO6ZhScEzoushDPy5AdJQ0XW0KF+xrpEMcAdQe/9HHbC28Z556gLNzfqhuFsSb6NrLM0F+O1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oDA3t9cvgidp8PexrgSPxfx6HlsmtszWaDqiiboiOt8=;
 b=uMRLRpMltULQfkDpWEasfz7ME+iA9Ie5juaOF0+Ih8y43ZIBJbpR9OUTZ2jHgHLhIUXeYYxEO5qj0Rt/2A4YHqhBozOOx5Pel8Jn+6Q5TKpNsFAgIdbBJYmGDzN6vRyhV/XfKoW+h+woH9h76MYF2x7H7wIS4hGrOzGr7+FtPwE=
Authentication-Results: lists.sourceforge.net; dkim=none (message not signed)
 header.d=none;lists.sourceforge.net; dmarc=none action=none
 header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3019.apcprd02.prod.outlook.com (2603:1096:4:5c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20; Mon, 1 Mar 2021 04:58:58 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3890.028; Mon, 1 Mar 2021
 04:58:58 +0000
From:   Huang Jianan <huangjianan@oppo.com>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     huangjianan@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] f2fs: check if swapfile is section-alligned
Date:   Mon,  1 Mar 2021 12:58:44 +0800
Message-Id: <20210301045844.154809-1-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.255.79.104]
X-ClientProxiedBy: HK2PR06CA0001.apcprd06.prod.outlook.com
 (2603:1096:202:2e::13) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.255.79.104) by HK2PR06CA0001.apcprd06.prod.outlook.com (2603:1096:202:2e::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20 via Frontend Transport; Mon, 1 Mar 2021 04:58:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fe09319-320c-4f31-6217-08d8dc6eb8c6
X-MS-TrafficTypeDiagnostic: SG2PR02MB3019:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3019849BF232A22304E4DF59C39A9@SG2PR02MB3019.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 42MOe7cr/2ANd2iXsEDE6izFAHpp7yArJo9v90kga1HC5zbN0f1he20Lu0+ql5ElC8w1OULUKqolaeAou/vFrDYZnUsxRpMUPVI5duMaHXNfdGjQtoPGrNcm9m5VToYPNBkra1ZHIRHrKn3/qAA9UllSdYXM2Q2Ma4V3qjtucX/AqCWulRWPgq9PblR5nFyqL1QZhbI4tBa9LjavvvqLAOtr7b9DYDPMkPgTyryShFIUrHyDxFOnhY9to2yZgGFEkdo7WVi9Vg7GqYn8IzLnindGNX7saXKJDOJiPjzQAnMuYeU3BhxOIhrLb47Wxossw8mo20zmLmrL3B87y+gk5O61eHGS+oIhokVks9ZPwVh/fFUCNnScy2w0ynGrJi/YHPYIOnVi/cBGCvO5aeWExXledmXnloxTsbmItaLMU7dmf1GqTgzfXYs3eTcFj6QgnrQWEaPUfaATHbbJmXdPH0XnACOsIWi9sUdjqqUyuAbli4fght3fM7AB9rWF6/yTQC2xCNyz7eUP/QiioqMIHKeX+L5a5so5FPa0g7SD6LZnWc1UqRiaqVaAtwg3WjpOIg5H99wzO5V6bjAoNwLX1E3HotDL7ObagTdzcieJkxg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4108.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(39860400002)(346002)(136003)(2906002)(6486002)(36756003)(8676002)(6512007)(69590400012)(4326008)(478600001)(6916009)(8936002)(186003)(16526019)(6506007)(66556008)(66476007)(83380400001)(5660300002)(52116002)(6666004)(956004)(2616005)(26005)(1076003)(66946007)(86362001)(316002)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0U5t2QFDWEg4zxu5EFCg3MEKUySmt7tcRbZj/UyCBw5CPuZ2KFcXg0jCS6cX?=
 =?us-ascii?Q?O8J0kDbsbdFmZWO19tYCwaUIYMXtSo7rt2iRxfD9PXoYSkg2APyE2JIEvxfk?=
 =?us-ascii?Q?rpnooZAnHFD0rxDrvmp5Vn0reCB3hXO/3FX+8J71o8PevSqeMOm2c2bafzvR?=
 =?us-ascii?Q?jP9jYi53UhgeFJ8VAlhxZmGUFHX1QXx57LqhXMocQGbD28qpNR1UYPAvO+QC?=
 =?us-ascii?Q?A5kh0mGg9eogDQifEMn8yAaNoRjKel/gpEHjXJTwI6xzCoN+7zqKaiNGELcT?=
 =?us-ascii?Q?4+FQcOy7X1QJdgU0nRB2mQ3JU+MvuK3/fn1d8+3WjjEeMvuMJWk18V4NdR1x?=
 =?us-ascii?Q?eOKIgmXxKeHja+hLN40LmMzoA3HSwA4GNcb56bzBb0CgYsxzgNBISOqPBxvj?=
 =?us-ascii?Q?OOw4n2ljtStnSL6v6TrKd3alzPXEYqF119qYTnrCFKZng4ROXd2YHIA0DsSg?=
 =?us-ascii?Q?6BKAezfikTPpAC4djxlwypsnP7KKTOu8qx97QUnPe2drrby79ihVS0GynkVh?=
 =?us-ascii?Q?8FW2lObHPUamlZo7uiwyY/x1WAiSyfYbwZgOCxMZLkK+EuEAaM0tPy64KBfc?=
 =?us-ascii?Q?i2cgt8l17Y8HxnUUtpGrDkIBS/LBdVWzx8XT5joTfy1ZKZtRQmOkGmI2WWi5?=
 =?us-ascii?Q?NMjU/qUESRJEvnCMd/XPLZ8tB7VjoKL4mI9/w4g/fZFYh9BnFaesdaA/v/JY?=
 =?us-ascii?Q?fH9JuTgFBCVuddXaO2ceKKrHPQXH7dZnZDUcbn5tQlyEVQEgFGxiT30JSpiH?=
 =?us-ascii?Q?jDuCVrYUp6e7wN9YWK2+LkgoPA4anPhXGHGuerQVB+2gKWxvh9oSpCoNUdVI?=
 =?us-ascii?Q?cJ3dPpDF1TAWjXSBrH89Qtt9ZOWbq8EcJEVuO/qbg/iyZoMMaEKrZGmdXb8Q?=
 =?us-ascii?Q?if6uZDfnF909DFz39d4/Jea9lJwJnkh3b0U33l5JwXISZWVHunO2KZ0K1NqO?=
 =?us-ascii?Q?lJNkXpCgvLQHgFoGFiPu9aT+UfQOHrNS61KpVw4xr77CQo3DXuxZgaobtwuY?=
 =?us-ascii?Q?3QK2dl8cKIkPDbtkrIpWDYsJdc48Zt1wzYmH2zQhIJoFxnVAnjVY7k+j7O5K?=
 =?us-ascii?Q?nxhX+Dvz3iJnLfXDzhkf7onZCpM+I1q3ZuOWUrArnH1MHkIYVBRKPcZIIaLn?=
 =?us-ascii?Q?vI7+isY5QDGX6YDEnZh5WKIBt2FLfyO3N/Llg6ZFD8ER+dYZdxQdAb2DGl7Z?=
 =?us-ascii?Q?4mV4Uzic9oa8VVzEB1eWFkVV6OdX05zXsohKVfnLQKHEZMhA1V/Rb1K7jXLw?=
 =?us-ascii?Q?QItBQFKFi6iTifkjnPOGX0WtUeh5tcZqMHYtzeFjZQaGyr+UOFA2u7KytmPg?=
 =?us-ascii?Q?OQGz6t8VTIt7f6VjdvZTg4LY?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fe09319-320c-4f31-6217-08d8dc6eb8c6
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2021 04:58:58.2004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Duq7HbmKsYw37DrRRtWuCylnl4H8YgwVnfSmAlKoYRERtcJzH71iwFWiwnAg3LCt7Ydrkff8nYfI2z53LYzFwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3019
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the swapfile isn't created by pin and fallocate, it can't be
guaranteed section-aligned, so it may be selected by f2fs gc. When
gc_pin_file_threshold is reached, the address of swapfile may change,
but won't be synchronized to swap_extent, so swap will write to wrong
address, which will cause data corruption.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fs/f2fs/data.c | 109 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 88 insertions(+), 21 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4dbc1cafc55d..d33085daa3dc 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3781,11 +3781,64 @@ int f2fs_migrate_page(struct address_space *mapping,
 #endif
 
 #ifdef CONFIG_SWAP
+static int f2fs_is_file_aligned(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	block_t main_blkaddr = SM_I(sbi)->main_blkaddr;
+	block_t cur_lblock;
+	block_t last_lblock;
+	block_t pblock;
+	unsigned long nr_pblocks;
+	unsigned int blocks_per_sec = BLKS_PER_SEC(sbi);
+	int ret = 0;
+
+	cur_lblock = 0;
+	last_lblock = bytes_to_blks(inode, i_size_read(inode));
+
+	while (cur_lblock < last_lblock) {
+		struct f2fs_map_blocks map;
+
+		memset(&map, 0, sizeof(map));
+		map.m_lblk = cur_lblock;
+		map.m_len = last_lblock - cur_lblock;
+		map.m_next_pgofs = NULL;
+		map.m_next_extent = NULL;
+		map.m_seg_type = NO_CHECK_TYPE;
+		map.m_may_create = false;
+
+		ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
+		if (ret)
+			goto out;
+
+		/* hole */
+		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
+			f2fs_err(sbi, "Swapfile has holes\n");
+			ret = -ENOENT;
+			goto out;
+		}
+
+		pblock = map.m_pblk;
+		nr_pblocks = map.m_len;
+
+		if ((pblock - main_blkaddr) & (blocks_per_sec - 1) ||
+			nr_pblocks & (blocks_per_sec - 1)) {
+			f2fs_err(sbi, "Swapfile does not align to section");
+			ret = -EINVAL;
+			goto out;
+		}
+
+		cur_lblock += nr_pblocks;
+	}
+out:
+	return ret;
+}
+
 static int check_swap_activate_fast(struct swap_info_struct *sis,
 				struct file *swap_file, sector_t *span)
 {
 	struct address_space *mapping = swap_file->f_mapping;
 	struct inode *inode = mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	sector_t cur_lblock;
 	sector_t last_lblock;
 	sector_t pblock;
@@ -3793,8 +3846,8 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 	sector_t highest_pblock = 0;
 	int nr_extents = 0;
 	unsigned long nr_pblocks;
-	u64 len;
-	int ret;
+	unsigned int blocks_per_sec = BLKS_PER_SEC(sbi);
+	int ret = 0;
 
 	/*
 	 * Map all the blocks into the extent list.  This code doesn't try
@@ -3802,31 +3855,41 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 	 */
 	cur_lblock = 0;
 	last_lblock = bytes_to_blks(inode, i_size_read(inode));
-	len = i_size_read(inode);
 
 	while (cur_lblock + 1 <= last_lblock && cur_lblock < sis->max) {
 		struct f2fs_map_blocks map;
-		pgoff_t next_pgofs;
 
 		cond_resched();
 
 		memset(&map, 0, sizeof(map));
 		map.m_lblk = cur_lblock;
-		map.m_len = bytes_to_blks(inode, len) - cur_lblock;
-		map.m_next_pgofs = &next_pgofs;
+		map.m_len = last_lblock - cur_lblock;
+		map.m_next_pgofs = NULL;
+		map.m_next_extent = NULL;
 		map.m_seg_type = NO_CHECK_TYPE;
+		map.m_may_create = false;
 
 		ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
 		if (ret)
-			goto err_out;
+			goto out;
 
 		/* hole */
-		if (!(map.m_flags & F2FS_MAP_FLAGS))
-			goto err_out;
+		if (!(map.m_flags & F2FS_MAP_FLAGS)) {
+			f2fs_err(sbi, "Swapfile has holes\n");
+			ret = -ENOENT;
+			goto out;
+		}
 
 		pblock = map.m_pblk;
 		nr_pblocks = map.m_len;
 
+		if ((pblock - SM_I(sbi)->main_blkaddr) & (blocks_per_sec - 1) ||
+			nr_pblocks & (blocks_per_sec - 1)) {
+			f2fs_err(sbi, "Swapfile does not align to section");
+			ret = -EINVAL;
+			goto out;
+		}
+
 		if (cur_lblock + nr_pblocks >= sis->max)
 			nr_pblocks = sis->max - cur_lblock;
 
@@ -3855,9 +3918,6 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 	sis->highest_bit = cur_lblock - 1;
 out:
 	return ret;
-err_out:
-	pr_err("swapon: swapfile has holes\n");
-	return -EINVAL;
 }
 
 /* Copied from generic_swapfile_activate() to check any holes */
@@ -3866,6 +3926,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 {
 	struct address_space *mapping = swap_file->f_mapping;
 	struct inode *inode = mapping->host;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	unsigned blocks_per_page;
 	unsigned long page_no;
 	sector_t probe_block;
@@ -3873,11 +3934,15 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	sector_t lowest_block = -1;
 	sector_t highest_block = 0;
 	int nr_extents = 0;
-	int ret;
+	int ret = 0;
 
 	if (PAGE_SIZE == F2FS_BLKSIZE)
 		return check_swap_activate_fast(sis, swap_file, span);
 
+	ret = f2fs_is_file_aligned(inode);
+	if (ret)
+		goto out;
+
 	blocks_per_page = bytes_to_blks(inode, PAGE_SIZE);
 
 	/*
@@ -3892,13 +3957,14 @@ static int check_swap_activate(struct swap_info_struct *sis,
 		unsigned block_in_page;
 		sector_t first_block;
 		sector_t block = 0;
-		int	 err = 0;
 
 		cond_resched();
 
 		block = probe_block;
-		err = bmap(inode, &block);
-		if (err || !block)
+		ret = bmap(inode, &block);
+		if (ret)
+			goto out;
+		if (!block)
 			goto bad_bmap;
 		first_block = block;
 
@@ -3914,9 +3980,10 @@ static int check_swap_activate(struct swap_info_struct *sis,
 					block_in_page++) {
 
 			block = probe_block + block_in_page;
-			err = bmap(inode, &block);
-
-			if (err || !block)
+			ret = bmap(inode, &block);
+			if (ret)
+				goto out;
+			if (!block)
 				goto bad_bmap;
 
 			if (block != first_block + block_in_page) {
@@ -3956,8 +4023,8 @@ static int check_swap_activate(struct swap_info_struct *sis,
 out:
 	return ret;
 bad_bmap:
-	pr_err("swapon: swapfile has holes\n");
-	return -EINVAL;
+	f2fs_err(sbi, "Swapfile has holes\n");
+	return -ENOENT;
 }
 
 static int f2fs_swap_activate(struct swap_info_struct *sis, struct file *file,
-- 
2.25.1

