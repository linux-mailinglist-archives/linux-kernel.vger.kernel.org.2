Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FFB36DBFC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240687AbhD1Piz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:38:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2538 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240087AbhD1PhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:01 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFOcnS011645;
        Wed, 28 Apr 2021 15:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MjHVx0Te9dhwwEM8TUF3R9AZjpvIoWoCjeACKHwPCNU=;
 b=K8Jo/pmt2OMN13sAxsTew3TqM6HRWay+apdQqQ9R5GLoIoKAA9SPGTqsLWMh430AG6QQ
 RCMAzJCrBvjH7RaKuxY4plVqiJkw+873oNUEiLAJcFH2F2ARAXs/llLHsRf0kQJMmZqM
 JwHzIbSXVGvGU93+K0vjCb5xuRxvwjcEEHM2cDvqiElbUpjYTuTNyxumbRR1/x8TUHJV
 zgPo9hqdfsHllp55J4ftlG/rXTFvCZSCO+VWRKkDPnPsQoM05U+aYE65b4G0iLm9W5r7
 QtYQz7I5SQHk2ibOrho8EPTgTevpcuN5h5jo0b2oJqlaGQi2G47Juw8oTzj7+9MjrTT9 nA== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105xn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:57 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFRrsR124479;
        Wed, 28 Apr 2021 15:35:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3030.oracle.com with ESMTP id 3848eyqwaq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6z6N9QAXRgsnyZKFw/ZfgQy+WKGZ0QMd3//cAPr5VK07bxRmUGzaCFJzF5vly04cEEodcWKLeh8Gj0aOT+MevtM7RAlkfMFyHPQEWqhDwDbIxeyiH+RZGgGlknHGYqn35FNj3C2KfEGJh50AXVYZfCNNaliG9uh3c+YBaZnixW0h9hZgWoQ079Y7/bpjMG5Ku108QRf5drhR70v59BNhSjhdEu84t1bKPmOMuWFMTpItzDOYUJL6RkGFVq0FG4vO2pV9L1sQssspXebmkUpWbWOcFzPIotHdHCeNo3RQOHjfSgPWXh44nzOwKAlxv+JyUkyrmkWAdtU51D73XOKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjHVx0Te9dhwwEM8TUF3R9AZjpvIoWoCjeACKHwPCNU=;
 b=Zv7RhTqfty3YxvQb78jyoRMv1FrPqdEPfOTcGyYTZ3zZEwVMRqIaLzLTyvNzP8e9E6VSLFP0oXHI7LUBgHPkU/F1t3M4HUZdVH6VJsg2erEVrPNTrPEntf99xqkZ25i90Ngt0z7Nvw1Fuj6vIDvNUA66oPQfSbtzBYE/CZC0lSPAQIdd4w0wZhRdEtDYdBxKBOELiPz9P3sFOCWFRMtwW4XZqtPH40KdKcCsstnTHHmYaoo6TkJourvRrSbDtrvdwCzdaehJHV5gUiI9L0A6bZ65I1AGd/R6L6DaOv8Ki7ri/OxYRySzfmaGTCOJm6tZYGcGSf+ITd21LRk7EwFpvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjHVx0Te9dhwwEM8TUF3R9AZjpvIoWoCjeACKHwPCNU=;
 b=R5lRuVh03qUWz043evo3lTsGxxxxvCfU3vue07dWa2Ot7ua6DV0DrHWOFcB0DhAkuRrlJUIT8h7EEvPLAB+zfF1ayoPKkzb/+pA2P0hNwT5EEkVxrL26D0JFmk1o0/339byiYy1ssKYLhTlkb3APkuMbGH7YpgsjR1PdqWkYNV8=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:35:54 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 20/94] mm/memory.c: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Topic: [PATCH 20/94] mm/memory.c: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Index: AQHXPEQsMAQp/LsT0kuGmt1THmmovw==
Date:   Wed, 28 Apr 2021 15:35:53 +0000
Message-ID: <20210428153542.2814175-21-Liam.Howlett@Oracle.com>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6366e286-3590-4f87-7d53-08d90a5b4f7e
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769C22AA57728FB5F94559DFD409@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wIx0HHuM0NGSQfac5Y2s2RsQVztT+dBdLsnoZ6GOI1Zw+uWBI6U20xHvCa6lGGq/QOU9JSI5POGos2N96Ryc46w0xQHHiE2Aek2U4y6Nh+SP2TFc1EBIB2eeuhSOdNlA9Cjj752+1X7Z08SYw1tRkait2tUaPB2y6UKZS7CskvBrp7+sjEY8laZDHbgkQgLhMcmSQSZJr5tLPnpTbedEJ3gyD6Jz/WowmtkXtPQjn46h8bbNb120eGbAODeVC1plJG9yyNOdnaHpQmd2nrfuyzMyhVOJW0tgI8Ly50Kz5BnUra/LQdtTVncpfgrJ+qLOlLcO2iuccnGmUl07ytyrFsSjc+//ZHoeMQ9AyMtBUhGhuAst7KI95bwjM/3mVXVlx/EZczu+WhmmdaM/YqYQD2OjgIjaWVZALgQ5dEVGXsBaBeeOoAT0I7LTDZRPysVOskKTk4dT9LU1Je98A4Parr51j65a7W9pho3aQSKV87Mh/NqqIYTJG05LLINXzfMEpEvI8J9J283nVNSC9sXtpXIESf3sCG8lz8jpuTCqNRtjUhSaahPmHsBYlMcu7A10OCI2J2NZX7gNMjfHyc/+3/tuGrCliKQ4cSnc8y/debU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(6506007)(86362001)(4744005)(2906002)(110136005)(83380400001)(66946007)(38100700002)(66446008)(66476007)(54906003)(8936002)(2616005)(8676002)(66556008)(76116006)(478600001)(36756003)(4326008)(44832011)(316002)(1076003)(107886003)(186003)(6512007)(7416002)(64756008)(91956017)(26005)(5660300002)(71200400001)(6486002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?JICUPjKzC07fhOL0OlX4Xqo6WVOOEwGyeAdEIaaPWXu9V9gYCT4FGT9w57?=
 =?iso-8859-1?Q?URRbMzsyPlh3NnwFVJVzwgo3ub4VOsXr7WurmO++QOnoozXCI5slD2oZfA?=
 =?iso-8859-1?Q?sxAwlDmREo34VwgVGdQcjUNYx2k9aUaIY6a/MG6AvNSW9xcIDcL1y7bEns?=
 =?iso-8859-1?Q?G1o5fB8j3XQa4hbTEEB760r3klxxjjiNOWZk+0h5r0M3wAZw2xofgvOxnD?=
 =?iso-8859-1?Q?IQmv+mxsgVtmw0sg/VuGzG/pGakLSXHc9lJPdw0teIC0T4Xijo+mr1bzFg?=
 =?iso-8859-1?Q?NHsdvoZbr9dx1nKLgxaOvUrTTDzyY1Ktmw4TC2ExJT3fFeG/RlpBRlo9gr?=
 =?iso-8859-1?Q?6Ty50z9x4JFFdJgUk9Ck9UTrPC0FQLLj4MCdXIErCjTdtQZrrUPfrRwSD1?=
 =?iso-8859-1?Q?9cqDFRf2zj4q/9HzRz4q6gnt2ZPS16RxvFrMl1SsRvJa0ncvfo2aqlQZ/k?=
 =?iso-8859-1?Q?oX1nhpgkIK7Vk4G306qQh46Q79N9Dds+1o6AO19jgBQYFbxZ8ARXV4bdy9?=
 =?iso-8859-1?Q?XiB/uebEu8FC8Fv0IlL+aHLnpZniui+sC86EB/J0sQX/ICqRA88OL1YGTK?=
 =?iso-8859-1?Q?slvoK/dQkvycc97Yaqgz81PimeemToOZ2re/f/E+Z9u/xmAq9tiwwdatHo?=
 =?iso-8859-1?Q?K3UqNQ2LnIWryn8vtpjTkrEq9TYqA0o28RhBEBw50aepQjM9HUNXCEKRxK?=
 =?iso-8859-1?Q?ZpRHYWRZ9wdhogv9uZ4F5/v0URnVwwZ5oLc+rnwpsORp/nx53jdvTPHelw?=
 =?iso-8859-1?Q?IqjyOfVIzIGy2DrJ5dYsoN7fz74UwHHNjq/ud5e72X2akuC2j7eiUkhwlM?=
 =?iso-8859-1?Q?41ibMg42CLjcs0fHQRigYgQK8+Y1GAX0ET6WckYqzuAlnsK8lYtneFU6Ha?=
 =?iso-8859-1?Q?m/3t/h5VO+ELXwE1VDY4nznGXKA27CR0o/dBFJ6odPblaSXfKZ2YkB00Qf?=
 =?iso-8859-1?Q?rCD0Ml/HThA4AbZZkm+svCk1LtwNxLOGFMNrV3yCqaGs7Wvj+tgBnyOfXX?=
 =?iso-8859-1?Q?LU79G6zBy3NM6A//GC9JSbCu5EL2IdSF7W54Qf0yjcgkCkEQyXZyWRWEc5?=
 =?iso-8859-1?Q?vR6NdzDHoiIQXuRzBa+QFGch9T3DawRd+bskfUeqV+ApmzLtEdyKrT3CTM?=
 =?iso-8859-1?Q?f9CmVVWJdPnRrLbL/gyDvV1GI8/lgUHR2sJi6Qc27tKs0F0arfqyD7Odvq?=
 =?iso-8859-1?Q?wnGB7haHzWj40W3oiRQz4UlwUN/rn5C1DRrC8PCpLVPcWWgbOZ19jojtkO?=
 =?iso-8859-1?Q?j5cnIiw+tTgduBESUaSZRFJ79emZijxpapRtAg2+jUQ1W2XjfJWn1PtUa8?=
 =?iso-8859-1?Q?+cGAXz8FiPmDGkQiRieg63x/0RpjMLFoftSEYskTwDZgEsjiTgt06yRElG?=
 =?iso-8859-1?Q?AiIITBe3puu2+zoSxkg4r8df4dqvzmCA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6366e286-3590-4f87-7d53-08d90a5b4f7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:54.0067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LKD7t9S49IvmxrM1kd4LDkNw8WUUJhvqE+9QCRKnzjD3JWrz8sDkrJJD+lmpVeqfj2mwzhTleJsi+cejHnXwZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: HgFpVs6tK5vFdegyrUueuFQp1GCK1rwL
X-Proofpoint-ORIG-GUID: HgFpVs6tK5vFdegyrUueuFQp1GCK1rwL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new vma_lookup() call for abstraction & code readability.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 27014c3bde9f..91e2a4c8dfd3 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4944,8 +4944,8 @@ int __access_remote_vm(struct mm_struct *mm, unsigned=
 long addr, void *buf,
 			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
 			 * we can access using slightly different code.
 			 */
-			vma =3D find_vma(mm, addr);
-			if (!vma || vma->vm_start > addr)
+			vma =3D vma_lookup(mm, addr);
+			if (!vma)
 				break;
 			if (vma->vm_ops && vma->vm_ops->access)
 				ret =3D vma->vm_ops->access(vma, addr, buf,
--=20
2.30.2
