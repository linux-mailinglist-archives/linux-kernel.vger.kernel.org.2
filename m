Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E81F30DEAA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 16:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhBCPut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 10:50:49 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:44672 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234399AbhBCPnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 10:43:09 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113Fds6Z105144;
        Wed, 3 Feb 2021 15:42:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=G0RmwC8qIwhP2qTa5U0jfxarErJCGVg+bo1nxn/vYLY=;
 b=CzxMgOizqIl6Prn3PaMetHqvyChSRzJpKCgcTPNoRbryeVW+fy2uJZ11n73qiLDY36Yj
 DGpYthO3rxz+QvMS4RX436Ag1KdU9GXHL6wIT5R6kDjQBOwe2kHhOS2/QunP3nvt5VS2
 AS7UG/hsSfIXMtfLeuVTBjfzTk8aunfc3NG/PXCom+YuQtewdXHVcb/LXxhFH1W/gVuQ
 LFEhzUelcw6M8+gOiJZ70mlagdCItBXqI4Jx/38o7iqy+PLhliStfHFDiJfLrUM8WiBs
 jCF+Y3zb9tB0jenSQNlVqnQeiw7USxbTtLXNWm6eauzLVATFLlYB302s7f4g6ypBScaF fw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 36fs45981j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 15:42:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 113Ffenh173876;
        Wed, 3 Feb 2021 15:42:25 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by aserp3030.oracle.com with ESMTP id 36dh1r1vvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 03 Feb 2021 15:42:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ibdTearCyNB3Mpv6AfTHTFMqT8ngB0Hva8f5mHhUcAjvuKhD4spuzmYhA97Vznqbz5g0xXAxC3onWpVFaKhZ1qMDj/iRdUOYHT0fA7MUtYh9Obbs/gczibhsnv85V6oRFerTigX+XDhjoGf0uU/5QL4XYzEkiUC0bk/ZyJr1TX41a271B1uCtNzFjyRt9dmUNQJ1eI+8mC9G9Eq+Fx0cZuIEJ7uCKilnybbHD/QVuVQIsC1v7QjcdPOsuw/oRucYh+a+jnpDyOwDaejUesXra2eHkDcdOUgTQmzwejftaFKu4YQvlWH9h0uqxge+k10OVOJiIwjyT1lKyAxUn7C0Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0RmwC8qIwhP2qTa5U0jfxarErJCGVg+bo1nxn/vYLY=;
 b=lesmW1oCi9uVvA7As3bRxFn5nFflTZBurf13PKpnZ8q3uyl9o4tqw+rBixXz9gtI6Q3x2lYxir+DzfWH8jR6PFcHqsTZ4RqrDE9gMBoDOH/rB0wlf2cOOYQsV5+k6OVbgzP9goq9hYYg36X64/DyOIYmelE4yGXGbrdVsxf5sqWhQJXxGvbqebDM+uJDHUvY+/LVmiz9MB8ppY2oS6H/NxUJP5VNMaOP96PSvqQCTNls6X7OkxYkOLSIHWKbu/ZZ+UGr6d7ge+pDBN2/dB5POYTDKUKbH7qggkJY7IzV+ZL9BItbkJDcWTtQqLoaNZHVcMGvqAGKh6P5sRjpYnLitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G0RmwC8qIwhP2qTa5U0jfxarErJCGVg+bo1nxn/vYLY=;
 b=lWYoxK8zC4vjZTMnH4oJm4BJaIUJqeExPHvMd9SE0whoyyAlvzMcncQiX7OTHXxNpAdeOt7DYAPjQiDq7rkBnphgRRDW4drsU2VrDvrO5RJ9oFNV29hRX3GO/tsV3laZpqKxtcfgVjVXEXPJ4fSEImtCdFGJ40JWt9oxXKz03fI=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1744.namprd10.prod.outlook.com (2603:10b6:301:b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Wed, 3 Feb
 2021 15:42:23 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::cd32:6bce:ab18:83a]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::cd32:6bce:ab18:83a%8]) with mapi id 15.20.3825.017; Wed, 3 Feb 2021
 15:42:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [rcu:willy-maple 189/202] mm/mmap.c:2830:18: warning: variable
 'ma_lock' set but not used
Thread-Topic: [rcu:willy-maple 189/202] mm/mmap.c:2830:18: warning: variable
 'ma_lock' set but not used
Thread-Index: AQHW+dnKgZXgnyyDcEuW6nqKgXpq5qpGkimA
Date:   Wed, 3 Feb 2021 15:42:23 +0000
Message-ID: <20210203154043.gapbdfft2kahirm2@revolver>
References: <202102031140.3Ms6psce-lkp@intel.com>
In-Reply-To: <202102031140.3Ms6psce-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae47986b-2a01-4011-3288-08d8c85a4cb1
x-ms-traffictypediagnostic: MWHPR10MB1744:
x-microsoft-antispam-prvs: <MWHPR10MB1744C8DD65B7F26A0E398066FDB49@MWHPR10MB1744.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:785;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jhyl+1Tii6ZY+4lkEnHlMU1wbEaZyAXk3pVhmVDZ+lzH84evrfrlHE9sP8gtqsPlRjRIg4idcKJVT65bPh2PZFlz6oxq+/ldiWSyc698fJA4fxw1Bil+daeIZqHsYsQ4JRogeDC6qcaZLdYrzHVsffWB8mbyzBrwDl4z/AxN+kzDLNqNgCH0a8y8W7Zp/ZZ88o+9Np2QDILgsE6/xkJUOuMj4eqjZXikd/KdKDKRaUNN+QmJOhR7JWiJvR3+MRbrX4qBXBePSJp/D7eMI4JyVt4UKx0/fFWUUKtBOJTv91Ap9lX9JC0qHJ3beoN4ehZn+owessXJed6gMmCRSeNjEEXCdwLkkg4s/9P7u31J8l6pIbm3BH+5fH6wDwyjXHS9K1Pzy5d9SCXG64CjjogKpYMoYhW1Sr6gA76vDxGCUatjJ1RYvvPOdAVtrLdKx/40rsj8/CiZdTolaJ5dbV+qnqnY+GfX0CQqkLXuQ0wXZFcoM1vrwuJ6IO4QwDI1LBaK15uBFJzDPfKHTYyZpjengQ+3l10Qy3uEbGcdfYvsKy88CFwhqG+4XvSXzLNX8rciPtPSXrSS28VyujCqW2fEDsGMQcVKy6LQATyrFtEQrm0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(39860400002)(366004)(396003)(136003)(346002)(376002)(86362001)(83380400001)(1076003)(6916009)(9686003)(6506007)(44832011)(26005)(186003)(966005)(6486002)(6512007)(2906002)(478600001)(66476007)(64756008)(66446008)(66556008)(66946007)(4326008)(8676002)(8936002)(316002)(76116006)(91956017)(71200400001)(33716001)(5660300002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OlSrJGXuJP1rC2O8BuW+d1bfi5x3BHlvMoKIh2zMknWYgyi4awayPy+mFOYH?=
 =?us-ascii?Q?+boG9U6xRL2+ACgyCXUiMJQ9Ky0kq6AZ5Q/ttbYtkJ+LAyGC0jtzzNj4sBzy?=
 =?us-ascii?Q?NxDO6LuVDC0Cv/Q7Yxkkmrp9V7wVxzdjGzxSTnp4GswqdkDMelI4zuW1kAGo?=
 =?us-ascii?Q?qFe5FdpGD5NceWSD4tOs+WiUWfudgHkbV+cbm2fKEHhH2y/+Cnx6Xd+cpth6?=
 =?us-ascii?Q?gluwfsuqt6KYL9MJpLsm3OA3WagWBvvNxlHshQ9WPZDb1VGyAUtBb80ULizh?=
 =?us-ascii?Q?+Rqsm5U1dnjdsUH6wwrp+uI9/K3MakgVUEm+Qv1sMpRcdg5I0meO0/o7jgk0?=
 =?us-ascii?Q?WA4VUNKiB516xMiBw1mkVrLwos5ZsirLB33+u1e3/cPwqclWPbLvDfCi9ld1?=
 =?us-ascii?Q?pEkvWMeLR6xRR1xYUZoOeNAEPDdcj5xNvh9R+Uo9j4pXy2kFEEuXlH2dc1yV?=
 =?us-ascii?Q?NKnVkMhufVvSMppSrCEUW+oVYewuA1YCvo0Y0Ts4+EvrJrU5PsEOc81RbXmj?=
 =?us-ascii?Q?CZS9NgeKhlR/xjNKmjjqBat8yF012YoT5IaS78tNmL7dqMDfGmYw4noRAHlU?=
 =?us-ascii?Q?GByWZmxx/stAP8Q36j0pkdXJEuN0SDik9diKbj9wNEORzblVMGhWTzNoo3DH?=
 =?us-ascii?Q?M9uZ+h4jRJzY04mkfURBMFk2ylk3aC+WjFHd49zfipH8/vAU/fLJjx2UiNCI?=
 =?us-ascii?Q?w2A8beGK07+KUhT83jYWeMb9XBU6J5B4FPHQFITLbU4jkpMUM12fO49K8Sck?=
 =?us-ascii?Q?auX4P5927DPHQ63gW+pQj7Wu39c2kPxfkMadqnWPm73S/GXxUbOhR7JK9loZ?=
 =?us-ascii?Q?zi+pPXanMUop8Ebr+bbyAS3e7pmCUGvJVRuQthEn1Vazs/5stcEZQPTWlYGd?=
 =?us-ascii?Q?/c0VBFq8Kl3N1dSgFczBuXafoe5clo0HehcgQ3bIeedEVssbzo4EJ1C7b+qb?=
 =?us-ascii?Q?uCIPuuNvLuOsOG2e6/xZFibA2ePe9fdPoq10iSTyeKjSKfY+iqxyVF71AMTL?=
 =?us-ascii?Q?Xf8KMVaxhB7S0lLmtKAwAFSyUXNADJJNatnQRuaprqzA/RBdM0f76DrbpVQh?=
 =?us-ascii?Q?n2Eoy/3U?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <97CA57A99257BF4E961055638661F323@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae47986b-2a01-4011-3288-08d8c85a4cb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2021 15:42:23.0618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qulaHh3x5I1/wK3+G5Gz7ZLYmDcnL91W9YREEDYn6D4MCAlCvJsWdvPL/hrWyvsg4Mx2Yq9vjxkw2IZEBx887Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1744
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9884 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102030097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* kernel test robot <lkp@intel.com> [210202 22:08]:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu=
.git willy-maple
> head:   7e346d2845b4bd77663394f39fa70456e0084c86
> commit: e40a951e09ed0e66dbd646f938df19c876915b9d [189/202] mm: Remove vma=
 linked list.
> config: alpha-defconfig (attached as .config)
> compiler: alpha-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=3D1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbi=
n/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-r=
cu.git/commit/?id=3De40a951e09ed0e66dbd646f938df19c876915b9d
>         git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/gi=
t/paulmck/linux-rcu.git
>         git fetch --no-tags rcu willy-maple
>         git checkout e40a951e09ed0e66dbd646f938df19c876915b9d
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-9.3.0 make.cros=
s ARCH=3Dalpha=20
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20

Hello!

Yes, this can be safely dropped.  I will fix this in my next patch
revision.

Thank you,
Liam


> All warnings (new ones prefixed by >>):
>=20
>    mm/mmap.c:2366:5: warning: no previous prototype for 'do_mas_align_mun=
map' [-Wmissing-prototypes]
>     2366 | int do_mas_align_munmap(struct ma_state *mas, struct vm_area_s=
truct *vma,
>          |     ^~~~~~~~~~~~~~~~~~~
>    mm/mmap.c: In function '__do_sys_remap_file_pages':
> >> mm/mmap.c:2830:18: warning: variable 'ma_lock' set but not used [-Wunu=
sed-but-set-variable]
>     2830 |  struct ma_state ma_lock;
>          |                  ^~~~~~~
>=20
>=20
> vim +/ma_lock +2830 mm/mmap.c
>=20
>   2824=09
>   2825		struct mm_struct *mm =3D current->mm;
>   2826		struct vm_area_struct *vma;
>   2827		unsigned long populate =3D 0;
>   2828		unsigned long ret =3D -EINVAL;
>   2829		struct file *file;
> > 2830		struct ma_state ma_lock;
>   2831		MA_STATE(mas, &mm->mm_mt, start, start);
>   2832=09
>   2833		pr_warn_once("%s (%d) uses deprecated remap_file_pages() syscall.=
 See Documentation/vm/remap_file_pages.rst.\n",
>   2834			     current->comm, current->pid);
>   2835=09
>   2836		if (prot)
>   2837			return ret;
>   2838=09
>   2839		start =3D start & PAGE_MASK;
>   2840		size =3D size & PAGE_MASK;
>   2841		if (start + size <=3D start)
>   2842			return ret;
>   2843=09
>   2844		/* Does pgoff wrap? */
>   2845		if (pgoff + (size >> PAGE_SHIFT) < pgoff)
>   2846			return ret;
>   2847=09
>   2848		if (mmap_write_lock_killable(mm))
>   2849			return -EINTR;
>   2850=09
>   2851		mas_set(&mas, start);
>   2852		vma =3D mas_walk(&mas);
>   2853		ma_lock =3D mas;
>   2854=09
>   2855		if (!vma || !(vma->vm_flags & VM_SHARED))
>   2856			goto out;
>   2857=09
>   2858		if (!vma->vm_file)
>   2859			goto out;
>   2860=09
>   2861		if (start + size > vma->vm_end) {
>   2862			struct vm_area_struct *prev, *next;
>   2863=09
>   2864			prev =3D vma;
>   2865			mas_for_each(&mas, next, start + size) {
>   2866				/* hole between vmas ? */
>   2867				if (next->vm_start !=3D prev->vm_end)
>   2868					goto out;
>   2869=09
>   2870				if (next->vm_file !=3D vma->vm_file)
>   2871					goto out;
>   2872=09
>   2873				if (next->vm_flags !=3D vma->vm_flags)
>   2874					goto out;
>   2875=09
>   2876				if (start + size <=3D next->vm_end)
>   2877					break;
>   2878=09
>   2879				prev =3D next;
>   2880			}
>   2881=09
>   2882			if (!next)
>   2883				goto out;
>   2884		}
>   2885=09
>   2886		prot |=3D vma->vm_flags & VM_READ ? PROT_READ : 0;
>   2887		prot |=3D vma->vm_flags & VM_WRITE ? PROT_WRITE : 0;
>   2888		prot |=3D vma->vm_flags & VM_EXEC ? PROT_EXEC : 0;
>   2889=09
>   2890		flags &=3D MAP_NONBLOCK;
>   2891		flags |=3D MAP_SHARED | MAP_FIXED | MAP_POPULATE;
>   2892=09
>   2893		file =3D get_file(vma->vm_file);
>   2894		ret =3D do_mmap(vma->vm_file, start, size,
>   2895				prot, flags, pgoff, &populate, NULL);
>   2896		fput(file);
>   2897	out:
>   2898		mmap_write_unlock(mm);
>   2899		if (populate)
>   2900			mm_populate(ret, populate);
>   2901		if (!IS_ERR_VALUE(ret))
>   2902			ret =3D 0;
>   2903		return ret;
>   2904	}
>   2905=09
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

