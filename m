Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7721B3EEFB7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbhHQPzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39242 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240337AbhHQPtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:03 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjeMG011246;
        Tue, 17 Aug 2021 15:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=mRf1ckOpT5rniYOmHdL447aeME5rQ6SgAzzr/lJ524k=;
 b=IoacFKY9KboSz073f+uxOcVkWoTSiJCv1XC2EHM4/xhHqe1PKGALZNQ0HgzgbM7aoY1Q
 TxhPer0oxXZ1SHzMni8yqoVMyOPFVOx7qo2p8zvF4bwxz96IBLHsJ9jTV05R0rcFqB3C
 KWeV9uec2aIWHuen5vIaesraS+dXjJp29uEHO9ywEz4zpaxzWmljVK5p4k0ugzvYx4F8
 PGkzU1a/pZsjdvVPp6zATNyJeZ6TVLWM7Vm59MN+LMsj/Exk2UdIY/qnZwhNJ8C6Hme5
 xYwmLidrdd0/fSVa9jfqMlN1QukIRz3p06+IaTMv9kqqNVQSAmjWxeOsam1F8sbgXU6v JA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mRf1ckOpT5rniYOmHdL447aeME5rQ6SgAzzr/lJ524k=;
 b=Kw86JTA0TLFj2eZkxUxAUlmiiNXW3AuLHQIVZNvWFJttLkVLcO9UiAGbZSM8FbnrPAip
 qN4+9fXeQX2XLwZRPhW/V9+tBsAQSGggvl6ftdv/1uK+zcGVGlQ4H2eMaUvJ8uXZWQs3
 uZDrrV7rtRsc79Zl/i0edqbdUnKKq0jlj3su51FwpKi+STdPROw4phLxE60EJSYb3kPq
 FKjtRFYYMFAQbyPrexqbPvSbNXysFDmn9vUnrk+XYpF8N0qpCu5hOwQC4wdI1D0O2r4r
 x+WYdtqpcIe/HStLAZ7iu/HOwqOkwsw6vxpMLsnCIejuMNIs+fJdoL5geqbz6NlGjnAv bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7d8bvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:03 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFj3OZ174039;
        Tue, 17 Aug 2021 15:48:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3030.oracle.com with ESMTP id 3ae2y0d2r9-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BikPvbWDDoah2PlJwVFmhJyXXzHSlvi9QDP5K4ru2A5RgP4TXBqRLDL/eUm3eTKpi1OoHXn8aTBR//0gI/wbu/L0ZVKTXOUcxQ4t/j+Aa5cYIB4oAWD2/8W9SY/wQCIpsrqlBtBPlLtMcI9XAcr/cm6eccJeUTFw+zIGvWLC6W3caOBvgJuG5qtQeFq1otBTMrwXu022lKfwecKnLX+Wum3NX03IxS+XfbL6Q4AfGSC7UydLFaBGdY5XRWznbl6oLcFPDKRfq3XEBWdakX7Y/i23sO9EuwhZdW2N8S8aB7qqMB1SztYt6WNR6gJhL1zKVWhl8mFC7Y0gY/wioT1vHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRf1ckOpT5rniYOmHdL447aeME5rQ6SgAzzr/lJ524k=;
 b=EOXgPhIUU2wmkSNWQuvWGkhm+I2/D0JSjL9YVra3q/mzFl7AneVaUZTNUC7AFXoTrT1XOsHd/h/nWqn8KXPGu4g6wjcBnOr8Uw5tQwCr9wL6/EAhhhTqpOqtj2KjzePAu/O2Oh3TZC9XEBelOoAqAqUWE7+spiclXrwBCWaEbfp7naDOMNE0+z7qzo6VfsN0qgVZeLiD4YO6WIKD/IYJEgHX1BDjRWa5JLXZ8qMaM7a9l0RlOVXL03JWXYMX1xS5QqVnJvGTXtutf1OrPUkrC8gj9nYM/nrDFgfLjhUAyQN1D3v0G4KXWVUIigZhJOD83YlbAPab/ym65qWjNJ9jtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRf1ckOpT5rniYOmHdL447aeME5rQ6SgAzzr/lJ524k=;
 b=HV9FLTZ4XC2hA5jag7QECiBi9nMhfo8GxoVYnEud20WnVGq6t/Hb39Aeo2XczV51sNk3+rTnwP6w7Zw1hM4+xpJbnB34dNfN5+wsy8oKLV+PEekABIMRHuPm7rI/Qzo8K4GCacB7hAUPYCaJjSW6SlM3pmlQiLJ7nlLXIbic544=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:53 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:53 +0000
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
Subject: [PATCH v2 36/61] fs/proc/base: Use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH v2 36/61] fs/proc/base: Use maple tree iterators in place
 of linked list
Thread-Index: AQHXk38rmFeBSXYzbUykve7pqN5bBA==
Date:   Tue, 17 Aug 2021 15:47:23 +0000
Message-ID: <20210817154651.1570984-37-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 95a14da3-e619-40d1-522f-08d96196602c
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB4236649351000C3A2757F5A6FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IeyJaUiJUswDzLdHnNtYrAKgctwyvLR5PXa/Vmplg3a9BxCbmjWHo/BvglNZqBHIPxQlwM0tisQivZmPALzoIFA+IXQSlt6rv021MQ9OFGt58b+L1+k6E76rIUnT/GL+MuAaLpCRS8aFsxyX5zPH69RhN1lR/m33Gn1framTF8qEHCtss4/ROCzCVfeNxIKY54Ae/usMETkhLTZ+AbJUBtGvWJYXXl5ZpwYf0fO7hbCoLG0XSFYqaaDPxIaPUZbIYvN1NcoyKIUQdITn+lWqHW19QbqMJ3hVJvwjYGsDp6pmzSWaJxK/XWASOBg+90baOiJszaPxwt+YFjy8UIfgEPT0NZy9CZJDjt9Z5qnvWL5fH6wu/0b8T/oHHRHm3sk93BjvxI0eAKF3YNaz6riN0AisPYd/m3sLQEiPSTvZ+q9XIBPq+zSFR4tAhWlkCoGZa5SYOI/ynhBNuZ1azSbvEuKRgmMSOY4JNW4pSqING1fqvMweQoOGlPwYiuTpXU3W3DLK5H45wERhKEye/lSwPMx8bzPrLQG+bCEQJjeIj8a0cJDmJr8Nngq1UAabffGfwWpqfXV2NCoRaeC1VqILGueEcCSI+Z80Kvuxk6+1sDICVLmePPpjs3jqkXu6QkRZjPq+m5uCJexYUsrb7LvjolP1Y5jAOy0yW/YMvqnJQckqS7u74MGMf6HUvGhHGoyB73zSJWsUD6ehHVkG8QTTAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6666004)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZGRxKXPTVFDCqTFTOVt/ftFRINcUro5IYRU4nQ3Eglxy98auG/VIEZSl+h?=
 =?iso-8859-1?Q?eHNcFHuEhpLIjdB1zwaeHeM00LSQYnZBw7yOAnXucAytdaFCvTTGeHOTDb?=
 =?iso-8859-1?Q?Y9cGZhN65xRpbp9BrFIOQRFymzuGEScn9OzlM1ZiV/A6NbiHH1nZHvpuUn?=
 =?iso-8859-1?Q?dvubCK3cswiIeYsu0cXZ6Nn2sgkBMcpNqCvSjDw7iYqhXLc67I4zODiThU?=
 =?iso-8859-1?Q?eKvQjlo3kFILA58p3Yrhdlfn3wU0QRVMKmFCt9AhCpETClfLOAkdM4L+o1?=
 =?iso-8859-1?Q?NI6vnQjZp4grI6D8ZZHl6lo4E4CsuKl14dwfz5Sjlp/Gnf6+jpZmO7mizp?=
 =?iso-8859-1?Q?HCFEJtNpq7hSWZC10Ye6VWdtIXzFEQjkZZ0SszdmGCqrJpCAw7hqGX2WHO?=
 =?iso-8859-1?Q?nqTKDMldfBI+KTu4COcU5FYrP0cIZa0gX380calvZqdO2V7p2AUB0ILdXm?=
 =?iso-8859-1?Q?SSDJifT9Pup3sRyP0GjrQXIzJr/uIxkeio3XVBnJnyvkBaFxGg9abBCyTO?=
 =?iso-8859-1?Q?MXyHl6yNYtTaynySsdJ8Egd/gwphqDwZ/d9w7b/V4no2hZfQ5aWV9DZaGi?=
 =?iso-8859-1?Q?jqxSbu4IbcABs4oy/GuHEDgmAGuXwOt+wQi3ZzPPw8jPoKgp6RvlyayY84?=
 =?iso-8859-1?Q?+8VTrikRH3J9Q0gwhhQd0dEDhfJy0feIMLzf4akU8VO5fJ0lZ027sqtXIP?=
 =?iso-8859-1?Q?J958SDh+z99AQ7CqGbz9wjFvBRyffVkhLKfQ75QP4MWXyOBpsaMV8gDtQp?=
 =?iso-8859-1?Q?XcoD5rNwHgN6gZitPHbLUnKT8qUIIXEKMOVf0YFXIOiBD8QY5ofhF2yBBs?=
 =?iso-8859-1?Q?Uf00nT38NSf4LNwgZYB2m3ZxXiLjONwKQVsVMErEYk7EBnEKbMyZ09ivpe?=
 =?iso-8859-1?Q?FiSiQ31MAaZYqnxYabDXLC3tWo4lwyaOVrwxem4OXEkZHDu28zsAlBjijA?=
 =?iso-8859-1?Q?Nuko6A2NXX9tgfnxoUvqBvV1aELN3qYOsN6ryZn0v+L6wFNGwxXNLAZunZ?=
 =?iso-8859-1?Q?KRxot70Sen5wXpDc+SgH6UjYWMrxOTe1srju1NShM6qABBkoz9AW1OW7jE?=
 =?iso-8859-1?Q?wbj07qESNr0iYfLEhzoBcQ94Ps5uHy5FNUezAwcgnvPPueQ9031SQZ7wZI?=
 =?iso-8859-1?Q?3DKlIkv42Fdp1KmGz1YnDesQRM7IB2+G5gz74gXUdurTCdSqeuRYJ7MAWk?=
 =?iso-8859-1?Q?eY2KRzPoeVu8L2HvNx7tjvjGaD9uGyX8k/7RkZ9GJChgjBT8NAWHUb0zn3?=
 =?iso-8859-1?Q?+o/WtOYvy1tL2cDfmQvTkzq5CDUXCpSuhBH6NC7Fw5B5yFLIFAX/163Ybi?=
 =?iso-8859-1?Q?+XSeRJnLOc6xL4NYOdBffq96KQ/m1no5uPvFi1oL2AS7iCABuP0J839t+T?=
 =?iso-8859-1?Q?LjV6ABjP1z?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a14da3-e619-40d1-522f-08d96196602c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:23.2930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +QKSIaFs1y0EPlYFadeOwXv0IW8dJCcn3ZAMG7Rcy791MzIw7PpBcE9X9jKbktvPEDLDB1Lem1lQ86jiSdLppg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: -aNohN5PQ-tU3pBj7ZR7su0eUFVY_8jA
X-Proofpoint-ORIG-GUID: -aNohN5PQ-tU3pBj7ZR7su0eUFVY_8jA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/proc/base.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 533d5836eb9a..4f7e7c8abfd8 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2318,6 +2318,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	genradix_init(&fa);
=20
@@ -2343,8 +2344,10 @@ proc_map_files_readdir(struct file *file, struct dir=
_context *ctx)
 		mmput(mm);
 		goto out_put_task;
 	}
+	rcu_read_lock();
=20
 	nr_files =3D 0;
+	mas.tree =3D &mm->mm_mt;
=20
 	/*
 	 * We need two passes here:
@@ -2356,7 +2359,8 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	 * routine might require mmap_lock taken in might_fault().
 	 */
=20
-	for (vma =3D mm->mmap, pos =3D 2; vma; vma =3D vma->vm_next) {
+	pos =3D 2;
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
 		if (++pos <=3D ctx->pos)
@@ -2374,6 +2378,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 		p->end =3D vma->vm_end;
 		p->mode =3D vma->vm_file->f_mode;
 	}
+	rcu_read_unlock();
 	mmap_read_unlock(mm);
 	mmput(mm);
=20
--=20
2.30.2
