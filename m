Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12363EEF73
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240458AbhHQPvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:51:09 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38230 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240238AbhHQPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:30 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjeYl011245;
        Tue, 17 Aug 2021 15:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=DCq2IE3y+vM6Ehn6VmVTdQUsL9NXI0mbFcSLG2C6Q6c=;
 b=ZRyJ2vUgM2Jlpqw4agnGMmMa7ciCCmytQBSe4iaTK4wRyfhFNmarSR8k3F2wkZqePKdK
 NrBKeVlb4NZyed1q9GCf/x/C4uQPD09xGN+quKewsFLc9VyVmjiPobwukjPRWHtqpUCs
 a8qiO7GFvUTMnjSAr6hSMbW5yWLYJ8YXmPLXaTGFcRNKjh4v6EVL6bIPVBZczCm2Pw3T
 p5Ih81HOKxkAyVJkD+GKfAE3VA3OweOgIObIKwam6GQT+QYQkVwB0Phho6AZPyoS71nk
 lYmkk5xI29m/ftVDy4j3tBCUwE5Ejal3AxJJ2iYzrbSrUPJPg+owCBoSjeJmquB3UaXH QA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=DCq2IE3y+vM6Ehn6VmVTdQUsL9NXI0mbFcSLG2C6Q6c=;
 b=sMh9jJT4ei+Sv0YLd+jnksJ529dam9qXcj5YACinDmttkF1w9GElZMDSTI0sBZfhqy3e
 c51OD3i04FdmZeonBTAdE2sm2jnUTXkodU98przv3SBV2eC2iaByv/Mcy/gCIZKhr1Sy
 NA3UDr4FNRi02cy/beh0je5GpKFrOg0YauAOAGwZypRsLF0ZGH3+OjB4WFe3iQJwUe6X
 N0fXQ+qpvfBVVBo5f8I70AgtxDOugjt8vXNw+tcuQfH79QmFWsww+HJ4mvRjFW3mS+PB
 vvePsjiQ3/pR83vb5q6CaHXBs0jdBpJ8R5Ea1/9GjBG98BNJcLsL9c2MgivKCeX62CUX +g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7d8btw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:27 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFksn4094410;
        Tue, 17 Aug 2021 15:47:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by aserp3030.oracle.com with ESMTP id 3ae3vftdg6-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mq1xoMwKvrckV7Vj4So3acRnn6OT0EX5xZupWzKqvh4aAi38Ars7VYudIND/NUv2lzIg1cU8KNiXpGE+Otghc2iYsXpq0+Py2s1QB3axg9YdWOvSBgW2BQLkcaMZfw7qK/jLY8PQUNaZWgaUnnHAhrd8HiAOEjN+/o+sC46jqkHF5s2/3UwkpTKN9Rb1zQu1bImtPG2I9sqQZ+ww6jQcA1jRbtGEWeqCG09t8VMZbCcajcRz4Yeb+BbQY1e5Rau0v9Y47llAIJlXoftVL0/6olWnteJVBN6WtEsfrw/z8Oo0PHCURWS1tlL9K2c4CFtUtmefMZEJrSQwFEAYD1N0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCq2IE3y+vM6Ehn6VmVTdQUsL9NXI0mbFcSLG2C6Q6c=;
 b=aO4poe6FOeZwGY0Cz9rRGaKmHOhq6qQGrNkURIjXEe5tmcRC9zE207+H3QSz/vipnK0gSYkgGKJOFxUWI5Wd+ytxlvw2jGNlb1C3y/PoatHlXudnTM6Mlq+W52Ifas3+PRLyoW7qDDEFXauwdUUTMMZun0vBgIFyh01iwkjxqjYhty+w0RAKgjE0ehiizHMrPPa+zVcrczE1eYxeUECodZJRmPOuvQ1nSW1mccvq3axRm+VrBF4TQaHnSWGKLDF73DgDF2+inFQyBwuCM8y8zfBZr92ZcVq2ySoUIVvPvAaGSacfGoTzCpd92kgadI+m9EPwU3Qp1Ul++BAFUHZrTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCq2IE3y+vM6Ehn6VmVTdQUsL9NXI0mbFcSLG2C6Q6c=;
 b=qw3o8kmlykQw6qqZcr6MRtGFGZOfjdrWObn9bAOtPfJvKxMPoG6sNDrgm7cXtQHcwc432PypBvPdTkG6u0nOJL5JULo/YUU2VQPGvJpxbqxtFjOkD1KjEy5DcocWfHCvKr9mGFGuYH/EIuYeEZW0BgXekmDQ2bbCEsWu1/jOA5g=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:22 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:22 +0000
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
Subject: [PATCH v2 29/61] arch/x86: Use maple tree iterators for vdso/vma
Thread-Topic: [PATCH v2 29/61] arch/x86: Use maple tree iterators for vdso/vma
Thread-Index: AQHXk38qkiUUesGxtUKIH/HVhy2xYA==
Date:   Tue, 17 Aug 2021 15:47:21 +0000
Message-ID: <20210817154651.1570984-30-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: b48cb419-ade9-4556-0013-08d961964d81
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB4236196244D1F69F924541DCFDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fnWKhO5BVa6baNtL/uehQODb2SyhebYUPa5N7QK6x9eHFQeqZogLZrq60pI8CDpqVHISBG8PWtSnX22NYtdZXmfTl0PrBImN3P9lBTM9fOU45xM/QnGbA4Ex/fQZDa7EciG9XOv4inewy4kqlEYSKi5XBWN2oUSm9WV6ve55l0oG9daxRPIDFszYndZymdoEbTSRkO9lpXkvNbOVMSARnS94mc0aUBn1pk8ETW3j2G94kya0nckH48w3ZZkXfX2NeLPqnswEL2IhEORfLPizB0x1dFqAfZ69R+jsm+767SuBUm5nEL8UQmlWa1bMLCi8HCsOUipcfNd8DLFI9qZxIYFLc0eQX6qkrdMHWGrv7t2V8pD8Y4XNQfYMmoZrJx6PspcBUI1sI47IR5KmVpeSrIA03XBMVssKRnyXdflurtGGBOdiKrPTWaRjgo+cppmz09cWj49coI2GDHovkOCI/uUbT4xHjRfKK8/0rl1Sl7LX1BnlK8gIsHH1Po+jfnruCnqDETKg2lyBkbp1r+GW6Afhf1n9yzQouA+AJrlgonVOXT1bGo6wGQ7fkV9eP69TzFUfTyxO3O8fNs5kCzqE+Bl6FsZvE5k88w264QBwCjwJd0Qdt+fzBxIKRdMfdxh4yndF5Gad0HF90EjUk9yGVkJh0bcg5E+eXa8/VMt6GsCFMRV20sRvzxMbv69zBUfm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Q2AFsyGUtKv67XgDnv+7MeCWyqe9Mwu84jBTj29xWjCO4y5/5NXvxOb8NB?=
 =?iso-8859-1?Q?JdOS3wCgDpAcVaUqyC1IX5skExid5s4goYW+2TGmvwsz/G8T85e09Lbr2S?=
 =?iso-8859-1?Q?d91glSqK4JN/iSzwqpf+ISs7YnOg8iubj1X5ZnWMpPVkCnDSr7YImeY7el?=
 =?iso-8859-1?Q?PY9YIaHV6Zep8DmYjviIdUPqzNKFndyYGBmpePsv1dxm9mhYPdu5ojY0bJ?=
 =?iso-8859-1?Q?Nuw3KzQHLLTd/ncDn4UWq+i4+GpnJZ/A038P67RQzLoETBnGHwzkuWQtvQ?=
 =?iso-8859-1?Q?SvmnMv6EWN0ATV/aRdDCF7J37iRgIGrsYRLO4dvpgEX9UoddhuDr6iG2DM?=
 =?iso-8859-1?Q?6A9qqot8xb0PoqLKT6ZuncSH+1Jp7S1zkM4ZwaLuVauvGDRD6OIK4he8kR?=
 =?iso-8859-1?Q?Mosr0d77Y6ANDBZnMAoiGvWTkxa9tBYAxawdsIQJ11VP0TLj3m1tlSupXK?=
 =?iso-8859-1?Q?mtID/sc9n+xuo83Uqg8Mt/L06MveTzfr6uuUCjjiSpYfHDjoeN9gIzDyVX?=
 =?iso-8859-1?Q?lx3uNzLq1LrYQoT1iKUPLR3I2nQDjbNpAaPb37olwqdqz4mUVgE6snTlh8?=
 =?iso-8859-1?Q?ak7IQ+mI5OOzWBVPZtKIE1PsODmcYglRphrLfzJgigmhWsUBHIfMk3CJ9L?=
 =?iso-8859-1?Q?ch/DPVd01U0YmcHaRG1QShasJo/KvxPTgsJZELGz3J0kS/Zda6SQCdFM1G?=
 =?iso-8859-1?Q?Pe0iPy6Bshcl3NL4xRkCPR3lWv0hxSn/3yhFd6UrpW7Lk+6363WznqmQcF?=
 =?iso-8859-1?Q?1mwWkJW5xSnH7q0LTxXXDsh6L3+N0Ap1EWzyb7NOSG8iOPZ1+eUnltX4h1?=
 =?iso-8859-1?Q?S9h7r8bEWFHTfSpvc7LYaNf37GGuCJgI3bx13aWGvC6A1ee5vk7pae5dYn?=
 =?iso-8859-1?Q?o7wf73MM4DAi+DkCCNOFvgDifwwn/Rzg6bH/X0K6M6rNkutZUUfceGajBR?=
 =?iso-8859-1?Q?slz1XmlFuincmjyW4Kphs0XHT8ApJXdWlxhQZq3iWO8YlWnjjIdVXKf0RQ?=
 =?iso-8859-1?Q?Bp+BXszrbIkwpMqD8vkrLrRypD3gb2tQEa9UANIb55UppufVOg0mTQyIy1?=
 =?iso-8859-1?Q?xzOlqpoI9PiecRhBEsYqay6gV8DIW5SkKaUVqvhWbLZyDWtg5/DSP2emSI?=
 =?iso-8859-1?Q?Swqn6X86XUEBR4BsgQwDPugx37eiEA4YI+G2biwip6e7IarcsqpuPCJDs6?=
 =?iso-8859-1?Q?aUlN5hLjC68DabMmQ007u7qHWYQAeD6F0pUY8TB7plafnekK/t4mY0pXs2?=
 =?iso-8859-1?Q?eHtmdFFyeL1BwcK5gGFaH8hwQJB+iov+Uppq4bh0pvVwrXjoQt9x8Q2/0b?=
 =?iso-8859-1?Q?OTGPB7fWN0yM9CdGrVGAtAzxRAR5reUvbnEQJ+c6tbAoFTtbsTM/MaHFdC?=
 =?iso-8859-1?Q?xS0ZSHgd2D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b48cb419-ade9-4556-0013-08d961964d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:21.0648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R95dQU0wlPEso0Feimfw/F9cOIgKixmSi4O66PGzAA1Z8qeMJmSJM7nmxOvCjczw0VS1vj5s6jWhKzM9uZvKuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: N7bMD6NiGkGfqM0c6n-Gz0OCx6mUp9aS
X-Proofpoint-ORIG-GUID: N7bMD6NiGkGfqM0c6n-Gz0OCx6mUp9aS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/x86/entry/vdso/vma.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 235a5794296a..c0b160a9585d 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -128,15 +128,19 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
=20
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+
 	mmap_read_lock(mm);
+	rcu_read_lock();
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_mapping))
 			zap_page_range(vma, vma->vm_start, size);
 	}
=20
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
 	return 0;
 }
@@ -354,6 +358,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	mmap_write_lock(mm);
 	/*
@@ -363,13 +368,16 @@ int map_vdso_once(const struct vdso_image *image, uns=
igned long addr)
 	 * We could search vma near context.vdso, but it's a slowpath,
 	 * so let's explicitly check all VMAs to be completely sure.
 	 */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_lock(&mas);
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
 				vma_is_special_mapping(vma, &vvar_mapping)) {
+			mas_unlock(&mas);
 			mmap_write_unlock(mm);
 			return -EEXIST;
 		}
 	}
+	mas_unlock(&mas);
 	mmap_write_unlock(mm);
=20
 	return map_vdso(image, addr);
--=20
2.30.2
