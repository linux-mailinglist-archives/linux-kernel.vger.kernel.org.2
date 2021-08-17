Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED6F3EEFC1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241073AbhHQP4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:56:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5208 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240283AbhHQPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkHHZ022539;
        Tue, 17 Aug 2021 15:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=75l1O0pEP2Xo7Dd+zOvHCyADspnFAZHpCcmxQLCYSTw=;
 b=vLFTZ85b49TUTLe8p5dC/ml0RSeVytNjH2nzvyow2r9KLC8tFxH/7To7KtpVs5Bt58G6
 mYvyYhrO57H4Zz/AH+zrZbrSLHYBg5pyPkXFMqvteJxrZ7AF5VdENuvIPQxSPvBNKSra
 rDs/6ZeSQWoUk3TjgNBosUiZMk54849BqAmw05ASy9vosSd6fhKA/HzNP7YkKtCOsMNb
 8v2d4sd5BSzzrnlUM8HzjXMCv+Ep3r3FH0gA7TjQOX6kmPkFtxreJ7jyJWLYxhZPecJH
 OnRdPSFj+oFnvrGZmlpd/XrALc8yR7FzRG6uWiLFVMNIe2AZ5UgeSDRIwfXcxjY/kZWT gA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=75l1O0pEP2Xo7Dd+zOvHCyADspnFAZHpCcmxQLCYSTw=;
 b=C+rg2b7r6G++HeYQYKWog0w1fL7JPuXhfmvT9s9BsPGtA9NXrXoGtNdO6+LUGoyEd6MQ
 4zW9yQ/f/ztKMioIVaJJm2EqUKeTgkkDVU0oZ7nV5fWuxLuXHOr31Wm2mXo/cqKfysCE
 o2B84ahCjgG02cqKM/e87hESjQ3mkwfc0/SUVC9W7mNRE32BJGuBduij8eJPlEu0QFUc
 +hmXi5bAJL4QoU+drlC3M28oXmC17Nb6vjrw537mZZ2AEWXr2xVFpt6i8FwbsP8KTxjW
 Z9E8S2oSgV6yS01uMdl+UW3ndN6x5DZMVFqHCTs686euo/YSqOCJTV9EELQvkiFaI/gu UA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpgm903-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmfV158706;
        Tue, 17 Aug 2021 15:47:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3ae5n7sv2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W2nq1bJFK+hHWMY9/INMLHIEaR+6RC9g21GpWQdXFNTzqAbzZsF1sMwQ9cbs/0n9oNnU1cHw0CrsLesiqT3kgasM55mzgs1a57uv4DVTWsPrxaePt2QcFifgUkiTge6s6gLzqKOYgqEk19ukt1kbyXHbzuWd1JEpkyLm3TQDcoz6M722ORkmY1EioALCbcQaKLODB+PrJaQuJBYDJ4CjIVjNOfOiVTwgAM2k5aMntE9eryr0pJLR2l7vWBLyj3h5G96fik+e8jFLbo7jKHG86byknvuPZdWfTtYVgmufOFhHbMPMCRp4V2aNqIW1W39TubyOAOrBftHi3HrVywyUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75l1O0pEP2Xo7Dd+zOvHCyADspnFAZHpCcmxQLCYSTw=;
 b=YHXYMOMzaC6Sz5UlMNYyudRACO6fKb/kFq+06ksvZYC4yzbrxNnMq/DqF6S9ksoU2t3r9lo8leFLMGNECknP66sicsbe50CylsMeSQb9bqRe+vuCdSBKMZZfEvwRfHc+rPF+kOLT6l3pAc+pRmQzwvnx27qR6KRPsOq1pkczRVXZ7PYTFhBG53y+Qyr+nyo/6yf8uxQWvRwXG7ENMtWYC0H6zJ1b8WcpPpjFomh+B/qc04WrCNl4TGYXyxQC6YlGg1+7rXxTh3mJFtoeJviixufZJcEokpFD1cj4nwht+PZa1HIHX7HqeGAwArPFxxB0qcRIbN1u9OdS0L+k+9wWkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75l1O0pEP2Xo7Dd+zOvHCyADspnFAZHpCcmxQLCYSTw=;
 b=PNtbLEBggLFGpHhHVnYyBQp0DfSdynMDv3EWE8CAI0ptHOf2jpFnx4NmqoUEHP5IKnTjBxuegbSHMoY+0Sle9h/Xr4fxuacSAybSxqE4uHSN/P3yq2nN4MWGNDoQChVud3QULoa5/NmycrN0E06TdP1zaH/b9K6UjjHYGFfkIL8=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:54 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:54 +0000
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
Subject: [PATCH v2 39/61] ipc/shm: Stop using the vma linked list
Thread-Topic: [PATCH v2 39/61] ipc/shm: Stop using the vma linked list
Thread-Index: AQHXk38slOMnucT0Okm2ucpdhV61RA==
Date:   Tue, 17 Aug 2021 15:47:24 +0000
Message-ID: <20210817154651.1570984-40-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 5f55b8f8-522d-4ae9-8f90-08d96196607a
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB35809B4FF28E034A52D60DD5FDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lde1hB31CeBB4GUFtWcBIaphDNhU202yPMxwDXR0Z0xEz98Zpb39Y41GAbSg+GykTkkJZFLztUi7WTD08Hc5h08gbWWg8YsZaHYmq+alAkBLYomIgiFpl7s6RZnSye6j5nmwuDchnlooOzEL3l/ZWxd8yOrCQVtKDwrTRt1+FnpuHkXwPQnN0Pr6RoHIkdhmHQUi0UG3wQSeSq4MnjEZYNn/rR4GfdvG3FnHqVAVr1Dz+VwTvuNUkYjPtsfWVPBm3NBdjD4g+jJGfxsKECEj69c/UU1R+GqjH7+psdzSb6CnvhFS7Bx4sO0CgMau+o6cr1ThS7UcXB0Y1PcyMkccR3BkE3CzDx2OYvpQIQxWLRpiUptXpKwalc19m4QhEo12d112I8iIcjNmW8cWxHpy6mb1dxz0YovODSegX5mFJ83E5UeLEACdWBODW0U6BWQx5CaDqAghuEOY5w9KK2fz+//+GQiR8dwLLyuBhR0E91nLyHPYuRBZhjpOBG8OTu2n5RyRpdsVe5eAd3S8dY+CwvNW2W45b3vg072qy6neBrrj/uTnS974k8deInP9s25wWvh2Ald5EhZeBzOvG7+A2LQZMX5GzqShRErl3iSoskFRq28pqQof73dp68daprtVESeckGZ7w7wLi9u33iZCJ7/6mAc4rjlu4yGnV3t8UPtzyIgmrdOGt4fTKrICV/Qp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8ENkkVtSBHZcavfHPgq2cYw05PNpwlWjfOyf+2BoSWu1LSUWdHa1TPayiK?=
 =?iso-8859-1?Q?0rzCc6J1QOVE6s/K2Wvd4cBkgraABIcI2R9EqnwhYBbuUI6zF4e5DIwJ3R?=
 =?iso-8859-1?Q?Iyc6zw4D5FaQj9XuSf0zPXfsk958gR2MyRSJvUBL0RejsZnkyhNoRMyijw?=
 =?iso-8859-1?Q?w9t9s3z0Z0Gq91n2tAzrJwzOz3FHe+SKvl91m+brU5V3U2idK/jjPaYCPA?=
 =?iso-8859-1?Q?vO9JyP16C5JFHCw7U0eHuFLVUeEZr/ucC17IpiVKr4MZquAXRl2kTFRHmc?=
 =?iso-8859-1?Q?dRWOQLWMRO9gMbtqxESCmVdYm5Z0eG8KEZInNM1fBGS5D5aIDqIlwa5yEk?=
 =?iso-8859-1?Q?sKAm+6DfTXzQiRmnn6rRRhhkVEmeQVYrh0rTBy8OTJ0TTf4ALwpsffT0i0?=
 =?iso-8859-1?Q?ZSH2XJWwRcMHKwDx9JJJhskpsaWuf10xjrR2w9VZBA11zdgkV/RLRCgwQV?=
 =?iso-8859-1?Q?HFExRNrzE6OJA0v1ey+EEF58PjwqN5x0xq65pyBuwk4XMpTio2EptGrqsY?=
 =?iso-8859-1?Q?jt7XpI9sjqOoreIwsBL+BSgIcTmS72hXmKqJEZ8+lMQyP2RAps27iHF7aD?=
 =?iso-8859-1?Q?iOxMzofBxtR/kJ+teLAzdqYROet2oX4J8wEQgdHbQ67pYv8fQesIpSoeZL?=
 =?iso-8859-1?Q?kR7dBLG5myf8RMVcpsnHbd77oKRex3mmFfKUHg9UFnvW40ZEq0drAAcbWD?=
 =?iso-8859-1?Q?uS6DUFlmlfZpnSfTBHYbsDWJ4vHxk7EmBzYfiIby/NRt7WdoQAtAL8ucuk?=
 =?iso-8859-1?Q?YDxkVppumPbaa5OJYrfbLZxCVEq6ikt1aGtgnbhxDazGbP0AoldLZ34QQr?=
 =?iso-8859-1?Q?rI5AY4tjHurbV9Z1J/DlbkL10Z5y55sL+UTZbeComOtZmrpk7le7VMSrtH?=
 =?iso-8859-1?Q?rApyd0R31QfNKIndS8bi8NapAajnIse/R6IKQNJTpBgVwfdO0xDS7Nul4+?=
 =?iso-8859-1?Q?swTPv+Q0tteXq6X+ww7i3qwS+e2mEZYM0FyifmupJmr8THWrvK++BvHS+3?=
 =?iso-8859-1?Q?h5rloLAWXKrykwBzx3XB/ijOwi4nCTlvnHrMGIGjqj2WNCjw7+l0dwKKjD?=
 =?iso-8859-1?Q?ybMmxpd3eCxYU2ouecFDCrsFSi8dZY/Me9q7W4DNi9bsbQr3eBRur+nlh3?=
 =?iso-8859-1?Q?TSZI4qCWgPT3czJ26wMJjVk5JbJ+MAxRQZY64sBbjKzJ1ylq7ZQoe6LwGf?=
 =?iso-8859-1?Q?5y8FtfCxpZn0/C5m6TMZYf8YidluhSFaAnM551WEb9aaFeP3LwMbgg33EW?=
 =?iso-8859-1?Q?CeNjkxRF647lRb30ThyRYaNL8qOrqQaGlmGAGQso4radnqfspy0wGwErnJ?=
 =?iso-8859-1?Q?LTlRKiZkY2ytk3QVShfBdQ5DwbEcPGEcmsUYUl/V/xNrtdbDmxvwYe3WYb?=
 =?iso-8859-1?Q?RiYW5OJTP4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f55b8f8-522d-4ae9-8f90-08d96196607a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:24.1851
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Isqt1omUdsgAdDcDFX8o8PERR0bEh3W7XaRJoyNHiUMu2fGdg6NNBoVyPOUcI+Fw/Xv/AWQVlz4t6Cr10VhC6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: 41Vy7SGjj1YResPiugeK_D9LMgJCiIix
X-Proofpoint-ORIG-GUID: 41Vy7SGjj1YResPiugeK_D9LMgJCiIix
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

When searching for a VMA, a maple state can be used instead of the linked l=
ist in
the mm_struct

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 ipc/shm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index ab749be6d8b7..ed6628679679 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1631,6 +1631,7 @@ long ksys_shmdt(char __user *shmaddr)
 	loff_t size =3D 0;
 	struct file *file;
 	struct vm_area_struct *next;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
 #endif
=20
 	if (addr & ~PAGE_MASK)
@@ -1660,11 +1661,11 @@ long ksys_shmdt(char __user *shmaddr)
 	 * match the usual checks anyway. So assume all vma's are
 	 * above the starting address given.
 	 */
-	vma =3D find_vma(mm, addr);
=20
 #ifdef CONFIG_MMU
+	vma =3D mas_find(&mas, ULONG_MAX);
 	while (vma) {
-		next =3D vma->vm_next;
+		next =3D mas_find(&mas, ULONG_MAX);
=20
 		/*
 		 * Check if the starting address would match, i.e. it's
@@ -1703,21 +1704,21 @@ long ksys_shmdt(char __user *shmaddr)
 	 */
 	size =3D PAGE_ALIGN(size);
 	while (vma && (loff_t)(vma->vm_end - addr) <=3D size) {
-		next =3D vma->vm_next;
-
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops =3D=3D &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE =3D=3D vma->vm_pgoff) &&
 		    (vma->vm_file =3D=3D file))
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-		vma =3D next;
+
+		vma =3D mas_find(&mas, addr + size - 1);
 	}
=20
 #else	/* CONFIG_MMU */
+	vma =3D mas_walk(&mas);
 	/* under NOMMU conditions, the exact address to be destroyed must be
 	 * given
 	 */
-	if (vma && vma->vm_start =3D=3D addr && vma->vm_ops =3D=3D &shm_vm_ops) {
+	if (vma && vma->vm_ops =3D=3D &shm_vm_ops) {
 		do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
 		retval =3D 0;
 	}
--=20
2.30.2
