Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B3E3ECFFF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 10:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234729AbhHPILD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 04:11:03 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:4928 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234525AbhHPIK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 04:10:57 -0400
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17G7k1Lm014924;
        Mon, 16 Aug 2021 01:10:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=oyV81yr+5N/2o0NAuNFWsURu7tOiHFbFu9UO1kr0w5A=;
 b=NrkBrBOjlqxtuf7+tIcKOphLXWHeqbQ8Zkc26TEqjKIuuZqtfJM4y51a4aGLmQ49Laa/
 IGnUjgaeksC/0I7hDBgSgP+lWvgWw6A8qBKORY8HQAf5FWj2O26BEbJQcHdnnRtJvqLK
 wCV3vBLa2rWg7BUHqOKnBKNuOjUXcsWJcW8NBr5FZ0H9mhn529FZ8rIu6WFopYBEhCaE
 0ZRIBjPXxrD5OPqvLz8zZH2/Ytu3j0awVEoaIJ80muFmeO8GGSLim0HCLmRzF7qSWW04
 awBZAdM3FXf+hf0Je7D44vwrfbq1zllh6QfhmhAj7zZHUbw/T5s3J3Q8PX+0o92whSS8 mQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-0064b401.pphosted.com with ESMTP id 3afajf07mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Aug 2021 01:10:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aad5c4+HMoRDojVIgoYoWgZyr0vbnPRS6rrkLtLiGv+YEC8lUHgs+B7GQ1EKsoUs31yvVsX/84ZVU8EED531+1ZPXxGKnpxCTKmBkeijTu7J91A9YA2DMUcL+jI5/8gSMh1OH98a2p+VUXd+RZXrk8neRaKXdJfa+zeueRucyZ3/HBWAiaewnhcZAlleF/FvVdIXZNwfDd4BCgQN1aP9n/B2Wbt1Rdpy7cw8tVf7wnasuvH+JKUKifMfuzbasKlRd6HWgRubEuOoGpXi5eRMPbAVYoLleN+IYAncDLZcl6e6B5yIFEv1PMoYC/ieK2gSLv+9VKDkO/oCI0ODlbxfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyV81yr+5N/2o0NAuNFWsURu7tOiHFbFu9UO1kr0w5A=;
 b=WDJjYMSSuUQTtrGQHvFGhgQeRl7S/eU6G+5Bvdc9FiGlTJfjZA8fVSMNSo5Fh3i1fBq5wwgkTiHM5epa0CqohPjUuNyG7gpgLdk4CgoU+Qs0tAQSjY4/c6va5cW7XdSc4ybJGH1A8ZiDPiHvf48SwEECIUJmvBXoFNxpsCFKHeBeTfgPPx6/rUbwrhfNx7WT9VDJXG11UWnz9BmoYXBjlihci3ny1BfosZkwYnssg5jreVs6Q+2aPkwnRvQECJ+p7KHRKNiXYz58D6BBtFjBLvk6fLHkQjW+Xog04+An8m3Po0mWSmUnPhhenCiXpZD13y5NKYzdm8ZICxpIom3qGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by BL1PR11MB5429.namprd11.prod.outlook.com (2603:10b6:208:30b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Mon, 16 Aug
 2021 08:10:08 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::b16b:d6bd:fb7:457f]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::b16b:d6bd:fb7:457f%3]) with mapi id 15.20.4415.023; Mon, 16 Aug 2021
 08:10:08 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     David Hildenbrand <david@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, slub: add cpus_read_lock/unlock() for
 slab_mem_going_offline_callback()
Thread-Topic: [PATCH] mm, slub: add cpus_read_lock/unlock() for
 slab_mem_going_offline_callback()
Thread-Index: AQHXknK0ZLgcB6C80UOe7iYBMM3JQKt1xbSAgAAAziQ=
Date:   Mon, 16 Aug 2021 08:10:08 +0000
Message-ID: <BL1PR11MB547899C96B72DBE3B48BDA51FFFD9@BL1PR11MB5478.namprd11.prod.outlook.com>
References: <20210816074605.30336-1-qiang.zhang@windriver.com>
 <ef944ea5-c3cb-24e5-1ff8-b8e1008fa6ed@redhat.com>
In-Reply-To: <ef944ea5-c3cb-24e5-1ff8-b8e1008fa6ed@redhat.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f4713b8-e803-4275-2ab5-08d9608d4371
x-ms-traffictypediagnostic: BL1PR11MB5429:
x-microsoft-antispam-prvs: <BL1PR11MB5429049B87253A69CB5DAC94FFFD9@BL1PR11MB5429.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:116;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rT4dYVsI1nh7RcX8RT7hKUt1QeTS7jn9929XocD1/fcF8/EPBacAooJ/Pniz9vk3GJgTGTdniGrPn8JmeU82TEGt1mGr9DpMIHsni+tW7uTDKL93rRsOiytOqJ5kBGNZxck1igCia9OYoK54qh028Veq3bsbFp/F+9DePxpk6UH5dd5F3j3pd3QuSeevQPIHQkIVdvL13F+zvb1ojN7FyBIzpB/kY9TG/MhgCc2+4Avy0W17tKegVVBYeYpEEmJJ+e1Q9GWFoT2wLZljoVZn9JWfTswA61LrzXmqWkjPwT6QAwdSj1Na1IBJYR6ZjIF0ZrIVb1A1nropEMv/Ek914a8UPCdo6hUU7KUfM3GnEOB/9ye9OWSOO9bX+QCtuwSNYJ/5LrpFRDRZqYzYB5Qmfd4zR9Li5HJ79Tkvkjnp1ceer36/R4Xo3Y1RyXXVEa0JYgXQF5A4DX6sgAiw0khiACjOnsd8rs2lf8MJgAOoSUcjag6qednA5P/v47+y2OtzzeHY9HwbhLQObE+G8jdiBJnhaUxMx3mWyvraPOegVMt8etGBbiNUUJPzE2NzK+f3TMEKgh4+JrEhLIGzYWo8D52ZQ41VauSzrO+FPb4G9KZm5bIGUsMgExyGw9TSloBY3HSRfE5GhqpnZ7ygZ/9D4zDakbY1JE9K61UX3l9ZZDDH4xkpQcp9w8rwS7QRicltAq4OutBxi0l6Yp9gr2wwxU99R1IEu/klyraP3a8USyU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(346002)(396003)(366004)(136003)(376002)(91956017)(76116006)(122000001)(71200400001)(186003)(8936002)(38100700002)(4326008)(8676002)(38070700005)(33656002)(83380400001)(53546011)(55016002)(6506007)(52536014)(9686003)(86362001)(7696005)(54906003)(66476007)(66556008)(64756008)(66446008)(478600001)(66946007)(316002)(26005)(2906002)(110136005)(5660300002)(586874002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?llEJ1SO7MO3T51S49q1fYDw62EWuauA47Xn1N43cOOuZgv0vq8K7At9rtfs7?=
 =?us-ascii?Q?0mBT/0XSJdTXPGF9PLDMgeleGw0tVk1+ypvWlXOAZ8IrBwwlT+EaG4RRlBMx?=
 =?us-ascii?Q?Sseo13Adv0hu/K0FH7COcfnHwTbD+vxe6sxDzoUBJ3CxBLFkynX2P4TDmRZe?=
 =?us-ascii?Q?uuyFCXhuJxZKwBaKLfegJzdVsdWNYKwd8mdkoFiRltJkvnyi4IP1nHEuG5Ha?=
 =?us-ascii?Q?c2i94NVX/lnCotzy3S8klCs64T221H9WG8m6SJccnR9a/Blosxm08yRXaO7e?=
 =?us-ascii?Q?1OYBfiNpdreOiWKxAqH/6JMchMTKLwsRGSpF5BlhZWlIIpI6Z2ayJ2IUt8ml?=
 =?us-ascii?Q?Uv8r31ZPEPgZ0ivX3AT7NLHxq+5G1DUQv6atrTBKrkhNaiNoc+tQ3wcEnts1?=
 =?us-ascii?Q?1XdJa5+uLV67+V/uS5OFPzLqMA7uW6IuHddG4XV/hvnMNPfWbPIDcMhB9kwb?=
 =?us-ascii?Q?iDGkpitcvZSE48OqyhHyl1wYM7ydetBmAXjTUyXXfW3ohEMAcJpXMa75vj+4?=
 =?us-ascii?Q?4JPBSZDAnh9f5wR0Z9BloJILNircqh+R4nb9PaE7D1dzO9NU3bP/1n3lpG1K?=
 =?us-ascii?Q?sA95Av0V3mSKsLTu2nKbP9dGN8bRBatXquKWl7A0UMwmhugMC/4xDkA90pti?=
 =?us-ascii?Q?36qaXLztfKOxGm1riFy72PPEM5zKbPt7c8scj1QRPus55kTfQPeOQwmeIrL6?=
 =?us-ascii?Q?F6mYlx554opMZrxFI0OIqIJCvJ9ShBqfMatJZC+Y7Si+YF7sCDLdYP5hzDRp?=
 =?us-ascii?Q?DViYQL5p6dHib8EQk9O+cP8sUpgun9bEUNFn74IPaz4TpLM5YjOZWcxpynVN?=
 =?us-ascii?Q?io78oP5G+B4tCsydBRHBKfhSmenuaSR8jhyfsgfEbeyGzB4BwbbIT+GwZ1L6?=
 =?us-ascii?Q?EifWIWk08duyqT3w3zyE+JZ0/XKrST6bAg3iEu8D9dm+GLwJaTWpXl6pGgF7?=
 =?us-ascii?Q?aztIuMO/aTCH4U/tgUf9Ps4Pq/DLj72v/mPLlNoVdvSSyagGhbdNAKaIBiZN?=
 =?us-ascii?Q?e9ouwZphdzscAMak6zLDPtVWwtHQiu4nuvoxJjSyImM7JPKn2aQNnCzlWKBb?=
 =?us-ascii?Q?tdy+jKq7P7aYB5xibiHqOx7999fmKcIM7MqQo5j/rj2eqspvociidOnHQ7BP?=
 =?us-ascii?Q?pEysx/hb+XEFHZh3VEbAcKcTHJRk1h6Ap6l1ZkKoRouvi2M7awYv2UmD/G3C?=
 =?us-ascii?Q?M4OWJPaQmq06checI4kiD8+Do3tDuFeNjP1V7Y4171/1T3J40A0ocvX+vLiD?=
 =?us-ascii?Q?JS5RJ25Cd7yDcpGgXLMHsGNzxEJ2G+Jt552eiRAObOo1xzArUumGwiQoZAxZ?=
 =?us-ascii?Q?+JY=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4713b8-e803-4275-2ab5-08d9608d4371
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2021 08:10:08.6646
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oy95SjEaZ16okC65d+aIcIlWxsaCyysmpfUCNn3zKtfaCGg66od25ijf4jpEwVe1y2aN8pgBkUdw7nF+hQBun2orbsqV3jawcCHqXuEvLRI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5429
X-Proofpoint-ORIG-GUID: ZAy9xHGpMpLtQB3exYeIN0SmA5wkXsOK
X-Proofpoint-GUID: ZAy9xHGpMpLtQB3exYeIN0SmA5wkXsOK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-16_03,2021-08-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 clxscore=1011 mlxscore=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108160052
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
=0A=
________________________________________=0A=
From: David Hildenbrand <david@redhat.com>=0A=
Sent: Monday, 16 August 2021 16:04=0A=
To: Zhang, Qiang; vbabka@suse.cz; akpm@linux-foundation.org; sfr@canb.auug.=
org.au=0A=
Cc: linux-mm@kvack.org; linux-kernel@vger.kernel.org=0A=
Subject: Re: [PATCH] mm, slub: add cpus_read_lock/unlock() for slab_mem_goi=
ng_offline_callback()=0A=
=0A=
[Please note: This e-mail is from an EXTERNAL e-mail address]=0A=
=0A=
On 16.08.21 09:46, qiang.zhang@windriver.com wrote:=0A=
> From: "Qiang.Zhang" <qiang.zhang@windriver.com>=0A=
>=0A=
> The flush_all_cpus_locked() should be called with cpus_read_lock/unlock()=
,=0A=
> ensure flush_cpu_slab() can be executed on schedule_on CPU.=0A=
>=0A=
> Fixes: 1c84f3c91640 ("mm, slub: fix memory and cpu hotplug related lock o=
rdering issues")=0A=
=0A=
>Which branch contains this commit? At least not linux.git or linux-next=0A=
=0A=
> Signed-off-by: Qiang.Zhang <qiang.zhang@windriver.com>=0A=
> ---=0A=
>   mm/slub.c | 2 ++=0A=
>   1 file changed, 2 insertions(+)=0A=
>=0A=
> diff --git a/mm/slub.c b/mm/slub.c=0A=
> index 5543d57cb128..cf3f93abbd3e 100644=0A=
> --- a/mm/slub.c=0A=
> +++ b/mm/slub.c=0A=
> @@ -4593,12 +4593,14 @@ static int slab_mem_going_offline_callback(void *=
arg)=0A=
>   {=0A=
>       struct kmem_cache *s;=0A=
>=0A=
> +     cpus_read_lock();=0A=
>       mutex_lock(&slab_mutex);=0A=
>       list_for_each_entry(s, &slab_caches, list) {=0A=
>               flush_all_cpus_locked(s);=0A=
>               __kmem_cache_do_shrink(s);=0A=
>       }=0A=
>       mutex_unlock(&slab_mutex);=0A=
> +     cpus_read_unlock();=0A=
>=0A=
>       return 0;=0A=
>   }=0A=
>=0A=
=0A=
>Memory notifiers are getting called from online_pages()/offline_pages(),=
=0A=
>where we call memory_notify(MEM_GOING_OFFLINE, &arg) under=0A=
>mem_hotplug_begin().=0A=
>=0A=
>mem_hotplug_begin() does a cpus_read_lock().=0A=
=0A=
Thanks David=0A=
this is my mistake, sorry make noise.=0A=
=0A=
>=0A=
>How does this even work or against which branch is this?=0A=
>=0A=
>--=0A=
>Thanks,=0A=
>=0A=
>David / dhildenb=0A=
=0A=
