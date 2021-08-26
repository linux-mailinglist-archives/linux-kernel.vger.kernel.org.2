Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B10E23F8374
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 10:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbhHZIAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 04:00:40 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.111.102]:59673 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233064AbhHZIAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 04:00:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1629964791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6RQO/yLzLGkPjusHyZXlPZBMrfon8W1kRS8l5j5cekk=;
        b=BtRspBQvEqg0N7nQjcy7mw8jhyy905fDNf3wIAH5ytVb4pP4a7uIU0hNsLJXnZf8L1W+MW
        xIFMtsK9eqmw77X5Ouc25wvbZQBctwuew9N4g0Rf4oMVITZzhmXO3pNX1Sn/OoKDfXhtDN
        80b++tjUP37d8q9/ndSEapiQW1K/hYA=
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur03lp2050.outbound.protection.outlook.com [104.47.9.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-30-njdv4tHxP66iWgKcPbpdZw-1; Thu, 26 Aug 2021 09:59:50 +0200
X-MC-Unique: njdv4tHxP66iWgKcPbpdZw-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BoVEROZhTO0cwUCgstq0mo/01c5SCB3OZosWzZHSICyfsFScppZaG+9AcQuociR11qXIn0JQ+bMwe6PfZeqpxfnHugoTlTQWOsF/tmvN10yIgeXJ26731blcLfDDROyBug9Caz1EhtzIVd6ho388SKyaZKpK8p3G6mM+sworITi0cPUudZdgx1yxcAg09BGkKPvjYPWpqCfAG5WuwESMWd9ApTdX8S6VGfx6deh4wpq5uEIF3t5sKw7wU9xtycLLq7t1Jrf2Q8q93UveDfjTxYuyGC+lg1Q3fD4KeTLSq08cXSpEfmvRCkkXHfcuEu1Sf6I0hv8VmgFUVi1akhAH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vyz1pn5TTGJ3NtBCuQ/YzMkYN6vvXKxA0c3OoRshbtY=;
 b=JLz8qY+QQ4dheJ5TfxgDFg06uIQEaUw74HIq34Ko25h63mdsuok30gzkb9maQZRPDYPTBZhQltyETAAhbe/foYjf8ZqlfR5Lxzb82psxVIzpdiYTkHb4CPunjIbrFoWgKog/pdB2MAWQ34AY8oYAuL2ZfEKioEOuzy4yKpCz1MoohToNRZ+cJAoh3kS8mH1A3PnSUG3hQxofJHwCeyGFTdo/kW3ICqN8duncQwdHSGNv2f6th6j6KEvjg+WRGE1cyss48RydwdvM/AEmIsseMy+KWoG6ck9E0T7KSZLv/lw2wItCV8YgC16ZTq9W0tA96WAf3b62AIR1Bwn9LCLfog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: fasheh.com; dkim=none (message not signed)
 header.d=none;fasheh.com; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com (2603:10a6:20b:f8::21)
 by AM7PR04MB6903.eurprd04.prod.outlook.com (2603:10a6:20b:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Thu, 26 Aug
 2021 07:59:48 +0000
Received: from AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71]) by AM6PR04MB6488.eurprd04.prod.outlook.com
 ([fe80::793c:6276:4f2a:4d71%4]) with mapi id 15.20.4457.017; Thu, 26 Aug 2021
 07:59:48 +0000
From:   Gang He <ghe@suse.com>
To:     mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com
CC:     Gang He <ghe@suse.com>, linux-kernel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, akpm@linux-foundation.org
Subject: [PATCH] ocfs2: avoid getting dlm lock of the target directory multiple times during reflink process
Date:   Thu, 26 Aug 2021 15:59:41 +0800
Message-ID: <20210826075941.28480-1-ghe@suse.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HK2P15301CA0006.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::16) To AM6PR04MB6488.eurprd04.prod.outlook.com
 (2603:10a6:20b:f8::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (60.251.47.115) by HK2P15301CA0006.APCP153.PROD.OUTLOOK.COM (2603:1096:202:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.0 via Frontend Transport; Thu, 26 Aug 2021 07:59:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1e442af-d05f-4abd-2432-08d9686779cf
X-MS-TrafficTypeDiagnostic: AM7PR04MB6903:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB69035FEBE1E0CB4538AE2E3DCFC79@AM7PR04MB6903.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1824;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mStsIO9FaI3QxTl/sVHtP/MOXzYpOXfO/CsKNhbj0mw6xN1s15ICbA81C6/Pb3kw1O8rHIJJk/NQe6EAuIiL3lv4t0EQetGoOKvGwTncO/HS6luLKS2N0Sh2mV8obKG3f3sMe7J9odp7iRa6ktXG01C2ip0s7/EZVqRRpsGStLbon7BK/wizZgoIQTJBfL0Kqbb9Sir/aZkD1VmqV6FnNFCDIu8FnyhS8EHtte/qBKzP+d1J54f/II8ySMnfp3TbJzKRFP2ZKPQ5Bhs/X5zY3MtzMViCl3fs0TtnNhc6+HeEgTgCuwQTvu9/VNeYOvEgPdhAMyIBJ/dncd9Nfy6mcSgmNowEqM7sI3kSHVuyHJ5V2qU0OXp5BPh4n/rGUKqnpCiUQukwyP5WqPmBhbEweUKuBhNHX5/Yqd+LXE0g4BmkmmycI5szEAugNYgXe6WX6jvwWe+3Ny4qAZsU8OQQoXGLJahj6Qd0iMIniL8Z/JfK9HwE72/jow49egWQz/md3tMAttntCM+o4y82kxPS8tr5iQ5HMNt9Rtv8qMPa2GA9yxOadPUr/Z+XFatqvHd6rCNMr2TXTHquYGYcfOPA4r3baas3w1nzy+2qvaMZthV14Pfp6Xbpi56ZypvL++B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6488.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(366004)(376002)(136003)(346002)(396003)(6666004)(66556008)(66476007)(8936002)(6486002)(1076003)(55236004)(26005)(186003)(66946007)(5660300002)(316002)(2906002)(6496006)(36756003)(4326008)(956004)(8676002)(478600001)(83380400001)(38100700002)(2616005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tg6vGyIniHucAF1FC0SAxHkAQqCxAxc0LII63CElIas+6Ck9l7IdFhSvyU6J?=
 =?us-ascii?Q?C3zMGeu/SkOrMA3QI7ySIU8pAwqmFmcrzAeDBwWLaLSGu5/7VpSzdbsgkrN2?=
 =?us-ascii?Q?aazeFxYsiZyMN87kFrRUCfe1+VQKKII7PaVBFh3naUA4Fj7WAaD9secE9hMu?=
 =?us-ascii?Q?RttBJdcrOf+tJzR19JX9RVr9mcp57fmRUfW3T5QMwCF3VskYNHzZhFcORxh1?=
 =?us-ascii?Q?rKZG9f8vgXeX4KKCiozEEgibV2MO5P6MDRzIO4Xhkj6Fag1PqfY3reJCPyol?=
 =?us-ascii?Q?vY768R1HHrW/BZIMIVfcbYlckZCU6CzrA6+gFzXWL9oYo29TasYbZtuE2rJU?=
 =?us-ascii?Q?uiDlI6xRYEJH+hDDcTzkX+/FzUu1xylJz6oCaaSw0WcfQD4WRaVvg55qcAM1?=
 =?us-ascii?Q?kJ2o/R9ZZv9ZwT/TE9TfL6LH6sz8C8DYQaCsh+0xD4cevfk2Doe2aXse+OWt?=
 =?us-ascii?Q?WToxqo8YjBVPTMCfk3EwWtJkglKziYSaDOjRFh6SNiPdVxW8Dbwch1ZjIoL8?=
 =?us-ascii?Q?uW/U3VvtD9B1SgIzCzH1qottPCfwZwvWEBASk248DJ9+K5HNBzFE5p0cRl/g?=
 =?us-ascii?Q?liltz19gb6RSgwNOvrba+ZgzIqcFOI1F9fIlYMsuNo2GLUI2I0xbLqUw9tw8?=
 =?us-ascii?Q?eMtNa782zTlkSbluC95r6/PInCwRw2dH7NBI0mpDOP+dDAqJsQmKIQoYZT2b?=
 =?us-ascii?Q?7EuRwrqTF3+lacuA7sXhiNIGCyehsq8CcrnrVDPS5KjFhrR5kAOwQg4Brxff?=
 =?us-ascii?Q?05wkTIFeGssZHfs/faT299Gn1+XYvwfn6ZP0HK0nz2IKxBLpxREbKAJzTJdh?=
 =?us-ascii?Q?z5aFsDgvBPTfJNGwVogjqvMNykB3684Q9ZxPKTZe/qmxdG/hD0Wff3KeQWTF?=
 =?us-ascii?Q?3gooAn1NJGsnbDair6cOgsRoYkp4Qqhry8a+E/qWXVmR2sq8aEVmBmm98rx+?=
 =?us-ascii?Q?W/WmvXa8LQyIP+lAS8P17sPlypGwVLChKkmRTZ42GGy9keINAbiaRM9DAaA9?=
 =?us-ascii?Q?BHM4Rfr0c7KyRGlO9gol+aiGpQ5SLPmjWOCqXx9FcEvAoEr8U0aTSBu+QBeX?=
 =?us-ascii?Q?cll/Nh7eXHyhR0wuClhr33AynLKq1vBr033ac/u19CLSD1K/OvTW6Buytiuf?=
 =?us-ascii?Q?tAJMxi5FxnCpxk3gfbk67X4PlYsK5oGrr97v5dypnsrDA68HpVd8pQkLUaQ4?=
 =?us-ascii?Q?kZjNc2Q1y5Ofkt2EqEcdnfDsRZfG7hW3QM1iue9zf5Ld0l03AjBPsUy9+k09?=
 =?us-ascii?Q?02gZj8r1XWuPTkaKityWvx2Gjv70TfL+hhfXar6iMk+dOt7r0u+FT0F9g6Kk?=
 =?us-ascii?Q?PYjQJDANc/oaJHYrts5BbAId?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1e442af-d05f-4abd-2432-08d9686779cf
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6488.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 07:59:48.5123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/dAXM6uk//lWn9WAHmvchYWhBMbp1djhuSpqGx+Tjc3cuJMFpuymAeYYNrMMxXp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6903
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During the reflink process, we should acquire the target directory
inode dlm lock at the beginning, and hold this dlm lock until end
of the function.
With this patch, we avoid dlm lock ping-pong effect when clone
files to the same directory simultaneously from multiple nodes.
There is a typical user scenario, users regularly back up files
to a specified directory through the reflink feature from the
multiple nodes.

Signed-off-by: Gang He <ghe@suse.com>
---
 fs/ocfs2/namei.c        | 32 +++++++++++++-------------------
 fs/ocfs2/namei.h        |  2 ++
 fs/ocfs2/refcounttree.c | 15 +++++++++++----
 fs/ocfs2/xattr.c        | 12 +-----------
 fs/ocfs2/xattr.h        |  1 +
 5 files changed, 28 insertions(+), 34 deletions(-)

diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 2c46ff6ba4ea..f8bbb22cc60b 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -2489,6 +2489,7 @@ static int ocfs2_prep_new_orphaned_file(struct inode =
*dir,
 }
=20
 int ocfs2_create_inode_in_orphan(struct inode *dir,
+				 struct buffer_head **dir_bh,
 				 int mode,
 				 struct inode **new_inode)
 {
@@ -2597,13 +2598,16 @@ int ocfs2_create_inode_in_orphan(struct inode *dir,
=20
 	brelse(new_di_bh);
=20
-	if (!status)
-		*new_inode =3D inode;
-
 	ocfs2_free_dir_lookup_result(&orphan_insert);
=20
-	ocfs2_inode_unlock(dir, 1);
-	brelse(parent_di_bh);
+	if (!status) {
+		*new_inode =3D inode;
+		*dir_bh =3D parent_di_bh;
+	} else {
+		ocfs2_inode_unlock(dir, 1);
+		brelse(parent_di_bh);
+	}
+
 	return status;
 }
=20
@@ -2760,11 +2764,11 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_super =
*osb,
 }
=20
 int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
+				   struct buffer_head *dir_bh,
 				   struct inode *inode,
 				   struct dentry *dentry)
 {
 	int status =3D 0;
-	struct buffer_head *parent_di_bh =3D NULL;
 	handle_t *handle =3D NULL;
 	struct ocfs2_super *osb =3D OCFS2_SB(dir->i_sb);
 	struct ocfs2_dinode *dir_di, *di;
@@ -2778,14 +2782,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *dir=
,
 				(unsigned long long)OCFS2_I(dir)->ip_blkno,
 				(unsigned long long)OCFS2_I(inode)->ip_blkno);
=20
-	status =3D ocfs2_inode_lock(dir, &parent_di_bh, 1);
-	if (status < 0) {
-		if (status !=3D -ENOENT)
-			mlog_errno(status);
-		return status;
-	}
-
-	dir_di =3D (struct ocfs2_dinode *) parent_di_bh->b_data;
+	dir_di =3D (struct ocfs2_dinode *) dir_bh->b_data;
 	if (!dir_di->i_links_count) {
 		/* can't make a file in a deleted directory. */
 		status =3D -ENOENT;
@@ -2798,7 +2795,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
 		goto leave;
=20
 	/* get a spot inside the dir. */
-	status =3D ocfs2_prepare_dir_for_insert(osb, dir, parent_di_bh,
+	status =3D ocfs2_prepare_dir_for_insert(osb, dir, dir_bh,
 					      dentry->d_name.name,
 					      dentry->d_name.len, &lookup);
 	if (status < 0) {
@@ -2862,7 +2859,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
 	ocfs2_journal_dirty(handle, di_bh);
=20
 	status =3D ocfs2_add_entry(handle, dentry, inode,
-				 OCFS2_I(inode)->ip_blkno, parent_di_bh,
+				 OCFS2_I(inode)->ip_blkno, dir_bh,
 				 &lookup);
 	if (status < 0) {
 		mlog_errno(status);
@@ -2886,10 +2883,7 @@ int ocfs2_mv_orphaned_inode_to_new(struct inode *dir=
,
 	iput(orphan_dir_inode);
 leave:
=20
-	ocfs2_inode_unlock(dir, 1);
-
 	brelse(di_bh);
-	brelse(parent_di_bh);
 	brelse(orphan_dir_bh);
=20
 	ocfs2_free_dir_lookup_result(&lookup);
diff --git a/fs/ocfs2/namei.h b/fs/ocfs2/namei.h
index 9cc891eb874e..03a2c526e2c1 100644
--- a/fs/ocfs2/namei.h
+++ b/fs/ocfs2/namei.h
@@ -24,6 +24,7 @@ int ocfs2_orphan_del(struct ocfs2_super *osb,
 		     struct buffer_head *orphan_dir_bh,
 		     bool dio);
 int ocfs2_create_inode_in_orphan(struct inode *dir,
+				 struct buffer_head **dir_bh,
 				 int mode,
 				 struct inode **new_inode);
 int ocfs2_add_inode_to_orphan(struct ocfs2_super *osb,
@@ -32,6 +33,7 @@ int ocfs2_del_inode_from_orphan(struct ocfs2_super *osb,
 		struct inode *inode, struct buffer_head *di_bh,
 		int update_isize, loff_t end);
 int ocfs2_mv_orphaned_inode_to_new(struct inode *dir,
+				   struct buffer_head *dir_bh,
 				   struct inode *new_inode,
 				   struct dentry *new_dentry);
=20
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 7f6355cbb587..a9a0c7c37e8e 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -4250,7 +4250,7 @@ static int ocfs2_reflink(struct dentry *old_dentry, s=
truct inode *dir,
 {
 	int error, had_lock;
 	struct inode *inode =3D d_inode(old_dentry);
-	struct buffer_head *old_bh =3D NULL;
+	struct buffer_head *old_bh =3D NULL, *dir_bh =3D NULL;
 	struct inode *new_orphan_inode =3D NULL;
 	struct ocfs2_lock_holder oh;
=20
@@ -4258,7 +4258,7 @@ static int ocfs2_reflink(struct dentry *old_dentry, s=
truct inode *dir,
 		return -EOPNOTSUPP;
=20
=20
-	error =3D ocfs2_create_inode_in_orphan(dir, inode->i_mode,
+	error =3D ocfs2_create_inode_in_orphan(dir, &dir_bh, inode->i_mode,
 					     &new_orphan_inode);
 	if (error) {
 		mlog_errno(error);
@@ -4304,13 +4304,15 @@ static int ocfs2_reflink(struct dentry *old_dentry,=
 struct inode *dir,
=20
 	/* If the security isn't preserved, we need to re-initialize them. */
 	if (!preserve) {
-		error =3D ocfs2_init_security_and_acl(dir, new_orphan_inode,
+		error =3D ocfs2_init_security_and_acl(dir, dir_bh,
+						    new_orphan_inode,
 						    &new_dentry->d_name);
 		if (error)
 			mlog_errno(error);
 	}
 	if (!error) {
-		error =3D ocfs2_mv_orphaned_inode_to_new(dir, new_orphan_inode,
+		error =3D ocfs2_mv_orphaned_inode_to_new(dir, dir_bh,
+						       new_orphan_inode,
 						       new_dentry);
 		if (error)
 			mlog_errno(error);
@@ -4328,6 +4330,11 @@ static int ocfs2_reflink(struct dentry *old_dentry, =
struct inode *dir,
 			iput(new_orphan_inode);
 	}
=20
+	if (dir_bh) {
+		ocfs2_inode_unlock(dir, 1);
+		brelse(dir_bh);
+	}
+
 	return error;
 }
=20
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index dd784eb0cd7c..3f23e3a5018c 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -7203,16 +7203,13 @@ int ocfs2_reflink_xattrs(struct inode *old_inode,
 /*
  * Initialize security and acl for a already created inode.
  * Used for reflink a non-preserve-security file.
- *
- * It uses common api like ocfs2_xattr_set, so the caller
- * must not hold any lock expect i_mutex.
  */
 int ocfs2_init_security_and_acl(struct inode *dir,
+				struct buffer_head *dir_bh,
 				struct inode *inode,
 				const struct qstr *qstr)
 {
 	int ret =3D 0;
-	struct buffer_head *dir_bh =3D NULL;
=20
 	ret =3D ocfs2_init_security_get(inode, dir, qstr, NULL);
 	if (ret) {
@@ -7220,17 +7217,10 @@ int ocfs2_init_security_and_acl(struct inode *dir,
 		goto leave;
 	}
=20
-	ret =3D ocfs2_inode_lock(dir, &dir_bh, 0);
-	if (ret) {
-		mlog_errno(ret);
-		goto leave;
-	}
 	ret =3D ocfs2_init_acl(NULL, inode, dir, NULL, dir_bh, NULL, NULL);
 	if (ret)
 		mlog_errno(ret);
=20
-	ocfs2_inode_unlock(dir, 0);
-	brelse(dir_bh);
 leave:
 	return ret;
 }
diff --git a/fs/ocfs2/xattr.h b/fs/ocfs2/xattr.h
index 00308b57f64f..b27fd8ba0019 100644
--- a/fs/ocfs2/xattr.h
+++ b/fs/ocfs2/xattr.h
@@ -83,6 +83,7 @@ int ocfs2_reflink_xattrs(struct inode *old_inode,
 			 struct buffer_head *new_bh,
 			 bool preserve_security);
 int ocfs2_init_security_and_acl(struct inode *dir,
+				struct buffer_head *dir_bh,
 				struct inode *inode,
 				const struct qstr *qstr);
 #endif /* OCFS2_XATTR_H */
--=20
2.12.3

