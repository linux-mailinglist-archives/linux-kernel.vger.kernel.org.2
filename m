Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C7D3F5965
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbhHXHvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:51:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38258 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235070AbhHXHvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:51:17 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17O7LxnY021347;
        Tue, 24 Aug 2021 07:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=eGcNJwjf8troj3rbNf5FgbyjWL8i/B3u5TdkgUCrxg4=;
 b=jniEOik2f0933q85OdJLOH5CCtxqlglRekLP+A3XPXet7swHIXyjzI+uKHSHugNGkQGZ
 rtJpfXj9qHhs3UlH9lGsdpkv5rHrzRMcsrcdQmw0nIVM4jMs+VadZiRWZoktNW/m4fjG
 lbQ1RqlHH+zmUVIPYuPB96h3aokLsvxR+y7xXbikMpZOoY6FTz2yTCorTOKRwvt2seAg
 v+pZQUbIXmMEkGNNr2wcKkGE2bBp2qOm2XN8ebExyT82tIjKwLWnMriUy/jCB2u3X6HH
 JkTsTUzczw0XDj/WWsT+Lg7UWzd/s7gb8lllto7lILxMwtT53DmZufkQR8iIyIb3R25q TA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2020-01-29; bh=eGcNJwjf8troj3rbNf5FgbyjWL8i/B3u5TdkgUCrxg4=;
 b=PatfJ6QlfYR8r7L69dNrgv2xVwPkzLu1SL/SvKHXfEP7a59HcEMH8gKmxJw2bxfKfFPp
 XCsuddJbCR5SVJD4H01uvTRsDua8A4I670An46kiE4HF0OInb+ePfb0088E9P5K/Q/WR
 GXCG24swPXMMxIrkRbfIi9HMrG8RN1gBj54glgh3VRgj4/AyO7b9hUYbffg6LujQoSi7
 HUP1EXyBtVI4anQjJHN2kDOVMwSTPXOKU0kFu8+nkFtjfszM4Q3uv6fmFulP7k6XR9+2
 rDIKpbbnl2xOy5Al6QCAzBxKNufQddDt9D9aluHkHCt6M9awZt49qdvMyY6IInvOGqKu EA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3akxrebfmy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 07:50:29 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17O7jDt1135201;
        Tue, 24 Aug 2021 07:50:28 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by aserp3020.oracle.com with ESMTP id 3ajsa4tp41-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Aug 2021 07:50:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCIKlsE6yknuz7K6IBPe05vGqdeRhVYfLiEd4V4J6oGv9LpJ7eYkZVsA2sJ2Rhftbigl2w71GARE9M8w08dJcDar9skwzrVsi+lIM4Gi4Peuy4BBgSpfjbJa/4UeypGoljlQY85Nxe+uvZetcC7OVuULvCR2D4uzrcNNyceSC6MbCWF7FRPxFqpmxNi+viB1XwiG+SX4WwXjyjtN2GyKbwXUEH+ISVIminf6fSW7Z9A57i0hqJKsdQw66pVkFlWgqes+NdZFE4SSnPCErWeulnZNXc+ZCGrXIrFGZL9NskXWLE9jMbF9BvZqMr4/97pMR6vR7zCwgDphJpK5fFY5rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGcNJwjf8troj3rbNf5FgbyjWL8i/B3u5TdkgUCrxg4=;
 b=bqqH88gXdQU22dWkM6U1X4/ppDzw0SaIBcCyLcOzJmgeR4ronFyxL1uhK7DVH7zEJCBJdXx4KNxWBl2R+efc2cm9EHTwV/o9F/Z3gYQqhvoLQLVmF9O0jdS23ajs6GFRvBGA/i0h2WKbDW9XWq27yzBy05kigZiJHDsG/+6Cl/x3b3glP4ZgYd+W8Hhvvb2hWUP99J4+XDrDXy4JiqBVp9OuD3Fp+6qk/jMEIImejNAYI9OMSeEZUzMIHUqAYkMJstId1UhwyRnCuWJNOsPOdBc+2qcGC7ryN1OfWmfovErF/3uTS61yTO0KsGA+HnKpAtnb1nGCfsD8sN0DwcNi6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eGcNJwjf8troj3rbNf5FgbyjWL8i/B3u5TdkgUCrxg4=;
 b=SxrKBCy95q+P5oUYsPAFQ4V+qc3dEFl3sRVSpyXRSkY7s70e9rPzUrnCyP8C/0IPVj092T0A+0By+tcB/RPGEEhH/WQIztY/xXCYDa+TgbfPlS9B58sKdFv7MtZs8Rdx27KYN+Gqmp1UJQfzSFVEau3xMTSLnR/QAS8Z6xo5D8s=
Authentication-Results: paragon-software.com; dkim=none (message not signed)
 header.d=none;paragon-software.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1821.namprd10.prod.outlook.com
 (2603:10b6:300:107::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 07:50:26 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 07:50:26 +0000
Date:   Tue, 24 Aug 2021 10:50:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc:     ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 2/3] fs/ntfs3: Potential NULL dereference in hdr_find_split()
Message-ID: <20210824075015.GB13096@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824074932.GA13096@kili>
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0070.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::21) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (62.8.83.99) by ZR0P278CA0070.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:21::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 07:50:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a66223bc-9946-4846-b25f-08d966d3d5e7
X-MS-TrafficTypeDiagnostic: MWHPR10MB1821:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1821D44FDD2E2E02717C3D398EC59@MWHPR10MB1821.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: inbInqDjt9O4ynPb6TsE92WCTVX45BMXDvgZtWzvkxR8qnMI1e4V3vgu3ZjGjI0oQ24+COvgWr2/UuPp/Sc4Miire+UlTjIQUAxDHZk6iN1P/wteEGTsAkBKBwpQ4dbylX+IdJqH+vCsoPcWNZCubh1SYh6pKOL0EhAPTb9vfYYZcKbHE7d2zAChdQlRodRCn15lbn6wu/Sno3WHCJrXdfYiRtp8kLcktON5DwRWN7nNvaN8c6FzVrWMSApdteMewV3HZpuQXjWddKnzyuFlCzLzFFwQK+ohK0wg+kQoByt+gbhKe2J5vFa9QNwU6CLN1MR5hwf6rPDLLJ4ky8cDsVlSR6WrMSKjI3cX9eBdi9EouylVNshZen1rNAyZuSxoJbhNmXEOcahqSTulOhPL/WAHEWt3/NU8xLeV+xZVAMnU0dfG4N0It1yKgogydPJ3yaNAbNITSU+T/4Qve51s5U2xENAUVM7j4PL07eXCn3Vx3WYjGaCyr8XOfJQvx2Y6tQ/TPebGmMldpoMSp2qSdQql6KymOIQHMC2ypdOC2QvrBqa00wUqws5WKLYZAXxn7WGT4Vh7Zk2iIjX0khccRv4NT5WRN800HUmXz4hwrvrZQV8fGmirIWlWgQpdo7IJ4KR1SqNc3TKBx1qa+2VS2hiNT/RMCAjouposj0NakQQU8EFRhbXGU+pj8H241WvebO/37DpWcek/pGowuNzuoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(366004)(376002)(346002)(1076003)(9686003)(956004)(86362001)(6916009)(55016002)(5660300002)(4744005)(44832011)(9576002)(6666004)(83380400001)(478600001)(33656002)(186003)(26005)(8676002)(8936002)(6496006)(66476007)(66946007)(38100700002)(66556008)(4326008)(38350700002)(316002)(2906002)(33716001)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZvZ2o/e6JakhMlbcD3RiUgwkOojPQkdZG+qkdL65gyUzmFikDcq2s08XZN6Q?=
 =?us-ascii?Q?1a3kPJqebK9DVhaKfCKDadO44Azi7p+mvt8mLNjgH4LikiJ/lyBZGMtObonj?=
 =?us-ascii?Q?GEFIxzzmLyDMBZ3qPM2n66TDTVGmEDx2jyNOcS4oYI5GEJZrX2GqQtqAXwG7?=
 =?us-ascii?Q?w2ZYQZhidt3yxosgZ+pnmns5PxVwguQuTHF4mQ2OamUQWnQPuNJ1/yvx4FYR?=
 =?us-ascii?Q?zViNhT5vaUSpjyVUO3Tqk6jAeY2pz7SkgbA65NPu1nkHdFh9YMm2GEbYJC+O?=
 =?us-ascii?Q?RjCQ1S5vW+DDc4d8b5uduSlxOyZth1K3tA7il/JHvb4xbMkhfiXCqfH0T6Yd?=
 =?us-ascii?Q?G16XSM7hf5L0y3VmxDtoHm+Y8z0ZhGm5tvodkZyOoUo+RuzF16+PwSS/4+jo?=
 =?us-ascii?Q?RiT9oDsEfSUU7U/rL5s6y+8sf+JEX4g+6VKcfAt8zGR3Tb4xQnEVi2GX6nkW?=
 =?us-ascii?Q?Qzm3N9Nto/giZom+4dyUZDXNDSZMJmN0pHSGz0eYgKHtNWR8OzitVwEyiAvT?=
 =?us-ascii?Q?h/EPF623OdUn+958qCn1MeMufbcfEzPVCLmgueMWiCikYrkHC0Jn0fsUer1S?=
 =?us-ascii?Q?4RR3ds+VWl8Cv+nD0ORwPAP8CFBos9Z852phbRGxTN28Zlytos1gZaiU9CbF?=
 =?us-ascii?Q?ou92YGoc6RV7T1GiiSF4eOIJmzpekOiG58/m3ZR5li/ln/bIiFZjzz8k9Yf9?=
 =?us-ascii?Q?TxZ7ZGkqkYZP6IYTjW4ey64lhqeU6QZifwQbnAJlsf5Xf03fiP0rzHzXCG57?=
 =?us-ascii?Q?jAHPCbtw5BWGF3iV7mhYTV4hGhdBAMxk8pyl1uNHV16q+CXoODfaDTHv8AwE?=
 =?us-ascii?Q?5/pQtLqWc7eWgfA2wxV9uzS+RY4ruh/eRhkwm0+HE/65KOzBuLMX7mlkYVqR?=
 =?us-ascii?Q?ZzYrHpAByny3hvXJWGHGO05ETgnQPjQ8Aa00M8W5Q8PuBRvUUWI6mjDRWpIu?=
 =?us-ascii?Q?2UpzHZtimPqRkywlsBvKLsQV1+Teu9nQyEPwp6U7EIh/2qCiTE8P7Yact0eF?=
 =?us-ascii?Q?EZROqVJ8CktzS1HmHNGDm+uJgY86EL5r/kz+bDnMK/uyoeanfWZfeyMWFwWV?=
 =?us-ascii?Q?Sls/Cly3anfqB58iUG4HgXD5uOFWNsv/MdZUBjyUb6dVe9Rq7C4t0erHCyGD?=
 =?us-ascii?Q?v2o+9t6RL4V4V0N32BiCnzyLAS6W25Y6jbzsjGGm7dJwNydNCOm989Th+28T?=
 =?us-ascii?Q?xo93hS8tPzCzQ1hL53ifW+EpS3PvorwYTkXQ7K1lBLdd8vRs3Id66BUcVHpc?=
 =?us-ascii?Q?7mWSnsntPElZE6VwSjZilQgXYpBG5v2SCTnStaicyPseUp8OsRL9ZVGablqq?=
 =?us-ascii?Q?bxOEy3dMEg5MJydu2+UGWT23?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66223bc-9946-4846-b25f-08d966d3d5e7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 07:50:26.3689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPShRosP+OyBG0se0LxmAgO/0Ea6/DDH4VV+x+LuExWNoS6IQ2xKA+FW6auouj96KDfDueqjt32AlwuuVKATq98kw/y7EUIgTwuwOyCVyq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1821
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10085 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108240052
X-Proofpoint-ORIG-GUID: 9SM0T72zr6jo6Imd5B7zmoZCA5iPSFkc
X-Proofpoint-GUID: 9SM0T72zr6jo6Imd5B7zmoZCA5iPSFkc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "e" pointer is dereferenced before it has been checked for NULL.
Move the dereference after the NULL check to prevent an Oops.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 fs/ntfs3/index.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 07d6dee0a4ba..489e0fffbc75 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -556,11 +556,12 @@ static const struct NTFS_DE *hdr_find_split(const struct INDEX_HDR *hdr)
 	size_t o;
 	const struct NTFS_DE *e = hdr_first_de(hdr);
 	u32 used_2 = le32_to_cpu(hdr->used) >> 1;
-	u16 esize = le16_to_cpu(e->size);
+	u16 esize;
 
 	if (!e || de_is_last(e))
 		return NULL;
 
+	esize = le16_to_cpu(e->size);
 	for (o = le32_to_cpu(hdr->de_off) + esize; o < used_2; o += esize) {
 		const struct NTFS_DE *p = e;
 
-- 
2.20.1

