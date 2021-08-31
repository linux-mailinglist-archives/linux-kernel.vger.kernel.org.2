Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE43E3FC2BF
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233995AbhHaG04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:26:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:21452 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233665AbhHaG0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:26:54 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17V5bKpo004719;
        Tue, 31 Aug 2021 06:25:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=qTu1uyQL9Hxx+XqQrAAWKU1S0IU5A4fIwRSUvusi3Vg=;
 b=V6BxaP7zt9/P+txPOEKbPvwTSXYP2DXg33oTE2Le14eplL83vQiR0QOkTfVFM6Uk7gyU
 ey3zBW6UQ/THzpz1Z4grmF4oIhiulc9V0lyC2URMkT5Bt7LC3vrJd/zVuD1mlbTH4Haw
 XVDngCygpT8sIK+rwgjy7VBrQUCrgD6DMKN49xenTbHZCkaV2Kl6nhIydHoq/7avbis6
 YobhDllSR/yAhAhtl5BSFYpSescqaAfSXWbiN9oP89sHka1/hHI3T3e3ybs/Ah1KvSal
 3VHLQzonq+ZB4fpYai//i7ZiPosKBh9jbehxQCONZLIc7M7tSt4ADdqSq6vm9uCVjpxf wg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=qTu1uyQL9Hxx+XqQrAAWKU1S0IU5A4fIwRSUvusi3Vg=;
 b=HRhu4i6crAVI2wL5Ci32HKP+tWPNhLgwMwpUuUEK3R+ewfwLpUIHTMLxoxJj4KqjStaH
 4xHSSrWqCjVv+0v7TyrPxo9NpIvEkRtVCUOCKMRpiDd/no161NiqklcK7bG9nIyarpOl
 xF8qdxhfIvSCtBZ5lC5hTxsPtx0yeLUmVP9Lx8HiFY52po9/Be2WyWdPheHb/zEpcqlF
 3zQvDm3KwP0YpFr+Bt4LGvqRECgNa0LodvqX5E4LLGEJIAIA9vSE4qrmweuhIoWxwfc6
 w5y5+F/ILau8P+BxYfB967kXi0NHRy9RUIbB18L0eb5wgp/AYBSxA2BZ5IbuyoEtr3bf zQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aseedg3av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 06:25:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17V6FaNM118963;
        Tue, 31 Aug 2021 06:25:56 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3020.oracle.com with ESMTP id 3aqcy459ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Aug 2021 06:25:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpybHpV9PnSVLQ9x8ts7bY+VP9Bx7X+cqUI2mqQu+FRhZ6inM/CGBgZhatdyQlDAG38BaTDuuj5KqcixufsRDmKQdxD6JaEoQETDLXzhau0NWwv0ZqZHDQkcy8hV7FyzTkoRFknc0eTx3U/+tX28ekwJDJ6o+lY7BX1FozXAaIxOL/9jSlN/7Gk4hPMI9HJbaCmJf+IGqROPSBAB/mHKrBNBs+YOGtwXR1fyFwsnWPsKAc2txgsRwtv/DJ4H4WFZRNkfqCBAnJZHDXUqgUFkKrAzL/RYleZPD0s2FN7u41m/Uoe4sximUs9H6/U7D7Zh0SbolDRUrsIjhZPwGcMkSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTu1uyQL9Hxx+XqQrAAWKU1S0IU5A4fIwRSUvusi3Vg=;
 b=j8j/CodZ8GC6KiaUgirbzplh+VuI98TWLPsqV69aqCxvLScT2rX67eUx6pL3QQRvjSOnzOSPrzHjq8TuDhIhPy7yEmkKnDfDOjiGI1hwiHh8Rf4sSER3oKDb87NzTJgByP+4joj5kPlnv9Z13/zi3LeZUCLfKQfeI0V4DkS9ovlinadFzfUbigTg+BLIc7HszdfetGb9hhJOyDdD+4TrO25ejgBYROwZkHrFQ2Mb0UdcDsYbDFMnb7F7xgJsC8vfOCY42xT82WV8aX9H7O5y28oE8f6RgZ4qjjU4FNFeY/o/VUi4/Iy3cotNpXje9h+11Oizv0Pcuteqjo9ZMby/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTu1uyQL9Hxx+XqQrAAWKU1S0IU5A4fIwRSUvusi3Vg=;
 b=LZANHbt9YxRFqli5wEOocMiUBHhbSw6cKNYfoMbriNGO9iNsM5URiFWmrrcQnO+Hxq7Ovvuxzz6106M5PEVXgQxy5YIHdnVfFOjGHWEvnLDmr8YGsPZRyPVX7PSq0lqS17lJc5vjla4gejwoa8ONgHzm/su/b3fr8eQgFLaCz3I=
Authentication-Results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1999.namprd10.prod.outlook.com (2603:10b6:300:10a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Tue, 31 Aug
 2021 06:25:55 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::c8e:2147:b83f:79db%8]) with mapi id 15.20.4457.024; Tue, 31 Aug 2021
 06:25:55 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     cl@linux.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] lib, stackdepot: Add input prompt for STACKDEPOT option.
Date:   Tue, 31 Aug 2021 16:25:38 +1000
Message-Id: <20210831062539.898293-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210831062539.898293-1-imran.f.khan@oracle.com>
References: <20210831062539.898293-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYCPR01CA0009.ausprd01.prod.outlook.com
 (2603:10c6:10:31::21) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (110.33.47.182) by SYCPR01CA0009.ausprd01.prod.outlook.com (2603:10c6:10:31::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend Transport; Tue, 31 Aug 2021 06:25:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 132ff869-6e85-4c68-3bd6-08d96c482fdf
X-MS-TrafficTypeDiagnostic: MWHPR10MB1999:
X-Microsoft-Antispam-PRVS: <MWHPR10MB19997BC71BF21F1C3210F951B0CC9@MWHPR10MB1999.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78mSMbFWCVhEv2sa++5YRUqquLVJESf1liJ+j6twQ0ROS0n6vCHzrAEwxR4gkKlBRhBVF2NR7/pcYJxkVEUgU7RIkVeFfh5F5DaSxadsGrSeO26lGCIj5cEd75V4/ciZjsdzmyKn/t1eJ2tW6KJFuAA2NT566XINM1vtPvCFSI6UBd70gkZDJAUEWshvfnhNJbnsgbHsn61kudX7sZAsrjv+Fnd3qGvFw3kvAchlKVnlkK9TVDT0CWCZmpNknTtpt81GFz2zs0H7IV9VAgMZrQrxmDkut9+zgEBwgLafD1KyRqSp5Wllaek8WmVFvb1oEQFHdQAfTthX7gnb6x1yLv1/6UxjyXIwc1zOz8nLCMSbT5b7zWO0SPku1eXRgMELGjCs8a9gzDEhCGMFZJiAwDmNAMNQgJf9iyA5dwYsDnJNyC+Jale2Vi8YA5GwQY447rv3zVtsJ5lSYfsgX583/LYN0INjyzqQQYEpc1vZ4orxuzxXTOvyEJHhcOXOZsgWBRfGcCazHI/Y+wX00xOF233L0j5WKbjpo+typdO+utbsGtw4s8rxxVWkc0l8WZ2imAZ8+a1meeD51cu6JSaVzQERv2gaqbyBF862IgB9/l1xQDHxoAijLe06kDU8w4m8S/z+f2qnnzTBuM0USeGDAT+rhCgfnEGIebE6q7mCB/5kzbWwhYcDPQtMIgFBN/iOxNLiLDhRiF8HDJGrJd3M5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(136003)(366004)(346002)(2906002)(956004)(316002)(86362001)(2616005)(5660300002)(66946007)(83380400001)(36756003)(1076003)(4744005)(4326008)(6666004)(66556008)(66476007)(8936002)(6506007)(6486002)(52116002)(38100700002)(38350700002)(8676002)(26005)(186003)(478600001)(6512007)(103116003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ss3Otetl3NvoLMMXiXvM1Y4ns/aPUQ7TWkgKAy+1LbNbAGcJi9PCwCqgVtmM?=
 =?us-ascii?Q?1x/+GLixKqSyhaYdcuOiZPCe2xJ8LacTVgArsBfg5LyRHIbvdhX6aEprOhve?=
 =?us-ascii?Q?GaOvDvqXhdLVVQKt8SAOJUjqEjPQbzj2ePtnpjXMBsMXvMhmpN78WNAciODd?=
 =?us-ascii?Q?0x5RzDV6gPdErlnveyChMHttCvsJftOwb+xAR+NMkDj2IVJB6ypVirjUYvIn?=
 =?us-ascii?Q?PR3tsRPU+zPS6fRDTrKPrub02nxut1YBdz/8copqmpJOj/REaGI2zbp7w5dG?=
 =?us-ascii?Q?dZla74spXEhF0hsSSzigMn6DYjS5W/azh+PNRwXBv7bXqQ5aUfHjBE18iJf+?=
 =?us-ascii?Q?h/mbV9K17bYBJdKAbyVLUKEk2rlkoZxha+cHJjj+HzEV7CbYAImdZMXzDD3U?=
 =?us-ascii?Q?nDLp37kT1gume9P7w6jkupNH9ScRWxzd//ECz/JzcohGnFehQZCpdkc35uwv?=
 =?us-ascii?Q?5MfVanYCOEw4Qug3fhX6ireOxhR10zG3VW46//d43O4VZfB4qJjV/UgsdYhS?=
 =?us-ascii?Q?R3ADa2h3YuUIPo+zzka2WFQPi5/89rGbJdutvAYnXUSycYDD95x2kNXNF2/e?=
 =?us-ascii?Q?E19q9speFGdI+pp7aX9RQVcUP3R0cOWIv025Dk9xM6KeR9dokOJ1/KGbAgJH?=
 =?us-ascii?Q?B1QE6WG0VFvCndjYR/WruHZ6oglyWZqQbbFvxO2BMraHX8fr6P35ZJEvP518?=
 =?us-ascii?Q?BkS3P03Q8lGcsg8R2WYdAWhBEPNPUNizSWpgyJpikBPu2O0yHnQQMhcEpUOv?=
 =?us-ascii?Q?/5AB8jrRLwFT8uiLnyhWd9Mz1v8u266yoyFNOxZYj26whb+h+sEWU9RlTNGO?=
 =?us-ascii?Q?ScEs97KZBNF9FuU5Tajoz7/4iQLqgJqSH7FfhDnuxiSFE3d+JCMj/mJUkBQi?=
 =?us-ascii?Q?eeXiagTTpMbVAeHBmt7H6WAoBx6dJ7krYEmZ64xGnwayJK1jduJz3KU8mPKh?=
 =?us-ascii?Q?tPvNoa9jfX/I6UPLCG50r0Oja36uZ7iNRzRPeg6uCmDW/bFGmk8TXbzboIUw?=
 =?us-ascii?Q?0Fx2tMygtFe8ZgegOHbP1FFWpDwoj9g7rda3g+55ObszRNHbG62A2yE4THWG?=
 =?us-ascii?Q?SS94X0ralmG0Ot+zjzlrOEFCSzt1ITdr1NZrlBQjeCz2acA2EGkyEgseJ70z?=
 =?us-ascii?Q?54NLip/GaTRToNaaoeALl75xdjVcwfFaoPV5SwS3lbP5+3WE1xP4RhFzn+7j?=
 =?us-ascii?Q?sxwdy0JxwwuoC8bHV3hfBbzm+EQYb4qLACaVVsp5JsVu31M/M8KXBOQ0kljC?=
 =?us-ascii?Q?aWLc3Pz0OUY4bkSF4AS1ftKWaeJe11T5223xssCK2o/4RE60oCDAcvSL6FKv?=
 =?us-ascii?Q?rs7uYdeog0YQl77kv6iazW5N?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132ff869-6e85-4c68-3bd6-08d96c482fdf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2021 06:25:54.9515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qikhlfi10cHojQ3MYBcZ2rwbhzaqT8rS8iVRIuJASyc+0KR3U+0sGBgexcaCfrYN0pOn3WTtRTKx95fqJ0v/dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1999
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10092 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310036
X-Proofpoint-ORIG-GUID: iilkF5PjJ1SkGIqzgpo4F55blElBk9zU
X-Proofpoint-GUID: iilkF5PjJ1SkGIqzgpo4F55blElBk9zU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So far CONFIG_STACKDEPOT option was being selected by
features that need STACKDEPOT support for their operations,
for example KASAN.
Since next patch makes use of STACKDEPOT to store user tracking
information for slub debugger and since user tracking info may
or may not store stack trace for allocating and freeing contexts,
make STACKDEPOT explicitly configurable.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 lib/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 6a6ae5312fa0..7e4b54f48af7 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -665,8 +665,9 @@ config ARCH_STACKWALK
        bool
 
 config STACKDEPOT
-	bool
+	def_bool n
 	select STACKTRACE
+	prompt "Enable stackdepot support"
 
 config STACK_HASH_ORDER
 	int "stack depot hash size (12 => 4KB, 20 => 1024KB)"
-- 
2.25.1

