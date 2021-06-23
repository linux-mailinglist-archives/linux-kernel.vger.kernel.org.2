Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 623033B1346
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 07:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFWFgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 01:36:38 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:22026 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229665AbhFWFgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 01:36:37 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15N5T01r017240;
        Wed, 23 Jun 2021 05:34:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by mx0a-0064b401.pphosted.com with ESMTP id 39bdsc8q4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Jun 2021 05:34:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJdp7xhwM9XY9vgNqYC+w3YQ+lTdlUSUX2VH+GaDGWBe1BjNgHtAfXymw/iq+w2vZftGggIxdNgLRg491uK7WMkUxrN8NYIIQjHtc75vtPCP83jD/P6aE2J+ds2dQ1euYIiOTsMjTR4oSGEj2YkNyIBiYplmcxXltrB99kZYkvl43yfw5MA75apky/CQGVLH151wuhb+LWRv/rFdFduLX+YP6ObJwr7jd2QX+qwyfLct0tx1WXgE0mxrATqmC6tV2Iam88wmJcgzFtJJLQcBQ9UlQhv0d1DaJ3hKkSghaLW5PqR6Yuo4Xv6JWN/5SdcsE+iAPf7BtHg1ojxAkAIDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+00L6S6hVyrzJ9MoobG/1JmOnKAdo04Xv9dA143vIs0=;
 b=XlDjJQSgr0rTlVSCOHT8MR+P2dQqoJuRSp0PeRRT65QOBcB9ySowmKSG0//GMdWKJ+L8P3Ilv5M9UVGaSBGp7DIcgQSRLJh5bTdE6wB20jFWo/Pnbzb8qEGJu5+Mhl41OWgRreJui+iY/qI4KhqUon97k8ka5RjwIm4p6CJoEUGOIVwCdJZpPuTdx+HA7je4RxlAC7B+bq3+Alqpb6Hz42pn5hdAAiVBMAWi8GwNcIJMqMvMHKp8acmPJsSIP0bZeho1wUXR6kwZkoiibQghjf3sARTI9HfO/fWlgJOmIL06/TbmDNDYxxK/IRWTxBZFRmVci0w50NRq5d0vcNz8XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+00L6S6hVyrzJ9MoobG/1JmOnKAdo04Xv9dA143vIs0=;
 b=PCwUKF2Wmoq45wjVya0okqB/Xc3aziGgHIAU3BExy8/HoCljNSc6yKDOlLt09m4v1WspNUEpml5C89WzE18Qa4+A8hss2NYuU5SkwvWJU32r0bWx42uKj8emPZIrnRltOcK6mVWJLOdXBZ49AWHJfr4P/ewZhJI0iLLxDTwgQJY=
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by MN2PR11MB4510.namprd11.prod.outlook.com (2603:10b6:208:17b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Wed, 23 Jun
 2021 05:34:16 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::9967:5190:1cd4:bb93]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::9967:5190:1cd4:bb93%6]) with mapi id 15.20.4242.023; Wed, 23 Jun 2021
 05:34:15 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
CC:     Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] workqueue: set the rescuer worker that belong to
 freezable wq is freezable
Thread-Topic: [PATCH v2] workqueue: set the rescuer worker that belong to
 freezable wq is freezable
Thread-Index: AQHXZ2QWISsDK3PkgkGbobcL4eIXTqsg7ZUAgAAdQK0=
Date:   Wed, 23 Jun 2021 05:34:15 +0000
Message-ID: <BL1PR11MB54783384845A2BCFEE305DA1FF089@BL1PR11MB5478.namprd11.prod.outlook.com>
References: <20210622124211.715378-1-qiang.zhang@windriver.com>,<CAJhGHyCNXEPEb0t9KLXafx8TPntjWFFH-T9uFUTsuGAQxVcZTw@mail.gmail.com>
In-Reply-To: <CAJhGHyCNXEPEb0t9KLXafx8TPntjWFFH-T9uFUTsuGAQxVcZTw@mail.gmail.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1dabe59e-3c6f-4f5d-8260-08d936088a59
x-ms-traffictypediagnostic: MN2PR11MB4510:
x-microsoft-antispam-prvs: <MN2PR11MB4510212B1C71AB4C3C47A1C0FF089@MN2PR11MB4510.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z6vS55awdd/KRTzIKUN4I30sSOzD5dcnJ6e3LKWKiaLoQe4i3kj72XK60SOC0/yt8OXKA4g8KpoXCAA6zX2Rcsz9c/iqA2w5Ns60EuxK85p9JJpJvtWoCUDnItQd/Sz17bh1Rn0FwqPFQoM5q3FPhJXnSx6M8KylC5Om1zzroRquCisJae6hcMdl1FtAtQHuWN/LgHr0Uo3kEM65SCEO+L2BaqL7qEByN+KMriZwMuXMW3sZPbSPwqPE+vGx17VJaDvGb08P0WKfSg1cjyRyB/OnIe1aIC9pL2XXkPzS0BLnaHejya7NnCKGjaJ6/Sw3Ikx6GM/WNDuEU0HYQBMo1Fog7dQwIhkSwfxbTFQaA5Wtihs+9etOMaYWMS0lCOSqEOu9NtJH84oyrdy7q+3NBLgkEM8lwWmYPDM5rbCktpO7EIMTUNxwN828uE2nSfNIcmp3s6GcibXAbLBAEfODwaBGBn1SNzruvMXPXbjZX+xZOHslRdcmp+KgpQpxZhD6Xr8hwRIhdWn8YXOsWrQQdoAHU8UfhKSDY8HFFE4vIS4PxtMSGXMSKdHt+GiQi4IM9r/3PmD3e9XD5yZMOTaKkGYI4cpdmpP/47MCXBo9VqnpeFhUQJWRy7tRDM9I+9xx4Ima0mFmk1avcWAmgkgWew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39850400004)(122000001)(38100700002)(66556008)(66476007)(2906002)(64756008)(83380400001)(91956017)(66946007)(52536014)(33656002)(86362001)(76116006)(66446008)(5660300002)(8676002)(55016002)(478600001)(6506007)(54906003)(4326008)(6916009)(26005)(186003)(8936002)(9686003)(71200400001)(7696005)(316002)(53546011)(586874002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3dMgW6IUavipZCqGVw2guWT+Jkr/W/kIeo+vZ2J+SzFEfVvA2cP0r1CpcHzV?=
 =?us-ascii?Q?t/1N7wvQLKq05jvvldYTKXFb2S9Sfrpy/0kLhf+iMqSOcD5a/pdY6k0G3BBZ?=
 =?us-ascii?Q?VTmWbrW61A+OSZI09MFDOtuBCnZ8g5mwlOMJpYkuYUXmwbWb3H0t7ZgWa/xn?=
 =?us-ascii?Q?1O1faWBgq0ROjd5ZJE4/ZFbzZ27Xm9A8fWVV8yK0f2Xwb3niwGhENiuCxbJk?=
 =?us-ascii?Q?QZa4MuvSrXN7uQdaxrK5AGexpqMcbEnYjDIkKQzkxMPHwpd+dBMd8xdiD432?=
 =?us-ascii?Q?1haC0Hs5yiri9hajMWxVRx39CtLnbLPs/x7bXPIUBlWzubAjnbM+KzHHp2CQ?=
 =?us-ascii?Q?92oGza1xtvscLaVBUrzPELVEUNlbc6C9E4PFZdld+KL8KlXQQqEqCF45EeSn?=
 =?us-ascii?Q?rnfZYFOBHUeRAHKSFegbwCNnuUUMyde2n+/LWR6Dg2iliqeB8mS3aHZSi7w+?=
 =?us-ascii?Q?DGH5JMl4ZopIyQXUCXOU1EbxPyOYZiWpDg1J3cKeAwIJ39RrwQM0wk5eGKWd?=
 =?us-ascii?Q?tUi/Yl+NpBYTTVLr75qoaVRDqdg0aL8fY04YrdxIyN6ry95G8ZC8uwhQJC1x?=
 =?us-ascii?Q?zBbSTI5b7zz8uhEa84sqRNnCSO2Ci3o5b7zkeSyzLPMmo/FHwmAH3soXrTpt?=
 =?us-ascii?Q?ZxnksbmNdwWXUoEVkapiumdRTHozwLw35nehWoNYxoSCvoP8PMhnO6b9T4OO?=
 =?us-ascii?Q?TilcyO9WEN9PT45hIiBmPp+iJHffJeV3BElR1AkzbmqXUACGe1MJpF/s1I+b?=
 =?us-ascii?Q?0bMDzAV7Uon9ndzRKtP6ros/KNXtuDb+nZf+jwk8QTzuDt+Madfng6mRQisR?=
 =?us-ascii?Q?O2pmU0yCZW2BRAPoc+vAk9YlnLHlf0ichQwpsMR3iMMUm0KAMtxNUG+11okz?=
 =?us-ascii?Q?Ug/DTo/4N36jsocfOt2Q4xibcqVN63emBnxjKKHFJwlbLxm0wq4QaDBGFMws?=
 =?us-ascii?Q?8wXU2f1kHgc56YJpK3pCS0WmSd9LjcKsOP10i9rUtN9KOIonGWb6uczht8hB?=
 =?us-ascii?Q?pdyp6InDMtWY7SDo5eyOCh2Iq9cL6KhJZHyXp9J01RSvMDybLptD2mIeQrsJ?=
 =?us-ascii?Q?T8qfhL96jjmRBF9JFSpH6CkSC+51OJF3UUK/Pqh5/yonjoEN3ICHNjL9EoVS?=
 =?us-ascii?Q?eTCJ2BrxuCzA8A1QRDO9rWX+3roooOF2CCrtfWiEcXGNVYlVbdoHer6sp3+k?=
 =?us-ascii?Q?+RiCJsCGO45htHYWBI63f8hezgyvgDr8x3/R67U2vwf9aYm3tjw+ZAR49cvT?=
 =?us-ascii?Q?OiX0lhyyxM+TjdImNI/VnRvR8BFInEsLU//R8HYAG4om44v1+oIJFrY5gqd0?=
 =?us-ascii?Q?shc=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dabe59e-3c6f-4f5d-8260-08d936088a59
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2021 05:34:15.7270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHRPa2RAYPIGIPaCmx8ti4PHMAFNpcEchiH7jX2WjZ3ZUycPHb/L3ybWcFX5xuFzQa46/hKPcIOpo1WLXXbtMtSGRW3Sn5ZW36Pci2gj3zY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4510
X-Proofpoint-ORIG-GUID: E3nHob90w2MGLY-hMjQR5reAfByBArQ6
X-Proofpoint-GUID: E3nHob90w2MGLY-hMjQR5reAfByBArQ6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-23_02:2021-06-22,2021-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=709 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106230029
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=
=0A=
________________________________________=0A=
From: Lai Jiangshan <jiangshanlai@gmail.com>=0A=
Sent: Wednesday, 23 June 2021 11:16=0A=
To: Zhang, Qiang=0A=
Cc: Tejun Heo; Andrew Morton; LKML=0A=
Subject: Re: [PATCH v2] workqueue: set the rescuer worker that belong to fr=
eezable wq is freezable=0A=
=0A=
[Please note: This e-mail is from an EXTERNAL e-mail address]=0A=
=0A=
On Tue, Jun 22, 2021 at 8:42 PM <qiang.zhang@windriver.com> wrote:=0A=
>=0A=
> From: Zqiang <qiang.zhang@windriver.com>=0A=
>=0A=
> If the rescuer worker belong to freezable wq, when this wq is=0A=
> frozen, the rescuer worker also need to be frozen.=0A=
=0A=
>Hello,=0A=
>=0A=
>From my understanding, the wq subsystem doesn't use >set_freezable(),=0A=
>try_to_freeze() families.  For example, the worker_thread() >doesn't=0A=
>use set_freezable(), neither do in your patch. If kthreads=0A=
>in the wq subsystem need these functions, please let us know.=0A=
>=0A=
>The way the wq subsystem to freeze tasks is by >freeze_workqueues_begin()=
=0A=
>and thaw_workqueues().  When WQs is requested for freezing,=0A=
>they will stop activating work items.  All the workers including=0A=
>*rescuers* will be scheduled as TASK_IDLE when all the >activated work=0A=
>items are processed and the whole wq subsystem is frozen >unless=0A=
>there is any semantic change about TASK_IDLE V.S. "frozen".=0A=
>(rescuers can also only process activated work items.)=0A=
=0A=
Hello Lai=0A=
My understanding is this:=0A=
when the freeze_workqueues_begin() be called, this only set pwq->max_active=
 is zero,   it's just to prevent, after that when we queue the work again, =
we will put it in the pwq->delayed_works,=0A=
but if  there are still some work in the pool->worklist,  the workers in po=
ol are still handle work items, and the rescuer work may be also handle wor=
k items,  until the work items is processed, the workers enters TASK_IDLE s=
tatus.   the rescuer worker is independent of workerpools , when the system=
 freezing,   freeze the rescuer worker directly without waiting for all wor=
kitems to be processed.=0A=
=0A=
Thanks=0A=
Qiang=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
>=0A=
>Thanks=0A=
>Lai=0A=
=0A=
>=0A=
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>=0A=
> ---=0A=
>  v1->v2:=0A=
>  use kthread_freezable_should_stop() replaces try_to_freeze().=0A=
>=0A=
>  kernel/workqueue.c | 5 ++++-=0A=
>  1 file changed, 4 insertions(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c=0A=
> index 104e3ef04e33..dd7b78bdb7f1 100644=0A=
> --- a/kernel/workqueue.c=0A=
> +++ b/kernel/workqueue.c=0A=
> @@ -2476,6 +2476,9 @@ static int rescuer_thread(void *__rescuer)=0A=
>          * doesn't participate in concurrency management.=0A=
>          */=0A=
>         set_pf_worker(true);=0A=
> +=0A=
> +       if (wq->flags & WQ_FREEZABLE)=0A=
> +               set_freezable();=0A=
>  repeat:=0A=
>         set_current_state(TASK_IDLE);=0A=
>=0A=
> @@ -2487,7 +2490,7 @@ static int rescuer_thread(void *__rescuer)=0A=
>          * @wq->maydays processing before acting on should_stop so that t=
he=0A=
>          * list is always empty on exit.=0A=
>          */=0A=
> -       should_stop =3D kthread_should_stop();=0A=
> +       should_stop =3D kthread_freezable_should_stop(NULL);=0A=
>=0A=
>         /* see whether any pwq is asking for help */=0A=
>         raw_spin_lock_irq(&wq_mayday_lock);=0A=
> --=0A=
> 2.25.1=0A=
>=0A=
