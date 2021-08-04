Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7453DFAF0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 07:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhHDFMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 01:12:38 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:1680 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229910AbhHDFMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 01:12:36 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 174581Qp032601;
        Wed, 4 Aug 2021 05:12:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ueQECmcPbygoUU+lpxJXhrw7V6lL+Uml0qImqPjY9Os=;
 b=xQsY4l5Lk4V4/vBLOXEXnjKpGHb/tOaetPtqQtTOLH20XjsuOrfnuh1W92x7/4++zLI7
 pY5QiC06mpSPWkuf4heY8kJwrHk/keAZU4gHibEa8gJ78vLf9bKzaETk6dyLeW/F82kU
 7pV5CeZiGp556hIRWqM8mXbzvMFT3Lbz0LZ2woKp8iHQmOo3EySaU5+CUQVKggbryzJB
 aSSWAJXkLQyF59Q1WRbMvfAnSILoOeq7LeP2dZmlm9w4wSrnIoq5ihiCYSxupdUEPzYL
 hIATqssz5pY5Kajc4py2uywMV2IVYwu6Sp7W2BqX38F1iefhdwF8rTH+vMxGLkHtYyAY jw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ueQECmcPbygoUU+lpxJXhrw7V6lL+Uml0qImqPjY9Os=;
 b=x0soX80kxS2ByZdjKC+q5OBBGezOXIcWpVtn1vCM4Z2F07/L0yaXK01vCjGHMd4IKKIC
 oEnqgxe2abtyzjnEmkIcCICDDaTWsN2YzcACIuZA79pkqwKSlndGgNbH/eW2zTm3eMv5
 qNxGbBNpKf8qtbv6d26UtFSE4j0cy1jHoWvY0GSFXBQGpF9P0PdtY6p2MebR9dOkSAfM
 /oF7fyh5JaGCyrAA238jX2PwcV0nwjHzapUGSuHvHETgBHY+nWvMnhtBwWiXXwLXd/yR
 4caKKXcA+1FG7M4czHfuO8g/VFhMZmeAj/VhJBOYPDwmgw4QedLI4EUaNsa1/Iv3WJ3V hw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a70pjtt5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 05:12:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1745BLAk142694;
        Wed, 4 Aug 2021 05:12:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3020.oracle.com with ESMTP id 3a5g9weqtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 Aug 2021 05:12:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GppKa0N3ZYpxj0squ3nykGK6HGiPbJy93EuDHVHWz9b0+ODI7r095aEmJbboc4w+Oux6XaPDNZEvNrhmGs/A1lCutY6meru4q4N6YXXedW5+Xufh8VYfGwa/X2W493e9HcCUoZazUZlM1w312v9Yt5roLtUKQk33/xLpwhQSZIxchUTZeEzBiIAQgO3HK787Xrj/3mv63HRhVuy9xSVVZMS62iFPIKD4z+smdONc5rTOXDuF9lebQClWUql9AsknSbOr82WlkABPYssfUU+Ppuc2wxvNULBgGBxbNV4oygYpLrHmaoQgzyKhtX3wVeX+AzGpev8T6BlfzMw6qg7OIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueQECmcPbygoUU+lpxJXhrw7V6lL+Uml0qImqPjY9Os=;
 b=oG/zzxADJd8l+1zKvxEiJ/rtlslDlE6e7SqmLkG9Sid2GZjPdSGRaq7VhiUzwI3IwUMtlQQuSoo6STCwJ8mmt94ld7XMd9ktmwJSTPeoO+APTsepV+43E1RNU6c6uB2maGpRhgzpAzO++klNw9dI7yUi26ZyyGp6PWdzoFie2bedo9WnnrKlO5EPOyfqWN0RYwv+yrTH0DyUjop32iBXrAAj51XLyJZJmB05kbhZXbtf2TajL8N9fY+RO5vu6H675UlcFNfquwWL6VhnJ6GV/JB5MN/HrfI9qfT22+b+hOmFSDXgWBlCiJftu4qF3km7XvTzsPkZhgonFoY6TPacWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueQECmcPbygoUU+lpxJXhrw7V6lL+Uml0qImqPjY9Os=;
 b=Rq5DriVbuToAPYyY0jkZeqzRW8TaONNbgD9TBijLUGAXVL1dA64ffjbEjPyrsKvdmlkpJM2TEz2zkVVVLP8kG65B75Y7jJ09NWiFp4DUL/TNlRENAPgzUAvn1MKqfRDmeY8KI2vBiSV1lMqTeHCgRgmYhQ37sqUBYC0gm5yhRIM=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DS7PR10MB5181.namprd10.prod.outlook.com (2603:10b6:5:3a1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Wed, 4 Aug
 2021 05:12:17 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::100d:983d:7b4d:11b8]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::100d:983d:7b4d:11b8%6]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 05:12:17 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Luigi Rizzo <lrizzo@google.com>
CC:     Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
Thread-Topic: [PATCH] Add mmap_assert_locked() annotations to find_vma*()
Thread-Index: AQHXhjmoYtMFsOr1JUGtL1OdK4dvaath9waAgABfMgCAABX5gIAAB+cAgAAGLQCAAFfUgA==
Date:   Wed, 4 Aug 2021 05:12:17 +0000
Message-ID: <20210804051209.movpl4ubatcekakz@revolver>
References: <20210731175341.3458608-1-lrizzo@google.com>
 <20210803160803.GG543798@ziepe.ca>
 <CAMOZA0JKjRFUHbs3zc4kiGcuXxR0arCN=oPZZsLCa4qHvRrH_A@mail.gmail.com>
 <20210803230725.ao3i2emejyyor36n@revolver> <20210803233542.GH543798@ziepe.ca>
 <CAMOZA0Lk_aLSyu8MyY-xxfPafF-U9Zwo85H=qh=yMqPNcZdT=w@mail.gmail.com>
In-Reply-To: <CAMOZA0Lk_aLSyu8MyY-xxfPafF-U9Zwo85H=qh=yMqPNcZdT=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 003295eb-75d6-40be-cbae-08d957066dd4
x-ms-traffictypediagnostic: DS7PR10MB5181:
x-microsoft-antispam-prvs: <DS7PR10MB518160AAC836655126FD3B45FDF19@DS7PR10MB5181.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jpxwqPpm7kyKN97D4Bj++owYIaA3zIqCCsysCUi8ovPX4QqUWt8/feXCtExtkaYikn8kLK4HSYfgE3UX5RotWVT4RZ3Hbp51tZsgML4qaIbEtHzKpygN9M2cVjKIpPphC2A39dTORPXGq5nKbZj9HeeoF+dsTK8Ehm28axHvk3WXFhiTLXov/sgZBBBWXetKtsCXnxmU3nZ8EigOrqQnHaUGpawOz6ByH4NpZDKcQZakVKqc5fJrV3OWlwh0Tib/JGJupZaw2Mo5YxqF7EwwMobe+bBUMC5iI+ZCsgugLeuXvkafkduno+bLFoEJ42n+7EumrpQs20i0QUTOKbYp6oRRL2b65O3uZL7piBxoYhb/OVP7ZWXhV83xmA99h2bVXSaYgykC+7SEyJiy7YWgDfh0xSzkWGIctjZiZelVxOpsgLuLs+5XXIYHWKiQ+k0KZaszNk3UmO2YJf2FcIqXsImXtZeUKorosWWCcNi2EEBipUb8PqH1kFF7dPklkVyD/trcQeieLpgBpwonzvffa4NjoRZTUiY3io/qyNSsX5/hWYRMh1rUfHvClOpStreg7clFOGna3EcPaMSDEjlWdOxiqCdg5l+9N9TxxRNrznpVUAGYPZdBDRXCdTxXdKI6XIkQlWlW1iNvf7bEIbKUcYS6ccL8v3ycMmhp9oYwRkzo4R6TQvPNL1PFxL+YlhyWlDmklQZuBkRsysaQUeVw+lng/PZJZD/s7Hz1D+fA0DUZ83VUFEj3EhOLKG/PFbhlcQwGl4iruOSSOj2rXRqCax+bpbUS6QMzkaCa7G8Lg43DJ906DDf5g/TI8911D7g3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(122000001)(38100700002)(66946007)(2906002)(66556008)(86362001)(9686003)(6512007)(6486002)(44832011)(8936002)(76116006)(66446008)(71200400001)(64756008)(91956017)(66476007)(33716001)(38070700005)(54906003)(316002)(4326008)(8676002)(6506007)(966005)(508600001)(26005)(1076003)(53546011)(83380400001)(6916009)(186003)(5660300002)(37363002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gC/0bTHhY0CzqnhF9AqGOa9qnK6V2uAlhbY0PPS/N2tqcLr1q7gti11/LtNG?=
 =?us-ascii?Q?4hTijrOxWmm+tQ3IfVNHGPLST5IS9LSYvn17DyNH+2MOODWXYt4lxDBcV8A5?=
 =?us-ascii?Q?mOltX4Pb1qjdztfti5/6+YPN4sy3OZrjk/iHqSc2nuEpbd9lrS3GDDro3OEb?=
 =?us-ascii?Q?hqxLNuFtb7+5qpkMrNzGiL/yOVPwGRPzIimwQB0NzURoP+4KdoK+c3oyGrL6?=
 =?us-ascii?Q?fY7HSixtDe1cuN5Ul9M67vUx5m3J6btW0gwCcrLduMBlXM6OE540uFR7+fiy?=
 =?us-ascii?Q?j3qmjLAMyT14kTbZRszlyeeoOciozfS4ZCLKEf8Q/TDA3qe4KYl+m3oYJBRT?=
 =?us-ascii?Q?iHKxcWQFHmKfaZtHQxfbpRyVxhOLv1DAUoFNhn7m600f3r2/0XF/UPrNn9bn?=
 =?us-ascii?Q?qDjs5DRNCJSKGBkbi9jP4rAIfiX8/mIxXh8XcpqfiwI5MO5FGBfwOGVhIwMG?=
 =?us-ascii?Q?w4VMgYUpov28cWplb8Uk7fk1YR0dF7/wkXf8GJUwMMpC41yHlVoLNov7J7GT?=
 =?us-ascii?Q?iW2wBbDzdWjFntMgRU/Uc/NpJi0DsYHrOgia4GQr8q2/s2xSClfZCKS/46Kv?=
 =?us-ascii?Q?CZYB4b4jcfTxX1DFsa1iu8MIFlWL5EDBOpz4toFAnPv2/sXKXoX3q526P2hO?=
 =?us-ascii?Q?GG/wENIYEqSZm47F0vGkTLT11JfEH5WnxUV5Ax3BTBcz2STfv+h5HVVlw6o+?=
 =?us-ascii?Q?QrYj2DWPEppFUbp65GayEg/Ae0R5PK+J6AD1XXIetKTLueB8MGLJFonTMOkZ?=
 =?us-ascii?Q?b0Btx//SXoVsMqdeh6jXzMfDbl/5l41yTDWKc8jlhQo0LLuqKYAA7INodOdb?=
 =?us-ascii?Q?lWCmQyO3k4uehv/TfGcgV112C5WWr0c4gtuOgP4F0YPuzFB4PHOM9ulTYXyj?=
 =?us-ascii?Q?AaPiMiE4L/GblJTynheLxy7exi6N3Arj9RpkxleQ0wAZCeW9EYOVzcrz5BHv?=
 =?us-ascii?Q?u0v8vs8O5EOMOqS7RZMpHinlnjZqZA+BH/vb5D26Vc9NwJxBsV+eah0nqMo/?=
 =?us-ascii?Q?R6swixQdd7D8iCVAUfrso6L1HS/gVLWCrRM+oNtPopWEfIm/q+hqCC7Xt5DO?=
 =?us-ascii?Q?PBGd0g1dor32bqzpLgFiuInbufx7TGyLjRMLRjhC7vY4AklEMyiut8fkNEK1?=
 =?us-ascii?Q?Z+YAbReZE3jBrpajZojS79qtrJRNkRjMTu7aX4RI8w0SlwJyi13C6bDirwWu?=
 =?us-ascii?Q?npzZUhsh76J2GgQf7seGhwp8IUVCsGVAz2bH8qdk4hDQnkBmuHy9UAPE/Hhg?=
 =?us-ascii?Q?EoyseY4mQB85TVmdbKGgIqxhG79aUxwmjcdDl+PyTvvaeFfztJmOjB2oxwuy?=
 =?us-ascii?Q?pwYMb334kCbGgxW36OVd7lgl?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3CF26834B86C3E46A0574144228E2D76@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 003295eb-75d6-40be-cbae-08d957066dd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 05:12:17.2453
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WL5w5BPona4AXtefjPFLmBNpW2dw72cqr6zhtjloSdLE3aiUnOUCckVzMbRzVxkxayZ8EusxhrrC+gmwptFq9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5181
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10065 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108040028
X-Proofpoint-GUID: hOfBMGSbRXPz4IFnvwZrVtGizODpLXRI
X-Proofpoint-ORIG-GUID: hOfBMGSbRXPz4IFnvwZrVtGizODpLXRI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Luigi Rizzo <lrizzo@google.com> [210803 19:58]:
> On Wed, Aug 4, 2021 at 1:35 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Tue, Aug 03, 2021 at 11:07:35PM +0000, Liam Howlett wrote:
> > > * Luigi Rizzo <lrizzo@google.com> [210803 17:49]:
> > > > On Tue, Aug 3, 2021 at 6:08 PM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
> > > > >
> > > > > On Sat, Jul 31, 2021 at 10:53:41AM -0700, Luigi Rizzo wrote:
> > > > > > find_vma() and variants need protection when used.
> > > > > > This patch adds mmap_assert_lock() calls in the functions.
> > > > > >
> > > > > > To make sure the invariant is satisfied, we also need to add a
> > > > > > mmap_read_loc() around the get_user_pages_remote() call in
> > > > > > get_arg_page(). The lock is not strictly necessary because the =
mm
> > > > > > has been newly created, but the extra cost is limited because
> > > > > > the same mutex was also acquired shortly before in __bprm_mm_in=
it(),
> > > > > > so it is hot and uncontended.
> > > > > >
> > > > > > Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> > > > > >  fs/exec.c | 2 ++
> > > > > >  mm/mmap.c | 2 ++
> > > > > >  2 files changed, 4 insertions(+)
> > > > > >
> > > > > > diff --git a/fs/exec.c b/fs/exec.c
> > > > > > index 38f63451b928..ac7603e985b4 100644
> > > > > > +++ b/fs/exec.c
> > > > > > @@ -217,8 +217,10 @@ static struct page *get_arg_page(struct li=
nux_binprm *bprm, unsigned long pos,
> > > > > >        * We are doing an exec().  'current' is the process
> > > > > >        * doing the exec and bprm->mm is the new process's mm.
> > > > > >        */
> > > > > > +     mmap_read_lock(bprm->mm);
> > > > > >       ret =3D get_user_pages_remote(bprm->mm, pos, 1, gup_flags=
,
> > > > > >                       &page, NULL, NULL);
> > > > > > +     mmap_read_unlock(bprm->mm);
> > > > > >       if (ret <=3D 0)
> > > > > >               return NULL;
> > > > >
> > > > > Wasn't Jann Horn working on something like this too?
> > > > >
> > > > > https://lore.kernel.org/linux-mm/20201016225713.1971256-1-jannh@g=
oogle.com/
> > > > >
> > > > > IIRC it was very tricky here, are you sure it is OK to obtain thi=
s lock
> > > > > here?
> > > >
> > > > I cannot comment on Jann's patch series but no other thread knows
> > > > about this mm at this point in the code so the lock is definitely
> > > > safe to acquire (shortly before there was also a write lock acquire=
d
> > > > on the same mm, in the same conditions).
> > >
> > > If there is no other code that knows about this mm, then does one nee=
d
> > > the lock at all?  Is this just to satisfy the new check you added?
> > >
> > > If you want to make this change, I would suggest writing it in a way =
to
> > > ensure the call to expand_downwards() in the same function also holds
> > > the lock.  I believe this is technically required as well?  What do y=
ou
> > > think?
> >
> > This is essentially what Jann was doing. Since the mm is newly created
> > we can create it write locked and then we can add proper locking tests
> > to many of the functions called along this path.

That sounds good.  Jann has left the patch as pending a fix since
November 2020.  Can't the removal of the lock/unlock be added to the
next iteration of the patch?  Was there a v4 of that patch?

> >
> > Adding useless locks around each troublesome callsite just seems
> > really confusing to me.
>=20
> Uhm... by that reasoning, even creating the mm locked (and unlocking
> at the end) is equally unnecessary.

I think taking the lock is more clear than leaving it the way it's
currently written.  It is actually confusing to see the lock taken after
calling expand_downwards() which explicitly mentions the lock as
required in the comments though.  This should at least have a comment
about early creation not requiring the lock.

>=20
> My goal was to add asserts and invariants that are easy
> to understand and get right, rather than optimize a path
> that does not appear to be critical.
>=20
> Adding one read lock pair around the one function we annotate
> is easy to understand and clearly a leaf lock.
>=20
> Having alloc_bprm return a locked object is a bit unconventional,
> and also passing it to other methods raises the question of whether
> they take other lock possibly causing lock order reversals
> in the future.

We are (probably?) okay as the usual order right now is to take the mmap
sem before the pte and interval tree.  It's also just for the set up, so
unless there is a special case that could cause trouble... or maybe I
should ask which cases will cause trouble?

Thanks,
Liam
