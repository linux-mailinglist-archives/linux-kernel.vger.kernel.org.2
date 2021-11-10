Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C467944BC4F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 08:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhKJHrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 02:47:02 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:7140 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229567AbhKJHrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 02:47:00 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AA6H8Fj017892;
        Wed, 10 Nov 2021 07:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=KfGFKRgH4tzGX9Vp2cXwUbtzpeKUHUTP0NagwP3PepY=;
 b=bKI+P0NOEnRTXDOE4GfzAiUDiksmLcsHpNNq2kXXHwuCv+zyniDzKQguzLvpDpivvaum
 4n6izY4tEvxFRjaqVqQ8uA7+YJZ/yBVqVf3BQrFD/Si6KFKQod1OLUwx55N9+2kCgb30
 pzdHmar+muooZ0QRm51e4JJEB9/MN7p43NU9Ri9FlVgp24+ddxARblW0eiPBxxIoGxMz
 sH5fQi7TFFwQSiRwzdzFqWBxExdqrhCJhIA1lZKTtOYg85ybKl91tDIXrKim9Sco+uiE
 HjBEeycBtNTJL0z3KZVBLjyd1sy3zFzPc9Ah1Px6V1sG1es2fa1LTa1Pzc5/6CEgGoEt cg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c7yq7b24m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 07:44:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AA7eIxU122252;
        Wed, 10 Nov 2021 07:44:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3020.oracle.com with ESMTP id 3c5hh4w4tv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Nov 2021 07:44:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/FDDdJuEqsMQmSr6z4MuAd0WBGDgiJ7XBwD2T1dJ0h4FRKotWpNBkR0zdp2SmeINtF5rXhL5AT8rsfFvBXihvndLQAw4kdB7Ked0A1M3ao738cfl/QR/5YIDimBw/M1uQV9T7VaMzdJQ/wEJT63EtVbLJV9xt07lzsBxWHBY5HH/X7hdZGi8Tq8HN1rm2tGO1rTa73Ju8G7xbiTLt94cqF/Izi6UzPVyZLLzJO4Qtn7r2eddhqgP9kpuYTupIm91+z78PR77SQVNC+Wx7Y36l/3iAFKp3wFCdCQoKE4r5SgynBVP+5HcDTlmH0ThSYaf0FFGNULtRd3A80iomOwUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfGFKRgH4tzGX9Vp2cXwUbtzpeKUHUTP0NagwP3PepY=;
 b=ClLLBqlgOoeq38ky2nqhn4mupeiweJI7uLQkURnCidJMenwA90qKn9B1U4uDvt6k3ty2aS6JCF5hHVxTSPlzAUWIL/ViCPnLUdRA7Ivd+ajk6sw/HRO++F5akgXQd6zXhpjV56I7mnB+/se7yZj+0FJlIb9awH/8UWZCZk1FrMByv/tnur4eY/TdWY3voylcBGOaMYDLNyE4prLMJFlOT5FLTONVLQuVn+VlLb49KprBvyJL8YqVFoJRhVVmy3KnjHVwjSNKnNUCjIo7/m3wor7hDZBSd4muqevDRVxoT2LKeVxfWdRbXBaaXMUuxSNIe2GLJQnqv90B/s6GabipGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfGFKRgH4tzGX9Vp2cXwUbtzpeKUHUTP0NagwP3PepY=;
 b=BnxJ4EXsdQ1oxoH+bpAJqVMlb0jVcXKAUFh009wB+bpcFHnZRJuiRU1tt9uwtW5vqbs+m6moJoxZaZrfvfA/X+0SJU7gSzzaZPzHHHIRip5gfuCct0bxOR1xuMf1/mIgC/MXFySWO0onhbINk1Z1NnNb7/pGuOR42QGD6XfwgxI=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4513.namprd10.prod.outlook.com
 (2603:10b6:303:93::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Wed, 10 Nov
 2021 07:43:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.016; Wed, 10 Nov 2021
 07:43:59 +0000
Date:   Wed, 10 Nov 2021 10:43:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Vadim Pasternak <vadimp@nvidia.com>
Cc:     Mark Gross <markgross@kernel.org>,
        Michael Shych <michaelsh@nvidia.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] platform/mellanox: mlxreg-lc: fix error code in
 mlxreg_lc_create_static_devices()
Message-ID: <20211110074346.GB5176@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0166.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:45::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0166.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:45::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16 via Frontend Transport; Wed, 10 Nov 2021 07:43:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dde019ff-377c-4313-d29f-08d9a41ddb52
X-MS-TrafficTypeDiagnostic: CO1PR10MB4513:
X-Microsoft-Antispam-PRVS: <CO1PR10MB4513BB24A4384F3D2B36E3708E939@CO1PR10MB4513.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:651;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztrKqIFZIKb9LRl39vzOZAmFDZdzUQ7ffe1qDVtG66e4JkyEbTfsMw83Pv6ZmhNL+cPxgk0kNmFUQzgghQoETum1pFTJTl6RG4VDIoq6GTvh4fCDYn2P1efCq7jwRtwP7IFXFJ3zoPUPfi/DV6OlVEpgi2EpprXOOJo3/8aiRqwE45bvnOn5TAA/Ze9PqRQjev6byVnIrgvzd1j7TdU08YbvZtaZ8n9hhhWG7OeNK5zAsoe5DUZVXuRpHAYEjOlp76NVpkEIOplI4hUmsxqvcZYK6xQgu53boXI2ph46VwNRbFY9VmqF7ulD8NqJkGa5y1nppgjEHNt9RA3K4YHrKH0obit2vOBjnDn5hg6oMB6UhiOF0vaAZC/19AtEx31vGLmzn1DNS+Mox29qmkYucmGHnKHoy3tw169x2byeCF8q63TAoZWuGfuC00HKXM1mmN9no7HbPQoRFAnBBb3kcCZ5sBI6bV232xEc/KsYS39CHIOm3l1brkkzuP6TLeuq4L+brl2qwweJpMCeqyshbYCnNGbIR3YpbeNGx/Y4D+Mjdn1XzKGFUnPcmEX+LhgwVScx3dVPyP7j7MxSwLnbIQQavPkjCKpqD5KAVb3JIAwzopQlh4RmKCQd7Tpc3XbnoI+/VsCh3+zWp4VI5dbcMoS6G4fXiHVXbJX9FuMTibU8EioWb9hRpgOKEBYd+VJ2ScTzojnLE7K8DAq4mZBB7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(33716001)(44832011)(316002)(86362001)(110136005)(5660300002)(33656002)(54906003)(9576002)(38100700002)(38350700002)(26005)(2906002)(8676002)(6666004)(186003)(4326008)(9686003)(83380400001)(66476007)(6496006)(66556008)(52116002)(1076003)(55016002)(66946007)(8936002)(508600001)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U48myfLiBPtQQWL848WZjjlUDEQdripXFwPjUNsT/xFZppcILiRtVLT0jhvN?=
 =?us-ascii?Q?Ii//zOV5VQ0o/RAEOm7KHc5FsuJP4WrZakka+CIvcbU/SmwXZBeESBhe5xXc?=
 =?us-ascii?Q?kfHA9TsHsxMQThX5PI8bfvbSO35TBf3JYe9kzCLLoyAwfy7v09Zejwzy9Kuz?=
 =?us-ascii?Q?dwF9lo4OFSNzopj8zN6amDmo2hl4BWDQ74JGzv7cYeoHM/HUjg5SVP6vfMoW?=
 =?us-ascii?Q?fbJq0r3RbsAhCS8vpJO69spfeUEREkuobKDxjMfYyQDErLas58PXlXAA/BeF?=
 =?us-ascii?Q?ofmglRpJav2CoCiYohsf9/nmALzFLPcgE2665UgDq2OnW1fbp2NvPl++l9r0?=
 =?us-ascii?Q?XaYuhCccvU7t4OdgWXIiJSGJ6dRNxkxd4cPZpEtsgwnK9iLydiOcUpP2SUGF?=
 =?us-ascii?Q?s6PxcmNiwwrTU0oTarcYvFnQ3ZE6vE/MPtg3zsceFd97y/5FMYQ6XYUPfXPW?=
 =?us-ascii?Q?Qxj9uZGy3iahW3tCv4Yzy0DUMeGXQGPoy/CcVAX+Md3ZSVtsfnPJ6lo1kqsa?=
 =?us-ascii?Q?ch8sz0f8OIKT+QH/nStvEBCmYg7ioCsp5Hjdd/G84Ukx8u1vXE2GBmSouQ/H?=
 =?us-ascii?Q?rVqI3tg4hpjLPLSrXLslYuGoHV5cGLUO6jJqyzb8UoY2tiZGjaH6xiAJZpFU?=
 =?us-ascii?Q?nolTSu5rSNuYbuc2NKcPgFluYP7jweqs4Bz2OIk/cQcxNWiBBtqYL8ywO4nB?=
 =?us-ascii?Q?CGASH9LcSassPonfmDKAsY1oz0BM/7x5Of9gO7YGffdvVHpfuaVxspUXmUHI?=
 =?us-ascii?Q?rwUzFcfUa3kL6b60ozutt61NLTzRtHqZ1fT2l7qqBBGZeBSLFCn9s8G9ICpM?=
 =?us-ascii?Q?UMKqSGj+Z2LmRUK/v3CnTs6JoEgAqffa7kz8xgyRFQV9x+IdyeCECo0ZUErs?=
 =?us-ascii?Q?KLpPm6V8TqMvwSblNarl1AGKx7VgAqO3iTOQx49eG9qsF3N7ZBRtMyOw7SHc?=
 =?us-ascii?Q?gLS1wccB2XPYSMR5rqUOjfrTxGOoffc/E96ZzXvOIxEnH+EdtaUJI9kpG1V9?=
 =?us-ascii?Q?/B77JsB7sjSJTjkeRpcFQSaCt+8INdkKArzXTdLdlCQEwyi+QUhezA58LK4v?=
 =?us-ascii?Q?aXX6FQ/bEGNXsQXzVmYNzv0xXxUdVOPL51/jP+gWUYJRr6i2cRvHRGS4QVny?=
 =?us-ascii?Q?0pnBLY/yg+aoN/uIfRSRoM1Zar37q0JtVbk2u3Tg4PqSh0/nyFsP7DP7MB2F?=
 =?us-ascii?Q?8WVPmIbuAIX9BYYk3k4tphdu21qAJvdeC4EhmF9AfbLH08ajV9PSnhKGABP/?=
 =?us-ascii?Q?NBSvEOg1JwGr/+uRdinsjyZCQ94XvfL0tNmFUufTuyvD7B+ab8NAL6jfpadO?=
 =?us-ascii?Q?csvR5QyNb8jG8fte0RHnJXp8sAXoOHFRRaeT11m+4hgHiqNAhDewrUHyudMz?=
 =?us-ascii?Q?VnVTaWZUBTqeT/AoEhnRMIBn6ZeJxkqUwhyaHf9ItP9UXE1Ym9XsDu9a9dlK?=
 =?us-ascii?Q?1pgHhXIJzbBfU+Eeg0I1yz6sNWDebIs516OT+aw6bvWN+9JZxFuXger8z2l/?=
 =?us-ascii?Q?PjKsbGZekhw0bNPIjny2+IMY/yGe9VueauLPSoWTRGIKXv56Wd46BVXlbdqX?=
 =?us-ascii?Q?IRnA/655dx0KciVa2TWDBMrh8OkSshg3Qxw868tWY/qqKOEKJ+kmapBTL3Cf?=
 =?us-ascii?Q?wbofke44zcaYW082IRKMCD4faoNrlSrlAv1Gb7NJk0tOBJ/nHZZ3M5w34LMb?=
 =?us-ascii?Q?M1kqL/0q8lGAJntBwMNB8Y8/BBw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dde019ff-377c-4313-d29f-08d9a41ddb52
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 07:43:59.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBOnrzTXYb8yXD2OTFW/10GuOFQogD/FIBlWeDVkMrmay5tv9wytZu2wJp2oj7D8uEkMBWFwpg79dWzhTs9lSyubRlmaC4k5yBbtlfGyGmw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4513
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10163 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111100040
X-Proofpoint-GUID: P1XUrGDsxWpcjhlTfQ7UyDktDP6u0pWt
X-Proofpoint-ORIG-GUID: P1XUrGDsxWpcjhlTfQ7UyDktDP6u0pWt
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code should be using PTR_ERR() instead of IS_ERR().  And because
it's using the wrong "dev->client" pointer, the IS_ERR() check will be
false, meaning the function returns success.

Fixes: 62f9529b8d5c ("platform/mellanox: mlxreg-lc: Add initial support for Nvidia line card devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/platform/mellanox/mlxreg-lc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-lc.c b/drivers/platform/mellanox/mlxreg-lc.c
index 0b7f58feb701..c897a2f15840 100644
--- a/drivers/platform/mellanox/mlxreg-lc.c
+++ b/drivers/platform/mellanox/mlxreg-lc.c
@@ -413,7 +413,7 @@ mlxreg_lc_create_static_devices(struct mlxreg_lc *mlxreg_lc, struct mlxreg_hotpl
 				int size)
 {
 	struct mlxreg_hotplug_device *dev = devs;
-	int i;
+	int i, ret;
 
 	/* Create static I2C device feeding by auxiliary or main power. */
 	for (i = 0; i < size; i++, dev++) {
@@ -423,6 +423,7 @@ mlxreg_lc_create_static_devices(struct mlxreg_lc *mlxreg_lc, struct mlxreg_hotpl
 				dev->brdinfo->type, dev->nr, dev->brdinfo->addr);
 
 			dev->adapter = NULL;
+			ret = PTR_ERR(dev->client);
 			goto fail_create_static_devices;
 		}
 	}
@@ -435,7 +436,7 @@ mlxreg_lc_create_static_devices(struct mlxreg_lc *mlxreg_lc, struct mlxreg_hotpl
 		i2c_unregister_device(dev->client);
 		dev->client = NULL;
 	}
-	return IS_ERR(dev->client);
+	return ret;
 }
 
 static void
-- 
2.20.1

