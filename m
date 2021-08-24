Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3CC3F5D5D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 13:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236871AbhHXLxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 07:53:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:6822 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234787AbhHXLxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 07:53:38 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17OBG7PM001041;
        Tue, 24 Aug 2021 11:52:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=HLKXcSt6ypzWwaDGc/EXJKn8Az1DAUk4l4L5+JiNxw8=;
 b=Kmi/RKX6SWEHy46uJlRUYLviUbT2arZCvCI/EbaFK+jsWpHaFcMteov/rjkD53ViQ3+a
 Zx4BeOy3mYFONXu4LgiLmda/LmWZZKuW2KqDwrGII6g4WzG9DXT0iyKKksqnHKsx6fI1
 CUE/k13uzELayG4s1m9Bzc2Fhz4irfCCPsE16Uhxthvzoi0XTjEsR1GyVhdM9iDFFTit
 9Yh1L2QzaZqL5zB1GifrrvvxhUKyJICyz6KcHcUd9Z18FFzG7us5M06KIN7kNgoXKnx6
 COI+Gel57IEdWMeHRSYlw0YjIHKu9UEuutQOHF1SCad00z+df0kOu0HYj/2oMY9ma6YQ hA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=HLKXcSt6ypzWwaDGc/EXJKn8Az1DAUk4l4L5+JiNxw8=;
 b=kxUyXaY+dPj1z5nOjgJbq7zfe6Cjmq0Z1Ks10d+bhIie+d+nBj9bLL+siKb39Okl3D8d
 90sGrr2MNxYXCJdkHyO64/aKobrn3I1AxP6X9howFZcTOWGZC/yvO/5JkzD8k9l9kUJE
 sTzpCcVUF4MQRdS/o1PSut4mj/guh8kGyBPbKYB/3ScIyqqYV/3TaOnpV3ZUHccIp0Bw
 lhYNXutxXQAfNVhn6szCz+iaRikMPejLLWo+5dXQG3wLY0vX2dndDeSdHpmDNVhbHAhY
 iGsRF1h6wOFLQLkCFV2fk72zd/E+QfrXnFB47NZSEJXKzd3VoSRBAum9Qz/2G/q5JxmS BQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3amvtvrhdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 11:52:50 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17OBjFpd100482;
        Tue, 24 Aug 2021 11:52:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2046.outbound.protection.outlook.com [104.47.74.46])
        by aserp3020.oracle.com with ESMTP id 3ajsa552pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 11:52:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW87cuSCdX6sVACzwsZ3CuO0NBNAUCt3Lm6pMCyLrVEugMY5f4c2+Y3mLVgIleMsiCIU6YFR2K3Su8cvi33hcGyCaRsOC1ffOEeaFTwzKpNR5eMGqFhBosXO7ox3Ndy4JdDc5f585vnY6aAg9d0cT3hfsbEvV2b0JxXD9oTmN72K8wAyEFo+NcyqB8HsuIcaC7MlxFG+ZiM54RRYdF+rG09ev7tLM+bWzQv8U+7+9jhZYCfN1VbCwKooKKcq9Pmu5V1vwUzdkXlQNkzRsmbdMVs626TNtgnupJlIjdrneaDpiEp56ku/t01NJ01Jon3h4a1LfejCIQyBPoH7ThQ1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLKXcSt6ypzWwaDGc/EXJKn8Az1DAUk4l4L5+JiNxw8=;
 b=gEPV3iyyaDMQwmO6ZkTWUV3nRvYMAN+KDGXYOPdK3VdKsBBS1D414lMiad9fVseo2rgzdm8xuUbvbnyoPecfJIJTyHoFp22wm6fZkENb2+2WabBARmqRtlrrckRbOYifmWnskX6IP0xtJUF5KNKXZTD+pb5xK8h0BNynwjPacOe+vvAihH5CAEq/gEL3c+2DrgKt1hF7Qi3/wE54/FlQ23Q3Budmy84Cd9dbYrxK75aJKfriv6K8hv7PGkfmxFjY7z3Jwhg+xHJ2AxwLH1JxIu2oQFRcXc7h4OkIOAAAtwzawBuIkNNWzA2G+zeJh5xQmUhyTZix+a1A76o+Af+jYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLKXcSt6ypzWwaDGc/EXJKn8Az1DAUk4l4L5+JiNxw8=;
 b=tGxG0I3YPFH5jyE124UjqXHil8Ucfk0cuTnOBmSme1H/tBIebfQLHJmi8m0KOatz+mMwktMBJD7feez5tehBrWWPodCEhKhDIGTc+tTCKplyS5KVzgK+AHJ43KyGKBDnk4f2q4Dm0HrmH+iT79U+oARiwj4MfGWvq0bMiUCNYWs=
Authentication-Results: paragon-software.com; dkim=none (message not signed)
 header.d=none;paragon-software.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4595.namprd10.prod.outlook.com
 (2603:10b6:303:98::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Tue, 24 Aug
 2021 11:52:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4436.025; Tue, 24 Aug 2021
 11:52:47 +0000
Date:   Tue, 24 Aug 2021 14:52:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] fs/ntfs3: add checks for allocation failure
Message-ID: <20210824115236.GJ31143@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0091.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0091.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:23::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Tue, 24 Aug 2021 11:52:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 743295a2-b7bb-4210-89fc-08d966f5b0f0
X-MS-TrafficTypeDiagnostic: CO1PR10MB4595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB459588A08179824623B24B498EC59@CO1PR10MB4595.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q4GvekiMfJ+qt995Ojb3HaB8MXpRfV+KBKXrMLjH1F9phQ6r6X+YTRTkIvjUf85ZbpKT2Hp9HxP7XyY73hi2dL9SP7Zue5KeTWm/9K1cwkF6YQ38acY2L7n4ltZfGcmd1/i2co3tLJlWELYilVq9lKtt2rZEhosUVjS0gWJFNpAzfjs1Pwzh1zAFCFWUPS+uMX7sJNu4ZQnrqpytSpaXYz2Enu1xENB0Q+2sNYLs2C5Qb3uVX+wlJ8hvfCu4qzdPlNhc5nsNyT9Ka7odxHBKsHkd6CUBnlWDGBLD5KPQu1WpF+MT7o0wX5PnEl/m1k3j2TkD+Xfv2JbB0Wj7zeUX5YEwkDlc3KVJfYegKfh6Gw6VVAs3Qwa+CM/eZc/icfr6TVE5jNjoNil+0Vmhlst3iCVoLLOtSJyz2+zSbIKghvsNYnwdl/wn+ln4RyAte+bWCVJsjIBpPOXPPCJ8KOS2GMY7WK/RadY+x/wVw7weOC/JylXIiBsQPQpt48C075oXHcONEs5hy8G9FCxTJZ7Sndaa63R9DhyM4vCAuc1lowk5LayBvWB58qIzYO6Hhru1Z9enmI+lnnvBHF17N7vHE6YaW2Rxp2layClsAdDW5B0pRAFayas//K8kyI4OKXW5NxGV9kyfzskuGlihB7O7JgzHS0MnIcQz1/rbQZvysqOqqb8GJzAA1WcnYdGN+tBuZpuOe36h1Q0fy4aHE0GYgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39860400002)(366004)(376002)(396003)(38100700002)(38350700002)(6666004)(1076003)(86362001)(9686003)(66946007)(4326008)(2906002)(6496006)(66476007)(33656002)(316002)(55016002)(52116002)(26005)(478600001)(186003)(5660300002)(6916009)(8676002)(33716001)(956004)(66556008)(83380400001)(44832011)(9576002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/o+5nQ/IFbaqbJtS9EZGX1OykpXtXbwjkWEdbFUfbxWGVCSP5xDNk0UyJRKB?=
 =?us-ascii?Q?rmZ2XOiCdz7PnQxCCCtbI+FttfQJ9dWZDIrNQJEvuVlF/TtU7Xy5Dtw+jyoZ?=
 =?us-ascii?Q?ffvgoPlyyYZVAfg4ukdV8jVqPO8gsihFEFbS2TWzlTBOWHI3Pn/oEOnw0cKL?=
 =?us-ascii?Q?D5UhlBqXs7dQuica+PF6zp3kbOW9OBmfWmvLWmuNHRNZLonn0p622VqeLcsB?=
 =?us-ascii?Q?FtISm1UP2t8w5t8kRf29LtRqBfHwRCssJDsgS4p08lHg5e6jS/eSlIzMBmBo?=
 =?us-ascii?Q?LLOan0YOIQ/qjpHvqwe34rHmkbhMzu4RiJPQc9nUOeqWaRe+TNUb72yvfsLw?=
 =?us-ascii?Q?xhdi6d9maxIOHE/5XUVHqDV9lByDPnIO4Zne/AAyZrYmmRjN4WUx6hBEpzQG?=
 =?us-ascii?Q?YjWUMQF54CocsyZ4J3QGnsZH/RhjOxqF7PES/dNkupxtzVGtw50NmO+Nfsqe?=
 =?us-ascii?Q?Y+2YJzegxakziQi98bdZ6dkDzXHwgTU3O92Hv1unSeD+W/n3YAjg6YGvFQOU?=
 =?us-ascii?Q?76uzynMrRD5XslvdgQPXuiAj0S7NFe4pscSYLF0eMH0IU1cXGgCT5UHFqEfS?=
 =?us-ascii?Q?ThflGLWVtiKo1vWW939snKJWTzG9CVaxcpHRnYJec8JMoudIiVc669n5/Jhj?=
 =?us-ascii?Q?iVXfnEBqtnibntLlfPFSxbXkxnziZtgvxfiZhIAVzBCHoosGhIepe+aeG09U?=
 =?us-ascii?Q?3lVtzj5Z+K9geBqK8TpzSFGVr6YpY7/MQ0XRVNThg+eMmbXqk/E5WcnEV8c+?=
 =?us-ascii?Q?fEJ7Ii762pvnLMap8MaDpCQ5KAofQWRd2ibcOrQIxM4Jg+JaWQwdtlTbqaK8?=
 =?us-ascii?Q?N/jDpejRPTLYpWS4Ix2CnSu4AN5icrOUHonasFOzV7XU0wsu/oN2kho6N0tz?=
 =?us-ascii?Q?2CGUCDBcB4HDVbzMtjKW/iJsxke9ScX7FwJvM40oZS80HDnitxAwIjWRK1Da?=
 =?us-ascii?Q?35GUl4Hhm8IpkBS8fbRTxO1yHWg+AUq04Yvl27WKlKYU7OU+nXJrEL+2Hqv3?=
 =?us-ascii?Q?PHsycv/t0d4bQAdxZRIn10m4u4S5Xn5yu+pxGM+6N/1yKboZMZjGPa8NhfFf?=
 =?us-ascii?Q?VTvCkwMXOjigvKq81oMAjpcqHIlPo8VM8Qo7qy0pJFyFfzpEDBkgHkPiRnJ9?=
 =?us-ascii?Q?ewOpsWqnkJop5rhPbT6wFalZLbQ5s468Rg0eVrHty5Js+5Hkw1YnHDv54NEI?=
 =?us-ascii?Q?y4nk2Ym8QFnx9WL5ptWUK7q/HkQb00tXjAIRVWd6kubNk4MveahY55Zwkkpx?=
 =?us-ascii?Q?4rKEIYtSS5rknm/oVYNblf4jyhB9hlb2ZLzFYUT8FeP8wZEx9FkuMmqAHhu+?=
 =?us-ascii?Q?zmOtK+9uQ6yovWP10LM7B/53?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 743295a2-b7bb-4210-89fc-08d966f5b0f0
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 11:52:47.3659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HbrQf3EX6YMrcf7QfhpSzS1I4ylsIev89+FC/IvgZi9DcCtcNV7GI01p1VGyER3t51OXoHECOORUoYtwCpMJOaSFQllcT/lMbDfR2OrdFOo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4595
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240079
X-Proofpoint-ORIG-GUID: BgFkqI8raG-amR3p8fnnosbWIF3PgSjN
X-Proofpoint-GUID: BgFkqI8raG-amR3p8fnnosbWIF3PgSjN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check for when the kzalloc() in init_rsttbl() fails.  Some of
the callers checked for NULL and some did not.  I went down the call
tree and added NULL checks where ever they were missing.

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/ntfs3/fslog.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 397ba6a956e7..209fe6ddead0 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -807,7 +807,11 @@ static inline struct RESTART_TABLE *init_rsttbl(u16 esize, u16 used)
 	u32 off;
 	u32 bytes = esize * used + sizeof(struct RESTART_TABLE);
 	u32 lf = sizeof(struct RESTART_TABLE) + (used - 1) * esize;
-	struct RESTART_TABLE *t = ntfs_zalloc(bytes);
+	struct RESTART_TABLE *t;
+
+	t = ntfs_zalloc(bytes);
+	if (!t)
+		return NULL;
 
 	t->size = cpu_to_le16(esize);
 	t->used = cpu_to_le16(used);
@@ -831,7 +835,11 @@ static inline struct RESTART_TABLE *extend_rsttbl(struct RESTART_TABLE *tbl,
 	u16 esize = le16_to_cpu(tbl->size);
 	__le32 osize = cpu_to_le32(bytes_per_rt(tbl));
 	u32 used = le16_to_cpu(tbl->used);
-	struct RESTART_TABLE *rt = init_rsttbl(esize, used + add);
+	struct RESTART_TABLE *rt;
+
+	rt = init_rsttbl(esize, used + add);
+	if (!rt)
+		return NULL;
 
 	memcpy(rt + 1, tbl + 1, esize * used);
 
@@ -864,8 +872,11 @@ static inline void *alloc_rsttbl_idx(struct RESTART_TABLE **tbl)
 	__le32 *e;
 	struct RESTART_TABLE *t = *tbl;
 
-	if (!t->first_free)
+	if (!t->first_free) {
 		*tbl = t = extend_rsttbl(t, 16, ~0u);
+		if (!t)
+			return NULL;
+	}
 
 	off = le32_to_cpu(t->first_free);
 
@@ -4482,6 +4493,10 @@ int log_replay(struct ntfs_inode *ni, bool *initialized)
 		}
 
 		dp = alloc_rsttbl_idx(&dptbl);
+		if (!dp) {
+			err = -ENOMEM;
+			goto out;
+		}
 		dp->target_attr = cpu_to_le32(t16);
 		dp->transfer_len = cpu_to_le32(t32 << sbi->cluster_bits);
 		dp->lcns_follow = cpu_to_le32(t32);
-- 
2.20.1

