Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F49421C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbhJEBgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:36:15 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20988 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232496AbhJEBeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:06 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19508Mdk004481;
        Tue, 5 Oct 2021 01:31:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Q5RRnx4kDiaiz6YdhseFw7tFky7FbtfsPONk6dubH/o=;
 b=fWFhVno8GheTIpJftOmOz6bc3HZsawumAmtsqyuxbJBaQO3R76CYC1GtXqfjoXtTqWwK
 f7KslVeYUE/h7GMXwqtPbnC8fiE5KspzSYZkl5bty6FSvTb4magyJYgI9fWOj9Jvyfdg
 PyV6H5WLLYsZRfoEXwKxCm9FRNNBTuWHMEj3v7SildtKVcMpLDgpmp8NfFRBrLq05QNg
 V0hyVAZSaHVGHZVMKDdio/ivfXvT4UvIia13hKM2fwxFu749dB3cm3xkFIhQHpHXqSYY
 qtHTRa4cXHQFqqF7wAHHKUGR8S5cJ+8I3fjSSlfbYBQruu4g1mF3PJTAzY/lBh4yDiCJ /g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:30 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdGK141634;
        Tue, 5 Oct 2021 01:30:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3020.oracle.com with ESMTP id 3bf16s9dx1-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zg1qS66tueqRl81yg3/ObBCK+eTP/3zv1AQUh+Jh5iHqgVR4je62ppysxYo40BLGSrj7JlyD1pKq4E8ia0eQygSuG911Bw5SJh4It+IroVkNDedXH+zuQEzpLiqa31Tigl4+8HacbZ3RJyffwH9Auszj+AiLgv1aVLxtWDt2dwbLRZX6YW+mjDWeSuTiXDy+uqq6pY9S6oMTzGDTYm6HyH82pWFT9mVow226cigtuws/5bsDklv/FDQdO6fEP9uKaCNsPoNK+S1P9MSGT/TilrJ3CmEb2RHHfqKDSZNZWwZNiurs1F8HepJX50es1KPTSiV4TpNId9HoTR6SJAw/yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5RRnx4kDiaiz6YdhseFw7tFky7FbtfsPONk6dubH/o=;
 b=W4F0Wll9EnZowiBvosWToGUFUTTzUNlo5rHlV7mL8qt60ztPHL2bJs7ev+2vioJswR7YdXPX/AEKfnHAtlQt1moHbFSjqYLq9CegUDGONfZ/AEb0RFe/I/xjnhWbesPOXKdPg330NREz4HpMh/i3FVXvv3z706YRfo675uz7Agr6/ay0kenHAPyFuOZ3llhqLEOlou6Rpjb3OrvC8G1ZkKrKleKnOdWdydWoqn5R8e0l9ZWgpKwpIlgVKrT6nNW75koH6kuq494q8qlKQQnk3Lun6ikLxsm3jIPHKxJiU/SjN81zADFn3fzPpxIqovqzuLvr5DyAZey66UFDpr4gFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5RRnx4kDiaiz6YdhseFw7tFky7FbtfsPONk6dubH/o=;
 b=c+ePTyqpSeY8GzAI9soSCsuj0qGJ3piVL4hulLPwad9sEDcK82UwDpqgiS1anDmub5i0a+OurQ808EKOZCQaOjPrQRlVaHeBNiQVYXBvjY2JtLXVTofMh6Szn0+xOTLgMKH7/Hqe1Cv31nESbkHIIA3dR+wnH5m4ba/JidAyfpc=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:44 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:44 +0000
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
Subject: [PATCH v3 20/66] mm/mmap: Move mmap_region() below do_munmap()
Thread-Topic: [PATCH v3 20/66] mm/mmap: Move mmap_region() below do_munmap()
Thread-Index: AQHXuYidQQNJUAlBD0K38O5L3+pb0A==
Date:   Tue, 5 Oct 2021 01:30:44 +0000
Message-ID: <20211005012959.1110504-21-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: be095121-4ab4-417b-9224-08d9879fc06f
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50449DD4B8451548CE403875FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J5RRUNfa15gjZHq/SlKrGzyvE00+zyih7dgRWLTq2OQU2S4WrH09VKNDBxL+k5lZ8maUGpB2IRoPrm/IOZZPMElTBn0ejHhaz22RpXlidueiaZ3uDZTT0HY9g56b2hg2MyYr0ljEGgWpaPPFNLdCPVsl9BywYSMTzwh/P+bADTvTnu3jfMvivnuHxiXynFa5sEkecG35zssH1Mbk8DrVx+B3jFPGoxDF+OQzQ1ozEwdTQczK4oqbSBOQkYGmlppjXM6EM8UjTDWegnjyLkkr3AseRj2rhZvVjvrUh3eBhESB+i2sRDU0Yy1//aHGnBqo7MjJe7M8Y082OszBWb998q1faGX+CU1kEcMzMxE+ND0dMY2H/5sEUKI3IjFO5L4JiPZ4b9jmN5O3AuI3SEziaFdh4xSga5FdN/at2vLpYjiM2gdHmRRDaAAeux2MVpcIhxKHXsrvXeRISIJ067cuDYCMEnXLU9RH8soNFNUY+AMmzGPQLLVg583wuwXo7Fb/+xXSteqFUVxqtp/ZD3buQaz7QWSLQ12QCUM806wG2HzzG2WkLfqYDCFBoxhIHqBoanP2mfWzjuAitHkoYlYOu5lFM34+IwZyum31dyyE34YLzJovvZhbpDgvzj4IWXRQp9sTYwMowwpCq92H+bk8ko7zr/8IuzttL2Znf5/7bMp4VFWehXki1IP+wJW24d3ULcXR/PdM0+FjuDaYkUuYGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(6506007)(36756003)(30864003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/CJhzOve5y2WnafZD9EX47cJhwsL+Rhj28llQUU3mQSpvCwLCFK8S2uiYM?=
 =?iso-8859-1?Q?S/q0tjtR64z5jrjtOYOPqJLFYx0DkPxXz5iCl7+KfARd+i35sngYXZL2hD?=
 =?iso-8859-1?Q?V8fSMiEU24YKsZ0/xagfqscRXjZoVqOqGMa4KZPEQEj12ZqhicocQELQDw?=
 =?iso-8859-1?Q?M+j+24qbxQTMd6vHnOuNNrZrCvXmLHh9vygJ/cCkB7DZC7QJftH6RA7ioZ?=
 =?iso-8859-1?Q?qF3HkFDgjygjfG2slg3toalxWcsom5fAahB9Ns5Es1b2vDG92r8obqNhMC?=
 =?iso-8859-1?Q?IEbTj3eIdYDg2/CtvVOEwd2G/KDs4/Z69Lf/vu14IRTAOJ9wWXHq+1RNs6?=
 =?iso-8859-1?Q?cH1vey/R4WHQlDXvJjyK6QdtPTRSf30oEuWL4yupvDUAI45Ddc9KkNt4p0?=
 =?iso-8859-1?Q?2psfKgaCTPG9s4dKIn9DGsNMCU8QzfUhZtdgq83PWecKM3guPEPapQ0FUx?=
 =?iso-8859-1?Q?JsgxrN1Hy9+qxtXH75Sr6TrGatgp8WGzz0Z/P2ORW8VUrQ2hum2JFkqlq5?=
 =?iso-8859-1?Q?16/8DxGZEU5L3vutc2Xle96V+4KcxJyV7QMJVbdTcKqLBN99L9r3BCNy92?=
 =?iso-8859-1?Q?eTtBCQ6HsQ267Zd6oSh9NDqGKznFaLWQzjCSHqLJTz0uKIQchYvO16nUdw?=
 =?iso-8859-1?Q?MsEZ5hb9WhIMoFneLX1FvjhGmHWTolIT8iWG8UTcx1OWuhQWxEdYcMxK+E?=
 =?iso-8859-1?Q?5GW+jAej2JTGrNp8RJI+4rgrQD8vVV1YN9L1VyHlhSxN4N1OEtDKLHlDYe?=
 =?iso-8859-1?Q?ZJ22UEuHwMPrdfHRwS2zJfSeTFe8rdPotV1YOLCk78kgZxUfIFDJHLh3uB?=
 =?iso-8859-1?Q?VdJN5Ks2nScC8b6p3PDQifkWEOMBzFbWK/J0vRT6amGFj1lettoDr1RUYy?=
 =?iso-8859-1?Q?vMLi8FEgCH5Pm5rfS85nbZCl4k3NYpzBNongE7jCTs6Ev4nYCbMf6PTK6Y?=
 =?iso-8859-1?Q?A2CPk7Ly3Wo4cVFB4ueNiQI7A2IQ9BkjtcSEVl6huF6Uon4pVhOLViRwcB?=
 =?iso-8859-1?Q?7K1ZQwM+fX7+5LCUGmHCJdzQ+9i7lR6GbhSMao34FOjR9iuygCWVSnTcAJ?=
 =?iso-8859-1?Q?m00l9nNaA+dy6OET1ATS6+l3i4d04ZW2XeJJNu1fh0xqLr0YdDf06DGZ2c?=
 =?iso-8859-1?Q?kQoTMvRYO8RkzXPmqRLiTZjdRTh3Ld5fZlIwSphGDcU9m/TJN3Y9DvGatd?=
 =?iso-8859-1?Q?a4Nl9g/CobXPCgS0VNRuFi5rWw9ysEr80jFzlLVvr7aGhZs8Kb7KyUvABP?=
 =?iso-8859-1?Q?AFQU1H7kmBZHZQV4aG61d+sG6FhOd0e7rQMhyCM27OWFB/hkX5XUcUide5?=
 =?iso-8859-1?Q?quMgFtWg+ZD1ySvNjAEhyLrN/Q7mW2XY+ANce+fKHYZpdNzdYEGKAVQ0aS?=
 =?iso-8859-1?Q?qYni9/rNyi?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be095121-4ab4-417b-9224-08d9879fc06f
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:44.6573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R04mT+L4CaO8YkpmZC5O3NvYexLpss1Cr4911hoaD4vnKb79w0oWv6SYQ2rfwJyAEcP+ZwHHZWK6IE8kfNxf2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-GUID: _yd29CpS1OWwOVFWf4HG3cEjDrIWVVrf
X-Proofpoint-ORIG-GUID: _yd29CpS1OWwOVFWf4HG3cEjDrIWVVrf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Relocation of code for the next commit.  There should be no changes
here.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 450 +++++++++++++++++++++++++++---------------------------
 1 file changed, 225 insertions(+), 225 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d6c42f416de2..54838406518d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1712,231 +1712,6 @@ static inline int accountable_mapping(struct file *=
file, vm_flags_t vm_flags)
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) =3D=3D VM_WRITE=
;
 }
=20
-unsigned long mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
-{
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	struct vm_area_struct *prev, *next;
-	pgoff_t pglen =3D len >> PAGE_SHIFT;
-	unsigned long charged =3D 0;
-	unsigned long end =3D addr + len;
-	unsigned long merge_start =3D addr, merge_end =3D end;
-	pgoff_t vm_pgoff;
-	int error;
-	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
-
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
-
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
-
-	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
-		return -ENOMEM;
-
-	/*
-	 * Private writable mapping: check memory availability
-	 */
-	if (accountable_mapping(file, vm_flags)) {
-		charged =3D len >> PAGE_SHIFT;
-		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
-		vm_flags |=3D VM_ACCOUNT;
-	}
-
-
-	if (vm_flags & VM_SPECIAL) {
-		rcu_read_lock();
-		prev =3D mas_prev(&mas, 0);
-		rcu_read_unlock();
-		goto cannot_expand;
-	}
-
-	/* Attempt to expand an old mapping */
-
-	/* Check next */
-	rcu_read_lock();
-	next =3D mas_next(&mas, ULONG_MAX);
-	rcu_read_unlock();
-	if (next && next->vm_start =3D=3D end && vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX)) {
-		merge_end =3D next->vm_end;
-		vma =3D next;
-		vm_pgoff =3D next->vm_pgoff - pglen;
-	}
-
-	/* Check prev */
-	rcu_read_lock();
-	prev =3D mas_prev(&mas, 0);
-	rcu_read_unlock();
-	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
-	    can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				NULL_VM_UFFD_CTX)) {
-		merge_start =3D prev->vm_start;
-		vma =3D prev;
-		vm_pgoff =3D prev->vm_pgoff;
-	}
-
-
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma_merge(prev, vm_flags);
-		goto expanded;
-	}
-
-	mas.index =3D addr;
-	mas.last =3D end - 1;
-cannot_expand:
-	/*
-	 * Determine the object being mapped and call the appropriate
-	 * specific mapper. the address has already been validated, but
-	 * not unmapped, but the maps are removed from the list.
-	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		error =3D -ENOMEM;
-		goto unacct_error;
-	}
-
-	vma->vm_start =3D addr;
-	vma->vm_end =3D end;
-	vma->vm_flags =3D vm_flags;
-	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
-	vma->vm_pgoff =3D pgoff;
-
-	if (file) {
-		if (vm_flags & VM_SHARED) {
-			error =3D mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
-
-		vma->vm_file =3D get_file(file);
-		error =3D call_mmap(file, vma);
-		if (error)
-			goto unmap_and_free_vma;
-
-		/* Can addr have changed??
-		 *
-		 * Answer: Yes, several device drivers can do it in their
-		 *         f_op->mmap method. -DaveM
-		 */
-		WARN_ON_ONCE(addr !=3D vma->vm_start);
-
-		addr =3D vma->vm_start;
-
-		/* If vm_flags changed after call_mmap(), we should try merge vma again
-		 * as we may succeed this time.
-		 */
-		if (unlikely(vm_flags !=3D vma->vm_flags && prev &&
-			     prev->vm_end =3D=3D addr && !vma_policy(prev) &&
-			     can_vma_merge_after(prev, vm_flags, NULL, file,
-						 pgoff, NULL_VM_UFFD_CTX))) {
-			merge_start =3D prev->vm_start;
-			vm_pgoff =3D prev->vm_pgoff;
-			if (!vma_expand(&mas, prev, merge_start, merge_end,
-					vm_pgoff, next)) {
-				/* ->mmap() can change vma->vm_file and fput the original file. So
-				 * fput the vma->vm_file here or we would add an extra fput for file
-				 * and cause general protection fault ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma =3D prev;
-				/* Update vm_flags and possible addr to pick up the change. We don't
-				 * warn here if addr changed as the vma is not linked by vma_link().
-				 */
-				addr =3D vma->vm_start;
-				vm_flags =3D vma->vm_flags;
-				goto unmap_writable;
-			}
-		}
-
-		mas_set(&mas, addr);
-		vm_flags =3D vma->vm_flags;
-	} else if (vm_flags & VM_SHARED) {
-		error =3D shmem_zero_setup(vma);
-		if (error)
-			goto free_vma;
-	} else {
-		vma_set_anonymous(vma);
-	}
-
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error =3D -EINVAL;
-		if (file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	vma_mas_link(mm, vma, &mas, prev);
-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (file && vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-	file =3D vma->vm_file;
-expanded:
-	perf_event_mmap(vma);
-
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
-	if (vm_flags & VM_LOCKED) {
-		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-		    is_vm_hugetlb_page(vma) ||
-		    vma =3D=3D get_gate_vma(current->mm))
-			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
-		else
-			mm->locked_vm +=3D (len >> PAGE_SHIFT);
-	}
-
-	if (file)
-		uprobe_mmap(vma);
-
-	/*
-	 * New (or expanded) vma always get soft dirty status.
-	 * Otherwise user-space soft-dirty page tracker won't
-	 * be able to distinguish situation when vma area unmapped,
-	 * then new mapped in-place (which must be aimed as
-	 * a completely new data area).
-	 */
-	vma->vm_flags |=3D VM_SOFTDIRTY;
-
-	vma_set_page_prot(vma);
-
-	return addr;
-
-unmap_and_free_vma:
-	fput(vma->vm_file);
-	vma->vm_file =3D NULL;
-
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	charged =3D 0;
-	if (vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-free_vma:
-	vm_area_free(vma);
-unacct_error:
-	if (charged)
-		vm_unacct_memory(charged);
-	return error;
-}
-
 /* unmapped_area() Find an area between the low_limit and the high_limit w=
ith
  * the correct alignment and offset, all from @info. Note: current->mm is =
used
  * for the search.
@@ -2801,6 +2576,231 @@ int do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	return __do_munmap(mm, start, len, uf, false);
 }
=20
+unsigned long mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *prev, *next;
+	pgoff_t pglen =3D len >> PAGE_SHIFT;
+	unsigned long charged =3D 0;
+	unsigned long end =3D addr + len;
+	unsigned long merge_start =3D addr, merge_end =3D end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
+		unsigned long nr_pages;
+
+		/*
+		 * MAP_FIXED may remove pages of mappings that intersects with
+		 * requested mapping. Account for the pages it would unmap.
+		 */
+		nr_pages =3D count_vma_pages_range(mm, addr, end);
+
+		if (!may_expand_vm(mm, vm_flags,
+					(len >> PAGE_SHIFT) - nr_pages))
+			return -ENOMEM;
+	}
+
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
+		return -ENOMEM;
+
+	/*
+	 * Private writable mapping: check memory availability
+	 */
+	if (accountable_mapping(file, vm_flags)) {
+		charged =3D len >> PAGE_SHIFT;
+		if (security_vm_enough_memory_mm(mm, charged))
+			return -ENOMEM;
+		vm_flags |=3D VM_ACCOUNT;
+	}
+
+
+	if (vm_flags & VM_SPECIAL) {
+		rcu_read_lock();
+		prev =3D mas_prev(&mas, 0);
+		rcu_read_unlock();
+		goto cannot_expand;
+	}
+
+	/* Attempt to expand an old mapping */
+
+	/* Check next */
+	rcu_read_lock();
+	next =3D mas_next(&mas, ULONG_MAX);
+	rcu_read_unlock();
+	if (next && next->vm_start =3D=3D end && vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
+
+	/* Check prev */
+	rcu_read_lock();
+	prev =3D mas_prev(&mas, 0);
+	rcu_read_unlock();
+	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+	    can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
+				NULL_VM_UFFD_CTX)) {
+		merge_start =3D prev->vm_start;
+		vma =3D prev;
+		vm_pgoff =3D prev->vm_pgoff;
+	}
+
+
+	/* Actually expand, if possible */
+	if (vma &&
+	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+		khugepaged_enter_vma_merge(prev, vm_flags);
+		goto expanded;
+	}
+
+	mas.index =3D addr;
+	mas.last =3D end - 1;
+cannot_expand:
+	/*
+	 * Determine the object being mapped and call the appropriate
+	 * specific mapper. the address has already been validated, but
+	 * not unmapped, but the maps are removed from the list.
+	 */
+	vma =3D vm_area_alloc(mm);
+	if (!vma) {
+		error =3D -ENOMEM;
+		goto unacct_error;
+	}
+
+	vma->vm_start =3D addr;
+	vma->vm_end =3D end;
+	vma->vm_flags =3D vm_flags;
+	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
+	vma->vm_pgoff =3D pgoff;
+
+	if (file) {
+		if (vm_flags & VM_SHARED) {
+			error =3D mapping_map_writable(file->f_mapping);
+			if (error)
+				goto free_vma;
+		}
+
+		vma->vm_file =3D get_file(file);
+		error =3D call_mmap(file, vma);
+		if (error)
+			goto unmap_and_free_vma;
+
+		/* Can addr have changed??
+		 *
+		 * Answer: Yes, several device drivers can do it in their
+		 *         f_op->mmap method. -DaveM
+		 */
+		WARN_ON_ONCE(addr !=3D vma->vm_start);
+
+		addr =3D vma->vm_start;
+
+		/* If vm_flags changed after call_mmap(), we should try merge vma again
+		 * as we may succeed this time.
+		 */
+		if (unlikely(vm_flags !=3D vma->vm_flags && prev &&
+			     prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+			     can_vma_merge_after(prev, vm_flags, NULL, file,
+						 pgoff, NULL_VM_UFFD_CTX))) {
+			merge_start =3D prev->vm_start;
+			vm_pgoff =3D prev->vm_pgoff;
+			if (!vma_expand(&mas, prev, merge_start, merge_end,
+					vm_pgoff, next)) {
+				/* ->mmap() can change vma->vm_file and fput the original file. So
+				 * fput the vma->vm_file here or we would add an extra fput for file
+				 * and cause general protection fault ultimately.
+				 */
+				fput(vma->vm_file);
+				vm_area_free(vma);
+				vma =3D prev;
+				/* Update vm_flags and possible addr to pick up the change. We don't
+				 * warn here if addr changed as the vma is not linked by vma_link().
+				 */
+				addr =3D vma->vm_start;
+				vm_flags =3D vma->vm_flags;
+				goto unmap_writable;
+			}
+		}
+
+		mas_set(&mas, addr);
+		vm_flags =3D vma->vm_flags;
+	} else if (vm_flags & VM_SHARED) {
+		error =3D shmem_zero_setup(vma);
+		if (error)
+			goto free_vma;
+	} else {
+		vma_set_anonymous(vma);
+	}
+
+	/* Allow architectures to sanity-check the vm_flags */
+	if (!arch_validate_flags(vma->vm_flags)) {
+		error =3D -EINVAL;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
+	vma_mas_link(mm, vma, &mas, prev);
+	/* Once vma denies write, undo our temporary denial count */
+unmap_writable:
+	if (file && vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+	file =3D vma->vm_file;
+expanded:
+	perf_event_mmap(vma);
+
+	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	if (vm_flags & VM_LOCKED) {
+		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
+		    is_vm_hugetlb_page(vma) ||
+		    vma =3D=3D get_gate_vma(current->mm))
+			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
+		else
+			mm->locked_vm +=3D (len >> PAGE_SHIFT);
+	}
+
+	if (file)
+		uprobe_mmap(vma);
+
+	/*
+	 * New (or expanded) vma always get soft dirty status.
+	 * Otherwise user-space soft-dirty page tracker won't
+	 * be able to distinguish situation when vma area unmapped,
+	 * then new mapped in-place (which must be aimed as
+	 * a completely new data area).
+	 */
+	vma->vm_flags |=3D VM_SOFTDIRTY;
+
+	vma_set_page_prot(vma);
+
+	return addr;
+
+unmap_and_free_vma:
+	fput(vma->vm_file);
+	vma->vm_file =3D NULL;
+
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	charged =3D 0;
+	if (vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+free_vma:
+	vm_area_free(vma);
+unacct_error:
+	if (charged)
+		vm_unacct_memory(charged);
+	return error;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 {
 	int ret;
--=20
2.30.2
