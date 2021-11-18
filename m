Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A194561C8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbhKRRyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:54:03 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:58356 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234205AbhKRRxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:53:46 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIGra68000706;
        Thu, 18 Nov 2021 17:50:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Wuv8VfS4jRjNJWU/UtSM9cLIfFrgkMtZeOn5qkXuhsY=;
 b=UhILnJhLJD2HaTKgVu6s3O94com9dLO3AGSjSFExzqK1sdXiGaxRWSf3lqYrmVNG1hT7
 V8HSvJhTFZNsT5xkipTEvxyFeeVkHrnJl2H4cFmGhJcv0f2lJtrxYKq5ppFsYAGUwaTJ
 lzMyqi5kW0j9TS9+M/+ooaXUPm/gB9ElBopL3E3Bm8NrIfFd8RoJBLFXceTAcCn3+HqM
 ul1nH4YIUd41SAWEnLZmqILMnZLwAtTcx/xadNbdfnreDNaKVPrrjCUP/WhBKaj1skPc
 p6lHAFVp2zf9j1LsZRHBzg9cIXV4I6b4lIrT89XlE9/zWfUkQZvVAiSg/GBySCBWsVK8 Qw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd205hh5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHkLAN102936;
        Thu, 18 Nov 2021 17:50:23 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2048.outbound.protection.outlook.com [104.47.74.48])
        by userp3030.oracle.com with ESMTP id 3ca2g0vmmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltdwfoUN+GP+5UkrhyzejBjAf1xm+KWKI/JqfRDDxLFrvBXYKASSIml+CumiZKIyWGn8X/dfVUTFS93oWEU9BXqdnFuAoJWg95P08Ojp+BWX2Mc5PVRzx1FlBPdNulHrn/M1Kk5A9qS8xVonWL7gxBVX/WR7gFBVwrnvrl0bNmxIiBPxWkdr6ix47y5oxfGXLW6Kgb2dHtzFHfqoi2Ozw04yV8JQXP10/WGRfX51YcdO3nRiJbd01D+P4aewNH2uGk9Y2Xz/+cW7AoodW/1LmqTk4wq/6NJWoGwHqJ1jR03f5dzIMP5cQg8pLr1OuXhjr5sLkai3ePpL7buxvtJshw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wuv8VfS4jRjNJWU/UtSM9cLIfFrgkMtZeOn5qkXuhsY=;
 b=VhDSf4/tpKF3pL9F4QIUbKVEYPen1hT5UEyZd0FGaebIIzA8YUQXEnD9Rq4MhOpMS5wXhnfGK6VfAgqH20GHhKaNUOt8UKRzUR75nU4tQcm5TbJe2Jp+lhq5Lkm93noiQsUPzwwuOBs6oGvbo9PSdUSAp865nvngFFVhRJwZICXFTPEGKQignSJk61mCXIB8TlQA6eGPv2jq2SN9tSq/b21U79vjzzMdw3zPAsN+cpCmYsh7fAXd2PtvHvm62P6zlQvVykzFyB534RTuTD+wRVVIO7ffjQa54HOtH52Rrm7NbXNXycuUcT3m1+JFYA226iTmvcfOHSAfhVPVH+GBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wuv8VfS4jRjNJWU/UtSM9cLIfFrgkMtZeOn5qkXuhsY=;
 b=XnWuFdiqHUwhExnnAwcHRetcoJ89CtlHig/b9YosbLTpDQ+pjliJTUCSgZMMrAikZF46CdQFFd+aGnzD12QlqJwl4mECkZH+Dr70XG2Nx03QEr2pTK4DaLcxUd8iG9GCh3JhFAKddUiqHApjaiFB0chinnRuL0voR89UECOyCWo=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MWHPR10MB2045.namprd10.prod.outlook.com (2603:10b6:300:109::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Thu, 18 Nov
 2021 17:50:20 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6%8]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 17:50:20 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [RFC v1 6/8] crash hp: Add x86 crash hotplug state items to kimage
Date:   Thu, 18 Nov 2021 12:49:46 -0500
Message-Id: <20211118174948.37435-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:806:27::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA9PR13CA0124.namprd13.prod.outlook.com (2603:10b6:806:27::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.7 via Frontend Transport; Thu, 18 Nov 2021 17:50:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 969f15a8-908e-4f33-7c5d-08d9aabbe395
X-MS-TrafficTypeDiagnostic: MWHPR10MB2045:
X-Microsoft-Antispam-PRVS: <MWHPR10MB204559637C1CFAF8A2F2D0DA979B9@MWHPR10MB2045.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sf3Ud2Xa+UVIps+MdYG3kzF3/dBQcResZ8HzYLX0Er8+24TCnMlWxomAEF4i6s+Q+htLdwjLbFCUDMqqXLNhBuktDoZ6YdI1X0e6Ppb5JtNCXR3uXr6eIs/t8EQINXeT5DCW0oas7VBny6opVmwdUodgx3nfy2BRteLCeC1MqtKSXr3uDCQ+9F+VvqXtwlNrETLuGgWtcLi3R1o/VnL8X+AyeA+WB7tGV+Uk4+nyvoFsFYhHri+Sqsf+PXmmZas3hLs2I1cK5X/MROxCVjdDB1GRilfzAXtYN560s2TFKSiBWRsBOi8aLQzANUCGkWZrz/2D66xlpXai6uj43V1l2qV/+0Myz6m+3WUdqjjB0CZ7A5Tt1JeWYQNVRYDrb2HtZeQlzSWObNJMj0hrnxojk+02tl+p036KtRrlzsbkaPfLwIKXf5GPv0KEkqI2MjwK+rFdy7p/sEyCFEw/6k5TyPNDpv8W5XFtkWad1YfM9GGLXQkffKJ7/Qa31DVPY0Tfj8LqZM/dTchSH6Mm61BxQ02I+TWHMgLyh3a6aCD1hYkcRtpbLP41JrkLPL58F30aR9QqbcVwxYK2tifZQEYZ6OHi73rSAqACOFCz+rR4OzowAiOCtezai0jRAXO3A/zg4Z/mS1w8LIrI9TefRg9SF6GdeWgaVtLyrqR0so0VPnW7uUYvCNiZ0TpVM2ZtJjORkqO4BcAc/Q/YJT2oZOtVaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(2616005)(6506007)(5660300002)(186003)(956004)(36756003)(4326008)(38100700002)(52116002)(38350700002)(107886003)(6666004)(8676002)(86362001)(316002)(6512007)(66946007)(508600001)(66556008)(66476007)(6486002)(26005)(8936002)(7416002)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4JbBp85kIfnE5eWAWcPs+Rc87+erlIBnaa0r9AEyn5trItzRkn0TjrEgGTeV?=
 =?us-ascii?Q?U+LqR5tOlbx4Q4W4KcEwXLBY9Tw0D6Vr+vwxBBfGPyeaXHCGuYtM2RkxZ1yi?=
 =?us-ascii?Q?+zyAeDTaWrKLxz1wlGiEUse1aGoOsOmVBiklDEbtdNI2p0MfqBjqObXReYCp?=
 =?us-ascii?Q?o0Jnz185d/eHv81rFPaldL55ovxTweyRAXgiWR+lsGGyTn7HHGRbPcIahgD7?=
 =?us-ascii?Q?Q4GAWT6boMXKsAit1j50XZtUJZvQMODGPT0vDiHvQ0N5TWUmpyLEOiRhFqal?=
 =?us-ascii?Q?7sC/YnT+e9ub8Ui6LuSFz3hJTyWLSqBFmjEguSrUmIpPf1zRaY8cebCuVKlL?=
 =?us-ascii?Q?5f99eMtqq6jG2k8RCwA5mwPqXcrBu391VW/ncE1LLU/2hHgKg91/RTISlYtd?=
 =?us-ascii?Q?Okmf37BnGoiB5P8BbgVaVLxdI5UuU7MHUkg0TihuGmd+wXQYF1FkI88Pe4aW?=
 =?us-ascii?Q?BMN1Vh7/fK8gJ036GvpvaUk+hzdoY0OQxZkAIP9RhFgoKkdHSba3Zq5v8ow4?=
 =?us-ascii?Q?axy/8sRMI1+uK9z1EIYMicIBsdwFLu/T4rsovHpA5/+D6zFuuVgEbKMT5Yxy?=
 =?us-ascii?Q?SO8C0kQ6rJEFDWqtHpkW+HEs3EJ4amX/mX7Kvf40C2T5cwTM3ZFjUM/g7WLZ?=
 =?us-ascii?Q?hLHyKpsMS6agiMOkb+3bFvENAEApUR/aO0t9clcs//Y5mwQyfKcYukkJA26k?=
 =?us-ascii?Q?BW0fztAZiIlRlK6CrjoRoW013z0tMLSaoZ5PSsCM//tHWMitxgqUbakAkzSC?=
 =?us-ascii?Q?oVctRdUxKy/jJJXDowaJygQjhGuH4rIcpLkRDlqJjbB7MWaEMMxqV2GXOOfK?=
 =?us-ascii?Q?UGHytKzC9ozIQu03OAfIG3FIcus7Zf/FlsWFCe5GToSZ4FmyMqmQV1/wNw/9?=
 =?us-ascii?Q?6l5dIj+SrwyJqprbPhqZnc4Pk98AX/s8KpRdhdoa1sHXGSMI4WoV2nY3yaX1?=
 =?us-ascii?Q?3LofT/9eFd2KlGPQGiqH3UlFd1oj8tR7x8F6Ec68hkXpgownkX8AUBh/pJ/n?=
 =?us-ascii?Q?a3ZemZiXFrRaqmOQ2Elxy570a4m6WW89Ecwn4jvOEF69Xx3UJf2lCF1ZyPxc?=
 =?us-ascii?Q?8ZnsttsrFjYTThWgvh//vT53lZPOnMtUbfRh3Kl48SAaV75PmYuNagVEuwWX?=
 =?us-ascii?Q?vX9KxdJyHtIFSluskeEBgDp+yuxrfQtJL289urT4nfSwtM4vn4MQlPIJy1hI?=
 =?us-ascii?Q?NTz7/IHBtawTXM8AVfKkPmN5nKdBdEk2c5ZCU/xQmOuTiU0KWb8ey2xBw73l?=
 =?us-ascii?Q?31scBhxis2Cm1lOft8KwUTYrPYvEONeZgBtL8NWSu8uPYH/518PhMc4JCCnB?=
 =?us-ascii?Q?bnaMDj5YGAF1FEW7yIZmU5c/pyL4cTkeotYz/HymriFc5NoycnvmD1uBA/ZL?=
 =?us-ascii?Q?y1t7a1S/jry7NGytnZwNYs2Y04ggfpkzpSek9Zo5bQCx++FAvW4iVB4eb6Ft?=
 =?us-ascii?Q?+vF3biNQJ9lF+ReeUyYczYayWyQSOeDFCvIefMgW0rS/KqEJ/swRHvKLv8Q0?=
 =?us-ascii?Q?iq9ce0ThmJ3twT7of591GY9Jas+WXp9/SAP3DU3YrMNzysomdHD1eRLif7kN?=
 =?us-ascii?Q?/9vk9fy+U0gKxL1QroybDRB/Mi8x9FQTpPvQx3Aj0fG4PXKdaUgEOM6vgys4?=
 =?us-ascii?Q?I5SAsFrL+Sq1YLDhHxw2RWFT7gQWgFotD4LzvdIX06jlUQBQ3HIHvqUVesqB?=
 =?us-ascii?Q?VuCtMw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 969f15a8-908e-4f33-7c5d-08d9aabbe395
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 17:50:20.5647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +6AT/U14n1OoC3D7XRxECOVSdrZmls/xoYGL7dbxZ8uHWTfdVb5zX7ueBB6EFrlzNIQChxIQI/+JPMpIfyN+W8mOFtxGfjxgzPk7S+o7kfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB2045
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180093
X-Proofpoint-ORIG-GUID: DJKC-2T837t2x5BqR7HFkKL8hzPPSm_g
X-Proofpoint-GUID: DJKC-2T837t2x5BqR7HFkKL8hzPPSm_g
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To facilitate hotplug updates of the crash elfcorehdr, a few members
are added to the kimage arch struct.

The indices of the elfcorehdr and purgatory segments are recorded
here so that upon a hotplug event, those segments can be efficiently
located and updated accordingly.

The purgatory image also requires a few register context values in
order to transition from purgatory to the next/capture kernel.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/include/asm/kexec.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
index 11b7c06e2828..b08fe56239c8 100644
--- a/arch/x86/include/asm/kexec.h
+++ b/arch/x86/include/asm/kexec.h
@@ -150,6 +150,16 @@ struct kimage_arch {
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
+#ifdef CONFIG_CRASH_HOTPLUG
+	struct {
+		int elf_index;
+		int purg_index;
+		unsigned long rbx;
+		unsigned long rsi;
+		unsigned long rip;
+		unsigned long rsp;
+	} hp;
+#endif
 };
 #endif /* CONFIG_X86_32 */
 
-- 
2.27.0

