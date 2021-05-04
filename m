Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41C9372BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 16:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbhEDOHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 10:07:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56986 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhEDOHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 10:07:07 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144E01CH093391;
        Tue, 4 May 2021 14:05:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=S/wdfZFvivOxYNInp4TnG+vakghQfVGmOE32pURQU3s=;
 b=WWXz7xwMHRch6C3kO2G5ae/QbsOevB0IqW9oD/rjqFy/OOtcSoysGdtOeH00t7FKi6pA
 gIzRHx9KX/cPsqGi50Jd8NXoooZXhL0iUEjlHkgqkSst5sO+pO1VpZREsG9juZUd55sQ
 2p8PnzsZXdKMox/MstcH8V+NPEXOYlCdqSdZqg9p+ZSjFX0GzfRGLT5TcnZCoYbFR61Z
 6/D3oB4hLgccD2OpEUHyZft8QjLWe/cadwbDhAL/HEloSda02vSALAS0k9xxClA9DccS
 WHRCF22mEOiIfMAKV5UjtUs+QAo31+DVJ5+HZdBEDHpqd9CA/jRZByroNZKYkygTQLQB FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 388xxmy1vs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 14:05:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 144E0Fi6101596;
        Tue, 4 May 2021 14:05:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by aserp3020.oracle.com with ESMTP id 388xt4571v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 May 2021 14:05:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAOfuzHJFr7lIJwuHgzxG7Q1yR/Unot+PyygegNCUJPDcC+dClbW+tmtuEjUoYG/Pll2zmQF9fAIeQvnwGzftm2vMv17SOy0NOlo/0eDwsqDaOy2BIQQ99yrDvpMhxQyagkFil8F+n5uVkOAlASC3/CK063DGiNTLP7L+8hCYxn1gCviCKRDFUrt8UMO7xGhmjc/eAevANNvf+ovI/YCq1a23MPOUTu/TSpjU5RpXt7HQ2Krq9dsfYz91vcyzfpwFcpS9Yz1iN4sXysZbFqtDWFwxY7C+1/drOB3mcQOjl9HUZREKXUY67MnH5p1sB0MV6x/hNPBruP2QIwLS21plA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/wdfZFvivOxYNInp4TnG+vakghQfVGmOE32pURQU3s=;
 b=khg/RQkWPIh5QRE1hWjmwETlbMCjpQGZZzMbBxV47fsPCSzEBBkzgQA2zjlMnB5qejX7BbGFs1qgue5TGJT5uHL1B9TF4oWozIFTqIF334uLDddF8hWaPG8zvi/fE3cgXMXP47hIkCcgKtd2XMwO+V35MAFB2rey5gwDyI4dT5r5a+oiZv3Leg+2WZOSKxy6pcT2SORY6TVBTbtJVmp0CHA4nY6LsjLft9kTcwglGauh0UTs/vYWAKDQre6r0Zdm72o1oOq8CXQpHTkTKcWv7LYtPaF2yigdZdJdA4760cFp0ArYevQ6EHweUJHn2AOFH/L98X3lafVBKaqtiSiEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/wdfZFvivOxYNInp4TnG+vakghQfVGmOE32pURQU3s=;
 b=Z20PIRbucTyUda9JNkRmmtj5FA+AiuFJT3qVTirSx6s3MavS0wJfD36jxRCVeW+NyoOX0bKvxuG2qviVfLF0j2MU2VArdJeFwlGe4L9INCdm+Q40Rrp8YqoPAfm0qO9813duYJu5kz68l9sByCH14kEJnp2/KHqv2a2ba6JqdB8=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4404.namprd10.prod.outlook.com (2603:10b6:303:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Tue, 4 May
 2021 14:05:27 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 14:05:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     MAPLE <maple-tree@lists.infradead.org>, MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 76/94] mm/khugepaged: Use maple tree iterators instead of
 vma
Thread-Topic: [PATCH 76/94] mm/khugepaged: Use maple tree iterators instead of
 vma
Thread-Index: AQHXQJ4h5EplJjpLOkCeTY8jNaHwSqrTW9EA
Date:   Tue, 4 May 2021 14:05:26 +0000
Message-ID: <20210504140454.22isjwj66vydyzmy@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210504042930.10436-1-hdanton@sina.com>
In-Reply-To: <20210504042930.10436-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sina.com; dkim=none (message not signed)
 header.d=none;sina.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 86afffd6-94b0-40fc-b324-08d90f05ab51
x-ms-traffictypediagnostic: CO1PR10MB4404:
x-microsoft-antispam-prvs: <CO1PR10MB4404C9B05F6129524D071493FD5A9@CO1PR10MB4404.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eUsx+ik0HBQDlfu0XGsI2fot8mjROQHrCV1jwgFiho7FjUa97UqT7dDiOVZQG9XBZTpON90o+9JryDkWzzdmR08ZlzUJea1J4TK9fMqddKtlEPVBKJkYOdnVw07uc0BcDyW5US/Em2IsbjD8M1uAJHUpUMCqzRxkqr4SyaGgyUic3DAgrlmT+A5RKuN+IIIOg+JFIPBjha+aki60LBMFF3O9mbHU3gYlJ/qscJNrE0HPm7ZsyoZQ3k1mdvN2skhhsiO79qU/cmHFmwCVBltbEPexjpyaGgMEpTsF314HFV52pG4zkG7IFgE+8GxKBwLH8xTggk1cTLUsBkRppdF1UVIx8tD/loKn6avJMG9+dfZ+24E9nEZ/ZftSu6z3Y5DUzfdZjnxBp5Xnzw564oANMUNuT8gaBiugUB19eAMfTvZ8/h5b/HTISmBrv/3xfogKhgp7lDNd/kEtDM+AiYTZy1PoyraH2zzW87FHhmxDsorLLxr3d/0Yt6G2wUi+rplX1zbBmQXVSAvDt4SXeVOYEKzuaKpQO+ze2/6ssXxSVRP8W4K+YhYP+dHXHx4bkv0EMHWN+0MmaFe+vOgFOOwGeoFrtVLHE0ru4rQh/XsHZzk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(346002)(39860400002)(136003)(366004)(396003)(66946007)(91956017)(38100700002)(6916009)(122000001)(71200400001)(76116006)(66556008)(66476007)(1076003)(26005)(86362001)(66446008)(6506007)(83380400001)(64756008)(54906003)(5660300002)(4326008)(44832011)(478600001)(316002)(6512007)(8676002)(9686003)(2906002)(186003)(6486002)(33716001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?kcPgjqYqBCp5GxJ5Mo1DbgY5RPchPH//rJISsUgT58rTboHbrWQ27w/wVjrG?=
 =?us-ascii?Q?xYI5k+QeevtFyDqYwh7qEnDax6idWB9XXnOwNfH7Rjo4YNIeXpDwGnpbLFOZ?=
 =?us-ascii?Q?d5Vqg2HdQ8z3ay9/nIZca5YfXzZkWqRVlxR7nHVSwlDiM8OrZ2QFdIszpIDj?=
 =?us-ascii?Q?WvPFHTbAJRRPCfoNH9Feg+0/CqhCn5zF4dv5fJHXP+AEYdDpIHBQi++0YdOt?=
 =?us-ascii?Q?+rsopU/diOs8U6aQjbsdqGFkp1H8u+780eZJgm5UUvWyeJnM8ZDUlMwt3V8E?=
 =?us-ascii?Q?tHShHP710wJ62l2axOP6WUb/MzTQanjl0DGKi4Ebm9xngJ+JJ0+sUghM2DGm?=
 =?us-ascii?Q?PDH7TKtgIacQf+NF9yeGrRj06+QMnAcEIDPyAoOdI8STgjLBLhLF+olX9ZlJ?=
 =?us-ascii?Q?PpftX61ec9Tut/zwU1IZSxj62MsyD9F+49Xp10iUPR7ThLM2iKufojesl1FZ?=
 =?us-ascii?Q?BqIcrgHn46L9J7TeGV6+G75AY+h4fRERXqaxE4wzj404T4+mmjSTYJxkdN0F?=
 =?us-ascii?Q?PAl4zrLXTgn6sKDiZAhjSe/m24Hl6+zqb5nt6NMoDH5ClhEzev/kioilvLsq?=
 =?us-ascii?Q?HV/AJSqgy3zHwmnIFwn40dHcXcP+o3X2IqftX/EdwzGTxox7A7pWHQy5973L?=
 =?us-ascii?Q?WaESiKSsF2PHYwTpbcPfwdiES2f6rYrNilYYfM/bWXyEK6dvC7KytehjrRAu?=
 =?us-ascii?Q?bX/ii0zpugGfSCqyjxC1BFd/LckEmPT8WvdPYmC5p/lb4D2GLmPBWqq+dCif?=
 =?us-ascii?Q?DDLE+RAyPbyEY+vlYMgD6vDD4k759AH5+VNn8oIVa01m8h7IHUyn17BQj8xy?=
 =?us-ascii?Q?LqeAkmKXKz/khOaQbFDrjTysVygKORq1MJl8GJrzHAms3S/jjFlJJiPTaqHy?=
 =?us-ascii?Q?OVS/iCzvxE5ABvl8Ds8pFxVjsWVXuOscd2CllXL79Um/6EbLIRiZ9kzo6RAU?=
 =?us-ascii?Q?NvX8qFmv4cTPA7XeFL5mM24DzmbxhRihx/NGhjAv+UxpDGcbPbK4vuFRrzO2?=
 =?us-ascii?Q?TRW2nYY13siUFkKs3GjcjJKsTpucHbUFfK9jpJKRF/HZTk6X498MgAvfU27C?=
 =?us-ascii?Q?rd0IvSECmRAuIlz/DrRbwdWc5TKcmmqcGPPrtWyNNIQ2cIfVWpuWo+xhD2OR?=
 =?us-ascii?Q?tw9xCHHu+44Nvs8LGSDjf1TBeMk49zF3KacKRtTagkumY5AlizE808pF0DnG?=
 =?us-ascii?Q?dEXzVbCXqaLRhYIGqkwJSdcQZL2rT8AgRWIIn2a9HKGCCo+nSHTcq9hL+cRp?=
 =?us-ascii?Q?KrPBiMeyRPiHASD045unJVtBqKXSKZXt55EZkxCiEjbzbBEfjDZEdCBRQ62i?=
 =?us-ascii?Q?t0JtTeMDttIgNLU8vt8GXp7m?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D3DC6C3B8E40D2468C0FC93152EC07CB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86afffd6-94b0-40fc-b324-08d90f05ab51
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2021 14:05:27.2057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSNWlgG4PuNW35ny4mYWDa2CIgCnu5tq+M3/C70NxixH/f9HmQYMqgF6pNIiHWA6VaONQ2cpypkn5HYJoyp7Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4404
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9974 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040105
X-Proofpoint-GUID: etyhDJHhzTYSlaPbxn7LRXwduUNg1_Ls
X-Proofpoint-ORIG-GUID: etyhDJHhzTYSlaPbxn7LRXwduUNg1_Ls
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9974 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105040105
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Hillf Danton <hdanton@sina.com> [210504 00:29]:
> On Wed, 28 Apr 2021 15:36:24  Liam R. Howlett wrote:
> > ---
> >  mm/khugepaged.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> Good work. And a nit below.
> >=20
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 33cf91529f0b..4983a25c5a90 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2063,6 +2063,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned =3D
> > int pages,
> >  	struct mm_struct *mm;
> >  	struct vm_area_struct *vma;
> >  	int progress =3D 0;
> > +	MA_STATE(mas, NULL, 0, 0);
> >=20
> >  	VM_BUG_ON(!pages);
> >  	lockdep_assert_held(&khugepaged_mm_lock);
> > @@ -2079,18 +2080,22 @@ static unsigned int khugepaged_scan_mm_slot(uns=
igne=3D
> > d int pages,
> >  	khugepaged_collapse_pte_mapped_thps(mm_slot);
> >=20
> >  	mm =3D mm_slot->mm;
> > +	mas.tree =3D &mm->mm_mt;
> >  	/*
> >  	 * Don't wait for semaphore (to avoid long wait times).  Just move to
> >  	 * the next mm on the list.
> >  	 */
> >  	vma =3D NULL;
> > +	mas_set(&mas, khugepaged_scan.address);
> >  	if (unlikely(!mmap_read_trylock(mm)))
> >  		goto breakouterloop_mmap_lock;
> > +
> > +	rcu_read_lock();
> >  	if (likely(!khugepaged_test_exit(mm)))
> > -		vma =3D find_vma(mm, khugepaged_scan.address);
> > +		vma =3D mas_find(&mas, ULONG_MAX);
> >=20
> >  	progress++;
> > -	for (; vma; vma =3D vma->vm_next) {
> > +	mas_for_each(&mas, vma, ULONG_MAX) {
> >  		unsigned long hstart, hend;
> >=20
> >  		cond_resched();
>=20
> Given the added rcu_read_lock(), take another look at this scheduling
> entry?
>=20

Yes, thank you for pointing this out.  It is certainly an issue.

> > @@ -2129,6 +2134,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned =3D
> > int pages,
> >  				pgoff_t pgoff =3D linear_page_index(vma,
> >  						khugepaged_scan.address);
> >=20
> > +				rcu_read_unlock();
> >  				mmap_read_unlock(mm);
> >  				ret =3D 1;
> >  				khugepaged_scan_file(mm, file, pgoff, hpage);
> > @@ -2149,6 +2155,7 @@ static unsigned int khugepaged_scan_mm_slot(unsig=
ned =3D
> > int pages,
> >  		}
> >  	}
> >  breakouterloop:
> > +	rcu_read_unlock();
> >  	mmap_read_unlock(mm); /* exit_mmap will destroy ptes after this */
> >  breakouterloop_mmap_lock:
> >=20
> > --
> > 2.30.2=
