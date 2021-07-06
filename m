Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EC93BC700
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 09:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhGFHTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 03:19:09 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:55242 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230138AbhGFHTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 03:19:08 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1667G3mI003949;
        Tue, 6 Jul 2021 07:16:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-0064b401.pphosted.com with ESMTP id 39mjcfr09j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 07:16:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J3YGS0Eop0nLl4OF3M1OFu5GA4e7DQBCGMy1NZkhuriN2h3nEQ92x9VrPUo/5FDTRPaTdOrvuP1QU/FHvTC4KDS4ipuXYFHy8davpbWNRpnD8zZYTUgLycH8VDE8Zi/c6AU+aMJM9k01/u1UtTsazcqZB12+Ppz3ygQZaVQz3E7OV+TsEiq2uk7Iom2ZP7iQwlUc8TNzKvJ6P+ZP8qxyFOxNRirKscbtNgSIEsLAdMlfDKRTLNec1ylLo864HkehmohnZuI1EmEQDRAhhcsdfvsJKMdfatS5a4KWmmU+YffhbXYOwnhNh2e6+Hagit7haO0S6lqkYAAWEGuuRLC1jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM5xO9ExqHQcsgTYac4ice9kcY3s8BYce8MaFdz0Ztk=;
 b=ZkcGeXcMV6vjqDgMwwTsb1zOw0w/uY0YdWV56lJZbc5kRvMDXW8H6AF8tI7NmibEQuG3augaXmWwzaN1jO+T/ypMnFD1jsfUwicOiNG8y78HyuDAUOi6VQ2VFXVBf6yLkKAYKODLyCvm8jY2lh+jv7iFk6aaZHOsonTdEnUEqsAoGGp6d3A6UXyc4lu7J9GeSGcOClgLmRWgoYDVMZ1L1O20wWh70qFVpvATXJpBkn77ZGaX3tVxXUq20BLCUvVNRndskqHUmsZCTchZBQvPf5DBtWuPSKyn2DECsekB01lDWpBQ/IH/goNnGg9tmyfdx9LUkIl1Xl1k3Lk0WbivXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TM5xO9ExqHQcsgTYac4ice9kcY3s8BYce8MaFdz0Ztk=;
 b=EVYQeQsT856M8arMC5EzsTteoUsv5gzsrqSAt+q1Li7hc1MajRbaCRJ6z6Cng0t/LV64MkcHW+uECIgSL/WiL3Ba1M1nd1Y3NLxRczzvCQ3vEKYaW6mXJze2VmsbDKatxwIKridjGuKeZTY2tcGFr1QCfv+9JFy+I7Ch4MHXnmg=
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by MN2PR11MB4679.namprd11.prod.outlook.com (2603:10b6:208:26b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.23; Tue, 6 Jul
 2021 07:16:13 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::a140:b563:8725:5c2b]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::a140:b563:8725:5c2b%8]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 07:16:13 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Muchun Song <songmuchun@bytedance.com>
CC:     "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "alobakin@pm.me" <alobakin@pm.me>,
        "wangqing@vivo.com" <wangqing@vivo.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [External] [PATCH] mm/page_alloc: Fix sleeping function called in
 case of irqsdisable.
Thread-Topic: [External] [PATCH] mm/page_alloc: Fix sleeping function called
 in case of irqsdisable.
Thread-Index: AQHXchcYgGF/+qrbbU2ClPtOwI1Ekas1gh4AgAAG0ns=
Date:   Tue, 6 Jul 2021 07:16:13 +0000
Message-ID: <BL1PR11MB547867F20F2A7A65F7BF1F4FFF1B9@BL1PR11MB5478.namprd11.prod.outlook.com>
References: <20210706032907.1276-1-qiang.zhang@windriver.com>,<CAMZfGtVB-UQV0i4_mrRrt59iWFZbchm1FtT_TFhaE6Bmp43Hfw@mail.gmail.com>
In-Reply-To: <CAMZfGtVB-UQV0i4_mrRrt59iWFZbchm1FtT_TFhaE6Bmp43Hfw@mail.gmail.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bytedance.com; dkim=none (message not signed)
 header.d=none;bytedance.com; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e32c9ba9-7e44-4d2b-8040-08d9404df005
x-ms-traffictypediagnostic: MN2PR11MB4679:
x-microsoft-antispam-prvs: <MN2PR11MB4679AC9484594AB7078F56D8FF1B9@MN2PR11MB4679.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UdlMA4fdBtxzDQmETk7Dv3aJ210WLXODAxznPds25iZ2xo98E5ycd/6A68bz0XcbpSudB7KJox5mhaotUFEN/dWwW4GDg+JgW/C7mExc/8cjw5LvTjMN7MOua3xpO0Me5UOXyl8Vc3bYg5ZKqlQcUt0JtwZV83cTgfXgTq3xHb2+NOvMJLSioaJ7Gp5e/ucZPd+osZEgiH91E1oEI+sjqR3igXvNWr+/TFDdEihuw2wdEzc0iGxKNJgZBj4ssolkW25iRk/itybiuORJKVx6JQyyjeSVz3AsPgv1QP55nTntA/69D5oY8i1OtZTPzqSn8uuPQGbedz3IAscfwi0gkI2kN95SUCYJevGi7L11PmihBjTy6x3yCp52y3je9dFEjrZHpRM4qgAiu0REl7TmY2v3HDjUUbidRLKdRRTVs3lBw6+uKjdutwaIkSpq4Xr1Yyq79USDZW1eHP3g0ZehhrnXjuWouWf2lUTZ61K81SWNVBvQr6bbnibdOkEskRxsTBanM3pAijEZcmNDMblctNAERNH2CrA7WJEbhgP8yOdr6qeIOlBDULYghTelg+YGh6q0oqPhfhLByfsM8DsE3VinrAy/yeA2euHvdS1q64ub9nXQdfUtt7hyaPdLTY9+3785x0+fk2BwhT3SlYPb2XHecEhaFhn3jBqmIX34/IPAqbEbyh+3aSisSW0F3eyMWYESQ2ydayl7DZNjIbWIkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(376002)(346002)(136003)(396003)(86362001)(8936002)(91956017)(6916009)(66446008)(4326008)(54906003)(316002)(33656002)(122000001)(2906002)(478600001)(66946007)(38100700002)(52536014)(26005)(66476007)(53546011)(5660300002)(64756008)(76116006)(55016002)(9686003)(71200400001)(7696005)(8676002)(83380400001)(66556008)(186003)(6506007)(586874002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5DZU4EydNCiF5qoqk+VbjKa7qbIPucUu6JnU4sKevMsuHgf/PyFgMSpj8u9v?=
 =?us-ascii?Q?Lwwoxpg9HPAKmmtZOkESK1yVsrjfa+GHn81+MZAh/r7X8KYPGc+eI7jK018r?=
 =?us-ascii?Q?c3keOjPDympX28epFtnPSAeA0GrTRgVLeHIQZL3L4Y/PJzkhxCPzlYmkfy31?=
 =?us-ascii?Q?tyHGExTIRtDt9jmUpUUTb5/pA4RQQtU2gims7jdiErDwV5DaMunOIPvti547?=
 =?us-ascii?Q?a7VSGqOR9lHr48rTxtCx5d18oEUmUsDR8l0mIvHZLMYmYyZIePnmgjr7H4nm?=
 =?us-ascii?Q?1d9+FVQ1m8jOAKpS+EXlmkYuRLmfhpYVeAGPrh5BdNrQyRNrnLrdvKfWOGhs?=
 =?us-ascii?Q?QricEIXW/ehJy2EtHp9nBFqcLpeSjReCXCIlap4ko7pPThx8semF6ut80EWo?=
 =?us-ascii?Q?OpV2i07WQaefFyP9RlMMHwcw3qmTimpoqOnqCjRo17HVAX2Q6ssiy6cQKtcq?=
 =?us-ascii?Q?B4uyQ39uI5YY/KUJFOtxHf1AJPsSSahjSFY3abw9NWi6lUlXiuK344IHfxbv?=
 =?us-ascii?Q?Nbwe32T2iKx4UtioeIoTqV8YkiA/U1hmyZY0qhJHs69G9qstF2W02ZPoL1xZ?=
 =?us-ascii?Q?dtquxaZfuF6xMTrLVWJEG0nE6g/ViYs7UbmISXPPnDz4X83wirzHK1YjDR88?=
 =?us-ascii?Q?4D+tkDXhdxzv6YRPcFZ43cTR2vRdwovHJtMwdgTNrE2yn+GGRcjFMGNm5bRH?=
 =?us-ascii?Q?uP3ZDA/UKAiEFe94waE4vtYq7rBorrDBMbvp/ANEJYeYPGlTRM9wBDPWr/Ma?=
 =?us-ascii?Q?KSfyikR/HUFFE/JEnt80ArbIWrUCFTFFwPG0dYf4xr1xk1GUVmjnTwlIhYOV?=
 =?us-ascii?Q?WpJNWMxphBm5KnYAodkMdlUn18GfcXAK+BQ7sSI+3uuharXGy78yLR19ROEc?=
 =?us-ascii?Q?lBupG0JFrJwCmHADTdMg0BcbQBeGcxTyhbgYP1VQ1wQbdZxhfbHkPNmH+fUs?=
 =?us-ascii?Q?tFL/db36yHi0xal34lcRnbITt5u+O19esOLj1k4AiB8A53xxuOdohFEMnY/0?=
 =?us-ascii?Q?0UxfnvQwaPNKpr0GMcdUVMg6OdwrlS3KXu1mSfzPJdukYAxhzr53iJ9a8j3i?=
 =?us-ascii?Q?nP0dH99jpAkS0qbtLqYbHTORSCeKGbvvQCCQFgkLH6Eg363Xg6/k9pqisMoT?=
 =?us-ascii?Q?idezQDWaNmQKwaC0DgjNXomvV7tTI9n310kfROnMkF29BNi9lsytWoNdVRnu?=
 =?us-ascii?Q?vxzbpDklwaXmhWzPyq9Uv5ps9964+1MNnSeT36Jto3M/08R8fqECYYtKAcA7?=
 =?us-ascii?Q?p4V0b9ohZjyKC6cYuhdZMeJcGvX0Vwa9yA3SGk0q3TVpVsTFPBUXRo4DOv70?=
 =?us-ascii?Q?eBc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e32c9ba9-7e44-4d2b-8040-08d9404df005
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 07:16:13.1614
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qL9rDRE+fx5lHkhJPAIqiEvohZ5bgmUnl4gTsilV3QRTn5tOHMoyYPBb6BtWZCbQcwVRSRgC8Xkc9wju/FlqHez/kMWpmkJRHpbXs0mvHSk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4679
X-Proofpoint-GUID: oru2GrStLtG1VgqytDK1_zefEp6VX9Ly
X-Proofpoint-ORIG-GUID: oru2GrStLtG1VgqytDK1_zefEp6VX9Ly
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_02:2021-07-02,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 clxscore=1015 phishscore=0 lowpriorityscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107060036
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
=0A=
________________________________________=0A=
From: Muchun Song <songmuchun@bytedance.com>=0A=
Sent: Tuesday, 6 July 2021 14:50=0A=
To: Zhang, Qiang=0A=
Cc: mgorman@techsingularity.net; Andrew Morton; alobakin@pm.me; wangqing@vi=
vo.com; Linux Memory Management List; LKML=0A=
Subject: Re: [External] [PATCH] mm/page_alloc: Fix sleeping function called=
 in case of irqsdisable.=0A=
=0A=
[Please note: This e-mail is from an EXTERNAL e-mail address]=0A=
=0A=
On Tue, Jul 6, 2021 at 11:29 AM <qiang.zhang@windriver.com> wrote:=0A=
>=0A=
> From: Zqiang <qiang.zhang@windriver.com>=0A=
>=0A=
> BUG: sleeping function called from invalid context at mm/page_alloc.c:517=
9=0A=
> in_atomic(): 0, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0=
=0A=
> .....=0A=
> __dump_stack lib/dump_stack.c:79 [inline]=0A=
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:96=0A=
>  ___might_sleep.cold+0x1f1/0x237 kernel/sched/core.c:9153=0A=
>  prepare_alloc_pages+0x3da/0x580 mm/page_alloc.c:5179=0A=
>  __alloc_pages+0x12f/0x500 mm/page_alloc.c:5375=0A=
>  alloc_page_interleave+0x1e/0x200 mm/mempolicy.c:2147=0A=
>  alloc_pages+0x238/0x2a0 mm/mempolicy.c:2270=0A=
>  stack_depot_save+0x39d/0x4e0 lib/stackdepot.c:303=0A=
>  save_stack+0x15e/0x1e0 mm/page_owner.c:120=0A=
>  __set_page_owner+0x50/0x290 mm/page_owner.c:181=0A=
>  prep_new_page mm/page_alloc.c:2445 [inline]=0A=
>  __alloc_pages_bulk+0x8b9/0x1870 mm/page_alloc.c:5313=0A=
>  alloc_pages_bulk_array_node include/linux/gfp.h:557 [inline]=0A=
>  vm_area_alloc_pages mm/vmalloc.c:2775 [inline]=0A=
>  __vmalloc_area_node mm/vmalloc.c:2845 [inline]=0A=
>  __vmalloc_node_range+0x39d/0x960 mm/vmalloc.c:2947=0A=
>  __vmalloc_node mm/vmalloc.c:2996 [inline]=0A=
>  vzalloc+0x67/0x80 mm/vmalloc.c:3066=0A=
>=0A=
> If the PAGE_OWNER is enabled, in __set_page_owner(), the pages will be=0A=
> allocated to save calltrace info, due to the allocated action is executed=
=0A=
> under irq disable(pagesets.lock be held), if the gfp variable contains=0A=
> the flag that causes sleep, will trigger above information. the=0A=
> prep_new_page() is not need to disable irq for protection, fix it through=
=0A=
> enable irq before call prep_new_page().=0A=
>=0A=
> Fixes: 0f87d9d30f21 ("mm/page_alloc: add an array-based interface to the =
bulk page allocator")=0A=
> Reported-by: syzbot+0123a2b8f9e623d5b443@syzkaller.appspotmail.com=0A=
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>=0A=
> ---=0A=
>  mm/page_alloc.c | 2 ++=0A=
>  1 file changed, 2 insertions(+)=0A=
>=0A=
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c=0A=
> index d6e94cc8066c..8d7f0f5ce891 100644=0A=
> --- a/mm/page_alloc.c=0A=
> +++ b/mm/page_alloc.c=0A=
> @@ -5309,12 +5309,14 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int p=
referred_nid,=0A=
>                 }=0A=
>                 nr_account++;=0A=
>=0A=
> +               local_unlock_irqrestore(&pagesets.lock, flags);=0A=
>                 prep_new_page(page, 0, gfp, 0);=0A=
>                 if (page_list)=0A=
>                         list_add(&page->lru, page_list);=0A=
>                 else=0A=
>                         page_array[nr_populated] =3D page;=0A=
>                 nr_populated++;=0A=
> +               local_lock_irqsave(&pagesets.lock, flags);=0A=
=0A=
>Because pagesets.lock is relocked here, the current=0A=
>thread can be scheduled to another CPU. The @pcp=0A=
>and @pcp_list need to be reloaded. Otherwise, it is=0A=
>broken in the next loop.=0A=
>=0A=
=0A=
Thanks Muchun,=0A=
=0A=
I ignored this  problem, I will resend.=0A=
=0A=
>Thanks.=0A=
=0A=
>         }=0A=
>=0A=
>         local_unlock_irqrestore(&pagesets.lock, flags);=0A=
> --=0A=
> 2.17.1=0A=
>=0A=
