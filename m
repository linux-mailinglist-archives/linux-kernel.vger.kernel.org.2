Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AAC4421C02
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhJEBf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:35:26 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42486 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232132AbhJEBdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:52 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19511ntr024407;
        Tue, 5 Oct 2021 01:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7RQxd5oBQBJfo1W8DAg1OQig4qk7huO3fJPf1UbRp3o=;
 b=QKGXyGDiKWcpwqWEALhxqOP1jfEBJgosuHn9As6rW1UrHVU0NqyYS0dhSWEWkcgAWv4b
 kHqOds5iAbEl7BD4wpNRE+n1D+ZvBNQgAo0rPueY67fRdiN80VGJlEnXRCVR7U11xB+E
 BaJEFMOjSL9WjQqQ4sC5hgEP+bauJ8DlerKRm7cT8nGs2+KvB0k555hDUVB3ZS0zLGPY
 pe4qLhk0+AvC0gLPl02tFPyYp9CbZPOYfczyp38Op0buEODT6Jy/ZB1rWHNJ4sneqyF/
 7rTBpQWYMYXBh0glrVj9LIwKkQLmuOmSydLjl5iGFHSUy/5/JTV5cgIQo7+0x0QzEmg7 AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg454bvpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHTQ178361;
        Tue, 5 Oct 2021 01:31:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3bev8w0386-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8uBCvS20Lp+tVNofOtUuIPxRA4+Fp58KRi2aBVjcre04pU9KBI7HTRgFJ1r61Bz+C25va4pTmMmfZ2rIzLy/NcwU4/pjgv810dftAnpLmyEx//dvWPLR+o5D3eZ3oovPLU8A+/v756WfCLfA9go5bl9b7Lqoqqcyf1cDbX3Gk/T9y0dod3Cj59+GLoDn6UzeDRB0nQPbJEYTHJHdb/9ZeiJb7z2wZdLtC8WwFdvh2NF8x1Q7oHf5lQNfMxo/GUnf1DjBvWmQ7KxsxnyEBfFzmkZ6Yek+GxxplSQeJ0PSowUYU3NhWoRYsXFtoHpEdsUHdIrmReuHnEBlOlkb0wqVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RQxd5oBQBJfo1W8DAg1OQig4qk7huO3fJPf1UbRp3o=;
 b=gE207cM3EeB49WyqT7H5rG1aOe666RrUgSyJqXjjQPXi+jAgzg5okI1tqmgXJigMMoH7bejY/voSR5Odemm/urG8X0jyEluEUUk63B1iYnN6m6CL5dpuyfJVK+18rCCCbMtaK+VProebvXhm0nvywYM0BrnV5DpQvhL2E33+k2W5549zbFzr0X4Pto40hrJpsFQoq7vn3UtMZ1YD6njgvzEYCkpsgPAzEjBAjvGkIxlJrfoA9h107HPf/TU9nFhwsUR8MUgteqc678nCljCY5zMMImFnZz7Zis+tvp+4kwOLqv+SQbeqa0Ho7yTI0VmKbLrftLM2oJXeKB3DnDeieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7RQxd5oBQBJfo1W8DAg1OQig4qk7huO3fJPf1UbRp3o=;
 b=mOR72/5onrKJh/Ulu9FTzhPK3qdWbGUvgYT7Elv2O4kPLJGUlLkk6nuSXJFjXFW8faDfp8DtgYJwDdQo9/UtcXe9GvqZGT3FBij/uu6oKxf4eEJzZjb9PE2bNyY14BcDAVrPEry+vTR+SexY1HabWjuKkcvH9OGKsOyduUGvDmg=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:24 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:24 +0000
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
Subject: [PATCH v3 49/66] mm/khugepaged: Use maple tree iterators instead of
 vma linked list
Thread-Topic: [PATCH v3 49/66] mm/khugepaged: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHXuYiqbb8aJQuDAUq6Brf8+kASEA==
Date:   Tue, 5 Oct 2021 01:31:05 +0000
Message-ID: <20211005012959.1110504-50-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 22f54e8d-7880-4058-90f3-08d9879fd837
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044BEB3E7EDF3D2C70C23ADFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OpD7RMyeHMW44OK66LKP/vLWFhzFivqe9UUtExy1CriKbOIX9KjbbhJ+3mvQFrdij+4W3j5BbGPcUd5MCQN62chV5zRsEr9/raE4JSd/6ji2YZ8eFUfqm0/KrZNgAmqrGC6h95bJdMko5Kl/lyQ/MXr4mfdCHPFaxu30VQau2eTmLqj+SnGOwv9SfMVdWPEoDhNJl5vKND34kzHozcgNkk3/SKgEBVAFjHORMTXBc5BV/59pFK9buqmrbOXO8pMjmGayBWOc9fvAczrCskUtpKAZCizzH/BftDf+aP/vpa+96yStTPnzviA7T/fveoi1QWu6V/5/bIZWfqnivpIKBd79zmFJcw9HuM71np0jbLoVpEikTfRmKjyWi4b37PyDgnMoIcD3U8Z4NEmbDzyI8npiqXaEdu23oK3t/LEf+Mz3yL/nSL8hZGWtwmx9Vg/ByZ6uN3nqK46G4Do+OXLpiWCyfAhfl+i8n/vjmdv9eZeUi7+T7kLQZGgFhcXs277RGf8MFFTgBkInA03sSIGr4r7fYhplzxtFXd534jLu+4FZXjvzNCXJUI6du2Feml/Tqb+r5R5mEQiMcma1qVOG2iV+ksHcEAepeqVYBCXOdUvj5CUtbkm7GS1iEHxa9ncNYT/uc3bVNYBQ0brrMzcMjmQd2FTPjmsnobpDf1yllmJPO5/YuvrjMgQ3tRph2UWyZL2mdLObqVdAbf+Q8tmfrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?i06RrTvthLvC2soFezLzPDUJgwl7DxwvEwOsvPk0qXHd+hgTV0IGLOsRXW?=
 =?iso-8859-1?Q?WljFJLoaujJIO/8VQpri8mB7r+J7UpPkAkeod1A8gOEj9gnPjl3T57EKA/?=
 =?iso-8859-1?Q?M0hW/HDMiyrUh4+Bq7m5CqRDHGYivvZpPfgM9hYhvwbTJgWn2XTuMLUxM6?=
 =?iso-8859-1?Q?Jhe3WANEjFyL9qM18mNeF9PyjiiUtiLJJGkmTnlqb4/8BGpA6X/HsbsAjo?=
 =?iso-8859-1?Q?Wnb8AI1Eac6PXwkRc+PW8pnOlAC4+lEuEnWM51NiNwgyyZCh0vhMyX8Lq3?=
 =?iso-8859-1?Q?PdFhbxg3/jBSDyZwpstngrCxdcwE2us5ONVn3LfGh9CLZSKbCD16iboId7?=
 =?iso-8859-1?Q?Phhu8jdTqnR3CbeIoV6FOl4QEGUObyy6SMMzAnqv80BTxt6EN/5jfQ1Fc/?=
 =?iso-8859-1?Q?FhSzLa8AoyVvtnMB9gk/uVFkKiGhKcofP5WDgJcgwDJaXh1Ii3ZEK/5Skf?=
 =?iso-8859-1?Q?X1D1L1AifEQdHFvYOj1Wr69ORm1Ra2g1SjetEGk4tXYKQLWd/Q8F6Am+QU?=
 =?iso-8859-1?Q?L9W4XK15n/G6mUKr0LW9oxYmSpuhGag+n5xxB7YOX6vBfe/adTqU9YHvgS?=
 =?iso-8859-1?Q?uS8MrCZChLSW5914+92S5bCaR4oIVXDD5rlWFQIPRoSZ5IulFNBhz3ujtm?=
 =?iso-8859-1?Q?dMoE85mWjJuD9u7ftEc/4BnfNnqdLCmP9DPkOxT1Po/2thoouqrxR3VCca?=
 =?iso-8859-1?Q?/FKXt+t27FMHUuoOl8SJntN/Ke8w6rNBvU/p+zWvyawjEKiLwtUt0RMAPW?=
 =?iso-8859-1?Q?3ceeEqUpUfIcgznTAu+UzXgP0ahbEfeSuV1+78q3nKD7siWqSHWokoh732?=
 =?iso-8859-1?Q?HrqeYAeWhBrhB4ZBCYOpesGpEJMNYBv99wC15pyFqzFClSd8b1xALRVxoT?=
 =?iso-8859-1?Q?aD1Uz+XY1i69IiEiOHik3B5lJKSX4EDI5k+WKISbY56YKAovGNou7sGj6x?=
 =?iso-8859-1?Q?9/A+okpzvgmuA1dDxEzsXFBvzIniAgK1NzMpOwVku5IobZgKQ2f9scngjH?=
 =?iso-8859-1?Q?o4UDkzFkbTt+vJVBPvQRQYpeDOzqKBRw2+dL7sx6H1COndSPRaQaNq5FXy?=
 =?iso-8859-1?Q?ApSsG2hEc8d0sobB72ILUxSbvFmk2WK2cM/Tld7ydF8Bjrza+cX/KHRzAA?=
 =?iso-8859-1?Q?07X5WdI90R26HnE1/qwweNo80Uw5cSPxTjyKU76f0dTR/Kjl9qf/z5NZsB?=
 =?iso-8859-1?Q?kkmzCRscaShRkEgu9/L4kwxQduGywWFm7RIW/Mw8GqDz0IX/Dfi3g/MdQK?=
 =?iso-8859-1?Q?svpaaJgQKKgIw/h8PtzHql6FZErmIrGvtqvaBwVSb1ng8EUFkKLtK/h7PJ?=
 =?iso-8859-1?Q?pZxcIxvD2G69xTcQndLY3nGQJAPUty+2z1ren4RUybi35k2IDtB7YENvQH?=
 =?iso-8859-1?Q?f5mszyXiNJ?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f54e8d-7880-4058-90f3-08d9879fd837
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:05.2146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZqjZK33jq4WshMpqurvyaUlZJ1gmtnV3uyWfnA3/nuuKSPfSuTH9rX165l0zK8+5hA7QIv4KTVSCqvUYJCPQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: WX8Wh7qqlu3iXTweKR_B_oYyZx7pijuQ
X-Proofpoint-ORIG-GUID: WX8Wh7qqlu3iXTweKR_B_oYyZx7pijuQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/huge_memory.c | 4 ++--
 mm/khugepaged.c  | 9 ++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5e9ef0fc261e..8595111ca0cc 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2270,11 +2270,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
 	split_huge_pmd_if_needed(vma, end);
=20
 	/*
-	 * If we're also updating the vma->vm_next->vm_start,
+	 * If we're also updating the vma_next(vma)->vm_start,
 	 * check if we need to split it.
 	 */
 	if (adjust_next > 0) {
-		struct vm_area_struct *next =3D vma->vm_next;
+		struct vm_area_struct *next =3D vma_next(vma->vm_mm, vma);
 		unsigned long nstart =3D next->vm_start;
 		nstart +=3D adjust_next;
 		split_huge_pmd_if_needed(next, nstart);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index f27673c596d2..c1ee32fc0d2e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2075,6 +2075,7 @@ static unsigned int khugepaged_scan_mm_slot(unsigned =
int pages,
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int progress =3D 0;
+	unsigned long address;
=20
 	VM_BUG_ON(!pages);
 	lockdep_assert_held(&khugepaged_mm_lock);
@@ -2098,11 +2099,13 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	vma =3D NULL;
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
-	if (likely(!khugepaged_test_exit(mm)))
-		vma =3D find_vma(mm, khugepaged_scan.address);
=20
 	progress++;
-	for (; vma; vma =3D vma->vm_next) {
+	if (unlikely(khugepaged_test_exit(mm)))
+		goto breakouterloop_mmap_lock;
+
+	address =3D khugepaged_scan.address;
+	mt_for_each(&mm->mm_mt, vma, address, ULONG_MAX) {
 		unsigned long hstart, hend;
=20
 		cond_resched();
--=20
2.30.2
