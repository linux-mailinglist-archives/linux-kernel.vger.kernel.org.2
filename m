Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAE0421BED
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhJEBeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:34:02 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:19832 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231222AbhJEBdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:33 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1950fjVi024345;
        Tue, 5 Oct 2021 01:31:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Nzwt4pIgqaH6FzaICIvcCA6nIKTKzeWjo8WrFpwuvbY=;
 b=dJLVfQf4RaaMJJUNIu+wottED+M3tX4Xhg+P3Uk8Cs5nwYggUhAcsuawgvT1xlG5QVY2
 TMZKD10miLl3IVgIuOpxzVJK3pJtLahw/n78tIEzGIGw10jlsJxjNV4VRa+zynB1boz9
 nX9dVDZyX/h+2xmEU7tQ94IfQ5pUGH+TRAUp/uhEX6tD34EqOpmbnoYGc+Zd/8UprfGh
 AnXM7ipq4HMtMMhkxfl2lelUQNSHJewHHvXhj9+gnQopmemtpR4X73km6/Ktj0dtGcwc
 dTqaMRyIUDWLV8JJm9EnIGO4zmFgJhjkiApVV8+RD0hfOL/ap11JXvgXtzEa+ldPUiCG uw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg454bvnx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Tu3n056799;
        Tue, 5 Oct 2021 01:31:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3bev7sgru8-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfUKo00Nh/WiN1eUMEjRnX0JbRdUkND3lRU05VYpZP611/LQ9XrYZTTEu/B83fdIxUcT4RUrhn9LLSy2/wSS2xTtXRTN9CB6YaFwwOQFNBDvqY/XPm6a1rAV+1414ByFcp4ClTNeXDqSRYLjtJvPdK51xQwOAg3U3s5aH/BI192i/TKkKfDAZnh6t0mC/GXyew/8OvVM/wdRGMlG9IlQNNm+uveoiyckRqDTQjSDCOKl8ZEoO10iwMSqR2PSEQqUOjYUqQDZqFemC4fwvHqhMOKr6be3iEPRxHybIyNYson6djOL8/0bWles2L/OK9iELdMoqP1UMBUFf0QLkzVm5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nzwt4pIgqaH6FzaICIvcCA6nIKTKzeWjo8WrFpwuvbY=;
 b=mc8ClwWRSUvbTqQJCL8IrKHOTpuwj+V9uSNJPJAxyeqWKMQGZdFVrEzYbuDqiPz+FRGDAjGehupt61mVWxQYYHmPr6sdwt5tcv0+mHLQWAtZERulo3btnC0Q2OytnbMMyzlhosJe+5vDGCwwZnAKI2AaNPB+kVQ4t+HiuOX3VpCVb2BVouwwImJT9i9NHdlEuTrLosZf69f5+B293RnpZ/lvZmneL4BDx+z3lIuKCFgMhcCgN60B70zBkerx+LXRLfs4Um32nV4mbTsfUGkp5F/4BkzJbSYjDAdaA4iuRPnveKB0M5sRLBmP8AIBjOe1iqJyUlavOgq5AJkoVPpN6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nzwt4pIgqaH6FzaICIvcCA6nIKTKzeWjo8WrFpwuvbY=;
 b=kF+bgT3NC/HWhsolSHYzQaX/CJGbjYQeeyHyv6+w5JGN0sdvsEGhFfIbMZxu3vRKzJ8j1ST0X1md7YrCZ8gs6CWbYpVaTh/rHQn4Rf0jqqOZHdw+I4rmJS0HxNl6kvHtnk1qrCU0oK2+2odpGmCzo+y2D3gWpq8KDFf00gST8Mc=
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
Subject: [PATCH v3 35/66] fs/coredump: Use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH v3 35/66] fs/coredump: Use maple tree iterators in place
 of linked list
Thread-Index: AQHXuYii5UIjz6couk2eUw+6FJn9/w==
Date:   Tue, 5 Oct 2021 01:30:51 +0000
Message-ID: <20211005012959.1110504-36-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: ad8aa3e5-1c52-470d-1b82-08d9879fd646
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50440E179A3E10112568AD36FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ki83Xv+bjJCW+t59GccfFihR/GZijYj7+O5zSDIYCgsGXU2cSPj++bpkNpluPDuB9BzYeTYFaipAlFOUy0cit2LpZ1t8xkRfjfU22L7ObEnDdFmUHLgaB+Va+F3DZDjC1hGcon25LmwbDKeTfbn1a8cki8f1YmOpUFAG6LMat+8ABPbHW1wakyGL1fugqYz8IgdVNz+BWRiiuy3edWbvvuA7AVEASks0hqmONN2FjqgWYPL4NYy7vQ9nNSjAsbqGJ4XcuoVO6Q5u6Ob9ATy5B/6N/BX8uzB8zKgBuMehpDR3cVeTdMqv4WMaIAQeYbDQ0fSRlNabyTAOyT/pG/AVGpnBBe2abpoPzudcLmTPR0TnksdkZLUngb3LcgOT3yEK1JBmFtCJGYhRTja/j2Ngnf+Tmijba6rpon0SYFLPDzKOKXcO0dcEoGfhIUID42y86/dsPskUdJOAgtIkn6soTkr/Tql3AsUkT4S5ipcLPY9cyDrjFtAcvM7PFq2FC9bfwP4auK+mYRt1CF36gvu0I28UDXEwIhorbAuhusJNMRnMM3O02hjhlS8FnFlQfOLW1QRTuxvSU8tbjwWVzSTyQ0I8/4AvQ4BgtrAVNcXLJKyMMPdBi2XS7M3+1chtJJwBoi1x0WQvgjcx6jBpQNSof/G3dVWR/e/GK4MEDYnO5nMDtCIsMiVmBk/DDAZx6cy+jipTsqtDomFsdBQ2K+eWfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hzJeYc1prhEDwY+CNb4jFw4C07WuXBAL9rIaMmDlKceETms9ADg0SrS93D?=
 =?iso-8859-1?Q?r9rA1gUmvPNhXXmM7/xG8nMMI8HtX2f6Iy5kSv0bQXJwIuWuvU94GiBt7J?=
 =?iso-8859-1?Q?btm+ACT2wp9ga5zTME5cZ17S/Qw6thVjM9J5oyMxt+FsE0sXZ3yjIVwZfB?=
 =?iso-8859-1?Q?7F1wR0Ridw4joc+QQlEzf+J6jtZJ8IfYWtPzZSgZDerhhYiv/Y/riJ6Gn4?=
 =?iso-8859-1?Q?Ib4u7R/KDcLNS9xCBq8JBBE4yDyNSlpJKglLao9vLVXgfoANYQrcIAsOq7?=
 =?iso-8859-1?Q?Vu4xutMgIQzQJHDHMJp0dvCDNtVFbIM0lhzFMvsF69oCXygCM75fsXpHCU?=
 =?iso-8859-1?Q?tR9XcSAK5Sk9kDZBP6AsvLGz77c6BDucv08cOKdoif9vwMRJM4ylezZM3u?=
 =?iso-8859-1?Q?h+v/hjb8lP0M6c6mML7lRBrPPamMYZjdAPmzqguRq/b9MsIECsFh9bc/nk?=
 =?iso-8859-1?Q?TK+krJznCq9JpY2KVu9TkeoZgUBjUA/XrL1XV6oz+Fw0fnMW0YC6eIUZcl?=
 =?iso-8859-1?Q?D7wEljT/O0uwZBAFN2BEpxRuJD8TUz9aEjbrnoQVEdVdK450FJGg0d8F/w?=
 =?iso-8859-1?Q?fMfzJRaTBJ/7CmHLknBnI97QVrur+RDvodWp6ddYBty6wIQpFMAcW8Gm+k?=
 =?iso-8859-1?Q?8r1TLeBHUgriCwi7atO+qXgWKIm3meiABW0d9jgmXdltr0JjiKIIf5a6Jz?=
 =?iso-8859-1?Q?KUGtb56J0tVVWr83LZhfvW4CKGMRxaf9MjfYOEHhuJGe9OndS3g1uH3D0v?=
 =?iso-8859-1?Q?ROUYr5gGL0Mg8cimKWIgyFaQoEeUUPDWDu/q0v2BVNRAvEuRkA4aJII8pu?=
 =?iso-8859-1?Q?ierB3eG25chxs4aZHoI08EotjW3g+cWxxwMVXUT1S62VV2KnMScN7PmkUi?=
 =?iso-8859-1?Q?YSSDX+Lt7oWEHEcHqSqKP25VvVUhGmc01NChyf2+/NBjaia/8bkCkxkRrW?=
 =?iso-8859-1?Q?j8IU7gTq8qZp54uSplo2qojMUzGTXG9wYP9ER0IaSX8afDfaW8irBJb3Q/?=
 =?iso-8859-1?Q?OcmxPdPKLh4FaoT5mLbyQJdQz3EBFCXi9IS9zShl4deWDWWFmO1TbuXp1u?=
 =?iso-8859-1?Q?emNUCMES+W1gCq22BpZez3A22KD8QEXCWZDcSoOHNr/t8XZNp70UNjW4tF?=
 =?iso-8859-1?Q?QfFOEiZ2dng4SqBMjtukZ1lhAsWJs1pvYq018b2bFH4lhcit/tOQY84EXO?=
 =?iso-8859-1?Q?bCE/YzRFrkh4n7KkDp4XyLuOqBIayzFFKKB0GKICYqmJC4lNoMA2CSGv0+?=
 =?iso-8859-1?Q?VajZAoByc9Da2bUTl7vFXuht8yOcOFm4HoN2yjRHpZWen0+Unn/RHJlWEd?=
 =?iso-8859-1?Q?Omcwz82jrTOoXBHDHp9NxPF/2v0jFuVl8EdC5tZwIzp39lqgb8Jcf026CC?=
 =?iso-8859-1?Q?VByTA2ZWL2?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad8aa3e5-1c52-470d-1b82-08d9879fd646
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:51.9342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N6JMOOsmMKpT+3rladuwgo8Q5JKgEXPe38PVJ2Ud0iREmTNm+uwzqBiczGrZgAb/CzOML681pivzG/HKxIg+1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: Y7MvITtGtW4-SEyNCYgsvI2pkSE1A73u
X-Proofpoint-ORIG-GUID: Y7MvITtGtW4-SEyNCYgsvI2pkSE1A73u
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/coredump.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index 3224dee44d30..ab296bc42c58 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1063,10 +1063,10 @@ static unsigned long vma_dump_size(struct vm_area_s=
truct *vma,
 	return vma->vm_end - vma->vm_start;
 }
=20
-static struct vm_area_struct *first_vma(struct task_struct *tsk,
+static struct vm_area_struct *first_vma(struct mm_struct *mm,
 					struct vm_area_struct *gate_vma)
 {
-	struct vm_area_struct *ret =3D tsk->mm->mmap;
+	struct vm_area_struct *ret =3D find_vma(mm, 0);
=20
 	if (ret)
 		return ret;
@@ -1077,12 +1077,13 @@ static struct vm_area_struct *first_vma(struct task=
_struct *tsk,
  * Helper function for iterating across a vma list.  It ensures that the c=
aller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
+static struct vm_area_struct *next_vma(struct mm_struct *mm,
+				       struct vm_area_struct *this_vma,
 				       struct vm_area_struct *gate_vma)
 {
 	struct vm_area_struct *ret;
=20
-	ret =3D this_vma->vm_next;
+	ret =3D vma_next(mm, this_vma);
 	if (ret)
 		return ret;
 	if (this_vma =3D=3D gate_vma)
@@ -1120,8 +1121,8 @@ int dump_vma_snapshot(struct coredump_params *cprm, i=
nt *vma_count,
 		return -ENOMEM;
 	}
=20
-	for (i =3D 0, vma =3D first_vma(current, gate_vma); vma !=3D NULL;
-			vma =3D next_vma(vma, gate_vma), i++) {
+	for (i =3D 0, vma =3D first_vma(mm, gate_vma); vma !=3D NULL;
+			vma =3D next_vma(mm, vma, gate_vma), i++) {
 		struct core_vma_metadata *m =3D (*vma_meta) + i;
=20
 		m->start =3D vma->vm_start;
--=20
2.30.2
