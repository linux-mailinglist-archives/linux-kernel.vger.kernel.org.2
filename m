Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32ABF3FE638
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 02:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242668AbhIBADV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 20:03:21 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24154 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236602AbhIBADR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 20:03:17 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 181M53aK027790;
        Thu, 2 Sep 2021 00:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=lqnUUbmRDtDRUEQgPqfI+GRnc7Q8MIezD7vOgcm6jjI=;
 b=HJ3vMvf/SiHHC5/85w9ZyuvHEi0AlRmNO5WYq2KpcYjcwanvhu/My5ML8m4r33jBrgpW
 Wgumc2A3dZz5n2WEbAhMJdeMlQ0W7vFpP2s2+t2Rg/tiM7jMNYCESzvWVSQypwHTOD0b
 EKD6ZL0EFXYBCnKk/fnk1B+g7Hn89JlVKLADIUJWHwKEXyLgqSB7y6ekb57OMfGSiBfA
 QNYqEnDs9iLoVJ+keO6bFMn0hNerdtKwLAjqhk9nB5uvhzkuC3yc56OALnIjy3X4gBVy
 vBlAMqW4Ps5IhM++famaJEpLIscD2vH/nhWORnEUlXCUaKDqCALc6InxpZ7P72WG55Ip 5A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2020-01-29; bh=lqnUUbmRDtDRUEQgPqfI+GRnc7Q8MIezD7vOgcm6jjI=;
 b=tvpdwZkxkZlzz5rMXg0FxQ5KQVykrHCvdvhENWm5hWmszseI5aUfxDhUCUjEz0TRSfDG
 F5EtuyNWVEmaHVFnmuUkP0x8aVoyEASLJXKMC/6XSgElu6xYQrMQUkRLoH5gnUeEr1//
 nT8jER3ZGy/7hcmhpPhtn6K/Rfll2Ly7OpvM5bXjW7AeiB4Pu+93m1F6iD7nP1GfjNPx
 e7hl8rQiz6pvDr/DStZRGr5xUaPM1+PxaJzGHB+WxnwcvXqwTR9J+Dy4jJAjWEB+L8/l
 8V6OtZHNfkAHdZ+WLol5FB6bF00FenYBM6aDWS+HAUyNPTwaLj0TtlMEsEY10G0YXYKx cg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw00w50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 00:02:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18201p6t155792;
        Thu, 2 Sep 2021 00:02:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3030.oracle.com with ESMTP id 3atdyw5pgk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 00:02:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oz4u6oK6uLBMR8M4WDIjxUGXXb6Resa1WxwBS6Exw8JXdiPcj0OHt3brgzMBmajG0zN+hCk/bl+E2DLHUGimvdaFv0TA6r0OAHRs/xRDUt/Hko2FV0lP4fptKROurtuQ4xRU9y1DecMiiSZvPGk5As22npQ7CgUCGcgybInvFlpoOw+hI9T7w7oLBpyhf+ZNWLM2Iet3Qvsd2+vtjAlD/Vw48cTXgXShz9o8RpNbJ4oXblP3c7nQ6JAE7QYZdr+RbGH3JEQgEWMLqhAtUeWLiKROYk0VTg55zU73szQNvgrerlThcLhkBFoLqC9jfAUzeFH8pe0RNkeZUSR+/RzqDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqnUUbmRDtDRUEQgPqfI+GRnc7Q8MIezD7vOgcm6jjI=;
 b=c2aU5yCh79tGOOqtT4vUqoWeqyF+3CWOkC6j2swC1dturpkyiDdAOCyzzk5vZ18E/nlsiqSnkqM0HqJB5d3Mb5BfmzkK4QeGG97KEzHr7MERNDCK0FqVPHImR6mOKAVDEXef78ABEXyZ4tXpRLLzKBiediiYswRDlhcMw9vZXsiumskSkbQbIHt8i12O/Qil1JwidiHnkKoofXETNn1llix8ABlogywsmfzR3tVd6I6Qd3N9v02qBi5zvSrT9KYRhv3syME1SFjS3zxi1GrQWIjlg9XgYOfoz/Mi3ermhmsj54Jbqd44XGoQ6yE2v8YNiocFlpFG87asXLNSqbveGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqnUUbmRDtDRUEQgPqfI+GRnc7Q8MIezD7vOgcm6jjI=;
 b=R+mky19r/H7M3LLAesLEwo8kWvfiYA5owPNjpLuSlVLEv98yylMPyowZdsXqrLmQPpM/Cq0bBXv2f8Ebe2hVryrTSdkTCItLkdeOIY1G0VVwcoWUqgyc9MiH+8nPfoqJKMKcluIb5XAB/eFt660xSHd4exX1MeJhxBR2+xu2GdE=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=oracle.com;
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by MWHPR10MB1999.namprd10.prod.outlook.com (2603:10b6:300:10a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Thu, 2 Sep
 2021 00:02:12 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e1f7:a0f4:46c5:3df]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e1f7:a0f4:46c5:3df%6]) with mapi id 15.20.4478.019; Thu, 2 Sep 2021
 00:02:12 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     vbabka@suse.cz, geert@linux-m68k.org, akpm@linux-foundation.org,
        ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
        dvyukov@google.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 1/2] lib, stackdepot: check stackdepot handle before accessing slabs.
Date:   Thu,  2 Sep 2021 10:01:53 +1000
Message-Id: <20210902000154.1096484-2-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210902000154.1096484-1-imran.f.khan@oracle.com>
References: <20210902000154.1096484-1-imran.f.khan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY6PR01CA0009.ausprd01.prod.outlook.com
 (2603:10c6:10:e8::14) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
Received: from localhost.localdomain (110.33.47.182) by SY6PR01CA0009.ausprd01.prod.outlook.com (2603:10c6:10:e8::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17 via Frontend Transport; Thu, 2 Sep 2021 00:02:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6f8d4cb-7161-4682-2be9-08d96da4e9f8
X-MS-TrafficTypeDiagnostic: MWHPR10MB1999:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1999E5FB4910A0033E9758D0B0CE9@MWHPR10MB1999.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIDP7UmYmHEVvk72Xjxhfj95UJgiyG4SFx/Hz3tGjxfcflHXNxxoKqX8f54B6qAatZ19tKy1rzFKjHZKe0rRYnLIBuss7EZ4O4Bdu3LdUCXcmqSEsPJi+2iRc/fhcnOaAgS9Mz0hZprc7jXz0gpbPsbWfyHkKqbkqBDY+w2S0+CV33F4tR02NTgAuM4BbY4gIkeoI7u9j42wc9iDmesKW1aAB014xe9X8lIHeBiCzidpXts/ZOl3BAkS2l2RgN/Znb/kzNSmgcxwWzNx0PIgcSl7KaY4GhxEDIVzzKK2+8FKOUxFMf2gIkZ8TkCe01tS/hEsX3/3ti7IxAxdt98qcQs+qmt6LWuroliVg2L4xdzyM4nHAU+UQ9JbI2efGSkuy6yFZwrAKsgZlkuMMnj88VNY3i4/gL8hvNDpTMMp+PfqGBXPM+zpL3KGtFUceWa3D+CPZc6zpGmZqRyWwIWly9VjcNzh3pz96KctbaC7A6ZxzUxoQh0ym5l6VLOek3a/DL2oxm3oJw7XZBaG95hE9oj0X2M0Tz4d2bOjGVQGvoS8F8ZzxDVOTLZ0/H3k2vh95ab1syNBVSA/i6ulel68Wl2IphXNIkzo7VLI7oI20ofpw3BawxghXuEiY0nN+A58qCOPCqKv/ZQDY+hMo/WJ2zIufXLkE+K/iaw0DJe8MfTBUr+t67Zn64//IlLaKAxUCP1dXvHa8H4xFfZ1ues6rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(346002)(39860400002)(136003)(66476007)(66556008)(36756003)(1076003)(5660300002)(8936002)(52116002)(6506007)(8676002)(316002)(2906002)(478600001)(6666004)(6512007)(956004)(103116003)(2616005)(186003)(86362001)(6486002)(38100700002)(38350700002)(66946007)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gjgmWO8k1vK6KLqURL/XlalxTwc1w/FE0DTOpGLE6apyR+rqxDjooo9QA4pa?=
 =?us-ascii?Q?xLvX0LbNHzBoRX2AVWYvmkNgQQTbdYlBy2Ym4LQfLR/bYYM2XatLnImO/BY6?=
 =?us-ascii?Q?7rOA7ZU459+OVqpXdmUIsRVzFVLZn6vV7XOR4hmQ+jSwDdlFfB9KeZrh7Ai0?=
 =?us-ascii?Q?ShhJcYO1kKn2yJw80JvUdF2NMkFOcjtaC2zmDMxyaW5bUP6RITJXSp1+95dp?=
 =?us-ascii?Q?dO/eQw8Q01ZyMiX511iXi4E40t2+J2cGjNATv/JktETm+3+jAzvoCS6AUQb5?=
 =?us-ascii?Q?mgQR53Sjorbt0oyXSGx5H2CUpFRvWlQuhSUqGi0Dxi/QLbiM0iwgtVduobpx?=
 =?us-ascii?Q?JL81lKxI1iqdMCEH7HlZbXqc5O3fpEAsDY0RH0cM2+do0+vsVd+Pr90+GFSd?=
 =?us-ascii?Q?RO0ZKw1tsKQbd1aJLa0/szJYIefxjpiezxe9QtZ89jnZKLWs+nFnDWj3CB9x?=
 =?us-ascii?Q?0CwQrwTGyU8eSiBVJgFCUBnELy8zZA3xNDC0nYr/VbEmElC8HhnVL2zBjXJS?=
 =?us-ascii?Q?EfV4sd6hLm8J6NKwma0Fa9aqy1oRQGlujhzenRwis99yLEWXtftFt5ELL2cj?=
 =?us-ascii?Q?984mADEzyDXYpBKrYR/euZm9SksoViyuDMwbuIfcw9Xxn/wuQpoXMpVtgBTX?=
 =?us-ascii?Q?/cWyzPgG4RFOtEugIGLCXZO/iG8GZ4enT0W2ZjwVYYDRklbn09FPu6cvcBHH?=
 =?us-ascii?Q?MRr83tHUyrCl+iBlmCcvUvazQEBSh+RyloTGSVpkXmzrvM0sZ7rXBeEIF/tw?=
 =?us-ascii?Q?ac5K4h1C3m6Bs5ACAcYZfZ8ssCsWRe+pYNS4S1QHdcq5H7mqIladWS2SX25J?=
 =?us-ascii?Q?KvWO9RQfVu2h8wRzSDmvrMOG09r8jea4LQeCRW9FZXg8fq6yxq93tCv7ut3x?=
 =?us-ascii?Q?wxZvtgRlE1xv42Dyh2mF7GdWyCgnRpxAgYlzkE7vv+S5m9Ts1cnHvorGhalN?=
 =?us-ascii?Q?YDmm+VTpVmYZUtFDoi2EZo3pLcud9ebN5e+5fVsikZezoX+WQ5wGGitApCYA?=
 =?us-ascii?Q?QH818pYJpvQTAG8wucFNQqldDXc1HkQT3mxBCmcD+3I6ahKpNdSoBIKUyLTB?=
 =?us-ascii?Q?wCW9bJXQC03i9PdS5VV0ZoBrEiYi+6wvaS/MKyius4B3QNS3+8db1Fuxsi5v?=
 =?us-ascii?Q?JIBwmsC+hUoEDk4E57+SmkGVLteWrDB0KGMd8wqaFOofsglhpBgtCKXTrKhe?=
 =?us-ascii?Q?ac7ighhpeHrAupWIZPbmXljw60AE31iT8M/RO7Fsl8g9EYYnvgppxWkq8V3U?=
 =?us-ascii?Q?GZIgrL8gLvTdHI8JuhYxxKY0rlU/tUVZvYEDvS4jmhuGXpN3II6AKeMinO1b?=
 =?us-ascii?Q?a0AGhS/IZGDBlib9cAP4RCpJ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6f8d4cb-7161-4682-2be9-08d96da4e9f8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 00:02:12.2153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22FzBX8wqsqSFx0+E4kzObcjg8o951D/g28NDkdq91uo0y4Yt/IqyBbYXGlREnTPaJc5sLtzi0w+YPgHdJfcVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1999
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10094 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=961 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109010142
X-Proofpoint-GUID: KIQAn8PNIMQbP2KwYLHXjWEaPucXewF8
X-Proofpoint-ORIG-GUID: KIQAn8PNIMQbP2KwYLHXjWEaPucXewF8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

stack_depot_save allocates slabs that will be used for storing
objects in future.If this slab allocation fails we may get to
a situation where space allocation for a new stack_record fails,
causing stack_depot_save to return 0 as handle.
If user of this handle ends up invoking stack_depot_fetch with
this handle value, current implementation of stack_depot_fetch
will end up using slab from wrong index.
To avoid this check handle value at the beginning.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
---
 lib/stackdepot.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 0a2e417f83cb..67439c082490 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -232,6 +232,9 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 	struct stack_record *stack;
 
 	*entries = NULL;
+	if (!handle)
+		return 0;
+
 	if (parts.slabindex > depot_index) {
 		WARN(1, "slab index %d out of bounds (%d) for stack id %08x\n",
 			parts.slabindex, depot_index, handle);
-- 
2.30.2

