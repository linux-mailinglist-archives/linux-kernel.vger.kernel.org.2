Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E667D42B393
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhJMDbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:31:16 -0400
Received: from mail-eopbgr1300111.outbound.protection.outlook.com ([40.107.130.111]:64128
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237672AbhJMDbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:31:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KscW+rS+VvE1gLXXREJyBlIIaeN6N4RA0BUc1/5jHg6nld3vrO++oRDFFOJo/W0xjMu/GYiWegliAwoE2w7iI4q44J1kJz2jV/9cRtAlPk1PBsVG6SYPoSLByApt8BlbK5PDf8yxQcuMqfloDKFhtBaw5TjpOXdx8Y9o/4Ytck6oEhl1lnLaULXzGHIUbpaCoFMzzruUWC7uCRo9kq0p6EbJxtuFAR3NlbadzjhIUj6OiG+uKP3OSCa+wfEwOGJ+nGeo44/Ytm5fmQW7sPUUOnwdt8mSlyj0T7Vbi24GBbt3Y56yJ9wIu3pW6GL/sewSWYz8DxwrKdc2aCvySKhN9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXOxSFvSo4Ak0McdPaXaiGQ4cYiy1RRbZKwBvZnISlI=;
 b=Y5nS87wLmJAwLbstoWZ2MqhNDK2yQZzJWZIfzAR3SKrzykk5JvYBUTh1H4aWiFANXrp/F5q0ZcGMAAP322+zRW3lxEupwDqB8nCINDbkKZ9CU8ShKm94hFqTL5gwgU/7iczrAf9ZrqNjD+/jVsSEdXPppCKLj90kewFPibGxv14a+Pb3wybNHLgmOPpcIxqR48xO/CKQmet0yupHQorlBRZuq3bmaMfFESu65KGRtOwT/fRABcKRkWj+dkVkirhf0XWdMy+K9SVvPtUyo5HFiBDMW0r/QbwAPVrW+fu0VjsPg3SlE/2e1hI3CP+N62NJPg8rDCMiF9Q9zQ0fC8v4kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXOxSFvSo4Ak0McdPaXaiGQ4cYiy1RRbZKwBvZnISlI=;
 b=BsVM8q2ou+1iiJ7jOo+lx9WTZhabxedPnarF5/eGVTDKKKw3ZOD3o/3kaDXYAvxKbIc4khWlPHyC2uagEsKwtUD/2bcI0Fqfjf6ix4cql7DcGdNN5dsNx4Dgb6hxUyo0HbTBDDzbMM1Znzw9/NFjmhOi11slwu7/unWAn1dQrVs=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB2955.apcprd06.prod.outlook.com (2603:1096:100:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 13 Oct
 2021 03:29:11 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::4c9b:b71f:fb67:6414%6]) with mapi id 15.20.4587.024; Wed, 13 Oct 2021
 03:29:10 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc:     Qing Wang <wangqing@vivo.com>
Subject: [PATCH] f2fs: replace snprintf in show functions with sysfs_emit
Date:   Tue, 12 Oct 2021 20:29:04 -0700
Message-Id: <1634095744-4579-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:203:b0::24) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK0PR03CA0108.apcprd03.prod.outlook.com (2603:1096:203:b0::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 03:29:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a424a9f8-ad0d-4760-5d99-08d98df99f37
X-MS-TrafficTypeDiagnostic: SL2PR06MB2955:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SL2PR06MB2955C235B966DED67A87386DBDB79@SL2PR06MB2955.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuVx9/DFPUNq4yiew7pMHU5uP8ZQ0Ay7Z5x+k0hWpjRMbE8yaGxgCiIg3WNs/CWlo4i22zCCX5uovkQJUz3+TIghWuZYnzgiIM+Y1zojMniiz7wM6EeFYI+iSuUy35FtT+g5Hlgk9ZcG/Ae/aVZlVvS5jB5JZ0xblXxNfXFEKuHVPWWR1fcaGx/nelwJItvYt995RRsIb3Oua0kIry/d27Qt6Ev8F0nxQpYvSYEVAnT/qK1HmMd7KSMDd8lULl9c5zMYvD9NjBq+CdaTA6gAjTsZSfsNOin3iAUyyqlgpqNBQ4PKBztxv5jmaW7e6arsNUr0h2AnhDuup7Kmnzt4iRxwyZN0VBoycqROsJDbmXjAOmWd+6lD+mEnFtN9eS97gkF4ZkUDSJiwkb5MFiuEWn2UJgPTOdFzUyozk3L0uYZcFZxlT+36oMtoWGB+0spNLyX55jB76DZfQcML87qWA6Sv0Ms/pfSHnPQBjt5xXa5+T5V1rTnIapnBGyq5Kwf5OMQ3hc08ecfza2cTv9ozoTHs6r3jvOBH0m/zqSDB7YPyIe5PJ1FFELq4Aiu8Rm1PkpYcU8bVjOBvzrqBq5kRUeVgUtz7WJhSD/1YMfz95r9jB0hgDUOL0wniUvhqajCX7ouYM5sg16++d+4H1SRdFVDPdLP11E85ML1incoMu8orpQbyojjqywSgfdmHZg4S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(956004)(508600001)(186003)(6666004)(107886003)(66476007)(66556008)(8936002)(66946007)(110136005)(26005)(2906002)(6486002)(2616005)(36756003)(83380400001)(4326008)(52116002)(6512007)(6506007)(86362001)(8676002)(316002)(38350700002)(5660300002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eKnZnFdzbekFaN/4GgZYJzyoWRoi9PYqrgUIBfBuofKNwAkahJzc32BvustR?=
 =?us-ascii?Q?6daRPLGmsSmz/gP64/S9l0BfeH0aT9vLDrx06XFgDrYvw1hp+GL9rXc7xFGz?=
 =?us-ascii?Q?gyfABl5Y+U1aP+WS5RO3Dk+g3loAC7q/b8+sMygBvMw/RFRayvfAWKGHwGWe?=
 =?us-ascii?Q?ydj4OcLalzJDmtqJa/DLcVpkPv1p0e0BfUDoOWlRt2ZwBVxZoKadOzUYPqo/?=
 =?us-ascii?Q?rAmorV1xyRMUHBvFiMXz73gRRWhj3sH4i8TB8w80L8QXItytBozf5WBQ9gC1?=
 =?us-ascii?Q?pt8qJNAunxybsajFs6K0jGo/322O4gGt6kpg+1qMZYEwg9qWz8XoS3y0E5nl?=
 =?us-ascii?Q?sXVlCdBVpCwQfBQGN3n1FWOXvQX1K+0cY2AQ8gAQ1sYqv123dGJah6/yFb1i?=
 =?us-ascii?Q?RH6Xf7qZE0AZdHI53Gv3QS7QYcGn8iFquY6yVy9mh+Z6KLCpxP3qbf2A/k+w?=
 =?us-ascii?Q?WDZ45qNP2j/xSLPTHERA73zY/nMY2/IRoQKat4j+ro3Cde9TyDjBEH87JGxg?=
 =?us-ascii?Q?RcNjQixnm2gE/XQd4xWXV7vEHWdu2F8Y2qB6yQQb5QvkCyuMjOs0WFgVnQXl?=
 =?us-ascii?Q?jUoe679NQ8KQRwjH5XS0JeadvNHbpImusIBhrzK+lwN0aNMwCxxgOfTzuy4U?=
 =?us-ascii?Q?maeCGWc0cJjt8s2gjUHGtIc/fuq6Vc5z0vJzfY/nOI4ei4z8+pIO9Lqb8zCJ?=
 =?us-ascii?Q?as8bdmFBMASlb2+5qodSKOZweLHfpF8Jh/OSE5dOg9m+Ju7glRpao32+GChd?=
 =?us-ascii?Q?rQ7wssfR/MsyWV69OqQB9ca8IpxZQwA17tw36sE6y0UK6fyNOb3A7RMyztdE?=
 =?us-ascii?Q?rceWUGOnbdEWj3O5DhVm4Y8UpBCNVZPX7n9/6UrrWZMwtdCFNi2rMOJG+3Ij?=
 =?us-ascii?Q?Jp4pvkS54/0YbhFmOM3Ttp4mEbv+CF3zdmky+Jfe3jQbCoNtUfmb38hD81Rr?=
 =?us-ascii?Q?im23O6IllK6zmHC/TNJwWKS2iitP5+lXkNtOJMblJv9mKm21wKwr9AlG2n/1?=
 =?us-ascii?Q?C01VoldpAEbgonkp23stnoD3C3hjZoHti76bO33V7+pg5fgdScfpTeT4N6nG?=
 =?us-ascii?Q?J0KqR8IpJdFol8OS6CVeAUaQRzIhydrMyhR0aupwHTL3J+ebPR8MO1xymGZI?=
 =?us-ascii?Q?sjgSaUda1V2kVCh35B6N3GvzF4boEgvUg7FwJt3bsBjIjJkaedVF2b7tsoLY?=
 =?us-ascii?Q?vwH5gm9tBtZBZZ97whQkotSKObm6wZyrdtgdimBd7ZaOlDHDBF+dUUjJD8TN?=
 =?us-ascii?Q?k2KK9NJKLGGMf7TklzcYX996zVjtFx/y9XJfdtRSISAOLz3j73DFGoGfhUdD?=
 =?us-ascii?Q?48Rdm3qW8BPJouSe0M6mv7D3?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a424a9f8-ad0d-4760-5d99-08d98df99f37
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 03:29:10.8953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NSkZiOlx9IAXM+N2ifJuqGKCALjSp7LNqPIBXbjvZ7xeIvIiATVFRA+qZwxtQ5wb9gVeeXU1ZXRWNexvD3atSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB2955
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

coccicheck complains about the use of snprintf() in sysfs show functions.

Fix the following coccicheck warning:
fs/f2fs/sysfs.c:198:12-20: WARNING: use scnprintf or sprintf.
fs/f2fs/sysfs.c:247:8-16: WARNING: use scnprintf or sprintf.

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Signed-off-by: Qing Wang <wangqing@vivo.com>
---
 fs/f2fs/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 6642246..4ec3661 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -195,7 +195,7 @@ static ssize_t encoding_show(struct f2fs_attr *a,
 	struct super_block *sb = sbi->sb;
 
 	if (f2fs_sb_has_casefold(sbi))
-		return snprintf(buf, PAGE_SIZE, "%s (%d.%d.%d)\n",
+		return sysfs_emit(buf, "%s (%d.%d.%d)\n",
 			sb->s_encoding->charset,
 			(sb->s_encoding->version >> 16) & 0xff,
 			(sb->s_encoding->version >> 8) & 0xff,
@@ -244,7 +244,7 @@ static ssize_t avg_vblocks_show(struct f2fs_attr *a,
 static ssize_t main_blkaddr_show(struct f2fs_attr *a,
 				struct f2fs_sb_info *sbi, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 			(unsigned long long)MAIN_BLKADDR(sbi));
 }
 
-- 
2.7.4

