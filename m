Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E01C36DBE6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240753AbhD1PjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:06 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38948 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240101AbhD1PhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:01 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFLjfx031184;
        Wed, 28 Apr 2021 15:35:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lECJnd8TiywjHS82JufowLnbZVpPrqv/RMTr0xPO+M0=;
 b=K54dbXeBOglJrI1w4tB8RMiperSjmzx10hY8EdpSFWGBhvjwqAzoqRjKxNmQrzaYYmYE
 FsJnngTJWp0HYBe4T/mrvdCUxFXSER27MqEB4Xw9xVSyUl8Bt9TYIflqtYIGx16F9oYP
 PUa5TTKBOBnxE32rE0cghu6qXjSS9qpAgQlEBXjrojMI19qqmbr3bJUHniymQMlJeQJU
 HCrpj0TTqQp8OLTM6STuOZguvZyQs6vigD5wWBvX3Co9QzunxPZn5/VMYDOwKumS7t2e
 WDLSwVaF7IYLRDZ4RVX4rqLbD8ThtXs8XXmE08tq9NIRzzmyNkesbQupmjTcpdKR/jDF Fw== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 386mxjh61r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:56 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFRrsQ124479;
        Wed, 28 Apr 2021 15:35:55 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3030.oracle.com with ESMTP id 3848eyqwaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F/7iRs/eza8qeMyVpyniSz4ssiUK5w4au1Xo7ssVzuIW94vFjoqWdo7E6ZAL2WZ37OiRn99/7m8M9F2PhGQPgy8i9SEOR3EDu1hiAL9V2KLi4/2oVSIgeDanRCexij8fM74v8gTiGhZFvKg46PrHzUHOdV6uHuFxdHebwK2vz9ORLL2Og5zlAGBdZwVVatlXxe7JZvJCilMdvRz0zL7wWYFUhiU2KjMwxL26uMgHKVC8CSjFaZOKV0AAdaAZtFkjz8Hw/B5GLumxJq2SX6XdFaSKYgTO1O9i8tU5DPEEpGpi9/NZwlQHAvhA35itwVfKAa8L+O1B1p69sRS7Q1WPIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lECJnd8TiywjHS82JufowLnbZVpPrqv/RMTr0xPO+M0=;
 b=cLfzoAAO+WuW0b2ThRhJencnivymHheJpC+Z1NFQpy6PHIcZgoEKSySi5ZkhQTgRcs01yQpMKiULSrtRc+8JGWtIiWYpMZDkWkfqADtjrEGyRjzG6j/uirwtNdbK9bYlJblBtPUjB9obGL0objEkPBSDHuU4FlZt4t7dMu3A+yvuVEErzhXd7U+Ry4Hau2W9JxxOIvsSWeayy0UYGUaF3uXE1NWsuXZYvg9kkrm/1uJP8PflKc9SU2kNUDA/InUipFLDV1V7a2SUCG21BigbM6kpGJYFL+E4UTv3KH6DGWI1z9TnMHNoOffuY6lYMigIro2XHeaSXN9dt7LwhWw9XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lECJnd8TiywjHS82JufowLnbZVpPrqv/RMTr0xPO+M0=;
 b=f8IL+CsqqOPUfWN1q3GnKd2NAakmCpgW46URdobYrADXkitpSetw3Hdn50vTggLmNgvBMKCUXMGpKBGEXhmwVcOr1WLXM748F5QCaLwhuXVPn7vCChE9lX+bW3Oi3WdaS4xkZ4j5OAb+c6o0OQK7w21Dw5VjcP52AAoj9BAzmkM=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:35:53 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:53 +0000
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
Subject: [PATCH 19/94] mm/mremap: Use vma_lookup() in vma_to_resize()
Thread-Topic: [PATCH 19/94] mm/mremap: Use vma_lookup() in vma_to_resize()
Thread-Index: AQHXPEQsQMbt5OroQE6OmDPyzsc8BQ==
Date:   Wed, 28 Apr 2021 15:35:52 +0000
Message-ID: <20210428153542.2814175-20-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: e9f97585-1e5a-4783-5c3c-08d90a5b4edc
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769AFA8630F6BE16B8AD5A9FD409@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zlkDvGAfsB3Wy6Y9F+Gxj1ZiO6Npgb+Us6MQG677vMsjNB4OzavrViUvXdxYrKkrat7KA/MYeKlLpiEcKSpqnCvMZ/Ni28+je4IKZBOcPgWqRvHOLZkCpC4chRzibx/K/Z/Vy3wL/q8X/B4cXuuVzN4WHb97+6UjeX7+0yYp5NIZ7bR4dd7TjyqyjD5e/iihjdySXjUQmbgVs1HyZSOTyOBMmKtdXnN9Co/9FRkLuWIUQuPCpVeEkBpMM+1/FstaxJnNEgTOxzcXqq2xCqLFJdUae+oSpo4p9bGwy0jfLQwQyU/8njW5Ll0of87z1Ec/p5kDjf5o1wfSsgqSCA89TBFtzDUIf2bY1WQIDAlfrmJHjtnsPCD4GbON7/cpK5YfQfS8FMdrUfOWo4ds7PMI3VQDuu7+RActvzXuunmwP0Yu5I5tINbdKZ5epICJNHK/MmZiZIhPQRdAyu/5KuxNiZXCxdI92LKEVfOWjjg0Oi3eBWYvctUnBobO76xcDdNJz7IkFACGsRQMxMDvn8knzt5DpMFSsIc1KNRE+5l/M02T2a4AfO7Z4G6f+lNm4OVH8CKRU9esxpdLJ/KQ8IIj0P2GcTWPSTIsDtyONVU/wuE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(6506007)(86362001)(4744005)(2906002)(110136005)(83380400001)(66946007)(38100700002)(66446008)(66476007)(54906003)(8936002)(2616005)(8676002)(66556008)(76116006)(478600001)(36756003)(4326008)(44832011)(316002)(1076003)(107886003)(186003)(6512007)(7416002)(64756008)(91956017)(26005)(5660300002)(71200400001)(6486002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?DSK0q1FjMPmsKIYJroaeKDJ4ZEMnYONQ4FSJT6t4O0mdW/I26PYysuFBbV?=
 =?iso-8859-1?Q?GrwT3Bj87GC7+dnRwTpiPiQfukQaEsV7vc/1xr30zm+1Rbs8PrVBDTbNQk?=
 =?iso-8859-1?Q?EUWa5HKOBm74r4O766EYLfIeAOzYXh3BEMz+H5CSHylRtV4PlYuWZVLE9A?=
 =?iso-8859-1?Q?1Zc3dnkXwjTRkvixx46vY5Rrjr/pOnLNn29b5G4UI4aJ8FcdB/y14zGOZJ?=
 =?iso-8859-1?Q?ZObMVrpMh7kFJX/1h1c+ILxJJwVB1jfT/kLZBq9GQe4w5mtf/ipKmiKrSm?=
 =?iso-8859-1?Q?f8MVGnjth18FqPWsmYJXPIrTC7ePWBV1WziykZ6lZ1xwBuanVhQD7iE/4s?=
 =?iso-8859-1?Q?SrkXgq38XAvL5Y0X6M0g+RqTro5VNwaC/nG8wVdSylLqvlCsa3Sz0mXs82?=
 =?iso-8859-1?Q?q4yRtpnFr+YOPbR53AEMaYcp9hlu9p9DRj7dRvxwVGnypqs/ckbtcK3MoR?=
 =?iso-8859-1?Q?4NSWUhBsIlipm/RiIH+zS07C4AfZE3ZHaMrKm4SXdn9q7KlUsRkWIbavsL?=
 =?iso-8859-1?Q?JFnXrhu3KVm4FosQl8OsmOvwff2Ihazc9GLcZPVAlpahccSKmmx93fxz/5?=
 =?iso-8859-1?Q?8u/bjwjXSDYpizOZKH3578CrqxQjmCyBRMBrbOB/ntLdP4l/K+ynksDkOv?=
 =?iso-8859-1?Q?drMggTd0Y4UzyxJG3E13lDW2LKV2dU3sFNq/B74j8d3qqFWeSQpWAEOaBB?=
 =?iso-8859-1?Q?t+QtsNu0Q97GOIX+WUH3pa4XePnyWlxu4z+yNyXKrxPpwe9RzIfQli/CH/?=
 =?iso-8859-1?Q?sfrF1Dc8ONR0GcDI9II9Z7lUwEDqo5SGf4RggyLJLL2SJrw2rxZhIoQEe+?=
 =?iso-8859-1?Q?N6E4QnobcN8NBRLne7GL+FsGMsXREn857oyKwA6lpRn39UehnBbTJXVdGG?=
 =?iso-8859-1?Q?hAVBLn0kvPAjgQTezzwCivBim/Cl0e0w/yFB13TMywMjQEwNbRAcQWFJeq?=
 =?iso-8859-1?Q?2v7kQnr8eA2f+yu8A2CQiR7YGKWp5CPdycljUk7kcd7mMyl3bTIdDYS+7L?=
 =?iso-8859-1?Q?A5JMju++4wpkWIhezp8giujPE7IqMHBm6RxVfp8pnQ+sgwyx4qVwRKBTZw?=
 =?iso-8859-1?Q?FXQRA87G4HlbMYmbMItbPJUq5wwGi5VRMqphx7vZKong+Aw+RoMDnVv+UP?=
 =?iso-8859-1?Q?o2D4/isIfE6GyGO2L9CIFWszP/9Dhk89wxquPVrOsgQdiOHyRtaH/rQ++U?=
 =?iso-8859-1?Q?ynkm/0NQAMR55Ls9MvPptm7/kTA1D5GFQCjcjVGpjbaNXoEL/8k99s23QH?=
 =?iso-8859-1?Q?nPf+fsTa8lxMjDfw2nVVbXFbBoAZpDrk5tsjUKmaVAFrgRCoVUut3A+Rmh?=
 =?iso-8859-1?Q?RZPpHl6NW16d3VB+M3fY3cWIVyywHeEttrgNJQTxg/HDzJfsRwJXlrEAEM?=
 =?iso-8859-1?Q?746ui3wKgjEdV8qipgxBbKNIlQJGKEow=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f97585-1e5a-4783-5c3c-08d90a5b4edc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:52.9732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CBBtxDOeOW7CPijAZXNcz/IsNZXY5w62vf9/4zy7KnYk2BfGxuyo3NQjgizi1kfnkkBTZxesMCzok0b0qEcjbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: teclOwXV859u-ZM-JX9BMpx4z5tp7-hN
X-Proofpoint-ORIG-GUID: teclOwXV859u-ZM-JX9BMpx4z5tp7-hN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup checks limits of the vma so the code can be more clear.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mremap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 47c255b60150..04143755cd1e 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -634,10 +634,10 @@ static struct vm_area_struct *vma_to_resize(unsigned =
long addr,
 	unsigned long *p)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D find_vma(mm, addr);
+	struct vm_area_struct *vma =3D vma_lookup(mm, addr);
 	unsigned long pgoff;
=20
-	if (!vma || vma->vm_start > addr)
+	if (!vma)
 		return ERR_PTR(-EFAULT);
=20
 	/*
--=20
2.30.2
