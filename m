Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8104561CB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:51:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhKRRyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:54:10 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:21458 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234245AbhKRRyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:54:02 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHQUdX009982;
        Thu, 18 Nov 2021 17:50:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=OG9pX7nWTdZqe7VXOme5GNeHMPJB7t5T+NTE1mkp7Cc=;
 b=dGE/ck2V73+qHE5YgX54JHdpg0pck8vAafv5k2NYmeEDOYjAFAsC5lzbaYZeRxIou+qr
 Aeb92JRBGw3r5mBK6UB0KeOWjqxxuI/qSvaQcMhh14/OlbjuIi357IBASgcCdS6cE3lm
 b9yWqd8fv07xl0DaHzknu0tbjiwIP15uvnA1SoA2YqW3+c7LBrdSqaphnu/OVcHYPUBo
 5q0OGnZH4f8NbdNKZB2uaF13/QFroMk7zIzNmkGtv5KIGU8d8DHt+wq++SSfcRM80SeW
 PfCYa01br7ZHKowig4ZxjC5lrOZI+jdevCqSnoLZNqPRHyLd0erFYDIhK7ky7W0miTaH Bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cd382hrxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AIHkWNh165605;
        Thu, 18 Nov 2021 17:50:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by aserp3030.oracle.com with ESMTP id 3ccccs49xd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Nov 2021 17:50:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSGo6Jd0Gj1BcloKalXW514uRUC2/LSIbeQI0jD+2DfmRfjiiUN2y/HZt1merSC/LFtuYuL7psNmksAIDGTUr50/jSVfLPfdaTiyCKzTWCZbR5c7VaHGMi43/NeMXdMmZrGsdg/NFsaM6M/w9abVGGriW59zEKmrxWamrhhvn0zokMRQ73bifBxMNCTth3qQJzYtZjP/axKINcCQze8FV0CYhWo1aQqyg6jrrl51o9nFAHZT99o4QfFw8m0VZgxPpZ/GDUhpyK5+NVHE/NL/hpFmt3H7oXFFHC7snBSL4XvMQoATGHmKDnC0Ytt7Fq6/jr/Wz02wMsbO9q5+QduneQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OG9pX7nWTdZqe7VXOme5GNeHMPJB7t5T+NTE1mkp7Cc=;
 b=ZECslpSzUBxscoSnudL4bfFNG4fcedZ+axRYhTLmi5xY4pJ3lZ46HcmYKA8+ADutsxpxW110wJojZpYo0lNNsKj5MQENu/e+S/qI0ypvMH2rUKGDFCur8yvaULkqdPIVtO1VJOLVPkyz878AfRlol9BIiCzeqS3xlbb3aUvfDiK8Sl/B2H6MzTmZOqES4xNF0K/e9TGtrbIkVeEH9+fYtGTJtDIfzVILw5CE0uAaQBq18AzSGE8mZ0+vKxc5yR1f5KUd8vbcjLoeZIDYS5Ge7fS/frOlNu6mOjYlzd5AduKI1jD0eUgcPs0BwiRMDy7KrjUwYXkA/y2PXIpumLbn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OG9pX7nWTdZqe7VXOme5GNeHMPJB7t5T+NTE1mkp7Cc=;
 b=WCSL287PV9e9feWG+lyGiRHXq8EeejzRpNrH0AGxq4/3NnXYIiDwLq435C1TPPu7r6R2p6oHLVH4Q7L/teDMppP3DDBNkrgP67QEamFzqyUmDqvvOqZLCJp9hcHQM/5wA4aeTTxk/bF6Jjp91ygok/rhaOK5P4xUx89h/PNHEKQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CO6PR10MB5652.namprd10.prod.outlook.com (2603:10b6:303:14f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Thu, 18 Nov
 2021 17:50:25 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::90ef:e061:a4c2:acd6%8]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 17:50:25 +0000
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
Subject: [RFC v1 8/8] crash hp: Add x86 crash hotplug support for bzImage
Date:   Thu, 18 Nov 2021 12:49:48 -0500
Message-Id: <20211118174948.37435-9-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211118174948.37435-1-eric.devolder@oracle.com>
References: <20211118174948.37435-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0124.namprd13.prod.outlook.com
 (2603:10b6:806:27::9) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
Received: from localhost.localdomain (138.3.201.23) by SA9PR13CA0124.namprd13.prod.outlook.com (2603:10b6:806:27::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.7 via Frontend Transport; Thu, 18 Nov 2021 17:50:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbf354a7-53ca-4ef4-642d-08d9aabbe699
X-MS-TrafficTypeDiagnostic: CO6PR10MB5652:
X-Microsoft-Antispam-PRVS: <CO6PR10MB565255B968A45CF5186979B6979B9@CO6PR10MB5652.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CsSRtleZ/1fvtW2yGN5Etj5GQeMinv16SPb/o6Pbykq/wgosiAiBNCVzdENWUwJu4lD0qXQQSzIbK6a++x4J0tOhNY3XUqR8Ci9JywMZEte6hjopqFDRXwklINNZS8CetOU577qMcEkhOIjDDJgduPMlxILYuw4HmZ+DG9ib2W5fE5BjarhvIDu0M7+0myo6O1jOQrknL/r9sOt+mw4/s0Y0eSF40XF50O868yNt3yEbwnMQCjEMRtSzunCHG2wDWGZ2J65cjaDEnIAH3HfXnVUREkhWbLpK1nRI8/hIplkkZlqKF09nAfKE1ApVl4aA8OI/J7hsFDr5ieRbWf55ptPiPVc/HlQVBGgIG9VO0jzwtZel1ihQUCx0S1sDe2f4dVo76ohNwqDVvBvwEHAinpWtbS369FJvHwD/jNlQMTqMEIx0uOKnMgQZajaHc6fuMjWsy/vOrnfbCBChm7VqWR1UTYQhG0OfyTqQ+dmeAvxbcbCPsxCuWfCAsOdOnjjIbU71DNPFVC9jTkCO6NPuAd+3usxey4sQ4n3LMgJrT0QsDwlPSwHyMrSrLk8U5Tl647D3HxBy1R11CPx6UaGcLi6TaQUA8ph+nqH6ZtUluqTxbccCaOFx0AG25CZH21CNXu+MNZo6pXs8gvtjhy+ncbcw4cXd48gZbU7NBHD+tGGoMcHiC/sCZc48HeJYMFUka1tP38ZG0mINaiBkTSobsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(6666004)(66556008)(186003)(8676002)(1076003)(6512007)(66946007)(6506007)(6486002)(36756003)(508600001)(4326008)(66476007)(8936002)(2906002)(107886003)(316002)(956004)(38100700002)(86362001)(7416002)(52116002)(2616005)(26005)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?13+n5gAplpZuhFV/Z1Tmo9x11zIaXJtVeShSfWCXea9BucAZ2AHh6yUVYNi6?=
 =?us-ascii?Q?Rj7q7Y5ne0slH4pXXzYxFltUpu0GlQoS0oLI9G6ypPlTccNCscl4+bls5oOu?=
 =?us-ascii?Q?Y8s0uRCulzPJLpP05brRnuUk1ZMmnSxGCzTT+PSwnAt5S35HwbIDIJJ9/3nh?=
 =?us-ascii?Q?VG9cGo1dttYaA902ss78zwD2FECwQMbtZ+NL4HcLTIbvbvQ5t00NJA4rZT8T?=
 =?us-ascii?Q?n+DXZf8VSQM8pPbhivoa/KTDvN4AWzi0OT3axlaXkl24SN3SQ6yp62yVR92g?=
 =?us-ascii?Q?aLDgocK6TPoQtm72yJQ5YMWxGZiBw/WMzsOigwaYqeKOzCbMB1buGuCfF9Zw?=
 =?us-ascii?Q?hRwoI2nvoi64Rwl24Kpww94FYMQ+kq2nqKeQMMK15WLSHClv6+W8fZp1xS0Y?=
 =?us-ascii?Q?II33b37FpQDjAtjL82zIvzC9R4H2nFG1vAwQ9Szr6GKaauVskPDVqeNsXz+d?=
 =?us-ascii?Q?jgZb3ZXf1OwMZK46qcEh+H2DP3ahj+laPSRnTOcGaJgDxH+bl5mAqt8mQtBN?=
 =?us-ascii?Q?CjTbLcFsQQ8mYHM6C1RuNI9k2PtEUJrCchFJh4jhaq1K541hDsQLDQrQQQXF?=
 =?us-ascii?Q?odQbBu9Pw2ZU+p1j/TPRq1PufbqIUUQFJ3IhxBkm0FyXTGODrRo9Z6w30o4i?=
 =?us-ascii?Q?AQRXHR3IAHru5YdldLCw9fEb2rh2zf+IfkkdoaehIxi/0Et141fFt2FdtJX+?=
 =?us-ascii?Q?fvqI6vJ92WouGAWiZS1koGs++UPm/A5VWi54/kusQjqp7pXlzMwPB/S5g7+o?=
 =?us-ascii?Q?sm+nBHo9c+h/EHmYqNQOBFK4Ld5A9T9vBbT2FgWGsSrz/FUb0RoaBG3HtMSb?=
 =?us-ascii?Q?4TlDYQNucNNmm1y4/ozIKdYtf2gC/8vxMqxgjBzaIU3GT4eQiLgeyjs9SWGU?=
 =?us-ascii?Q?pUa/XFbhvV9ko8djdCfNZCKcDCmNsSRMJVqSmf8pDtu0YZwdbu930JUJ8Idm?=
 =?us-ascii?Q?x0iJ44Y3JLDIXXGIWRtP7Uwv+oq5w8bSDppmSASL3C1jRaOC9mByDVno0X/n?=
 =?us-ascii?Q?6fllewYRkJfEDCvnLWKvKbKgNULRBgh5MTlT5RADajQOO4WrWYZpe5zeINIY?=
 =?us-ascii?Q?Y0CVWZgpyGBqosf2S2AxUBIxL9uy2lTUjFdymB8eY+4lW7j0nZza08/K6VJ1?=
 =?us-ascii?Q?FgnwxtryJfOP8+2kwDwHBbA9locNWgatDKf51uCluF0SNK5ZCmFi6sslTbC/?=
 =?us-ascii?Q?M1jHZYWxZLJsDJko+0wOkaoa1I3mL64zaM95uTjc/qat5qu1nRNWtT8yOXCJ?=
 =?us-ascii?Q?5Pk+Ymx67o912gIoS3uWVFlhLjOIzYSv0vWlf0obRnuHvNL0SXIQLN8kZ6SV?=
 =?us-ascii?Q?nj1gFe6fiRsYYxtW+i/ToWh2CAerKmDlSZxkmFPlnJZKXeeaXhsHDeDDymz5?=
 =?us-ascii?Q?pBABBRw6Tk1OeSyF6YJWD3Z5vPNLGfDjGu2NwJTyOWE3NA3B8JLP6685QJzg?=
 =?us-ascii?Q?IOjXlZmDbW8/YMTzWreLLLLXUmOHP4EV/hDC04vdtjz6xO1OQIlCfk2iq/s0?=
 =?us-ascii?Q?RyaKATKOPFfjpZ/oi+Ll+kGoyoulTBge7MOmpOu9+l8c0d41cl5P8AdEY5bB?=
 =?us-ascii?Q?UGSU4CC82Z7w6Cp+qod9OpopGBznKMbmvPQ14xw2CgQNOTG00gh3Zs4mEVOW?=
 =?us-ascii?Q?5mDps5+IRwsyvBBTRdST/+MnCbXNXL8INtn4tJWUIJ45d2Gl44vxjGkl8DBh?=
 =?us-ascii?Q?Zy0AbA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbf354a7-53ca-4ef4-642d-08d9aabbe699
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 17:50:25.5786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cQYc65zfe7v+vra0iR2PDNDNBELzhnwYRPGgIKiNYba5pAIQIjJgVwi2ibuzwUmLXGSpgAmrvEFzc06h29mhSOluX63fbqpKGemsxqCvf7E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5652
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10172 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111180093
X-Proofpoint-ORIG-GUID: z3dj9EEbTwmex8fSsaaJc67LlXLfonqZ
X-Proofpoint-GUID: z3dj9EEbTwmex8fSsaaJc67LlXLfonqZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The few changes to kexec-bzimage64.c are to record information needed
in advance of when a hotplug event occurs. This information is recorded
when the crash/capture kernel is loaded.

In particular, the index of the purgatory segment, and the handful of
register context values needed by purgatory, are recorded.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/kexec-bzimage64.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index 170d0fd68b1f..1886c215215d 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -378,6 +378,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	 * Load purgatory. For 64bit entry point, purgatory  code can be
 	 * anywhere.
 	 */
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* Record the index of the purgatory segment */
+	image->arch.hp.purg_index = image->nr_segments;
+#endif
 	ret = kexec_load_purgatory(image, &pbuf);
 	if (ret) {
 		pr_err("Loading purgatory failed\n");
@@ -488,6 +492,14 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	if (ret)
 		goto out_free_params;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* Save for use on hotplug to patch up purgatory context */
+	image->arch.hp.rbx = regs64.rbx;
+	image->arch.hp.rsi = regs64.rsi;
+	image->arch.hp.rip = regs64.rip;
+	image->arch.hp.rsp = regs64.rsp;
+#endif
+
 	ret = setup_boot_parameters(image, params, bootparam_load_addr,
 				    efi_map_offset, efi_map_sz,
 				    efi_setup_data_offset);
-- 
2.27.0

