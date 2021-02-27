Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01077326CF7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 13:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbhB0MFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 07:05:34 -0500
Received: from mail-eopbgr1320075.outbound.protection.outlook.com ([40.107.132.75]:24448
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229863AbhB0MF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 07:05:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So+LipZEuY+9VNBQXVe/Bbus/vNNdkq2VslzRBOPtAo5Q3lJge5djTAPYkXCrOQE5Cctglo6Omrk6JiZdyXkzVNrLGzq0VmGEAqj2nAMlwX3PXAHKsFCiHVdRJRAchgRbCcY/yOWQ7MD9A2nVdCOu/jw5uK6EuyvFQC2M+vtq5bRHOEn42BB7Ciq7ku8yKcpJmgwZxlMmtSPQpvNP3WnV776zh/Vn5hynqruqL/6Wu1TJE+FNCnN+09r3c2XCXp8j/zo2vdTK/f++rWULuRlsGifMUnv280sc+49YNvzujIhONt0QgnQDwh/Iweug4WEOS9JAvOZhBxt3BylFxepKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vaJ+e9WLQ1BRnCbhijENzkhhFlivEjOeIL5C4gjufI=;
 b=Wq1ArPsU5FdIBYWEC/be6orptOlv4RADZZzAwSaa/AjYl+D94IUv4NUNHaxM8TxP65tEDNFBryT//M7ozsNVPQtaTgQDGoQmwRBbZiOatXSmb8DaCFCU1BuUJZg6siFeT5T5eDKZuAtj/Q6753laEdJcKGUThkL1eqkihBh2M1TSiiwTljNBEh127o36jy8seduXQWUJrvUkGne67jeNVSPif8iiL5YDL1EUL+VoNdXxZiV7qlXKz+9Wxlg25gaWOffmh1e9ZAI8a9sPqQ8S9hpy8nAKfvjYu1/9ohWWoFaVsQOr3DwIpl8OGO8j9j/i7tKzp5zRWlRcNPyZ1wRVcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vaJ+e9WLQ1BRnCbhijENzkhhFlivEjOeIL5C4gjufI=;
 b=QEfh9whAZyrXQpyqb6DyAlH3uIfCpFMVis3G23A+yb0PkeTSlXP0FpJAwpbZc/gUeosGKzG0qOk0ZDplaucRAAZhvIrEUfJlaZqrEuUxtcBccnkhy/td2JzwZnBCKU0T+o7mBn7yAOm6oNwtRl+mq6hBDsu77+weCZ4VQ/Y4FYE=
Authentication-Results: lists.sourceforge.net; dkim=none (message not signed)
 header.d=none;lists.sourceforge.net; dmarc=none action=none
 header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB3369.apcprd02.prod.outlook.com (2603:1096:4:43::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.19; Sat, 27 Feb 2021 12:02:52 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::1143:a7b7:6bd4:83b3%7]) with mapi id 15.20.3890.023; Sat, 27 Feb 2021
 12:02:52 +0000
From:   Huang Jianan <huangjianan@oppo.com>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     huangjianan@oppo.com, guoweichao@oppo.com, zhangshiming@oppo.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] f2fs: check if swapfile is section-alligned
Date:   Sat, 27 Feb 2021 20:02:31 +0800
Message-Id: <20210227120231.136559-3-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210227120231.136559-1-huangjianan@oppo.com>
References: <20210227120231.136559-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [58.252.5.72]
X-ClientProxiedBy: HK0PR01CA0050.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::14) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (58.252.5.72) by HK0PR01CA0050.apcprd01.prod.exchangelabs.com (2603:1096:203:a6::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Sat, 27 Feb 2021 12:02:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 995a2d6f-cfa7-4af8-b966-08d8db179c5c
X-MS-TrafficTypeDiagnostic: SG2PR02MB3369:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SG2PR02MB3369E68DA62CA37BE41E071AC39C9@SG2PR02MB3369.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:901;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzGoSF7heV8GSiTD0cAokJL8GGlhNhbmwjS80pJayS/yaGCKViO+hhn2PnWm5tc65UTZ1SmcH6ZNqiTNHNghGomfx5KG7/nVZA5Kj8w8jeRbkuig2aFQOZLuNKZMZKgGyaqjSeaq/igBgnQ5z8Kw/FUdeeOPJfG9ATtuKLNC30/HjEkXAkUECPxsONKt4F8/EXV6mkX4CNIu1M/ouYWRTSoTUNssW/0KW7ORUKiibpg30ynzCorcSzxaGoEccxRx4D491y7csDwfy/ukcJ1YGx9wV9BOh7nRqGWbej5/xMdqlFc+dScYeTSwks5P03f9UbQRWZfiiomlTOzZm7siQmBLkakJRvm5wssR+pfvWVR3L7TO1hMBA3bmbkQWwh6PfMmFMV4gsil68ieJk/0BgJoJKqjRxujpPWcP0hR70DyMwNjTvcPfVmOfgffli7IDsu+vaz7TtHkrxqwfWhzWoSyHIahcNhZe5T03qi1ByvrLF+HkdENeqNMsNbdG7IAJW8YUEEfMD7ah8HX6D/6+7SjHsJ51NsWPAastBLrutaaOPba+DFCcDORnkpfHyb02xErffy+fL6xlng5bzvKUm/NaZHq8oNqjhuXV9r2KgoE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4108.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39850400004)(26005)(8936002)(69590400012)(16526019)(186003)(6666004)(36756003)(2906002)(52116002)(6512007)(8676002)(6486002)(6506007)(6916009)(5660300002)(1076003)(478600001)(66946007)(83380400001)(66476007)(4326008)(66556008)(316002)(2616005)(86362001)(956004)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?48I00Ru+HJUGPRCGv5PjgGVirWcyzBQ+Q9Jjb3ovuICySv7cifVwJqUvxhqG?=
 =?us-ascii?Q?Gtx+5HOQDsuikLDA/Hn0klKX2O/tv2Eb6CstdMzGWWXnQqwmZoBSbIGKaqd5?=
 =?us-ascii?Q?lSlsPdqBn5I1LWMWR1rXkhnz0aMBlfjLEN2TiO6GpGlSvwphCnGfh1Pn9LX3?=
 =?us-ascii?Q?hV3ykPsnrO+esRWsnVjHQY+Q3un+gRkne9kDeRrK5GjNouIb7RlHoWPgQ0L0?=
 =?us-ascii?Q?pmTDxpNwcsXLFr3RH4odQoBQg2ujgXS73BaRot1KAr8Wfnn2ucCmpfBw8K2h?=
 =?us-ascii?Q?zzjvTCHIN82Isk6nzLm834jFGxtnsAy1rGQxLfK0vIAwu/aE8GpLRu4mi0Hu?=
 =?us-ascii?Q?3Yv38KMT0aKxZAIyYhMRgG+T0aqUirqyLB3cY69/9Ibt6d+M/wR48I5vige9?=
 =?us-ascii?Q?TMNMW45mgOj7txDYR0kzDReY8Xtyr75Aew2k2jVHjb9hZpXSugEuPKrcRMRN?=
 =?us-ascii?Q?+gaFIjx93HbGzJkUpJnyDNBnAWTZoHWZn1q9m/yvpXjy7RS5rlSMiG/tCvCS?=
 =?us-ascii?Q?qIs7n1cN7pXXM51pVcgt0DMx+nHoUs7FrkLN5ax/zsdqvD+scc5cKOe014Ih?=
 =?us-ascii?Q?pv0kT3hiBJFue8Q9FKSzFJw4hDxo4nqh4I5fdBX2J1C8B8QgCB8HIXjuPK9H?=
 =?us-ascii?Q?Npywe8HO0FiMxOEib2UbYtZBq6SXI2E4GPgFgCNKw4NZgIy1kV6/ugVx4YDt?=
 =?us-ascii?Q?TiVCtf9R9YlUQKOhWCswCPX1zUAO3FDsopPGtRs+rbXeMjHWdAJlYIkDsjMc?=
 =?us-ascii?Q?2/x2nWkabbz5XnZmThvMy9t7OE1oiCK+7zZt7uLkLZKnznP62TtQPg47oZdx?=
 =?us-ascii?Q?FuQEPCezPt0Bf6lYDi+Lk5ZtVGO5mhXNlx32/XP/Do9Spqz+Zegk5TlHw1+6?=
 =?us-ascii?Q?5SbpSBlMlnNJORlaTyWmKkYbXjEOyxE6+d0MlXV55coFQdEqY8lCfY2FzbZB?=
 =?us-ascii?Q?LHIQHmeiQONOywJrX2aLpAjcpNYLKfaUt8aW9yBkWj4JiSE3rmcVGcngPuw2?=
 =?us-ascii?Q?3pDf49+FTpEd4giM/18lVt/FMMpfHe7i7omUXLZLvTXMAFnqSUc0N0Wxv8lu?=
 =?us-ascii?Q?P6Bgclp1YR6g9VxObrNVZ7/ouMGBZLbR3U9Y/ZGNijzYjvlrs9BqddX3zYfn?=
 =?us-ascii?Q?bjv05M2uFxyxkkSc4lsYcZ2fnVSlHr0RgjrSVnCEU4AWm6rfCJvk7IkzhXLd?=
 =?us-ascii?Q?bIqjubIDhT6tpGmx6Ac3hFt066yHL9QNB9y7Fq5GLKItwUl36J52nadLp/aF?=
 =?us-ascii?Q?TAjvge6Aph8kEycBprAbzk+KUsE0ffNq3Ma4/Lte2vQQZTgDwWMtosiMwnUm?=
 =?us-ascii?Q?o3TEVmShpEWi26Op0eVcn6A9?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995a2d6f-cfa7-4af8-b966-08d8db179c5c
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2021 12:02:52.7827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qWvAiThLSNnQxvZf9B1cYwyQ/R14YtCIdAoNzKZhgiJ4hG/t/1WqMUiFnvsHVNrpTR5gjokV0aXIZ664YVWnfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB3369
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the swapfile isn't created by pin and fallocate, it cann't be
guaranteed section-aligned, so it may be selected by f2fs gc. When
gc_pin_file_threshold is reached, the address of swapfile may change,
but won't be synchroniz to swap_extent, so swap will write to wrong
address, which will cause data corruption.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fs/f2fs/data.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4dbc1cafc55d..3e523d6e4643 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -3781,11 +3781,63 @@ int f2fs_migrate_page(struct address_space *mapping,
 #endif
 
 #ifdef CONFIG_SWAP
+static int f2fs_check_file_aligned(struct inode *inode)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	block_t main_blkaddr = SM_I(sbi)->main_blkaddr;
+	block_t cur_lblock;
+	block_t last_lblock;
+	block_t pblock;
+	unsigned long len;
+	unsigned long nr_pblocks;
+	unsigned int blocks_per_sec = sbi->blocks_per_seg * sbi->segs_per_sec;
+	int ret;
+
+	cur_lblock = 0;
+	last_lblock = bytes_to_blks(inode, i_size_read(inode));
+	len = i_size_read(inode);
+
+	while (cur_lblock < last_lblock) {
+		struct f2fs_map_blocks map;
+		pgoff_t next_pgofs;
+
+		memset(&map, 0, sizeof(map));
+		map.m_lblk = cur_lblock;
+		map.m_len = bytes_to_blks(inode, len) - cur_lblock;
+		map.m_next_pgofs = &next_pgofs;
+		map.m_seg_type = NO_CHECK_TYPE;
+
+		ret = f2fs_map_blocks(inode, &map, 0, F2FS_GET_BLOCK_FIEMAP);
+
+		if (ret)
+			goto err_out;
+
+		/* hole */
+		if (!(map.m_flags & F2FS_MAP_FLAGS))
+			goto err_out;
+
+		pblock = map.m_pblk;
+		nr_pblocks = map.m_len;
+
+		if ((pblock - main_blkaddr) & (blocks_per_sec - 1) ||
+			nr_pblocks & (blocks_per_sec - 1))
+			goto err_out;
+
+		cur_lblock += nr_pblocks;
+	}
+
+	return 0;
+err_out:
+	pr_err("swapon: swapfile isn't section-aligned\n");
+	return -EINVAL;
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
@@ -3793,6 +3845,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 	sector_t highest_pblock = 0;
 	int nr_extents = 0;
 	unsigned long nr_pblocks;
+	unsigned int blocks_per_sec = sbi->blocks_per_seg * sbi->segs_per_sec;
 	u64 len;
 	int ret;
 
@@ -3827,6 +3880,13 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 		pblock = map.m_pblk;
 		nr_pblocks = map.m_len;
 
+		if ((pblock - SM_I(sbi)->main_blkaddr) & (blocks_per_sec - 1) ||
+			nr_pblocks & (blocks_per_sec - 1)) {
+			pr_err("swapon: swapfile isn't section-aligned\n");
+			ret = -EINVAL;
+			goto out;
+		}
+
 		if (cur_lblock + nr_pblocks >= sis->max)
 			nr_pblocks = sis->max - cur_lblock;
 
@@ -3878,6 +3938,9 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	if (PAGE_SIZE == F2FS_BLKSIZE)
 		return check_swap_activate_fast(sis, swap_file, span);
 
+	if (f2fs_check_file_aligned(inode))
+		return -EINVAL;
+
 	blocks_per_page = bytes_to_blks(inode, PAGE_SIZE);
 
 	/*
-- 
2.25.1

