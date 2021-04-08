Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05CA3589D7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 18:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232304AbhDHQet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 12:34:49 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58896 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhDHQes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 12:34:48 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138GYDpL180010;
        Thu, 8 Apr 2021 16:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : content-type : mime-version;
 s=corp-2020-01-29; bh=QRw7nj5zDuneYlTyq4bGBTW8Mnncx7M55LMm35xFiHc=;
 b=GZ4Kzs5k5fw6ImwZGLXLe3ieG8ldbIKIi06f3Y9jUWae4MjRGF9qS0hb/qhqBnkoFTDk
 GKrGh+fIq2UbBsbjvp2o1DdpW3tViX8Lbk8Qm32SJ8VuX5orWxFEFDh3njGuG97t9D+4
 t0jwMbwbLZeXhtlKM/348YnpmbkUJ5o0nqzAmT0l6zLt3sTgU8J1/PqzXjSG0AJIO/K3
 gH0FmQOHu4sqDmARq+x8I2fbHu8eDlZPy9UcSiqVp6UykJ2Wvy4ovRC1Vn8rgbiNe7OX
 evubGdUET3iG3SmvSxG5d0q2/6kqlqEUL5P45IRhsRFsCarDxanjnLOugY6+AulDsw8H Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 37rvagejuf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 16:34:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 138GVAcd190140;
        Thu, 8 Apr 2021 16:34:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3020.oracle.com with ESMTP id 37rvb1e89s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Apr 2021 16:34:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GpJaAEnXkGdOFxXc1VtvlCHmJWvh5vaf0H4jZ1Scm/D+chNIwMh+qu2r069Ykq68ykH+yKPIVQSuDC3+h2CORyYkjBvWTorVKWLR/vL5NW0xz6u/hy9eXoqg9mgQvCTOoq9+z0lK5SdNlvYI50LkUF+BmxKIlu+0Nc9rdfPJAu5NfjcWGx1ClA85GRYQ/Qpb36xWbFRlEyl1ZYNqaPBCu5xoKSIpGBb0taMl5qQYQ66Wd8fEL9g0N8XWs3yC+YzRe8oQ5o5ljn6ZMKVE5ikqymIxeaH5gz+RD1o/TYkF4I00RvCKZnMmZju39OxzSsO1sYxcH9+BYV7b7Lb7g5uNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRw7nj5zDuneYlTyq4bGBTW8Mnncx7M55LMm35xFiHc=;
 b=XJTGW0Y9jWad837aqLgVI6ULHXsRnH0QcfcqS6mXMAy+slMD5Lw51aGOfQDtTUlVtHBPMKhi1OlmOAeiivVE0Dxu1xKmb68l8swWOXWHgrqrYEIYg4ZHYNHC6GCYUHakHqyEzjFtRMWxyAnc9v/JtlkFUweylvmPljmT653rCrWxFHblthXjTAeHrw6aAh5H2eZkb6CfadxHQFQ+ktE+FDZnspKf8qZTV2Lo9zZCX6tmSr5ZpL3OT5x9G1ucRhF95FBmsPEVdlN7roIeDMEbGJXqN4oFHeDCmnUMJxTLj1a/nrGok3/RGMv0UAG1OEqbdkjMXsNl8kyNAai0avs4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QRw7nj5zDuneYlTyq4bGBTW8Mnncx7M55LMm35xFiHc=;
 b=pvvZOyeMbqWLulCuC46Y+7lndMiD4VVMJ7eTwxBZbKbbxb8ZJHzB07M+Za1CWaBu85mh1ZIqsQ0xZjzKtO64KJnN/Z4E0i+vbWj2+NRU3ebxsPMMiTFOab6fmfDHu61EwMM0sGbZG0s3O2ZJoFJIG7WwHcxDnPTy56+PIn6LXEo=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR1001MB2335.namprd10.prod.outlook.com (2603:10b6:301:2e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Thu, 8 Apr
 2021 16:34:21 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::1ce7:260b:b004:c82c]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::1ce7:260b:b004:c82c%11]) with mapi id 15.20.3999.033; Thu, 8 Apr 2021
 16:34:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Michel Lespinasse <walken@google.com>
Subject: Re: [PATCH] arch/m68k/kernel/sys_m68k: Add missing mmap_read_lock()
 to sys_cacheflush()
Thread-Topic: [PATCH] arch/m68k/kernel/sys_m68k: Add missing mmap_read_lock()
 to sys_cacheflush()
Thread-Index: AQHXK+iyIuMLgWgYKUeCSICFVkyJtqqq0jQA
Date:   Thu, 8 Apr 2021 16:34:20 +0000
Message-ID: <20210408163400.bcsmojb4ug7nnzwt@revolver>
In-Reply-To: <20210407200032.764445-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6346fe5a-59fe-4677-e340-08d8faac29a3
x-ms-traffictypediagnostic: MWHPR1001MB2335:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1001MB2335430F09561C414788960AFD749@MWHPR1001MB2335.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BTuF0LkB7nxWvdZb+DkvmgwehWrHHXh+AdQLtTB50P8VHNJfVdv+qfah+lZFkRs5Q+i4sqE7WK5gnOBuIfhOQdX2g5HcJOBHX5moF0nQ/eKOuYWNqYDPdbMhcfn6toDZfZlZWwUTCwIz4eN6LLqJzgQnnWvuCQZ+clV/Fc4fQmnyKRqm+lPI5+1+fepWCqbKyhWoe+809BTkKmVGOyY4wFJrwtV4DNyD1ITM/qmzYziaOw1LPZRgvuD0xBXcQojn+QY5ofG9eGhx4/FVYZG+WtxZpnicONr2RqjSgbL/XzPsdT9QxEnYI3dOCpzGCGFb75nPWSVHpXLBDNdj8lyvCRDEad7+Zfq6+Ct/wM66wYNxWOsmrkDKuYqTc+i2qQ1efK5rpIghrOX2AgD48Cg4ljfjdl5pXg/q8zWIQ5ovKL5/u9OPmSuk/1xlO8+Jypw5ua1IzbUSGEcbdWoRaYrczWD307+5FvUKvyLclpaQXTN3QHUJ+43WNwkWzIbskLvO4sf95oroXLCeBd/TqPUUQuLtBXCXrqViG0BAV7MfzLvfBzV0NbizNRMSRMWbas19hW1baul1HCjqN6S3QXOxP7Z2cjb8C4m9DUnUScG7klE9NjP2A33JBcH8iGNZMstUR4H6jLux9t/MrgCRagkVkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(366004)(39860400002)(346002)(376002)(396003)(478600001)(26005)(316002)(71200400001)(186003)(2906002)(76116006)(66616009)(8936002)(91956017)(110136005)(4744005)(54906003)(66556008)(8676002)(44832011)(66946007)(86362001)(9686003)(66446008)(66476007)(4326008)(1076003)(38100700001)(64756008)(6506007)(5660300002)(6486002)(99936003)(6512007)(33716001)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?P/V/uy6Sl/LMsenUbwxroYmwoh7RnMhf0VmTZWfGhNz0IlcB+nQMpOC5Pcs8?=
 =?us-ascii?Q?uarst/8Nhlg1NvOttUFqOC2ST8TExeFwryCkQzQ8tpHSUT9+gI15WA9C80MI?=
 =?us-ascii?Q?wboJJv0STITQTUPdGrc1m2b6+41V1zxv79G5SVzjV8iP/zZA3TNbjbuw3bBY?=
 =?us-ascii?Q?Hifa2I7HNoxR+cp1nD/5VNy0teEex78bb+MpeiyStgZn3aQtyTZDU6MXhEHV?=
 =?us-ascii?Q?/FcSgeDBUTNGiLHm635uII69+4+ORFNtaYvxm3/kR1fzCVXIpjXBdmnG1utD?=
 =?us-ascii?Q?qfYfaizzVjCnZnFD0d0FuQUZcqR4vS0Z606Bu5jLfNHPciD/6I9m0tOfUzB7?=
 =?us-ascii?Q?BBX2vceoZd++rY0ensekRhiTxFoQJNO7p58hnjmJUSkgs8A5XYbE74Vk8e3k?=
 =?us-ascii?Q?mqt/LevkQnEvjbFSXSZrH7Q5tvMdSwkRoku10ixo0n2VvLKXvfgsqFDOxsQv?=
 =?us-ascii?Q?R8MNlIvmjiMIMJzH0im1zyhC9JVn5w7vuXSUUwILOM2AgVM4yZuPCkJlUFzd?=
 =?us-ascii?Q?8Sjq7lPHyZxXBSxbzyOAj8M4j4ZAAxW8AJLaGeWBXGcr1O5MbtaM/L0YljH+?=
 =?us-ascii?Q?FnYPFZFu7NxX8+kzp6Ayts2dQm3hNMWgUrXA50XSVNivHkrLnIYWWFaaOucA?=
 =?us-ascii?Q?ptFfaWPCJ73eHgG+RGSzDAM8OtgxlQ+hNNacbR5a11dHgPLmqAn3KM5kHH19?=
 =?us-ascii?Q?9oz+B+fcc+XwOMAWd1fxBiiQEkzZlOLz4hg9MW5WJcITaa9FWBs2dA9J1LWJ?=
 =?us-ascii?Q?Q8ZiwS+c0bIqPmcndQXHoEWs/HPK8A1C8x/FIP2wrZQe3owmAP9kK4BSrhif?=
 =?us-ascii?Q?Y3VuK/LRrIhVeqPG1GiuKcc/5JTp/Ph2uCvPx1M3dpPta9BsoF3z7E/ERMHM?=
 =?us-ascii?Q?Te5H4wlCDKGcY0zdpCTcGRI5G5AlUK+T2q7EhsMQd/gnAlKIgAwi/DXJYrlw?=
 =?us-ascii?Q?20pIGYwB6FPkmEiIdnOk1XRuswmFn/EKymldmvUqpUcc2tiqCuki3fZdBgKo?=
 =?us-ascii?Q?Vg5CSWfberrAhtfJEmltNpLcfCBiRYW/xThcEZ+Syb46AAYGpuKo3CGNY/Mk?=
 =?us-ascii?Q?3XUrADuoM6788fkI8/jONb34qS7Na8AvBTl4s9r/EQHc6odGNWLuNBExDkgk?=
 =?us-ascii?Q?jhr9ykEMVnTNJbpB8myK4P3I1Z1aKflV+dd/veVpe0h4E0xxzr42uyljT3x2?=
 =?us-ascii?Q?kZkA3D7nLzfp8q8y5ndMR46Rw6cbBCZ+zuDdbDoIKZfGOMjlvmJUnAgiQ30A?=
 =?us-ascii?Q?NNHRh3+SNR10BNBLWw0E8UhVDOMK13CzALr2EO42dtMS+mxPyXOo9XphijSB?=
 =?us-ascii?Q?hxXk/xqkQo/FWQXpFn5WIpHt?=
Content-Type: multipart/mixed;
        boundary="_002_20210408163400bcsmojb4ug7nnzwtrevolver_"
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6346fe5a-59fe-4677-e340-08d8faac29a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2021 16:34:21.1850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9OVtQJSx9XEyH3whAX+fjf4m4GtuNzEaErKOfpqSq4XQ94OEU4H9GLrqwjMdPd62Y+nTQLDhUCDp3CWq8glxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2335
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080109
X-Proofpoint-GUID: eeoGkoRBIvtYZsa-4LebCmoo1_Mt-6r_
X-Proofpoint-ORIG-GUID: eeoGkoRBIvtYZsa-4LebCmoo1_Mt-6r_
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9948 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1011 bulkscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104080110
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_20210408163400bcsmojb4ug7nnzwtrevolver_
Content-Type: text/plain; charset="us-ascii"
Content-ID: <763E6B6BFEB5024488B732C5171D96AC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable

Forgot the fixes line.

* Liam Howlett <liam.howlett@oracle.com> [210407 16:00]:
> When the superuser flushes the entire cache, the mmap_read_lock() is not
> taken, but mmap_read_unlock() is called.  Add the missing
> mmap_read_lock() call.
>=20
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> ---
>  arch/m68k/kernel/sys_m68k.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/m68k/kernel/sys_m68k.c b/arch/m68k/kernel/sys_m68k.c
> index 1c235d8f53f3..f55bdcb8e4f1 100644
> --- a/arch/m68k/kernel/sys_m68k.c
> +++ b/arch/m68k/kernel/sys_m68k.c
> @@ -388,6 +388,8 @@ sys_cacheflush (unsigned long addr, int scope, int ca=
che, unsigned long len)
>  		ret =3D -EPERM;
>  		if (!capable(CAP_SYS_ADMIN))
>  			goto out;
> +
> +		mmap_read_lock(current->mm);
>  	} else {
>  		struct vm_area_struct *vma;
> =20
> --=20
> 2.30.0

--_002_20210408163400bcsmojb4ug7nnzwtrevolver_
Content-Type: text/x-diff;
	name="0001-arch-m68k-kernel-sys_m68k-Add-missing-mmap_read_lock.patch"
Content-Description: 
 0001-arch-m68k-kernel-sys_m68k-Add-missing-mmap_read_lock.patch
Content-Disposition: attachment;
	filename="0001-arch-m68k-kernel-sys_m68k-Add-missing-mmap_read_lock.patch";
	size=1086; creation-date="Thu, 08 Apr 2021 16:34:20 GMT";
	modification-date="Thu, 08 Apr 2021 16:34:20 GMT"
Content-ID: <4DD09F54E23E4742B751FD39D8C01207@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64

RnJvbSBhZWVlNzFiMTVmNTQ0MjZmMDJmNDFhNDQwOGFmYmQwYjVhY2FiN2VjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQ0KRnJvbTogIkxpYW0gUi4gSG93bGV0dCIgPExpYW0uSG93bGV0dEBPcmFj
bGUuY29tPg0KRGF0ZTogV2VkLCA3IEFwciAyMDIxIDExOjM5OjA2IC0wNDAwDQpTdWJqZWN0OiBb
UEFUQ0hdIGFyY2gvbTY4ay9rZXJuZWwvc3lzX202OGs6IEFkZCBtaXNzaW5nIG1tYXBfcmVhZF9s
b2NrKCkgdG8NCiBzeXNfY2FjaGVmbHVzaCgpDQoNCldoZW4gdGhlIHN1cGVydXNlciBmbHVzaGVz
IHRoZSBlbnRpcmUgY2FjaGUsIHRoZSBtbWFwX3JlYWRfbG9jaygpIGlzIG5vdA0KdGFrZW4sIGJ1
dCBtbWFwX3JlYWRfdW5sb2NrKCkgaXMgY2FsbGVkLiAgQWRkIHRoZSBtaXNzaW5nDQptbWFwX3Jl
YWRfbG9jaygpIGNhbGwuDQoNCkZpeGVzOiBjZDI1NjdiNjg1MGIgKG02OGs6IGNhbGwgZmluZF92
bWEgd2l0aCB0aGUgbW1hcF9zZW0gaGVsZCBpbg0Kc3lzX2NhY2hlZmx1c2goKSkNClNpZ25lZC1v
ZmYtYnk6IExpYW0gUi4gSG93bGV0dCA8TGlhbS5Ib3dsZXR0QE9yYWNsZS5jb20+DQotLS0NCiBh
cmNoL202OGsva2VybmVsL3N5c19tNjhrLmMgfCAyICsrDQogMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9tNjhrL2tlcm5lbC9zeXNfbTY4ay5jIGIv
YXJjaC9tNjhrL2tlcm5lbC9zeXNfbTY4ay5jDQppbmRleCAxYzIzNWQ4ZjUzZjMuLmY1NWJkY2I4
ZTRmMSAxMDA2NDQNCi0tLSBhL2FyY2gvbTY4ay9rZXJuZWwvc3lzX202OGsuYw0KKysrIGIvYXJj
aC9tNjhrL2tlcm5lbC9zeXNfbTY4ay5jDQpAQCAtMzg4LDYgKzM4OCw4IEBAIHN5c19jYWNoZWZs
dXNoICh1bnNpZ25lZCBsb25nIGFkZHIsIGludCBzY29wZSwgaW50IGNhY2hlLCB1bnNpZ25lZCBs
b25nIGxlbikNCiAJCXJldCA9IC1FUEVSTTsNCiAJCWlmICghY2FwYWJsZShDQVBfU1lTX0FETUlO
KSkNCiAJCQlnb3RvIG91dDsNCisNCisJCW1tYXBfcmVhZF9sb2NrKGN1cnJlbnQtPm1tKTsNCiAJ
fSBlbHNlIHsNCiAJCXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hOw0KIA0KLS0gDQoyLjMwLjAN
Cg0K

--_002_20210408163400bcsmojb4ug7nnzwtrevolver_--
