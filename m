Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B92C3E06C8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 19:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237752AbhHDRcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 13:32:50 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42230 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229934AbhHDRct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 13:32:49 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174HQp0P000390;
        Wed, 4 Aug 2021 17:32:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=2pg8ws8DrJvRxP39j2IARpCsaI/gkSygV5xFF0/sFpE=;
 b=fe+e5DwfZ9pmbTJcCrfK8K7T7oO5cCHQESiIRYLQDlv08FtP+OwLPI9c9ghuae4QvmuP
 HxNAlKSNXGKJwX+k9Mb2GqoMDdzUJb9ktLGuihzCVfyZAmN1v39TgoYwqrS33oGOxltJ
 joKNQa9vmYLtIy2ipkWU7YFQasDbbaSyGEu53HqloVU/cb1VD+Umyr4ch/rmIkuqMoAU
 6AT64T7zcZwOlSIEcrbyBXL8oQk7Eya/ytkWEPT884hPbzLXJokTKcIsGKRGbxHx5a5Y
 cq0F8AlQz75pSfhNMcuu9HO+mK8d0futPrmx9hRztoIDu0DZXLQdfE5JEUi2dXfLkThg SQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=2pg8ws8DrJvRxP39j2IARpCsaI/gkSygV5xFF0/sFpE=;
 b=DlnFmF/+4MB2WTBbRtJYCsjeyeDsPZOW7W3sBBECtXQxoencNff5oGmplfD1xjkPWlXb
 yib7Ezk3dWIVE6Vovgwukes1Si7PueJCkgzBWWdjMWaFHxP4Ogv6StbPOGCc8r4WI8vV
 4Eu2JLcTF9WVLSPN0X8EN3NgeJ3F94lfZ7pLPZp/k/hCJ6hesUJ931o+I3J0yzLZdcSf
 LxT+wVGzMXuN+I3T/IMvyWvdAk5kkHlP/rGpxOe7Ls47i6mxtc4bLdJ+46RPPzr0QjX7
 tdnVHb0CoKKp+91+4ADKYUmRhTzcEMq3FNSkik0pjBt3OmuNUCTB6hPgLcSlVrXNQlPO FQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7hxphy1t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 17:32:30 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 174HU1A2187082;
        Wed, 4 Aug 2021 17:32:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by aserp3020.oracle.com with ESMTP id 3a7r486qnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 17:32:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyAZAUWtrh5z0/kvFETho7pYBG2aMMkljPu4NjILK2aZqtuseOZ616rBc/FIukuJ7hqm344dfZJFd7lmMo/bsTGnepUACsEXytGPIhsKXItz5XqNvCECusKiCdg2WbI5n9vT2LET+RenXYqu/hbCF41/2Zi43m+iAgkwzoZoKBKJMzapVUc0GT8KGLQsgnDESBL6GYUcLFRTOEBQtFEVEm3pMxuAwSmT1AcJN4LmFOkOjhQgXLHIF1paQrIHWvU5S+BTAS9OKZvylMc9nXWq1KzDQLKaHWZwxn0NO6lDOU1X29QspIVGs7z7eKw4wZkaoOFZ+e+9d66yI1yHYu1iow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pg8ws8DrJvRxP39j2IARpCsaI/gkSygV5xFF0/sFpE=;
 b=ZSDdi2m1kkXvrfs+RVnInNZM8hQZnGbz5gEXyeubOhfCKLkoXCPcT3JkQuepqQ6DK1SODw0CPtCoQod4+IbWlLhCd6vWZd2G86rqvMbFYnTWYGhMXyZxSRhGLbWrGGai9EfJz8ctgV4lVLcisDTgQ9jEWRIqxZqoRutaTZuqRDL0N3pmMAI1bSTKcGK1dNoQ5JmNOWhBjkhUrg7VXJn9vKo/RK1zZH1zLNbU5CqmxyZF3BmzwIbuSznXk9J3pkeusYSFRpvV/F9x3DHcjQNRZZ/cARVHvG5QZmx4ieRyyDrsnUhwdncze5wIoOyg4QNJbvr6DO4lLAlR6JK+LYbu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2pg8ws8DrJvRxP39j2IARpCsaI/gkSygV5xFF0/sFpE=;
 b=XX/KPd9j4wqL4GDXCOO6fvL7k1AneRK7oKe+G1+G78CsoQPd7IK0z+YPN7l4KfekZ36/IEeK6tC1+QIYZj0OH4/wm9h12mkZ2uc/6QvbIensxyHFWqUDAPx9w6kpr+gRRpDIStrSo/3o4Ovu/Bh2N01p6wZg0nuUdVP4bIuS8r8=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3659.namprd10.prod.outlook.com (2603:10b6:5:17c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Wed, 4 Aug
 2021 17:32:27 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::100d:983d:7b4d:11b8]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::100d:983d:7b4d:11b8%6]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 17:32:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Jann Horn <jannh@google.com>
CC:     Luigi Rizzo <lrizzo@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
Thread-Topic: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
Thread-Index: AQHXhjmoYtMFsOr1JUGtL1OdK4dvaath9waAgABfMgCAABX5gIABBTqAgAAvfAA=
Date:   Wed, 4 Aug 2021 17:32:27 +0000
Message-ID: <20210804173220.nzn7kka3oyzcsxks@revolver>
References: <20210731175341.3458608-1-lrizzo@google.com>
 <20210803160803.GG543798@ziepe.ca>
 <CAMOZA0JKjRFUHbs3zc4kiGcuXxR0arCN=oPZZsLCa4qHvRrH_A@mail.gmail.com>
 <20210803230725.ao3i2emejyyor36n@revolver>
 <CAG48ez2TEP0hsRjLACVmRppMEk6Z9aREcGL498EKhdBBXSRsoA@mail.gmail.com>
In-Reply-To: <CAG48ez2TEP0hsRjLACVmRppMEk6Z9aREcGL498EKhdBBXSRsoA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 06a6040d-f6da-41a0-405b-08d9576dd480
x-ms-traffictypediagnostic: DM6PR10MB3659:
x-microsoft-antispam-prvs: <DM6PR10MB36594C28A06247CCF94F7222FDF19@DM6PR10MB3659.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A55wo9b6XPhzkNf4KgbVKnaCc930HPnA5JAqswGporpHHogcWudDHJnavJiSv/ml3LNCiZqbk6K5WEDkjRT+vyjd9UWjlsv30cVrVrhy55+DqSS27FwQEF9pcU3vbg54icWizSKFrHItQgSzyt7FA+rL1sqCjghZcXNve6AUnqJ28ZxyRODAL10U4diX4+iUXkZIUG1m55pqD/Z7mBIP2Y+A2NwYdeFcZvLjV49ffA9EZs/Kme9ShzDnrGuTlxvSfOjB7f4+IA3C9mBJBF0NndCaCW8PpPbNn/ghf2dO8+Eb3sBtDtA7MeZPFB6uEDnZCUzemA9sz8U0clqTCsDIeV+IsnSNTLpagnIZ34vPO5rYQwg2p4JiuB7fg2orRZYmD9jcTIqKbV2sQhrvy2AjVQP/GnLU655S1/lyagD/IODKFhBFr+pAW+dD5dnSW+/CV1finXorQAQsc2gXHFDYo1atDg5c0A61NvlizZQSbLCB/xUewP3xs1Xynb+X0YKso3Xxgpf/sq9WFznzDQfQijkMyZl2nEgP+FTczHFF8PKjr3BxaYtLz8PQHQQ8JFgYar/kFmB1yhlJ3uMKm55mRPmWqHjdTo2ocfZKpvS9QNfF3eVOqB5naB1+N2k2v1tmJedWvwsCkEPEqfrR2ACGU9GoZKcL94xAKyuNUUUnPmI52CglEipiF7YdjzmCVOj1bcvLGX+a7AZbSpUOAC9U159qHloXEUUmaKUsMF8eZCFZK/NiQUQ+/H8Lii5DIrez//RshAMyBhVvlMsKQPqycoaTPPUtg5TYLTUwWyQZbRgA5uq+AdE0jDyvHErDOWdX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(396003)(366004)(376002)(39860400002)(136003)(346002)(71200400001)(66446008)(6512007)(66556008)(9686003)(53546011)(33716001)(966005)(2906002)(1076003)(122000001)(76116006)(91956017)(83380400001)(64756008)(6486002)(38100700002)(66476007)(66946007)(4326008)(186003)(5660300002)(44832011)(8676002)(6506007)(8936002)(478600001)(6916009)(86362001)(54906003)(26005)(316002)(38070700005)(37363002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2xM5lnYla60CgTIeRjSVLG/4v3ehji59h5c/xBcFZeTB5gH3M6BgXtzeiNkg?=
 =?us-ascii?Q?xXzLOGJzXYISe4QdndHhEh9ctUdrPNQ7J9+at8iTOe5ZR1TgxlIvpYpI26F1?=
 =?us-ascii?Q?aEH3MZygDGvdkhwL139c9L57uZYGqu05qkRMpfxl/u3F5WgR4p4TP66N8HkK?=
 =?us-ascii?Q?+cjFuuOVp67fvQgKvWOosjFVTiA4oJ818LjJYeaXDlijD9giTqcUCk9pf2uU?=
 =?us-ascii?Q?RGMdeSLe8q3/h7jPgpoxQv8eoU2QhXblDiaOazA0W1fCGIvhizk2CEVjnUfs?=
 =?us-ascii?Q?AQZpNNHy+rRiwY5HzSIvw+aIR4+Z3zmTvIW5Xs27JOkq7iBUl7WMbBZodxHY?=
 =?us-ascii?Q?rzLaQPqDiEbWWA+1HJO+eW5UGoWRTpPZEpv/HWbQfMPzv0xKGEva22rPmSoa?=
 =?us-ascii?Q?0JVQxetLCCi7lcUa2gIVNZ6vLv1RxaNNJ5F1G70ptf9hYHWBziZsrTpvzYEw?=
 =?us-ascii?Q?vxnYeYWQjHrkR7F1rlVHT9WhES+U25rTZI+wMgx70ylxiIXcZ8ApVTZiGOkb?=
 =?us-ascii?Q?YP9KnltKWm99HgEuqZzMyEZAuiH/BDVZkDAS31S98agvGBgGfcA+/uYhRB29?=
 =?us-ascii?Q?gxPJtitnp4FCUXoEmAIGjFtj2sXNlvo/Br7lGmJuDHyeqoGwCfPgCVCCnnCh?=
 =?us-ascii?Q?BxAb4FAfqqLN2Wsxiye5BJEqJJwqY2v6jOil9PlgIlaxX3X6abXEkloWxYWF?=
 =?us-ascii?Q?6o7Vc0xiNbuugKqgde/qjhNnQpto1hNFWZP8eBUesHOXN1GTYUkgSfQckPO6?=
 =?us-ascii?Q?cOz9/d5DSNBZ3X2ytnuXL0nC3TEt1+nRabRa+N+CBOWZFwE4LEn4VoFjfjCv?=
 =?us-ascii?Q?kjdrmwc88GHxGYzaxwpqDyCQWqUMpVtMCFjIHIn2IWCwpP9Dp7TaAQCKO2BM?=
 =?us-ascii?Q?J4VtrZCmaiRtGg6ei/cyBwKVdHcXatJHWOc73edwrSlq2hMKLSd6ga7ZmGvY?=
 =?us-ascii?Q?Zr0NpLHepr7qKvczDc62bTyEkjnCSq+UlIUi5EKutO52leWqRpyWpy0W2Ixc?=
 =?us-ascii?Q?LT0h/wj7Qtwn5B50BIu9el2NR8ZI0XHv9hgc26BzJBQfQMgPVd6QlCQSOnmY?=
 =?us-ascii?Q?IsQPpbau1TMl2BuzohW2L4asKCp6f6PvXBr21q6dYdwQDysnV45XPiOA3xaE?=
 =?us-ascii?Q?ggXWr6hscHRj024KI2Fk3wHjjny9M/GTZF4qjKPn/j5R/n9YZARN9ZVP3LRi?=
 =?us-ascii?Q?Fb1cHLq/nWoQ0+JKD2Mes6hDtXJKQro3qvqcxKNDMx7cQweILZrQmE2bB7sR?=
 =?us-ascii?Q?CcHX4z0WtWfEaKS0bwL6SbSZt9iv4tb/G4gpTRLEBOvYjvb04owRzd3J1tUf?=
 =?us-ascii?Q?ZJv1YmkO/mS/Cz8bNHK8NVQf?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1A842C2DBA51774892E0479779389892@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a6040d-f6da-41a0-405b-08d9576dd480
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 17:32:27.7046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xh8ejyXkFO+ZGOs6EbGCTz1gE+Jz1y0XRbpEKMzBqPZKzP+bV/jnubok1mOQx88lPtUAgyWRiVcLDXE9k80A0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3659
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10066 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040101
X-Proofpoint-GUID: TM830Sg2Yi9LO4W3YN-ygSrenZBVYSrS
X-Proofpoint-ORIG-GUID: TM830Sg2Yi9LO4W3YN-ygSrenZBVYSrS
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Jann Horn <jannh@google.com> [210804 10:42]:
> On Wed, Aug 4, 2021 at 1:07 AM Liam Howlett <liam.howlett@oracle.com> wro=
te:
> > * Luigi Rizzo <lrizzo@google.com> [210803 17:49]:
> > > On Tue, Aug 3, 2021 at 6:08 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> > > >
> > > > On Sat, Jul 31, 2021 at 10:53:41AM -0700, Luigi Rizzo wrote:
> > > > > find_vma() and variants need protection when used.
> > > > > This patch adds mmap_assert_lock() calls in the functions.
> > > > >
> > > > > To make sure the invariant is satisfied, we also need to add a
> > > > > mmap_read_loc() around the get_user_pages_remote() call in
> > > > > get_arg_page(). The lock is not strictly necessary because the mm
> > > > > has been newly created, but the extra cost is limited because
> > > > > the same mutex was also acquired shortly before in __bprm_mm_init=
(),
> > > > > so it is hot and uncontended.
> > > > >
> > > > > Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> > > > >  fs/exec.c | 2 ++
> > > > >  mm/mmap.c | 2 ++
> > > > >  2 files changed, 4 insertions(+)
> > > > >
> > > > > diff --git a/fs/exec.c b/fs/exec.c
> > > > > index 38f63451b928..ac7603e985b4 100644
> > > > > +++ b/fs/exec.c
> > > > > @@ -217,8 +217,10 @@ static struct page *get_arg_page(struct linu=
x_binprm *bprm, unsigned long pos,
> > > > >        * We are doing an exec().  'current' is the process
> > > > >        * doing the exec and bprm->mm is the new process's mm.
> > > > >        */
> > > > > +     mmap_read_lock(bprm->mm);
> > > > >       ret =3D get_user_pages_remote(bprm->mm, pos, 1, gup_flags,
> > > > >                       &page, NULL, NULL);
> > > > > +     mmap_read_unlock(bprm->mm);
> > > > >       if (ret <=3D 0)
> > > > >               return NULL;
> > > >
> > > > Wasn't Jann Horn working on something like this too?
> > > >
> > > > https://lore.kernel.org/linux-mm/20201016225713.1971256-1-jannh@goo=
gle.com/
> > > >
> > > > IIRC it was very tricky here, are you sure it is OK to obtain this =
lock
> > > > here?
> > >
> > > I cannot comment on Jann's patch series but no other thread knows
> > > about this mm at this point in the code so the lock is definitely
> > > safe to acquire (shortly before there was also a write lock acquired
> > > on the same mm, in the same conditions).
> >
> > If there is no other code that knows about this mm, then does one need
> > the lock at all?  Is this just to satisfy the new check you added?
> >
> > If you want to make this change, I would suggest writing it in a way to
> > ensure the call to expand_downwards() in the same function also holds
> > the lock.  I believe this is technically required as well?  What do you
> > think?
>=20
> The call to expand_downwards() takes a VMA pointer as argument, and
> the mmap lock is the only thing that normally prevents concurrent
> freeing of VMA structs. Taking a lock there would be of limited utility -=
 either
> the lock is not necessary because nobody else can access the MM, or
> the lock is insufficient because someone could have freed the VMA
> pointer before the lock was taken. So I think that taking a lock
> around the expand_downwards() call would just be obfuscating things,
> unless you specifically want to prevent concurrent *reads* while
> concurrent *writes* are impossible.

Good point on the VMA being passed in, that certainly points to your
previous patch being a better approach.  That resolves my questions
around the patch.

>=20
> Since I haven't sent a new version of my old series for almost a year,
> I think it'd be fine to take Luigi's patch for now, and undo it at a
> later point when/if we want to actually use proper locking here
> because we're worried about concurrent access to the MM.=
