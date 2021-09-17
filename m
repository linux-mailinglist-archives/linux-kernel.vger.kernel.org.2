Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DFD40FDC0
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 18:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243913AbhIQQTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 12:19:30 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:46138 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239719AbhIQQTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 12:19:08 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18HFwoUJ025075;
        Fri, 17 Sep 2021 16:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2021-07-09;
 bh=5BEXF3gFR2RfoPlsJDo2KKrAM3maaEWmWygHWH4CSy4=;
 b=qTUJTsUSRb5LMb52lMGdQdgdlk1bi2Yh0LitLlKjNUMLg8Dq62ytJba5sQBPVybOhdRG
 xDHyHPCdWNWmqcaRC4bEtrzuJtOtwnQXrpFNG1uubQ8bjzvx7XqJVfcgPtA9LB4DSSBQ
 LK5CYtGhxIoYbQj41XMrdV1VOpCEeAA15nn/hOirkCSQF3lApVSpwb2iMiVMSQtiQS8l
 PcDriN49CgyqKW3UWZqtjKz7UFwAmGyEZJvAe28TM8x4a66ktR8TxIHV1tluKopnjOLE
 yRtxg29FEFL8OsnhahFA4elKdt/bl9r3ODTr1qXAehC6E4yKxF+7dMKkcj/aM4BJPO30 IQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references : content-transfer-encoding :
 content-type : mime-version; s=corp-2020-01-29;
 bh=5BEXF3gFR2RfoPlsJDo2KKrAM3maaEWmWygHWH4CSy4=;
 b=ayzvkT9rg6eyXg7acDy4EK2qNm8gZBrCfa0TAL8sOF3IIzDOF7zRby4jcRh0/a9xyGMn
 KFnbtuKG5GH7hHoT1JamIkvFDnca9JzIpgrnmgCb6X9wRPrgHDXo4F+i3QOxao2gUrGF
 G/K4vjWAk5TuUwRYe/Iucj48SefcxcSGlaWO5io6mFpm4r7jg3z5MhDrHl0EdU2w+iSv
 5zg0sjyLscrF1T14A85Vu9OmPLcp8d/8mhnVx74K1+JlK5x7AELNVPTFvDvdqrpldKJ1
 kfIHfjVl9WwcVnUuekiqb+TaBlQwyG5MKwaAcQxLg3Jebx3KJhMEAb0P3c1L2JqeuGWP UA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b4u8srubm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 16:17:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18HGAhHV012571;
        Fri, 17 Sep 2021 16:17:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3030.oracle.com with ESMTP id 3b0jghujj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Sep 2021 16:17:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiEFMKmclG56jipBThjHBbVCvIcYx6EkCZpqwkpBTP+x/GgHWpakwHbAjQBcEa3T+tiUlzXoyj/90dYqPymqAjcu4zjY8DEiwdw5rP7ffUuQH7/CHFikKzvYn839Cq5eVAHHQl1wMmJ0xqKlBUpVF3kMiLsUIrWL0isP7Uxd5LwFdaLrUPggwXaAKVy8W8A2FBIVksIfPgp0tPqiPGo7NfA7BGbAcLFxfFDkIM9sUaFhSwGnFPMPnMBqOdOVMbaSMYlMMov0U/xoD8m76JGGms4PQLXdTrgnPXaqGawGCxt/ydA6jn+t74lQqYB8g7ZBwxF6VHiMFfES/SpRKwi78g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5BEXF3gFR2RfoPlsJDo2KKrAM3maaEWmWygHWH4CSy4=;
 b=H0NoB4If/iiDYHgHNS4i6POeJuiX25Xiz3PJ0QdYFN8YNEnN00O0Cg0XPVHHL/LiK4DkPvRbLprb+aMiKZag1CAbID1SyDjFpJvOKtkL+z7fs37FNxz8Vxdrms+odvrjKeMkm663Y/eLKx7U34CXT5EC2lf0BuDHXG1FaNOFAxQT4uAhPdDD0amhH2TY+UN8DDRPZcjJHBkeTp1R6/jOmejKbmJovun1UvDCiGtaOvFwXAKMWK3XXctwoz8Xxd537HTVOU6zdjN1AjH7wAS2Yzw98YcI0mOBXnfALZVCVtJoHElAa0yg9VBoUQ2FqqhqBft6DUMujBSsOUrjP9DFpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5BEXF3gFR2RfoPlsJDo2KKrAM3maaEWmWygHWH4CSy4=;
 b=zpL8nOFCE19E9RKV+/SZRyUhprS+NWQDaOrxXD/bWZxApxi3kGN10JS4FxJWtOsddByOIExJ54X1fb/lgOJtj4lWbf7F+hcudKkvcCZXCDoq+BxkTxlxZe6ZfGAgahLfGp4DtWPv3xnEbgMmRiliVm7lP/xibEhSegx1snUmzmU=
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
Received: from BYAPR10MB2999.namprd10.prod.outlook.com (2603:10b6:a03:85::27)
 by BY5PR10MB4065.namprd10.prod.outlook.com (2603:10b6:a03:1f6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Fri, 17 Sep
 2021 16:17:09 +0000
Received: from BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c]) by BYAPR10MB2999.namprd10.prod.outlook.com
 ([fe80::cdbb:4673:98bd:7f2c%5]) with mapi id 15.20.4500.018; Fri, 17 Sep 2021
 16:17:09 +0000
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     torvalds@linux-foundation.org, konrad.wilk@oracle.com,
        linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
        roger.pau@citrix.com, jgross@suse.com, sstabellini@kernel.org,
        hch@infradead.org
Subject: [PATCH 1/2] MAINTAINERS: Update SWIOTLB maintainership
Date:   Fri, 17 Sep 2021 12:16:51 -0400
Message-Id: <20210917161652.2431563-2-konrad.wilk@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210917161652.2431563-1-konrad.wilk@oracle.com>
References: <20210917161652.2431563-1-konrad.wilk@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:f2::19) To BYAPR10MB2999.namprd10.prod.outlook.com
 (2603:10b6:a03:85::27)
MIME-Version: 1.0
Received: from konrad-char-us-oracle-com.osdevelopmeniad.oraclevcn.com (209.17.40.42) by SN7PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:f2::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Fri, 17 Sep 2021 16:17:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c0dc24a-4b08-442d-078c-08d979f69952
X-MS-TrafficTypeDiagnostic: BY5PR10MB4065:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4065153298484588CC80331D89DD9@BY5PR10MB4065.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gytZ83VAqQFPxzP2Yn5h3Hq7m41q7a8/1hmS42xxTyZOUQMckt7bcs3zjhNdAQo/ZcyoBQJ+hjNpyhVlXFFRjMNq30GVXsfdi4wCYCoLsjsC7jnQ6HPKwRWMKDWsDIJNiV5qq/Ffiqi2Xw45Uz5xSIfS/hfGuPGQASekxuU+/dF5fc2ifjU7mzx4srW01pSZO5FYTWJNCfaoste8DyBsYP8Rabdnzskik6N4Gs7QbrhVbaskhavQZ4CYeEVC6jK1tlEqrOVL4KCgC4pbMnJbPjvPjBkn/OB/YJe/qQ36HYP7So9VHqP4F3cfZPaA+Xz3zCJYOOkjW7DzRnlCZ3W2ea6MgIzy0NhGxsd4H0EUfBZ1KWoyA1iitKOjXTUYsCCqa1I4DoqOEdjl1cuOT8mE7T3QdblJoASdXXwYx4krwtiJ1hJP2pTnRPtFuvfnD1sa/5gqLdCNlEJNjVCd7pd6KodSiUR1Ef++FrZLzW4Soyk7FBcP7eJ9Zcd8R5M0PTB4jvgnMTOXUMba9Hgs06i9nuwTHbXmTrqXiK1zaWyiJ0cy+ksSR1QKyEHmO98owTHHVLoUl11FR3q1wORxkc5NVP1bd0zVwEObkHJ3ydbPOc6P9Gar3arPO3Ww5ZLTTU0sTH6GG7WkGFpKxfppuorMSnSvKzdyfqNRsKdsF5X6n7VqJ/lwXdG6UoCCimWWLrMzWLOAB9IPfI1gy/Zta+wVhwzbkfJEU67IusSaclnQyU7RgWPqfNeu9umR7d1Nm0HjNeGzMnfShkki82wICJoGhi9K13trIiCGprsPFHEQjLU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2999.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(346002)(366004)(376002)(6666004)(966005)(186003)(8676002)(86362001)(52116002)(26005)(8936002)(956004)(2616005)(1076003)(6512007)(38350700002)(66556008)(316002)(66476007)(66946007)(6506007)(4744005)(6486002)(38100700002)(2906002)(5660300002)(478600001)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qp7ygQF4ASQiEinsQXcMcqFf8vFHzwrj+CNQUXYTfGc1xH9drM+LQrrayf6y?=
 =?us-ascii?Q?pDp405BTJlNpzAKPCdjLZtdELc/oop5fbtQ/rYh1MD20eNKZKZZ2U9FPsQs6?=
 =?us-ascii?Q?SjkwC2YncpYWVWYrfPU5UVePiPdjXHbRmHTIMk3KhUBV31KAOVvhq4yIfznN?=
 =?us-ascii?Q?5e7ZrH0zQA6K293Id2Q8BmllNEEbwDu4CmFDhB1mZVE/gOlbYIeuxnV7UUCv?=
 =?us-ascii?Q?aqvycI2jMVPbPjiDCS7xyOnZsfnnvDBH9tBlT6nRi76lNa7cmmUdDCllSxaK?=
 =?us-ascii?Q?JJA4RgdpcwU/XFEY42WHq22zRYdGFoNCv1K/6YO7DwjmJAkMA3J7VFnvdTmw?=
 =?us-ascii?Q?bw4LxOlUjG9FS9LSasfHUSRa3/n07IuNW+4P9sNUq5LUCRMLlHVBOGRKBWqS?=
 =?us-ascii?Q?Xkb/sZ3gFKVmbmLfgea0OG/HaWjzySV0l0PjNM7MON9EwVzJHh6azoT3abgI?=
 =?us-ascii?Q?XSYer7xQUVugDsVaFnl+7fA49vf1fhZ7iLFgpyvAaGi6dJyUT1lf/VRNpFgm?=
 =?us-ascii?Q?PS3zJYX0WSR5kW6QFSbczuoG7JlOz+5FPdjfOUFFWlOBFAN3uhQYi7Q60Kfv?=
 =?us-ascii?Q?sHsGbdQ1aRIGkkp4Fq5ADgtuXnQN1c7hOBXSSWxxxRX8JL0NWxWPevf6GkQz?=
 =?us-ascii?Q?MUK86QVHggdhFYbheKGwmbsPugRsMbJ12ZnX1e12ahYRoPmx+NBwlDAVXBM9?=
 =?us-ascii?Q?gkNc8V3/WI7RUVqMnbM/Bwy5eR573NLMNyxHGhlrX7xD6WWvaxbDMrWom/kv?=
 =?us-ascii?Q?fTX7oxr/btLOz5X1rtSzYt5vccVbyOvCm6nDgf6YzAxjJKauptXSnExf5NRO?=
 =?us-ascii?Q?rYLANUsfzm0gaTkkpc4bdMmPC0Pjo51Y/Feoz3OOM991mGuml3EeIzJgU7cg?=
 =?us-ascii?Q?9jDC4U/JFnOmFwxQRKwJSF9z/u0bVlFPnNVpkREq3DR3MJ+VDfUyR2rIu4iz?=
 =?us-ascii?Q?UOF//kL+ujvQU3md61fx90Yy3dMJTfXrFZnJ2BDbj/jz6BHX4PH90v8qp9Zv?=
 =?us-ascii?Q?PgRxZvdDeUrbJ4rWKW7SF4yf+SQDks4gklsB/bWtyoX0BtQRRtRaDYIcWkuh?=
 =?us-ascii?Q?tSEZBYeJPfuO6xcmu0CTGwNIhUo6wG9u1JmQCrHYRcrpMXNRXrRGJk+svsF/?=
 =?us-ascii?Q?Tl+F6o3JOgPEufR48CuxSo/bEQWl3QjXyOts6UJ9x9NSYCjgELwnH8M+wFQd?=
 =?us-ascii?Q?cZW0eIoN6WE+YoZpCBdh3SRYlWrfCxF1OFgiIxl40VqhcLrUaPm0DnRj87Uw?=
 =?us-ascii?Q?V673KCMnIz73qiVzmcEvtT/VjG9FBTNXcRIepXdzoOcYu8ldQeNZyp+kZH4v?=
 =?us-ascii?Q?QeTfuBD1Oh++QpTlH5jhWojH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0dc24a-4b08-442d-078c-08d979f69952
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2999.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2021 16:17:09.3140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2sTD2uo5j8TzzbPgifWcpF0PNao5qNMy3JnpZEhQFgXR3SY1y2TKGm84ml+H24PitcLAm4ylSHhrk9xF0/uQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4065
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10110 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=903 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109170099
X-Proofpoint-ORIG-GUID: Hg6flUIydBM6MliaOb8limKoZwx33Zqe
X-Proofpoint-GUID: Hg6flUIydBM6MliaOb8limKoZwx33Zqe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Konrad's new job role is putting a serious cramp on him
being a responsive maintainer and as such he is handing off
the reins to Christoph Hellwig.

Thank you!

Acked-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index eeb4c70b3d5b..084f7af20ca4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17968,10 +17968,11 @@ F:	Documentation/admin-guide/svga.rst
 F:	arch/x86/boot/video*
 
 SWIOTLB SUBSYSTEM
-M:	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
+M:	Christoph Hellwig <hch@infradead.org>
 L:	iommu@lists.linux-foundation.org
 S:	Supported
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git
+W:	http://git.infradead.org/users/hch/dma-mapping.git
+T:	git git://git.infradead.org/users/hch/dma-mapping.git
 F:	arch/*/kernel/pci-swiotlb.c
 F:	include/linux/swiotlb.h
 F:	kernel/dma/swiotlb.c
-- 
2.31.1

