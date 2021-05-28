Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A46394783
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 21:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhE1Tar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 15:30:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3658 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229481AbhE1Taq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 15:30:46 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SJKS8c007024;
        Fri, 28 May 2021 19:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=WDl9aj1FXI4HNtMF56Ep0qf60FdwlSyR1cX3VkTuTVU=;
 b=EVOhD5Qj2uaWBS332I5JatlTrMvfHwyicQxDtYDgac1V/Ww5Fbuu3tLNE0Z9NlhZtSAb
 Yg3n2gqtRDQNC134dvdIYKRy0D8y4ZmZzcD6tWCU5fBh/8YiRsV5zgEVzUBmfZOKvstK
 Ekjrf0mzeZcvLEnvuZK2mgF9fdrmhSTmSfHAaJtpFdStQkf9gvJ7GUjV7jmUmEpQUp6w
 vJq1QR78Z0BiHlVafwNiIHHzGxVJossB4yt5QbIJRLC67KFnhqkOE+TcwfhD/PI1ENZo
 AVRMsvJWp1fGw72wdXyPus/0WZbMbyOS8hEOj7bB5VuScXO2ilApXtsckKQOIG6P0ULh +g== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38u325g2gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 19:28:45 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14SJSir2039133;
        Fri, 28 May 2021 19:28:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3020.oracle.com with ESMTP id 38qbqvrm4f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 19:28:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5r6kY2NprRd1R13rvxkwcxCWbZ4Otu3WUOjRUW+3bq4a3HPFLVBDlzF77h33HBovZFUJnNG5mwxuvuhIb9bTD/C32zK/Y+VSWWLnwkeVYgFkHmaRG0vPTHb1PMIn05b+78Ei0zHRXe9FJNnOR9o8YDH9JseHPTaHQ3/gZo+GTmiu7IWgN6W5wvwXUaxv5YDtlu9QDBahNIB/E3zQDB1bJZbfgkF9OgNFHnLsDPIDGKM0yCJ/YbHhPmf0rmNLW+11nhnuKt74B82D4aDJh+y99CspL0EwGJOqrBNjkoN1GM70xOcXIkvna6N1z/yuPr4ZRJafnKXF3WR61jZxkrEcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDl9aj1FXI4HNtMF56Ep0qf60FdwlSyR1cX3VkTuTVU=;
 b=Ti4DEWeA7Ofpmox2P7mjOxmWzRWu/akbyDL+mm0zQxyKZq0vUDdNFQ9TZllIjR2o+yWtjTJj+SyNfy1BlqzOugDrZQ4dxOgK3e7MQE2BIuWf8vhlPyZ9064jZjvCWF0Jv3mtvBL48GXLEmdOAQfH5rRXIG/7vNIkkbDyHUy1c0YcZkerwO0jbkJL21utSc6AP6Ud1NCqZlOYBBJnINQWJKDHlRTt3IszceNITDjV+ER0meRw1Ws+iFGEzmQUCRkQGgXYX+U4m4qBxDTlgcf+zcXMsAZu7KAWdHVySBMLcHaK3uaLCS0Xa/cZClX0COQ88flDWu0qpxGGbsHkLBIieg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WDl9aj1FXI4HNtMF56Ep0qf60FdwlSyR1cX3VkTuTVU=;
 b=Gm+d7K7K8JzIMOxE2OJex/8m7nA4gjOy6kQluy88cmYwUnivpCIeDbrOeSZCmMRUNdh9ww/vhR0Tbb8hNy5MgmoG8QEhuJeoUxOtR3fmoGLDsleuj4hfccAJUQZO2dNTTNCx65TiafCfQCFacWdNQWJo+Drr47/IW5uKrKWlbiY=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1982.namprd10.prod.outlook.com (2603:10b6:300:10a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Fri, 28 May
 2021 19:28:41 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4173.026; Fri, 28 May 2021
 19:28:41 +0000
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
Subject: Re: [PATCH 24/94] radix tree test suite: Add keme_cache_alloc_bulk()
 support
Thread-Topic: [PATCH 24/94] radix tree test suite: Add keme_cache_alloc_bulk()
 support
Thread-Index: AQHXPEQuvP7qWSQZGk6zUNYAinMQpKr5YvOAgAAT0oA=
Date:   Fri, 28 May 2021 19:28:41 +0000
Message-ID: <20210528192835.fqty5lk65dsg2q5c@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-25-Liam.Howlett@Oracle.com>
 <CAJuCfpEq3xVPrk0d_UNbgNOLQ7wN5rm4wx+CK2krc-bkmGpq1Q@mail.gmail.com>
In-Reply-To: <CAJuCfpEq3xVPrk0d_UNbgNOLQ7wN5rm4wx+CK2krc-bkmGpq1Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78397d5c-7285-4a67-d86d-08d9220eccf9
x-ms-traffictypediagnostic: MWHPR10MB1982:
x-microsoft-antispam-prvs: <MWHPR10MB19829924E7A555B696BBEAFCFD229@MWHPR10MB1982.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LxX6qxlbLT96wTpaDsXokDHqplAwCGvlCgB8Ur4ZZIpCAThp3wL2Pq3hAeCf8bcotUYCcf8JNf0HqCKaO5Mq0jCsQQW3LrppQ7rX5WSmKEtQWwgWi9BfGHCu7x0WCQTMM/lOT6SETps4CE/WZg0xnURV14lg8t0t7LFXSH0QwnRs/7kWdunAe5CTG5+ymlB23h5nioECck+BkMmuju3ydCmJgSP9j72T8kPU8lgeY4j2+c6XJ9xU6uk7LymCG8ub4LFE2m09oGgnbyOk0vV5WTnwkPUgWAknzyqFFEQ4RMN3XE3xYNp6+1iA+TSxeqoyiyVZlLa6uCpwsXYvLisG0DWrCpMLmiHLXpQK2fI+1ms3MYHu5fCx2SPnO1dGF2GKBD/VpQNo4d4gA5GJL6eQw2hrpvEIupuVuyvwsV5cPyklgBwLsp9jjxr46nR2DiF/v9xaFMcdPMQKh4hvTURpz+qTcsuAd5Mm41QReZ2/nz4SzyOiBoNS5eS5bqNJyS6gMLXJsMGuyXZTy8B9s0jc8UegkXC8fWJM631EPvx/Oipp7w25lKUB3JzjQYnNSs7LwaJk2+vxc/79ksKPWVjsX8ekBMkBZWChVcwiROxboWs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(39860400002)(366004)(376002)(346002)(136003)(6506007)(53546011)(86362001)(26005)(7416002)(2906002)(71200400001)(122000001)(38100700002)(66556008)(1076003)(64756008)(66946007)(8676002)(66476007)(76116006)(83380400001)(5660300002)(91956017)(4326008)(6486002)(478600001)(44832011)(9686003)(6916009)(6512007)(316002)(54906003)(186003)(33716001)(8936002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?tdCGqAn7Mge4qpEU+csdx02pLHHqMEmReyJg+mLHZYxOOZM6g2SLl6kzIAvr?=
 =?us-ascii?Q?EWzIzrysuOsh2tiovTQwPMyWAlllxF1BraRK9YOtoT/DjGD6zJKx3uFbFE6M?=
 =?us-ascii?Q?YAy0KtEtv3zW7xSdAfj3h+FJ/CxGoqIEtJHZSyfjL4R0fNRaJ8jZ5wi+N5jv?=
 =?us-ascii?Q?+rtUsUPUrFPdmlyxCOdltDk8qlLGwBI83/Y/N0L6uu4SwESYGQ2cbazxI7W7?=
 =?us-ascii?Q?nqPymrV2ke8b8u3eHWimDxnLLWR4WdLKzPusrl9VrkqKS3yDN3iPIAt0LW0O?=
 =?us-ascii?Q?cfNIJHZ/nJKevSFFPz3ISvBQZVMPlG2X6xwZyQLeimtJjfwjBP4HYVPKoms6?=
 =?us-ascii?Q?5IeTE+UGkzvaHtVLpbC4EGSXgrv6L02a38N2BywV5UTH8uKPpqdiSBuyn52o?=
 =?us-ascii?Q?qgpS7JAy4H6xDnnBHqbJzHIUCxYasmq8j6DaYQks8Zx5TalF4O+DdShrBM8t?=
 =?us-ascii?Q?qr2rQPl8EkRW25uv0cWw2EWvRLx8ymvjCxXhwPsc9Az3P9i2hAvhuSwXSk0J?=
 =?us-ascii?Q?hnlWB/hxYzXxvGBNEaK8CKSHv6pt7ReMPVwv7/EA3izjRJBHzKCuaCS/MZmY?=
 =?us-ascii?Q?wU2GkW58rQRjLfRxvsf2CxBFDUidbolWRPWW/RBI0N7gi7pOzmP8j5DuPcR+?=
 =?us-ascii?Q?v4MZILkwxTC2D2DQNYLiXfb0LupNIZwzwAtIBrAPYPjRfBTTO4p6sRTPOGFh?=
 =?us-ascii?Q?SR3/H8Z+pN/WqJsunyiZZU3xZ+QRsVNFOR5b2NRdMoB8PVADrQc9FOCYYXcr?=
 =?us-ascii?Q?MPuyK0zIJJm2UWebJ84dA/7IWwipU2woPf/JZQVewe9dxLDxDQioMhOP8yy3?=
 =?us-ascii?Q?BLm+XAxFJRFTcHAYFQ4191QhokIcaLdgiSytiPb/FdYDPZZdw0FOsXbL+6rT?=
 =?us-ascii?Q?jrlBDuGgJFD3C3eJMUmqBMREXgZmBwrzmnasHyJhgBPDVbIHtpXPMnRBRgB8?=
 =?us-ascii?Q?8lbhX+AkPPSrxxdRvpZQMHUgh5CmRPlQn9NMdXIADLCB4wi1U0VMbfGd84ex?=
 =?us-ascii?Q?oW/fjtxZNtvaIIJCyRKWuUOnk5YulRF5eHYCID7d4BInMXYnLvSaOrPCvyD8?=
 =?us-ascii?Q?QuL6DvD0m8jR545m72eWjbijbkdMMvqLqDGaOIk/kS0PWbrhUhSOIJlPA4iq?=
 =?us-ascii?Q?9SlzCjvLIjR+xtKosiBwFEUdMvBQ47pugZrspPiDu6s4xR9rHmYTID2G2V03?=
 =?us-ascii?Q?kFhJ3MEuPBM2qV9YMVJJ39iIHOpqnmWABq6LPbqemfSgNyfjqFAogpZuykly?=
 =?us-ascii?Q?TN8Xztaysx0oiWFzgCaMCPP7b071ZkDQC7sr2ABSWe5Gt3w8Rs/NOvMKfEMH?=
 =?us-ascii?Q?9SsBhndDXbQ3IP8kPJmkgDPc?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BBAC53ACBDF2274FA578FC176339FEF8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78397d5c-7285-4a67-d86d-08d9220eccf9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 19:28:41.2108
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iQq8SJ+bOYW+G9OMzNRJTcLaN1XvXWFJ2CfeRVWQyV5DIVl5n7F4i2JSHZbmOsw7peXK6SVDetjZh2otQmCTxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1982
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105280126
X-Proofpoint-ORIG-GUID: 9bfzg73_7QiqYT-uDJjlZhR0x8Du2FYq
X-Proofpoint-GUID: 9bfzg73_7QiqYT-uDJjlZhR0x8Du2FYq
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [210528 14:17]:
> On Wed, Apr 28, 2021 at 8:36 AM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  tools/testing/radix-tree/linux.c      | 51 +++++++++++++++++++++++++++
> >  tools/testing/radix-tree/linux/slab.h |  1 +
> >  2 files changed, 52 insertions(+)
> >
> > diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tre=
e/linux.c
> > index 380bbc0a48d6..fb19a40ebb46 100644
> > --- a/tools/testing/radix-tree/linux.c
> > +++ b/tools/testing/radix-tree/linux.c
> > @@ -99,6 +99,57 @@ void kmem_cache_free_bulk(struct kmem_cache *cachep,=
 size_t size, void **list)
> >         for (int i =3D 0; i < size; i++)
> >                 kmem_cache_free(cachep, list[i]);
> >  }
> > +int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t=
 size,
> > +                         void **p)
> > +{
> > +       size_t i;
> > +
> > +       if (kmalloc_verbose)
> > +               printk("Bulk alloc %lu\n", size);
> > +
> > +       if (!(gfp & __GFP_DIRECT_RECLAIM) && cachep->non_kernel < size)
> > +               return 0;
> > +
> > +       if (!(gfp & __GFP_DIRECT_RECLAIM))
> > +               cachep->non_kernel -=3D size;
> > +
> > +       pthread_mutex_lock(&cachep->lock);
> > +       if (cachep->nr_objs >=3D size) {
> > +               struct radix_tree_node *node =3D cachep->objs;
> > +
>=20
> I don't think the loop below is correct because "node" is not being
> changed on each iteration:
>=20
> > +               for (i =3D 0; i < size; i++) {
> > +                       cachep->nr_objs--;
> > +                       cachep->objs =3D node->parent;
>=20
> In the above assignment cachep->objs will be assigned the same value
> on all iterations.
>=20
> > +                       p[i] =3D cachep->objs;
>=20
> p[0] should point to the node, however here it would point to the node->p=
arent.
>=20
> > +               }
> > +               pthread_mutex_unlock(&cachep->lock);
> > +               node->parent =3D NULL;
>=20
> here you terminated the original cachep->objs which is not even inside
> the "p" list at this point (it was skipped).

I just verified that this code wasn't hit in my current test code.  I
will test and fix this.  Good catch.

>=20
> > +       } else {
> > +               pthread_mutex_unlock(&cachep->lock);
> > +               for (i =3D 0; i < size; i++) {
> > +                       if (cachep->align) {
> > +                               posix_memalign(&p[i], cachep->align,
> > +                                              cachep->size * size);
> > +                       } else {
> > +                               p[i] =3D malloc(cachep->size * size);
> > +                       }
> > +                       if (cachep->ctor)
> > +                               cachep->ctor(p[i]);
> > +                       else if (gfp & __GFP_ZERO)
> > +                               memset(p[i], 0, cachep->size);
> > +               }
> > +       }
> > +
> > +       for (i =3D 0; i < size; i++) {
> > +               uatomic_inc(&nr_allocated);
> > +               uatomic_inc(&nr_tallocated);
>=20
> I don't see nr_tallocated even in linux-next branch. Was it introduced
> in one of the previous patches and I missed it?

It was introduced with the maple tree itself.  I will spin this off as
its own patch with the same edits as nr_allocated.

>=20
> > +               if (kmalloc_verbose)
> > +                       printf("Allocating %p from slab\n", p[i]);
> > +       }
> > +
> > +       return size;
> > +}
> > +
> >
> >  void *kmalloc(size_t size, gfp_t gfp)
> >  {
> > diff --git a/tools/testing/radix-tree/linux/slab.h b/tools/testing/radi=
x-tree/linux/slab.h
> > index 53b79c15b3a2..ba42b8cc11d0 100644
> > --- a/tools/testing/radix-tree/linux/slab.h
> > +++ b/tools/testing/radix-tree/linux/slab.h
> > @@ -25,4 +25,5 @@ struct kmem_cache *kmem_cache_create(const char *name=
, unsigned int size,
> >                         void (*ctor)(void *));
> >
> >  void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t, void **);
> > +int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t, size_t, vo=
id **);
> >  #endif         /* SLAB_H */
> > --
> > 2.30.2=
