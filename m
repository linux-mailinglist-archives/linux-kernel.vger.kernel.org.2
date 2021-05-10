Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8703794D5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 19:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhEJRBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 13:01:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44994 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhEJRAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 13:00:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGscI1166697;
        Mon, 10 May 2021 16:58:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=qEEN6JpA+/Jx2zY9S3kDye8EdDVlS9XsDlBimRtPqTk=;
 b=f03V77aY92ARx/PjLbDDneiWqV4uuGdQbx5Bhgwha93rVJusn++1cuP25J50NQaVikxH
 MvX73gFYFGLAbH2vDbKg2veQmM4fyIXyvhqnPntlwbd4ZSESl/0XQfyWLEbltfKshPX/
 ZfQJmvgZ4q/fYqErVezbCTFgEh3HleHoMJinIi32mO1H4IUE2TjfWBm6xu2opghYr2Xh
 AWqj6kTGQOgbIsRJCcKFoI33dLx+yqblHgyWERY365rSpbAX2bYSPrLJ1b0PFkTjNyZh
 Y18ldWM6jbmwQIEs7frAx5+ItDmM9/90EhpV6ce47NIgvp+RQEqojkaTdzzG41aFoeCk Tg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 38dk9nbx0y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:56 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AGucHF109288;
        Mon, 10 May 2021 16:58:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by aserp3020.oracle.com with ESMTP id 38djf74j6a-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 16:58:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzKBXYHVSM44p5ORpRRsZBmKIXN+MI9+39N5/pPSnjkyxjX6494BWmr9j3Blelef0vwHy602CDn8vKWTXI6rfr0XZXc8Lg2u/I9w7luBhrJ+p69HgziPIKtHZ4zjgaNXCgJqPXXZsq3F9oqpd9QZIO8aWGc+YvVdvxOFxfoJQiU6/RaXkLlsixtoPbczuysD9W5Uc0oGL9KGnpmQl+xIZfyUguUOW3MdLKLHp3SZhDG8whRMI1imOinfMKZQe/qgXVMnk295xcBSFKsKcxOqFcqjRWel7wvoPlI6Jb2gT/y6QrN5aMNRu7T8LSD/fzLgFPIvEOzyU336/Ezjj6HpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEEN6JpA+/Jx2zY9S3kDye8EdDVlS9XsDlBimRtPqTk=;
 b=NcKDSAgOKdexh6DFyBiho37KCKxD3YB24CUnNtZQdG8wh7SbGify2OgrNNdMYHtZUbFX0TQ/X7BDQYo+/7fKe2Ux7lyPmMSGQpq3PQQ2EGy5QVHp3oH+PR+qL7GSmhmVSUx8sCr2M7L0KL46dPDJeBZKsatwLiMk61y2NiirnZu7/VbfOrClUIAb9ElkDYzNkoJqOkKOJcuyr1bkbOVm2y+q9+rnWVVqP0pMqa31c6nFi8j6F8H2zzJKY9zbK3xWFvQjRWQyDxhhDgRb/AlUvuhyMJx2tvVBvi/Za8CnPu9HWTh69c13vL2GWf61UVrN39waVxavyg3JBL0t/z/9lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEEN6JpA+/Jx2zY9S3kDye8EdDVlS9XsDlBimRtPqTk=;
 b=hoMqzubZBS2dehnXdUMz/BXTSCyKX2ucOk19k6I21X4LOAIbRkSdNFujNtPKJ6pRedrQmLOWQqWocP3YwSWrtTJbBaFJkzJN3a+qBRR9vHPdgThDB9GIgi9qPuziOpjAyDWTF8AFcEDtveSqJo3rxyaiZ5I/8ZatyWzmR+Py6hM=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Mon, 10 May
 2021 16:58:51 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 16:58:51 +0000
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
        Michel Lespinasse <michel@lespinasse.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 06/22] arch/powerpc/kvm/book3s: Use vma_lookup() in
 kvmppc_hv_setup_htab_rma()
Thread-Topic: [PATCH 06/22] arch/powerpc/kvm/book3s: Use vma_lookup() in
 kvmppc_hv_setup_htab_rma()
Thread-Index: AQHXRb3Ad6a4YwErt0GGp96qORh04w==
Date:   Mon, 10 May 2021 16:58:51 +0000
Message-ID: <20210510165839.2692974-7-Liam.Howlett@Oracle.com>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 59e6b3d7-70fb-4d0a-a4af-08d913d4e34f
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769C7EFF1437FEBB53ADEF0FD549@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: k/S4V/uilntXgUKYdEhtrNVO1xMl9yqXMBY5Sf83fHAO4EGk9t+QFd3nkuURafEnKqiwC+9kxZor9hsKg1CGO4G6jseWLQf5frMhb+b/ah0r0XbkwwyEXsLhacseHSdevOTKudqKaYNL4Oq9AQh97rnfO3aH7V8ikf+J+ibeQD8Izkmto6gcOIcNpo6E1NIEI2XuiMKvYOaC7mqmGMR9en1R5DLtrSuzqZ/HSwB17EsC9AqvpmEzCMF1lkQi2emEeZce/2jut0uqffj1LwLPKDlloaGwndAv7QzncE+XLbOIETliyJfcBl4cy3WXmkOoJs49xHKPu9Zf/fCJnEvVKJmyf6Ik0E/L/TcFISRViROmFgVFT4BWaeK4rnZagLWmbs0ElR+TnuQ1U21ExP/wJLV6+JOW64+UDb08qUfJCvSR+4u3sqQ0+BXqcgLVndreQlGgJNV/3qOybAQZKLe0K3VVIRa5QFsPt8WFyrnaKWY2Z+i1VSN8oJLzkWef7TbSbdVTBZ0eBzGzKoLG4XeZ0mYB9P05JKzAGpM5J9MrhNwCWgbXQX84y6uw5dA0WlIJDE/C1/V/MpotghguWvQCQ5B6/56OI/ZakSm8bJrVSZ4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(136003)(376002)(366004)(39860400002)(7416002)(66476007)(64756008)(1076003)(110136005)(478600001)(38100700002)(122000001)(54906003)(6512007)(186003)(2616005)(107886003)(36756003)(66946007)(66446008)(86362001)(66556008)(4326008)(76116006)(71200400001)(6486002)(83380400001)(4744005)(6506007)(8676002)(2906002)(316002)(26005)(8936002)(5660300002)(44832011)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?hTXPT4DLcobmVWF7iNhtKSOyfd9TZ7vJi6XE9OqyxPStFOypbemBCbXp82?=
 =?iso-8859-1?Q?q4njp4EslnMW0LNguVOBgEgNxH9eiq3SAp5pwH1ZUrEewhKNmslcYbY7r5?=
 =?iso-8859-1?Q?vlEZlsgNZsp09cBHpMz9flZ25h63qcpWI1ctCnhbezm4/tMzCYbJOGKDeh?=
 =?iso-8859-1?Q?9WUNbG8YdgWwh5j2FWNVbygHshxUgFAxydrEov46ixcuImdPjgfQt1nrwN?=
 =?iso-8859-1?Q?o6lHskJUzuVYPsDeebX5ifsZnDEJgzA9jKY4Q938f88Q5jFj4ewxWoPNMV?=
 =?iso-8859-1?Q?1JYn4IxV8vTedUwHu8HbXpxIpx9Zeli2yBhZP9g59sqUxP0BI6/RhCSq16?=
 =?iso-8859-1?Q?M7qs+BkcftzVYABUTgetvI/+BuB5u7vrk7ydZlN/t9+9PQzrgQtHmRhqH8?=
 =?iso-8859-1?Q?4pnva19HW6hk4Zg8VIYU6cAF03Rcy23Pi+2ULc2oCxekCA/HblEjwXOswK?=
 =?iso-8859-1?Q?7RehkpEU7KJ9C/2DwX08aer6BHUo/hbVOXSmAddT1NZSFUOEaxKYf+3dyw?=
 =?iso-8859-1?Q?S6nfCpGe55hyGF8a1tmCXkkIxL17fYtCa0g7FDdnHLwUdz4ItrT4hjV1wo?=
 =?iso-8859-1?Q?+3P2I+La6DOmrLF5bxdS6J8a36lTxNtzU2ax7WFCgJJR8cHugVFTP3u0Gr?=
 =?iso-8859-1?Q?TOQMV73bAzq7X2/Wkw0ivSnjemndENPPGc3l67f+WtT6evclK+fchNpVR+?=
 =?iso-8859-1?Q?Rn8gdvSigX7XD/lvmA1w5db+v4uWfkMFhwuhY30mOpjvWmBSIoznWa43Nj?=
 =?iso-8859-1?Q?9ylq9zjrJu+q4DzuVu3QO5KMdBFEBrbmUonccC3N1KqQKjw7V63uHVr0YS?=
 =?iso-8859-1?Q?1XbnISYyBlNEzj1ArH5lfYI0hns0H36alZKRqNnTb851cJQq8pjTa+RiYP?=
 =?iso-8859-1?Q?uSyXI/OrmkZFKObXUi0Qb6lIm04J7JgB23t3amODBue4aFLl1Luix62h/Z?=
 =?iso-8859-1?Q?mpimogu+QTJnweYIgHatAhSvEc9DPhlic/qHA6sn/TkwbqGMPomnRxtGYv?=
 =?iso-8859-1?Q?mP64QKC3mngVlBzxGHL92tAeodBnL+yRmU9HXR0zW6iGuFSjE27NQE+Y8/?=
 =?iso-8859-1?Q?uQAWlyF3rUBWR/fuQak8/lcEY0ZDH/OUT6lVnl4GivIL1sDA6Bab6ZsnV5?=
 =?iso-8859-1?Q?iuD8x0qbzP4PJxS7mdYkEs/F6/27mqrZgmGXj7nTWYoXuvBoXa5zSsiCZp?=
 =?iso-8859-1?Q?xCPRBGt/RUm58yoOtanKzVB9q9IxgalMv2DgZlpim/Ci3SgvAlXfjiwT0m?=
 =?iso-8859-1?Q?uuahYDzAX+bzCndLUTQiCiBkxjXlt8sx2iLj0RTfMYd7tMernI4d+2OtJh?=
 =?iso-8859-1?Q?BmPQcDk3sS0+oqR3dLDTgNH0fqyBNHDpOcW+qIC3AqjoY/lZb21fuE6ABW?=
 =?iso-8859-1?Q?BJV4JpaKP0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e6b3d7-70fb-4d0a-a4af-08d913d4e34f
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 16:58:51.5598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQw9uBipj2g8QRyUyx9IEFe13+c3MB5GqZUQ0R6JxAeDz41sZ8AUakhPUP37qmtA/USqbanQ6pTF+ri/xRWR8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
X-Proofpoint-ORIG-GUID: JRMTe81_F5uDdhD_RQxHLLXbg3eOvgGM
X-Proofpoint-GUID: JRMTe81_F5uDdhD_RQxHLLXbg3eOvgGM
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using vma_lookup() removes the requirement to check if the address is
within the returned vma.  The code is easier to understand and more
compact.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/powerpc/kvm/book3s_hv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 28a80d240b76..a3a4b2179350 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4759,8 +4759,8 @@ static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *=
vcpu)
 	/* Look up the VMA for the start of this memory slot */
 	hva =3D memslot->userspace_addr;
 	mmap_read_lock(kvm->mm);
-	vma =3D find_vma(kvm->mm, hva);
-	if (!vma || vma->vm_start > hva || (vma->vm_flags & VM_IO))
+	vma =3D vma_lookup(kvm->mm, hva);
+	if (!vma || (vma->vm_flags & VM_IO))
 		goto up_out;
=20
 	psize =3D vma_kernel_pagesize(vma);
--=20
2.30.2
