Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD3A38CC99
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238602AbhEURtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:49:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48500 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238477AbhEURte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHTWx2143196;
        Fri, 21 May 2021 17:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=1SalLb0zqU3aSEmKlYJ+TTRAwotvFUtho8DcorVucGo=;
 b=GYq7cT0LwFljM727nnxE1jwFsYtKWdxGRQH6sdUoo8iighvDhHLfjQfuzdGyq7GQZPOU
 Pqu2nanXunWG4Y2CJCljSSkFjwfuMtTyXYuI+YIKg4xA14kPo6kvEg+VeRHgcL6n1ImQ
 dof9gatuZ9S22lWQkUB9gvYRegOGUDFa8p+LpFb+u+vrwdx868yBkS5THYfGb3/77qyi
 LitIEvAoXX692wIbwW0zLPokKyYS+d+5vCnQbrdGWKGEewJmgOCndvbOXcYN8ybupl7Z
 fU5WdwBhsOkzCTsNXGpDEsTc4erQX2Uec5JdOfgAmNs/nSIc7ByZMbYxNH22ewi6+r8s Ww== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38j68mratp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHk0rY189475;
        Fri, 21 May 2021 17:48:04 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 38n4930cwe-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXS9F310rAxL7FyzQE2dfHnfhFkMLTouLStd+CjNh9Y2uBEWdreyhJFcV+0Y09p4ZH3EK9ap9OLCoU2eyKcKterDR2sLgkEq9DO0oRpyPy/8bXnNuHMCyNRx6oX29ibKfZfy7dnYNEa8p6ErTc41YHoFny1eCznSyCpNIaB/Q/lEUfIk+wdpRVqqHNr2pM7xcu2/ha8Wplo9SLonYj1qb1qxb5V9sJNzOd0MDRkWYWArQjF5u1tQ/3Fm8xfFp7o5DPc4xYztTf0L9JRLczfaZ3FksA3ZksMOqtSoPBVx8RNejJnmvqwOYp2+FEF97MFjOsrtNhCzaJBwPNJzdkh61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SalLb0zqU3aSEmKlYJ+TTRAwotvFUtho8DcorVucGo=;
 b=XcSsxofR+XZ7SxGKnr9hRlD1xOUPpKfS5NsuGZ4/WMvAR9O4qaHZW7XWt3oTyg/BFKYQfz/HQ+3x1LjC23nA27md6mIrfp1NoYu8WX0ZEjV2Im7tB/CudePDWIYQqWLqJK2HDY+PdnoqgkyMxr7oAY4GXi29McAMN9Jr3/AbMLj2YEKe7tOcBhy+VXDkHKhPPzAUI7ppHzIk5U1hBrD2tjG38pWUPK74IQiGmcMScyT+4DUrrf9baf/G9HBsSSBGjVMkWWFfKTwrjL0pJEUjAUVAKEUQTE244nYVKutdLNsri9fKvYdLQzNjBuZmMBDRD07kFJ1LwPa8Xsotk4g2jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SalLb0zqU3aSEmKlYJ+TTRAwotvFUtho8DcorVucGo=;
 b=aiy5K5AQVFLSqZ07EQTdCBWZNF+xavb8B8J6lPmpgj3x5olsaNQ9bdo9yjup8zA6PAEKK30gbHuz6jf7wC6EPjuoY3HHTr0w+pGn+EaBpqt/68LHJvud/HhVVYNZvq2AbOrVDvoQ122heSLH4AnCbSweqBmyHAmRPIaCr7Woprw=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:48:02 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:48:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 10/22] virt/kvm: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Topic: [PATCH v2 10/22] virt/kvm: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Index: AQHXTmlxfge1bJJXyE6+dmoOjpUhqg==
Date:   Fri, 21 May 2021 17:48:02 +0000
Message-ID: <20210521174745.2219620-11-Liam.Howlett@Oracle.com>
References: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210521174745.2219620-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4a45991-cba6-42b8-97b7-08d91c80947c
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB446711308A9D1DD6AABDC0D1FD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1148;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J82rFGV417rfVR/Nf1x926sNkh8ylI1igNjZ+gREY40gBKRJ3OS0dlw+MGAKPa9HmPgEDfhHvTMJgYSbJ7y0ASFgYrtWumRTj9Rhej5kEpyHf6RoACNxuhbCAsc35oqS5L5MNgAOYslriNzCCsZqv0cyHNZV+BKEfufRhnjYzxDA1BI5ECPTM/b5XhYOnjZNLlWmbKzDYPpxopJzuM2W/FJplSo7DQu6aSbgzKBLO/iYN26mBbHYr4PbbnnqONmRPkX8l1wDOQ6UW7vJrYE/Dif8vvAv7WjewtAtDh5XJRwO2cwtgmACyKIkEX9pcOodHCNNyxxGqSTtd7RLIoFf/lcSFXpK91ig/6HBcOgdmw5IWgZTEoJYJ9MuA8obFr7H5QhTK0ht1EVqUv6M7+a9rfbF9Wojo09qJ1cVOHYetmhtN99oFq+Laae8Px6mP/SQUMLRi1hL950Yf4A5BHXIocVu3i393y+dQ8oC0wuZDFXSN9Ko85wE1PaZpTJQTtc7A8/k0dn/B2W0pcCkoIZbfZ+CgMsLqWQydtLIFWpt0+DlFWUI95H0LoptbHdujWE63O/wArAMpnXJg1oXe2sn1NM50UDx42Tzps3atvTTtcA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?5Egq2RcomEKiFc2fNFG0Z1J0pcSiIYlzCzYk5FVWBLpG3kcoF2+StGW4Je?=
 =?iso-8859-1?Q?av4AfIQw6tkRKykduU2fM59yZVZ/o34Bpsk6uFxQ07PtNBE6LsRIsSZswp?=
 =?iso-8859-1?Q?bJIrMTx7pIjOIng+0+K0G+i+aoiClTrUgJaSzxEgdHwTTAK+fE22uRUYPY?=
 =?iso-8859-1?Q?W2vxxRaWgeHe2hcohJZqKfTp3eOKBVvnjVZQC+JuLqqwbEZhEKhR0imfJa?=
 =?iso-8859-1?Q?O9qXNXM+sweppgGo6rJj75ZXvME5KBqRoH+cwRNWEsCjV6eaF3WG1VyH/C?=
 =?iso-8859-1?Q?JH5kC/06qV23aVRthKmlIW9pT8zR/LvSnq3peAGyK4Mn5xPBn+xIlb+CdJ?=
 =?iso-8859-1?Q?dyBY8j0WMpmOsgqF0vvoWPnfr2HXP4ennPE09naKOGWLR5IrfYdPVPBLw4?=
 =?iso-8859-1?Q?aPpL7zwI6yxbkjFygMpUVffmGjFB1czchFjmsY6GxExxNi868t1GyJyYcH?=
 =?iso-8859-1?Q?FluoZNai3Fc9o8LBVhOZ/qsjT8e+wA7daeY9z7/EiKg/9FLN+rkHIcJnnP?=
 =?iso-8859-1?Q?Vfppk1kxbI2E3obb7lEAu4IgLUi3oRzz1arUR9q9tKVvxAj4LT2B/UpSsD?=
 =?iso-8859-1?Q?x3/strdtAE0+qapRWWlJLz9rsfw3MooE0VSWUxfS+kEw7/hKrAdM2lHmJE?=
 =?iso-8859-1?Q?v6boZq6QySzVzOVhB5MCvqhW8dWcoAAJuqlQ83AaBD/++akyrKx77AdQeV?=
 =?iso-8859-1?Q?NmBOofJw2KOD6tNptD1MvtZRuO5arOl77a31yMWXGv6SgmdZvL6UbQlvMJ?=
 =?iso-8859-1?Q?lDZwms6775iUbftHOxCYGU55t055t2VG8Kx/kV0MUov4M7dIMFz39552qL?=
 =?iso-8859-1?Q?BYUjPaVzlLk6QOECErLlqv2vgRipgMoY/ydL0INp1mL3AHbRyXW4RexIx7?=
 =?iso-8859-1?Q?pBRDpusddsRHFQj7+yztcuxpn4/poSa/FPSc7VICHxGGEXh7u4GonYG6tL?=
 =?iso-8859-1?Q?rdRaFShxsYb2KfoSh17SkCm5hCXc85pPmTNN50F2Le1FyetVLG0bLfOYzO?=
 =?iso-8859-1?Q?PK/Jr510Q/b+A5cnJ34aUuZ1vAkOeY1cmcxMWGcGIjjTyCk7IC593SPqPN?=
 =?iso-8859-1?Q?NJnZVuBwL1Pc+ulgf2789/avnieD8hr+Qf5KFOQQc8xcvC2kkiFH/im05J?=
 =?iso-8859-1?Q?OdYGC4riwWAAo6ajqtPDXapgT1/A2lz9rSPMsNp/wZo77b637m0VBzKkZj?=
 =?iso-8859-1?Q?sIWzQRSVZVjxwQ5nQ2NgvJAVP85VVwY31gehTXNnjRvJtZpNkS5RXJnFAA?=
 =?iso-8859-1?Q?Ef9h5yXZ1w190E28lL5PWXD5xuML+qMikc2hJIXJTXAUY219oHgRYDtXJ3?=
 =?iso-8859-1?Q?suArUnWVq+OCZqUJ2JJjPS+20RMBhTXCzHUCs7uM8vDqQQ1ymZS/E71zxN?=
 =?iso-8859-1?Q?EUyfY8fFgg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a45991-cba6-42b8-97b7-08d91c80947c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:48:02.0941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qv1Ayy31ZnPUbrE/1qifzVICoBob+pmSaOihperOskgbOtQF1p8+1Vs8VChAwEmLw6NxKpraUqeijphGwjWo/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: HQ2Rc134zFuZsUlE21sID6Bd_BLOL3Nb
X-Proofpoint-GUID: HQ2Rc134zFuZsUlE21sID6Bd_BLOL3Nb
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() finds the vma of a specific address with a cleaner
interface and is more readable.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Laurent Dufour <ldufour@linux.ibm.com>
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
---
 virt/kvm/kvm_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2799c6660cce..a7703b11407a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2154,7 +2154,7 @@ static kvm_pfn_t hva_to_pfn(unsigned long addr, bool =
atomic, bool *async,
 	}
=20
 retry:
-	vma =3D find_vma_intersection(current->mm, addr, addr + 1);
+	vma =3D vma_lookup(current->mm, addr);
=20
 	if (vma =3D=3D NULL)
 		pfn =3D KVM_PFN_ERR_FAULT;
--=20
2.30.2
