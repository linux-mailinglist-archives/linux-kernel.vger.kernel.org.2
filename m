Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B433439474D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 20:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhE1S5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 14:57:34 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:9078 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbhE1S5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 14:57:33 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SIp8mS027534;
        Fri, 28 May 2021 18:55:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=otSUfUzxDXwvNELzAQ5CGtNdQvXPZzRDCj0z4DyNLXM=;
 b=CB1dhGxLy0oGe2oenUEEB/5LI1h1Onh1I5W60A83netlJU7UUoNI42jlZ/MsUmRChTLc
 mzpnNtWMIJqTA5sjIt4LFL8BEuSJj4kJivr2054fLCU4SFu8KdNakpokzVDeDs2UwXYn
 EIFS+aLE7CmoLcMAe80goJmh4FLgYmjy33O0cUlpfXWQz6bMMeadjdUpNq/aHiW2yOGj
 N4EqEu474H8kIoKZzZK7FEIm/WdOwULv8g1ra/nSIslDEHBxzsbVscB6scpk0v0q9I8U
 XEfc6e4Wi7UdezUlziv5LTBI4SkMdewe/RXzWJ8dj4l/wr6WopIxXVyZGuAgifIbaIB3 KQ== 
Received: from oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 38u31br28r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 18:55:01 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14SIt0IF160246;
        Fri, 28 May 2021 18:55:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3020.oracle.com with ESMTP id 38rehmqvnp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 18:55:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqkZYZbgXMaJ2wiu6IuA/lePWvdYx1vqg8dDw9hf8FFOEy+Pq5exCGzQW3kB5aHtt8VDvUjeEVGLR04nFVhpBoabjBcSKmRmQ802i7LIDwaOzCdJ4HfAGSdrYkWvcCK79lD7JOSlZDmgoW+4tAte04Njq9j5t9z6vk+/SIcxGsqqb26sNVaB39MJ2x7Qvh/8iGqZjxc0MJ0ePwD1atw6UEUBsKT+/WZhvficaGFCnapP+Eki0dBU0QxVzIDK/6CxvGbe/Yft+hV7hZCcT6Ju24ne1EqaTKqkwAQK6U787T2CFaNaI+LSHQTaoDP7I1USZ9xIy7Y1VpcHYHkzIldOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otSUfUzxDXwvNELzAQ5CGtNdQvXPZzRDCj0z4DyNLXM=;
 b=dirLxeRDh+2YNi7qOTQMTKo4C+78iY/L+E/c71QHgC7hNonNXwxZePljNfh7OJKBZ4UDUZV1Zb4HkN59s3/gX3TBzbIryN+YXEmeCEoOjSCqXUAtmKNyBwRXO9NVfABSYpsBR0CMSNpPBvhXt09hK/ozd/ueDevz6ZEeaLLZOWJA5UIAcTzhTTBV14uimSHR2QNVzuFNVq49aiLYPCXyCBbBggJcrZszRQMUHUA4b/gKc3xkam3QhX9FuWjQ3vWAjs4eskOxx14Jy5+rI3rPWeKteA8AAXiP5edosYVWtJ02rvBS7F6SAeZB2S6KkGpoRIfoW6wgbJ98sTtp5wj1zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otSUfUzxDXwvNELzAQ5CGtNdQvXPZzRDCj0z4DyNLXM=;
 b=GA20+cZAaYYfrmdPMEm31Q/P9zDnocNxJqTBWODkGIt4+oytkKm8OvcfRJ2n9FVr+gPGz0uyJhS7q2KQvjI616sWwjXhPpYE3uKMWu0X8YMAK67Q8EjW+4FsEzDiULQqHyc5VjODc1c7Cj0117XyjrilVD0C2LcaUbtO6tf3Pno=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR1001MB2192.namprd10.prod.outlook.com (2603:10b6:301:35::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 28 May
 2021 18:54:57 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4173.026; Fri, 28 May 2021
 18:54:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Suren Baghdasaryan <surenb@google.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>
Subject: Re: [PATCH 21/94] radix tree test suite: Enhancements for Maple Tree
Thread-Topic: [PATCH 21/94] radix tree test suite: Enhancements for Maple Tree
Thread-Index: AQHXPEQt+WoqT/epcUyBrmonyn+D/6r5VeCAgAAXdYA=
Date:   Fri, 28 May 2021 18:54:57 +0000
Message-ID: <20210528185449.vovlbet7omoex6ks@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-22-Liam.Howlett@Oracle.com>
 <CAJuCfpHto4kwjPuC-9iH9Pp45OO-6TJnHLGtfyJ-VtiaNstrAA@mail.gmail.com>
In-Reply-To: <CAJuCfpHto4kwjPuC-9iH9Pp45OO-6TJnHLGtfyJ-VtiaNstrAA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 13e0e7ba-5e8a-4e3a-7dee-08d9220a16c6
x-ms-traffictypediagnostic: MWHPR1001MB2192:
x-microsoft-antispam-prvs: <MWHPR1001MB21922AC62A31E12A0441D117FD229@MWHPR1001MB2192.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: doNTpKvjUgXuhDMz2kSoAcUArOgWpMpB5SIY3oCLwseO+3bBwYK5Oa+XqWmsStABKjmYw+9J/cMZmyFVlD51sUKAr4j3ozbqY+fdm0cgZLP+3CaVgXs77fV6DWB6UYGBfl6KYmg6Ad2krnNV8VxMaOa7QKSwog4Ni9E6cKXH8O9JPDqR7qPMAG8hkFs3Z4HpFQtQbtcK51EL2ZoILcEC5CUFiOcdRqUFF45K0WYxw6OLHqsQLm4E+1dkG9LEaFn9IFKrP2a0GuRbTNpjPXD4oi0AJx92K8GfayPq8MSWlejlGvi1N+Sa4sdeoaRy9KzEFInr1SzR+AJOxCk7f2G0OY1ds6b3eoTGuAxLRUSfeAdtprtwy7HKAOioigcN7UdKbk+2rvssFbkYMKiDr6mSi8FjYO7OqlgicjPTgKVukTlJjZki2VR2tAMnTZk731KX2XVf5sF2Rc6JFxOq6yCLz8wnX94ykrS/Xcd+aG9E5QQzLnjUBg35uOeIIHjjY9dIFwt9yjfw8YBeSqgDmFNQK1Q3vFkMAL4QlMZF/16yx3NrtMm8dU85LznjLamIEu+gHnCXZUWGn2Fr4zZ5orF3+hl6cDsrCQJPx9d0qkYl+ws=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(136003)(346002)(396003)(366004)(39860400002)(2906002)(4326008)(54906003)(38100700002)(122000001)(5660300002)(316002)(83380400001)(1076003)(86362001)(6916009)(26005)(186003)(64756008)(76116006)(91956017)(66476007)(66556008)(66446008)(71200400001)(66946007)(44832011)(478600001)(33716001)(7416002)(6486002)(8936002)(53546011)(9686003)(6506007)(8676002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?aZAe/9vPdhNQovQD/a3OMZ2xFM/anZrjMtT/xIeruT9AP2i9lfinPyIB2V28?=
 =?us-ascii?Q?RiD6A2OoW190HrzhCZ2xDYjfbb/CJi/2osxRRwMaF0YAVEAYhOrlaErYjkDi?=
 =?us-ascii?Q?VOG8pnSfUHgyquGe4ZRODOThWObSVEMe8B0bBpI32TxwknsrOZo4kk583bpc?=
 =?us-ascii?Q?jDvX/Jm1xzMY4Rw8dlH3AxY2/wSsk0JuiuG44PKYttpAAOL5eaVFflbOuhb9?=
 =?us-ascii?Q?r8a1jKu/mrlAGsxNP3Jpl90y6P5g2d3zEGxSJtwBTLaLH/6WAle1m7kZzq2A?=
 =?us-ascii?Q?VUmDD289INo8XQk9uaaiVBRAzohQ8NMS3TAkMpuTV8BZYceVprZlH+hGcsoG?=
 =?us-ascii?Q?/5PN/8Jk1NR8QsajAw1D8hgfjFO33OFSzc2S8L6apQ0ZmQZg78PdOT3D8mdW?=
 =?us-ascii?Q?3VEhhOrVuATfis6wA52zi6mim60HYxzPd696N/CCR7LqxifFztxrlDESTGRE?=
 =?us-ascii?Q?t4zaDrmBdBODMiuHLn4o6lzrMahhh9XSwWWJsuHu5txoHptbtu7oKLYrpOrV?=
 =?us-ascii?Q?0hjzPEadr879lvNNJ6yqJ3U0Swfde8M1k4Pq8XcaTvr+hXrYqzVEAGxSQHFK?=
 =?us-ascii?Q?qBRdHpy1Ou1a7xgp39qDqV6Yi7qh50a0yaFx8hAsLst8JW6JEPQNafmqN+M4?=
 =?us-ascii?Q?VhWYzxGXySASOgS+09q1MaJs5sJ3xusYP/KG/Pa6vNT3FixavvKZXLfKxvPN?=
 =?us-ascii?Q?lMzLn0dPds1qtLtN6ETsYOhKgYLKO4TDJn9Bg9/US/Ld2kcqhT+yqD4GkR79?=
 =?us-ascii?Q?hYwaPA9YyxdzhS92wdt7vQK6JPkH79OsbJppzHU/l6+tfWkcnHMuxyaFQzpe?=
 =?us-ascii?Q?h5vl6+8ll2zlzOGbn61MyK/aIXfDBlO23Pgkka4yGAHUHsFVk5RnKNn/q66S?=
 =?us-ascii?Q?5xR7q1BQujJBVh+be8G5ImNmXPjyIjCX5F0s+Eit/syiAVJ2T4lIQ8j+lqxo?=
 =?us-ascii?Q?ecn58CU1UmGx8H2GwNWTXFaVjN2i2sAL4hixW7UQPXnIQnIqOvQC3XbM1LRr?=
 =?us-ascii?Q?YiEoxUDeyKXN111Zf1OFm2FgyCVa2Yp+pQh61BS73lsxhy2CCm9C1ow25Irs?=
 =?us-ascii?Q?KLXAMzc/gMFScUweZffWyIoOpgSoToDOqNJhrwY5Z6H5HFAHmCyt/XT81iPU?=
 =?us-ascii?Q?NS/E9Lth2sE1HuFTTf03il/drezrPa67G3JfUack53tnSvu4gUOnPvyFR1zp?=
 =?us-ascii?Q?jkNs72wmGUw04KxWxxXHvHnNBPmtMxGD3UefjDDspXN+D+f/qBeQ7uuvKLOh?=
 =?us-ascii?Q?N46CDvKsLp/ALcls81r2Evn+SEaPKleSj97mpttuL6FPdoaLZBuV96o7Y7Xl?=
 =?us-ascii?Q?RY9+rWshvogHXFus0VI6DOF/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4746E904B12F3C48B69107E625F39729@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e0e7ba-5e8a-4e3a-7dee-08d9220a16c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 18:54:57.4821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uSTEVUc8/YJmSqKlsmZO0RvkVnfJVTrXSBNI6cF8trMT5d3ULtSNViIfevIeooR7HDZt0N/UdLEnu27bWkUOdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2192
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105280123
X-Proofpoint-ORIG-GUID: Fv6-WxiNvx67dR6ZGc12bcI81pUnbiWP
X-Proofpoint-GUID: Fv6-WxiNvx67dR6ZGc12bcI81pUnbiWP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [210528 13:31]:
> On Wed, Apr 28, 2021 at 8:36 AM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
>=20
> I know you have v2 for the first part of this patchset, I'm just going
> over the whole thing... There should be some description here of what
> the new struct member and new function are for. Ideally you would also
> split it in two because it introduces two seemingly independent
> additions: non_kernel and kmem_cache_get_alloc.

Your comments are still valid and appreciated.

I did add a description to the patch:
--------------------------------
radix tree test suite: Add kmem_cache enhancements and pr_err

Add kmem_cache_set_non_kernel(), a mechanism to allow a certain number
of kmem_cache_alloc requests to succeed even when GFP_KERNEL is not set
in the flags.

Add kmem_cache_get_alloc() to see the size of the allocated kmem_cache.

Add a define of pr_err to printk.
--------------------------------

I did group these two changes together as they were both affecting
kmem_cache.  I will reorganize them into separate commits.

>=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  tools/testing/radix-tree/linux.c        | 16 +++++++++++++++-
> >  tools/testing/radix-tree/linux/kernel.h |  1 +
> >  2 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tre=
e/linux.c
> > index 2d9c59df60de..93f7de81fbe8 100644
> > --- a/tools/testing/radix-tree/linux.c
> > +++ b/tools/testing/radix-tree/linux.c
> > @@ -24,15 +24,28 @@ struct kmem_cache {
> >         int nr_objs;
> >         void *objs;
> >         void (*ctor)(void *);
> > +       unsigned int non_kernel;
> >  };
> >
> > +void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int=
 val)
> > +{
> > +       cachep->non_kernel =3D val;
> > +}
> > +
> > +unsigned long kmem_cache_get_alloc(struct kmem_cache *cachep)
> > +{
> > +       return cachep->size * nr_allocated;
>=20
> IIUC nr_allocated is incremented/decremented every time memory is
> allocated/freed from *any* kmem_cache. Each kmem_cache has its own
> size. So, nr_allocated counts allocated objects of potentially
> different sizes. If that is so then I'm unclear what the result of
> this multiplication would represent.

This is intended to only be used for testing with one kmem_cache, so it
hasn't been an issue.  Having this variable exist external to the
kmem_cache struct allows for checking if any allocations remain outside
the scope of the kmem_cache (ie: threads).  I think putting it in the
struct would cause issues with the IDR testing.  I could make this a new
variable and increment them together but this variable existed for the
IDR testing and I didn't need to support that additional functionality
for my testing.  I should at least add a comment about this limitation
though.

>=20
> > +}
> >  void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
> >  {
> >         void *p;
> >
> > -       if (!(gfp & __GFP_DIRECT_RECLAIM))
> > +       if (!(gfp & __GFP_DIRECT_RECLAIM) && !cachep->non_kernel)
> >                 return NULL;
> >
> > +       if (!(gfp & __GFP_DIRECT_RECLAIM))
> > +               cachep->non_kernel--;
> > +
> >         pthread_mutex_lock(&cachep->lock);
> >         if (cachep->nr_objs) {
> >                 struct radix_tree_node *node =3D cachep->objs;
> > @@ -116,5 +129,6 @@ kmem_cache_create(const char *name, unsigned int si=
ze, unsigned int align,
> >         ret->nr_objs =3D 0;
> >         ret->objs =3D NULL;
> >         ret->ctor =3D ctor;
> > +       ret->non_kernel =3D 0;
> >         return ret;
> >  }
> > diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/ra=
dix-tree/linux/kernel.h
> > index 39867fd80c8f..c5c9d05f29da 100644
> > --- a/tools/testing/radix-tree/linux/kernel.h
> > +++ b/tools/testing/radix-tree/linux/kernel.h
> > @@ -14,6 +14,7 @@
> >  #include "../../../include/linux/kconfig.h"
> >
> >  #define printk printf
> > +#define pr_err printk
> >  #define pr_info printk
> >  #define pr_debug printk
> >  #define pr_cont printk
> > --
> > 2.30.2=
