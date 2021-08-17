Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15E663EEF71
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240402AbhHQPt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:49:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26734 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240218AbhHQPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:30 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkqV7017407;
        Tue, 17 Aug 2021 15:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0YeMSWDIUIKFKCmJyviNNBHDfAcPQSxe/5U/yQ2I61A=;
 b=l8GMZRjh0ows8YQSTLmjlAHS/nEKr6U5id/MIJkG/LARFPJ9OnGcjAB/OPEnhOcMN9U8
 u14XByHWsTS/mJ+qk2LfdmK967bNuG4FHZytsNJqrbwwSVOlY/+gd03oWQQ3+92CcJL4
 i6NwzCh+bd0oJ5x6YRChKt5wl7X7zZXliQeAkT7czk6GVRGhj+xAHajwoOrN1GmDRypc
 cLdEnUmeM/8kUyoX37+5bLLD7CZo/wzTJy5kpkdIC+e2D7+xoZ7oWX0mrVot29YlXl4F
 R4Fs7iLwhrt3xKKiWqwkih1wWbuxtpYPdNzHwCW5Bbji+wiP6E7IUb/BEGICCjSBx7kd CQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=0YeMSWDIUIKFKCmJyviNNBHDfAcPQSxe/5U/yQ2I61A=;
 b=WBYXUKT7YB4ovfQ/QF+tuAyFpzfE6ZHU29EoGoXIRI5lLdje/6ijVqxriJYbs2aiMDgp
 J25w3lzwiqQqlgC1Wc29eqOn2OL1nIxws7pg6uuBvjmGH7fT0vfr87vNhH91WfBARoIv
 8nTYzNu38dpSubMRgi51xhxTwsjjmQQJ7Q59WDpQxRlIMUTPBrkbrd+aUgpc7R9MoMDu
 VgSMX1aHsSwiLoUK28VV7idcAN374bwHGKlIg03VLrghkjcHqE7p95LIiA+P3gcW8wlt
 U4hxdPpNDzHV9I/hHYzaiQ66xwqhk9EAASINhZBsWqzNCvtXgiIemabjDKCaoEGkt8Kb vQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf0g4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmf7158706;
        Tue, 17 Aug 2021 15:47:19 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3ae5n7styr-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BgIVQ+26qHVL3hkikgPUSOSFcdHOBnjB+vgRfd0XLIf+aF1THxN0LYnV3bplQLWxxstHQFoEz2K6lAoeVlhPejsPYyoZ3gdGfP5nq92VFmWu7Y67on2XNDVvjc0OnKdEQsFwH7r6QyfN8JCWdccHxHeYzraTzzHXrI4Mn/YKVxXYuikBub4W2wf7XCppWiYhrz/kLZtSZuo+NFvDRE/+qUrN63Z279QDCGrndZypOOgElVUcRvMJBuvEaDwc6EiXE7016ZjyOZSYof4XZvDFoIYcnwF8A+fFwHCYYpzND7Z1LyJfpIjMTCpNU8cDY90NzW8OuO/zBqo3BkMA3bs1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YeMSWDIUIKFKCmJyviNNBHDfAcPQSxe/5U/yQ2I61A=;
 b=AbHXHXHJIK8AJWWqUQLjI1LHy5OYDoxY1G2y75oWJ7I0fDf4hy5U5+MrWagc16CFiwaBOWebDwBP/qcxza6onLedhUH7+C665Zs+2v1918YIY6qP75RPON+g28LJ9KRq8eVvmV2StQ3CfK4gsr26lcVMwYD5LpMuNHcCbLFJaEjMTZvoHPsYPBHhcLPvGoAa68lUa0S49kqXbFcNqgb8HF/4cwLQOq84oqCLh38Gq1iwRYbPrADzsSFJ4hTegqK1lMPeIciwTPCM1tD4umdGGB+zJFk0JPxz+X1WN9MVVPa3Q1cdi+sTyMG4uum5dajrxz27Y2xsRE6VENFJkImZ6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YeMSWDIUIKFKCmJyviNNBHDfAcPQSxe/5U/yQ2I61A=;
 b=NzZ8/uMwl4vid2aRCF2eIvfPHvnwPFXyXMNU+pVFZ7HKkG0ueaRpTe085QrzTW2/LYxhYCkugQ3mbX7VG3CNLjbd3smQ9MvERCPij2ElpT9TQBO5nTc5uYkgOH5xmurOrxUEm5JMYJNaVCgyFALEyJjgdsnhHp4tXIavru367BM=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:18 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:18 +0000
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
Subject: [PATCH v2 20/61] mm/mmap: Convert count_vma_pages_range() to use
 ma_state
Thread-Topic: [PATCH v2 20/61] mm/mmap: Convert count_vma_pages_range() to use
 ma_state
Thread-Index: AQHXk38otw3+ENZNikW91sSGqLrd2A==
Date:   Tue, 17 Aug 2021 15:47:18 +0000
Message-ID: <20210817154651.1570984-21-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 0c3f6a2a-9fe2-4356-f1b9-08d961964b1f
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB42362846B3D75A3B1170CF09FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DjXItX0NnMsh5US8ZAap0xmtTtZFR1c/Fivp3NLl51tvOqsfNZI8YfCzOY1umDnNQYcmrOAycj/hcpvOCPXXB0EyG4zmSQQp/7OMa/d43el2NennURI8QumLnCE04RnlUQyN20et6Pf78v4aeytMXRANbgk/ZcvBtiX9SG9O9byz2ZZGj31RTVf2yFCS/oqfVkz/ZM8RPs7hI6JS0B5Ioa3AgA+G3J852KMzK+CPZjq63HBfopXe5JFnZD/YGmX0/mjkHrQv0fN/LEA/1sonDd/mKxcX2JOA59IvFF8Mk4bDbhfat9iiu33Q5G/jhkXNJnaTeLM7Rv55hpnSR8HyMgp2yLmJrPwCkefeANDg//jHRMkh+SalEku+1nUUt4WqNR/QZ4hvWjzGhS+pqKkiG3sF3CsCB1hyRiel2YNJfqVKZ3YEy4KUAJsFXP01Ie1sdbGDj8bxA5UjKu+z9NXtM3W8s5QhCIARwPQMhmwVNj1Bp/VvGk14P/4592mSkC0R8HXi5X2QpF7Q4YMs0o4o05H6Xpdk14NikSvvr005sx/0YWzmqvNgIUGsGVEQSb8F18O381JqRlFOHVxpxXKUBkoO6CRFktHDR7yAaSeOuvI0hmS1I9u24UeVtXtnSpTPmaLUQPwEYOmlj34Qbfz7h+HUugWFh1qXkfFAr4uUGKaFwN/oRzkS+uTVbYFccjGdIBOKrEJDfs8sAyvCG0IkQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0Noj57QrkBYCUK3cmRDTD2o2HJUfQQRThslP/uO6m4iYXWdyRoKYcq39h9?=
 =?iso-8859-1?Q?Preb2LtO1L6yTwwHJLkyEKOstE6HscBiOBEfzMK89wahAMggm95dYRPxmL?=
 =?iso-8859-1?Q?9KYKaB5o8aNqHSmxJYnI9qaNGf/2Y0xawZz9vTeNJfh3OsByK2ofW6GMat?=
 =?iso-8859-1?Q?zebNFbgdxIskTA0XQ1YhUQP3M3bdJ3JZbcG6YoOFSVr4PTv2ogYe84fnT6?=
 =?iso-8859-1?Q?b9sOPxxbPr9dd/WsXsSzV+8DfhjxCL+/MeBIqti6LHkGYaXZw/M5rkSmk5?=
 =?iso-8859-1?Q?vu2ywq1x0HdbNy4KeRBlXkDWWOyoqxvDPzEaIc/C4WEtO4C+CmmESDmI9+?=
 =?iso-8859-1?Q?daBLNtdZ4X1qbLHvfljTQbI5UpokLLbB4siAan7YYD/6efaLsksRRobnhn?=
 =?iso-8859-1?Q?pwf671cgWftIbAJL2x63GQso9ZysV/30t24Y22xaPc0qHX2YXOW8WyMd/5?=
 =?iso-8859-1?Q?Qqq60YzvXEHlj8Bp3ilmL9St6fEW4Y94nIwIEV5cpMUB4Ltju9wwidDq6X?=
 =?iso-8859-1?Q?69pPcr0jpRChj1jKFelm6RFSc1k8nEpSVV1xBLS0qofk+fotQqi5UoxUEb?=
 =?iso-8859-1?Q?Kx2qSPuR7TQTTIb+xekGEkZdo3DaPiR9lUMZRvdiZ76Em4/7siW3/dEHMV?=
 =?iso-8859-1?Q?hh+Wc1bY2b3frKj4iQVVLBZ7fkBQSDXQrx77/qV3bsqyFeVCaSq7L7rAg8?=
 =?iso-8859-1?Q?Dlah7k1XqRuDGZhXwEfkKdoYH89uAQYxklP1cVhmeUppygu3+poFnCLBlr?=
 =?iso-8859-1?Q?/7J1Ch9Fr40CKJfohTdNcXGYm+LtfdQRIAuQx1kEuo2ebHPG325jGIql7q?=
 =?iso-8859-1?Q?wxPmKr9UYDX2KnY0ohfMa0SwZetPYt3mkqeIZ9gb2D1q8lBZU0px1yyQyv?=
 =?iso-8859-1?Q?FqwRjRrgVr67c0P1pehdoKAvb54GlFOkP2XuDjOCyElkxiFfOdylAthNEx?=
 =?iso-8859-1?Q?w2nLE07kSyYhm9nOxazsoirnn695TMV2u2YTM7gXa8bM+g6tDXzk+2yqtP?=
 =?iso-8859-1?Q?PaYgxQQvYOqODJRS/1shujSkBJ5nHLqG1avCR5xeU3tdk73DDm3y3sB6yu?=
 =?iso-8859-1?Q?vPoGqpMKmqR3OHjt5NBo6ZunYgsWW60D9gyuLNxqbNzeCatSTyWyhsrAFp?=
 =?iso-8859-1?Q?Tbsgd2hquU+AP/0IOoZ51EhLnMOeiHiTdj8uO5h8J2UoKyQF+R1ywQVxqM?=
 =?iso-8859-1?Q?qlNvzRcR1PXjO1KNF42Y7uSk6V893Rv/D7+7cg8fBIzKZzmjN2WPCGwZ+1?=
 =?iso-8859-1?Q?85M1XCqbmIu+Nv7Uob5175MC2zThx3crtJHDKruAK9HmHd+c9lT41lYOI/?=
 =?iso-8859-1?Q?dIz1J9z5l4BNK3aMEj84qHjo8VdedoHQFncYq6/yTmXYmtbsrBJ9YvL8PD?=
 =?iso-8859-1?Q?9N+FLfa0wy?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3f6a2a-9fe2-4356-f1b9-08d961964b1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:18.1555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LgUu9mQXbFuB3NCM6thGWmkDK+DoIKzDOKzKJxgm62n2WKuOQkKZpwBQUk9jDkqB4vsO6+2Gr/bNEjGZMwW5+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: PfcXh7C0WchLdWyyY-n8wcPYogy3Hvkp
X-Proofpoint-ORIG-GUID: PfcXh7C0WchLdWyyY-n8wcPYogy3Hvkp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

mmap_region() uses a maple state to do all the work so convert the
static inline count_vma_pages_range() to use the same structure.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ef618dfd1d94..d01659a64b86 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -502,30 +502,41 @@ static inline struct vm_area_struct *vma_next(struct =
mm_struct *mm,
 	return vma->vm_next;
 }
=20
-static unsigned long count_vma_pages_range(struct mm_struct *mm,
-		unsigned long addr, unsigned long end)
+/*
+ * count_vma_pages_range() - Count the number of pages in a range.
+ * @mas: The maple state
+ *
+ * The start and end address are in the @mas
+ * @mas must be locked.
+ */
+static unsigned long count_vma_pages_range(struct ma_state *mas)
 {
 	unsigned long nr_pages =3D 0;
 	struct vm_area_struct *vma;
 	unsigned long vm_start, vm_end;
-	MA_STATE(mas, &mm->mm_mt, addr, addr);
+	unsigned long end =3D mas->last;
+	unsigned long addr =3D mas->index;
+	struct ma_state ma_count =3D *mas;
=20
+	rcu_read_lock();
 	/* Find first overlapping mapping */
-	vma =3D mas_find(&mas, end - 1);
+	vma =3D mas_find(&ma_count, end);
 	if (!vma)
-		return 0;
+		goto unlock;
=20
 	vm_start =3D vma->vm_start;
 	vm_end =3D vma->vm_end;
-	nr_pages =3D (min(end, vm_end) - max(addr, vm_start)) >> PAGE_SHIFT;
+	nr_pages =3D (min(end + 1, vm_end) - max(addr, vm_start)) >> PAGE_SHIFT;
=20
 	/* Iterate over the rest of the overlaps */
-	mas_for_each(&mas, vma, end) {
+	mas_for_each(&ma_count, vma, end) {
 		vm_start =3D vma->vm_start;
 		vm_end =3D vma->vm_end;
 		nr_pages +=3D (min(end, vm_end) - vm_start) >> PAGE_SHIFT;
 	}
=20
+unlock:
+	rcu_read_unlock();
 	return nr_pages;
 }
=20
@@ -2607,7 +2618,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 		 * MAP_FIXED may remove pages of mappings that intersects with
 		 * requested mapping. Account for the pages it would unmap.
 		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, end);
+		nr_pages =3D count_vma_pages_range(&mas);
=20
 		if (!may_expand_vm(mm, vm_flags,
 					(len >> PAGE_SHIFT) - nr_pages))
--=20
2.30.2
