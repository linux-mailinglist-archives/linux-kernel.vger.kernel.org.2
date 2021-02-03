Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846DC30DE4A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhBCPgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:36:33 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49520 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234073AbhBCPeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:34:46 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113FTaht169771;
        Wed, 3 Feb 2021 15:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=p6Y/NKzb/FRjD0WQVnzJWMx/z7pCEo0EysBVQZ0BxZA=;
 b=IR8kgEkvaek793nq1FD4otT0IYdSFm+sfLu0p4vFA4LwQxJRk/xt0JgZaPrIl5ZZ4rpk
 WC4p5HAXs5ErmltWHXI0gZ2RpT40PXe7q7iIfJAy3rvZMtaOEBf6N+xcUMQ1chOeR6iN
 VbiWBCrUW1UcxtaPXIDvaxToX41F/38XNq6K7w5Dsbvs35oYJyjaB5csrLBqdiG4tlFv
 CpKqcNisErGEiEmY7vFfAJJQyyfXM3ZUG+2qfwY0MCkcYtYbbwsNTr0eLZxKayVkbI7y
 hgRFjQ11UBZMX1Qm8YtF4z1OEsSrwd1oij3o3UQtwvuk2y7z4i2lEnt/OceTRUS48yAk UA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 36cvyb0uh7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 15:34:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113FV3Ag064405;
        Wed, 3 Feb 2021 15:34:01 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3020.oracle.com with ESMTP id 36dhc18png-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 15:34:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhDzrytTtBDiQ/nGjGLHgeObaUaknjPQtSnZ1aF5jg9DNWpNB0zzrbOArbVAY8LMAJgqCR/+qzB64wYCGHbxp4dhWpcLLxLm6uIyB0vKjSNRYT8Ps9fJQBmj5gPt/6/jQslCNmDUwnW4BbyBP6OfnZAoCazzw+lrXk9zOuxbCFl1TXIMYLXD+C4EzkBSiVn50j2YI9RYxFSQo+pAYdU7iWkc/ZUJBCuIbmN2BrkbwGf6c2XJi0n4u8e0DuC9x3XCNraVb8ZFt8QokNZe4Ud920wgMPZv+3fSI0aUELMfyuGX0ADp+7dTWEH9sRIQMzMeYuDumf0hMw8y3TotusUWCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6Y/NKzb/FRjD0WQVnzJWMx/z7pCEo0EysBVQZ0BxZA=;
 b=Cx8CZ4FhTudOmk5org17Anr2rIuCaWa0g5qxqfH8uFJuuz95WGd7LhXMYqyiFiV+RsU9QisFhXh2wDA6k+Xl+CSBiXj9IE1WQrQWOZ88x5VGiWK1KYT33zNCtcbtZhMqv1xZmq9zzbichlrdYnxe3a9/cLX7UzFYRXsJcJhIVZAFwRfpnYAIR7T7xpBJref2y6xQjMm2panqJv+uFrnBj1oLMjV0hl6XQRRPuzHmWsT1yQAogtA+3DR4JW5QLG+In/OqGvj+MuroRyVtIOKTCtCWFx8NvcXsS6COPt1ufIkB30o4SgXQb/ORADY0hwWuyEq51xBotKCcmsD7y2qRlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p6Y/NKzb/FRjD0WQVnzJWMx/z7pCEo0EysBVQZ0BxZA=;
 b=tPEPX6ljpY7ePBD7Dajqf+ZtpbOpEjA15fiKtKuYm1UP1LV9xeEl3BfFMXJ5D2oRpy5Gc1DDCFLvBhRxXY913oeBVn8Da1wBJzqNOQF8buafe4C24onmlT1s8jIYdGp/04O1hRViYwFfKuPx63CNOMBHPrinOEigWwwQ3jGLRAE=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4673.namprd10.prod.outlook.com (2603:10b6:303:91::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Wed, 3 Feb
 2021 15:33:58 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::cd32:6bce:ab18:83a]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::cd32:6bce:ab18:83a%8]) with mapi id 15.20.3825.017; Wed, 3 Feb 2021
 15:33:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [rcu:willy-maple 134/202] mm/mmap.c:2919 do_brk_munmap() error:
 we previously assumed 'vma->anon_vma' could be null (see line 2884)
Thread-Topic: [rcu:willy-maple 134/202] mm/mmap.c:2919 do_brk_munmap() error:
 we previously assumed 'vma->anon_vma' could be null (see line 2884)
Thread-Index: AQHW+i6k5RdXsRNAlUK6nDmedBcrFqpGj5SA
Date:   Wed, 3 Feb 2021 15:33:58 +0000
Message-ID: <20210203153351.3mtcpjrprbuj3kvf@revolver>
References: <20210203131513.GX2696@kadam>
In-Reply-To: <20210203131513.GX2696@kadam>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3171c1ab-a69f-45ab-8387-08d8c8591ff1
x-ms-traffictypediagnostic: CO1PR10MB4673:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB46732EBECC6649A069BD6C9AFDB49@CO1PR10MB4673.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z85Z/kQMq5V850B7sAB7UNEBdyrWRApHMO937sYGYBOHynOvrkAodSsFTnIjI6kWuOFWNHscSWXHekzP3CQVPJrxVD93VIo3OivCzPcJTOw0df5vS7RolhaO3QjHtrtKPQFD4mEpk7NZ3Y9gQTiAnPD37+kJhMXO8PKs4s2yvyXxcjJpjV0nNlPYQjhbpjNsUOi4JCJ5U3GVRIq/7Q3ujIGA2oZWkPZ8nfrlX/p2vsfhjyxQk5Y401+0tbc4V71V0ztlh+ldoRW5a2D1zQ6WKDdsrbz/BH4xKyWzZj4T+p9ZpYSle5jqotTGah5OaZ0ihzqZBuW9xuembkEO2bk+cbQ6+0OWaGJDzWrzrd2KSsdFMyFl4eK+vbH/eHj9DEburZ5cUBbS2yfcCQxJohYXfhhzEMXYnSjet2yhrnHblZbKsuTih0C2n0qOLMVIz8E/SWMqgkBbsgK6Y8X000dyyhACf566kcegVHy0ud4dD0t2YlWhz0PkpbjX+pFMurE4vugzgswI/+4RKntG2eJ319HgHYHYz9Y+CwFZoKzM8zOAUEWOiSOZcfB2MOyNZr+qOVcK1DMS9XV3Lrt3UzbY06CXA+sAYFZGPKvjFcNMHAs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(136003)(346002)(39860400002)(396003)(376002)(4001150100001)(86362001)(30864003)(2906002)(316002)(33716001)(76116006)(8676002)(6512007)(54906003)(71200400001)(26005)(66946007)(44832011)(5660300002)(186003)(8936002)(6862004)(91956017)(83380400001)(1076003)(66476007)(6486002)(966005)(64756008)(6636002)(6506007)(66556008)(4326008)(66446008)(478600001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?0LRYTqCogL3aJ1t+YvhPoo+DYD2RKeC4735eKiY8PU9P3AWhSl8Cmg+4LhPg?=
 =?us-ascii?Q?FR3A2JKcsGyKwI3ZJprwKvdia4hFxZjNmRWlRdEdegWwh9MxM8ErayXjPDWV?=
 =?us-ascii?Q?coCg8eNZoyGx1shM6lax8WSlqKGqwp0yA5z24dM/NQofWYID+Qeq32n29QRE?=
 =?us-ascii?Q?TW4Y4Ss0Lg3x6PeazGp3Vm5OMNspIyLoZn9oBcD6ukUIYFOzxhTknjsu6wNM?=
 =?us-ascii?Q?yTDdC+HWVEvs7Wv8O8sWd393BCy7BErb89WUZjAP7h6b9+YSNjp3n90eR9pv?=
 =?us-ascii?Q?zsNF1XI4L+L9fh3O+I0xdp2omzqnKSeewjHV07/qFKaGrF65WTQ/YKWcrliC?=
 =?us-ascii?Q?xsbxQhBeLExa2zfY0+OBpJy346lvnlajg/ERt80qF0BtMq1/uSTph0UPzlxz?=
 =?us-ascii?Q?n+Lu+tyYiTZGHRb8IyEX12axLbMIoc+G5Anuz2zgFiaB4uKc8S0tgbscdpe3?=
 =?us-ascii?Q?6r8Nx+cHZHLUj1a95zyWg/rCJ5X+CKdsD6mDkhlf/oUFd8535dX5HV4hMX9a?=
 =?us-ascii?Q?emrDHdXANM3dVZaCkCZLnzrjMJOGrX9P3QkhZjWcsbHcSLw1Ji3bpp7Kvrq5?=
 =?us-ascii?Q?GpOkAntAL3ExO8JVq8q3zIvfMkVsait3b7v//JwKj3hqZDMvU9oKu05nkfr7?=
 =?us-ascii?Q?Zr1sSGuFGuaYSc1xSsVMq2/H/YISvbo34gfwFbzAjinn6nucOnQyhfbUcLku?=
 =?us-ascii?Q?G6Zoh2REXxpQ1Fzhesa/r4d9l3eleVI6PkAxRHelv3D+WyV7tyjaq/LUqTtH?=
 =?us-ascii?Q?n1ntOHpw4mnUfEQOIkHrCSub39NyX1f+7VFQVDm3d5RIdbDgAIxwz2MLDCM2?=
 =?us-ascii?Q?AhDTh9z5oqmBGAygpCEv45Bpn9OhStIrDMKAhh4IOu+UVBgIsT2oPK8hRuef?=
 =?us-ascii?Q?HLzJl7NsFyqY6LJo3DrhDSM3CqbQ7RGgNZuRD840l8HahHM53CfEchPm8Gjv?=
 =?us-ascii?Q?rduHfUJQdTei1pbOrJCzXhrFlgBX85NgC+5LbC4HgIRSiouM8iIShVDR+2ts?=
 =?us-ascii?Q?Qlnk0XwkttxjLgSOD9kP3fAEyioO2xZPjmcS7iLbazttcrenKvYGX83lrDjO?=
 =?us-ascii?Q?9AIgxd9b?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D2E8A9F958689249A909BD3639067460@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3171c1ab-a69f-45ab-8387-08d8c8591ff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 15:33:58.5291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SHN187at+UiJHz6R/6PG02xx94CBjAnz+KwneWGwh+k8wtmZIt7iRIVXigCHbz5NpcSuDwKEAnv9y4fkmaoUng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4673
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 suspectscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9883 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102030097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

These are two valid issues.  I had noticed one but both need to be
addressed.

Thank you Dan.

Regards,
Liam

* Dan Carpenter <dan.carpenter@oracle.com> [210203 08:15]:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu=
.git willy-maple
> head:   7e346d2845b4bd77663394f39fa70456e0084c86
> commit: 5b05486ddd0127e852616630ef547dba96a7abad [134/202] mm/mmap: Chang=
e do_brk_flags() to expand existing VMA and add do_brk_munmap()
> config: x86_64-randconfig-m001-20210202 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> smatch warnings:
> mm/mmap.c:2919 do_brk_munmap() error: we previously assumed 'vma->anon_vm=
a' could be null (see line 2884)
> mm/mmap.c:3039 do_brk_flags() error: we previously assumed 'vma->anon_vma=
' could be null (see line 2980)
>=20
> vim +2919 mm/mmap.c
>=20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2855  static int do_brk_=
munmap(struct ma_state *mas, struct vm_area_struct *vma,
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2856  			 unsigned long =
newbrk, unsigned long oldbrk,
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2857  			 struct list_he=
ad *uf)
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2858  {
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2859  	struct mm_struct =
*mm =3D vma->vm_mm;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2860  	struct vm_area_st=
ruct unmap;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2861  	unsigned long unm=
ap_pages;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2862  	int ret =3D 1;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2863 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2864  	arch_unmap(mm, ne=
wbrk, oldbrk);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2865 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2866  	if (likely(vma->v=
m_start >=3D newbrk)) { // remove entire mapping(s)
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2867  		mas_set(mas, new=
brk);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2868  		if (vma->vm_star=
t !=3D newbrk)
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2869  			mas_reset(mas);=
 // cause a re-walk for the first overlap.
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2870  		ret =3D __do_mun=
map(mm, newbrk, oldbrk - newbrk, uf, true);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2871  		goto munmap_full=
_vma;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2872  	}
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2873 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2874  	vma_init(&unmap, =
mm);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2875  	unmap.vm_start =
=3D newbrk;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2876  	unmap.vm_end =3D =
oldbrk;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2877  	ret =3D userfault=
fd_unmap_prep(&unmap, newbrk, oldbrk, uf);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2878  	if (ret)
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2879  		return ret;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2880  	ret =3D 1;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2881 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2882  	// Change the old=
brk of vma to the newbrk of the munmap area
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2883  	vma_adjust_trans_=
huge(vma, vma->vm_start, newbrk, 0);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21 @2884  	if (vma->anon_vma=
) {
>                                                             ^^^^^^^^^^^^^
> This code assumes "vma->anon_vma" can be NULL.
>=20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2885  		anon_vma_lock_wr=
ite(vma->anon_vma);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2886  		anon_vma_interva=
l_tree_pre_update_vma(vma);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2887  	}
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2888 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2889  	vma->vm_end =3D n=
ewbrk;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2890  	if (vma_mas_remov=
e(&unmap, mas))
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2891  		goto mas_store_f=
ail;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2892 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2893  	vmacache_invalida=
te(vma->vm_mm);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2894  	if (vma->anon_vma=
) {
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2895  		anon_vma_interva=
l_tree_post_update_vma(vma);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2896  		anon_vma_unlock_=
write(vma->anon_vma);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2897  	}
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2898 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2899  	unmap_pages =3D v=
ma_pages(&unmap);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2900  	if (unmap.vm_flag=
s & VM_LOCKED) {
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2901  		mm->locked_vm -=
=3D unmap_pages;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2902  		munlock_vma_page=
s_range(&unmap, newbrk, oldbrk);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2903  	}
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2904 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2905  	mmap_write_downgr=
ade(mm);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2906  	unmap_region(mm, =
&unmap, vma, newbrk, oldbrk);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2907  	/* Statistics */
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2908  	vm_stat_account(m=
m, unmap.vm_flags, -unmap_pages);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2909  	if (unmap.vm_flag=
s & VM_ACCOUNT)
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2910  		vm_unacct_memory=
(unmap_pages);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2911 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2912  munmap_full_vma:
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2913  	validate_mm_mt(mm=
);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2914  	return ret;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2915 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2916  mas_store_fail:
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2917  	vma->vm_end =3D o=
ldbrk;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2918  	anon_vma_interval=
_tree_post_update_vma(vma);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21 @2919  	anon_vma_unlock_w=
rite(vma->anon_vma);
>                                                                          =
     ^^^^^^^^^^^^^
> Unchecked dereference inside function call.
>=20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2920  	return -ENOMEM;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2921  }
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2922 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2923  /*
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2924   * do_brk_flags() =
- Increase the brk vma if the flags match.
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2925   * @mas: The maple=
 tree state.
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2926   * @addr: The star=
t address
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2927   * @len: The lengt=
h of the increase
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2928   * @vma: The vma,
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2929   * @flags: The VMA=
 Flags
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2930   *
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2931   * Extend the brk =
VMA from addr to addr + len.  If the VMA is NULL or the flags
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2932   * do not match th=
en create a new anonymous VMA.  Eventually we may be able to
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2933   * do some brk-spe=
cific accounting here.
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2934   */
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2935  static int do_brk_=
flags(struct ma_state *mas, struct vm_area_struct **brkvma,
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2936  			unsigned long a=
ddr, unsigned long len,
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2937  			unsigned long f=
lags)
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2938  {
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2939  	struct mm_struct =
*mm =3D current->mm;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2940  	struct vm_area_st=
ruct *prev =3D NULL, *vma;
> 3a459756810912 Kirill Korotaev       2006-09-07  2941  	int error;
> ff68dac6d65cd1 Gaowei Pu             2019-11-30  2942  	unsigned long map=
ped_addr;
> d25a147c68d737 Liam R. Howlett       2020-07-24  2943  	validate_mm_mt(mm=
);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2944 =20
> 16e72e9b30986e Denys Vlasenko        2017-02-22  2945  	/* Until we need =
other flags, refuse anything except VM_EXEC. */
> 16e72e9b30986e Denys Vlasenko        2017-02-22  2946  	if ((flags & (~VM=
_EXEC)) !=3D 0)
> 16e72e9b30986e Denys Vlasenko        2017-02-22  2947  		return -EINVAL;
> 16e72e9b30986e Denys Vlasenko        2017-02-22  2948  	flags |=3D VM_DAT=
A_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
> 3a459756810912 Kirill Korotaev       2006-09-07  2949 =20
> ff68dac6d65cd1 Gaowei Pu             2019-11-30  2950  	mapped_addr =3D g=
et_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
> ff68dac6d65cd1 Gaowei Pu             2019-11-30  2951  	if (IS_ERR_VALUE(=
mapped_addr))
> ff68dac6d65cd1 Gaowei Pu             2019-11-30  2952  		return mapped_ad=
dr;
> 3a459756810912 Kirill Korotaev       2006-09-07  2953 =20
> 363ee17f0f405f Davidlohr Bueso       2014-01-21  2954  	error =3D mlock_f=
uture_check(mm, mm->def_flags, len);
> 363ee17f0f405f Davidlohr Bueso       2014-01-21  2955  	if (error)
> 363ee17f0f405f Davidlohr Bueso       2014-01-21  2956  		return error;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2957 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2958  	/* Check against =
address space limits by the changed size */
> 84638335900f19 Konstantin Khlebnikov 2016-01-14  2959  	if (!may_expand_v=
m(mm, flags, len >> PAGE_SHIFT))
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2960  		return -ENOMEM;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2961 =20
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2962  	if (mm->map_count=
 > sysctl_max_map_count)
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2963  		return -ENOMEM;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2964 =20
> 191c542442fdf5 Al Viro               2012-02-13  2965  	if (security_vm_e=
nough_memory_mm(mm, len >> PAGE_SHIFT))
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2966  		return -ENOMEM;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2967 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2968  	mas->last =3D add=
r + len - 1;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2969  	if (*brkvma) {
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2970  		vma =3D *brkvma;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2971  		/* Expand the ex=
isting vma if possible; almost never a singular
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2972  		 * list, so this=
 will almost always fail. */
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2973 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2974  		if ((!vma->anon_=
vma ||
>                                                                      ^^^^=
^^^^^^^^^^
> Check for NULL
>=20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2975  		     list_is_sin=
gular(&vma->anon_vma_chain)) &&
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2976  		     ((vma->vm_f=
lags & ~VM_SOFTDIRTY) =3D=3D flags)){
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2977  			mas->index =3D =
vma->vm_start;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2978 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2979  			vma_adjust_tran=
s_huge(vma, addr, addr + len, 0);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21 @2980  			if (vma->anon_v=
ma) {
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2981  				anon_vma_lock_=
write(vma->anon_vma);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2982  				anon_vma_inter=
val_tree_pre_update_vma(vma);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2983  			}
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2984  			vma->vm_end =3D=
 addr + len;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2985  			vma->vm_flags |=
=3D VM_SOFTDIRTY;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2986  			if (mas_store_g=
fp(mas, vma, GFP_KERNEL))
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2987  				goto mas_mod_f=
ail;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2988  			if (vma->anon_v=
ma) {
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2989  				anon_vma_inter=
val_tree_post_update_vma(vma);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2990  				anon_vma_unloc=
k_write(vma->anon_vma);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2991  			}
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2992  			khugepaged_ente=
r_vma_merge(vma, flags);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2993  			goto out;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2994  		}
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2995  		prev =3D vma;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2996  	}
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2997  	mas->index =3D ad=
dr;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  2998  	mas_walk(mas);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  2999 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3000  	/* create a vma s=
truct for an anonymous mapping */
> 490fc053865c9c Linus Torvalds        2018-07-21  3001  	vma =3D vm_area_a=
lloc(mm);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3002  	if (!vma)
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3003  		goto vma_alloc_f=
ail;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  3004 =20
> bfd40eaff5abb9 Kirill A. Shutemov    2018-07-26  3005  	vma_set_anonymous=
(vma);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  3006  	vma->vm_start =3D=
 addr;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  3007  	vma->vm_end =3D a=
ddr + len;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3008  	vma->vm_pgoff =3D=
 addr >> PAGE_SHIFT;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  3009  	vma->vm_flags =3D=
 flags;
> 3ed75eb8f1cd89 Coly Li               2007-10-18  3010  	vma->vm_page_prot=
 =3D vm_get_page_prot(flags);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3011  	if (vma_mas_store=
(vma, mas))
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3012  		goto mas_store_f=
ail;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3013 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3014  	if (!prev)
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3015  		prev =3D mas_pre=
v(mas, 0);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3016 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3017  	__vma_link_list(m=
m, vma, prev);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3018  	mm->map_count++;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3019  	*brkvma =3D vma;
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  3020  out:
> 3af9e859281bda Eric B Munson         2010-05-18  3021  	perf_event_mmap(v=
ma);
> ^1da177e4c3f41 Linus Torvalds        2005-04-16  3022  	mm->total_vm +=3D=
 len >> PAGE_SHIFT;
> 84638335900f19 Konstantin Khlebnikov 2016-01-14  3023  	mm->data_vm +=3D =
len >> PAGE_SHIFT;
> 128557ffe147c2 Michel Lespinasse     2013-02-22  3024  	if (flags & VM_LO=
CKED)
> ba470de43188cd Rik van Riel          2008-10-18  3025  		mm->locked_vm +=
=3D (len >> PAGE_SHIFT);
> d9104d1ca96624 Cyrill Gorcunov       2013-09-11  3026  	vma->vm_flags |=
=3D VM_SOFTDIRTY;
> d25a147c68d737 Liam R. Howlett       2020-07-24  3027  	validate_mm_mt(mm=
);
> 5d22fc25d4fc80 Linus Torvalds        2016-05-27  3028  	return 0;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3029 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3030  mas_store_fail:
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3031  	vm_area_free(vma)=
;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3032  vma_alloc_fail:
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3033  	vm_unacct_memory(=
len >> PAGE_SHIFT);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3034  	return -ENOMEM;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3035 =20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3036  mas_mod_fail:
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3037  	vma->vm_end =3D a=
ddr;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3038  	anon_vma_interval=
_tree_post_update_vma(vma);
> 5b05486ddd0127 Liam R. Howlett       2020-09-21 @3039  	anon_vma_unlock_w=
rite(vma->anon_vma);
>                                                         ^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^
> Unchecked
>=20
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3040  	return -ENOMEM;
> 5b05486ddd0127 Liam R. Howlett       2020-09-21  3041 =20
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

