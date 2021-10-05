Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8495421BF2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232814AbhJEBeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:34:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25022 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231651AbhJEBdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:37 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19513vaH024351;
        Tue, 5 Oct 2021 01:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=JBsq+ztGJ2IUiXBFegoswjtIjPG6hdZrrZFxhda8MJ8=;
 b=oUXJpjGTuceXkP5PX347ITG4OZaOctPhMOiF/FtU+pqVJmz8gniqrKEFoEpgRUOjT1kR
 L1r2EFoRaZD3VE96Fg2xiazSnqGtm+OH9F4nbBNtfrXAP5PEJHdObEYSafAeZhyHIyWt
 FitzjYpOx+pHlK0yya9wl1Eb9uYFgQPtO2/E3hhj5Xicqdcec4wXQb/gBZqHusMA2s9F
 RrT97/+y0pP1qOy84Z9W4zDi0aaSVbiXliTV9G0VCYdY6HLG+owtELS52eh5yapJBbSc
 ZkBXXYNfW4iWxzGnRwkk86b9ACx40a7mhjuB2mW3+qZfELEOEnDVuPvXn3NSvq5B5dgh +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg454bvpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:30 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951Tu3u056799;
        Tue, 5 Oct 2021 01:31:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by aserp3030.oracle.com with ESMTP id 3bev7sgru8-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3fmeAB1UIlRR/bubaKz0RsWzKeJWmzfQbtqcj43AaIqSiChPvX0IBK8s1aLzXIXjD7aHjTvXdhP7SHxClyzk1xLlVvmPq+fw57giRpN/W5lLkO6ASVMFq/Vg3e6kXtQK6R1NRyu8TzuxRQ/xmmzaFBdBHK5Fb5bWiic5DUWssfIMWpHAWUPzSXm4LP6Zep9B4ifjGWBj/AG53CFuhrDZFXnXsUI8CFJnOOl/X+5hi4C/fQoEtfvsqPkvmYPy4aX5QQjhnW6DdUkgIKfAros5B231YaPr0aWuQO14HeKiyS3lWLpL7GhNpWStuOTq76BjcAsi5R+MiW1Im7We8/Shw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBsq+ztGJ2IUiXBFegoswjtIjPG6hdZrrZFxhda8MJ8=;
 b=FflN4ihPNBRjvlnvG8ItxH3rLE6nkIKrVJKW7ne93Q0ZVdcVfFmHT/L/xg+Eyq1sYaXmwnkN44vS8NXz768x4Ym7y9ZC2baFinjB8Qb/PaGdt/509dIDs4U30b7YABEgKgc8BLDEIrBFraZ2THQfp5mHVKiQB+Y8La3iLZsKEC/DJc0rxrlaPrBg3cwsoTSsUWTj+9u430TLRCb8hyLEabxQ/ptm5zyLFhhDd1N2cWZJ3dIfjCjRA3sCmHoyUY18v9qvg1abiHXK9EFV8r3KaJiSVsYsk+58BBZWwlZmJ1GuJFz2a/ruiTjYBUnjCcGMrO7AOTOVn0jwpRzSrPN70w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBsq+ztGJ2IUiXBFegoswjtIjPG6hdZrrZFxhda8MJ8=;
 b=LZHaBJprXt8QtJa6BZrTwtxI9zoSLzGMb3zr7WByjG8gpaNzXKKua9mWpb/ctSadTra6SPivO6Czwb5Q6XfrY4b5RlBeh+L0NGM24ca0pHgKIpzZJQwHRJlbiQd00YF+lt0kv8xUKLneKx6BAqoM+XEJy5AExUbvrNnKkx5/uck=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:24 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:23 +0000
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
Subject: [PATCH v3 46/66] arch/um/kernel/tlb: Stop using linked list
Thread-Topic: [PATCH v3 46/66] arch/um/kernel/tlb: Stop using linked list
Thread-Index: AQHXuYip7Dc5j+CqXEGLP+QyphqINw==
Date:   Tue, 5 Oct 2021 01:31:03 +0000
Message-ID: <20211005012959.1110504-47-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 3d2c59a0-4992-49b5-048d-08d9879fd7d0
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044352320C8601BA447C47EFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1079;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eCkm3suvjQzOmgMQw0sxWy4oVHdbrynRTynRg1SizSAKR1nXEkM6JuOs69QVod1ZsNUACB5/0jQ+10lUFNVbLi4KUngJgwVoF3GqCuwGE04GBA2jXv1Fg3JFo5A/3QLWv0v/dGsTCPbKJE/7Yl7ZOuosgsgHwpHwEJ7X+bvg2jHQBYxQZQ9dTQS6SYRmI77spiKjPk21qGQsMGSXKj4AvOljrnJTZbapuYqV2HE5nESzHzv+O90vL0CAf1RQSnPJuuPdB8sGk+IDjr0qKW/7c8C/xhxdZrVq2M73s4+6rLd4DExIhA0VQABQq+iLrV7EjuBFhCiCrw/OHFfM8jZjZ/kZvzvP2pgRtU8OfOMDyJ8V64eT3l+0SzKF6VGoZ5cksDFb9PqYa9ZYHjpO7tkHgmffFqL7uwxui2wBJGLhR8q9TPlArEaNavaNJLksb9i65JadsNGQTKHBzcEi77iOZVr4Rsw10Wp62KCCuyw66rZqbaNFwxirdnoloCVdDc6EgIDj3WfEKDZQPJHK+aluYRG+qfe9Up5vv8POa2NmQYx5s9DUxJi5n1Y71kEICIKx/obPdGThXFPbASz8pdnqZT6EwkBO+CDCMlf1GYq8pTW+5yVb8edyQm2Vp5hbp5uHgsCaOkqWSJ/H151z9058D4GCSaGhqBv0ZYWNPiS+dStG6MinlRdZ1eKvjbrq3BeXdVyzlAQUwUQGUSqvGG3F+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b/DroHQKKmqdu6b3EfuUFKqo8GwvEMJ3LlhgKQ31iAsVhZ0U9uemcI7Lvk?=
 =?iso-8859-1?Q?YeOmcgIvBsOUzm5B/wdHqJzCdWTynLzwirTn9bBIvEWRDRAKcn5ajvWlC1?=
 =?iso-8859-1?Q?jLfihoFUpBJU48jopnt/XQsXFOHHQoSDlnbZV2K8l/6SGISyzsnzczXrr0?=
 =?iso-8859-1?Q?kjS8Eh4+R3ZIDjIzDrVu5OSmt7n3BWYqOi8hElPP4L+bZppHPwO/Cc4s2j?=
 =?iso-8859-1?Q?JDj1ispKtSvfx5RvdsQNGcoF05lTHvvDXeh7uDoBC64SQPlDZIYPul7kVd?=
 =?iso-8859-1?Q?a0+JCLhmlL0ffF7BT5f2n0eAB5sW/DjAr9o2UiuNFSI+P+TYrkiU5oYggr?=
 =?iso-8859-1?Q?qdw8ORdQfTaSBwGfStbE1oCUB3v0TJDspSRTLYLvOlGrZlWrgflONy20Lw?=
 =?iso-8859-1?Q?dI2srg2yLSAOPl4hEBsFz8xuD1MIVW+VV8WGpUpEk1eYfkGz+lIazXmVjr?=
 =?iso-8859-1?Q?FANM9/Wj2z1vFrb4SDXqWYTK65PDtTI2X1nv+6DMv8kOVlXZcPz3h/AgOM?=
 =?iso-8859-1?Q?I1LGD1lZklFJFDLgLQt+42K70Pvgc327mGOgb9uikSD3W1XdkMNot464/O?=
 =?iso-8859-1?Q?l1Z/mS6cy23/9sVZT3fjZhZuZEfVZ5ncN9CUf5jUDGfRYXIh+9jSeV4kOD?=
 =?iso-8859-1?Q?tPMT92JU08kpqzlUyky3+3iS4ZFCnI5en0JW5gKi9cx7V0vPmMThejBxX/?=
 =?iso-8859-1?Q?a6Ll1zJswqlQKe1p5F+BhnZIH7iCnRvE5G3IOy4QoVHwN1GjnbAeter+fy?=
 =?iso-8859-1?Q?E/Bg3eEcfK2dy+lzaeA2jT16tcNek2D/k3HqluDGx8h8SfPttEf2shcCxk?=
 =?iso-8859-1?Q?KIe5LzrrM5D4RjNBoaDzsp++b6AUqP8oZbjT4K/5jwJ5SicubJuqwn83lg?=
 =?iso-8859-1?Q?/ok3JILEGYxqdseE42YCAZtKgy2eyXycldVkwM5FldmEuaNamNrUrIMHUP?=
 =?iso-8859-1?Q?6+FbYsaDn9aMfedm/+yBMcxvlnhJqMNLPMYcOnYyvrXyTrI6XCXpUC1Gax?=
 =?iso-8859-1?Q?CLHwRu4saUK91+QjE89hbbB/16TRqA/Y4IyqCv+fsknn6gbiqtWIbQlINg?=
 =?iso-8859-1?Q?15KnSVhhVhbRIyq/yCAcyePbEfkTyK4jtwV5Hzt9o1szF2ShHcVboARsmg?=
 =?iso-8859-1?Q?PQnygXemUx9yNmfYfWwIu0Pkme2wfLANyCWQiBG8Ia7/Zm7pGrFW4GRscP?=
 =?iso-8859-1?Q?ZZGPzOM6TLbWn+2X540Rm65MmY8Yx1fIY+iuRA38XpleXaAm+BVvkwLfxI?=
 =?iso-8859-1?Q?Z6zTZY3/2tnNbpIsL52PcWBJ2G0JLFxSTGfUX7TDbIfCagVqGUL5ktLXUP?=
 =?iso-8859-1?Q?gk6lkK3jQti752DvJOXn3OqhU9VeAH+XLcgiQI3tKloYR5S9/5NKItNhYg?=
 =?iso-8859-1?Q?i8mrTfUM76?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2c59a0-4992-49b5-048d-08d9879fd7d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:04.0133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUHOpZmq/E51jT5Z90A82gfBJpRXFMa/+SwDS7q4wXz+mSiqkMzUD3uzVCdrQnVg5z7YRLJ65rF11Oz5cKLR0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: TDn6cPEu8bMO1cNkFzPOsiZopOGbR5v2
X-Proofpoint-ORIG-GUID: TDn6cPEu8bMO1cNkFzPOsiZopOGbR5v2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/um/kernel/tlb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index bc38f79ca3a3..0cbbebad70a0 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -584,21 +584,21 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigne=
d long start,
=20
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	while (vma !=3D NULL) {
+	/* Must hold mm_mt lock already */
+	mas_for_each(&mas, vma, ULONG_MAX)
 		fix_range(mm, vma->vm_start, vma->vm_end, 0);
-		vma =3D vma->vm_next;
-	}
 }
=20
 void force_flush_all(void)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
-	while (vma !=3D NULL) {
+	/* Must hold mm_mt lock already */
+	mas_for_each(&mas, vma, ULONG_MAX)
 		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-		vma =3D vma->vm_next;
-	}
 }
--=20
2.30.2
