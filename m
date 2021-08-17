Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A153EEF94
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbhHQPx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:53:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:15360 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240198AbhHQPsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:31 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjXnb006885;
        Tue, 17 Aug 2021 15:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=UmSEJas1BRH5zEjF04bE+doWkDqoD4jAmqgDRjUGooI=;
 b=K9POYYWn63Zzy8/cTzVyUrsgcg8NcyN394Je8hkQy/2QKZ4LN6SARb05nLZcNnwLszQ7
 6QRopM89ysmy6P1XLVGfsBurKPcpzLuCmUkYkQ4MjPNLEQeSxEOXlUBQK/8ehPcKwc4G
 9t8IicqLkNRkENhzDzQlh6WjTZZVLyqKLhqjFJiiTzBAlvf1zS+SkUAETq98a6J35/oY
 ZbGEHFRxvHJNjT0I+bUKs6QI1ojt3uB09uPOfnQcWtoVi09qqqe7tByMPPu68o3IVaXj
 jS1qtOpUEe2VSCxteVkAO6xIUD7tNkHzaRbJ3OND8Le6whueNZJG5ViR6eFi+TwfqakA WA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=UmSEJas1BRH5zEjF04bE+doWkDqoD4jAmqgDRjUGooI=;
 b=iLabFYhS+99zW5+IR3Yj8oiPFzLByICOGLmwOx0u5jBhpqYkmCHO/M94G/sdCwckGDy5
 +853DyfnZsieMjoIRbO1ynuhgp2GT2AhkZi058as5lM1dWQ4w71wpbsgUOdKl+4SWKEU
 mxYQ7hbyAkD0c+BCAZoQ+5EQHOHzVWxyn94AJwxBeSiA5yNfewrVgVXNhv9Xi43qjjCJ
 y6dfhCuE67z/9ONjZsthd/fi3h4E9Tqa8OwsIld67vhqXQpLGDsi6D+RpPN9ehnJ3Ruh
 1AWE3l4OilCSXjBGpHVXCIYpW+iBtYNYwL/rGM9wWP1jn/P6pp2JrRRWrCrioh9HSlTn Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbc9ub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmhN158764;
        Tue, 17 Aug 2021 15:47:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by aserp3020.oracle.com with ESMTP id 3ae5n7su0r-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9APWdk9Sz1uuo+y1AS7bV/Thn/W+61nKMToIAaPIAjUC1KZyLV01OxKJBAg5gyWEPrdJW8elfigxdFc9SMycMMHu4dipbtjjo6T44SjMZTvtRSIiwO0G5z1PwVmrTcGKporKyOa7RnvYCcBZseKQpmCdmjgXYiSye0C5ag3fSz4shN5DgYUYjmT6/XyJkQuQull6gIifWKuvWMbpzlW3ekdJ9WdHW+saJdHRjhqqDPDwL/CxXbv8IB4sCuG4xpHj4uyTZxr+WBrTP6mCVZV2mobh+Ig7s3WBiPXnCRB0ZV82WI76JriqNsFr78bxcAZDmOd1h3A1RnrsDHk+STT/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmSEJas1BRH5zEjF04bE+doWkDqoD4jAmqgDRjUGooI=;
 b=GfHb4sl1LnwIaGmftgYr+Y/U9Dlvn4fp9gVZDrSpA/brTrJI6LfTy5qZbFSV6ANDuAmMJ3qqrFNaKl5ZIQIYc3f02kM6jLixsx9TouRp1wQt4w4XzqhSy/IdQir0erBn6SQUaUufx9tNeb1eIKYMHzkvtWLLDx6Wtzwt/1DKbRi6KYnT3lmm/6FijNnzG9cmwk58MT8OKCxn1FOCGanwhRI9VXDGd5Wad86tDJpAw5riqwyCb5Q8TSi8JbEn1tHByIjX0KTCLbbuGTy1tGz4Vrz2q/x1DOzdQdG5v1ZRYyaOPrnoUG0HxwLgXsKT6dfW8MiQnVqbLFDNqgCK6XBkew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmSEJas1BRH5zEjF04bE+doWkDqoD4jAmqgDRjUGooI=;
 b=rG6FxjxSwwt7Z4uW04QF+qQlGnJU5CXdEjioxhlwZNRbpjE6JCcr8dkV9PE1QBEZ9PwH4Za0S1g3XwwxD3Uuamfi365XpUxzcSw+crKsROmZqSKr/QMb1cl68nm4WWDeWuVyO6Km6LT/4L7HK8KgkegSeaCuJO7S+rR28yMEMlM=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3097.namprd10.prod.outlook.com (2603:10b6:5:1a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 15:47:12 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:12 +0000
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
Subject: [PATCH v2 09/61] mm/mmap: Use maple tree for unmapped_area{_topdown}
Thread-Topic: [PATCH v2 09/61] mm/mmap: Use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHXk38kHOl0/uL360yVdPMwgi04bg==
Date:   Tue, 17 Aug 2021 15:47:11 +0000
Message-ID: <20210817154651.1570984-10-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: d0981df5-863e-4565-61d5-08d96196477a
x-ms-traffictypediagnostic: DM6PR10MB3097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB309728AC120201B85AB7B6C7FDFE9@DM6PR10MB3097.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:605;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kjQ4HC8u7E8R0v68XkPxIr7UGneuxyl2xD/c1LhGTeIcemixohEPITkcCZWfIcDKnllHHxfPemglQRilwExE9EkIbACnMRKOyCg0lV0EXqlHw6IZj3yiIotwNRJzbP5ksFf4uOOGzll94cVSzXLDUtvpEkHyBh0pRfD7jyfXHdst0kdsD87ygxzT/TvID1WKA+/fy6JRoVqeEo2DX6Ex4gOqS9IKLenTyoJMHcM7ZaU/rMhpzWEqnoxRO3Aj9Q7AlUVHrpD6/Ws3V1gXki2AaDeLlf9yHqgOLobmbXy5QJ7Qo3jc2yB1obFjCej2y6G8vB9xRuVH77VYw/B8WFMHvBZAURAc0YJ2BAnC7yh8r/BXm0JcVP5ePnRRi1TSCwCYkxBC0lpc3l/FwywNg7mMvqb8P6G9rvvEbml24xorkxmnSU5DlKXPpxVzK8Gc0s207BkQQbmtQ5BtvsRJjfJkAap9SxZ1+JPhnhHDsH1rQ9CqJI9leY1O30RDbLKYbFhy64SlBSIRa6VVXxiUx9dtpEk6WyI14nNG/RMLqy188EOAdX7gMopBirsdK5OOKJAiL0my6cfY5ZjWXBw1Ci/FoeDFGKkL7lsuyTAhfS7jDJUQVUho+cTmOmWuHtEJN5csh0NUECTPzjygIcvkxBptAQtUSwc1aIFTKcoz3EFfMlxiEAPBmeZlVr2L2M8v+hhqHkHm4R3MkM93NvVul8hgTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(346002)(136003)(8676002)(6506007)(2616005)(54906003)(8936002)(478600001)(26005)(1076003)(38070700005)(110136005)(316002)(5660300002)(36756003)(6486002)(71200400001)(91956017)(66446008)(122000001)(6512007)(38100700002)(83380400001)(7416002)(44832011)(2906002)(186003)(4326008)(107886003)(86362001)(66946007)(64756008)(66556008)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0z/waCzbvXLr7/1v1B//9ci/vXjsZnI9wdjHBCVwXCgtwhOqZNpLlW5dmP?=
 =?iso-8859-1?Q?GghbEPEEsS5nU8nW31Qmli7oT9Wtq5Iiy7uqZRwUwpHabPQcc2WdSY1kS3?=
 =?iso-8859-1?Q?Xnc+VdACgGaydYLDEs0s74zaVbZY4l0lYw3kxvfn/sVqeQQeGzDf3X9lM3?=
 =?iso-8859-1?Q?lUaIiQsc2uFBtygiZAUDWwfqHXnxzQ3/PPAvU4+D/ZU7TfoOPIb5Ge6PWq?=
 =?iso-8859-1?Q?o7m5ICLvZtZl2Kd93qCA4Y8V4x719Oftexqzcpo2Jt+62Kwz5hHmrUUP/M?=
 =?iso-8859-1?Q?jWp2PdXs5pPDKmYu3gHooubvjsEh+PcvLyz86Ine/wKLKy8bC+c36jfDWu?=
 =?iso-8859-1?Q?kEIKDmuqpBMKRqWUgRLNC0dM8a1vvOY0siD1mgbPZDQVasiFZp8yzaQNb6?=
 =?iso-8859-1?Q?fR+O5dGN4JrXqKbk5sA+1aLT/4Oszxhk3e3rqnvuyNNVnXt5KhwJzhBisn?=
 =?iso-8859-1?Q?pPyZ8/FyQDscxQfja8j+t/rLEV1LVePHQFA3E4Ex8oER6WGEhCW0nKaNwz?=
 =?iso-8859-1?Q?6ZY8OTx8vaMzmeyBrNEHOgkRMYWFZxLdfCEb10QfPhUsAbnq/uDGwg1ZIC?=
 =?iso-8859-1?Q?UE4cna+b/HTX0+UjQEXZwnRumP1cAWG2DnNyhHfmro0OCdpojkXj5VHfQ1?=
 =?iso-8859-1?Q?fWgszjlJ9m0T6IBPqqzN21GNh/GJaqX4hW/L2SpBF9D7cfJxYzNDNl/JYM?=
 =?iso-8859-1?Q?Nx0RqL3dzi/lAZmI/vEWzSUy2pB3m6mYN+9jAzNnOBEc/PgbJAwVA+4vGr?=
 =?iso-8859-1?Q?zLqY9gVXFeQrMzXOgFaTs3clX/Wgpm4IP+pLIdNSrvIkhW1kOK7f/IiY85?=
 =?iso-8859-1?Q?F0iqaMxzihnuNlTUnrjbZxBJHj9jorp6TqG9rEEIXaTpME24lN67/fvujp?=
 =?iso-8859-1?Q?Hrf/qxQT7iIr9ruXfvUC6LZZBOebxu4ZY5XAskXMYQMehJdeOb9L+9ZUhk?=
 =?iso-8859-1?Q?vLTS6AdXu0XG/X26IwRYjgkzFC7cx87vMQcnsoTDlTq8Y3IsskPxn1/5KI?=
 =?iso-8859-1?Q?AuohckWe18Zy8As06QNPkt2/oUnA01VSbL0YWvi1C3M/BjuCP7Xx1/HCQV?=
 =?iso-8859-1?Q?n3OCoyWtMF1mKf4Uo+W2WxpKI+YEMc59XBCSXCqPBLhKqusOGnsh2kDDul?=
 =?iso-8859-1?Q?KPt+D+yEVELtwa5O4+MwQ7Pp9BgWBIGfI0SniiE2V3pIZ4QKb3fnZksuDd?=
 =?iso-8859-1?Q?l7qfpc+FlCPmaE3nRgQG97U78+mMNDelOHzsAFMNofHHpG1PCDYj3uzV1L?=
 =?iso-8859-1?Q?jTwWl4s4ZxzjAEOgTlfIsvC2g988HKRemKJE/r/ybzMTDt3gXoW3l0oR+D?=
 =?iso-8859-1?Q?9jxNguVLl/RXJ1w87m48InpZp53q/RY7azDWO3VDGEfc99SBkyZJKe4IWt?=
 =?iso-8859-1?Q?nu7lpO5Rur?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0981df5-863e-4565-61d5-08d96196477a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:11.4091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMYglnSRcrj3YkI3jPRGFpFGY2wH4D0aT71xnUxBdY64A6U84o1MC6ZSsI35x5bRe93pGqHbdKaa1Yfy1ZQlaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: zs4YtFdySI3Q-Y_x3DyQbGNCPSyGNhmf
X-Proofpoint-GUID: zs4YtFdySI3Q-Y_x3DyQbGNCPSyGNhmf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The maple tree code was added to find the unmapped area in a previous
commit and was checked against what the rbtree returned, but the actual
result was never used.  Start using the maple tree implementation and
remove the rbtree code. Note, the advanced maple tree interface is used
so the rcu locking is needed to be handled here or at a higher level.

Add kernel documentation comment for these functions.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 262 ++++++++----------------------------------------------
 1 file changed, 35 insertions(+), 227 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4d996ab2372a..fac6e2554351 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2053,21 +2053,20 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
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
@@ -2075,238 +2074,47 @@ static unsigned long unmapped_area(struct vm_unmap=
ped_area_info *info)
 		return -ENOMEM;
=20
 	rcu_read_lock();
-	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
-			   length);
+	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+				  length)) {
+		rcu_read_unlock();
+		return -ENOMEM;
+	}
 	rcu_read_unlock();
 	gap =3D mas.index;
 	gap +=3D (info->align_offset - gap) & info->align_mask;
-
-	/* Adjust search limits by the desired length */
-	if (info->high_limit < length)
-		return -ENOMEM;
-	high_limit =3D info->high_limit - length;
-
-	if (info->low_limit > high_limit)
-		return -ENOMEM;
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
-	}
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
 	rcu_read_lock();
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
-		return -ENOMEM;
-	high_limit =3D gap_end - length;
-
-	if (info->low_limit > high_limit)
+	if (mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+				length)) {
+		rcu_read_unlock();
 		return -ENOMEM;
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
-	}
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
 	}
+	rcu_read_unlock();
=20
-	return gap_end;
+	gap =3D (mas.index + info->align_mask) & ~info->align_mask;
+	gap -=3D info->align_offset & info->align_mask;
+	return gap;
 }
=20
 /*
--=20
2.30.2
