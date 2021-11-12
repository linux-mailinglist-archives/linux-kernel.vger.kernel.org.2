Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894FF44E04A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 03:30:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhKLCdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 21:33:07 -0500
Received: from mail-sgaapc01on2085.outbound.protection.outlook.com ([40.107.215.85]:53856
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231965AbhKLCdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 21:33:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I2uc6gLSKqveMJjRiJqVDG90jRODfyJuxqVGyGnJbYPVxd0qBMnFlmZxmBWTbIGeabx5zEJbDSpkUK02t3WkixOkXS77T8v3e1Yl95mID+UWke+zdy/xfOkaJ1xRvuwzCbCdEvEpu8ptPJCK5nDF638NLgmvh2htPgFVnpizY62zBHJWCWl6upwHRJePYqBo7KHYWgPrzFicr0wSVn9A14Iyyn1UB4wlBf5IQefv5McTjDw1iwz6MTRYBrNKo+OOvxgZVB12X6kq7GsQAnDH7hrce+zRtl5wGRFAEG5MCPZynz9ZJgESEM+7HgqVCPmipQSbqDt+CWWOCFSmptfVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyRUDTuRCm6dZlgZTtkI1xJOdyE2vnK6AYBNx0WC/Es=;
 b=RPh/JQB8q8u8Cv96N5axLvDFhpJbcouyExMyah8FAXFqCLJwSqICR4Ao4CcpMgWmeevtqDlOtJgqtLu4kWcBqpDcL8lB5Q6CyFPZf1n0HrL7FGP/ogzngi5Oaud2UQnmEc6rfus3pyztX65T6HtJcrHYymZwQDg998kjUj2NlX0j1qnhUSnMLp5OHS6JmUd9jj2xkayLwO6Bbi7B3NwJ83x2qd+VnMc1XztmSewnM4I/7lSb3+sYQo5uQYZVyCbSXKXfSmQ2H4QIEHs3lrHWA0VYkSj9emQqLEUIKdVVc7xE4F61bnqmWgkhGh+ggKKFerZdZtRkwnkHp4cH5rC8Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyRUDTuRCm6dZlgZTtkI1xJOdyE2vnK6AYBNx0WC/Es=;
 b=rUjPop+G5R9U6vsDCBVE/s7rG9KIGF8y4sw+tKcdwj6zS7rck+RMkr+y5gap66PJhlu4CBFpmNc5vj0Ka6EkcX063SVhzRurs3MXLoMFMpNIbOsdpq5Zf5qCqa9GmC12CHlgld1kP4e0MQ+BQInUN0qnI09pXyi2L/NuDHjBipw=
Authentication-Results: lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=none action=none header.from=oppo.com;
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com (2603:1096:4:96::19) by
 SG2PR02MB2384.apcprd02.prod.outlook.com (2603:1096:3:1f::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.11; Fri, 12 Nov 2021 02:30:10 +0000
Received: from SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988]) by SG2PR02MB4108.apcprd02.prod.outlook.com
 ([fe80::7e:59ef:bec3:9988%7]) with mapi id 15.20.4669.016; Fri, 12 Nov 2021
 02:30:10 +0000
From:   Huang Jianan <huangjianan@oppo.com>
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org
Cc:     huangjianan@oppo.com, guoweichao@oppo.com, guanyuwei@oppo.com,
        yh@oppo.com, zhangshiming@oppo.com, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/2] erofs: add sysfs node to control sync decompression strategy
Date:   Fri, 12 Nov 2021 10:30:03 +0800
Message-Id: <20211112023003.10712-2-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112023003.10712-1-huangjianan@oppo.com>
References: <20211112023003.10712-1-huangjianan@oppo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0181.apcprd04.prod.outlook.com
 (2603:1096:4:14::19) To SG2PR02MB4108.apcprd02.prod.outlook.com
 (2603:1096:4:96::19)
MIME-Version: 1.0
Received: from PC80253450.adc.com (58.252.5.73) by SG2PR04CA0181.apcprd04.prod.outlook.com (2603:1096:4:14::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 02:30:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96f169fb-6447-4701-01b0-08d9a5845937
X-MS-TrafficTypeDiagnostic: SG2PR02MB2384:
X-Microsoft-Antispam-PRVS: <SG2PR02MB2384C6763EF739311B24614EC3959@SG2PR02MB2384.apcprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljlJvWegxpgYo+GbnR+idsrLdPpxyaN7w237rN3wlS08noO9Rr34HBwnGieEXl3YT1upvOKO7zlbRMbuc+MBm9MXdJwVKOWQIgyNR2el7XMeFiK8O/6Sa7Wn+17xTSAPPicuugkaSnzd9Apv8vHsBAw+svKq8ZdKVED867Lox0XdzKvZ/CO0XaIS3jWIXHJjHt2FHQm5kAQ3iPUQd+/eQW/bUIHE4d40hyLyDGQKvB/HBx2QC9izTI/Eov+N/ncu3UKlPkdLoLEscjHKlqN4f8Dkd4ddze/XKJAISdChtEJZCr0u+PN709s456F8KbeA4lpXAD4zQAtjDKW53Sd/zcVQ73RlWXurC5rmJweBbxyRNq1T+IpcDmxh7Xy93iuz58EoWF+T/a6cqklFhUfSIlpRuOKpHnDh096a+DyWK/4NDrpxDJIb2fNf3OjcF6arZj90mlptSH7Cglt1WpoOb39MfJ3QMV85oPStxSoFXOyFF3Tvw04awpofjnhJWn98t+8xXBH7f8CfTfcTLL4B0PGHBHnQWHuBv8+c9JhKhNkRYqZy2/YAJtSGJLaEu2dmOtQct6tn3BmmSlswvpSjE+MpL+ahlHC9U3L9fUx86UsWUhU13NOwk/0zTpE+ETSTezrSbmCjomQY1TvccUDTUhwGS2s6wt7BChW/ocn2pOb+FWpvIAgJBM3C/ffs0WllOV7QknwuUxUENx7oFOjepWdQC+XqXRVKsZVvZiTqt6I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR02MB4108.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(6486002)(36756003)(4326008)(2616005)(2906002)(6512007)(956004)(8676002)(38100700002)(186003)(1076003)(66946007)(26005)(38350700002)(6506007)(316002)(66556008)(52116002)(508600001)(66476007)(6666004)(83380400001)(5660300002)(86362001)(11606007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4iYao3lS9xJE5y29HL7SdZ+8U1Kgoc/UAogr0Mgp6QjzBqR9KCtanvpFk3UY?=
 =?us-ascii?Q?cNDST02kw4EdJzuYLmbw+rQOVywbEpVlz33J6r9AOjXuylkR3YOjuGSdY2OE?=
 =?us-ascii?Q?5zuCfh2PdF5ldiF8B3QbTAADt9RQ1uyntRUH8Tyl9pVxawSf5n+v2Weu6FnA?=
 =?us-ascii?Q?A2Ct9VueOkyU5ig/k9fhID/xjUJ8S1n1C+bH3j/+FrWrS04uqNORuU/hOlNd?=
 =?us-ascii?Q?8RYcoq9KLGnvyN8XuimWwZrVB/ctwTl/29t1iNw+kuPExLMoOjJYAAXrAYUA?=
 =?us-ascii?Q?0VSSc8SkpYmQmx3A4k9IQcpqvoFw12jwpjggB1mLjq5oPa6WBJHs/KsZviMs?=
 =?us-ascii?Q?2DpzvzldGUzb0kuz1OflHtM5mMTN3fU/vSp/lY4wj0hnf/8Xc8/8/wyYdu3m?=
 =?us-ascii?Q?Tgx17yFgexYiOitnRYG+OuWgO/Gxi3SS0z5+6PkW+h6bG1zbUo2nj1Fh5tLs?=
 =?us-ascii?Q?lgxdn5Sf1UdBH6adT21kVhKKPUNK2H9ojJ2mPeU3y/wSdHrbdaOPlcPtcteL?=
 =?us-ascii?Q?tV1LW8t6DxMLDLjGu2XsCxbyeFJ/j96GnwZBgc5Uynn8eD5oy4yrS4RQ5Txx?=
 =?us-ascii?Q?h7uEcv1HejkM1ihfWSqmshsjtpGyGjTtwZzZMH8KEUmQ6LkMZqqEVJBitjAe?=
 =?us-ascii?Q?P2i+H3FiRen7QMyeyDHse5NoxhKXVr5AbKaA7FaiJ6eNTamkUPz5jLrUp6pY?=
 =?us-ascii?Q?9f10iaHhnzatjt3T/TB9w6n+aFGknvw1mhOZbo2OcXfIffSxgOC++qf82//x?=
 =?us-ascii?Q?l3nHz5REXH3Y/scj+OF/t9MxKwbE7eJuPPbzg0WOJ55vTmKl7HYsw7t+Lj9K?=
 =?us-ascii?Q?FyXt76WvrbgcYoFvddfQ/qFe+ggo0fWYKpOO5t9ThjEzchwHR8A3QBLSzLP8?=
 =?us-ascii?Q?73E8sHTj8KnURpzdi/le55XhLkdn5RbI3Zw8U78e1vtQBuj8LCX2TaWER3AK?=
 =?us-ascii?Q?VJs+6dbyLSQsdrY9sez4zv1tTENV0aoGbKwAj+UQ/eXrekPEPV8xna3cDub6?=
 =?us-ascii?Q?UqOoMT9GqgGREVXMR+OZfs8TtHYvm8CWxiTdeEhlIIcqPAcNt37xFdaNfqcf?=
 =?us-ascii?Q?ZuabYh7fU07hVLSmvIc2m1mTc25KK3UaAVuUP7do2IUAsoS3j9HVOHbaMzoU?=
 =?us-ascii?Q?3v44vlW9yW/wcGuHDyZLpEJyk0IB2aKXzAwfJbNFV309J8WUSrmmjzwi+5qX?=
 =?us-ascii?Q?nhEMFChA7W1QIlsLp+tSjgBaT+dAwpP6y1T6yg/91fFZx/QjLkJ0Jb5tqfi1?=
 =?us-ascii?Q?MRsSTqs0wJAtGkdrHh7c3qfFEK5SSBOoBFZGmcdasgItnMFaLvpveTMK9QCc?=
 =?us-ascii?Q?JHRlqlAq9JvwwRlWEKTDbhyMRKCXJ5Fd3QOAshsNOTl/LEfCYdL3k3mEy3VT?=
 =?us-ascii?Q?oWv+vMVQv0f7y3gNuEKUdMnXX22wLZ9KkwXT/riK/b6nNODyVMp4X+1wO/SE?=
 =?us-ascii?Q?iOlhHUkOi57MJ5GmDtYH2eHbNjhTONphtlP7sBWf4OAgoQA7ySobhXiS4oTZ?=
 =?us-ascii?Q?6coTXIoP7NQhKceYX3q9Ph9fvWcvk2EaJbgEaLVNvcZiTKBJOLToWaCqPwBP?=
 =?us-ascii?Q?ntBgoNMnaHsuDtAjnG9TV01Hoj4UQLrpknKB0wZQjI2V4rbUoSlXHKbBmGWJ?=
 =?us-ascii?Q?8u5g52fjg+0fGwpAcY1voug=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f169fb-6447-4701-01b0-08d9a5845937
X-MS-Exchange-CrossTenant-AuthSource: SG2PR02MB4108.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 02:30:10.3857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dbRw1ep/rWhhFEgAyS81Z8jsmCXN76ooqYWY9lDmWMzo+LJksYgUMbPxdMLyWFvjfgtGmiEJBTimDYLIcY1jiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR02MB2384
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although readpage is a synchronous path, there will be no additional
kworker scheduling overhead in non-atomic contexts. So add a sysfs
node to allow disable sync decompression.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Reviewed-by: Chao Yu <chao@kernel.org>
---
since v4:
- Resend in a clean chain.

since v3:
- Clean up the sync decompressstrategy into a separate function.

since v2:
- Use enum to indicate sync decompression strategy.
- Add missing CONFIG_EROFS_FS_ZIP ifdef.

since v1:
- Leave auto default.
- Add a disable strategy for sync_decompress.

 Documentation/ABI/testing/sysfs-fs-erofs |  9 ++++++++
 fs/erofs/internal.h                      | 10 ++++++--
 fs/erofs/super.c                         |  2 +-
 fs/erofs/sysfs.c                         | 15 ++++++++++++
 fs/erofs/zdata.c                         | 29 ++++++++++++++++++++----
 5 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index 86d0d0234473..d301704de79b 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -5,3 +5,12 @@ Description:	Shows all enabled kernel features.
 		Supported features:
 		lz4_0padding, compr_cfgs, big_pcluster, device_table,
 		sb_chksum.
+
+What:		/sys/fs/erofs/<disk>/sync_decompress
+Date:		November 2021
+Contact:	"Huang Jianan" <huangjianan@oppo.com>
+Description:	Control strategy of sync decompression
+		- 0 (defalut, auto): enable for readpage, and enable for
+				     readahead on atomic contexts only,
+		- 1 (force on): enable for readpage and readahead.
+		- 2 (force off): disable for all situations.
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d0cd712dc222..cd30d4f0bada 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -56,12 +56,18 @@ struct erofs_device_info {
 	u32 mapped_blkaddr;
 };
 
+enum {
+	EROFS_SYNC_DECOMPRESS_AUTO,
+	EROFS_SYNC_DECOMPRESS_FORCE_ON,
+	EROFS_SYNC_DECOMPRESS_FORCE_OFF
+};
+
 struct erofs_mount_opts {
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* current strategy of how to use managed cache */
 	unsigned char cache_strategy;
-	/* strategy of sync decompression (false - auto, true - force on) */
-	bool readahead_sync_decompress;
+	/* strategy of sync decompression (0 - auto, 1 - force on, 2 - force off) */
+	unsigned int sync_decompress;
 
 	/* threshold for decompression synchronously */
 	unsigned int max_sync_decompress_pages;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index abc1da5d1719..58f381f80205 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -423,7 +423,7 @@ static void erofs_default_options(struct erofs_fs_context *ctx)
 #ifdef CONFIG_EROFS_FS_ZIP
 	ctx->opt.cache_strategy = EROFS_ZIP_CACHE_READAROUND;
 	ctx->opt.max_sync_decompress_pages = 3;
-	ctx->opt.readahead_sync_decompress = false;
+	ctx->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_AUTO;
 #endif
 #ifdef CONFIG_EROFS_FS_XATTR
 	set_opt(&ctx->opt, XATTR_USER);
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index cf88e083eea5..821a73857d82 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -16,6 +16,7 @@ enum {
 
 enum {
 	struct_erofs_sb_info,
+	struct_erofs_mount_opts,
 };
 
 struct erofs_attr {
@@ -55,7 +56,14 @@ static struct erofs_attr erofs_attr_##_name = {			\
 
 #define ATTR_LIST(name) (&erofs_attr_##name.attr)
 
+#ifdef CONFIG_EROFS_FS_ZIP
+EROFS_ATTR_RW_UI(sync_decompress, erofs_mount_opts);
+#endif
+
 static struct attribute *erofs_attrs[] = {
+#ifdef CONFIG_EROFS_FS_ZIP
+	ATTR_LIST(sync_decompress),
+#endif
 	NULL,
 };
 ATTRIBUTE_GROUPS(erofs);
@@ -82,6 +90,8 @@ static unsigned char *__struct_ptr(struct erofs_sb_info *sbi,
 {
 	if (struct_type == struct_erofs_sb_info)
 		return (unsigned char *)sbi + offset;
+	if (struct_type == struct_erofs_mount_opts)
+		return (unsigned char *)&sbi->opt + offset;
 	return NULL;
 }
 
@@ -128,6 +138,11 @@ static ssize_t erofs_attr_store(struct kobject *kobj, struct attribute *attr,
 			return ret;
 		if (t > UINT_MAX)
 			return -EINVAL;
+#ifdef CONFIG_EROFS_FS_ZIP
+		if (!strcmp(a->attr.name, "sync_decompress") &&
+		    (t > EROFS_SYNC_DECOMPRESS_FORCE_OFF))
+			return -EINVAL;
+#endif
 		*(unsigned int *)ptr = t;
 		return len;
 	case attr_pointer_bool:
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index bcb1b91b234f..233c8a047c53 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -772,6 +772,26 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
 	goto out;
 }
 
+static void set_sync_decompress_policy(struct erofs_sb_info *sbi)
+{
+	/* enable sync decompression in readahead for atomic contexts */
+	if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
+		sbi->opt.sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
+}
+
+static bool get_sync_decompress_policy(struct erofs_sb_info *sbi,
+				       unsigned int readahead_pages)
+{
+	/* auto: enable for readpage, disable for readahead */
+	if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
+		return readahead_pages == 0;
+
+	if (sbi->opt.sync_decompress == EROFS_SYNC_DECOMPRESS_FORCE_ON)
+		return readahead_pages <= sbi->opt.max_sync_decompress_pages;
+
+	return false;
+}
+
 static void z_erofs_decompressqueue_work(struct work_struct *work);
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       bool sync, int bios)
@@ -794,7 +814,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 	/* Use workqueue and sync decompression for atomic contexts only */
 	if (in_atomic() || irqs_disabled()) {
 		queue_work(z_erofs_workqueue, &io->u.work);
-		sbi->opt.readahead_sync_decompress = true;
+		set_sync_decompress_policy(sbi);
 		return;
 	}
 	z_erofs_decompressqueue_work(&io->u.work);
@@ -1454,6 +1474,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 static int z_erofs_readpage(struct file *file, struct page *page)
 {
 	struct inode *const inode = page->mapping->host;
+	struct erofs_sb_info *const sbi = EROFS_I_SB(inode);
 	struct z_erofs_decompress_frontend f = DECOMPRESS_FRONTEND_INIT(inode);
 	struct page *pagepool = NULL;
 	int err;
@@ -1469,7 +1490,8 @@ static int z_erofs_readpage(struct file *file, struct page *page)
 	(void)z_erofs_collector_end(&f.clt);
 
 	/* if some compressed cluster ready, need submit them anyway */
-	z_erofs_runqueue(inode->i_sb, &f, &pagepool, true);
+	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
+			 get_sync_decompress_policy(sbi, 0));
 
 	if (err)
 		erofs_err(inode->i_sb, "failed to read, err [%d]", err);
@@ -1520,8 +1542,7 @@ static void z_erofs_readahead(struct readahead_control *rac)
 	(void)z_erofs_collector_end(&f.clt);
 
 	z_erofs_runqueue(inode->i_sb, &f, &pagepool,
-			 sbi->opt.readahead_sync_decompress &&
-			 nr_pages <= sbi->opt.max_sync_decompress_pages);
+			 get_sync_decompress_policy(sbi, nr_pages));
 	if (f.map.mpage)
 		put_page(f.map.mpage);
 	erofs_release_pages(&pagepool);
-- 
2.25.1

