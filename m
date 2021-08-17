Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09FA83EEF9B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbhHQPyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:54:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59972 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240269AbhHQPsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:39 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjffW011253;
        Tue, 17 Aug 2021 15:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=nPxIWoVC+HGNpLIxqjvRMugohY6PbPm9UmWofPDlBr4=;
 b=vLWwygKGk4uExQQj46X8NoWfLk6Q5HYUxN4CoBZF9y+ppEb+8Mza774UOb4Nkf53ZgQv
 NLIhRC0osboVaY/tigzSuzzS7tqlZesBm49lAg42qqu3nlxG4vE0ZnS/t1W5pz11gQuT
 blMe8wobaYtc4YTXk3k1dEImhjbp+Outop/EPNEZP/OGfKMD8SN3b/+Q5IcvytdFeQBr
 zsjZ1XUN0cb3crSo9Xj2fA20tWskWLBeGGgsnr7Dh6FivBDduTG8TimsBD14jm3LgBA6
 1AcBswG+u1H/09RqgfLv1nlXbNVPOJLabfGGQW9Zhm0SHSXlkUaonTq5GtdQvEAAgATK fA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=nPxIWoVC+HGNpLIxqjvRMugohY6PbPm9UmWofPDlBr4=;
 b=rGnH4wIgBrF3GrQG4iYpWe4EmevHDk5IWCL5OjqCdLCR2vBwoICTXaNyPkdgqLXiNF5m
 Z4lJCsXPNmEzSjAnL5da8N3ScdzvvbSjkVoAn4xQ/6YoCOByKdVubkjDcHxMUKFCAYtJ
 3mkE/1/ooKN0Ibmqx5mSWtQcG4FKh7qlgudCy0Yt0UnerJyb9QgctJ3uHkcPi7T5vPG1
 +SpD1jkQx1Vzw1+AEyzhGVCeA+Mnr4zIEEVn9lYSwkX7VuDWT9d5D1vQOlvhV/vhSMgh
 kQggnXwzUTv8tacDWaytytCk1XW6MmrQQeXvCRu+wskS0lY6DCYI3ZBCdDYHBkPewg0Y tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7d8btm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:19 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmf6158706;
        Tue, 17 Aug 2021 15:47:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3ae5n7styr-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7TFUjcvvjMl1eP0zFOunixmOTS6vpKGNyLnd8FC+X2LYjezaa69H1LwczBv6q+egFSWKDssGPldvQVjsJ75YQwId5Aeixcp7s3OcD2JknLLOzyzoBKH//gFHRv4Tfkp6FC804Aw2eadeyd+wUz2Rgr0Q/pn1j2lQIAFcSKNQg74rw3H+YvhhclK2RDdZrFdUVD8JtwucpYUItZA15Q7fyBHNXCW6FmLH7r/+4KXNaW9t9qtSvgjdrsLw07om2SkhU0MssUWEhtSXXkd2uXyTVCRSohiM5EHQSj0BvulsZbjzA1iSNNNTTRst6whvUQo+AulJ7o/ppkvZ4MkEcH3fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPxIWoVC+HGNpLIxqjvRMugohY6PbPm9UmWofPDlBr4=;
 b=TG9skw5puzNehRv2WcQPpwxzI/dC6UhqCasmr8sBk3unKw/Yey7siqawnnR8lxzKSagPxUC98yyEsUAzH1S3ZmdbOLCMbFhEsBmDVYs1iI1goywyuxIccyuNHxETYcj81mJN+12pAvENbomnzyrH3y7lZBlrEAghamFWPJoSbV4VtbuX0m4ddoKd+6Q4stS4k0oltlXeyJ8VaKP6Md4Jo3HrmeYDrKqCeCGOZJvS8VZvYgLDds3eOZOZIjyBJfFHa7l4FrG6aKvjSkV/8xaaKhuqsUZTpmxNWYT3GHyVO5gqesN7kGpbpDcnRbACkpnyGgEEZU2oYn1SbvmyjE4Brg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPxIWoVC+HGNpLIxqjvRMugohY6PbPm9UmWofPDlBr4=;
 b=m4wGi7UZ5XEfMnTnf5lxYuf032t0Cyx5oQDZW7Ap02TC9YSVdLUeI67GJUJBlwuBvsBwuagfxGQLmRTH9IVC4iWAV7zwyUKyb0pxqdqVAhSllcsGfoFlE+cuQKpNPmzpOx0vTJJyvEsVo9P9rbgoF6kyNoIAneOYuiI6WNfvCtI=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:14 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:14 +0000
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
Subject: [PATCH v2 19/61] mm/mmap: Move mmap_region() below do_munmap()
Thread-Topic: [PATCH v2 19/61] mm/mmap: Move mmap_region() below do_munmap()
Thread-Index: AQHXk38meWXt+pFXlU+hcJUgX75spQ==
Date:   Tue, 17 Aug 2021 15:47:14 +0000
Message-ID: <20210817154651.1570984-20-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: daccb93a-6876-4897-9e5c-08d9619648f8
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB423644D04362EEDEF90C1C28FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oaq4rb4XMhevqweNcYBSpWtCyQBBD0G3gQJeZtMgjIuetI8ERlBAdv0H0LfOlCCWZDvWFB3sgcm49VXi39ONanf6TEEetQuzEx583IllxSBiC4vm5aB1T+j9iT9aLkkT/FiOKW20a6BNvyfJdqVhpIS9mpOlGEaJmGCfKusKzRxCKw6LX3iQ4DcJusYfNrijP8Px4GTkO0IrZwfL2jHMXt0N71ETWt9umBtEI3A64JrMosX0M1wPAeKAWpj+bOmAMJT6/MdGFshSYJ/XOt0GDm60xyKUnt47f2EwS8ToyzF20xanIJRjfL9hkGeOqcjrEYdRxP1yidSTCPDqUOoTQu0X/sn7FoIOpqhanYm3j8j4jtW015B7tCwMETV5jamhtIlIuWHzVRe+YNqRWWfRpl8GvF1odXJCQ9ujczox4hXcMgE1fZDHoMn6oaex2lWm83nnATtdMJlUj5POrqoCfjvFzfuCC1rbXhR1gMPUsxPwdnXudpRVq9TuJ5RMdHCxM9r5RVnxX0iGCMu2MKYkViYPizyx/z2meuu4X4q9d2SK8T9LsfJW8AM/9TxxHyYPuD6ew+ZuuuOIsJWt+9WOCy7Vg+6lELxs5NSgckmp5r7E+guqeByq7d1Dz/0BuWaYOG0XXp6K0BjtochWmK+AG6ZJ6aE4bhXc9o77tF/strvgoECgSRZEMXjfggZV91Km4ZxYfZv5sHnVfzVceZUu8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(30864003)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?diOaaE/G/Un24qtXyCqjCswgdWY7zmR0nNbsw/NULjCIgEUmuiZCWgB6m7?=
 =?iso-8859-1?Q?RNRe6WrQ720tBSWDEZyUMSgy7tdIjiKXeOPus0cMQRCL2ki4xlrh1G2mZu?=
 =?iso-8859-1?Q?p9Y0PhOmKVkMP/S+Yx0bfV8/NosteXX/u8n4s7Tn7PIvYYlfW2gU3M60Oj?=
 =?iso-8859-1?Q?hd7hHhjaFV7RZuRl00NiKOS0SjxsbZ24t9VSkTvV2S3mrnsW4UN1ljXq4B?=
 =?iso-8859-1?Q?0Ubgg1AB+2qy9o/28WfJs5qHiKLr55Y5K6f1hGC/CAqAa+cTiN3O4+XFrl?=
 =?iso-8859-1?Q?svGY6eCrc3VvWnGVxEViuSuSUUW4+6F6GTOk1M9wRsbWKOfg6mw4TLFEMP?=
 =?iso-8859-1?Q?ztYAjSuXwfpFeZUXl2QMWJQTeCRObC42XoNzh8bV9Tm1i6w0Q2lvs8Zxzw?=
 =?iso-8859-1?Q?8OWLtsMdG0aYAUBvjnOdWGmRjVz7Iu2ypCRVBsVpnrk8oy6J/0whlxE8BG?=
 =?iso-8859-1?Q?EohcufwmOvnIuqTSoSoOuY2KMRpY7ra9stFGov9bF1Eof/eg+vN84bL4Z6?=
 =?iso-8859-1?Q?YZ6ArvGE1UwcuoGT+tc77o4N97vZND0BxSeMXi0L5bp4pJkT2gXH3ciV2H?=
 =?iso-8859-1?Q?c9Xmpyzq4xP8UEAf9xHCQOYRsv+UeVKW7Hu1+jdOy/3sgd7Z399S/CXbPi?=
 =?iso-8859-1?Q?sTWVjyOKI3JI51pcKHpRtHvb8p91opO5i/n0IxTEwkWu99iNNxjDbpAcZV?=
 =?iso-8859-1?Q?0z9OFXNGBgxZOugEZq4wugBKArgVX+YsqI6+3KjMALUBwfwivHlHHDbSjh?=
 =?iso-8859-1?Q?b8I4rEkQ+rKqSnelkxOwC+UA/O4iXiwdGs0tRD9Mq6JTn3iuBMWw7+EAIj?=
 =?iso-8859-1?Q?ywVhRGf11idX6Vd9W9rsmcCNo8eaMeQ2bCGNfEfrNLVwnLRLU2YWZN5bK9?=
 =?iso-8859-1?Q?20Ptxy0NSHzhgJkl0bdCGPdKg3RYANqLaN2edKbl5TEfxyoylO1bcdwY62?=
 =?iso-8859-1?Q?9vu38LSXIOROVSOQMYKSng5U+Q50TLhogrUuDSmvU/gU4rYUuJc9olVRbQ?=
 =?iso-8859-1?Q?CI/ladshW1YLi/Tld5F17b9TGsjXiZ9TTn39fPUcKBZellWVvcehuRZOA+?=
 =?iso-8859-1?Q?KbJQFhlUysxhIWU9iETPn0J0oGV5l602gAtWzMwl78iA75ElLgnFyf8z0x?=
 =?iso-8859-1?Q?Kk4qwaxvXSlaDO96Wzm7MPAswAEtsDj3pExQa8Efjz/Simb8kd9JiOEeHz?=
 =?iso-8859-1?Q?RIDdriWeywNcO48kYP+W7NFbPxX40gCWP4mSCgdNYccUMNNWIaA6bWyPCP?=
 =?iso-8859-1?Q?VIKeyJqrbEX0WYF8Y28JdUbKd3g3uBMZ2nllN8h6MhYZzrqqL/FlrR65U/?=
 =?iso-8859-1?Q?QHS5txJ6kTg1XO80RatUZ3NIPVn1LMkAIYxvZboMA4pi0jj8PLL2StKnzI?=
 =?iso-8859-1?Q?biX6Ji3Pzl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daccb93a-6876-4897-9e5c-08d9619648f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:14.6021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WwfkEkiHynVnp2sTz43fQJlNIvEl6moYe+/n48sFNpIOrkf/Z2A3VhL2Z0VBG6zAhKEcwbZ7mLILnhh2POeiDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: 3ywUMK16dwbEcn3EghKI-UKPOWVxMqEK
X-Proofpoint-ORIG-GUID: 3ywUMK16dwbEcn3EghKI-UKPOWVxMqEK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Relocation of code for the next commit.  There should be no changes
here.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 482 +++++++++++++++++++++++++++---------------------------
 1 file changed, 241 insertions(+), 241 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index ed9a60d8a006..ef618dfd1d94 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1720,247 +1720,6 @@ static inline int accountable_mapping(struct file *=
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
-		file =3D vma->vm_file;
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
-	mas_set(&mas, addr);
-	vma_mas_link(mm, vma, &mas, prev);
-	/* Once vma denies write, undo our temporary denial count */
-	if (file) {
-unmap_writable:
-		if (vm_flags & VM_SHARED)
-			mapping_unmap_writable(file->f_mapping);
-		if (vm_flags & VM_DENYWRITE)
-			allow_write_access(file);
-	}
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
@@ -2825,6 +2584,247 @@ int do_munmap(struct mm_struct *mm, unsigned long s=
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
+		file =3D vma->vm_file;
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
+	mas_set(&mas, addr);
+	vma_mas_link(mm, vma, &mas, prev);
+	/* Once vma denies write, undo our temporary denial count */
+	if (file) {
+unmap_writable:
+		if (vm_flags & VM_SHARED)
+			mapping_unmap_writable(file->f_mapping);
+		if (vm_flags & VM_DENYWRITE)
+			allow_write_access(file);
+	}
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
