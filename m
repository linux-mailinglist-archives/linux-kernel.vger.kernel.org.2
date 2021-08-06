Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB9B3E2D10
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 17:00:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242785AbhHFPAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 11:00:45 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55112 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241910AbhHFPAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:00:44 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 176EpLlG001825;
        Fri, 6 Aug 2021 15:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=lC+0uA12venGfFdKl3ZUpEtZ5vQCvvM+3ZNDcWiQKDQ=;
 b=FqubRVrHDscB4gZFQDgWqx0S5AC2Qpd7gq08xP9GCuLGIOGmdbp9WN996jqWxifDhAwi
 UXtirgNbrjRffvvxpKAwXGhOeJX4Oww5AjFLYeKCGlf4IviZQanMqmwLPBrNAsGq7+u3
 L9Fswgl9Nbi8Lczql+NQMi+Asduv3imfLWNMbm35RI9MHT967qbKYo58aE2uoHijbFoG
 Qnc55lrNjdCAtXVqMTpqtliCgcUNuZxQW8G3V+mUSIfDB16S1reLSfqQ8H8TSWH9pKH1
 zMoLzfvHjvkiJBCVhqhqD6aYdVWRJYbL3ZkO156N9PKDZNd8+WBvDF1/JV+8FGFp/KrP +Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=lC+0uA12venGfFdKl3ZUpEtZ5vQCvvM+3ZNDcWiQKDQ=;
 b=dQM3RmG594vpVwUvVq2bB4Wr0+EGHVsc0+4G7vZE1DIVgWr3HYR1A5Ex+OiBMIqmPOlt
 93O0ERrFsptDnAd7qaHw36aurPVrmDHQRPC6jbC7SdcAqW5geQ0Nmn6XHoTAc1wM0ECp
 k9em6/1NjV82x4TOgLH44G5W/FYU1dPp3jrf0gt3DMFt0ro92vXNNLGXQoo8xF2NNOQi
 DF0ETZmtasy37WcRK1NCPddFDoeIn6Gc6PbPY1UcBplMr4/G4CF6yqtizOknRfGZOs3C
 aGHHtDsxJySBKQbjXb4KH/nRZFcRwrSwgQx4tsK75i/koMxGT5AeXIgQ53nDi40OOr0v CQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a9661r6rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 15:00:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 176EpbEl052649;
        Fri, 6 Aug 2021 15:00:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by userp3020.oracle.com with ESMTP id 3a5ga2d5a7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 15:00:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FjmwDlXgCPQ9dtZzjoq17iGtOcnugqOCL+LwQw+XAmI6zd1xZje5ZJoxxJUFuyOTFls50ccVjE4S5m7tXuVf3CRwlg7H7TBd2IrfLaCHlvI+KwySYwuB3QZpEGUa2YvWqnRNtZP2REFQVAduemIhAMfVfqeAaHOSGl8bYucsCM3+nvBIbogqu2W6GQNvSljk7BdgArk3TDhwCiOzQXCjDO0fkiARucFYx0rxQN0oPjWJaOXDMXYUn7FssTy33lTFqtEAD4/rhS9RtM9RkuZjldRHAswE13AucKKWnGm7NekzwMOUpTCOH86eN/eTb6yLhI7NKSfDNX5hgj97TFVBXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lC+0uA12venGfFdKl3ZUpEtZ5vQCvvM+3ZNDcWiQKDQ=;
 b=f83ZTjT/xr1lCnC++ewsAjeSswYHeW0g6mU9BVzzjH+jthC3SuUyqJAmkK1nqwlfCwpUuPT6g70qKN/K6Mj0pa8zklCKWG4b9rMzY+Vf8FMiKG8fEidA2AyjA+palXw8fMV3UgBjULzdAU4GS5M9gncRDD15YmfqQRhnJWlvTswW+XZU8KSoWWcsZ2OHQC4LNg6zPlbPbp1HBGWBfnWqJ3/8AmmZoumCB0Ec2T75i+Se8m7ei8UlBI/H0DiIbmIOWjH16dbzE1RjrP4F78kYt6VjhjeqBNb9QWfpJGUB8Vx/2L71Jlx6wxgPQkLCRiYHdzs4D8OKoP/NCWMJKokDrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lC+0uA12venGfFdKl3ZUpEtZ5vQCvvM+3ZNDcWiQKDQ=;
 b=bPQVovwvy9nsHuRIZxddYCXHMc8EXp/tmkcMB4Nz4hTsOfAkZ2uz6lI1dMWraygeniZyhEPLJr8xH4JhhAbtbTvWYHkCWDTlA/TIk6X8Ur+vcKgKRi134HI3/auAgh4U45ylMV8qGRtE7hf4lCoKZ+w70ED12x26AAPa+kuOgzM=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4561.namprd10.prod.outlook.com
 (2603:10b6:303:9d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Fri, 6 Aug
 2021 15:00:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.020; Fri, 6 Aug 2021
 15:00:11 +0000
Date:   Fri, 6 Aug 2021 18:00:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Linus Walleij <linusw@kernel.org>
Cc:     Imre Kaloz <kaloz@openwrt.org>, Krzysztof Halasa <khalasa@piap.pl>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] bus: ixp4xx: return on error in ixp4xx_exp_probe()
Message-ID: <20210806150000.GA15586@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0003.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kili (102.222.70.252) by ZR0P278CA0003.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 15:00:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 384bd71c-5747-4931-efbb-08d958eae39d
X-MS-TrafficTypeDiagnostic: CO1PR10MB4561:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB45611CC210A74F41E7C31C408EF39@CO1PR10MB4561.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VwLWyA01OB+KMnwJ9gkLuRiq9TdaOG0ox3DFAj448ZIbENkSHzMrRGLPl5whvxCvgpJKzC3BYXChpYP1Cl372AL+JDib/hU70dPx57GCzfSTbGPDUCIzhumsvcAYYbOWD4+WsEzL3Gbmq/V9CQbaQGlcGB8V4Ame5rR/tcUCoRCH1Z+J6IqnTePHDLtkaDqfZqxB0pOOKeKxsv4URRmJbwV9K71yVj5wYIFCIk+vAQqzUZGNYOWFWix7nhXPdbn2mS9r/zQ7Va+23zd2DwRDaAQjGi3GsceFJ60DeBg0o4JubrRsIHEOcWSsUhD3rNVv553ZSEuX7P0C5C+JOvQpbwEoTbFUcwrM8wZKlEdSFSbfvuqdl7H1T2fq5+CQ5D0cOYxBBufNe8cbZ+xZZFQ6nLzIfNf18ffFpgLXV8gPEPiS6IGzwVHOBEY+t9h7zRkJiQzCpu/HpRrR95afjE9ueLLbI+K39BGKMLDB4omqw2dbXoPhi7A/JO3hPp2TNITAjKddS+nS2hAiZD8gxo4r/TKGzqw2lQgxBt5vZdMzPaKxn76uI8Qj5rr2AQ7503TU3Gap3W1RzC/I9D5Oq377CIGrUI+o+fTIuFjwNcbkdhhetzcoWjdt4tKRQj9SW7mLUz34bcuocOwoJLwZA5+ZZc//WLOPaV33u6a+Iv4JZHtDDQe93Hv8rqMozBsz5FArwV21HGplTYrxpaSPKA/fEsgcQqloMUZR+arzbMwIjCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(376002)(396003)(39860400002)(136003)(52116002)(6496006)(55016002)(8936002)(8676002)(33656002)(1076003)(9686003)(6916009)(6666004)(2906002)(26005)(4326008)(186003)(33716001)(316002)(9576002)(86362001)(44832011)(4744005)(83380400001)(54906003)(66476007)(38350700002)(38100700002)(5660300002)(956004)(66946007)(66556008)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yqla6JnqYKdupQEQW3CajBiwfR+2k2fsGlSmMuaTx4Q/5I3D0Bl+6g1wmQUX?=
 =?us-ascii?Q?juxkjpz6MprlkCUqkVWGTo3YhHCbrCKvRFfFhLGFj5CRMtZu2QrOZYOrjxSR?=
 =?us-ascii?Q?7UZeQ6EfLOg91m/+K5OadfGgvJ08PnlxUJ5ScLtyGQZPxnK9BQJFbdJwtFo6?=
 =?us-ascii?Q?tCR/G4bA5QvRFQcMXuZywgljV9teNcx9PFJJSV/5uvP4j50A3d9CSLDHHd9H?=
 =?us-ascii?Q?8LaYzeWV0BNt7GorSdyXnwvvirM/7bQ3caHo+Frkkp0l5u2KOtUepVCMG4Gn?=
 =?us-ascii?Q?byqoWR/vcv8jGCTtBEjTGiV/mRr9DDWK7MFTnsy2qV7b80MBlCYzjOsHFp7e?=
 =?us-ascii?Q?o/fGxgUueKq6pwAuqtSF4ni3Z7cDAESttUMrxN822MhTDgaKWBJgi3DAx0tq?=
 =?us-ascii?Q?2/sDYhoPMk0zTGSjHXoU9drlEDXcvRbHveujzXYzJ7jFUHdxbM5kr8ira3EW?=
 =?us-ascii?Q?BPS+R4IepvQOHXjgSebiTFqf7xU0gPFOnFEJVCJ/6QZTBXGWcVGUY0r37VdC?=
 =?us-ascii?Q?qfpCWXF9yQUFOCCcq5Lg07x4IxUJizBWH5FNXvo9ty7KfRxBKnriOB9KYez5?=
 =?us-ascii?Q?r9LsgAlTXt6Cr5jyjwd3bTWqCt6qMg+qHiDeBqzzK/Yn9TdCVAfR8sUR9VRe?=
 =?us-ascii?Q?sg+tOCMx1qRt4AgvP988EdFwZja38enncH0ihha4eL7B+hLQKUrGMztmqsVH?=
 =?us-ascii?Q?79US61Dil56dlE+bQ9uzRgy32yMheRn6WdXpWeuMHNrcO4d2mCNY++XB/lDC?=
 =?us-ascii?Q?+9Sf0X2uQxLzC1/z6R6GR5YYJQQRzlk2UK9zV/gnOnTg2tepLVjSr77NIz4z?=
 =?us-ascii?Q?sAfIS0FSaLiytKQ3VpxCxXrV6godAU2iq/mryPxbB4GSA6PsZ2DkCXVfYrBe?=
 =?us-ascii?Q?itvyTfG3cIiVHVz1EykDxxMIBLM0EthWUKuhKqhD+rvwr1EDYeexrfUhu7km?=
 =?us-ascii?Q?9rZmWCyeJV/7+AlLzea/eCKqdixnE8iQxB6GjLMCach3htEWOfie/aqQkAz0?=
 =?us-ascii?Q?0tOPaUN0ZkNAKCRgUHxX/XvMpWqUDR34LoXMWG011lXAAjX91ByVZHWuOflX?=
 =?us-ascii?Q?OOyUIVeF3aYnawpB2z4mRdOQ5QIbpOTQbYrfRkeJhmDldwRxIQGunnccWi1H?=
 =?us-ascii?Q?xA5rpwp+lD7m13qk/8Nb1BtyXKrKm1J8wDWdnYNFKRFyUMNlAx+Eub4N6vl3?=
 =?us-ascii?Q?aXAiDVibMhzJlw5BA49MNRObHBZL5CkYOwndQ4F7FNZUmRIa9qHVoJaxWNj4?=
 =?us-ascii?Q?0SoNUuprIFf1vPfMbdA0BiK/lnoVMr0dzSnLgxmLim8yS/NB8oFeMUT165H/?=
 =?us-ascii?Q?BPiphSh+red/Kuu5ZSY7tpJP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 384bd71c-5747-4931-efbb-08d958eae39d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 15:00:11.5415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqON/8Qr6WSqNAGiNf19y33Rwht0DKIYdXtzqROKO/sKa3gj2kjsjF4The0TQQZR/C4U7GjADcGrwJ1Ix8bTdH2WTr4JyIT5pyANV+upKU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4561
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10068 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060103
X-Proofpoint-GUID: 27UIuyXydr48nhu4lDowFJUGnUCcgpF8
X-Proofpoint-ORIG-GUID: 27UIuyXydr48nhu4lDowFJUGnUCcgpF8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code was intended to return an error code if regmap_read() fails
but the return statement was missing.

Fixes: 1c953bda90ca ("bus: ixp4xx: Add a driver for IXP4xx expansion bus")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/bus/intel-ixp4xx-eb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/intel-ixp4xx-eb.c b/drivers/bus/intel-ixp4xx-eb.c
index 9acd00da413c..a4388440aca7 100644
--- a/drivers/bus/intel-ixp4xx-eb.c
+++ b/drivers/bus/intel-ixp4xx-eb.c
@@ -369,7 +369,7 @@ static int ixp4xx_exp_probe(struct platform_device *pdev)
 	/* We check that the regmap work only on first read */
 	ret = regmap_read(eb->rmap, IXP4XX_EXP_CNFG0, &val);
 	if (ret)
-		dev_err_probe(dev, ret, "cannot read regmap\n");
+		return dev_err_probe(dev, ret, "cannot read regmap\n");
 	if (val & IXP4XX_EXP_CNFG0_MEM_MAP)
 		eb->bus_base = IXP4XX_EXP_BOOT_BASE;
 	else
-- 
2.20.1

