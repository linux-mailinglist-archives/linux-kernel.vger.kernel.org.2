Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A579040EC67
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 23:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240493AbhIPVW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 17:22:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20970 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235749AbhIPVWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 17:22:37 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18GK0IWO009079;
        Thu, 16 Sep 2021 21:21:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=fa4XamKFhDBigC5x33aJYAwIT8MyC+C1rH8EcMHY1pM=;
 b=Z3KOGc+b+p0S6Ft3PyQRTSSivmCKh2lABZyF6MiU5Zc+YF4wPsMQ3LB0VdWic1AlSTI/
 b8mMOhKihHSBigUzeiveYXXDPH21vg2uJs9sZ4laYbwGrytww7kYP+CY0sOJriSZwVuz
 ggbgQmnSsItIQDYQN0URHjbMx1j6pvnsYSlLUbTv9ICwAP/F/tTf8agOyBUu4wyKzznh
 47ijbNgZ3yLpu3jvSaL1V9hCW1t86bd/zug8oHIfwdmK7I4IX9gkH0KklYZq8mohg9tW
 uzJzORi1NTFI+r5UpzRtBp9nNd61nt53313r7FF/VGbH09bVOHMtSlPL/EMtkJpVqMEs qg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=fa4XamKFhDBigC5x33aJYAwIT8MyC+C1rH8EcMHY1pM=;
 b=CP+uSeD0IKCkS204haEI85UDRLXZlLMyHJYQy+S5g423iCkVOoJNzWRs4xI0DgKhtGh0
 uUnm+s3bov3BLPQl7CqORnPePkJYUL4L3KUDVIwBINbTahWJbUGHhhbWSG2ThYPFQpIy
 FKWFqMpksMLLwe7OmP+hDbMPgH9chYUuGR8sTNO3xD5aPsa93gU3E9x6TVRO6JpJbGqM
 YilXhNAIE4jShYKyTmSRDrLWHUqYFUqfuo7nVUOmvl245LQDhsblh0416fKTuUX/MrMn
 4/y00+IsncJuG43VwqyCec8YbxN3CCH0/90DmcZOp5KQuBfxBiiZBAEK7Fk5DV3CWolp 5w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b3s74m7wy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 21:21:08 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18GL5XNq011268;
        Thu, 16 Sep 2021 21:21:07 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2046.outbound.protection.outlook.com [104.47.51.46])
        by userp3030.oracle.com with ESMTP id 3b0hjyuvpe-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Sep 2021 21:21:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WU3yBPI48kI/b7IjIOn99CXAd57DkkOUEzMOaHxqTh94CnJ7Q8rP1pQrFn9UfVFX/AWP1M7qemnXo0hrH9QrIIkartnXnNYpZvCCbEpweXM4LKOQfqe05ivL4wvJDSU1KP43Ct/mmS8l+6oCRu7ljImd0mWe64HG6t7+Cm7fPLKEvy0lOSlyOerLClC6Oyf5zHGaT1Pm+RP8YGRnFnEF6EL2DozjO+Kzhaq66/URwGiAOmt5FF1gLI42bE4pTiLTauCF/gbuB/FItcRO8TIyR8sGdrWogwgOaXz64uPjs4YPVYYvRIFcBNrZO7UXCpi+8upN27yhi8TMPjrpnTNA3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fa4XamKFhDBigC5x33aJYAwIT8MyC+C1rH8EcMHY1pM=;
 b=DkSzFQiC6Wt8DQvrJS0fU+3r0KosuIkQA5Yiw4PJTzzWyfdVGn78shuljxMASJ8XXhaAdpPyyzz/UHVC+j/I0v3VXd9YWkOA0OYuJ5YvthpZ8Vcqr/2HyhT0V/w0Z0NndJScqDaX8YSBaUtuty3luodkHnNemRewhliSSKr9u2AhieWUC1tQTCxM30yP0pir4fXO17PaO9BXweeaICoKvpnmpEa89RVre6t3+PSs4bK80Iwdi7+CLp8LFT6TmNdaJnYq4jc/rtiyr1Dr87RBBPSJ4S2yDKRyARNoH/tc2sS7PaPGo1pNKuIK0qoLTtAPpZd7pfjpcFRcYfpTkEJ6FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fa4XamKFhDBigC5x33aJYAwIT8MyC+C1rH8EcMHY1pM=;
 b=z3UN1B9F9PusU4TjR+6bLTUujkVB4MNTVuow7zRaM/PRtp6AOhByHzcl7CwucjfDiR5CNq0veykddYixmTAj4+L2aEqhsm9sCTJX5+ArKywTonIN+8RHHlr9hVOMsMhBI7iS0vLoPXuGvO5WxyZouldOcHZhZNp7f77TrT8VNKU=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB3573.namprd10.prod.outlook.com (2603:10b6:a03:11e::32)
 by BYAPR10MB2935.namprd10.prod.outlook.com (2603:10b6:a03:8e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 21:21:03 +0000
Received: from BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701]) by BYAPR10MB3573.namprd10.prod.outlook.com
 ([fe80::5881:380c:7098:5701%6]) with mapi id 15.20.4523.014; Thu, 16 Sep 2021
 21:21:03 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 2/8] signal: Export ignore_signals
Date:   Thu, 16 Sep 2021 16:20:45 -0500
Message-Id: <20210916212051.6918-3-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210916212051.6918-1-michael.christie@oracle.com>
References: <20210916212051.6918-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR04CA0027.namprd04.prod.outlook.com
 (2603:10b6:3:12b::13) To BYAPR10MB3573.namprd10.prod.outlook.com
 (2603:10b6:a03:11e::32)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by DM5PR04CA0027.namprd04.prod.outlook.com (2603:10b6:3:12b::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 21:21:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20f82e8e-935d-45b7-4bc7-08d97957e37c
X-MS-TrafficTypeDiagnostic: BYAPR10MB2935:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2935FC76F5CEA7BAC5628818F1DC9@BYAPR10MB2935.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nbb4bB1OZsFMwR/qoh+KaYEtCrIXzHkHpsTzsiEEUUurzfM7lCjLbZD4BsFc8Uy+TLWt2DTfPlVPcB6ukqP0DSJ6VWniDAmkwuN3Xy+gDEX75bzoJCrj4m1pVNFGTMi6XhfcTu2gNkKUrB7IDqUbqjNMxQGjGPwRSwL5drBOKfjA/v1zVBXEdn5hZNr6gqSIyTSEbkMGNmQD6IR0VHgrbujMgSkxmggej8CMCbpVLhp3WnQvBQdxinixmBrt9jkQPLRdef48SGjxaJJgVoB2dpYRvuZcP4k/o3zvWqBVP4uPR+fhrs7fpWJub81mpYfWUav7ArsVu7WTR0tjX3wi8RH/gfOcjrUfpXMts8dLyTuuMrhEl6xUwwEIwxUOXg43r2sLe9FJTRxF8gMFHRR2DZcmxX0gfMKLNZcAQ/9ooMQ8QpYiT8mi7Ara+bWfekUu9RSBnCxytgKqpwfZK2FzuNZ3aIlVpAQk+UviFIUt5vZLyJ0TTx/m/mQNDRHGnhc0VjHi9d8ROw1OWF/zrTpxTLb2plc5BamWwrZkRNxwonZnUSXf36sMnPZm0oQDZsyaYkwSQoDu4GSmK9sUMh2jvSDgDo7nFsLToiF9aBNl8ZCC89h9dzDOXLfxb6g56ZUQjxz0UNCUJmC68ti1h8rsFzc+17EYFj9j5ms5mce4ej1gih0cNThSxKeQEOnP7aoHrtMvrOx4qWqJpb0Z3WWOpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3573.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(86362001)(36756003)(26005)(107886003)(508600001)(8676002)(8936002)(66556008)(66946007)(5660300002)(6506007)(66476007)(4326008)(6486002)(2906002)(38100700002)(4744005)(38350700002)(1076003)(52116002)(2616005)(6512007)(956004)(6666004)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wm8YyOy9zUxaAqJfO1MvB2EVM1hvnVKOJAs3jus339x24aHHPIdh8i2hgjdp?=
 =?us-ascii?Q?o4weIWWu9aKSsIcwNjHoyppQhmqFcrKRwStCX/DXRN4FnOzXsCOVLQDxef+m?=
 =?us-ascii?Q?h6FgpmPR6YVIdsjjLJD3hJJREmH56d5ell/zoeiNwlmG/3IxqTMzlf+z7+e6?=
 =?us-ascii?Q?eLMRwBye5b1EXgiRx3uARMzQMFPqQUAZqLZQX3A5Eu4EpyQopbDoDCf96ynY?=
 =?us-ascii?Q?oxQUgOkEMEYs+i507ng5HXHtQJu5g+g50oTOXfNq/A/4YXgqMIcx10/Ngm74?=
 =?us-ascii?Q?8sh7Smy0GU40OwGQK57HZeG5JOlGOBrVsucEekoqj7XKlj0YL3peR6DC7Sos?=
 =?us-ascii?Q?aQI8p68S9YbpEl6hvQZzpkI57tx27MVg8PfWXRAlWXtvxyUK7T1cp+tAztpQ?=
 =?us-ascii?Q?ufAf8lAWOqcAa583MwHn6F2w4JmFjvtH4glxVblkLdNMn3dWmzv4m92b8qO2?=
 =?us-ascii?Q?ROfvEbtr6XTOLRCXrxdtXHO9EEyNTsMo4BnFKX5xVzk/0oNd6Lm5CgOhmyU3?=
 =?us-ascii?Q?PVzvsGarPMkPm+lVcEHEXaSs89IL9n5+ZqsUG0grCSKxeNdQz3KTIsIUoi2d?=
 =?us-ascii?Q?/tIADiyrOapm9py2WAsUjsM89xig7Kvd7iV5zywItr5Y0Hnxnn73+yaB5920?=
 =?us-ascii?Q?qj7H2+LFF4cv0OtyEmqo8gxPlfOhRZTXwrrhrxFEjOPrs806XWWOw2fWRUkA?=
 =?us-ascii?Q?JKZB19vEZU5lzqLBjhwKSyEOSD10VXRA7waWWrvBdDiCWaCvTFRTbKKr5AeG?=
 =?us-ascii?Q?mSctIeP1sDq99emyo3NIHoaVF1N5tW/FWspMOq9oCIerX5NvUJw59eIT3NX0?=
 =?us-ascii?Q?kHXporYKpCef83wAzdqX/DgolOJ8hCFSWcyWp/sVIs4/U+QEesA4IbQslWyP?=
 =?us-ascii?Q?zoTFDa3MiWIIkuvTzd9m3b9zsO7YZeliuqLZxJZPASZpGkFVHszkubKTyTVq?=
 =?us-ascii?Q?QRLAAUcgawbmPjOVwHI7Hgy0G1iWbItDXhRpABY7yvjlvlCgobaSYTFFSvtv?=
 =?us-ascii?Q?2JY5PQizoyOGQ/ti2M1QsdV65qParNmiuspTb/Klv69AQ5HIZYa4aUqYXv0f?=
 =?us-ascii?Q?Obk0fPBH2HzihbGHQhgGChIdKCaqgo29PryHpBano7ZEY6gIe5at6cSBHp6g?=
 =?us-ascii?Q?7L9ATgTtO6PAcBhbMGCHCLWdDQf1qZ53FDlLwcj+xLXJtKYgxKoPZvBatTpM?=
 =?us-ascii?Q?qWjQm9gbe9l4QpNjFbfB4mfZnNQniKoTXH6Wm8vxrgMkpD7SK299zbS/3bmN?=
 =?us-ascii?Q?zxNGCzmwttlL6WaSzxxz2msfdIQgQv79lmKK6OdVKhONPqY1r5T5SCdJTkfJ?=
 =?us-ascii?Q?oUrl9otxovMSUG/+jocl6jvh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f82e8e-935d-45b7-4bc7-08d97957e37c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3573.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 21:21:03.7654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+3linx83aCXiEDkjzMRw8XlD2wPiuesyaTDu733n/IVqEJKW0HKfSbaeUTK8R9OfSPgsizcwX/dA7zikj8TPK+b3c792fFoly+hPUQv78g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2935
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10109 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109160122
X-Proofpoint-ORIG-GUID: 8bAZpY8_uf6UCa3lo8are1Utjfa0mlbK
X-Proofpoint-GUID: 8bAZpY8_uf6UCa3lo8are1Utjfa0mlbK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kthread API creates threads that ignore all signals by default so
modules like vhost that will move from that API to kernel_copy_process
will not be expecting them. This patch exports ignore_signals so those
modules can keep their existing behavior.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 kernel/signal.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 952741f6d0f9..8fb79200c18b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -534,6 +534,10 @@ void flush_itimer_signals(void)
 }
 #endif
 
+/**
+ * ignore_signals - setup task to ignore all signals
+ * @t: task to setup
+ */
 void ignore_signals(struct task_struct *t)
 {
 	int i;
@@ -543,6 +547,7 @@ void ignore_signals(struct task_struct *t)
 
 	flush_signals(t);
 }
+EXPORT_SYMBOL_GPL(ignore_signals);
 
 /*
  * Flush all handlers for a task.
-- 
2.25.1

