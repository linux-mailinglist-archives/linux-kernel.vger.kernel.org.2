Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938E738CC98
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 19:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238590AbhEURts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 13:49:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48492 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238468AbhEURte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 13:49:34 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHT4xB142881;
        Fri, 21 May 2021 17:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=qi437W/o5QflSbEaroiiEDMzr+VJhZPrZhpkRgfqNdg=;
 b=KEj0hMBIK2/yAwg/CSsJoc6goXDwHrXNq58ga0n+lY2iWwtb2DcEkTtCzz/v/2UED8jb
 1zHWuRoCD7Ow/LRM44rrj4ows7AkDt2Sj5rQUjaoJ5mCQ7HhPA+FTKIAgY6wmwdVz/yT
 P5UOFZMb+93H2Z2L5PIwaiKW5m25L9fwaC+6cyLxCiNxxjccQGXPhltMzmhwnb6adyu+
 minopHUCtCzhBGXt36HUDL1nLiBhGtHR3/RJY3JsR6rDvDIbCZpMVItaKMdU1t6XBci3
 +thixi6gDWBHfVcnixjyZjzFPVA8WfI8lV9GziouVljiQAF29cLUHAOMGFP/lYW4o9IM nQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 38j68mratg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:01 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LHk0rS189475;
        Fri, 21 May 2021 17:48:00 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by userp3020.oracle.com with ESMTP id 38n4930cwe-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 17:48:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWMksOLSCPU++wt6dNb3JSZR2E0EDhxWdMkd4aCf0cgTsKs8llCOYozPasH6y/hlknGdKc+kXxd6kLWshvtxO6kTp2D7TEeO8ASYmFw9ipOGXkLYFHI+v4Fn0BaPVj5jkS3tzULXVVhIPlhcIkvlNl7go9tpBbRDelsLWgtdK0lpoj88pD4IlSf+V7hLeL3OyDq+O4qfWeWYIP7B0fdKQU7BI8EJPMD+dPz1zSF0MRBIjE3O7SIp9l/OR99VXagcBxNdihONxPEu4nDHt+yCUyRS+GyBiWm8XQVjxIoIC8xxRdIcLN78vROuhClAJBXEaqc8N9iuQi18gCArZXqOIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qi437W/o5QflSbEaroiiEDMzr+VJhZPrZhpkRgfqNdg=;
 b=aTRCxqb2qOtbviAUMzb+BVqm5qhKrUpYmYy1JIK7ALJ9O2H3tBsaz/095PIxuULAm8su/HfnVxdXs4DSG61d2sF2+Sx3a/Fk2yyKuOcTNMKCSah/77Q+jXQRniR/Lz9K7j8z3vRd6xEHQCm+OrgZh9HyhhWuiXkISyGQpbIe7OkGDQbpUUfEPxUybg4UZR2kf/kZvFuFLF+fAGPLJ0NkjnPs47aJBx4o10FpxAMmeUnmEIYfvUEYRKgqJGwfhlHz/AL8GsBlZQbfNmSMqlSHoW2m8bR11E8UxOp472rdbxzKAdSQgGgtdusxvUjxbMbEegXKDv5qfs4XVWOJq0tpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qi437W/o5QflSbEaroiiEDMzr+VJhZPrZhpkRgfqNdg=;
 b=vnXcWVpU4XBWARhMD1U88kBtGwKtWZ5Lvsp4bUZNgSDT6bBrXcOFAEkjXq6NCXZ/uIZ6E4Z95SRYALjL3tJSrXDrIPjgk6aqCbE+FcWfxOpG9o0IJk8Vau7ePRWOn1bX+WWjguAy+pUENci0ETSufzs4Ma/OCFhBEEeBw+6jVyY=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4467.namprd10.prod.outlook.com (2603:10b6:303:90::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 17:47:58 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 17:47:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v2 04/22] arch/arm64/kvm: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Topic: [PATCH v2 04/22] arch/arm64/kvm: Use vma_lookup() instead of
 find_vma_intersection()
Thread-Index: AQHXTmlvLXitcS3FrU6F1y8xQLuqxw==
Date:   Fri, 21 May 2021 17:47:58 +0000
Message-ID: <20210521174745.2219620-5-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 9e1fdac4-8df8-454a-53fa-08d91c809276
x-ms-traffictypediagnostic: CO1PR10MB4467:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4467EC6491F94C74D3663AE0FD299@CO1PR10MB4467.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EBAqKYO5aTsIUWAcp/KcL1q97AG2wjDcAYEfBFo/iHq40pqKfeJP5nBl14tqXlfRUnJlbYOUFiSQ/kzs5MyLo+1qWE2PVxANPV5cvMgU3cq95I/Jj441nTswQraYcHE+If3QVii00ShWuqKBQUMIURnZ9B0LAkcw27s+GTJkXoci/yOLM5W29ULWpMTgoDD0ui72GGtrEDZGOn3WrFm+j908LQULyEur8a1A0x/9mCmYZsSoDvvVWsPkJoJ3tgz/D84aVeHrJk5MltKK4EEa1E5Hn+WYQmv31fJevur+cKEwOe2chYKBEvkBMlm7meha0LPAhWv2BzoG6VtG3PD1UTscpZcp3LREciWcKQjUE1OZ7OZUvC5McPGMJYzPPVCi6pSmmSOsYjtKaRsKFbnl+/KsoWnoiqZeo0zslZJ17ptWh7D2yX5badNpEYf1Ec7Cq/bGHa8Yw3jBfLAv4Sny+ekCCYx33bU1Mpc5xXT7NJMugGxAdxSx7ZUZTUQe+RC3mpxu4hEI+Td1XyiBxKCDpD5jZdoc/913qHi7UTs0pN2AF+hDnPt9blvaShao4RXAHYf4CsfhEp0jcMy4rNRCw/EkmMLx0e8T2hAskNTW+oE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(39860400002)(136003)(6512007)(26005)(44832011)(71200400001)(107886003)(76116006)(91956017)(122000001)(86362001)(8936002)(66446008)(66556008)(6486002)(64756008)(2616005)(5660300002)(8676002)(36756003)(186003)(4326008)(66476007)(66946007)(478600001)(1076003)(54906003)(2906002)(110136005)(38100700002)(4744005)(316002)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?GNMDlO/+BaROo0xVN6zq9WjMkecX0s0MBxDjhMoIaTCHimL4qxn+h/ShEj?=
 =?iso-8859-1?Q?nPqmYCYi22Eea0P8TgbjIiTcEFPDmoyCIzPVvDR/IDmHSOWTEuQPVyjnkS?=
 =?iso-8859-1?Q?w8iJyyP027Dtix2zqtRE6VWX5SrVklBhtNRoyAVFJ2xW0wWUxPM/5gGtkw?=
 =?iso-8859-1?Q?cpyZcdnh6C3EfY5nOO1YSpxadF+CcJM1FncGyETbApwVS6B7XOBykJpFx6?=
 =?iso-8859-1?Q?B8sQH2kxrMMcwN3j2qelof/TooahmO5oTc7eMatBHtxwoc7GgfVpDQjm8y?=
 =?iso-8859-1?Q?LfBaM1NYTEUB7UrrzcIN79GNaIH5Km5kpeC15lA05Je/VPr7PFEbOFBdBx?=
 =?iso-8859-1?Q?7mPwNzdbiO0wWr53xtEjeVWOiCATURxZjuZJIXMxa1y5Sqs/EjSEWMZ21P?=
 =?iso-8859-1?Q?uvXOX1YAT3fm3pw8GObEef43QMCoX7L9Rq6pzmu2KboCY4u+8F13XEwWpF?=
 =?iso-8859-1?Q?syMr0WTd+cG4GnS3sJ4120hxk0AaN/Bv9UHtUHUSIG7z0cjbtU5GTrt3l8?=
 =?iso-8859-1?Q?7LiBGqcRohxUTeTD8w7B3n49ykg/d+otflQ3VsoT7DgAnLFNP6jDYmvTh9?=
 =?iso-8859-1?Q?ydXl/mfqto9jyyezjFtl1AA5Jdy+VHYEzbtnwZRol2EfMG8cMF1V0TFtXG?=
 =?iso-8859-1?Q?ISPCcG7ehFCOTsI91QPw9nINn275bJGOKKqEnh4K95pVq5lyuVw0sIkxHq?=
 =?iso-8859-1?Q?oOQXya0/zjON4fVCIaHGolJU4EX0TZCs1Nks1qWJWwjQYs0u7W7Jtjil5q?=
 =?iso-8859-1?Q?TPn9y+nje1s0ovnaIEPA1OhkEs6fv4TULaz/WO+LNbFfv40OuiuyRyPiXd?=
 =?iso-8859-1?Q?XCGniCSzrBP6TXsZh3mwfgR1R/aZNG4rqh4V5YPo4841YuoyqL6B2BlBpI?=
 =?iso-8859-1?Q?CgeeXWhAgrJEHhCwfcVdEgB2q6pgE24+Z64M1n4h33Q5mUTmELnSqzcKmj?=
 =?iso-8859-1?Q?GA3wOcTH50UjdR1O6CrOSGvEV5/m44Mf35DohK6GJL9P8uvp2eHiT2FLnP?=
 =?iso-8859-1?Q?FwbZqMCFd4tzRGdPCtQmGduy/H6aMbKlfhM3ERy7J0ZCVaAKyK46Fdcvpi?=
 =?iso-8859-1?Q?YuTDrJ+y424scxVamttfJZKuNBA0O/xkEoEJ5Br7padSiT/d2MTLdYPfmG?=
 =?iso-8859-1?Q?gDLYOevdtj/YZySgXg2HiADRt8xoShar89I0ZMIXdcZDh5NJug1QulTB+q?=
 =?iso-8859-1?Q?1mevTd7JtVZwDTZOo2Jeqjy6bhEw4+54EAalaRMEdIj1TYzvTIDpaYoxFr?=
 =?iso-8859-1?Q?3U5arCknzP6PACIcccZi8KQxABxXm44Mq9MAhTYrqvoGezZWhoyx6yXa/u?=
 =?iso-8859-1?Q?mnLxiHalknAGMbI3/ZuND2VLxItLdxS34ACih4h5YXHf88pU2S+RSGYFjH?=
 =?iso-8859-1?Q?vDGE3ClWcE?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1fdac4-8df8-454a-53fa-08d91c809276
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 17:47:58.7106
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXW78RKfkzIJAsOO5QHFDfRwi+CVVoljkAcCcieC2p5yWUhAwbx4jgP5Sgj7i4DhUiDy1zWitK9HcatTxQZWmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4467
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9991 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105210093
X-Proofpoint-ORIG-GUID: UOVTllcrUkbtTB18mTT2iUfXabLQxZo9
X-Proofpoint-GUID: UOVTllcrUkbtTB18mTT2iUfXabLQxZo9
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
 arch/arm64/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index c5d1f3c87dbd..8b112b594e09 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -855,7 +855,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_a=
ddr_t fault_ipa,
=20
 	/* Let's check if we will get back a huge page backed by hugetlbfs */
 	mmap_read_lock(current->mm);
-	vma =3D find_vma_intersection(current->mm, hva, hva + 1);
+	vma =3D vma_lookup(current->mm, hva);
 	if (unlikely(!vma)) {
 		kvm_err("Failed to find VMA for hva 0x%lx\n", hva);
 		mmap_read_unlock(current->mm);
--=20
2.30.2
