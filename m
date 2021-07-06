Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B303BC828
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 10:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhGFI7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 04:59:04 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:57352 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230295AbhGFI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 04:58:52 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1668tuDx005043;
        Tue, 6 Jul 2021 01:55:56 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by mx0a-0064b401.pphosted.com with ESMTP id 39kmh8gy68-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jul 2021 01:55:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TaRoeyvu+IhuHiv4HejKqlL/1KRLS//x6bAuYcNTNyYECwUKr0eQ1HnNSO1Odz1H6dhGBzadb3Xmj83cmbAQiCYhI6Q2JQDJDJOQMcQqv7ea4czDEk2NoQXFXRTnbCixIOzfN7S79Yts7fZh0+/UJ7QMcwmhNE3GAGBRVoyii/T5OB6eZLsw6wNtiXHzgByO9GpNKaiG9FunVa9QJ8kTlRgvL8RP7IvmoVxZVncs2t6T/HcJwEkLpZ9BZhaS2XDPpz/yNiDZ5E7GoXrs67F/nIhqP05bX8LxdItQFBNDCIH9OjvxqMBOKSsphP8I8Rsk4+sq6qYd0qAVZCQ/Im3qoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOZ/w45IkGj18tYsdPMTfTWt5xuQttIVHsqU4/qj4/0=;
 b=O1wYkLVLQNGfxb00PQj/yPaO0GvL7v9U+Vqs9HbI2yx7RAvQ7+QvmIKuWxnrXTQMedwpZteJ74bWokABQaPEozOhXAFpzJ8vRWWkcOI01Kh2gzhqnyeiFza6yzihIrKTdM/96PkS0raGMgqAD+Uf9zUadEeaEtpLV0lS3Pzo5oK3EM7sTkbDIgMPGajUcb6iTX5ePbuBl71v2ZqseieLhiqWCzrW3urJaaDkiASHP76yop6oQkCSEdzL1EQET+e83oODln6acmH5Im8ORP1rxKeK714Peo1iWzX4pLBAYGBAca+lPRbGITo3VQ44xztxC+DWM9/8x5Pg2QMA71BozQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOZ/w45IkGj18tYsdPMTfTWt5xuQttIVHsqU4/qj4/0=;
 b=A+K4F6hJaxTFrVnQYxBAtPjPCBkjEZhNfyG3AfAXqe5LKkzvaL5be3J+JwrUgz4G17Oie1KQUAF3QYZh9i6ladcpFWUp6e3fvAs+DHE8/XB9GCBxZzVyKkruHgGBsr5Cz3iX7KoMnQqOqpVYme/Py4vovW1IyAPiEAX559tQn0k=
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by BL3PR11MB5729.namprd11.prod.outlook.com (2603:10b6:208:350::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.27; Tue, 6 Jul
 2021 08:55:54 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::a140:b563:8725:5c2b]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::a140:b563:8725:5c2b%8]) with mapi id 15.20.4287.033; Tue, 6 Jul 2021
 08:55:54 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     "syzbot+0123a2b8f9e623d5b443@syzkaller.appspotmail.com" 
        <syzbot+0123a2b8f9e623d5b443@syzkaller.appspotmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "alobakin@pm.me" <alobakin@pm.me>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "wangqing@vivo.com" <wangqing@vivo.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mm/page_alloc: Fix sleeping function called in case of
 irqsdisable
Thread-Topic: [PATCH v2] mm/page_alloc: Fix sleeping function called in case
 of irqsdisable
Thread-Index: AQHXcjyjC70zMlHRqUy2vEZysRODP6s1nrCAgAAEfeo=
Date:   Tue, 6 Jul 2021 08:55:54 +0000
Message-ID: <BL1PR11MB5478A2FD3A25289C31B556DAFF1B9@BL1PR11MB5478.namprd11.prod.outlook.com>
References: <20210706075754.10726-1-qiang.zhang@windriver.com>,<20210706083323.GQ3840@techsingularity.net>
In-Reply-To: <20210706083323.GQ3840@techsingularity.net>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: techsingularity.net; dkim=none (message not signed)
 header.d=none;techsingularity.net; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88b43b89-5a78-4cbf-4e07-08d9405bdd20
x-ms-traffictypediagnostic: BL3PR11MB5729:
x-microsoft-antispam-prvs: <BL3PR11MB5729BF7504336A4D4A6AF071FF1B9@BL3PR11MB5729.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 30m7Dq+8/fLC/nUZYwuwHtBh6KetptP4ISzpGJ6udodBRSnZRMpU4Fki3GJrpQlrwMLvVe/kSK6CXyRGpNaDXL4gis80OWqI9LNESQAn9rkLMG7LEHOHiZN9m4OxHJIwCd4fn/aJqjsAj4FpbtZPzaZq1pP7qEklR/2kTeOFBJ7RwESXbdF9kQsyLhGNKYVNQv5wBtqRp30F4BN0vWjJvvgSq+yrFg5yLWd07F4jinRN7a8OaYtfO3xu0UBpdqGmZD0yM3pne/KEx0yZVdzYhy9E2YicyiJciON3CS9DWjAZfgIt+6mOT3kzYCguOM7cITHjMjQ6rSOk56ZPgehzqaLpooVU5pRa07TmRjqxvqxWMLu33LbEPzVLidx0SPhhVSGeuJb5fBw8rqtn/pbWVYYZR+p23LX+HrGEuH/AUh6SYtpwv9Xe/trC2fGa1pr3m2bI7boKf7rtJYCvTCrZ2aKiARZe60+uoifVXx9h22QUe+ZYkKdevUoCZYOiw3E7Osxk8umJDQ5J43Zv0XvXZ1f/eIxCytqAme1Iw2cmJTgVHoYRfW3j1pE/3c0jxsQIMC7bnlCYpElIu49V4APkMQEcUfZNOnWFZbG3yUMpvhUnc1tWXcTIqzpqoesfk30yajxI6z/9OjHt+sGaIheqrMIsL1uzWSrhhSJYSaF+41/EBDRliUpWZn5lPFVwDYfanuKo/d6+Sdo1hHvyuZyYkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(346002)(136003)(39850400004)(376002)(52536014)(4326008)(26005)(33656002)(71200400001)(54906003)(478600001)(8676002)(66476007)(64756008)(316002)(6916009)(8936002)(86362001)(91956017)(38100700002)(9686003)(122000001)(5660300002)(66946007)(2906002)(76116006)(55016002)(6506007)(66446008)(186003)(53546011)(7696005)(83380400001)(66556008)(586874002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iCmpc2gCiFBPmoi3JbxcmoFunF/s7LtOVS1izUpQCuUO5aMNbDIjgqlUYnhL?=
 =?us-ascii?Q?XGGSXFDaly1/w3DXE0G6Smf1Fm44r8osuDvuqnYdJVAFiMSPxeNiEMvoEJoS?=
 =?us-ascii?Q?PlayIE1/bljJ4Md8KYXqXl+nYRpvrJfvEiQ8gDiGpNybfvdp/gnlX4hCuOkZ?=
 =?us-ascii?Q?najsB7+HLA8NOBN0HSAzq9NrQIFrPB0x+dq7JOVr+QhjAmRMM0qjbh1CJ4gh?=
 =?us-ascii?Q?HiIr0pE6WFW0KpwfoGzfMZi9e6BUqtO5NGxnIEUmYhGV2TFtwGqCA7rR5g4p?=
 =?us-ascii?Q?keMHWnv2ISX9POkunNnc2pLwhPKeQNHwi0YhGNely9zIBsPswOQIpTP1s3q0?=
 =?us-ascii?Q?jPZOc/NJPV/NUeLUjqOqQzaHunwssAVyFXxipHQkDd6Op/Srdi/S2xyCumGs?=
 =?us-ascii?Q?YuHJvZhc76xB3g6qgxqpRm3nY/p/8tR+24OxdQEH4Bz9H4IdI9/jnbkyVW3N?=
 =?us-ascii?Q?zXJnUJTfCitfN6E6y3nGBSJdwO2GLgHDoVicV30I6Zhg8s7izbzH8/kwygEu?=
 =?us-ascii?Q?oGd1TGbX/argQk2Ls7SdBsZfFAuQwFO5sWSzgd7OTgKB2F4oVPLxQqbzexpd?=
 =?us-ascii?Q?UY1Z0WA+nbUULJlSBHFu/vsbPqmurstw31wS8JUzcrE5x/srKZL92PsbN1Y4?=
 =?us-ascii?Q?d743xZlNF8GhYtYuNmkri94l7e5u8wnstpDcN8oMI8mGpiYXeiXlqLxAmxcC?=
 =?us-ascii?Q?idfZgK/rl/rg+l1oCEAqBaPNZZV7TaV6jwkNBsPgbjr8GoZ563Kp/cjL+Fl+?=
 =?us-ascii?Q?wmubpfojlNzKykrStDQo9U2cbqlbSFgqFxb7NaGssrVaq4VbCTGUkgcGt0jU?=
 =?us-ascii?Q?lLzvi+yUGu2nfR98soHPu9Yly3ya1c0XMsi9Iokgu7dnVII8vi1hoOCR12wW?=
 =?us-ascii?Q?VnFghn7+xgPyNGj0B6JGI/RVADzWt1uW/6aR280XbKVTmNd9gKHOeT39ASXg?=
 =?us-ascii?Q?cvjE+aql5qDWJhrXfBfwXm+VnYMT++3pwoa/YI59pE10LMkEkZF2DO6MP7Zg?=
 =?us-ascii?Q?Z/2Twg37QTDrmyhk9pLhCZLNPmJtP/lcszLOlsf/c1egil11sLgkxQ6QyqaZ?=
 =?us-ascii?Q?bdrGpMncgpOpdbi4f7FEy6p4kMFctVJ9Zpm0bGYqG5Z8WHHVEniswNdPnx8j?=
 =?us-ascii?Q?/T59y7PQkZ1HYpLBCKkTlRR41jpBPxj7LShaR0/mYcpdRLTERCJjJGjpeulw?=
 =?us-ascii?Q?07FFy082mnow049D/KqsdwjlJWHDcaBJq01OMmigx5Pv7fskQSBC2lXdZLJJ?=
 =?us-ascii?Q?n0U1UVqgsTER2ZmVKhIwYKeWdTeu2yUIVdXhu+2dskfQRGOaHzPhn7jX76F7?=
 =?us-ascii?Q?+a4=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b43b89-5a78-4cbf-4e07-08d9405bdd20
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2021 08:55:54.4753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zJ/+zHWHeftZibLhRZY2cZtNJlpRg5uNFvPiPTIy2NGmdVIRPkcqHKkcos3sFFlV3Lb3X+/L4y+8mCqzMCzwGQF03oggnI6DSm4+rx1Rc8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB5729
X-Proofpoint-GUID: uowpv7dIFHttivRrN8Zrcb8n2_8R6ZD6
X-Proofpoint-ORIG-GUID: uowpv7dIFHttivRrN8Zrcb8n2_8R6ZD6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-06_04:2021-07-02,2021-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107060043
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
=0A=
________________________________________=0A=
From: Mel Gorman <mgorman@techsingularity.net>=0A=
Sent: Tuesday, 6 July 2021 16:33=0A=
To: Zhang, Qiang=0A=
Cc: syzbot+0123a2b8f9e623d5b443@syzkaller.appspotmail.com; akpm@linux-found=
ation.org; alobakin@pm.me; songmuchun@bytedance.com; wangqing@vivo.com; lin=
ux-mm@kvack.org; linux-kernel@vger.kernel.org=0A=
Subject: Re: [PATCH v2] mm/page_alloc: Fix sleeping function called in case=
 of irqsdisable=0A=
=0A=
[Please note: This e-mail is from an EXTERNAL e-mail address]=0A=
=0A=
On Tue, Jul 06, 2021 at 03:57:54PM +0800, qiang.zhang@windriver.com wrote:=
=0A=
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
> Suggested-by: Muchun Song <songmuchun@bytedance.com>=0A=
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>=0A=
=0A=
>Same comment as v1 with respect to the impact of enabling/disabling IRQs=
=0A=
>for each page allocated -- it hurts performance regardless of whether=0A=
>page owner is enabled or not. If returning a single page is undesirable=0A=
>then a slightly different alternative is to only enable IRQs if page=0A=
>owner is set and then goto "Attempt the batch allocation" to reacquire=0A=
>the lock and lookup pcp.=0A=
>=0A=
=0A=
Thank you for your explanation. I didn't take performance into consideratio=
n.=0A=
=0A=
>--=0A=
>Mel Gorman=0A=
>SUSE Labs=0A=
