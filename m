Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24D93DF83B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 01:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbhHCXH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 19:07:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4318 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232231AbhHCXH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:07:56 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173N7C51029476;
        Tue, 3 Aug 2021 23:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qSNUxbSX5O/b7B0P7luQcdE3Akyg6JidgXOFDMuzeKg=;
 b=f9eFIjdQRxM2n3k+9EsGreuIpMjmhBTVnvasEDdDxBDSsi7wIhM1vu0MgPZ1TPFyRaFD
 fh66IncNgIwZrgvuIgWoI3hOJukE10DMD5Lc+sQke2OfSLMO6qpjj1548M2N3zOpVrkQ
 2oC6eD7WyXKybNnOdBqXoJD0xNeoQBRTmzg9cX15AQclprtMS62jMYTxUq9tOkBysC2S
 SzfBPepYsMrehlo5TnafS2EJKFEFJo7mV/ISyte+6GlUu0fTckQW18lKdwQ48ffY41RR
 CioLX7hZQ/pW5L89qVyY4BpxLoCd8urDIYFn+UHa7EtLXU+gbhhyvHU9kXQDB4/pA+1J BA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=qSNUxbSX5O/b7B0P7luQcdE3Akyg6JidgXOFDMuzeKg=;
 b=FTSP1qMKpm1svPVARHhBojkZU6M3CRxR5D8pUw4rdZ+Qb3lEIBcYaRCNFyK8hB9/u/Rs
 f2IKm/F6m9KRPZhxHzUXM6k3XN+VyAO7dJ09ns9smKIOe7V0/92psKBO63VYcvHgmZYU
 N8NYDM6JH45vNOpjO0fgduI+52VV6y8cguPC349Lpi5TxtrkfPbJoYrv9HsG66UkWEsn
 mwHdgi/dgSnaX6IQMYV9vATO6qKzqD8B+RFMLTa62CmywVnH7Qt9kx0YMgWQ4pXjhkD1
 WUnX4ztMpsohyXHliqFiO40djOD/9uY2CJoxodkI+/47mXjUqo1mzldNnz587A1peeau ug== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a7cxn0743-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 23:07:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173N5uTP098764;
        Tue, 3 Aug 2021 23:07:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3a4xb7hqx5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 23:07:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+oVRpyvmVOIF27JaM6WnKGhM4vfce05MpvRds/m7/ZSyL8MXaiZte6m5TqMQV8OFxRFI1Iw4g4Jbq7t0Z05G38RS0Nn6MkKj0NqEOu7qFIGmo24ovOP0UUYma7oRfBvA1e+Ds92EDQYKRBmuj3uQAa0AklkxLsAW1c2EiDPsyN4HGly+BJdOY7l4xY07hrLs6lYTASUUa1dTjsHLJa0/D3XDaj6bGTytJceyzt98zZgrlEiPoK0ktiycf0qH7V9ezgBrcLdECubbfxDsrZsJFcKuTNq6U5/osCpIWkjb89XwrOI1kMYBCxtYO2ngMVbk2sD6GTn7Z/W2vgpfZY3QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSNUxbSX5O/b7B0P7luQcdE3Akyg6JidgXOFDMuzeKg=;
 b=aGazBlvIs4/xrMnqHaQpVjNeDWqQU0HuHicH0Ei0KYAS+foypbb/t/McNySQXos99wPDGo+gKmAUkiQnWgPsPtAtwEWY7YBMM5Y135y7odAXSy29HMrMXZiKFKlpIPymogMSn+gOv9GkUNNPWEMNLbRrE5xezWUTNOiAjyNo/xwfDYSxloKCG4SR2Nw/NTcMDVcpHuuFeHEsN7DKT3JXZ+V1yzLxOK26hWfKAzwwFplsUOm+uGkYGetwtRfnXjc54f3qb4u5NvynS3yhjukALnJ5Pmlj7T+GUZmD42R+Bv8t4JPpDE/kfnYapHvN1fVV7N9daw871J+/ps4Vx6WCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qSNUxbSX5O/b7B0P7luQcdE3Akyg6JidgXOFDMuzeKg=;
 b=v4oBiWutfx/zCcoI4/l62Y+IF3OvhdwMvJ6kw77aHtM4nzjopdIq+ldkchhsA2gWIEpZaBYgG6SUvPS1G6T1Fi7s7Lsfw+i6Cjf/YPd+QWr+UJcIV7Wm0IRChBnQ1Tw0TPhwliD5cxLTOu7inqQqhTWS9G4MHpEOFjBNVS94jM8=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 23:07:35 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::100d:983d:7b4d:11b8]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::100d:983d:7b4d:11b8%6]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 23:07:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Luigi Rizzo <lrizzo@google.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
Thread-Topic: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
Thread-Index: AQHXhjmoYtMFsOr1JUGtL1OdK4dvaath9waAgABfMgCAABX5gA==
Date:   Tue, 3 Aug 2021 23:07:35 +0000
Message-ID: <20210803230725.ao3i2emejyyor36n@revolver>
References: <20210731175341.3458608-1-lrizzo@google.com>
 <20210803160803.GG543798@ziepe.ca>
 <CAMOZA0JKjRFUHbs3zc4kiGcuXxR0arCN=oPZZsLCa4qHvRrH_A@mail.gmail.com>
In-Reply-To: <CAMOZA0JKjRFUHbs3zc4kiGcuXxR0arCN=oPZZsLCa4qHvRrH_A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a9e42df-f804-4faf-3b0d-08d956d37b19
x-ms-traffictypediagnostic: DM6PR10MB4380:
x-microsoft-antispam-prvs: <DM6PR10MB4380D5A1BF50D9DC5DA67B49FDF09@DM6PR10MB4380.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yuZdBCP1HntMSQTp9p2/VzB+crBYJ+dZtObxUFsGTN2cPRrMn22E6nsjjSM3F0C4ok0lOj/v9OkS9OvZSi8VOT8uJtWnOY6uQek+lwwyQpnphmc2AaPceRPafBn10ahwJfUOqoWeqcIhttvY5IeI1flyjDpcF1I88U2NR3ZjniJsVxiDeMtpnsOnP7USvJ0nfY1MKTN915m5em+TeMj+rd8+6DH3zcu13BX9dKQo8aw5d9Zc7taiLeld1aZjgslM1DJDIehI5FG5o+vRw5eLGs1CfXfZzaK/8/9zzceXJzaceiez4CRtaN36djLRonbU9GBzZ1jDCAcL8ewQ2xwIimNiTVF7NalvcND+bUhIpx1ybJAH0liGONVu8VvddeW38b40uX+j/dJPt2sfNb94V7hPYdHPC/5EAqV+Xwg/W6mFXiuNt2VjKq8LWRSpyUb4pByedq0Yl0wyyISz5EtTrZHnscVd/k+U3zncnmX9Kwm80gzwG8K059hE7ioqlA+rLpcsQLB821NsRAPJLMXhZqyDQsI41zyVuvOVH4Xa5kz5+qDMDxXMF+BUlOlbX1qvVYkKL8zg1Y4VapD09Mfx4rCLWWyW8OVqXp7Z2PAPiakSgkEDx6hDKFbTiuqDu+IqZ0wGWUxFln4w5BAnTV3Onz0FA45C7PSTwnE4BiTWEXSyK97BFLG0o1/RbuBIfL3oJ+fNatwipXljdSchu0XUt7g9GcxH4jty7bKhMX6LFP/nrEl3k7KoMz7TPfmtYl4B+KZt07RjDYjc0M/Q3p3rSdUvqQ42aEuM8zA3kMy68nBISZEksiNQ1iX+VmusGAjc
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(39860400002)(396003)(366004)(346002)(376002)(66556008)(4326008)(66476007)(38100700002)(66446008)(6506007)(6916009)(122000001)(64756008)(66946007)(53546011)(76116006)(38070700005)(44832011)(91956017)(1076003)(71200400001)(26005)(5660300002)(9686003)(33716001)(86362001)(966005)(6486002)(186003)(83380400001)(8676002)(8936002)(316002)(6512007)(54906003)(478600001)(2906002)(37363002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b21dhzAaoxikQTxOcxO1snKbFJIo9LHRnHz1Zq0PZCZhi8pUpWLn4uVvFC2i?=
 =?us-ascii?Q?e8JIEPfVQlGY0zHHgsTYO1ntnlcdROY0Spkqt0+FKXF9V0IyvEf3Ex+GaGR4?=
 =?us-ascii?Q?Ctxeu5HIio54Z5pYIuNk188FOHJThdz4elRqVQWhfm+qjxcuWUO/jImH9Kky?=
 =?us-ascii?Q?qTd3v3XSq0MNOAaJkswTiOeUCMvr7f5bRtJonLiK3EeCoVA6+EVW6HLKvLVT?=
 =?us-ascii?Q?/iZupAQUtRYpyDLhF66sDAIBzvQsbUi9rddkY/8c2RouhdqmbL63uhIIOssu?=
 =?us-ascii?Q?nOPMh9fg2kax6kkcyJo4r+IrhIk2lOwwVv1WB5gpl8OnF/v9gjvjdt0oM5qf?=
 =?us-ascii?Q?R/UnivdrrHfMtZUTCYsAZ7zeoonfbtxtqVeN6LBOhVANnGyKLggAzbB6zbI1?=
 =?us-ascii?Q?K3yh1E025DE3jjtpOuTpyYG5vgIRJ3HZUhqzgUJpeSU3t67GJHEVcq6y4jhu?=
 =?us-ascii?Q?CxT3SPycAjlHkzjri62fr/3FBf50ye7m+uc9tXcq5KglEJy1LZDQQNzSfeeq?=
 =?us-ascii?Q?ntG1Gfvz4aAUuIJfUieO5FI+Ooq2TNN7yxpcsNTb8IKpW47Ixx5pWwwAHozk?=
 =?us-ascii?Q?8hrST7AZVit8e2HrfSV1IqhlXJGU3u/VMCWwRMRRcQTaSstu5DpKtg+aElQ4?=
 =?us-ascii?Q?P53TM458SaVtYY5KG29TYVQ+/S98FRl22A+DhaO9BQBejZD2Rw0VnuSE6azZ?=
 =?us-ascii?Q?IZDy9O5OBr2LRxCGEyRM92SuvUlzcAAhUW6I1Y6SjIxwrv+wBv2K7OYq9UzI?=
 =?us-ascii?Q?Qki3k7Qeek9aWKvYSLi3w6FPKgRA7u7bMsh8b85oBHrFhXFFn/ncILMMngld?=
 =?us-ascii?Q?94cJP8VQ+eympI9CvMuYzKgUTTJJ+91kKkWmLLwXfRlIWWQEAuw2WWxE9s+G?=
 =?us-ascii?Q?H/kaqqEM5QtvQM70gULuca33z2DmKAA8DLYHQCO9S4zcsHr0zRQYexKKt7Vn?=
 =?us-ascii?Q?ha+I2yMSFCeti/YgNpN/7Ov26ZTHaVat/9Fd9d+1zO2ptaOclM/0Kv+CwkxM?=
 =?us-ascii?Q?xkm14vjM/qAKt1V+/lDI1MPeSraBlM05rdwX2oTfpbndwPTFavay1Qv20kS4?=
 =?us-ascii?Q?T0xHlbKXU/wl310GWM5qPecvH+7yoi3CbAl6571/4zk9/AMO+pQGaUeUlbh9?=
 =?us-ascii?Q?r/1io2hFF3apLCV8HqmpxHeMi5nRn70gf3mpDAjY5VQPlFoeKTVm3oGF9Azl?=
 =?us-ascii?Q?Olj0xq+4zm+fapnpP+sPpsoWks3k5/V25W6j1vclfXYGc8ufxepGCJfmcXym?=
 =?us-ascii?Q?KqcmJ97khNrc8yRnEInpOTkOORLMZVSxeg3uT6Olc1MvkIV+obK2t6+YwupB?=
 =?us-ascii?Q?Fsh+MCLAVDlDE1t78FFU5mh/?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6854C3F2EE3E964893C07773B288AAA7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a9e42df-f804-4faf-3b0d-08d956d37b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2021 23:07:35.1660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6OT0lu29nRGa5OB3+9m/aGk4iqHmaTZXPesMmAJn4PveGq2Pinw806SPT/XnUT4W/npn6+nnmnLMQ1CX1K/DLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4380
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=949 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030141
X-Proofpoint-GUID: ujAFy6N0ysZ19ONkiz2vJxA1ibAg4hbx
X-Proofpoint-ORIG-GUID: ujAFy6N0ysZ19ONkiz2vJxA1ibAg4hbx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Luigi Rizzo <lrizzo@google.com> [210803 17:49]:
> On Tue, Aug 3, 2021 at 6:08 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Sat, Jul 31, 2021 at 10:53:41AM -0700, Luigi Rizzo wrote:
> > > find_vma() and variants need protection when used.
> > > This patch adds mmap_assert_lock() calls in the functions.
> > >
> > > To make sure the invariant is satisfied, we also need to add a
> > > mmap_read_loc() around the get_user_pages_remote() call in
> > > get_arg_page(). The lock is not strictly necessary because the mm
> > > has been newly created, but the extra cost is limited because
> > > the same mutex was also acquired shortly before in __bprm_mm_init(),
> > > so it is hot and uncontended.
> > >
> > > Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> > >  fs/exec.c | 2 ++
> > >  mm/mmap.c | 2 ++
> > >  2 files changed, 4 insertions(+)
> > >
> > > diff --git a/fs/exec.c b/fs/exec.c
> > > index 38f63451b928..ac7603e985b4 100644
> > > +++ b/fs/exec.c
> > > @@ -217,8 +217,10 @@ static struct page *get_arg_page(struct linux_bi=
nprm *bprm, unsigned long pos,
> > >        * We are doing an exec().  'current' is the process
> > >        * doing the exec and bprm->mm is the new process's mm.
> > >        */
> > > +     mmap_read_lock(bprm->mm);
> > >       ret =3D get_user_pages_remote(bprm->mm, pos, 1, gup_flags,
> > >                       &page, NULL, NULL);
> > > +     mmap_read_unlock(bprm->mm);
> > >       if (ret <=3D 0)
> > >               return NULL;
> >
> > Wasn't Jann Horn working on something like this too?
> >
> > https://lore.kernel.org/linux-mm/20201016225713.1971256-1-jannh@google.=
com/
> >
> > IIRC it was very tricky here, are you sure it is OK to obtain this lock
> > here?
>=20
> I cannot comment on Jann's patch series but no other thread knows
> about this mm at this point in the code so the lock is definitely
> safe to acquire (shortly before there was also a write lock acquired
> on the same mm, in the same conditions).

If there is no other code that knows about this mm, then does one need
the lock at all?  Is this just to satisfy the new check you added?

If you want to make this change, I would suggest writing it in a way to
ensure the call to expand_downwards() in the same function also holds
the lock.  I believe this is technically required as well?  What do you
think?

Thanks,
Liam

>=20
> cheers
> luigi
>=20
> >
> > I would much rather see Jann's complete solution be merged then
> > hacking at the exec problem on the side..
> >
> > Jason
> =
