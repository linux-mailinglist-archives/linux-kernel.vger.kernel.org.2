Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADE9735D2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 00:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343634AbhDLWOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 18:14:18 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:43426 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbhDLWOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 18:14:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CM9UgU171710;
        Mon, 12 Apr 2021 22:13:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2020-01-29;
 bh=bxznug1KSGqdO16VnX6LEuJVbeaaHzZRECY+/AFGSpM=;
 b=dG5zUywZxh55cFCAIBq8s5EjzCmDIKe72CycosiWGLRyHT9FF0b3Vf+Gx1AKSoRiOvha
 eIsKVhTX1wG9LhH2iuIrL1V9ow6nsTb+5v7/8pUvAt0o/6RdMchZsO735oJAyguJYUT/
 Vjjc6z0M5u4vows+XZUQzEShUUYeCkSpP7HnbiFFEioR2Ki0RLvGvwqYfQyqdP5mjzn0
 ZEOnt6d0WSuK+mP6KAQScI6h7wLhxYIr4QAJKkNuFBtDJIx9w6eFfQHvAmdpZE95ItxL
 hfIKvO0Q1g3awKKsKLO1nEi2v4FWTkjIglUMAOjd8/5qFo8UXH1Muim4M9H8l+0s4yI7 HA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37u1hbdccu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 22:13:43 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13CM5QD3097791;
        Mon, 12 Apr 2021 22:13:42 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by userp3020.oracle.com with ESMTP id 37unsrgjr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Apr 2021 22:13:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1eHo/dTMEIEsVFRh55YgOdON8KWameRd4CxnIxe00Lcf7mCfiuxV5lZ8tIfAPN5pFDq4JQK5t9AC26n1j8lwb19OA31TxdtXmSjs89FyR49GEOLsITj72TUusHEwAabRebCGkLRFMWO5JiHEksVYncK4RGq+zaSfYNJrv61XVrOM3lpB4gFm7V2q2Ke7dPRY+J6helFnOK7cdVLVPx4+EYUCEygOVLKBHONGkv+lIsUwUkUmqPmJy88eIo6x52+P6VwUVg7uoizuhKl1Z082nN2JGuBBS13ErnS4ADn2O9atSuPkgrbI7wWzFjswqNl0eqOf8+ioNRFOX+9eEwYtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxznug1KSGqdO16VnX6LEuJVbeaaHzZRECY+/AFGSpM=;
 b=Ym/xM9dKI2V/U8R3kKx1ew6NvRBDd1ERfZGlv3zilpfo08qHJqkQ0Q7Ba+lheFsPBW0B/QcP+Vo3wIkORuNe76nOYh8jipvDtoSRGwt6aOBhO7E7e3f3VebntmrzjB0nizuvmFossV9yl5HnB0umOdiOyRYG8m9SU96z97xZGmlckM7/nVvfsex6y/qSpzNRU9up3Ppi8/AYJAKTtbs0ibu9gu3KrkZ9munb5TLb0gRlqOXBLw89GmBZDwqGb1kYbMzkCQgMewM8mjDbLFVevmP1qUD+hI1VWE0d2FbUo588R7g2LGq8sHPWGGFX5CS4XuzW2OvmqdVe9nNeSfRZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxznug1KSGqdO16VnX6LEuJVbeaaHzZRECY+/AFGSpM=;
 b=yeg10Ni4l/yJQV6ymTxSw194YjHsXCsFZBkJbXqCU3BgyteZoPAgwQmUzm4LEh3CmJaHcPO57GPDleEl4TBuLxDtsAJCXsljLTxQKaUC/u1p6AsIy8ZrPUNFdkAIokX06+UNKrb2SOQIAjaj4Nph2ed7nxwiGYhFzIoEtjArouY=
Authentication-Results: us.ibm.com; dkim=none (message not signed)
 header.d=none;us.ibm.com; dmarc=none action=none header.from=oracle.com;
Received: from CH2PR10MB4118.namprd10.prod.outlook.com (2603:10b6:610:a4::8)
 by CH2PR10MB3974.namprd10.prod.outlook.com (2603:10b6:610:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 22:13:40 +0000
Received: from CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::5d0c:35a5:182d:4517]) by CH2PR10MB4118.namprd10.prod.outlook.com
 ([fe80::5d0c:35a5:182d:4517%5]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 22:13:40 +0000
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
To:     Ram Pai <linuxram@us.ibm.com>
Cc:     linux-kernel@vger.kernel.org,
        Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH] selftests/vm/pkeys: fix assert when DEBUG_LEVEL is set to 2
Date:   Mon, 12 Apr 2021 17:13:31 -0500
Message-Id: <20210412221331.14914-1-dave.kleikamp@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [68.201.65.98]
X-ClientProxiedBy: SN6PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:805:de::22) To CH2PR10MB4118.namprd10.prod.outlook.com
 (2603:10b6:610:a4::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from shaggy-t450.localdomain (68.201.65.98) by SN6PR05CA0009.namprd05.prod.outlook.com (2603:10b6:805:de::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Mon, 12 Apr 2021 22:13:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de7384f6-1861-4053-463b-08d8fe003a41
X-MS-TrafficTypeDiagnostic: CH2PR10MB3974:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR10MB3974265989554D92F8FA9B0487709@CH2PR10MB3974.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kw3/zS2Dq6y7UdEoFU+9Bw9BAHn/XpGolouJwrXnXMFxFegELe3iBhUaK6tr9xQJqwZAhogJHDHN13Pvghb7XORFBUFrPUCXmNDBEZHufBrpAyYWOyCvKw0mTTVYOElG6D79rvs8fn0Jcv3qbZnT1g7O9xCqmavUi42DAXbrVrO9FYwPn+Y0wehGqma1LWiJ+ErppbwHpFJnGNkMDkRQynytJJgIe6Z5rDPWqqplU5FiMlPRqzqRe77G1UbXkR1kUH9n46J5bf4Vqzw1kEP2Bdc5DUP26lT/YYhajlzJ9wM+Qnx1YIYD6ZuhWTLtj2RgvO+Tq3Yj+AKlmdwqpEyI58p2QLA+swTm1RTBNf/FWkqiYlStoRBi4PBJNB/dEcU3xSANqGUW6mqIm1/EyP0pNS+LAnw6AVsjgGB+GkIKDDe2mbw1DK4IXxDfeTblEulcRp6mtIo/ynHFv24XZz2ElC0iJxAF0fXigPiCf0uClUHRwU/3jO74XVIYyzIsU/IMeIyAXkSJYDAAvQAUiNUy6uCK9H0dtYd9d4add+MIxBPX/THt2jf1J7ThfzUm1nQgg8QrQNnxMyKKrkKz1Asvb9lAlmTw15n6TN9mWmo2T/eWyhct9PlEb0GYRdzvKWmDlsUqjRz8fnnJDjD+TPWSTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4118.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(136003)(376002)(39860400002)(1076003)(6512007)(6486002)(66556008)(6506007)(5660300002)(8936002)(8676002)(6916009)(52116002)(956004)(478600001)(44832011)(2906002)(66946007)(316002)(107886003)(2616005)(186003)(16526019)(26005)(4326008)(36756003)(6666004)(83380400001)(38350700002)(86362001)(38100700002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?eAv/xnkSxPk9q8sJPw2IRHXXTuojdzxh9/zA+h208cp9mAuqWwnVIgHAyYPN?=
 =?us-ascii?Q?DO28du/Bk4lUlPg/uWZhYfLy4HTmEKGxa4ZYBXIOaIFe2FU7hY421UUb97bG?=
 =?us-ascii?Q?upvX3Jc4cIQouXRsz2nc5Qcn8s/h7FTAm7JmArVDp+nif2S9DWEpOkKNrqcq?=
 =?us-ascii?Q?p76rsW/yrVvUw0tnOKqZw/CNZHNn9rWftGkOY0QGbHTq1ZNPgBl+o+Zc5PkT?=
 =?us-ascii?Q?41YQwjtC5bScJBc2uR5gAGwWf2QkEQl2DIvl1irJa4aGDZZrRU1WcpuCJ2nT?=
 =?us-ascii?Q?sEahdOC2rujjmjcdgf18nmdGgdI6xmIE7KOfqzl/1TuRFF28Htrmsg1tCRCM?=
 =?us-ascii?Q?iGlDd3DBXcQX+eoHaBo+5QeaNiga+0Kc130YWI6owgSxRgwFQngd6TBLb7+D?=
 =?us-ascii?Q?/S+mM7tKREDEzimt+ju8FLbLIfUlo5hAWMk6LuCYP/o9TH80VtXzV5HU7+VI?=
 =?us-ascii?Q?Z5IbuiX1k/GsXAYM7BPWuuTHtI/x/F4XufN4ZngqNuektnXJgdqnnlvXXAzJ?=
 =?us-ascii?Q?HivAU0UaumUfDT4WhXCHhVT8Esac+GnBYip8+M561nxg0qIt/hWXF9TWj/De?=
 =?us-ascii?Q?6qwj4W6G0940ZcpB9gFmUAvpVH74MKyWP/9ti5K7BZT10J/Yx6YW8WDtNZuM?=
 =?us-ascii?Q?iP5orN5npZ44XmTntQsgNzjHs17NU7TMe98rigHu4kTWhwC7+8MnjDr6ZUkm?=
 =?us-ascii?Q?EgYM4TueXItiHhYNsTlNIhJ7/oHKAeu4F9c0fqTGHCUH/idiSXu5iNmCMSxg?=
 =?us-ascii?Q?aIg2FVx0jE8OpwG0lRyAFi+PxXy9e3+6sCUxSKIetTjexOq4jNrLEjNxjZ1V?=
 =?us-ascii?Q?LZYX5uKEra96PLFhnFDeIM8Ui+3hYtILvk+EfqzrGYZM38cInWkWcwdl/0KF?=
 =?us-ascii?Q?R1r8SFhjI5F9alTUqtOFpNB95xXsY3WNdYzID+wqTH69gGK3SrRacSYfelGP?=
 =?us-ascii?Q?2+qZp+rLbTCgA8gYSsbT5BmY/xEd2pXlrc0o6/S0gpWwZskEywC/PmR9iIr5?=
 =?us-ascii?Q?ykOV/f/YiShatemQ7a/t3/OoWom30kb7A7rZqgJyp2hTJDjpB34tRbpa/BKm?=
 =?us-ascii?Q?nLsy1p11r+2FeUC2IFayCPBXmMVqzVQEJhYUC8UYwuGcdyeN/uIYzQVkbpoQ?=
 =?us-ascii?Q?eyUYuCvYluwoKNTWBjkylIOvaOUerPzG0Ci0RXawL8GwG7kdV+zD2lj37eOD?=
 =?us-ascii?Q?apSR2WR4yj3gjHzbAcHSUxoY8O5EzKX2g4LU49PDkpR0NxNVah3La7tk7V6F?=
 =?us-ascii?Q?2ZKpQI6oLfOdDjqvGGSoMNs/S14/GLmjzapvxjWL7+n9I5pcHTjqjPb12x0x?=
 =?us-ascii?Q?xZmtIbsUolAh0ECGFU9GbiJT?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7384f6-1861-4053-463b-08d8fe003a41
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4118.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 22:13:40.5140
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hyxXWR7dMPn8ugl7IQhPcH6hy1TVj31wHhrUVw/ZX+ADaF8DYmEVZiteBQuw4ZhGRdwaLxFIZBvHWLa+e2r28q9ObWlIqLSuR6og4zFfWO8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3974
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104120143
X-Proofpoint-GUID: RZaUs3eOXxPH4MyWTOwy2_NzabgL3J3L
X-Proofpoint-ORIG-GUID: RZaUs3eOXxPH4MyWTOwy2_NzabgL3J3L
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9952 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104120143
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

test_implicit_mprotect_exec_only_memory() hits an assert in
_read_pkey_reg() when DEBUG_LEVEL=2.

test 12 starting with pkey: 2
doing malloc_pkey_anon_huge(size=4096, prot=0x3, pkey=2)
new_nr_records: 1
new_size: 24
sys_mprotect_pkey(0x0x7f44144bb000, 400000, prot=3, pkey=2)
mprotect_pkey(0x7f44144bb000, 400000, prot=0x3, pkey=2) ret: 0
mprotect_pkey()::628, ret: 0 pkey_reg: 0x0000000000000000 shadow: 0x0000000000000000
unaligned protection_keys: pkey-helpers.h:127: _read_pkey_reg: Assertion `pkey_reg == shadow_pkey_reg' failed.

This patch provides one way to fix it. Would it be better to make sure
that shadow_pkey_reg is properly set?

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Ram Pai <linuxram@us.ibm.com>
---
 tools/testing/selftests/vm/protection_keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
index fdbb602ecf32..070f6f90dcce 100644
--- a/tools/testing/selftests/vm/protection_keys.c
+++ b/tools/testing/selftests/vm/protection_keys.c
@@ -1449,7 +1449,7 @@ void test_implicit_mprotect_exec_only_memory(int *ptr, u16 pkey)
 	ret = mprotect(p1, PAGE_SIZE, PROT_EXEC);
 	pkey_assert(!ret);
 
-	dprintf2("pkey_reg: %016llx\n", read_pkey_reg());
+	dprintf2("pkey_reg: %016llx\n", __read_pkey_reg());
 
 	/* Make sure this is an *instruction* fault */
 	madvise(p1, PAGE_SIZE, MADV_DONTNEED);
-- 
2.31.1

