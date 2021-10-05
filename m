Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5976E421C06
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhJEBfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:35:39 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44650 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232185AbhJEBdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:53 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19511ntj024407;
        Tue, 5 Oct 2021 01:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Gr+ojFRfmVXzs/QgqhRDpSLJfOMoy7Qe9opcejRX0m8=;
 b=tASBxLqFlX6kzw27jNDUzjiA/ZCzyWRKT03koyyQ9CnfdNOT26x4N2deYSQyxFcWURdt
 +cWNWVkuV34vrfbAR0Uy5f1o2KKVfKaiPeSZEZ2mTDRe9xpS38N/rHNwry8GSUWJOrYd
 ETVI/GNZE/wrD23Arfs71Q2+H+q6sh2AclMrkmS5pLcJhAcApjF6aQBSPhsbnTXxX7dS
 OdpGyvaFapukzwBgOOgc8r2/RjQMao+c3aS6ZruQs8u0SIFVy4x1aVEjibFqcOXXfxHM
 T0bnV/kEhYHkNa9Q5jKvLfyDFo5nxVpT5DAqRKgUZLjkaAnwi/opi2SftEjvpwcmBCkw 5Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg454bvny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Tu3o056799;
        Tue, 5 Oct 2021 01:31:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3bev7sgru8-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNCz4e7mcYH0HaAq0FcbM3DwPaQC02z6KiWXX1rh1X6ed/yyMq9FLMlqqj2rU5+HFXMwgxKjFZGllmHM8h6nodr8MZ/KYlSLGbWyzBP3RrCIu91vhJjbAOCEXDwGtNs3943NA2L78GwO+POgDw1A+FCb6q92fBlS4WxpuJbucO0vkiGhbsdmmZLf8MCgaitHjg8WrS4cpV62yPWMKsYag3GCU4nmsV6SjmvOsM1o1QkgZuzCyuVv41l3nLpxS5unWHu3KV/RpfjCY/1uHWEBZIdbio5CY+iugpImTlHBTuhrDih/MswGumYDMv5VdsVL4S8+xZT1KWXT9nHSpWNl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr+ojFRfmVXzs/QgqhRDpSLJfOMoy7Qe9opcejRX0m8=;
 b=NPlFpE43R1qw8a7bMf2ze/etdgwBcUUAixY7oOOhmemdiHtbYgh/k16sLy50wQpyrbQc3FQF/ewPACqttKCfkHj/UzPfavMWQHHw58svaJumKf+3lq+SvQ4mbsXiT/CFjDI0gkcwqCcPBlw7YlAcmB+i8/rYwl4BQt5N8m8UE6xo0MjMLwgvo6yaQhlMamUFYTUVEOLoX37L9QxNTtHB4uZZei1wcW+340z/UWzjaEZCLcqXQuhaQrLFBz0ZsVvbwRwyEjNEhRCYCgheUMzLwAw0+wSV4KOY8Bqug4+bBVLhPz4CKI4KYNUgRmt6JrP2FeMi55q5okdSKzP2AJTz8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr+ojFRfmVXzs/QgqhRDpSLJfOMoy7Qe9opcejRX0m8=;
 b=sVZxx3Vdfgyjcdo5tUFJZEguSOXzF3ToiM9PV15rFGA0PXJPE/Sd0cHtnKpVGhpOsQzK35p6hsve7fxzqsi79yUfn5fP99c1cRLkYrLznhW2Gtnkbmq29/XZvNZ0wuZiFXq7U+9XBdiQ/okkL7WIrWw6RQLfuCGuTKZJgqY7CVk=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:21 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 36/66] fs/exec: Use vma_next() instead of linked list
Thread-Topic: [PATCH v3 36/66] fs/exec: Use vma_next() instead of linked list
Thread-Index: AQHXuYiiPef0VPyN3kK750By0gYGFA==
Date:   Tue, 5 Oct 2021 01:30:52 +0000
Message-ID: <20211005012959.1110504-37-Liam.Howlett@oracle.com>
References: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4349f010-7b43-486a-a860-08d9879fd667
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044AB11D0B6BCB9985E366AFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RyJ6xUyIpk54G0UqwzWM6ofUu4tcf9nTq9ODoXVUHvMFh+eKa9yKKcq7ecKq0cYerdvJAKj6iAJ/V/5+PHGXjhTcNMXfoKsI4wzn+wSaswDRPMGO5pbHtTY3VzXC6yiuUzL5zVe3tAH/NIY5XuTVDjMnxhd282NCiYAfhAcrGOqkuzmUTkiW33Bw+0SO3bi39g2eGS9L74czP4Sp1yHvVp5SYRHzR4Dz4J/ncuu4O9SUZ0CNS1C9PJGyFLsoxYh7cIX0Fckcb/338/KwdP/9XEe8kZOFm5UJnLxXvayq6Qd5Egv5ujbNRhAsKRRzO/4seVvXunep+L8w0VGXKUuUX4tsVTPKM93/dTWra5BzVFwEmp/LkvEYAbW5DmaOcMJEh9WUvr6kE3TVkLNP0Y8oZ3005hmWPIlXilk9jcT62yrinHySj5oAO4MrY0wX8VY4VBjn46sZDdh/AiDzeODQ9hiqrU7kuj9XvcujxGiDnPyCSRtXyZh/I6dNweC66MHYngPL93KLscOOqAxPzaj5HrGOMzDddgVFq0IZJG7dGpqUQI862Bb1lT5/l1NRZs7ezSlQFCz/d54z+n9SY6EHxhORHhqAkce61b5QLHvw3FjDMbqMMIzr0Xhb1rMPgmmoeXadCT3fj7lbkqPZXX96R7EJSQsC8cfawLbGx1ULmwBJu+LMx/gIjL4eAtUIbBIg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9MHMV8mvKEQrtGkHZ2K1U4b07R4tahiVjrm4c/2NZ/wYo4eyEfdN1cxm2J?=
 =?iso-8859-1?Q?lfdbkbi3rSFNQrVCuwqaIsnz3HMUwn1k3WHs0puLY2N6kBY0/D3NEFCMzZ?=
 =?iso-8859-1?Q?f0S0jKJI91Od8MojSEvp+AIHm7+8HlxWtfQY4LAcw1/TPgC/OeyC8RVwMa?=
 =?iso-8859-1?Q?r/ApV3lePV5ql4/VsOvvvMijTcqAdpdB3KSO28+lDQ5HVs1L3tTehJG4JK?=
 =?iso-8859-1?Q?+mGpVKBJD7WUtvp0+wSFzR5WiNlAeCDJO6JOExT/QVCsGb0gNLaKgrzaPa?=
 =?iso-8859-1?Q?wKfPj2BV8D9y5g1psMOam5e0g/Eudq0GL1rDi0iUnAXPguh0pix6Px56bZ?=
 =?iso-8859-1?Q?IWyVsRqhvBxsw3iX5CAoiRwiOVfQnCQGQZiavqxDQm1LNl1mt2TXzp4xGU?=
 =?iso-8859-1?Q?2y1U4y/ySdy/rBfalLyNos9V5B5u2D2KDG8tXCEFRWZ42crzkAYogEacda?=
 =?iso-8859-1?Q?piqesEDBSGsR9iM9+I0z308e+64N+mkqhR9CdjKvQtk5jrsyQMvXkDb8rs?=
 =?iso-8859-1?Q?lfD4LPn9GV+Ym1TzzANnHWoI2n9tGF9/W1iSDTI3x3eOp2mii1rvJenlOZ?=
 =?iso-8859-1?Q?k1U/54/j2EwpX4tg4c3rICM4Fcts74tE9J5qmhjKxeXB6y272rYtvA1JOM?=
 =?iso-8859-1?Q?uJNsgcwkPyNmA0fDx0vA0qhP3l50OVItSSIAoR03+ShXlVi5SHaxSa9vlA?=
 =?iso-8859-1?Q?JYA0Cz104kNP/uC8ZnfjGcb2DP0tSATtpv2LBKnBlOQMTJvrGbguDQdEOK?=
 =?iso-8859-1?Q?NB7wfC+S1yNhs3G+mBl0mnOiBiJWsWgcpEU4rTDqIzJWTi3GDPzV6aBcer?=
 =?iso-8859-1?Q?5yDF31Rh2MkD2uvxTlvOM8RbG3OP4jbGR8wyHORvCeZYdfmPrvj1bzOwcb?=
 =?iso-8859-1?Q?nKewBMe+uy5aGeL0KMHJcNkVS+Vp4WUfDICUV2nMAKNzMw2X1iDP/BYfhA?=
 =?iso-8859-1?Q?osT7ExmIUxyYxC6nOq8G19hfeWukyQc3scgy+rZECUjm12+hbPjkMaSxWi?=
 =?iso-8859-1?Q?fmcAo43ORKf/ErOG0MYd60V0XrnIEWv/BT6OvOTUPfNbsyT9KIPI7YMRPZ?=
 =?iso-8859-1?Q?JmFlc51PBblvMLJofNXM2HiXuSN3UDTODtf3Wbh35FJcrFWpXjcCK8PoGd?=
 =?iso-8859-1?Q?K0DoR4hAFxYCmTroqNd18dTtF4+7LmXg9GJvJ6BAkdI+m7YxeI4SfG2Ho3?=
 =?iso-8859-1?Q?6L5P2B3vLh5ZQcxtueIE+zu9kNarxC9lNVPeVmW8MUrdqafUZU55gKE7Go?=
 =?iso-8859-1?Q?xKji4o4sh+mCV0MTFPgblcoQtV4iczyXm3kSAvQOwZarI8lMwg1RTE879i?=
 =?iso-8859-1?Q?RfvwB3hOXHOp0S7X7jP29KS0BlANbI4NqjKTM3Zp5NQZuu30loAOeR2Y3a?=
 =?iso-8859-1?Q?IGPaq4hDQS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4349f010-7b43-486a-a860-08d9879fd667
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:52.3549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YlGzOwdV1yKmcwualRUE+97fUgKTIZmxiCEQ01q1cuknj4ZT1leSNsW0bHjItdFtjC/JKYjkSSJuRDXEbYredA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: GREMcJyZWI3rofwOYshzy3SMx3r-o4mL
X-Proofpoint-ORIG-GUID: GREMcJyZWI3rofwOYshzy3SMx3r-o4mL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/exec.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index c618a55a20d3..75d68ff856a1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -680,6 +680,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	unsigned long length =3D old_end - old_start;
 	unsigned long new_start =3D old_start - shift;
 	unsigned long new_end =3D old_end - shift;
+	struct vm_area_struct *next;
 	struct mmu_gather tlb;
=20
 	BUG_ON(new_start > new_end);
@@ -707,12 +708,13 @@ static int shift_arg_pages(struct vm_area_struct *vma=
, unsigned long shift)
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
+	next =3D vma_next(mm, vma);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
 		 */
 		free_pgd_range(&tlb, new_end, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	} else {
 		/*
 		 * otherwise, clean from old_start; this is done to not touch
@@ -721,7 +723,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 		 * for the others its just a little faster.
 		 */
 		free_pgd_range(&tlb, old_start, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	}
 	tlb_finish_mmu(&tlb);
=20
--=20
2.30.2
