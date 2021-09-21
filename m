Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B81413816
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230179AbhIURL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:11:29 -0400
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12]:34542 "EHLO
        mx0b-002c1b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229893AbhIURL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:11:28 -0400
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
        by mx0b-002c1b01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LH8AWd032380;
        Tue, 21 Sep 2021 10:09:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version;
 s=proofpoint20171006; bh=pmJhN6Ky9fzRqtrNql3neYqCONsrJv8EnXeY5ifvMVg=;
 b=wGQ8yHuoQ9eQVtjB3TirYtQtt9OV7WHGJfa2c/0GT68HlgU52Epy0NWjSbeOP+Qj7lR0
 /gGMHLvP07DvRdJgNY1QPp2SWD62pMoBEoQN+FKoz7x03eJQaFkLjVWvbmChg1/VlDOG
 qGaW6ZqpQ1g85DzQeO7YkaudwZxN/1VvUIJF4qhVl/jMLVR9HD+SoUjU1GQpEj5/36a6
 15YqhtU3288ma9pNFzBYZVz/ctiC6DrM9Hn/uKnSrde7h1dm/q+2q1Cp76C1HV6eXy/I
 BvPJ5KKDqyCIEvtSnnpVfXNPLgXdXf3EZytS1at8+NqimZXI99eHuwTiAVGKyplnhvB7 Zw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0b-002c1b01.pphosted.com with ESMTP id 3b7epprr0h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 21 Sep 2021 10:09:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4wtumruNER5l3bDRze1N5oeBh+NIBf1dVImv/HPIMIOiMLcFDrpvvt8iC+HWxop8Q7r9f6d6q4Ucq0r3irXxUL/0Efoly7mftZg08LnTbOjSzT2DY9SAGFGVhOXtrPYS7bcsAfkCXN3jjaYF5TBDOBRQerWxuOhr/4b/yt74nMnPUFvvWAW+nU/6FAuXGlDmDAs1GCNMpxPZDgdsAlWCEYEvo6M+W3wa6aUWkixEiuVLeKxKsbqsJf1f9UGb5dhWPxk4blngZ9xj1VArWNOTflW34MuCizcjKWAr5a833GRUsrhEFNNK7jp9QyyEeEn2fN8JEs6WGrD7Z9K1iAwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=pmJhN6Ky9fzRqtrNql3neYqCONsrJv8EnXeY5ifvMVg=;
 b=oH5vxOX1u5KHw9GITOMZz49p/a6kIarDamyKT86rlLypyurojZQ9Mh5ZgodK/qlLa75RTGIHPEw6cHIqQ2D6NVxU2YRJZI5KvhllPexd/FdLZzx73VtNSCSbmlQBMqY5K3sjKn5r7GIaybr3PK/LUWhRTl+fb/9k8tVGzr7+HP0MWjigZpQpvxpClvHGSHKJIDLwt3r/A0WU/KbEkHOi4Acn+Oz7DaUsjoAwW8dJD2p1tLDLQl8es3FFP/+wZap096pEhMQt3tQr+C0TeBskt7khh8uey0wASvQFLEooHfOci5vxAfz0hSMc+9qWykUMYB0QVWI6huOEw2s+ksam2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
Received: from DM6PR02MB5578.namprd02.prod.outlook.com (2603:10b6:5:79::13) by
 DM6PR02MB6954.namprd02.prod.outlook.com (2603:10b6:5:22d::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.13; Tue, 21 Sep 2021 17:09:48 +0000
Received: from DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::6da5:2da0:efd2:e90e]) by DM6PR02MB5578.namprd02.prod.outlook.com
 ([fe80::6da5:2da0:efd2:e90e%7]) with mapi id 15.20.4523.019; Tue, 21 Sep 2021
 17:09:48 +0000
From:   Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>
To:     Peter Xu <peterx@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "david@redhat.com" <david@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ivan Teterevkov <ivan.teterevkov@nutanix.com>,
        Florian Schmidt <flosch@nutanix.com>,
        "Carl Waldspurger [C]" <carl.waldspurger@nutanix.com>,
        Jonathan Davies <jond@nutanix.com>
Subject: Re: [PATCH v2 1/1] Documentation: update pagemap with shmem
 exceptions
Thread-Topic: [PATCH v2 1/1] Documentation: update pagemap with shmem
 exceptions
Thread-Index: AQHXrj+D4T8obcdGHUe6vvWc8xL+VautSQuAgADmeYCAAGf/AIAAEdEAgAAGEoCAAAsQgA==
Date:   Tue, 21 Sep 2021 17:09:48 +0000
Message-ID: <B110C852-5688-4A40-A7C8-099638D10AB7@nutanix.com>
References: <20210920164931.175411-1-tiberiu.georgescu@nutanix.com>
 <20210920164931.175411-2-tiberiu.georgescu@nutanix.com>
 <YUjb91tWhd/YAgQW@t490s> <F6A49621-C7A4-4643-95C2-F47B02F132D2@nutanix.com>
 <YUn0ikP4Gip3Yc6L@t490s> <C983908F-7AF4-410B-90FF-DB4B9A06E917@nutanix.com>
 <YUoIk247W1Sbt6Lf@t490s>
In-Reply-To: <YUoIk247W1Sbt6Lf@t490s>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nutanix.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d77e3247-7efe-46e9-d0b9-08d97d229e3d
x-ms-traffictypediagnostic: DM6PR02MB6954:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB6954F1EE64140ECDC443544EE6A19@DM6PR02MB6954.namprd02.prod.outlook.com>
x-proofpoint-crosstenant: true
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /CXKHEzFjINWYkWY4gvVyOQ688U+n7yKyIWECtHiHRwhbanr1Th8YFTFv88qlDg7u1m71VklWP3oM+UnNvUFYLJwEMR6VWXjUYJivP8Y4Cb+mciWBJz0oEmf2+21bfGGvKtXM7KFmHiot+Szj4aUmPBBtAOgCbV+KvtZjfEaYVwocmzgzO6Br7G9VyTW3bSgqrkjPrNsdHjP2Kf4djOiemffb7uOKXSmOGrIC+LVBumglIzH4w2l7njW+tPabIdeaP1tBvHmSmxVTrF6vlyy3L+d/fu3WdWXrY6oZ00pf0u5taGEy4ooueHEEjWsk8BiZWxPBJ0owst7Lrl0pzPtJ6hV9wvZDO5PeWccDweeQeTKrKs3W/lGHS435kcDCOp/BuBV12aPb1kE+ARZJSqi4sKpJnJsYgo2CuemN0pwBVUpMJXeV/cX+UAoYKY2KlqOIcqw/obNecNR4JfX/MNhQK95yQ1NLc+hNaXetihKzADe15sON81lBE0t90zmJ6xIc3N+DAlDgcdcMVCL7jfgZy+qmv1ngvtp+5FNrdz/J+no03UVJeH/PZhptJc/tw1w/ZnllL1pbCTpLQJk8U34pZCr9eW34rCxS17zItHVCq6Kt5dCoyK9baJExVcMaI5JuUjbSWrgZHrSNvDZjzIhHUFVGOnRYLcjP8VcRypNescEUJJsbbCEzHLnaREmgRUMvSqk96rJMKbdpE5UaMYngCMQ3SEwhPmDpNNPHZs+P93Nw2jn90JasTuS5/vsT3Qg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5578.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(71200400001)(508600001)(6486002)(186003)(38100700002)(44832011)(38070700005)(6506007)(53546011)(2616005)(66946007)(107886003)(66446008)(91956017)(316002)(76116006)(8936002)(54906003)(33656002)(4326008)(6512007)(66476007)(66556008)(6916009)(5660300002)(64756008)(8676002)(2906002)(26005)(86362001)(36756003)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v45fUCVOt4HW8t7okTNq8lDFZpHezrDpsNCvWraqntW4pYjTi1gYfCGJXGHQ?=
 =?us-ascii?Q?q7wBC9KA0dOZB7nxOA5ZuuFOSxkOoYzTpq5kRiSUMe3y0EfevJEI3E4UdAZU?=
 =?us-ascii?Q?cEpEiw7TRtk+eHbREDr6eVTJTu03WahIsuTRKDrDpLuOp7R3KUkqILMY7NfR?=
 =?us-ascii?Q?RCnMSlHECtXvygdPYn85omylcjXVXl1+uNjD6Ed3ybXwB7Jugf4RdoqLKOyq?=
 =?us-ascii?Q?CDDMKthG18vhMgbmguob0ZzmnqUtF8qcURw9CqDlXLDZ+CDzBfYul7EgIZaT?=
 =?us-ascii?Q?FVkXszryzWBmY2n0cVebVCdomVlW70GRtsGCEoUsodJyZPAUq+1xLnr/W6cK?=
 =?us-ascii?Q?hZ71zMfprpsRUjWhIGxDHhDdKIXF/LSoSVvTvIsTgG1IM6VZZ16KLe/xXVyc?=
 =?us-ascii?Q?12el9nzSPklGk5/A5QQz4S0sO1ZuDhnum+foWyArjDkKsKEoQtrKx8SF64fV?=
 =?us-ascii?Q?Fwu/EkT6dzKA9M6DXXFKbR4nQEpzXFtti33hrb0kNwtYjySdrtWhYXUytIw1?=
 =?us-ascii?Q?CU8hXNRbWSJdp0G33D/4mHOpQs69BGEqQNe9hXVoqyIY3sV/6FZMiqm4miTf?=
 =?us-ascii?Q?PPHwgJm3AF7Coqd8Wqjci7IJLqm1s6zcOMhgobJsTiYTQw+XAVNC92N+FBZd?=
 =?us-ascii?Q?rYNe+xZseFP9W1Y0CaOZluj1qUpWqEmLoY3ysyA0coOP10XcAqNOB2wxVXEJ?=
 =?us-ascii?Q?989KUXukoc5HcDPD8H76oh1CvpI7wyvndN0spHUxVB/otT86sElrm6zYsXmu?=
 =?us-ascii?Q?q73yomG+rmlkXFGsyvSgY6zHm7BJkp8iHs+jxfmGhJZrGH/VnVQ79xSmORdn?=
 =?us-ascii?Q?AUMA02rvmsZUsPC9pHnFJVgGWebxOQlQDWFDwHW0oXsyvfjTWF7JAIdqjXn6?=
 =?us-ascii?Q?60WC0mgnIacM83AETLxdxggI0ZxzUc+/j1xCsOgL4NQqUjNuA22YraPmDu49?=
 =?us-ascii?Q?Aup3wN85rE9FBVTGTuGU3Rd45bIo3NUQkqz6kMBmIP/67EDALGdfyD8UeCC5?=
 =?us-ascii?Q?42GpfmfIGFDPN1+o+eN9Vl6+ZzwK/DHhBhW5WE0R2J8FbfPpUADr5CVumHsW?=
 =?us-ascii?Q?bAF4vNcpVysSCVW/A3khH7mT0sDEDjJpk2bfMXBb/5odg3ryoj0p48fiVCfg?=
 =?us-ascii?Q?vT6OzvNmWaAypcEXmdCNcbBDK3+YHC/IgxlEasKmKzHmx3cEC+D0CyC9FZPH?=
 =?us-ascii?Q?t14/VM+kjTHA5jtV+fBG2pQ72gpXv83gUqUvIUSkBvRV4pQntW1odNnpvymF?=
 =?us-ascii?Q?2k5WcoKiPyoeVWco1s+8QVMr/JIDZUBubAagPBCh5z2ft836qe+vFRYsgLtp?=
 =?us-ascii?Q?qZGSNKdOdTYZ/3Ud0JRSnUvV?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AD1751BA2FCFBF48896380E4C22E9244@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5578.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d77e3247-7efe-46e9-d0b9-08d97d229e3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2021 17:09:48.5737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6lV+kQFxFxSc7R0M8kgs0dN+yaTDbCyhRPnmp61h1whju3dElkGkFBrcyZ1FAzpCxsDAJLZkoqZaL3sm7BqavQVIqThWy/hHe968peSFgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6954
X-Proofpoint-ORIG-GUID: S5rBpBj6BqblILK3sm6N0uRJMjn7TReJ
X-Proofpoint-GUID: S5rBpBj6BqblILK3sm6N0uRJMjn7TReJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_05,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 21 Sep 2021, at 17:30, Peter Xu <peterx@redhat.com> wrote:
>=20
> On Tue, Sep 21, 2021 at 04:08:29PM +0000, Tiberiu Georgescu wrote:
>> Hmmm, so if we put emphasis on the accuracy of swap info, or accuracy in
>> general, we need to use frontswap. Otherwise, mincore() could suffer fro=
m
>> race conditions, and mark pages in the swap cache as being present.
>=20
> IMHO it's not a race condition, but by design.
>=20
> Quotting again from the mincore() man page:
>=20
>       The vec argument must point to an array containing at least
>       (length+PAGE_SIZE-1) / PAGE_SIZE bytes.  On return, the least
>       significant bit of each byte will be set if the corresponding page =
is
>       currently resident in memory, and be clear otherwise.
>=20
> I think "within swap cache" does mean that it still resides in memory, so=
 it's
> not violating what it's designed to me, at least from the manpage.

I agree mincore() is doing what it is designed to do. I did not express my
thoughts correctly.
>=20
>>=20
>> Do you reckon this info (frontswap for mincore) should be present in
>> the pagemap docs? I wouldn't want to bloat the section either.
>=20
> I don't think the type of swap matters in this document, but imho mention=
ing
> mincore() as the alternative to fetch swap is still meaningful as that's =
what's
> missing for pagemap right now on shmem typed memories.
>=20
> Even if it cannot identify some cases between "page presents", "page stay=
s in
> page cache", or "page stays in swap cache", it'll still be good enough to=
 me.

Yeah, it should be good enough mostly. But I feel that providing an exact
algorithm on how to separate the cases is not appropriate anymore,
as there are still exceptions, and the "perfect" algorithm needs frontswap
as a backend, which can be a fairly prohibitive precondition.

Maybe I should just note all these tools down instead and provide a brief
explanation of their usage and their downsides in the context of pagemap
information.

Thanks a lot for all suggestions! I'll cook up a v3 shortly.

Kind regards,
Tibi

