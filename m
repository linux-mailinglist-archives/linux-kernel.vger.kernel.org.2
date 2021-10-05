Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C57421C0E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbhJEBgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:36:12 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20122 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232478AbhJEBeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:06 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19508Mdi004481;
        Tue, 5 Oct 2021 01:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gkR74Hz92KwKaW2epPKPK4AQxShbKVrFIj+NGFDmnXA=;
 b=BddE6vpIcSoyMU5rldd8aRiY5E1P97ABckZnNsM42rnNd6wqeiajXj0aBCy46Qk9sxG6
 wB5wWUP7NClYEuWe1b1uNf3V4FfzdMEMp5ZjAJGbjpqzfy/8E4H1EXSF22cKFH/Y1Jda
 5o0LwOG2wLdzxZf4pD2z5tYLwiF2vs7HR/G+dX34Im7AtJvP81whlI8kzy8CFH9ShQRW
 xB/pLKrVb8KyPOl8D/BjymFw22IUfEAelmeKfhki9XmA0qxeLLXDHQ3FGrOaUToNB9ma
 JpEqzoytGLWMH8a7PRd7stAQodydULQ3PZQT4+3mF15jyKS63XT8+eyya/ThNvL3hv3E Sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdGG141634;
        Tue, 5 Oct 2021 01:30:43 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3020.oracle.com with ESMTP id 3bf16s9dx1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YT8091rCMttNIsbijBQuy033nE9wNgh9tkP0W3m9MUTn4A9d5HwwdZolbD1hSCxQiLpBbzlqiF26V9jq21dC3VqjthzZqbLobksnp2c1C9YTW6NStHMu+re5AChOFPEbIItMmu1J+tR8p7rJ5I4WsaQXarZqYepNaXXN1rNaqJSeaxEzQhsAjHdmCuBrEVRPvoIhDbfhMcR8MvzIS9PRpXqZDuJb/fInsfs0o85J7Sty/M9qJj6t3rCPFSonLiN+r3QpwuzJDWcS6zk6senNW/0Qa7UD+8OfsTUrxMIec37aFKmWTO3+djoCLwzdfTyFM5GYmODmuYKsgd7TA+2+5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkR74Hz92KwKaW2epPKPK4AQxShbKVrFIj+NGFDmnXA=;
 b=D7ftK1+4isZIMrtU9iF9M0nhT4yeNXu3hrbgxa62+JCrSi+2JKZKaNJNAGQvL4FGCMj/MepZIEnyuereGLWFGqLa2nB8qFStju2S+F8a2iUp50TvEiJ3Oy3xos0fEVW9wW4gEVj+nj/trgpwn4SnCQ5ZTpywtZusTRgYEoFD0Ewe3ZgMneYs8WwBww64f9lQA9DiVBvG5pCkrwTm9RtuRHJCOBQNilnrvgA91f/bGETM+1XbUCOoWZnpooop3XdlLfk3GtCE8LcztEPkf0gHn6RYESrvhE6Qlw83tylWXC/qSHBY3OPOpRc5Fs+2NFdb201I5pOmuxqoGmshO+Zcfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkR74Hz92KwKaW2epPKPK4AQxShbKVrFIj+NGFDmnXA=;
 b=rkAbzL/TiUH8VquWhpcfZUdufg2+v/eEgLYb3ET3M8lZlK+Sipd5BN9G0CB737sXNunZRJQOQ28hE3gD26ALs47l0g2zFBduht7tRrsFJFR5S6JRiy05dNt8/c/VUgBhkBeXrJMe/C0nCGdKmtAk+esxoGqZDA6oujyy6Mp3N0Y=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:36 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:36 +0000
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
Subject: [PATCH v3 13/66] xen/privcmd: Optimized privcmd_ioctl_mmap() by using
 vma_lookup()
Thread-Topic: [PATCH v3 13/66] xen/privcmd: Optimized privcmd_ioctl_mmap() by
 using vma_lookup()
Thread-Index: AQHXuYiYovmv1g/flUmFu+rJw5XHPA==
Date:   Tue, 5 Oct 2021 01:30:36 +0000
Message-ID: <20211005012959.1110504-14-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 97e87477-4b93-4302-36eb-08d9879fbb8d
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50446B8F074D7684F6DA082DFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ahJUZX0SOvnEejF2Fo5Ak1qBSMWu0wuf4wqRKH/FvYIBcp6X5ri99fGe89simhWqMVjavpZjHyR9BbG8WzIBwZPtxCV0e47Kg5XrQIxtI3QVAYe2d6r6gTrS6yVNO2PnTUH4U5xumhN+mBnI39QW1aLGEguQABw53Y/0H3koZEZjb2lADydhRamsu/n07bnyV8UJXnZwayBqtmPufBJ+zJEEusE8R/cDs47XigGD2kZzlvQhR6rAgSBJoA6NUZwt3XJkZpTFjMYNvz+a/9auP6SggQF5T82Dg94JPoOaCJsGelj/8iqJbc0MGyqApTxXHJc+U7quT/Ei8M2/2MKETG832pAHrw3hP2UJhD82Q6s0MhsvD5t4o0yojk4lD6BSHyxmg1KtIIwxQMxsZxjgo2x9bF3o+mNl68nRhWyTNqU3eN7gC/jPSnQcev1qEBwqrYUT9dEN/2kzWWRQB34GsvRjKpdVPCC6hdaw0Resc/iSAU/1Nem11HRTMM65+UW9N/klVil/r6ziF0HaZ1UMCE0kbL2r/OA5izc6FD635LUOY42LK+ZSD3U6Op/EIm6Gw9DATGXMDnDViVyRzV0K3u2NBPat2vJIIXp7BEpXFxxowwI1p89pHk+QOUc/yvW+Qw0wEpfjsSLawxgxQzZmKf4SZzz4a4jDMbi6LFepv/61tpkQGKCYjZDT3p93rr6KIUfjZdqb2L4MMNIEXwehNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(4744005)(6506007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eqkX/xEHKc8xGhTqny747tNLkz6sKzaLdxdSZ6d8HiB9qjlfux5Qr3hItD?=
 =?iso-8859-1?Q?LKUb94vY8kIavE41g3uyFMt31UGqByLVoCvNpcSEbdgkTjZx3vMOEbFmdS?=
 =?iso-8859-1?Q?rrA1GWdAcYz0tX6WhRvBMjagOzA1vWV+smo6aYerqGxUV8tPUjtIxIw3yN?=
 =?iso-8859-1?Q?jb8UUY70MTSfzppaJjuhgM82+PNEJweFCCTnTA1i4jn0Ft/ZR5/iEG82oh?=
 =?iso-8859-1?Q?VIyMHRTfa0KiaDmLXmr2WcikZLygADhpKAWNY+2u6APz+gtHQ20CuBBlj0?=
 =?iso-8859-1?Q?HY2M3u9KrjKofQEo/8Z6M+cOjJi+24PHCRjH2Gp7jUTdOPqSKSIS8+qFLW?=
 =?iso-8859-1?Q?yGEwkHFxSk4Kt/5r8nMBEgbmegZ3ALyL7jlrKQ92jRGJdgmIAE0RoxDVie?=
 =?iso-8859-1?Q?PwIZye4zx6dc+gScRNJUv2A1Cg/7eeucDj8d9EAejRWMpBcxhjTGFXNvj1?=
 =?iso-8859-1?Q?meR6YrzWPdEwhwYYtoJdBDDJB1Rt1ZI3fib+wrlFn7K904SSwiWNrU2J6w?=
 =?iso-8859-1?Q?whB7xmUDnhxUxvWvEEo4JiVZQsy6Sb32LGm/xZAoxK0/rmfv0Csdhm7IRB?=
 =?iso-8859-1?Q?AmO+n4FY1x9G27YRBP18pOqXitcZ2l5SFNTzzknZj09gATH3arAo9jrnHi?=
 =?iso-8859-1?Q?5xvtzqbpax7jY3eo0GNA7LWJNkZ0vBClKQpvC464sqMQjE5s2wWLm0Fa/f?=
 =?iso-8859-1?Q?pDVVpWPkk9SJwmTM6riDddpwd7t/eophk/tAqcaTSzdni+qDddfphA3A8H?=
 =?iso-8859-1?Q?4PzYm78+N8NlCTdLdW2kUD5wiEcDsrP6BSVru48BMsSWk9z2LhcnXADubG?=
 =?iso-8859-1?Q?BSB4PwtU9TQAS0O1PPoA6axe+2aGWaaxhCVOlwspqDKMNPkTbhisDLfvyF?=
 =?iso-8859-1?Q?JdEcWSJtpeCu24nbJkgfhZkuRkjNZ3gQrnwc4eLXNP/incCEbNCRIE+6Dw?=
 =?iso-8859-1?Q?xjyUKKl4RL8ylwApHGbmEo9xzzvvqw6mekAJz+7e1z7P+/2iAfn1TIXTyw?=
 =?iso-8859-1?Q?VLG25uREtbKnWsmymg9+q0LLydZ12geSuFX5vXXnSRq+4VAZudlO3MvVEu?=
 =?iso-8859-1?Q?O1s65Eyibr2SBk9GE28abg/5ozpQi8OHcP7JHiXzU3J5y7yHFd0QD+26qc?=
 =?iso-8859-1?Q?hOG2NxZw6bp4zizLx7mKVfhJp0CpVYQcTLF8gWdmfnr2GfhTNEMhpcSlr7?=
 =?iso-8859-1?Q?DwiJeZBh5+G/mjmhg3wiY6j/lyzrfkgDR6ZFvO4y0c4Z36EiLRb8NmL3Qf?=
 =?iso-8859-1?Q?zcmvIv3fKOP5L1ysWr4qj0gjaJhCPZ7dMcF+NOm0+fZIVmmSVk7bRnN6mx?=
 =?iso-8859-1?Q?cLiZkr60vqGm0QQVxprLml1Ebs0MIAIQFQg37O+I+EjIsuBt7zPAqBlb02?=
 =?iso-8859-1?Q?KKKYe9PJz/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97e87477-4b93-4302-36eb-08d9879fbb8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:36.4750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MM7ODpdJxdPWiwqZIul+QNxiLh1bpDUfUz434o6kHK0pXmWk1Q9A1fo2gg3AGz9Xs1Wdrng/0mEBDNU79k/dkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-GUID: 7R-avRAXlOkuNzz0WNY3TB88BWwj0X4D
X-Proofpoint-ORIG-GUID: 7R-avRAXlOkuNzz0WNY3TB88BWwj0X4D
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_lookup() walks the VMA tree for a specific value, find_vma() will
search the tree after walking to a specific value.  It is more efficient
to only walk to the requested value as this case requires the address to
equal the vm_start.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/xen/privcmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 720a7b7abd46..5f903ae9af7e 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -282,7 +282,7 @@ static long privcmd_ioctl_mmap(struct file *file, void =
__user *udata)
 						     struct page, lru);
 		struct privcmd_mmap_entry *msg =3D page_address(page);
=20
-		vma =3D find_vma(mm, msg->va);
+		vma =3D vma_lookup(mm, msg->va);
 		rc =3D -EINVAL;
=20
 		if (!vma || (msg->va !=3D vma->vm_start) || vma->vm_private_data)
--=20
2.30.2
