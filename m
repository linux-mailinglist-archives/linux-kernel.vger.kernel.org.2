Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE95F38CC9F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238687AbhEURuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:50:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42896 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbhEURte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHTe5c111674;
        Fri, 21 May 2021 17:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=/Zt/k07xlrLk74DYHKOvqiCkdZdXA3wugk8M/1QPmtc=;
 b=kPXkXYxyExnc7VSOi3zre0JsMZDeD8ETf5StZPoXsBFhtfjdykvX6n9lsJXcVmp6ljVs
 5/I80fJD/fNBakF0r/5+5cf+B+c18bIMDrZIe9KvlxhSAzulWQkz2cqiDfuv2pVPhJ7v
 RswgR0dMqaH+MiQuuBCrslISWKRNR9k4V1+8TaTVn4IEXoYNyXQSxtIb5QLOUswASVUC
 diNYM6ebvPoKXjoN3WS9q5qShrpEwuJFfL2q1UZE7jGBIg1VVOcdyEq9pAJGU4dF0V09
 +wFlmBdJIquGLbfBgS8M0jh81YsySTH6Nq6CW3h6emzgLdP91Xor9MD+/+PiJg7kO6rL EQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 38j5qrgcjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:47:59 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHk0rO189475;
        Fri, 21 May 2021 17:47:59 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 38n4930cwe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:47:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9CF2aPmxzdCTTIh6ZfIPyJJbUAOCDzcTApnaGuWC8Of4Im3Z0yHQ9cbVCYgI5QqxWm0RDYIlhRxybcExeRjdzFtucwvmaGxN8TCUDSqMFZ0H6+j2Y+4CErc9LpHhCVeA9EBEG8s6aY43Asg9BQWsPQbtakVA1C5GRNo8DzNtatBGMNNb6tVKRkHCtKgnhQFBuK6pm+fC9WKKoCDls6DBv1PGp1IortWGCPSjhzAq3TfvLVEhFQNrwnVvDZD0utxsUM1lvDB4I3CCq1wdOuvM1XXWaIIUQ7BstkjamOiw/E/x5XW1AsLyeej5gcNKJrSr9yxuNLEYJ1eRj1GCN9QBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Zt/k07xlrLk74DYHKOvqiCkdZdXA3wugk8M/1QPmtc=;
 b=EXlm04IkReqWVoDdocdCv4GHetmHpL471X3xOi6exDRSU5/xXJ2FbIUwiQ9XlvYYqxKOKo6yHP7z3brPalomqdsBkI7i0mzN0iad0PSUAJQcmKx4gKgK8y160680Fht2S+WaqBv2axZ6WicLkdRs/AeD3fhJcG+vi6CvtxWlxsa2IqW3YWqfYEvBw91QVb75gaXbJX2sWqWEBjqJsh9t6UcC7tdATTOImMgoXpqb7rghI10NGhgttR/JSfgVq6p3aHxW4IsjFG26rr2NHYV72cP/Q1JPXltTbibY+o77elUaxy+Ag/BSDL1RVg9Hcr/G+ecHvPshNKnA2WBDNq+oOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Zt/k07xlrLk74DYHKOvqiCkdZdXA3wugk8M/1QPmtc=;
 b=gQ1oJtMxRqcOGNZBkSK823jtSZT+UWNCYEf/tUlO/BR33QDHQunJZzjGpBAca+/8BEwgSSNN0iFCah51nRZaw5KspHRg8Im9e0gNc9TTFHrpI3DxTCpCGchAOtm1G6WicgnqNpGU5SPc5hs1VTFwGZq0RLrKlsbGZ95S+lLsE3g=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:47:57 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:47:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 01/22] mm: Add vma_lookup(), update find_vma_intersection()
 comments
Thread-Topic: [PATCH v2 01/22] mm: Add vma_lookup(), update
 find_vma_intersection() comments
Thread-Index: AQHXTmluNqGdIyPonkeitHMR/AGVkg==
Date:   Fri, 21 May 2021 17:47:57 +0000
Message-ID: <20210521174745.2219620-2-Liam.Howlett@Oracle.com>
References: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7090e096-385d-45da-2d08-08d91c809187
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB446724504639556ABEB455BFFD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g0wmqNvwKeOT+MoOz7o+HwjeVRrAcEZHhyxzky9oNyf1mnXFN7gZjE+trSrEJMrLDG+UHhFFwShGyCf2Ow+QkTihjHDzJRCbm7GdwKmC4ZWZLesCA5yoPbqlQz+M6+ON3Juff81c7BCbQrHWVCWsh5UJ7nKdpWx5ej0fh53HUJsE8BxwTEVe8fXvKn+3SjEfzARtXQKUGSTByCBXLrKIJuJQiYizaIOQe8sAh3GTq6iuN0KbnyFjVOnMXgfLWqtQ7UD4cb067iDR5LPIquaYyT5twuwqAp9xG5zvwpiLG0/wYKnu7ejOPxwpnmNdp9rnLdNsbBra8CcQdNtZqwygfqbksQDjCJJtPCCmNjjlt4K+13oNaZvPwRof6MnsvlGkYnsnhnEv8bUXn8XjwR0GVn+eyOs0AiSx2Wg/U4ohcJOOvUnjyr4Y13wYmbBsP3lYeJYZ9SyRBxaYGFEPsukWg5XLj+fw1CimcK3hVy1rxQrAGbScGP1bLdKY9xPJZqXfbVlnwa6X6ZMNAoeypxcyZN7OTgN0MRKrF47t8DEY+sZXsTTgOJDsKhXJUyo4QWIxRX3rKqp4Q2MeGqRaUF160Kj/5euxEMZi6DOYU/HxFGM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?z+WQTXhCsJDbWYW1iemFNoEQAhm7UkcAUDpEUygHSpEsgUW8JLMrC8Rb4d?=
 =?iso-8859-1?Q?dq1anBIJHXynR9iS2Mj1+51IbWlSTBUSgnSvPg5wmvzE7YLEj7++lhnuHE?=
 =?iso-8859-1?Q?pDMnFJEDPof944be4XUjG3gYHsxjLe2J6vFKEeQSkOv6YUO2tFRmPp7dG6?=
 =?iso-8859-1?Q?+nrFGa8SpmrZ7um9cRpu9D7pl+HPUwtvhBLnkSvCM7T70dwz6ZP9clveo7?=
 =?iso-8859-1?Q?cCcsm/r7VUD2rFrIMBPiHShTDV+3/2y4CWtaLlDQftafFkZOjQGfHY4GL3?=
 =?iso-8859-1?Q?z+wKWUJuJ96kd3q3NbwQWnyCmyy7CQWtFUz46o9aKyCs9OXNdWrAR2n4l8?=
 =?iso-8859-1?Q?ZqjSwE8DSG2XgQukcuZdz4axReQULA2E8hx7JeQQDZeyVtjM1TPt2NcItY?=
 =?iso-8859-1?Q?vuKEIVUbHHx71TK1RrjHyCK1GQO1Jpe3sBsrF8anhGGIeTzQ2Wk1yg/OkG?=
 =?iso-8859-1?Q?lxOLgDmNVtEH58W1XYS8MOui/hFcgOKtXiG3AdUZB6N/+cePMCJxZd58+v?=
 =?iso-8859-1?Q?g6/H9Tx1Eqf34BhZJcTaGo36gpfSvVYPmP8xlc6OXjSrU1koqEx1lKh4FE?=
 =?iso-8859-1?Q?t74R14hikkze6jP8P2ESoc9emKXu0t54j8PrseZEK5Dgz4xLBSO/u8JFNw?=
 =?iso-8859-1?Q?qbI6jCOTU/yHdayTNl6FdfjezO2mVDC7x1HDga9vJJgdLFBfOEFDSz+2x2?=
 =?iso-8859-1?Q?+zTKRwBHgu5IEw3NWmaGDkQ+vKdxv72K3W7A5au4KeJ4Aa4fMWoSDgF59J?=
 =?iso-8859-1?Q?8/B9CofHTQpV1+PlIkNu+bC6v1jkTKLARB0lsAUdmpVn6dJt5/AG4DXxBj?=
 =?iso-8859-1?Q?M7jQI4lFODTVezsxYvNK9d9Ss8J5+aNLNSsXLN2Ln3nNM3Ff4CzSLGvgWB?=
 =?iso-8859-1?Q?vOt+LW6qoLNlHXRqu0VgD6Q/DmADCnFStVppdj6tN/WQAEvox0Zj8ycvf2?=
 =?iso-8859-1?Q?giOBM4/D/tYeHK4SiePcqwVzU0o8aWR1bvTfrEupnnd4X4BxL5ELEo7JXg?=
 =?iso-8859-1?Q?jj7zozcbrIXiKo3Y01frP1x+y1lygAtcerWnHEwJvZl1clUqDCf1rgeSlv?=
 =?iso-8859-1?Q?58JaUH8qaRut/vFtijyn7nKas/FNiv4ef2mM3Q2q074bFLtzVMBZYMiOvz?=
 =?iso-8859-1?Q?WT1lvdctfG1mEx1RUjemdDuE1iyJ411SuVZNjU8rMN4tBuk6g6weZvW4Rg?=
 =?iso-8859-1?Q?s/7LZa9CIqUS32MrQqVxzrXfFoXmnBd6e8oGmNMgpRBjjgKpImvkKw+wfr?=
 =?iso-8859-1?Q?1CjPLNpdtvrP4KXhGtM5MHzkSkhJLKPPeKUajl7d5U1Q6TEFL4r/9t/Y7f?=
 =?iso-8859-1?Q?ir/vQm3+zPqZS9eN+Fj+3nPCS87usf3N434sFwfgVQRVnAdMkYEV3z3HCX?=
 =?iso-8859-1?Q?3kBUMDCYQ/?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7090e096-385d-45da-2d08-08d91c809187
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:47:57.1513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wSYF06+YZhY0EN5tIRqe5mxHKsjnMr+hOU0OzYZS2pLM2lQ8A/WJ/nQdMR7SDpr/kHupVm98s+66Z3zPCuXYjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-GUID: Ocb8JM2UoBXG-WYEUwGLphNOxdPBQLRL
X-Proofpoint-ORIG-GUID: Ocb8JM2UoBXG-WYEUwGLphNOxdPBQLRL
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many places in the kernel use find_vma() to get a vma and then check the
start address of the vma to ensure the next vma was not returned.

Other places use the find_vma_intersection() call with add, addr + 1 as
the range; looking for just the vma at a specific address.

The third use of find_vma() is by developers who do not know that the
function starts searching at the provided address upwards for the next
vma.  This results in a bug that is often overlooked for a long time.

Adding the new vma_lookup() function will allow for cleaner code by
removing the find_vma() calls which check limits, making
find_vma_intersection() calls of a single address to be shorter, and
potentially reduce the incorrect uses of find_vma().

Also change find_vma_intersection() comments and declaration to be of
the correct length and add kernel documentation style comment.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 include/linux/mm.h | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 25b9041f9925..d5c443993ebe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2678,17 +2678,45 @@ extern struct vm_area_struct * find_vma(struct mm_s=
truct * mm, unsigned long add
 extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsign=
ed long addr,
 					     struct vm_area_struct **pprev);
=20
-/* Look up the first VMA which intersects the interval start_addr..end_add=
r-1,
-   NULL if none.  Assume start_addr < end_addr. */
-static inline struct vm_area_struct * find_vma_intersection(struct mm_stru=
ct * mm, unsigned long start_addr, unsigned long end_addr)
+/**
+ * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
+ * @mm: The process address space.
+ * @start_addr: The inclusive start user address.
+ * @end_addr: The exclusive end user address.
+ *
+ * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
+ * start_addr < end_addr.
+ */
+static inline
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
 {
-	struct vm_area_struct * vma =3D find_vma(mm,start_addr);
+	struct vm_area_struct *vma =3D find_vma(mm, start_addr);
=20
 	if (vma && end_addr <=3D vma->vm_start)
 		vma =3D NULL;
 	return vma;
 }
=20
+/**
+ * vma_lookup() - Find a VMA at a specific address
+ * @mm: The process address space.
+ * @addr: The user address.
+ *
+ * Return: The vm_area_struct at the given address, %NULL otherwise.
+ */
+static inline
+struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr=
)
+{
+	struct vm_area_struct *vma =3D find_vma(mm, addr);
+
+	if (vma && addr < vma->vm_start)
+		vma =3D NULL;
+
+	return vma;
+}
+
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
 {
 	unsigned long vm_start =3D vma->vm_start;
--=20
2.30.2
