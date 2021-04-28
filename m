Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9C236DC2E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240865AbhD1Pne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:43:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3646 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240478AbhD1Phz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:55 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFM7Fo009825;
        Wed, 28 Apr 2021 15:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=P3J8YxdWma1uF2ZSnWHhAtVm00nLcNd7vNb4oPFYqS0=;
 b=B6owhT8KfLDtiUvNFhxqvjWdG3FHx/TOqi/wckdbVVN3A3XdTWjpJULrO8ndV7WYsWuU
 036CgjzEOAFa/Y63+L9kavd77ZNczS06OeLNsLxttS23YIgINuB+lt5Yip+Cjyk4FJXm
 BeBH7LChWySsXinEtrJVfsYOPq8a0hdN1nYUBdu+4CDFD+GUll7qqmgtngaJTkOiohYp
 /0oYvxG/aNIE3NzwQ+y1AOK9zk/8XnaFYcHjDPMpulmjPXA2uZkU97wEllMMpwXZObsO
 jdvqfzM/A6SvJtO9xTalql9ZMHBuzCViSwuBQEXQWcgEnU9oaQM0fQM3I5I8r1d+egRf lQ== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:46 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaASv030176;
        Wed, 28 Apr 2021 15:36:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 384w3uuag3-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSPAPrdDqi6v8EoBH6YKZBhpgeikGW2YjwGeB/AwYhm8NRGneVAJwGROpwbeHPQaNEdYAuSmDguMbjxp1FTs0hgUvZwIBJ2M2JAdWUC1jvzoik+CEjp/rW9FSZI96FSCTZ980SvrEb8Qf9zAnpzikZDkd8cQDnkAlK64XZRvKc2J8Y2yCvriJ+WN0B5dvwHOHZ+1QcK2dWdf67gvmL5rqRSfXwsV7XbE0/jJKbKtbDb9aV/euNcvVHv5pEFC2fxHAWxlVzR6p5IgSKNqD03oTWxZBI5muTETFboQTg/FezE0qvQehwnCF49WNyvHZAYYYS81/quGPpMTin383/SFtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3J8YxdWma1uF2ZSnWHhAtVm00nLcNd7vNb4oPFYqS0=;
 b=CAnyRzlvRUb8X3G7iGpLMgOZ9fht/6tk+d6vaLYTItQ+0peRiqw9g3u8+uPG30lacoReBOpBs4E/gLpgPIxhTBjpFoO9iW3qx8B6/kApCsCyZAlAA8CytHYIW+p+qkh3h6UiOpWKTJfBC/3StJoYlfIV+W7+MdMQhliA0FUDHFeQ7USsWzY/vTpDML3oNg63P/V8BUlQd33fSh3O3Az15BinlA3xichzFzyF8aC/arGexlHD5lVV8pg3ungtvW3NbEIBaIcumyJOCPnPFv74IW3pMgG2MiLyIEqFQ5f3oFT4jLQ3xtJh2Y56iLFmQyXeLYdtIGuXmWAeZfIcmKZ+Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P3J8YxdWma1uF2ZSnWHhAtVm00nLcNd7vNb4oPFYqS0=;
 b=I6SypYNUoEl4bJ+mSNBvcQSKPETYtoOLz5KUAekBSZJjeXC1TwlILZXpVY/LGGIsNlK2lpasNd+Ne7/EFt/xyRFcKVTWLtGtaCC/iC/sHd7nrmNUWQbgjoF0wT+GyFcyVATcgNF5ONufG/91sWhxCFAfjD1ujquVoi/k/IVPdi0=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:36:42 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:42 +0000
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
Subject: [PATCH 46/94] mm/mmap: Move mmap_region() below do_munmap()
Thread-Topic: [PATCH 46/94] mm/mmap: Move mmap_region() below do_munmap()
Thread-Index: AQHXPEQ36B6PQzVhBU6BsquBu2qsZg==
Date:   Wed, 28 Apr 2021 15:36:11 +0000
Message-ID: <20210428153542.2814175-47-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: c7800d0f-0dd7-4641-8884-08d90a5b6c3c
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4515FB73F42CB31FF9A6A724FD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w/cRX5Y7dud4JIC/cUOEBLRXShdPf7YI94kYCJZFnSregRtgOn/5884aPS8K41o8sJpMrI20h2HzHdwCo52tPWUuckpybIgAY3Ld+xV2Zl9ydfm4hxkOriTihvXNWC7d/1bJR2Ux/m6SBL6Uh/LZ45PuQco3nlnGvLmTenuQdLUg6qYFX/JQSO9MNeMTx03Tu0WIkhTd5SvqojxZ4/9m3w/E/ra/3n4MxQh3zd7g+4MzN7OMAGaCUlk6ApACpwJhqDkJR9dxjC/mxovA/Yfis9FIMJZ5LVE6YSgxNvVOWMqZLIlIul1iwJpAreQoNCtjPhSgdyvRAx+DmB0icFrOi4HQWyYdoohM7Gj3gRHUDZKk3JlvVWzVd4wyQvBE0+ZU4ADdOT7aZaQmQbyn2L+00y3JDXbW8t8QzRL73YFKcDzjlvWWjiCGw7xWN7N/ePvYVsfswwrB2o4aJ0jSaH3HzziZqUGSZ9wmxBnlazIAnAu1A4dbazHervhY/H/Msv6I2WJiD7kQFISAhUnEX6sX3fH9hoWU4imqfNoYPQnYLteuripOQRsAvpv2vZ4u5UCVC9A0SWblqQpir+4z/z9walRQn+t+fdPirad56YXklLE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(6666004)(30864003)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?PD/CFi23oMA8NAOosoNfUA9AQ868OZlHYxqFGo9Ayv3z2xooVT/B32IFqQ?=
 =?iso-8859-1?Q?KeYlJQxHHLL+cbm1AT5Xo3uyH4s+oaevMkCsarhGpg6mpjvIks3/V0hXD9?=
 =?iso-8859-1?Q?SbCyFSu/BH9sAJLUpPxm9mI4NKygqwUeWBK4CK+c9VuLd3cF+eXu5EWBK5?=
 =?iso-8859-1?Q?L04vHKYJzLwbB6UInPs/XHisF+sMjrvA5q7jyf3LnyzcSu99SajXMskIu1?=
 =?iso-8859-1?Q?oE2e8m/ma2X1I6HbU5gnDB66lOOWFSCK7WQ+HzyiGd0qIArBfzLBPZeJnO?=
 =?iso-8859-1?Q?D28FD/QequjoX5p/ZnD4wZpnasZAgmBANvcSfW6S1XNKIfT08yWNRSFWA9?=
 =?iso-8859-1?Q?Xv0cTuEYWN0amGGSmS4SwaWxO9jDYNVXYl3JUnYWi7UbIpNZw5KiBG8Fmi?=
 =?iso-8859-1?Q?Lks5jhj0HM43jPoYJV+utctQMcG3XJxhTzgZHhdepvpe6mhvPftFCyh35W?=
 =?iso-8859-1?Q?2AVSf1BSIg6/WiNTTgD43arpZR5ghP0E86fGK46V8HghOzlSGborGwsp7F?=
 =?iso-8859-1?Q?A6l3Q6R1J74FoxSke2akb75HBb6jqBio7IVHIukKmZhOgH3PYzs/FDyoH3?=
 =?iso-8859-1?Q?7qEbLmdm0vK1dZEqMG+c+mStHei8Wf9bh59Ml67QHYL+J7C9rsjGSPVWq/?=
 =?iso-8859-1?Q?sqHiws9GP9JGxQYDhQnHCnlBG0mR/GbZq6SnJD6MNmn2Szh2aP+bRKIZHX?=
 =?iso-8859-1?Q?oxK8PD0IpVKAMw7eqmXxwYj/7Fk5C+aB5/7xLBsfnXzXZF70ie42/HmWqi?=
 =?iso-8859-1?Q?q0SYw33qp0hhIOnksWiY6navPezCxpbriCw7tJFRWHGCqvqM4dNt0HKcMU?=
 =?iso-8859-1?Q?ar2F+dIxyZYBQoHb9jGhpHlfxnK7djYd8NzloF5yZuwXr76DU+fUpHQje8?=
 =?iso-8859-1?Q?8TB5mVspeEsmZjuNSX2J/nWIX+JjeUYrdAi8Qq+Y4wIdSuHKnJ++wJbbcj?=
 =?iso-8859-1?Q?AYzROO3GsXLis/L2bTubVstnm3P4mK9RSVIhM+UKlC5UkrjoR70EZIOL6T?=
 =?iso-8859-1?Q?+DSHCKBqaJ9sMj5sGSbMdZtgixP5kV4fK6S/W8vFLtzh3WREQ7Myle/J0d?=
 =?iso-8859-1?Q?OdLTT+nnwzDoD5FAyyHEDiguWIz2OsTXOyh+fF9/BqY1MR8JEeHdJmdG/G?=
 =?iso-8859-1?Q?Z0m8fZ3KYsl6BCsbX5MdgAgpRm4AJBd/NkMy63m2kj4Kqv/Xh3YBQlVTfm?=
 =?iso-8859-1?Q?r0SyUV56w5XamlKHRHRe8YcxBBxFIbEjUtidfkjhNbIAHMlAxCgKcjKuqp?=
 =?iso-8859-1?Q?QoP9+cc87k56BLLgHnWBZbW+cEen7zLJTlJ/V8WscquoCMXJQl8br0YgVL?=
 =?iso-8859-1?Q?gTfjgMiFlKGbl2ZuTShNHsdvvwi4iZfYesx2vGAkSKOd5XwmbiZ0mPgkdc?=
 =?iso-8859-1?Q?91TGl6KFoc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7800d0f-0dd7-4641-8884-08d90a5b6c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:11.8279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z2WJzwK0hsCic3Ns8RVPKEBSg++ity7OnGRIIGTVd8GaXqNz+HGdfe22PbD8mUk15v5tEYZY1OlM/7KXfSqDEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: -AjLEuPbdCgrpSzMWkmS68JnyJkXuRW2
X-Proofpoint-ORIG-GUID: -AjLEuPbdCgrpSzMWkmS68JnyJkXuRW2
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocation of code for the next commit.  There should be no changes
here.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 472 +++++++++++++++++++++++++++---------------------------
 1 file changed, 236 insertions(+), 236 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8ce36776fe43..0106b5accd7c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1695,242 +1695,6 @@ static inline int accountable_mapping(struct file *=
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
-		prev =3D mas_prev(&mas, 0);
-		goto cannot_expand;
-	}
-
-	/* Attempt to expand an old mapping */
-
-	/* Check next */
-	next =3D mas_next(&mas, ULONG_MAX);
-	if (next && next->vm_start =3D=3D end && vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX)) {
-		merge_end =3D next->vm_end;
-		vma =3D next;
-		vm_pgoff =3D next->vm_pgoff - pglen;
-	}
-
-	/* Check prev */
-	prev =3D mas_prev(&mas, 0);
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
-	mas_set_range(&mas, addr, end - 1);
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
-		if (vm_flags & VM_DENYWRITE) {
-			error =3D deny_write_access(file);
-			if (error)
-				goto free_vma;
-		}
-		if (vm_flags & VM_SHARED) {
-			error =3D mapping_map_writable(file->f_mapping);
-			if (error)
-				goto allow_write_and_free_vma;
-		}
-
-		/* ->mmap() can change vma->vm_file, but must guarantee that
-		 * vma_link() below can deny write-access if VM_DENYWRITE is set
-		 * and map writably if VM_SHARED is set. This usually means the
-		 * new file must not have been exposed to user-space, yet.
-		 */
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
-	mas.index =3D mas.last =3D addr;
-	mas_walk(&mas);
-	vma_mas_link(mm, vma, &mas, prev);
-	/* Once vma denies write, undo our temporary denial count */
-	if (file) {
-unmap_writable:
-		if (vm_flags & VM_SHARED)
-			mapping_unmap_writable(file->f_mapping);
-		if (vm_flags & VM_DENYWRITE)
-			allow_write_access(file);
-	}
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
-allow_write_and_free_vma:
-	if (vm_flags & VM_DENYWRITE)
-		allow_write_access(file);
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
@@ -2788,6 +2552,242 @@ int do_munmap(struct mm_struct *mm, unsigned long s=
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
+		prev =3D mas_prev(&mas, 0);
+		goto cannot_expand;
+	}
+
+	/* Attempt to expand an old mapping */
+
+	/* Check next */
+	next =3D mas_next(&mas, ULONG_MAX);
+	if (next && next->vm_start =3D=3D end && vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
+
+	/* Check prev */
+	prev =3D mas_prev(&mas, 0);
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
+	mas_set_range(&mas, addr, end - 1);
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
+		if (vm_flags & VM_DENYWRITE) {
+			error =3D deny_write_access(file);
+			if (error)
+				goto free_vma;
+		}
+		if (vm_flags & VM_SHARED) {
+			error =3D mapping_map_writable(file->f_mapping);
+			if (error)
+				goto allow_write_and_free_vma;
+		}
+
+		/* ->mmap() can change vma->vm_file, but must guarantee that
+		 * vma_link() below can deny write-access if VM_DENYWRITE is set
+		 * and map writably if VM_SHARED is set. This usually means the
+		 * new file must not have been exposed to user-space, yet.
+		 */
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
+	mas.index =3D mas.last =3D addr;
+	mas_walk(&mas);
+	vma_mas_link(mm, vma, &mas, prev);
+	/* Once vma denies write, undo our temporary denial count */
+	if (file) {
+unmap_writable:
+		if (vm_flags & VM_SHARED)
+			mapping_unmap_writable(file->f_mapping);
+		if (vm_flags & VM_DENYWRITE)
+			allow_write_access(file);
+	}
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
+allow_write_and_free_vma:
+	if (vm_flags & VM_DENYWRITE)
+		allow_write_access(file);
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
