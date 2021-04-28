Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFDF36DC2B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:42:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241216AbhD1PnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:43:25 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35984 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240440AbhD1Phu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:50 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFTUtq018934;
        Wed, 28 Apr 2021 15:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=SLQbfsh7p4k3x/7576TIMIZJdEEFhIDda5OpSOSGfjw=;
 b=Rp/ED/l8xcBVfLiL+N6AxSSrDDVJWSC1bKACoXiKFXbBHXney/eyZWUbzJg0/+tcgx/h
 LqXEOR4eihQpgb5AAGeuzNJYWstDslnDemyYYVqsQiyrEF4RxYWFEeMbgSyTdqcpdmbN
 xBwqX0Th/153VZ1xddfM+AuXqZLn+oLM6EzxoSnOXOKsYaMoII1A5GpOd3NRnsmZrI+/
 NtvzOrX0kkomJmNyAHtqcoxkzK8o7kXrzG8truXbnQOFCfPvbaFDMWzmDTFksoUamXkc
 hkE0GX+c61pfsvdNR4HOnN1l7AI6KX7Sux71QIXAD8xcerxcHPUiYyj2ArIYoTEYKXAI iQ== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84sv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:40 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFY4iY022800;
        Wed, 28 Apr 2021 15:36:39 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3020.oracle.com with ESMTP id 384w3uuaea-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWplZGHwBDaPghZP+2GXhIb81UNtCpUBAPi94ILjBLOrVyB50fxLSgs/yXPJOqp14SuJ0fxDW7Wevm/j6NFtdDX027hNkrUlXEV2smdt70LdnOI8wQ9nei0k4p6A6Ux5WRsN0S/Ot1dQs0NsfP/llQLmc9ZL2rYxt1ltWpb4eEX4AACkB4TGypDUUISpoC/G/PdPLLVMskW5vWKN7OuabXMEzXCM33GcWCbBihSZVfrrltf5SB6DibsMPp9BNaWsQMuz0QHp3LbWtSncKwMrCQpbu8pRl/Slc6m0Wmcc3dgPkT2+AMYaXiDZIENFjos+cE+ZSYVI7sMuh4Pq1M9BEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLQbfsh7p4k3x/7576TIMIZJdEEFhIDda5OpSOSGfjw=;
 b=LFq4J8H6gFyvN9ysM8dZGdH1RASqj+nqSRLBlhcP2yp9/IMFh8kVnP1Zsijj1Wq/5iANnpWh/a+NpVP0N1QxUlR/jVDqU8zWGxbQyCoDlvafCWMHAR86SYjm9/Baj1I2+aF2nbXKuKfQoUXhWLFkggZ++WJlMeEGcB9cse8izTBAV+rGWm7Wb2zPTf7hDt7bHJiACtP8H+5hoIltYpT2C9wjUbAcOdXAaUUnX+9Bo0/BJ32wHg2pzPMz+Jyo+UVLbj+8lwu2Fz9eTg7A+JjXrwTN10FdecZCjDm2SkXDjSDrk3w1SyDRvCTwngqBw8DuXawfvgp9JJwl9aG7+sOmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLQbfsh7p4k3x/7576TIMIZJdEEFhIDda5OpSOSGfjw=;
 b=PhZJ/D8vY6bZyvtYdwY/lHDszQdRheuLKHVADlwxcTtESZnIbjDkZJ5i8YnDSHpiawyARbzH5OCbAX8gKSPWWGrVnq/YxzmLfofSisZGNHDdjEbranUeeT5EIItb4ztxGAkwucZp7bMoUlWcdnnsDc5JCNRn3B9gsBcsLfJbypo=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1982.namprd10.prod.outlook.com (2603:10b6:300:10a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:36:35 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:35 +0000
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
Subject: [PATCH 31/94] mm/mmap: Change unmapped_area and unmapped_area_topdown
 to use maple tree
Thread-Topic: [PATCH 31/94] mm/mmap: Change unmapped_area and
 unmapped_area_topdown to use maple tree
Thread-Index: AQHXPEQzbz+bn/uVg0qIrJjj7IL8gQ==
Date:   Wed, 28 Apr 2021 15:36:05 +0000
Message-ID: <20210428153542.2814175-32-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 671bedb9-2b6f-4047-5ac9-08d90a5b6857
x-ms-traffictypediagnostic: MWHPR10MB1982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB198273FF58DADC4BF4CD11F5FD409@MWHPR10MB1982.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dpfR5InMTD/va6F2fsYliukXuwlQ/I9n8HRaBvN1+7FFHlzM+urs6IlfJSV3Pv9eJsuJ2MJbiYD5zrZV0hiQMDWSSnGe5x4fFSl4XvwR7ZCJPc0DwHzFET0p7EfRmIwbGMCeUENfBZlURUfupsSm1edNsAXmK+yNNChH/WDfaomA858CcsLBsFEJ7a63cbXb4BrO0Wx9XlQut0cM2NRg+r+f+riivKfPZKC7nX44AmuZNc6HRO6wFNiZ578nR28BRecyBQOLNqnLB3RfHo8STquebyo+NBBHlKrfY2v1UGaupYJdZKDGRATPblvtpDPcImbARBtViNq7wk9loEA5twsi2AUc1CLVxZhuoDA2Squ3CZX8Uz5C8n2ECUCu1Of4G5EkVvkFGHBxEE9F8UCSNKZ7naE+Rs/NixMW78a6iwQqg6bVAf8cyPNWsD69xyRtuIu7STIr83VVqWQ7ip2db0T50hRC8Es5PW84ygPZ2cWKOubwBHyPsF8rl5ZYIt28OuwkDFZFigdzPLqnSZnpnmQC2xlyMjWPhjjpf/M/7bD8YosFct1B4audsjVj4Cc/PQDDxxWEBxtisEHoxZgRd2LWzCDrkvnGLYgYF6VNl8c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(346002)(39860400002)(2906002)(8936002)(6512007)(1076003)(66556008)(76116006)(83380400001)(66946007)(6666004)(2616005)(7416002)(186003)(26005)(4326008)(110136005)(107886003)(66446008)(54906003)(6486002)(71200400001)(316002)(5660300002)(38100700002)(91956017)(478600001)(64756008)(6506007)(86362001)(44832011)(8676002)(66476007)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?SoRozVZvJbJvUbI+ifrZlQKtTt1Lz8W44MYBMMZNpypP/f13cMoGvghTU4?=
 =?iso-8859-1?Q?QCSUM7EPWy1efnBvuFo+k6NtLA40z21FqbWk2VV67SJXblGd1g4kNwzvKB?=
 =?iso-8859-1?Q?J3JY66g+YBPd4Yay/zkd6PVmvRoh8+T61VHWih6jwCuux+hNhyrG9r/3tP?=
 =?iso-8859-1?Q?fL/pDOGQxYFbvzVELO23EB/ZuQslO3VYm3Mdmr42jvUHKdSWnwW5xO7IC3?=
 =?iso-8859-1?Q?nV++sZHSb+1GJAmXoki6dVCkGePNhq302AuCvvZQozpL8yDdMwxbZSqn7t?=
 =?iso-8859-1?Q?Q2EAAG7i04qUqe4/dd9brph/GD/dVREiPTk8et3Yjii9cCj10B2yTtqPhn?=
 =?iso-8859-1?Q?Wp9ggPGPjkLLIloUWQcZFO32oADL+V4sJFbWApka9vfqnnZoBdVS9LYKIM?=
 =?iso-8859-1?Q?9c8HyOrUEQILkwkgYhtpfGR6p8mrd9RTyOfcYch0fgOcZDL5zXnFVteSOb?=
 =?iso-8859-1?Q?JbFkRu71Hz7VUbQSQkN+zbY0fv3+HF+zhZgvLPl3G4E7/I32FKhxTW8wC8?=
 =?iso-8859-1?Q?S6k/veKbW/DyfodxbjiBjvICZZH+vLXnnjG+hcWD1ZbGf3DQn7VUZLX8Vq?=
 =?iso-8859-1?Q?cUbHdhV/JPQUtG47mKlhR6m49ouaFKAYA2PhTTPSKNQlmirSitp5zEMCAZ?=
 =?iso-8859-1?Q?UWwuvBX8JDOzlLngm1PT6hLSNkhfzQzYoJhs/ebYhTAKADHNWSmJoqwUsb?=
 =?iso-8859-1?Q?1yZ6S7dFciJUlKLf5Of/uya1pvFu48zOBEjIiD06HmcOtAvhwt2z6krSJb?=
 =?iso-8859-1?Q?N3i1wNKCcBup1WWnNj0TWWqXPSecoEU65fBH7wh021d0AOYELx4SAvnjai?=
 =?iso-8859-1?Q?0pGnqdv1ccAOwZCEDBbsg/1DaVvmNjfokOCf8Ol7DY7BJ/7W1AVvh7Mmd/?=
 =?iso-8859-1?Q?zg5sScTt9onmBBhdks0ZxbZYE7vOa71ZL5Zo2Vqzt4nsZ/8f1PmDkJlOhJ?=
 =?iso-8859-1?Q?gBPthiUjQ+P+nBa4dq9dTYAcZ7tSeRe83p2v9d9Or3dy8g4pe8o4obEdfC?=
 =?iso-8859-1?Q?n+lFrN3JydtN/GwVwKNWAT47Ro9qbmw3lCv3M0LBCGUI2olQgtEBjQ9D+B?=
 =?iso-8859-1?Q?jx66MHj/FpHsjOC33eI+2CphzVDY/cey9oPiSEoFNbyNmjHvW3J7K2q8O2?=
 =?iso-8859-1?Q?3/f0GAc1pw6JaK6gprSIxaxy0WyMOJ4Y8qUW6J/PMDqh8iITXmAoMpFhFQ?=
 =?iso-8859-1?Q?tnqQkUkC3Fjg6edResUGfIviIjcBnqW61cbWPMZAgCWlklKe+pQbdPHy1R?=
 =?iso-8859-1?Q?6xKgry/8hxNLq63/f+KKFNoklsYOpepoeiaNkbJSzrAOMKr5B29j5byeH2?=
 =?iso-8859-1?Q?e4gikVxGJ8MVFTCUQaLTGiAfjdOHMw9+nzXReFr+6DhRLsOalcRQZ6O76Z?=
 =?iso-8859-1?Q?w17HBGlfNb?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671bedb9-2b6f-4047-5ac9-08d90a5b6857
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:05.0489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YRI6cS7GE7kP31h7nGtIHJFgoYthr2gcj9uDudF6sREyCVjYkkkIPiODS24nhv4THHO7MFB6Zri+cwFSV7yQzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1982
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: 8ZUynKabGEMHRUdG4q641MmYs4YyVuGV
X-Proofpoint-GUID: 8ZUynKabGEMHRUdG4q641MmYs4YyVuGV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new maple tree data structure to find an unmapped area.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 263 +++++++-----------------------------------------------
 1 file changed, 32 insertions(+), 231 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0fc81b02935f..929c2f9eb3f5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2049,260 +2049,61 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	return error;
 }
=20
+/* unmapped_area() Find an area between the low_limit and the high_limit w=
ith
+ * the correct alignment and offset, all from @info. Note: current->mm is =
used
+ * for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	/*
-	 * We implement the search by looking for an rbtree node that
-	 * immediately follows a suitable gap. That is,
-	 * - gap_start =3D vma->vm_prev->vm_end <=3D info->high_limit - length;
-	 * - gap_end   =3D vma->vm_start        >=3D info->low_limit  + length;
-	 * - gap_end - gap_start >=3D length
-	 */
+	unsigned long length, gap;
=20
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	rcu_read_lock();
-	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
-			   length);
-	rcu_read_unlock();
-	gap =3D mas.index;
-	gap +=3D (info->align_offset - gap) & info->align_mask;
-
-	/* Adjust search limits by the desired length */
-	if (info->high_limit < length)
-		return -ENOMEM;
-	high_limit =3D info->high_limit - length;
-
-	if (info->low_limit > high_limit)
+	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+				  length)) {
 		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		goto check_highest;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		goto check_highest;
-
-	while (true) {
-		/* Visit left subtree if it looks promising */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end >=3D low_limit && vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-check_current:
-		/* Check if current node has a suitable gap */
-		if (gap_start > high_limit)
-			return -ENOMEM;
-		if (gap_end >=3D low_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit right subtree if it looks promising */
-		if (vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				goto check_highest;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_left) {
-				gap_start =3D vm_end_gap(vma->vm_prev);
-				gap_end =3D vm_start_gap(vma);
-				goto check_current;
-			}
-		}
 	}
-
-check_highest:
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	gap_end =3D ULONG_MAX;  /* Only for VM_BUG_ON below */
-	if (gap_start > high_limit)
-		return -ENOMEM;
-
-found:
-	/* We found a suitable gap. Clip it with the original low_limit. */
-	if (gap_start < info->low_limit)
-		gap_start =3D info->low_limit;
-
-	/* Adjust gap address to the desired alignment */
-	gap_start +=3D (info->align_offset - gap_start) & info->align_mask;
-
-	VM_BUG_ON(gap_start + info->length > info->high_limit);
-	VM_BUG_ON(gap_start + info->length > gap_end);
-
-	VM_BUG_ON(gap !=3D gap_start);
-	return gap_start;
-}
-
-static inline unsigned long top_area_aligned(struct vm_unmapped_area_info =
*info,
-					     unsigned long end)
-{
-	return (end - info->length - info->align_offset) & (~info->align_mask);
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+	return gap;
 }
=20
+/* unmapped_area_topdown() Find an area between the low_limit and the
+ * high_limit with * the correct alignment and offset at the highest avail=
able
+ * address, all from * @info. Note: current->mm is used for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
-	validate_mm_mt(mm);
+	unsigned long length, gap;
=20
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	rcu_read_lock();
-	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
-		   length);
-	rcu_read_unlock();
-	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
-	gap -=3D info->align_offset & info->align_mask;
-
-	/*
-	 * Adjust search limits by the desired length.
-	 * See implementation comment at top of unmapped_area().
-	 */
-	gap_end =3D info->high_limit;
-	if (gap_end < length)
+	if (mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+				length)) {
 		return -ENOMEM;
-	high_limit =3D gap_end - length;
-
-	if (info->low_limit > high_limit)
-		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	if (gap_start <=3D high_limit)
-		goto found_highest;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		return -ENOMEM;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		return -ENOMEM;
-
-	while (true) {
-		/* Visit right subtree if it looks promising */
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-		if (gap_start <=3D high_limit && vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-check_current:
-		/* Check if current node has a suitable gap */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end < low_limit)
-			return -ENOMEM;
-		if (gap_start <=3D high_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit left subtree if it looks promising */
-		if (vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				return -ENOMEM;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_right) {
-				gap_start =3D vma->vm_prev ?
-					vm_end_gap(vma->vm_prev) : 0;
-				goto check_current;
-			}
-		}
 	}
-
-found:
-	/* We found a suitable gap. Clip it with the original high_limit. */
-	if (gap_end > info->high_limit)
-		gap_end =3D info->high_limit;
-
-found_highest:
-	/* Compute highest gap address at the desired alignment */
-	gap_end -=3D info->length;
-	gap_end -=3D (gap_end - info->align_offset) & info->align_mask;
-
-	VM_BUG_ON(gap_end < info->low_limit);
-	VM_BUG_ON(gap_end < gap_start);
-
-	if (gap !=3D gap_end) {
-		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
-		       mm, gap, gap_end);
-		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
-		       info->low_limit, length);
-		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
-		       mas.last);
-		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
-		       info->align_mask, info->align_offset);
-		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
-		       find_vma(mm, mas.index), vma);
-#if defined(CONFIG_DEBUG_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		{
-			struct vm_area_struct *dv =3D mm->mmap;
-
-			while (dv) {
-				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
-				dv =3D dv->vm_next;
-			}
-		}
-		VM_BUG_ON(gap !=3D gap_end);
-	}
-
-	return gap_end;
+	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
+	gap -=3D info->align_offset & info->align_mask;
+	return gap;
 }
=20
 /*
--=20
2.30.2
