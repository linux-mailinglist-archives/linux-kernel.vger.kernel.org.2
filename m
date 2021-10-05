Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E12D4421C17
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhJEBgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:36:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9874 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232740AbhJEBeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:16 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951MKZu023925;
        Tue, 5 Oct 2021 01:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kKi9IR0u/ZXO/yn9ob7ZMbJIAM68697suBFPGngOCHE=;
 b=j477e9xaDExCv/Uk/tmZ4uMcBELGQIViQxlyuj3peFQ+eMJ/HQVfqgm24fiLFqOhioNw
 Q+p3ZXpZPpLeEWn5X1r0AhmdkH9yITIfXRxIAoDf2R2/g9aNQYIVpvN+IgLOnDFX3bi1
 aRiMH8+rMboqKG5Tfb/gQlTOJBnGfxuvsgnrvEuTrTUH5t7siyRenQlnq4s0Z0LzWUGo
 zgw8ppw+IA3KYNoEw5Nh7lJC+RBdL6Hzt5OYKjLBX4/YgQLm4hsF2yxOJ9OJRjc/7G80
 9uQH26nQqMb3n7AktdqS09Wx1R5eZtFuAAuyY6XpiWLO1aKvb5xmhOgfgx/Iifin87An nA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43gkppg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:32:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UIEf178435;
        Tue, 5 Oct 2021 01:32:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3020.oracle.com with ESMTP id 3bev8w03ud-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKqLW6AoYp6pVFLaUWoIEXrugDVIUB3PoGbVDGzKhlv/H+I0ZWA8s72g5Dbh3UXrLRvCPBPPmje2GmYZ1q2OhTJbWOiC2AjGF2T+0sUBAmMCUsFP3ohjKIDx1OZPnkApKArtthLkvqSr7VeXopyNhR5P0fjSA2Z88D35n288qUvrV2IFXx2xejxWqrVDo2CAfQG9tBj21FTeCsbBfEdvHB2haX+jctSS59crCGxM6Nw3diFTTlSyO6e89DpWajVmaFaCXiyQjCog3zbZaRw/TvhZrsqQTogNObH0pZMO9Qt9loEpUo7KE0CnsUdBuG7yUYCMUhb5BNKXU2Ga+duX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKi9IR0u/ZXO/yn9ob7ZMbJIAM68697suBFPGngOCHE=;
 b=TsNUwZbVneMD0crB0Jvl7nD5ISENT1UBCoDwNuCj9IYtXQI11KKZKojqXu14lrxH49Y9dHgVGNwjM/E9B8cuPW+IPSzsm9QX2Zl6v9BUrkXvg6/6N/ZAkwcL//vuiRi2Excz+nV3h23jAoVzhC59dUTt8PRJXuIxx4ew+gQGFA4aA59mSNPAcxnhEhCUhDsd41ZPsw2j9YG6Ie+mRqJAvdUXaaZVQ3KYPw7Fa8MHAjWblL5/JP9NB4MRjxKQ7krdOpSGmV01A2fCWhJvNeRhv0wca/fmbMYn7vYS6NQibaFF5FU/DPn2wxLT1zgVvQI5TS4stDaSgvDZHc8XGpUT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKi9IR0u/ZXO/yn9ob7ZMbJIAM68697suBFPGngOCHE=;
 b=HMWE2cDIK8RiBgtzeRRyFb+zjzWfSxJu/eH+imvGahYnGSptxLSEb2Yhs1GUNNeQTlLHzq6TXT2DJcGIz4xrwAOBNjBb1aBJUea1+LkhzPNuAfasFefKWSBDPseEOVwYlYLIqikpa5XP/ziQQVi85xed8jvG1hHmjJ6HcwSHWDo=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by MN2PR10MB4288.namprd10.prod.outlook.com (2603:10b6:208:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Tue, 5 Oct
 2021 01:31:57 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:57 +0000
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
Subject: [PATCH v3 62/66] powerpc: Use maple tree iterator for vdso.
Thread-Topic: [PATCH v3 62/66] powerpc: Use maple tree iterator for vdso.
Thread-Index: AQHXuYiv5Fuf0LtiH0aasDtq6g7G2w==
Date:   Tue, 5 Oct 2021 01:31:14 +0000
Message-ID: <20211005012959.1110504-63-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: d6dcae7e-2ef8-4dc8-8da6-08d9879febf2
x-ms-traffictypediagnostic: MN2PR10MB4288:
x-microsoft-antispam-prvs: <MN2PR10MB4288DB23C6EEBC84FBF30083FDAF9@MN2PR10MB4288.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OQEgKIY/woKISgaHBqMhT0cIL5XjoWKMR7oChNKj33gtnOvTMr7eMuk54wFi8LBT655ocxW9ftInn+2Yqp4ronUtI8ymMCWepluLBBBxzUg6BmZXtkdN6Sg3cJC0mKE4hTgymQ1tQ/iSiXLiiV4PI/e7n4ioM3L7naJMa0z6mH5PAX1a+ZwFPkyuQ18YYnK0xdFKLr9T/XSdZkKnPhM27hzULoorGMWQAwB92zXNVrFYt2CqujkKmCQSh0M51/MtVd+hxwif8mRzOmSD9pwnkGHJpSmWsOrvOytuirjntWhoAh1LWfQNKCqV0+RNkb/T9DBjx9P00AwWi0/GUk0lNqszsx8RJeej4BL63hX5z+e/wl0FVKgp0/RbNl2TVVRVFE74UN80VHeanFSayoXaSH6VvIQuCnhoscYVslG4RfEaBnqPUOcX+2L0LWNvLy5xMVYbgnBuu89MyHe7WZocUMsB1y6ftfIfCG4Q3X1FByb+4xAvE+diIZn2fMDoetQCyFum2R3hrYx1Ujl4OpmNA1XtQzJNC6zn0QyBXwQhpw3MaqyFLIBMZsFJJhUEbo3XJhG+S5w3bjffPChQ8e7gUplYWk0nJFqW8U4Sb7FVTl4MNGr9QK51OvWd8aEL4tvIHgDl9uaoRW9i4fIIOnfkO+jWiu+grZUvHEqFXFF4wbhKFjl7PnwM9XYkgAwzPgcQ6jvKAo6IiwYz0MrLcfG+Cg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(38070700005)(71200400001)(8936002)(76116006)(6506007)(1076003)(122000001)(316002)(2616005)(44832011)(6512007)(6666004)(6486002)(38100700002)(508600001)(66556008)(66946007)(66446008)(26005)(86362001)(83380400001)(5660300002)(91956017)(110136005)(4326008)(2906002)(66476007)(54906003)(4744005)(36756003)(7416002)(64756008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?K6DNPNeJq5c5c+AaF4zX8OjCeXelfkCIV15O6lQXQxG2JbPZIeY3I/maOB?=
 =?iso-8859-1?Q?oVedcwVbQJfg8wzOA9XvFd92c0JFGJ4dVUEHUb7DVVRzN8TFr0qnDRZsa6?=
 =?iso-8859-1?Q?NMOU3ZVE83rDcRWNtCp2hkmYX17RW5C1WEi8ha0PGSyOe7wZQygzEO5CTt?=
 =?iso-8859-1?Q?FihIlv6pF39hqgQoagXwKrcCJh/nZHC7r1TS6WdVCVRhcLeSGdTQeMUkjX?=
 =?iso-8859-1?Q?F/IcQzpiOhSvEaaxfvRPOk6RgJZYKHhbUmFg5xkH3YJmWPCof9Xgf4hB5a?=
 =?iso-8859-1?Q?MYThhyzvCKJ2KXtsVFaZ+vGVwOwFqaSrpf3Qoa30fRKXiweT8g8hIsBXkt?=
 =?iso-8859-1?Q?4jDVU1mTVFHzCDrjoOWveMTK2Z7GjAkZEo3S1POtJzTdMfy6hwYMPZREAB?=
 =?iso-8859-1?Q?7fVzhA6C9KVFOUCWP6iFVPi5Hgef8Mr+mbIqApJoo2mLBIL+5Ag+PRDoSP?=
 =?iso-8859-1?Q?esz0GPj1Wl9sEOJjbRDo8P8xPwz/PhAqlvhuE2IAZ8Hxl2cJnnCfHB3dYa?=
 =?iso-8859-1?Q?IkHlzOzgTgtJGCna2WuE2nhQq+34FsfyzlwmEbfBT/qB/WEfjWVr1V9NwR?=
 =?iso-8859-1?Q?9iRsMDmBDb87NhXtIKXSyl7cXuT2QTq0mVmioyF8+AyJ4SzJsRxDJqP/u2?=
 =?iso-8859-1?Q?xseFczRDSqkiiDzDZJe2zC8VMdHrhBqfoB8tYiCoE0CL85pieyU7OW44D3?=
 =?iso-8859-1?Q?PMbHLST9K/D70WjApeQOqsG2qhjtIIv6XtLoTpFMpOot5Bx6yNhBUUhogt?=
 =?iso-8859-1?Q?BORYwC74zIDRwaCCE4UB+pXCSPtBLRiINhM3uI037AdJW4d/Rxbou8TdC/?=
 =?iso-8859-1?Q?BSeLnRr9bxP8jwwRm02+DIYTgVXe3hhCGUzdZrPYo8UaWXfB99ytgOCUSo?=
 =?iso-8859-1?Q?8mZyta7nQXsQCiRqSXuRPjHhipUSsr+zMTZqAqGIIfVgJr5cr8azEOW/xp?=
 =?iso-8859-1?Q?wlA66A5g+d3OTBozDg9JqWAWVWrnbqYPP3P7bgjll/ml1nQmgFLmhHDqMp?=
 =?iso-8859-1?Q?ku5EDa0iS8TNbi+o1J+CYk87GIYUnXUctrFHMYvzzR56gOB65f0QdV/4Yt?=
 =?iso-8859-1?Q?+eucomtYJhp6x5VlaaR26Np6F2G4I1MK+ra7GFsg9KjGIQdEkayZGYfZkn?=
 =?iso-8859-1?Q?swXE9gc2C1SBlODH0MQAcbG686SBTHUauD6Shcxtuksvxg6Fqfj2wJlGBU?=
 =?iso-8859-1?Q?YwEXK1bugCWDKsIYdTj4N/KcK+EkbUrHpn4VXOZjwY9tHJ6aK6RvyApU4a?=
 =?iso-8859-1?Q?zoqr86Lq0bOY0LQwSZoziHZloNBMdBZ86iQhEhwT54fw0jkq4Zoyx5NhaX?=
 =?iso-8859-1?Q?YVZK+TJZgydZxu7AzYqrrxqJcYfYaZdTXvAIbNAClJl3+w3MMLQMSmFHt4?=
 =?iso-8859-1?Q?gYUa5PVNjX?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6dcae7e-2ef8-4dc8-8da6-08d9879febf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:14.5273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gxf/hO3t213YwMuBQeZAXw+Y5AfywWhIdignsQ4FNLGgD5+z6kCS317MwoVPmGJOKdTPVRftFNPMlENUuqDVzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4288
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: 2DvEpIYwBF9JyNXD_1z4AWCZnCi1hAfN
X-Proofpoint-ORIG-GUID: 2DvEpIYwBF9JyNXD_1z4AWCZnCi1hAfN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove vma->vm_next and use the maple tree mas_for_each iterator.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 arch/powerpc/kernel/vdso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 717f2c9a7573..2cf975a1fe54 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -114,11 +114,11 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_spec))
--=20
2.30.2
