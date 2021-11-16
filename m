Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB765452F90
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbhKPK6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:58:35 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:58400 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234430AbhKPK6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:58:33 -0500
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AGAtUXe013248;
        Tue, 16 Nov 2021 10:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=4hEAN3vDRKhxNekWAdFANqoYMshR65rCNM01Lsxhp6E=;
 b=kjmFfZ0CqxO+Ofls+GzfIKs70ATVE/gV9QK1zW5z8OaJ4RuXKeE91LeXoEx7a3RQeWSu
 4EdGUBl6aTELBQ63Ejvve0nRnmE/PJSpFhyVrz3R/AEQQTi+hTQcsX5cnxaXWVbiRzlZ
 otV2mTDVD9qQ7MPELdgoqeTmb5u+CPfK7Q8EN5gF854vzep2vYrYfUeK/XjIUulTTkmb
 47eb7akwZdPAXayW/Rw0dbnkb3+8cQLvS7KlE42d9NNwTXwJUifTSD0JozXm1Zuc0O8T
 +z2WCJMri/JNC/l+j4MEBsGM0I3VHEU0errUIsoN+DWhKwNIu/BGO3+OIM5iiGdkGTis yw== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3cbg669871-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Nov 2021 10:55:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZByZA4PsY13vLvVnA6kxSUw6jtql8DgSp3A7sjB6EBKB8fuu5t6f3mepiZvExAH8uAKwEPzH+uS2Qb3UXsUNzkqsAD/5qxrzLpRJM1y5ZkhS6uReyx+wNtpX1zeJQBmRQ/8H9BLohCQEcvQ7Bm+Gv0KD+qvf09x8fNjzhcYl88kbZ4+sejNwSMCjhEQmt6DGuEKl15uvQz6BEDX5xCOCU7g9TkoJJXagQuYtFhl1wSPM1vhYVMMBEhFsOnhj56wJq1QasOq7aaiyLsFDWe81Eipn2TIkwmPsNVbmdAquWuB1jX4t3VIbXsqErdUSJPH4mQ4bTxFp0Yqd8mJYQnWIYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4hEAN3vDRKhxNekWAdFANqoYMshR65rCNM01Lsxhp6E=;
 b=c4gtR7DCEtfSCLpA4g1RhU9twZK/KTE95beB/G3nw51Qx2DHXyG8hp60DHFSb7QKnTG5MHmpi0gFpro60UeVNAbenubx+1mdXCYhIuaKqWzRbbOAstobL6JZFxs2ScgZM2mKxSda/yVv0SYieUg7CIuJdg40xrqCwSZS2iItcU7B6xDRe2q92irO03tJxnPF/1F6s8BTya43OmGQ7apNb/+6xRWvGicqsywxV6OkSzH8VjqBFe0H9Dg2FAlRwUIxq9xedn56+67s4YExGWULQi011Q3rXtwukTi50PUkKxf94aJD0Cx+nOPoWL4g2TvQS7VJioRhVoXSkzTMaoE9pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH7PR11MB5861.namprd11.prod.outlook.com (2603:10b6:510:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 16 Nov
 2021 10:55:27 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a%9]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 10:55:27 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     thor.thayer@linux.intel.com, lee.jones@linaro.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, meng.li@windriver.com
Subject: [PATCH] mfd: altera-sysmgr: enable raw spinlock feature for preempt-rt kernel
Date:   Tue, 16 Nov 2021 18:54:24 +0800
Message-Id: <20211116105424.12685-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0052.apcprd03.prod.outlook.com
 (2603:1096:202:17::22) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by HK2PR03CA0052.apcprd03.prod.outlook.com (2603:1096:202:17::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.18 via Frontend Transport; Tue, 16 Nov 2021 10:55:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ebc702b-9db4-4038-b78d-08d9a8ef995f
X-MS-TrafficTypeDiagnostic: PH7PR11MB5861:
X-Microsoft-Antispam-PRVS: <PH7PR11MB5861ADAE3D047718FA378023F1999@PH7PR11MB5861.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jP6HsJQmqi/EO8jTYVCLeTUy/Cit7iAuFDtqtS7S3eyXDY86805dvNaWaUzETDB/3pc1tYZwcQWP+/cKHFJE7ewcDJHb5bbLxORh7wBtZb6xrGOPLCarLLwv3RMsfPxTQAsXBXRfb1GQ2gV3CKG2TaMr0AQsm+8qOCW5f5v48TA6lX6ePC0i5cGvabCGJOT/l4vlt4Ux7dGVGrD5Iy9JpyS24Imu9VlwxcahvUix6Pb2l7GYnnosrWLVJI9+kgwYHmQFGay9fM+OXnUmJJRvcyXRRj1mbptFeof8gNUGxR3PJjCVLnv+EdnxU/tJ7M1eFF431SMjMnmOjgwZGsWqsE9vK1mj86vGLL4hh3LMQXaEPcaIdP3CIGtqVnWq2jhqNbFR/Ydg7eEMr9I1FnsLuWo/B/7VheRF42Qld88YmWwJxOfwsISFEVVkfixXZ27bHKzFcwOeU2K3hRorKUWJKNT1srZ8BixYWIwgL7mb+c6sXvY5inDhFJzCKJD1cSlMxaHe6aWisgeGE/sDEdUXnrLWCi9UKZeHPdngKpgkmWF9NFrURHCAMPfVUjRgDnFN5bxknFN+UfCZJF8kyy4SrRbergAUxLez2fvNkU9UMfRHJsZpObP7VKryzP/AmXNHS6JfpbsiQiLH03CAAY0RwKLkCY+n0t7ZA0MVKSNtBytrTSOvKJNgT7d3RWng4qPMw3QPDUeM/ssGvc844lq+2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(36756003)(5660300002)(8936002)(38350700002)(1076003)(186003)(4326008)(38100700002)(6506007)(26005)(107886003)(83380400001)(316002)(8676002)(52116002)(508600001)(2616005)(2906002)(956004)(66556008)(66476007)(6512007)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nH0Dz1QO8s8RyMn9fevzcYUlzMuop2xMhppJE4MWXIHt5aV8x7P9ilbIoRtd?=
 =?us-ascii?Q?YX9yqZuTIOKyJyHTCmrNpiZOzt2uSiBS2U420g3b/bgptwVlQI4SDm71wAc5?=
 =?us-ascii?Q?2I/l+izoqv33DqM/gomRVd5sSQW3z79inKyipqBJ2OTXebq2tlVlGB4u8wGG?=
 =?us-ascii?Q?tVy/FHIgVG2VZUHfaQlGY5EpePO+tkF3zCm6/TjZcRy1cEy6PmKoTH3cPUel?=
 =?us-ascii?Q?3eL4fm1/DZPToGCMULV2uk12d6ENWhisROZcMYL7P25pb1NbjE3T0rpNI860?=
 =?us-ascii?Q?1sh9OUb0KADOTixOGN2NECmru14EEdezFw/YWjWxtd6GQGTVApgZfGTBoPaH?=
 =?us-ascii?Q?3tS1/2+11oM2MkYJRCinOIAbB44qL4K+bqWCxQfGDBzn/k9rekfeKDWi3DMX?=
 =?us-ascii?Q?tl6mE5nO7NDjYUehZdXbwBAU4yqtC6rFdkY5jyUMtHL7tpqatUkF9ToYncQ0?=
 =?us-ascii?Q?Wstpr+j+a8VgR5gnEmX5erOLbv7jGg/oj8Tjh2fG1KuAecedtWR8+I7aiifL?=
 =?us-ascii?Q?n7SzZKbfWk3q5FJLVz1fUHHgAdlsMeTnfwz4zLTYlrBU+XYM2SXeKvGr5/39?=
 =?us-ascii?Q?xD13n7mWykP2bWZjGA0bQBjuaiQQaN3iHIHstLok3XpSAMl5NMqJdgsk68We?=
 =?us-ascii?Q?/951DXR1ST7lc7fQiNFfGColnDhmPCnZx3TNTkdK2EAJasoqDyy8Vr3Xlcz0?=
 =?us-ascii?Q?M6VmUnQiRVBOfXGkm/VI1a0hATjQDRcK0KVMF+MGHxlwbdnz5o52sPhR2QDQ?=
 =?us-ascii?Q?1rJbcGIBdMmjvmlA4W0eL2PWNsuOtqpx3OJUJ8XZ5lvLbhx31wAyam5Ik+xW?=
 =?us-ascii?Q?vLiYPcKYLCYJisqSn1abSAyMpUXbVjvf28cCoDsrhd9LsMSbvFZTfWSDRAM+?=
 =?us-ascii?Q?KtjGIqtr8obuQPtmNgzPoQUlgO5WBJukehUoO4nLdjdNS4n24AO7/A8uqY0X?=
 =?us-ascii?Q?YzA6LxqLEmCWS/gKqZToiyj24mYsOEAb5UdAUsHmzI94PWVi6HmVO6xyDW5k?=
 =?us-ascii?Q?Xrjtc4AWUgU28+OVMoNiQ3duN5UPhayymdf9YkAzgf7l/B/3BAJTh/lb2UJL?=
 =?us-ascii?Q?58zMZV0jDNw7o/e6tDJy87GPGB+HWXjQ7cxlSObHNiEn6e/RtZ+PLI8unl4q?=
 =?us-ascii?Q?P+bVGo/iZrWrBndYLk0QM8S/j8k68pCSkfK80GHMAtnki3nhcbLijkMMkbVV?=
 =?us-ascii?Q?lwRJXPqSCZ+NlHDhjImS+UYc1i8ZoyHTGD3sGS1ga1T4TpekYFrnz/4PzEXA?=
 =?us-ascii?Q?L8iDrKw5cyXtCQnNATCc2BgjMnjHZHsO4FGuwSmfRHngQRoo1iok2yLtWnKb?=
 =?us-ascii?Q?VlyKWzlZzHsgvxTRhUmlLKul3tdIhvYp1qtZta2TA/wgVtSvbesSONfu7Fhw?=
 =?us-ascii?Q?RUeapCt0U9QG9WYMd79m9iNh9u+LUUAOHCc34smuAFQ8k5xzSV/dR8ocujO2?=
 =?us-ascii?Q?N8kLxIRzX7yr4wMTT0s7onL8kEkx2Kp7AFlKTymX42dlaCxNj4iBGBq2FVzL?=
 =?us-ascii?Q?U7ofOKqX+nfNHFGBgE1bH1ADCmXflxfrMVfzg4RP975BzPgoNncCqgxWXVWA?=
 =?us-ascii?Q?R0C3fxQWkjWAb979MwL27u8q/axbHzzpKhIQl5nSc4WY9GpxvwPniW2ybj91?=
 =?us-ascii?Q?yvKTk0INQprVfQdn3KLpI5Y=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ebc702b-9db4-4038-b78d-08d9a8ef995f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 10:55:27.6200
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m0m5HhZCSYN2MHSMi2RiPgIrfgzljH5o4Xeo4f6QbXOOkpEK1nmuGyachM5GU53PWlfIeeyk9kA1IE1y7Oo/lA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5861
X-Proofpoint-ORIG-GUID: xj2GbxnCkue6JUslHOHH5jjlWfVLNfnj
X-Proofpoint-GUID: xj2GbxnCkue6JUslHOHH5jjlWfVLNfnj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-16_01,2021-11-16_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 bulkscore=0 spamscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111160055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting up preempt rt kernel on stratix10 platform, there is
below calltrace:
BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 1, name: swapper/0
Preemption disabled at:
[<ffff8000100b25b0>] __setup_irq+0xe0/0x730
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.78-rt54-yocto-preempt-rt #1
Hardware name: SoCFPGA Stratix 10 SoCDK (DT)
Call trace:
 ......
 ___might_sleep+0x144/0x180
 rt_spin_lock+0x34/0x9c
 regmap_lock_spinlock+0x24/0x40
 regmap_write+0x48/0x84
 a10_eccmgr_irq_unmask+0x34/0x40
 ......
 altr_edac_a10_probe+0x16c/0x2b0
 platform_drv_probe+0x60/0xb4
 ......
 ret_from_fork+0x10/0x38

Because regmap_write is invoked under preemption disabled status, and
might trigger sleep.
Recently, the commit 67021f25d952("regmap: teach regmap to use raw
spinlocks if requested in the config ") add an option for regmap to use
raw spinlock. So, enable raw spinlock in preempt-rt kernel to avoid the
might sleep issue.
Note: The commit 67021f25d952 is only in kernel v5.15, not included in
earlier versions. So, if intend to fix this issue in earlier preempt-rt
kernel, it is need to backport the 2 patches together, otherwise there
will be building issue.

Signed-off-by: Meng Li <Meng.Li@windriver.com>
---

v2:
 - improve the patch title.
 - improve the commit log. Clear which commit is depended by this patch.

---
 drivers/mfd/altera-sysmgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 5d3715a28b28..27271cec5d53 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -83,6 +83,9 @@ static struct regmap_config altr_sysmgr_regmap_cfg = {
 	.fast_io = true,
 	.use_single_read = true,
 	.use_single_write = true,
+#ifdef CONFIG_PREEMPT_RT
+	.use_raw_spinlock = true,
+#endif
 };
 
 /**
-- 
2.17.1

