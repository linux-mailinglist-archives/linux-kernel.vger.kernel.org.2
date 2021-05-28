Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D851639476A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 21:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhE1TJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 15:09:46 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:13786 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229476AbhE1TJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 15:09:44 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14SJ6FR2031121;
        Fri, 28 May 2021 19:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=F0wur1XdT7MUZDkfd9Co6gA3WVnyOC/mxLtzrCq7du4=;
 b=TzPyBCHhHRoZV/D0AHp/0PsD4jbCT3LwjoXCoPXBBEkdjtg+S20n3mOs+8DLLSX3dJo1
 R0Ox5rjPEW6qXDNQWyhtJIRLYRPrqdSgyJT4q3AFNzxp1eY0qZ4KGPasyu/t3bmLJO4L
 IacxlwWojGwy6OyyHHiTGiDfhS1mgecGshayoEXroIERq8AwBgvtU263ErZ8SA5+LyVL
 dzRl3r6AsBJQIhtp7SlH1Mnd09tZcHlXjfPrbpCkHzWU3HyOKN6xX9HjJ0KAXDTmQY6O
 WJjo5jcqb3A7WkWfEXeJCoH6fMmJcWTmI6GQV3MsU990CcORL2DfM+eS9NJ1cYsosKsC uw== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38u54vg0we-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 19:07:43 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14SJ7gAi001817;
        Fri, 28 May 2021 19:07:42 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by userp3020.oracle.com with ESMTP id 38qbqvqrs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 May 2021 19:07:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YiTdTzKCrPmMCptEB0pt5t+IK/eulnKs5nEpwpfLTrC+fzCI+mxHmibTqFHVUFd8HycQksrxzLfiixPtKY0D8ovHfopzPSvK1Tfa/l856C5PKU/hCB/VC3RMbnVUiRYQmcIvClW5q5kDD5HID19AIhMdY7Mw513xtu3Kw/er9MElP/KI15Ca6+7FwcpSlx4cpurYOgedObGv35kKqipLZn9eStbq+W5XUnFklpzH+u+wSZ3lZb3szeaIcLxXHbE4n2cczBPFSmLw4fw9r8lJF8owoHyTnC+XXrLfYy60XeyGKYbKQM2LjdWXniQaVsS/KhX/53njqPMcjwtNc7g4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0wur1XdT7MUZDkfd9Co6gA3WVnyOC/mxLtzrCq7du4=;
 b=W3CXMizcUF0XoGoKlSj3tp7fDfphkKnY5YYzWwRIc59T/4h4hHfRkkqBJ808bKlNRRfSaG08eBI0scHR9LDy0oY+Og3RtMqy2rmqKHztySbWuJ6QvD5KquHt7HmUo5+HjpQ0os1flFe/XZ4fWEKeKwx+pioocmuSRDdfeJd+0/dSw1wnRwFEzkkoVT+CBQzshWsGM7Tk9LZV6YwNiDfq2F8YMV2hulhbWIZJTK2tUqVW/CmVCL04IrKtFHgZqISid5SIS+QErMqwEqDDlzSoEGoD5SzvbWsh2jhrPkb85uXN9JanYTiWrJxFf7p2ILSJQypNDXCSDYqWAcmbB3vdww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F0wur1XdT7MUZDkfd9Co6gA3WVnyOC/mxLtzrCq7du4=;
 b=PjYMcAeG5rmaIseCgjfNGyiZcHYT+jXZ9QlPc80KNY04D4PloVeSyndARI290Lj6iRRC/kmUvSG74HZY/wAlAWAtewwd63Og8V9TzJDSV04F1fpmuGQHEu6iaGJVVTNrz0HFkVoDsiB0zZPuUleBjNxv9JMJ2PqE505Asr/LLnU=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4498.namprd10.prod.outlook.com (2603:10b6:303:6c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 19:07:40 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4173.026; Fri, 28 May 2021
 19:07:40 +0000
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
Subject: Re: [PATCH 23/94] radix tree test suite: Add support for
 kmem_cache_free_bulk
Thread-Topic: [PATCH 23/94] radix tree test suite: Add support for
 kmem_cache_free_bulk
Thread-Index: AQHXPEQu20/60aauIUGZQthGSVt2oqr5XMoAgAAUGQA=
Date:   Fri, 28 May 2021 19:07:40 +0000
Message-ID: <20210528190732.f7lxiyl6enmtidmi@revolver>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
 <20210428153542.2814175-24-Liam.Howlett@Oracle.com>
 <CAJuCfpFSE5MSDnMQ40fRx3mJ0eCLW0QDTMCbr05nrWDtC6wbaA@mail.gmail.com>
In-Reply-To: <CAJuCfpFSE5MSDnMQ40fRx3mJ0eCLW0QDTMCbr05nrWDtC6wbaA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9fea398-595d-4dd1-0c79-08d9220bdd41
x-ms-traffictypediagnostic: CO1PR10MB4498:
x-microsoft-antispam-prvs: <CO1PR10MB44986CEF04C40175DC1E2F1CFD229@CO1PR10MB4498.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FSqr6bImV/qyx3+ZeBTsegMMI8YcFCCwxcQNAc/h5U2Tjcxii48/XEHwhQx3LMZdnacoDhsJ9K8cjUeukuUfNDuFMXQeOStpCyLS0gaTZiAuSPeT1FCbs/W/uU9R5uJ2ZvtIKgIeZtYa9JopyYz7RlwtwHFKkit22QISuZJs6uCOkEctexrNnafGhOtg7/cojxdYCxmxpJfXHOWQw+EDfmzSFie1oz+HQwrQgLcL3bQkFp6c7jwoGDBIrOkUJIiq2niNJbchRBCNLbEweNlb3KThJW82r/sAG1q07PWTWdeuL/izBd3ZN6YucuKXrYrkFZg7SPMJh8sScbD0pYHAfdhynBsGLgW1FXBRpMV2K0cQn/f8H4doYAlgKw+KEMvFJ7CzKHVpjDNZRW4c4j6jrVtYdkFfuaTIZ0f3X8xtQN3ePIOrBpOxQjTpO6aUcFPmQUDaOrv8ZmEi361la1ePGUj1fuQLxEMN7w8ku+sg6vDv4XspZ2HOSx2KKxBwRXRV5UVitjcG0ayqq1gPLBCREG4LabBPX9MJdHkxYHXNyQTsEhFqgAXXt0jIwsa19cOFGMiFt1A49d/eX1VugUbvzpxzO45GvF5PfAJJWh2qlqc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(39860400002)(366004)(346002)(376002)(396003)(136003)(91956017)(44832011)(66476007)(66556008)(66446008)(64756008)(66946007)(76116006)(122000001)(1076003)(5660300002)(186003)(26005)(71200400001)(4326008)(6512007)(6506007)(9686003)(6486002)(53546011)(86362001)(6916009)(33716001)(7416002)(478600001)(83380400001)(8936002)(38100700002)(316002)(54906003)(2906002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?BD7e4TwA2vxliha6yGamhI2EDsD7QlTYELTS7LPMZV/8WL3DUod4S2ltVdbF?=
 =?us-ascii?Q?WjrDR8iCnw3SThy7pc4xizJxAkUBIsOpfGgKjEBXQG75PVqgLgfECeVWHz9e?=
 =?us-ascii?Q?m8pl9tWw0Q80zY138dljKQOf8zNVfEhnEB8uD8h0pbtkNZ+gDY+30PURq0GH?=
 =?us-ascii?Q?PE1AeZVmz8nCZ860yWmms+eCchTjISjrVfnJIR10nOFeecnKXaUcJqbqHV/Z?=
 =?us-ascii?Q?7Ua8KAZgtp7wuX47yO8/d8UpLzSLR9rlpwoL+KgmUzM9+3OJzFKLu03C5sDa?=
 =?us-ascii?Q?FoNdA6az3eCJC755wPIkt3yZ279ILSZ+3FBNORQhzEWUMChekRtV8g7F8oxA?=
 =?us-ascii?Q?ZHp3P8b1XX7OCQDWNcKJwZVOe6kT0S56f4gTcoGSeRjt2YzenGmG63B8xh30?=
 =?us-ascii?Q?xd8eyOAtaxsFGXvuFx7Qq0YuQ6ea9p3/Xf2PMYqzrnTf8gNn8+orCUSZGPeU?=
 =?us-ascii?Q?Me8+DfB0KVvDRD/rnx5WVElqILJpFpvoh+qsbQsmiDgxeK0bwQ/WlOudyJnc?=
 =?us-ascii?Q?GXlklLcD78p002tGT0QFhnujxtUrCH21x3WUdVruHCjgrHyA10gcKtykeuJA?=
 =?us-ascii?Q?8rNHwu0zJwYGIXLuUEO/dyvIfSMTetGsavwkuv3JzdeVabSqyftTwK992Xx0?=
 =?us-ascii?Q?tKfRIccHJStGM8hIyuaTps33Cj99LYTQmThj8JaiM2FXKCO/tD2AHsgkj9pA?=
 =?us-ascii?Q?K40dK7VwSW7S0MZtq8GmtFO/0vPxq689F09dPwLC9gJpOw4ezM/KRKusN5+g?=
 =?us-ascii?Q?Yxq+B/ID5zdpCJHJf7pOopbm1JCxwk0ko8QxTYbBMcWDlry6evwj8AQCBRbG?=
 =?us-ascii?Q?si2D0KmveQK0Ry60nJHLAFljU5HCtDF3GoruJrt3P8L6nP1dq22S4icGtXYr?=
 =?us-ascii?Q?rCn+1JcDzy2+kPmkcZXNUyoKdRftLSdX5onOyGcJsLhbR/iUNjRuFfqL+J7D?=
 =?us-ascii?Q?JxTo2MYazQTp7GuGpiMAL2GD4EhFRxO6nVgzdgFI/up3L+PtWEdfwtaeVnPm?=
 =?us-ascii?Q?rKkKNhThfwzTUbPmc5o66kTX81bQQWRyWPSJbvxLiZSHoNYE+hiXGh9x37ta?=
 =?us-ascii?Q?Msha+maXi2C7mhJ08Vz/Lmau4yiX23r+/zsuIr5nZi3uDQUWMPtngMLl1EnM?=
 =?us-ascii?Q?QAkVycR/rg+2yBWq9HLs9+HDzacMt9UUZTxGgNUbu0tGMI2ZkqgZhYL+iEiJ?=
 =?us-ascii?Q?6uS3EqWZdCQDMbz6f/CHGCZ+lFXJ/SyBgp6pOhmco/XL8JI3Qww8BHYbOhm+?=
 =?us-ascii?Q?0uvkK5OxRvQHCU94wWbyrmD6dVzSrdpnG6EmFXFRH2zJ+A0ij4Om6rKvTakq?=
 =?us-ascii?Q?nhT4SmjT5eUNZHbosWE2KKJB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CFFB2ACAFD3F3C4EA0CAEA6503DD4E5A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fea398-595d-4dd1-0c79-08d9220bdd41
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2021 19:07:40.0468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3MS2tjGJPBMKgVQZgkTdbTv3g8vYCtW18PoP6ts72aDX669W6hREIHu8MM6pFnS75Bz21Z++HRoSQ9OS8+x/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4498
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9998 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105280125
X-Proofpoint-ORIG-GUID: qO4OJj1POKQcneql1uHcf_-TpHBH5JlN
X-Proofpoint-GUID: qO4OJj1POKQcneql1uHcf_-TpHBH5JlN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Suren Baghdasaryan <surenb@google.com> [210528 13:55]:
> On Wed, Apr 28, 2021 at 8:36 AM Liam Howlett <liam.howlett@oracle.com> wr=
ote:
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  tools/testing/radix-tree/linux.c      | 9 +++++++++
> >  tools/testing/radix-tree/linux/slab.h | 1 +
> >  2 files changed, 10 insertions(+)
> >
> > diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tre=
e/linux.c
> > index 93f7de81fbe8..380bbc0a48d6 100644
> > --- a/tools/testing/radix-tree/linux.c
> > +++ b/tools/testing/radix-tree/linux.c
> > @@ -91,6 +91,15 @@ void kmem_cache_free(struct kmem_cache *cachep, void=
 *objp)
> >         pthread_mutex_unlock(&cachep->lock);
> >  }
> >
> > +void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void=
 **list)
> > +{
> > +       if (kmalloc_verbose)
> > +               printk("Bulk free %p[0-%lu]\n", list, size - 1);
>=20
> nit: Printing the address of the "list" is meaningless IMHO unless you
> output its value in kmem_cache_alloc_bulk, which you do not.

The address has been rather useful for my testing when combined with
how the list is created and the LSAN_OPTIONS=3D"report_objects=3D1".  When
this information is of interest is when a test fails, so the tree will
be dumped.  Combined with the list head and the report_objects output, I
am able to deduce if there is too much in the list or too few, which
operation caused the issue, and what calculation is of interest.

Adding the alloc_bulk counterpart is not very useful because the
prediction of how many nodes are necessary is the worst-case, so the
head of the list is almost never used and the request size is already
known.  Adding that print is just noise for my use case.

> I would also suggest combining the patch introducing
> kmem_cache_alloc_bulk with this one since they seem to be
> compementary.

Yes, I agree.  I noticed this and fixed it in v2.

>=20
> > +
> > +       for (int i =3D 0; i < size; i++)
> > +               kmem_cache_free(cachep, list[i]);
> > +}
> > +
> >  void *kmalloc(size_t size, gfp_t gfp)
> >  {
> >         void *ret;
> > diff --git a/tools/testing/radix-tree/linux/slab.h b/tools/testing/radi=
x-tree/linux/slab.h
> > index 2958830ce4d7..53b79c15b3a2 100644
> > --- a/tools/testing/radix-tree/linux/slab.h
> > +++ b/tools/testing/radix-tree/linux/slab.h
> > @@ -24,4 +24,5 @@ struct kmem_cache *kmem_cache_create(const char *name=
, unsigned int size,
> >                         unsigned int align, unsigned int flags,
> >                         void (*ctor)(void *));
> >
> > +void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t, void **);
> >  #endif         /* SLAB_H */
> > --
> > 2.30.2
> >=
