Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50E03EEFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240453AbhHQPy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:54:56 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25180 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240319AbhHQPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjTpc006863;
        Tue, 17 Aug 2021 15:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=xMoMkKrfBsnL3YOtYBbEHVzcXjAo9+9gilSFGUKnQSQ=;
 b=nyJU7h/BCbUF4FHrOsbLDb6qxvfycW2jsYBZvv3wplHhJK2pkyfzaaRXLRURbcx0k06h
 Ns2lrE1QTAYuXEcb01HdHoOWa7umtkr2MAUKBpSEXmaTKSQVsU7NgwIBOH8lG8BbnoL8
 Fnx/qCEYR+zVMkCwVzJ7IYn+WkFA+eLX3WHAgYt40I2f98a5r7Ao+BwMFHHtG1jlbZnl
 //OuWtMSsSn5AvAtrCqegr3zFbIFYwaL+CSBXl7y/ZRC4io6gw5zayds7FvGooahKDbT
 TdB+mx3OQXWBWrQjhuK8MjsycMS92jikKkt3rkgwQQpNZ4irXSqLxww+0QzDUOSpAGoR aA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=xMoMkKrfBsnL3YOtYBbEHVzcXjAo9+9gilSFGUKnQSQ=;
 b=Olwlri69SNiSiIi46+gQku2mHW+C1a07Q6mjsOcd0JmQQqQd5M9ectUgx4CbijI2QTBx
 vL2NF6VCouxmv4XH4MV14RPshFiNhPtXGxwxlDFu4MB5Djar4lowF8wUFGR4qBYLq8qJ
 dsmqX/+uIi/DbleWzA4dQQAcNtoCa50yQLs4YC9zTjU4PNjFnrzEPEwZ3yW1UekrXkNB
 uBEemk59cdNfeujpCv4oFqSfzDb/z0adCvir7QckwSqwMpW516/9PuHp/59cPqm+vfRG
 vYeAxYgTL4FL8427L6wDIHiMhspsIJIOgJdNwNbiKJBR7UqHQX+ZPswE2+LN627VwJ3W tA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbc9wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmfd158706;
        Tue, 17 Aug 2021 15:48:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3ae5n7sv2h-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+3R2MZGVzGYn6bVPq7gdO9oPwVU3PjunOlHXaBaLFD+4B+59xpuRftJmwi4pE9O6mrjrLGdRGhZV/w1TLLLvmvJkEo30ksH9eExK07tB1tTWh6vRYHDk7OhHkgIDh5EdFLhFCooGizvQZpeJyapcfWO1dIf0fscXz53sQHLRnExe9671MBNjLRJLKHNWDPrHX9c2tO77rpDr330pLiBixuMbjPoIp+h9eIJIAEhP6sULABtKw5a5CkI+3cBivtsD4gx9gQFRh3dZH4tWCymw9Bt2YoAfZEuBj8VqdK/1RGvE3OIu1Pz0C2Dikdo3uYGuBWIdefWOJqs4SmzIfWkQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMoMkKrfBsnL3YOtYBbEHVzcXjAo9+9gilSFGUKnQSQ=;
 b=U5H5YrFAVFMt8XBScz6ZSZZRo9s1yXswwXUXb/tYFMx+Z4ZP4pqkunc2mqiHx/9ZG+GVu4lX3AKlPD5D7eFoGVs5jJ0lLXNbwELqLiU5MuMhqim8858gVt4tJb9TShdrZ4/vYgZWRSTLvUXwqczKEfu9coISXdpzUhi5Eq/EWiPb8dlnKksHyzpr+weRotwYojSKYbKGDO/Q+ZMlQRBRKox4NdagZC86BKwLgtATv8AF7DkW4rrvJfFiBtQv2XzBxpktRYDC2uP5N+OI7NIWQQ7IOo4VhvGDnFaW6sA1aflhZ5bb1QDeT/FDbPEiS85HKRhywpKGd4lARBj9VF5yaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMoMkKrfBsnL3YOtYBbEHVzcXjAo9+9gilSFGUKnQSQ=;
 b=BnBHeZgSQymTNNjWqKBhgHhrpYp1DyfK4ONe+hOSgUT/g1SAnlaMj6xrhN2tLNOyaKox5tVgPY2QXRgdREA/wcR9rU6tTbPeg15aF+G0wNy29zZpJ8ByvwFPVABl4kkQA2ROrj/eGPYH+w2X8kMm0oFMIvBiZ03cyf/tIimEBX8=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:56 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:56 +0000
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
Subject: [PATCH v2 48/61] mm/khugepaged: Use maple tree iterators instead of
 vma linked list
Thread-Topic: [PATCH v2 48/61] mm/khugepaged: Use maple tree iterators instead
 of vma linked list
Thread-Index: AQHXk38wFBXwC3Nkh0Sg5Ufjnr0r9w==
Date:   Tue, 17 Aug 2021 15:47:30 +0000
Message-ID: <20210817154651.1570984-49-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: f5a391d9-a5c3-481b-05ba-08d9619661e7
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3580C2FABBDEDFAB21A228A5FDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mblm/r6G/L5p9RBKIddm+kocR388UhbRwgShaEupDCIhcPJugCzdIQccmHXTxbgE4C8kKedbjMK1FvCmU/6p60mUTq7dO5nDSYCuVe3lLvmpFzaTzj67oFDSrUlvdr8jZHNYqscQ/H3soBdhxvrbepm9rGBY6ZcSqNr8dQ/qVhpLippJc0RBeDx1J/KrSDusyPNsx2HdEIxJXC8JOp0YsHy1dW+nDG1ZTh3dreZdy8mNXCzhq0nK7O0ZDXa8fMBgWDCDDH9JZ7HE9OvvH4I/UVg/lssoSuEsnTNKKPrS3Q6W1FUBrUIviRiMwVMu2YfP1jfA/bLkTA7vK5iUaF9Q130+ukqf/SIu6VCLJMNgB1EajA8vjmMX3gHSFIKf1Gyjsm2fQC0uRl5dZtz/tOaQHI0IkcKWqa+NncElw4RGHk8FR/MpfIOA6QsO8HIe8MarHDjlfcuLTEBPPmoillIeB1QiAm5ND45CBRn77KQ6USzpvgAbjh2eIB76K2Yz1rtV/sSp5GLRDYdqnRGdc6PNpK5W4ak7bKe6pul++NcuX2YhBxQgMvdfqtzN6h97rkxkivplSB7UuuLTzy+UqRAZCfLRredfek44tAI9wSf2IOzivVTD/KjjfOyoNW4pys2d03vp1bjdKJfWSULoWF7SdN2GCW358ecCD5yqKZD3syABevAjF/LLEUpACtPADuNsxUQ8L9LZmij7xFJU5qFEcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QoHIHuO3Vkge22i1gQl8RikSKmdl1KOoLhTc8x/HGc07n0TWEsxFtHqeN9?=
 =?iso-8859-1?Q?O8Rmu1Pzcbrj8kP96L+6a9Gh7EdOp0NPAkmTfuevuXIaYK6NB3BaJcVGw6?=
 =?iso-8859-1?Q?AG+j+Li5Ud2owfp33pESijFrWHks3ux8GdNXqxoCZ64wHwF33IoAOPJrJU?=
 =?iso-8859-1?Q?nRRr6QPqrt9AyFxsRQ2nFay/QjAGViwk8JG7uGEo7tYexf4Nu5ySyi+okR?=
 =?iso-8859-1?Q?LAi5SSxhYrhLpjI18VBfXXraZ6cmBHzgvnCorWFLTSwyTpFN/hcw7IGwYd?=
 =?iso-8859-1?Q?x84V9JqiuNHGuJASkKszTKFJ8vfmZDN1dMXanIrf1Rk9DouUgnieC7cFGA?=
 =?iso-8859-1?Q?PW8fu4819BHTkIm8JaKqyejrPc75PtxPHWaOj+vngfEq0bojq5FPKtMFZy?=
 =?iso-8859-1?Q?6N1HxoKvk93XDrPLoiOzKS3c30TvfIfGIez5lkBcdTlaEJXNxeDfmjDuYM?=
 =?iso-8859-1?Q?/QbXqynGBfJXoWPEvI4dd8AhfhSfYExZLWUpyj1+juWya7yowmQRNGAs8v?=
 =?iso-8859-1?Q?eA0GhO89eao+9AVEJko+AUGcF7oNpptr+nrc82eBpd+1yjYLB5pg2MkZzq?=
 =?iso-8859-1?Q?/gH2H8x4sfFNUKLLH9QRAMs9QtPj04Id2qQerycl/FaRGrHmYfF9fLRGtL?=
 =?iso-8859-1?Q?+qbWIvBF5flGjGVAclka27wF06etaN9ARwgDdy4QPQEXkuvuyQU2ii6vwL?=
 =?iso-8859-1?Q?7dJORmg9Ldk4ShX1USy5Q4wFsBGJ1ZMxpEJKjilHhp/9JFt28NLLbeY6l+?=
 =?iso-8859-1?Q?6jJvpgtHTJisdl4jBCEzhmrUULa3HPcRzNp+lEGWZ2nLlYA5I/ZECrAdZL?=
 =?iso-8859-1?Q?oytI65H55QAy2CfijcR4KWYkd0glDZ6OxgRkhBr0djnJQ0kgElZOoI/+LX?=
 =?iso-8859-1?Q?Lrpsaa1hh6pRbN7k9apZlyFrbLfUFA9kvwvTToIZCMx3j8DYgMNswll5h6?=
 =?iso-8859-1?Q?N0TmE9zXGGwLCeP4TyOl52Cf8vQlVwslRi+uUMTCNznHZDhzOOGL9so8V9?=
 =?iso-8859-1?Q?OA2c7sfwVZFCuYqKXOUzBq4ARllQFg7GLsrDbI7a5u22ev+a7IGp/6I64J?=
 =?iso-8859-1?Q?+uJQ25K1qe6S4sFD3gpnntVY8tiqk9XKqaT5ZHjnjallfa0/6DLd1CZzWt?=
 =?iso-8859-1?Q?tKYlFPHa2doizg5ZwrOdmP77X6dkBvJz60sQAMa2bZCCMNiE3Z4GHH3qSa?=
 =?iso-8859-1?Q?d0ypZ9El1lqnptYwQcwc29JhjmTwHw5e8f1FsabRVNcgzE7lOjuAK9sg5F?=
 =?iso-8859-1?Q?97UsmScZJwSc0ipPhllFDPAu5AyuJJEj2W+JjDiUwnk6uIuM1IhJeSENnq?=
 =?iso-8859-1?Q?H44jz/6Y8RUSrRKSd4/yHdhNtGRpKPc82q7muB9TS+W4KhZ5oIX3KcHINw?=
 =?iso-8859-1?Q?Zu/tqiGWsQ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a391d9-a5c3-481b-05ba-08d9619661e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:30.7852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DqY+uJWoB+8T5ZkxDCuYrY1FlCmu+ZkotWmY6iQSVLyPNHBGWkTbj1/TcYh0xSugXmErwovdeu2vEBzG75z0Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: 7cUPylSETqauLao6HIhmZhT_Q_BRwSUo
X-Proofpoint-GUID: 7cUPylSETqauLao6HIhmZhT_Q_BRwSUo
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
index ade81c123d87..b36bea1d5b5d 100644
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
index 3a43610141bb..27b7f3521d9c 100644
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
