Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADF1E3EEFD1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbhHQP5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:57:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49390 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238121AbhHQPtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:15 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkF7Q022508;
        Tue, 17 Aug 2021 15:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rMtu/9jE3QwZblfigAEta+yEhWF2g36uNS9p4vtO7aU=;
 b=kTKJmvJpeSG1pwLToNhmOouF2nRkrDoyROJAQYsZ5L4MoCYLbNKS44QlTRzP/xUj3Qow
 1jGDtTDVoBWRJIv04pU/YVV5+nnU59erEjbkJPPQ+cr6MwpXVYuQuHOyhXJhHLxmyIEm
 AhZ1D/DlhXa4KLHd38nh9T/SsA0bQgR6vXwSXccXBNFVk2a5/iKQzK7s9RW+8/Y2qjgu
 t7st0pyiqvjJSBTaBeVpOzXoxn40xbWv4TlpdaBSVAYuxgU0VdxHwQFie9QZk0BfwUkO
 dT7PzogjHyMUAZOZTAbeuKGK4rrBUq7yqKuTosfLpKBJVXBlXZx5n9SjnfeXEgBD62me 7Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rMtu/9jE3QwZblfigAEta+yEhWF2g36uNS9p4vtO7aU=;
 b=IyuhHcK3zIBWIEdYQkhWmJy79qYBIhgEHhmeWN1mT9gXvDBUTU6iXUgM30j16sO/aRUh
 XWL0KWSTUqSGO/9YnUQSG7evAe+qHZeRW90GhFAKPhHPhCmYBMtrY7wtqBoyI6V+D8tr
 BZMcPmLBFuu4ZccYq8HpEjjFdYr+CPN372pQ61TLhygi3qmXm3PI7CrA58zrXpZmps9+
 s3az96MrszwZazjlAmRzokM0pWh6G4g8YrpVncEBOwN7MeCUQujGQf+2iTuuBjx9TUzi
 WPj7D+RAZLmhrinhsCwLVF9TOtssMvwIQ0ZdPG82SNjtELEj/ZblmsA3PtVLY3eCp1AJ /A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpgm90g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmfg158706;
        Tue, 17 Aug 2021 15:48:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3ae5n7sv2h-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=neIjr7S6G4IJgJGSGG215cp46mqJcXOC1OMbEQukRFFtWyUyxrn09Hh0Bvic1/UZB9YDF/QmtoWROXKyOg+HhPhRpAV4IBh9ZjSC4BhzPmHpScQmPIwyms4bWSN6ZE+ATycBVzCDU5uj7UJmJq2u47/spmSk4fSvruc8UIYCPvUv2OEGKpw1F6hC8vdc7K5Pm3j/ZraqDJOVCoWe0h65B1kpcRv1scqDMEXpVbDVdz96VZMIprWg0DxKUCZ/RGsu6ChvRlnVnPqvc8i4b0ZtyzGgrd+M/ZwaQ60Gope4t7dghLlU04xE1pNwwuyKuzBYNyBNJle9ReLLhmVdlSvuQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMtu/9jE3QwZblfigAEta+yEhWF2g36uNS9p4vtO7aU=;
 b=KWcmhqu5Pd1z8eOLY8K7uYgOSJYwVeQhDXmpt7VmxSyPRHquieuSngNZQvY8dNlG+YENVjNmRLjBLH7o2kbxzyI2RMCO08S+J6QGVvbf9M+Gu0weaycYpIrM1S5IexoeVojCGRIaedvT+jEd78pvVtqQpUhbnM98gE6vAT0V2Q7/h3wHmnd01veuFVRNIBS9rQxm5MXolHiJWzMRL+0yQd1iREKUOTtKV9VsYp2YeW5+PLjl7sJvf2NpG1nEXy1hlslzqRYr+7IdbVksar8qcTQS3rz1Vk8VRU1Dvmn08XXSXfrZrlDgoGfIGp/wqPzk2XRdkqj+ja/uGiGk7cJsbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMtu/9jE3QwZblfigAEta+yEhWF2g36uNS9p4vtO7aU=;
 b=f2C9w8VIzd4ATrdpwvne7ysuJfblP0vRsXMvqa9IPPg4Gbbx6cMcY/F3U3SBDUs1LU4roHejuliE25desooDlcik+ZJrvgUI9fSxer4OMf9zJmLfLzJEUGpEC/Kj6dS8PLOuIJ5P2VbYjYcebOfjXwNhNgTlZYa5rUVU/RfqhFY=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:58 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:58 +0000
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
Subject: [PATCH v2 53/61] mm/mlock: Use maple tree iterators instead of vma
 linked list
Thread-Topic: [PATCH v2 53/61] mm/mlock: Use maple tree iterators instead of
 vma linked list
Thread-Index: AQHXk38wsuAfg9soFkGI9ordWlNFMA==
Date:   Tue, 17 Aug 2021 15:47:32 +0000
Message-ID: <20210817154651.1570984-54-Liam.Howlett@oracle.com>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
In-Reply-To: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d0c40b5-f4c8-4853-598c-08d9619662d2
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3580395C4538A23524CABBA9FDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OVgk8lbazyF25I2sQXlRfEUwRdwHwTuZHa3s+PH8GrU8694wa+Mg/DKywV1L603pNrbjJ+eYSpERchHW+jmN7DhFpX7scF7OpUAnRk0qUtV24iARUEocxsjedNVkVk1hmIitMneqaeHM848Fk4DtAv3L2Q/Jau7QKd5JnU0XfYlQKoKg/u7E5w4qrzZaiOzIwLvAO0qrRJx/Gg4KS3bYWxONU/WTRZfBUZlXZ61NkXPX6N2FDUnBjREaLhsdtC6FjNq7euFoqdGOyoVRejj+xwxb9cpduWMHBJ4flGalDUULpLQ667YgPHqkZ9Fa0V/agoGm6m8ZdTUl/r8w4+ceHL+c11LcWFBaJKXCRECwxRmq2dFE2TcYoE373bah4DlxsCx/rU+FTP9oZ2+5c0PUHMbQMRbmjNXYZPm14qpXDhNObl5G4wf6X5j5l4HyKP5OXJtR6sJ8S00ugm3OxDLJ3k1qBCE/C8udxiKcVDhQ+h34kksqd3u6RwjNHdwcb0Iw+j1VUa+6LuyjGxrJA/OM/ilmjXQBNfCNLhDzhEeER0eNk9H+9cvFBae9rbIMsHvrmL7asG5spOrOvbnNemmo6Lj12kvG+bgKq5g5ifV4RK1gyxTY9rkgz+k9dYoTa9OY7h1/bIXMMOgF63+hcJYkMloxqc2C/yOw1WIkivKxWNSBi7PuFSW0uLijS59ae3IFpcjAp8SIZ6mKPJ3B4NrgdQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RMguQCv2fbKA+oAhYRxlsx9HwMCuwO5AbhFGUMTwwP0JwY/g3U+CtlNnE4?=
 =?iso-8859-1?Q?UQ11ge7IQBnabwoRW2qxrJsuBCUpfjPbD/9IO2RYaQtvz25+o50riM2Tzs?=
 =?iso-8859-1?Q?1/Vz3zrX+DNDHDWvvEsgejeaBA6tx4qZchcEVqks2FZNNG7mjTq/3/N3W/?=
 =?iso-8859-1?Q?RyyUnBNQP9GI3X5/8Tz++9C/X6KzQRKrYL1pvDYeyd+OYmsWNvYxFcaENQ?=
 =?iso-8859-1?Q?tnhWF4MCUQ1i7C95zaF/UhOnsFns5BQ/ZAwI1cz73PWlgkjRt+mVW6BCuq?=
 =?iso-8859-1?Q?1WPEAoEA6XT5JS9zJ1FSBOFxcWzSkKKkFl6ngCgM68Au13YezzAPrkaclb?=
 =?iso-8859-1?Q?qLht+8mtGvbJiFTGwYHxClwK8eDnVbhnm/ijp4pqxLtTSyYZO/1WMQUctJ?=
 =?iso-8859-1?Q?EfcjmBpV5l0n/Eo3TtitcCRt7xUGFQUzzbaDio8U6LVhvFBAXqEI+jAezK?=
 =?iso-8859-1?Q?xcWBXr4QQ6rLYMj3K/cYePE1kwAceOU2N/66KyN+A/FNWSnuo4VsmT0xif?=
 =?iso-8859-1?Q?iRsp6ewuc/fKYt8UJzMQdm2FV45Tethzw3jf1B0ZjrFf0iau4h1CHul9gP?=
 =?iso-8859-1?Q?PNKRuD/3omDPT+L4tzkXtuegesLXt1uzSXEai0kpVinX/sAytp6kaszed4?=
 =?iso-8859-1?Q?AvrGI5lIKoM7APRt0LqsamicK7/UyhRZ8vc1vqgA3SYWrvkEyq6oAJp0Wu?=
 =?iso-8859-1?Q?IX9SRpB6xDtRQigJw0CK+vkdBkckWkwjBHorFygDUoeLZ0Zvz+5JNS5B+b?=
 =?iso-8859-1?Q?foCfYZoxPF7bTYHLwgld91S08e4IKFZK0+FPQz8fY1WX6YeJgf9FirP1Jn?=
 =?iso-8859-1?Q?Xqen/P6evFJI4srmI36SnPiqKakF31NQTl4A2U7HIrNo8dChd8Vx27Ja+/?=
 =?iso-8859-1?Q?Gzxfns76aba7fcqlBk59SGSDlMVUxtV4ZZeh8/AcZjKEdDaMcYJ3R4EoQx?=
 =?iso-8859-1?Q?7UIh0zSF5t5vXwV0zgPchUFYIulmtuqO67NTSKkCiCK5Y/fQuc9vLjvqPV?=
 =?iso-8859-1?Q?LqDEGq8oi+pRJMkKANjrSzlmAiOMwZUPCJGqKM8bO3nU72deQz4HLawv3q?=
 =?iso-8859-1?Q?dXcJ+zmODM64c6S2avgHmDMFaNG/RJl5fbXW4eHx3vVCnEyzfYb8mgd7Fq?=
 =?iso-8859-1?Q?ymj4x4ExwX/oXTd0yUvN9H2dwrDUTg1y3j2OCfZxGeE7pH6FmMs3t1RUUH?=
 =?iso-8859-1?Q?/r9W9/0MN54b6q7mAEkH23lx58tHLBKmPaeKIJ5NmA+dvz3ifRBSrHPnIB?=
 =?iso-8859-1?Q?QiMi4pitIG66MlSVIWK0z+if5EcYX1eeHFsDK8aPw6KrXLnKMFmgGL8YtP?=
 =?iso-8859-1?Q?gOj0vFzPMRZKAwzbY0SBMJqhGlDW6jKHxozKMqLS2cmR+Ox5pJseNTUUD+?=
 =?iso-8859-1?Q?gWZvQo/SY8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0c40b5-f4c8-4853-598c-08d9619662d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:32.1412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJPVbuL1/qbZvvseicaFGf7Xcm91/LQj7YtCQdavvdRb2LJb2/qmaPYDJHDvuf30BuT8M9gqb1yzmZoQVL9p1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: cHsrUMpbD2mf5jOMv2h9yYQCRBFIJWeO
X-Proofpoint-ORIG-GUID: cHsrUMpbD2mf5jOMv2h9yYQCRBFIJWeO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mlock.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index e263d62ae2d0..a91ea32fb219 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -563,6 +563,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int error;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len !=3D PAGE_ALIGN(len));
@@ -571,11 +572,11 @@ static int apply_vma_lock_flags(unsigned long start, =
size_t len,
 		return -EINVAL;
 	if (end =3D=3D start)
 		return 0;
-	vma =3D find_vma(current->mm, start);
-	if (!vma || vma->vm_start > start)
+	vma =3D mas_walk(&mas);
+	if (!vma)
 		return -ENOMEM;
=20
-	prev =3D vma->vm_prev;
+	prev =3D mas_prev(&mas, 0);
 	if (start > vma->vm_start)
 		prev =3D vma;
=20
@@ -597,7 +598,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D vma_next(prev->vm_mm, prev);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
@@ -618,15 +619,13 @@ static unsigned long count_mm_mlocked_page_nr(struct =
mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long count =3D 0;
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	if (mm =3D=3D NULL)
 		mm =3D current->mm;
=20
-	vma =3D find_vma(mm, start);
-	if (vma =3D=3D NULL)
-		return 0;
-
-	for (; vma ; vma =3D vma->vm_next) {
+	rcu_read_lock();
+	mas_for_each(&mas, vma, start + len) {
 		if (start >=3D vma->vm_end)
 			continue;
 		if (start + len <=3D  vma->vm_start)
@@ -641,6 +640,7 @@ static unsigned long count_mm_mlocked_page_nr(struct mm=
_struct *mm,
 			count +=3D vma->vm_end - vma->vm_start;
 		}
 	}
+	rcu_read_unlock();
=20
 	return count >> PAGE_SHIFT;
 }
@@ -741,6 +741,7 @@ static int apply_mlockall_flags(int flags)
 {
 	struct vm_area_struct *vma, *prev =3D NULL;
 	vm_flags_t to_add =3D 0;
+	unsigned long addr =3D 0;
=20
 	current->mm->def_flags &=3D VM_LOCKED_CLEAR_MASK;
 	if (flags & MCL_FUTURE) {
@@ -759,7 +760,7 @@ static int apply_mlockall_flags(int flags)
 			to_add |=3D VM_LOCKONFAULT;
 	}
=20
-	for (vma =3D current->mm->mmap; vma ; vma =3D prev->vm_next) {
+	mt_for_each(&current->mm->mm_mt, vma, addr, ULONG_MAX) {
 		vm_flags_t newflags;
=20
 		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
--=20
2.30.2
