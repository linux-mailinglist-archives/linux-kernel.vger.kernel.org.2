Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDFA436DBF4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240919AbhD1PkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:40:05 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:30396 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240416AbhD1Php (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:45 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFKnmH030215;
        Wed, 28 Apr 2021 15:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KqA2FX+HosLERgG39D2VHE9Q2h4aShscf80YOl5Zors=;
 b=k96mpqzJfFcbtBmJGUWk/bR+MVYNTI2AbdGDH+gTy6L0HrrRnyQiM69eRuKYXqxuc2Xp
 y/H7eYzvDzdyLb30oI7yZZLuaz84ANLyukUrecNusg4sPTbxShLrgmXbDGyAo21xd2OL
 JKB1xZZX3Fc3QgVykx/mYMDsydSmXR8kn+Tr0g0lRWrr/ewmdV9TR0nG5fnWnBHEQ8+Y
 9BMGrM4jODR4q2F4txNlWwtslMJqEkAOnJb9G/vi2N4swIFDq/lVHGiN+E/k2aCAGXIt
 uo855QassucxGWY+CchYN8zKStA8G7vjuCjdh58fFnZ8x6n0etySjR979jQn3dgzrSlu yg== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 386mxjh62d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:42 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFY4ia022800;
        Wed, 28 Apr 2021 15:36:41 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3020.oracle.com with ESMTP id 384w3uuaea-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJp3/96mdZrKGsU33SylfJNWkf2vnOsFTQH3e00pQBgiUlOc5J2p8N0CBPTPKnXDS9lRAsId4X3RQz58B5tLUdEBSic3YJAH7eHINLHSxZCo7J35HrZUdUV72rNJfqGOlFRJsJpStkIlpVK7PMcZFeBNASH5lwdDuwYQAaP7mYWgxOWGMco2ZM+LC1zvCuTvvK9aERhMZxecrInhAm7wgcyvyp9cgGP4E9Xb45lYDg+k1SzQ2dEGwqOQ3T09m+0ASZ8NmGNPKSyULBv8y1QBb68ApwLmbUwjxPiaRGUxlPcHY0yw7BfMWpTO+39XLTPbjt5ISxE7XeUROAhJXu8bgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqA2FX+HosLERgG39D2VHE9Q2h4aShscf80YOl5Zors=;
 b=TLj3egGzewG8Y9uifgX1erETFDM8oW6qaQgplWRNwcCWPyH8FXZizLH+J1AZEmN26l+ZWz2d2nRaqFSIuKaHt48MFCxhRqfY0h7wLC7lDiQ1jpTesCEPMdKbjCuj0bmYrBODo5ZqSawE12BN+xZWBpjrXdoZTKx0WlEIEJ9y91FToiiCkobSFYzmfrFt85LY4XokUVgLHvwjjN0Nl03rUUs5Q6nzAghOPaYjiwJC+K0ZU0wh7pvg476/hy0tJdkiAyGzK44GRkByF94AhiXonOZy9MFLWt4Mlu4tcYQyuzDP/FQxo/4mLRd17TEFiVKFY1v3UgFUgdCmPemE0p7MgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KqA2FX+HosLERgG39D2VHE9Q2h4aShscf80YOl5Zors=;
 b=LTjDZhp2Y/vtcZyD2XYuUd/+45rusM79iPU8cZlr0fOc4mNLWp48rF+qCmiZOeiQfoJMZ1WjNsA+a8w7l2eoyW1OLkYIWfSQCeKG/awBp5Ri+uPgP+38oCi6C9JSzyy5jYS30vxeItjfV3NeM7FvOmyITu6p3PPQ/5IEKG7crEo=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1982.namprd10.prod.outlook.com (2603:10b6:300:10a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:36:36 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:36 +0000
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
Subject: [PATCH 34/94] arch/m68k/kernel/sys_m68k: Use vma_lookup() in
 sys_cacheflush()
Thread-Topic: [PATCH 34/94] arch/m68k/kernel/sys_m68k: Use vma_lookup() in
 sys_cacheflush()
Thread-Index: AQHXPEQ0laV57ZRGcUG3mV86G64jWA==
Date:   Wed, 28 Apr 2021 15:36:06 +0000
Message-ID: <20210428153542.2814175-35-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 8eedf1e3-3027-4827-0b20-08d90a5b68f7
x-ms-traffictypediagnostic: MWHPR10MB1982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB19820D3B1C1069DFE1D27927FD409@MWHPR10MB1982.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e2BlgCg0jMMTaOrGAaA+yZKWJyNwADbnqUGVJKQTPNfiGaworlAy6B4FXnYPBasvrYOuArjC4HNqPIL5BgAebwWTP4/Zb9k+E9/yzfZ76uOPC/Ou/N/7Z038NhApvpqxgedXltjcUUEhW9VYOEGW0yTUpXQOtiZdBkfSi9v56SNa5vLDGQtmjQXl9GjDpytWMez+eyXrzLyc3fmMCbnfR8XMVT9drpo276RLxNguGpghVu/eoCD2SXzKTvPRHA7uKOHbavq2khTbkl3mNKf2EcTH75mOeXB1k0gf5EKCgRKJEzKlye0PZiQPvP+f8+DmXgpRgLbd/bmkWIwHEAcsYhhUlIh9S4BB27jeGiAcbQxqhVJa6mCVZk5mDorbyPfGdSrOvxL6I3UhSG3d0TDI9GlcP7L+Vs4lNv6Y+Ca2n96KOOI4CjubFmidjdHZj1OS9vD8Vt9KjnsHi3Gmj5MFK8owgP+GGKmE3l9eONmZrC1Qm+SpZgLHMUwuw+iuF5Tha15aYWc5hHlAGVZQ0M6VXeUBcE0fZ+MfZ35Cg2WDkcDjSd/+B1Z5fuGMUiRY0FGUDUxPAIVaMaPG8qZWNQWJfR75VCkFPWs0Hym9rogKZ7k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(346002)(39860400002)(2906002)(8936002)(6512007)(1076003)(66556008)(76116006)(83380400001)(66946007)(6666004)(2616005)(7416002)(186003)(26005)(4326008)(110136005)(107886003)(4744005)(66446008)(54906003)(6486002)(71200400001)(316002)(5660300002)(38100700002)(91956017)(478600001)(64756008)(6506007)(86362001)(44832011)(8676002)(66476007)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?Lm/MH6Bly28UULryI3EC/m0gS7syqs+c3oX1oOUEVazkLOsiWmRcJOBCCf?=
 =?iso-8859-1?Q?Fqq9tWK9bFbX7wf9Ip/bsCi+Um7Rpwj3bw8LVOUcddhbm/pI9Sqx4LGuKv?=
 =?iso-8859-1?Q?ZpeZUZy3PKgnZjY1TGupdFlXWQj5++96OQRdzpJSWLzW6EF6NnZP939QNu?=
 =?iso-8859-1?Q?v2xcDIKJRxVzIV+TZWKF0W0QCd8d2DcMgS4aHjasFnijYlhghwMWuV/ywR?=
 =?iso-8859-1?Q?u2yL5QIYpxytwImUMCq9FVTK8puiAL/jAnyqQwHbJNzfxnkIF+aRj2RXAS?=
 =?iso-8859-1?Q?MOxKZAAPWwgXzXirRGvncjbrGCNZj9kKeQOy/fi6iZ3+rjRHF0n+otsk/r?=
 =?iso-8859-1?Q?B0vCstOECdtTNFYkl6cz4jJdmUoFVzv/jh2k0il4D/zBkbtsezGSv15Ffy?=
 =?iso-8859-1?Q?ChpFKOrC37w0CC5FPnUGvirZ1eItrDFauwuKkPqGDZUDDnP7w6QvN1whIU?=
 =?iso-8859-1?Q?+YikOL+pROdGAul7imkpZDp+SdE7auPm1LIFDgpkyOwJox5JeiU1Hqg/FJ?=
 =?iso-8859-1?Q?aMbWPjSitpULr+VA6qi0CxOpTiueK9xJ+a7vqFEBIyEQhf6OHmR7mPsj2h?=
 =?iso-8859-1?Q?IPfzBh4wPkWWeCNf4QeMsMr5FuMvWZJ/psmH4GwlbxKZ3UArRBxoSHqxRa?=
 =?iso-8859-1?Q?woZFaYKnoQJLTqrwB2hz4cM/5Xla4Xf+u2j4tMonIul97XHuGwpDliVimn?=
 =?iso-8859-1?Q?fgovJh3+LB8WbGatbas/9VCC6xPacNR0fC94tFJQOcs+kpfeHRqI38l9aO?=
 =?iso-8859-1?Q?SHib5h0hyCdjWiUx4aSy2BmhM8ektm5ZiNAZYBgLVw/oQfcpqPMaHbDRv1?=
 =?iso-8859-1?Q?AnaxRmyv85kwqNN8ybLTiToknZ49qn9CcJUjGy7zXf+Db5nlpKFGrXxh3+?=
 =?iso-8859-1?Q?YlMM1zr32gXhTR09JZhsEiPHWsrzub2e1Nhj2AZzwTK8SCoGsDjGw/ZsoG?=
 =?iso-8859-1?Q?VH+k7TFXinytnXMrhnPzdZgxZzdh2Ansr1Olh6MK4gn9jioNDU6ZLdPELz?=
 =?iso-8859-1?Q?X8ApjeKGLwex0nZw5ai7XLrXSbJAeZiE5wuK1Uay7Qjs6fZbGUatgtmXge?=
 =?iso-8859-1?Q?j3mruOOvrBDsJErVlscMxgTGl1JwAesYBbN9jC4WIBi6FvWV4nwGpzfyZS?=
 =?iso-8859-1?Q?1Hk79G2H88sLeJVGL0Tl5zt/1MVFNBOIq7rTJhTVCE4MJNj8vR4CVPynKb?=
 =?iso-8859-1?Q?v4UuurGdhmoiH0HmSjsLTl+Q//qBpsCe7fswqDM9kCNrykA4YJqMvwfATD?=
 =?iso-8859-1?Q?huPMDCY0EWxlOPP5xiphiDHE/xFpN0wY/KP4gEMUjQIc5l9TGhldoLsBM4?=
 =?iso-8859-1?Q?H1Lrrwu8Pk52SKDo2BNXsUfpT9vIsSui6qJJPkkldmqvPA9BEtTLVxmEwi?=
 =?iso-8859-1?Q?PNE6IIpSBm?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eedf1e3-3027-4827-0b20-08d90a5b68f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:06.4912
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lA1UxTlurebQnyoqeQH/JYb4LxTrswF/aTtzF4bWE4cOl339Ts+6gAlzBtCmWWpGJRZHxJ3Is6pn4pLSBEHscA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1982
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: VqAIlF__uP7ANYFf1oHkYvKJ2FxbbEws
X-Proofpoint-ORIG-GUID: VqAIlF__uP7ANYFf1oHkYvKJ2FxbbEws
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using vma_lookup() enables for simplified checking of the returned vma
to ensure the end address also falls within the same vma.  The start
address must be in the returned vma from vma_lookup().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/m68k/kernel/sys_m68k.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
index f55bdcb8e4f1..bd0274c7592e 100644
--- a/arch/m68k/kernel/sys_m68k.c
+++ b/arch/m68k/kernel/sys_m68k.c
@@ -402,8 +402,8 @@ sys_cacheflush (unsigned long addr, int scope, int cach=
e, unsigned long len)
 		 * to this process.
 		 */
 		mmap_read_lock(current->mm);
-		vma =3D find_vma(current->mm, addr);
-		if (!vma || addr < vma->vm_start || addr + len > vma->vm_end)
+		vma =3D vma_lookup(current->mm, addr);
+		if (!vma || addr + len > vma->vm_end)
 			goto out_unlock;
 	}
=20
--=20
2.30.2
