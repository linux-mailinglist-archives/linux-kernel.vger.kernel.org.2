Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA28636DC1E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbhD1Pmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:42:43 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:56594 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240649AbhD1Pim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMZPe020193;
        Wed, 28 Apr 2021 15:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=3WNnb2gxwc0ljtpvA9nTXL5v7pAr0x4m6qHO3vY6lNk=;
 b=cevF3Ap91LEzygv1kBMo8Hjs6M6EUMA8psLJ+sglCEg0k/vsYzaIx6iyH5o0PvnlIwWC
 ciTzA0yxr744n2BoT04Pjvi3ge5IiuYrUb2Ol7SEpzMeF4GKaMcicaqoq7Xv0TJ2/E/w
 28y4huF4A3tZBAn7SdX3v/bs+yZ+WBUF+HQt2+ZQAfSbruf2IJxW5PWDNltzS+/vNHGG
 zF2J4x+Fm8xiNUyHZXJb/ZvwolS2HGRMEzzt4pgBJH+fYkqa1mRCjTdvwnEIrVo03a+7
 l6Flnhj3EqMxNlSfkInLxfDqRkstn3VlllXPUpbZPC1/JhVIlbngo1tHubG/h7qNY7U7 Bg== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878kgg533-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:35 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFZjx7021758;
        Wed, 28 Apr 2021 15:37:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by aserp3020.oracle.com with ESMTP id 384b58qq07-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V29jbLQijyoYC51qGE2zMNLXW+g1ZzOlY99iPfn6f6MRnD1pqkR5UebldMAdRoYTe/ZGXbL0LwyFxKFbqokSIAyYuk3ZelDjyCmaKN3kGwPEwmQEaaWUThNZ+W2DJSXRgpsYkOyIhQi52tgBjJghZUihKHohtd7CzMc0gmEDO2rk3CfM52PqLOiRnIc7A8KXKUWakrjchMhPSQKF8d7cUKSHIwFhzhISPSIe25RT5taxUDeSmu9h3LJecS1wADTiK9oHQ/yHgzYYjaUx1VTEqFlLmpUN3m64dHebHyoobpuwbvTsS0iutf8P+w/aGl5ziNIMwFWky199bCyCgc30+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WNnb2gxwc0ljtpvA9nTXL5v7pAr0x4m6qHO3vY6lNk=;
 b=R8KThz3+lJDeTKqbXyFXJ/HSYr/I1YVNtxxRu6EhIJyf8lDDK+ZOkGpW4PzB9xdDZ6VUOgAvAbOn5TgODEoV+Nd90hZ2TyE7I3zSyCW/trTl8pob5Db6DG82pBG1zwbvuVdhcuw4vf0qxSIYvKjcMedadFDkHr7WFSp3N32Lfs96ZK1ldcyyzsUReQgcA5P7D5ccnxdm5TS0EqHVvcOpWDR/Z40gs9PdfiiKiu6qdnA1jpdUsxDt9RDdHgEE6HmJTiaShnAQlzi8bmzoClOp6gGmvHf/Ouy5URqzD6fQlwOS0RpDEsdOdgRs55m8e+SloXFYAWmlsU06a+BJgkYtbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WNnb2gxwc0ljtpvA9nTXL5v7pAr0x4m6qHO3vY6lNk=;
 b=f0qgnzcIdRGTqIOyr0Ls8x2tYDyz0R0opRI1zIU/eqm3HFZ5ihoGDXW0/AUqlcCurNeblrkeSKcuhR4VC+iHmn+4wkXs+Vo2Qh+eqpMQeSyYsEjq/U0kNv1dfHpURaaEVTbKqGd1CbVY0CifjV8TCApKID6tuWuuyVLjranhiQI=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1871.namprd10.prod.outlook.com (2603:10b6:300:10c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Wed, 28 Apr
 2021 15:37:29 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:29 +0000
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
Subject: [PATCH 88/94] mm/util: Remove __vma_link_list() and
 __vma_unlink_list()
Thread-Topic: [PATCH 88/94] mm/util: Remove __vma_link_list() and
 __vma_unlink_list()
Thread-Index: AQHXPERCY+klfYb+LkaJT/lE13g/yw==
Date:   Wed, 28 Apr 2021 15:36:30 +0000
Message-ID: <20210428153542.2814175-89-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: a025e7c4-7fc7-40a9-f1ec-08d90a5b8830
x-ms-traffictypediagnostic: MWHPR10MB1871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB187160561BF7854D10666D64FD409@MWHPR10MB1871.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0RmoYo5hSnvJCJkhYpDCkrP6UjXe4wcpF4JAGs3JkjPDvPbH8y8YhqLhd/N6gkW2N/xN76MZGdFasInoLbPEQ5ZGVdrbIDx7p7hVzpW/GwrFPICdWTLz+0JqVhYOWf9TBXeY/UHEULMxIbNrRBly5/F4peAGxDfkEBNOJ7TfOgFpMmW7zHZMbm5SvqxiOtPeCcrDoqq5S6uDgY5xaYyshin84fl/ZCIFbpz7q4OrciiPCY7n9xirBKUEzloR6QhBQDIndn9BZ2BSs+UWW/Yp8rPyGxdwaKySgtKuMnPo8oar/qBWUu8COVhtPsa10hsG/+teXf18YxAAgI5AnEv6OqL0He0FFiPfVEdbPmVR0rxhzkCz2Pgv5MEphlmbyjWt9lI5LW9rXKvyd9EH077NGnDla0jZuMHmtUnxg00jraHQMsViY/L/Y1aM5ci56iwBhhP/nYVofCJECUDBujX6/r/2RUYiK8RR1BNTJ9q9yS2gTR62iZPMRIBhQyAoxKduGUphDTQ5v8IMonPhKiOKBFDWciv3/z8VeDFrL1aR+ta6UfUF1oNVwLSSpNpj1mi+rMSXSnTJyOiTvG2eSmPBVg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(136003)(376002)(396003)(86362001)(186003)(6512007)(66446008)(6486002)(66476007)(316002)(107886003)(5660300002)(66556008)(71200400001)(110136005)(54906003)(478600001)(44832011)(76116006)(6506007)(36756003)(7416002)(6666004)(26005)(2616005)(8936002)(1076003)(122000001)(38100700002)(83380400001)(8676002)(66946007)(91956017)(4326008)(2906002)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?IKUznlK4NKiEcOtsZG1995i7ioZDUOux1cjK+tNRge4hstWo3h3fjL2vC1?=
 =?iso-8859-1?Q?6s8jdhpWJkDJRond+W57rzdqgD4BW+P8nq0BoeGjKsnZT3ixWFVY0rqGZ9?=
 =?iso-8859-1?Q?mrXFnBX7bFu1RzxWawdhpFfMMjS/J6ORNX6ZXEtgQTp3nkuHb7SQ8q3T6r?=
 =?iso-8859-1?Q?84SRffPhcupRJe1YDqI/RBUepnTl2h+A9OJq3IPf4MKoCfpcQptVpVCR7E?=
 =?iso-8859-1?Q?KpeILjKd8Kg8aHulg22w5aPsFCKrUsCO70kmWZ/H//8CtWUNrEusCRzPZ8?=
 =?iso-8859-1?Q?8x936hJEQyY1IPYeVZbRUUQdUR7bOrjZa0G22i0/njTMx+m9y2N6IuAtGK?=
 =?iso-8859-1?Q?KMNHjSGjU/BTr1ixQ+nBAETUkUD0qlB8msEKDbBNlYqhkLNBx8Reog4lV3?=
 =?iso-8859-1?Q?m/kH/x6xH5ZAEa6ofb6RqJERGjiAgGL1bHvckkIbjzuV4Rv9R07khrWzir?=
 =?iso-8859-1?Q?TzcLMNx+Ax1qK4hH91IK3zvvYJdA0ML68feShmbXFvmzxgSg6qKKbFuOLU?=
 =?iso-8859-1?Q?Pi90Bn11MrGLJGRsQ/OhLGx/YqsRq1Vr7tjiZlqJvVOctGMX2oSMxpCcLT?=
 =?iso-8859-1?Q?ZDW+G8yqvNISo0b8q7u0Cy4m3+3m3kQYLqI8FEOqwvdUsW+0nqolvO97wd?=
 =?iso-8859-1?Q?VvKb8xC3Jp1Jv1UDcHMPur600UcYIEwuzjSVus1yOlSZX/7bTbDKzmVn1w?=
 =?iso-8859-1?Q?EYyAezIJWyNJXY4JRTl3QyjWlatiGHojvYyJbN2kgUCYnO11/dkwhV3HvO?=
 =?iso-8859-1?Q?VIcUj5/UA7pOzzFkWGbmfEF2iCkTmlNy1BELtZuD6rowQc2jlkfBZpHzlB?=
 =?iso-8859-1?Q?lXFJpTGfQeuH3rtkG6F4D6fmrPcjw+GDhLYeAxNnBTBOVgcDCV0TqBtuih?=
 =?iso-8859-1?Q?5sGmtvo7kPca2HBf+wCuyA0fc6eXUMhG0pnYGUQzAPqx+s9mqnmStG5RMo?=
 =?iso-8859-1?Q?rzeXNe0/RfX9ns+bk0KdRVCgojEhrK7l4c8AKobIOFUilzbj05lLoRoMWc?=
 =?iso-8859-1?Q?z/sjobs98da5uumLHgf0IS7pA7xoP+egtDuxZncPYhCpp+giRUeumMq2vT?=
 =?iso-8859-1?Q?gwHkEI9DnK8OGWo28SWOPcwvPYqzAEXXFsy6fEbdUdLepdlDGBjhuWWxTu?=
 =?iso-8859-1?Q?MyTrSlmT1pQMNkQlVCYds9swiVtJvzK4GLJUjM1tyP79kVdNKVcVCij2WX?=
 =?iso-8859-1?Q?ypTh1raVJowX1vX3AiF82mh11cjdMSwhEQZbOSBqdAdtnJ/MUzoAXOZdm9?=
 =?iso-8859-1?Q?C+RuBcQJfv1nx+DLyPVckyzZaoSRmy2paa42K5mTD6IY+RZ6Lo1jVutRkK?=
 =?iso-8859-1?Q?zslJUo2XVyC91GM2HyZurxbgE3HIhs46t8lDMKjEX+ZgmcQkcoM60BEk8F?=
 =?iso-8859-1?Q?WcX87d0n6q?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a025e7c4-7fc7-40a9-f1ec-08d90a5b8830
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:30.3237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GwLVkHRlimBLMWUxwCiWQQqUshtceLsdDdDz3ElTSNKaUb4jWDU7VTtjeDWF8Z/mq29mCeFhoHcbaGazX5owIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1871
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: 9_oUw5oNPn2SYRcpaiqE3asLAyJTUqs7
X-Proofpoint-GUID: 9_oUw5oNPn2SYRcpaiqE3asLAyJTUqs7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/internal.h |  5 -----
 mm/mmap.c     | 19 ++++---------------
 mm/nommu.c    |  6 ++----
 mm/util.c     | 40 ----------------------------------------
 4 files changed, 6 insertions(+), 64 deletions(-)

diff --git a/mm/internal.h b/mm/internal.h
index 583f2f1e6ff8..34d00548aa81 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -394,11 +394,6 @@ static inline int vma_mas_remove(struct vm_area_struct=
 *vma, struct ma_state *ma
 	return ret;
 }
=20
-/* mm/util.c */
-void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct vm_area_struct *prev);
-void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
-
 #ifdef CONFIG_MMU
 extern long populate_vma_page_range(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, int *nonblocking);
diff --git a/mm/mmap.c b/mm/mmap.c
index 51a29bb789ba..ed1b9df86966 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -583,7 +583,6 @@ static void vma_mas_link(struct mm_struct *mm, struct v=
m_area_struct *vma,
 	}
=20
 	vma_mas_store(vma, mas);
-	__vma_link_list(mm, vma, prev);
 	__vma_link_file(vma);
=20
 	if (mapping)
@@ -604,7 +603,6 @@ static void vma_link(struct mm_struct *mm, struct vm_ar=
ea_struct *vma,
 	}
=20
 	vma_mt_store(mm, vma);
-	__vma_link_list(mm, vma, prev);
 	__vma_link_file(vma);
=20
 	if (mapping)
@@ -624,7 +622,6 @@ static void __insert_vm_struct(struct mm_struct *mm, st=
ruct vm_area_struct *vma)
=20
 	BUG_ON(range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev));
 	vma_mt_store(mm, vma);
-	__vma_link_list(mm, vma, prev);
 	mm->map_count++;
 }
=20
@@ -681,13 +678,8 @@ inline int vma_expand(struct ma_state *mas, struct vm_=
area_struct *vma,
 	}
=20
 	/* Expanding over the next vma */
-	if (remove_next) {
-		/* Remove from mm linked list - also updates highest_vm_end */
-		__vma_unlink_list(mm, next);
-
-		if (file)
-			__remove_shared_vm_struct(next, file, mapping);
-
+	if (remove_next && file) {
+		__remove_shared_vm_struct(next, file, mapping);
 	} else if (!next) {
 		mm->highest_vm_end =3D vm_end_gap(vma);
 	}
@@ -896,10 +888,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		flush_dcache_mmap_unlock(mapping);
 	}
=20
-	if (remove_next) {
-		__vma_unlink_list(mm, next);
-		if (file)
-			__remove_shared_vm_struct(next, file, mapping);
+	if (remove_next && file) {
+		__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
 		/*
 		 * split_vma has split insert from vma, and needs
@@ -3124,7 +3114,6 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct **brkvma,
 	if (!prev)
 		prev =3D mas_prev(mas, 0);
=20
-	__vma_link_list(mm, vma, prev);
 	mm->map_count++;
 	*brkvma =3D vma;
 out:
diff --git a/mm/nommu.c b/mm/nommu.c
index 0eea24df1bd5..916038bafc65 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -592,7 +592,6 @@ static void add_vma_to_mm(struct mm_struct *mm, struct =
vm_area_struct *vma)
 	mas_reset(&mas);
 	/* add the VMA to the tree */
 	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
 }
=20
 /*
@@ -617,7 +616,6 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
-	__vma_unlink_list(vma->vm_mm, vma);
 }
=20
 /*
@@ -1430,7 +1428,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 				return -EINVAL;
 			if (end =3D=3D vma->vm_end)
 				goto erase_whole_vma;
-			vma =3D vma->vm_next;
+			vma =3D  vma_next(mm, vma);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1488,7 +1486,7 @@ void exit_mmap(struct mm_struct *mm)
 	mm->total_vm =3D 0;
=20
 	while ((vma =3D mm->mmap)) {
-		mm->mmap =3D vma->vm_next;
+		mm->mmap =3D vma_next(mm, vma);
 		delete_vma_from_mm(vma);
 		delete_vma(mm, vma);
 		cond_resched();
diff --git a/mm/util.c b/mm/util.c
index 35deaa0ccac5..3619b2529e51 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -271,46 +271,6 @@ void *memdup_user_nul(const void __user *src, size_t l=
en)
 }
 EXPORT_SYMBOL(memdup_user_nul);
=20
-void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
-		struct vm_area_struct *prev)
-{
-	struct vm_area_struct *next;
-
-	vma->vm_prev =3D prev;
-	if (prev) {
-		next =3D prev->vm_next;
-		prev->vm_next =3D vma;
-	} else {
-		next =3D mm->mmap;
-		mm->mmap =3D vma;
-	}
-	vma->vm_next =3D next;
-	if (next)
-		next->vm_prev =3D vma;
-	else
-		mm->highest_vm_end =3D vm_end_gap(vma);
-}
-
-void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	struct vm_area_struct *prev, *next;
-
-	next =3D vma->vm_next;
-	prev =3D vma->vm_prev;
-	if (prev)
-		prev->vm_next =3D next;
-	else
-		mm->mmap =3D next;
-	if (next)
-		next->vm_prev =3D prev;
-	else {
-		if (prev)
-			mm->highest_vm_end =3D vm_end_gap(prev);
-		else
-			mm->highest_vm_end =3D 0;
-	}
-}
-
 /* Check if the vma is being used as a stack by this task */
 int vma_is_stack_for_current(struct vm_area_struct *vma)
 {
--=20
2.30.2
