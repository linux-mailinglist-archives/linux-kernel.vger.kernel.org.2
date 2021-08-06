Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5B43E29E8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 13:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245636AbhHFLli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 07:41:38 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:16246 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242420AbhHFLlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 07:41:36 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 176B1qgn015782;
        Fri, 6 Aug 2021 11:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=V03EuraJblEVqftCgJiUqKp0tI2WI0qN1rpYMcQXsGU=;
 b=HHfRTbxa8gKmcyVAKFJ/VaD7gya8OKqLgAVLKbAq5OnYWdqh/Vecm3DzWUmx50UUEmXH
 Bt8vTQaAkadyCeTdt7XOqR62ytPeyjrtvZdL6LBHqTnhHP3x5so356cKxAU5kssvp61A
 OevCENh/QNcDVDh71jHIft+in1w8O9Om/DhFKby/tg8wjv4zd2wnpeiTAL0oFcN6+ZwW
 lrd66tM705u9QC+KuZuUFq9+vV2ehB0xSV6uQ2Wcqq/qMvSKdFhPDnOHEKA0GErYbB0S
 pygCLjs2ALN8BNQTBsDaawNiau2lcOgttb6tJoNEJOMYGPFCYdvMVdAWmVo8j7QubcyQ 7Q== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2041.outbound.protection.outlook.com [104.47.74.41])
        by mx0a-0064b401.pphosted.com with ESMTP id 3a8nh08gs5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Aug 2021 11:41:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrhVr4mToA364qXSMGDKK2g7FVQBs9A73HDdfeBCVCRbzsw/Ldq/rOeyrToOpJF0q8y1Y0YNwzQo+yTHa17DIVidMrmne2dOWhGYVN1vGOi2YWuHOUuV677qBU9BUym6JYTb0dBUXdk3INUOc7WBUd/P+Sqy1BJRwUYd3s6UHkHLrxDU+Nzj7ZiO4H33Hps6a80nAqddmn8bk6vXkhAsvqMFSknWiCoQ0z25+/XM2HfFaLwxYrySR5TkCnuwB6n76V9TBQSxvKcDKx4KVjQqJ+h9TGQtixIaP2Y/jzMP0xWgr2IZm5JoPdfJfw4KAxfWUvH5TX5/d5S7evbWF7WDmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V03EuraJblEVqftCgJiUqKp0tI2WI0qN1rpYMcQXsGU=;
 b=VafIIDda8L0gEQdAx7NbIHJLeXqB9VYShxkz+7cBJr5ycbr5BqYLMYuIngjmFDgoXnFxocs+Xcjhqs0i9q39HsRWdcFGSm+dred0IXFC7LP+dHHg4WajbF3gZcMlVqUDf7JYbS8ogc7Ye2hGf8ilIAHH0sqJIBJqb3MzvzLEUlKDPktfWo8kT/P7XHPuvR2J/hfyw0s2vb1jbbcd2CbN/URGjLSq2cLSHUu3L2WeObdLeE86TXjRQq2O+2vTVSGfhugR0XDIc5F9K4imvFWnQWRWLG3snzLq8U2iJXJ0EHOhvfoT3BCr6kmiYMUPSzD69PVAVDaqyCUwXTBvGTgjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB2587.namprd11.prod.outlook.com (2603:10b6:5:c3::16) by
 DM5PR11MB1737.namprd11.prod.outlook.com (2603:10b6:3:10b::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.15; Fri, 6 Aug 2021 11:41:03 +0000
Received: from DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::8ccc:636b:dcea:7a5d]) by DM6PR11MB2587.namprd11.prod.outlook.com
 ([fe80::8ccc:636b:dcea:7a5d%5]) with mapi id 15.20.4394.019; Fri, 6 Aug 2021
 11:41:03 +0000
From:   Jun Miao <jun.miao@windriver.com>
To:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        deller@gmx.de, wei.liu@kernel.org, bristot@redhat.com
Cc:     peterz@infradead.org, lukas.bulwahn@gmail.com,
        jun.miao@windriver.com, linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/hung_task.c: Fix a typo in check_hung_task() comment
Date:   Fri,  6 Aug 2021 19:40:49 +0800
Message-Id: <20210806114049.649909-1-jun.miao@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0053.apcprd03.prod.outlook.com
 (2603:1096:202:17::23) To DM6PR11MB2587.namprd11.prod.outlook.com
 (2603:10b6:5:c3::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp7.wrs.com (60.247.85.82) by HK2PR03CA0053.apcprd03.prod.outlook.com (2603:1096:202:17::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.5 via Frontend Transport; Fri, 6 Aug 2021 11:41:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef536f8e-6003-416a-cb43-08d958cf11c9
X-MS-TrafficTypeDiagnostic: DM5PR11MB1737:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR11MB1737971ACCF9A5D283470D8D8EF39@DM5PR11MB1737.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: exw2L14lI5q7GREm/LLKCWkFWHhPCo64C+e9fmTnSOOKBpCyUTUBIixKBXOlRprOwGL5XuSoeuNP9+zHnlXMfH6lv44ed7dmJfoothNgS849e5eA6I1MCv13syXhx4sRguEK5q/OQZZiM8O3zkKdePdAP4vOS85Rgq64YQkZ2QQladxrAHZc4ycXvBVMWEF7ioYXp2te9ceQske6lCjYSiR8QoXD3KZA2hbFSFNaibOj8ABaxruyEpc3f6j4goH6WvqSIBTI/iJsI965VZOr1I6l69/kOOYyW403CsO3A6J+omhOPBmx0D4SDKjX5SWajRMh+IqYO7kGLO7Y0obiHkfFV1AVuxcnaFqCkV5vTDleoheQ4LS2afPjeENvQtVsViQBRThsSGszkxFY7De5a1gdAoS+2RRKkd2Sp/KX+9+yG/3lHgiavKTxIE6IZFir+Da4IujOYrJFbEtlTZU5RgutDKyq5eiB1ZCZkk/JojaEloWsdGxwKEIXAHjLkTQc71HrwguawQyTJtiz3sSrw3yCSr5AmELWXuXlBvDONEGJgxAmP4Wuc3zwrbKESFhqarPsYEgsKXAnSM8qOAv62zN3Q5YkqemUPGMDaJd3N27py1nGK2WhZL2RD7wRyL2Q+EqCCaV+6I2uqjit6Xndl8cCQok75HuI3V3dl85XHwDi2s0w0KuLIRPYXuNe2VsptIFPXXTQW1wmfHTMKBvvYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2587.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(396003)(136003)(376002)(346002)(6486002)(38350700002)(38100700002)(4326008)(2906002)(8676002)(6506007)(478600001)(316002)(66476007)(86362001)(66946007)(66556008)(6666004)(2616005)(36756003)(6512007)(1076003)(5660300002)(956004)(8936002)(83380400001)(52116002)(44832011)(186003)(4744005)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U0FHs2hC57tvzjtnwThAFyxh8ypGx0Lz2/QAGUHQdo6N1/0VcL0hpwGwIwuM?=
 =?us-ascii?Q?x1LrjZUrRh4TLnoKrj7pspAjOJsNGPn/awUyTXh8YMWs7ic6OBhFCRE8wQNf?=
 =?us-ascii?Q?iyIJB4LT13FEm3SZnhrMki50NRJj1MxAG3l3USXGle7kt1dwyM5NOiYf8iWY?=
 =?us-ascii?Q?XM3iUQB3XAhGD7jlRVVWwwK937UcrfTtEn0YCLqHBxNwPnFpegbINALs6qDy?=
 =?us-ascii?Q?DON7mwQyX639L2iDT62m43tRhX2raEbkXG3K15TVZm1YAXdj43+Caq0n1QrX?=
 =?us-ascii?Q?uomZvcnBmiwiBWNUZtngtGfYDo9kATfYb/tzprjH0SFt82gZkpZi8zLXR6W8?=
 =?us-ascii?Q?MslY6o9LHGdRlcccqktUFhqWQsYtInTJOIpG/l3IgBTT6uhyenvxEbyMpvbR?=
 =?us-ascii?Q?DkMRtssaq1Q1BTldQG1j25rz3rnHhbyyjtJpriqflp/3GVWeNje6iwMddmEe?=
 =?us-ascii?Q?4Z8FSBPikjP/gpn6NuBjDFEEMmt7jLYqXMQX+BzuF3nj9FxIzEpZ3aqhCvUh?=
 =?us-ascii?Q?yxRpZSpbSZJV8iNoTggWR9vgX6pAa46sZz6vCh4iI2GM6UxFTnD8Yo03mKUS?=
 =?us-ascii?Q?7LzZD5GjD3mX5AN9WWlBlQbYWLIWRIM2aqC8INo0F2QEZBbTF6qZEA8CiVBH?=
 =?us-ascii?Q?NfcwHXg7g9X+FIsmWW0VqR5tFcPWy/hUH2076OoKZOtxs52gY7cqw6FoF/yt?=
 =?us-ascii?Q?1IwMVQHamFtpZSwwM/ZmgoJXkFN/2FJqZe1nzJbVmMAF8Db9zXSjLg4Hd4k5?=
 =?us-ascii?Q?cGPz0FAmu+gHgWGE9CWb5W64KMAdmm1AZafpngXd6kC6rkPy/K7BVxgcdylG?=
 =?us-ascii?Q?zieuA5o/ye9lQMBT0vpJF31dPn1mLs/QKyu71Zb5pGmylLKTJT+GjrXjFxg9?=
 =?us-ascii?Q?Yz+v1v1CciqXMk/Im5EWiAmfvtJxsrB+dttiIk9X3WbBoec0f7/xuNVaMQmN?=
 =?us-ascii?Q?ljFMFH4c7nD6c4y8CPTOqwkowtixCAwdI1LeXa5ts6OVWOTHdLSVC+S08cZU?=
 =?us-ascii?Q?8I/87NPT3C+CVLKhK7PZwTBigqd1VOI9uO8vu3MGHw1e7mwXZ3SuGX0OwMRS?=
 =?us-ascii?Q?GbETkBdWTpR1ufF4avrxib5Miko1z1bMnY7LaZUntFs2Xs3RJHuFTj4cG8Bd?=
 =?us-ascii?Q?OuU/zk9e4ExTtzicmAUSZrQ3sr3yHiO7W3tbXCWzWSzwXd50aMxkThilM63w?=
 =?us-ascii?Q?adWFUd3lQbGYohy4o3qfLqBJopZSXai+/3aR7DhB7ql/t02XbZAkB+12oIrI?=
 =?us-ascii?Q?vquphYcc6gU429VnCwn4pyo6qUzCu0OEE9sWSQdvSrnVNK3y/Mc8unuwlpi6?=
 =?us-ascii?Q?iJflAl0zWAR6Mc0g68C6H0Ds?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef536f8e-6003-416a-cb43-08d958cf11c9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2587.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 11:41:03.2526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWyXBGqj5g1A+Yk6f3VrhF2Ykmlzx9Atw02S+2WGzUelO69TuD2p694W3Sbkzi24voSIwxnTUTlFr22j//TKyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1737
X-Proofpoint-GUID: otcApt5hcD6smIknGpqoDnSMCC2gosnW
X-Proofpoint-ORIG-GUID: otcApt5hcD6smIknGpqoDnSMCC2gosnW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-06_04,2021-08-05_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 adultscore=0 clxscore=1011 phishscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=771 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108060083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's "mustn't", not "musn't". Let's fix that.

Signed-off-by: Jun Miao <jun.miao@windriver.com>
---
 kernel/hung_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 9888e2bc8c76..ea5ba912db06 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -99,7 +99,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	/*
 	 * When a freshly created task is scheduled once, changes its state to
 	 * TASK_UNINTERRUPTIBLE without having ever been switched out once, it
-	 * musn't be checked.
+	 * mustn't be checked.
 	 */
 	if (unlikely(!switch_count))
 		return;
-- 
2.32.0

