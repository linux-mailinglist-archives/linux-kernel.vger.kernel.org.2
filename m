Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA94539AEFA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 02:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhFDAKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 20:10:34 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:22029 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFDAKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 20:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622765329; x=1654301329;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TNDQbRyIM56jP+b6y+070dhhrLCZTXaiDtd8Lf7hTmM=;
  b=BAYRbijdW7cqHU0TuAxffa+Hd/HY5h7LtQIcbHP6tiSFLXfEn7tMB9yM
   68nsQgLsOtHt/8qDhAwllml/liSMYGEYZIE5S6FHHTCOASAvqqLhheW4y
   HNVcLPeLU3OX7aiU3h+dRYgv3H7L8fxqsonx8RgM5g/ShM9f9vTITVLjy
   oZcxaHJV4+aaDy/xDjvI3u0OZdZncy/LnFxkX2pCKyE6tKy9Wv273Unsy
   sg/wRXKTkHcfnSoDTrD0i5CW9ZDcxbNrY1BWitSqRE9A1nvnWRV996ApO
   StHO1dRKxS7ZxbDpWXfczjqlGHCyvlDYuPozYF5qiLVRspKCw1R3wrFa2
   w==;
IronPort-SDR: lSo//Xilr/84uDypFzmhOjvDZz7NkFPqU6OhizK4d8dXQfz4SkJI4hZSSgsVDsbhLYMf4ZK3xt
 YCvRrc4KIBJp2lZzexwD9oMKNAnCLhWn/ezE49EgB7vQC19Rhzmb6thLQUOLWKGDGgfCBYDTEo
 stzdM+LaIHH0vCTIWZaEc6W2j2z3nOle3i7WKM7dOxcG4Xo56dDnrdt0+OSiX49xNTNYPdSu8a
 oH8jiUFVLg2/p4yDjMUMZNz9XIW94e1r9uUVEqdoD052rzGNErJHUfrQUsotZgr26wb8utDh7D
 UgQ=
X-IronPort-AV: E=Sophos;i="5.83,246,1616428800"; 
   d="scan'208";a="282058977"
Received: from mail-dm3nam07lp2047.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.47])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2021 08:08:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLTmHVMTLlt/wKA6YON9XkJF+rAbrH67uADyQ9w+mGyZno5/mQAoSxOqGoImUUpl2NkWL8xVcqydInpeoCN7CkYgkP94HDV/yJXcSfUeolaEtIpvfNDc36w+dX9qMw24SlPep4TuFud7hwFMamOMn/fLbQf9gpRfv48M2V0XFaKe1YlQrCbo1LCwPEwSpussZIKPE5pl7bj73PtWo4fL8xyFRAxazJHPUtRTIkM94+lKXtuVoiRodzkTGi4q7PxTtRKuQsc89SZ9bZVEgeCz9PYy0MmUWO6bKVTHZyaH80Ow5ckZ4PTGbMoHTcC0Y5DNm/u4x5m1DpVWoODLcp/C+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMSgWt8tWgJckadDfU/H8lO/QKcnGdaZZH1YCJYwT1Q=;
 b=gy8/iGylh5d1Np2uxi+QZ9GPDY/bsQDzYcjwHv14YOvYY2qfQSAUDu6bcHC1Bbgjnic5QeJbB6yOCIs6GU7oORuQXR/zjNS1oMUfxUzadRnN3xczpGV+hqSZ4YX9YiVh1r9op/MBG+F9PiVDOCDJni9PsK+XMGaFuzeQuwJzr1c+g9meVJ0j7ZwfKDk5eieYprlR6rXe223Hc0ZFlkjmLHt7D/l45C6I5TS+vPHzjqbrKw5M5aRZjQZD+St+Q0g+18SJ8HA3OGB/Gck3fqJ0VjeaIyQQYUXUPXMJYFeyelSI9R8TNzCVdffKELl1CBUG1hB/pa1ZwH9kBuqZLfA9Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMSgWt8tWgJckadDfU/H8lO/QKcnGdaZZH1YCJYwT1Q=;
 b=D0s/O+SYsgzPAyjdwQ13LJ+Up4Jx85UZ3zaGKUzj80vU7JROmJ2yrUO3OHgbCaMwrEk2dLHU82DpwqRTYyOlSP99fiDeD3z+tmCZ0xrb6E0rIPLvM6LLMRytkuz457/7X8/iTIid9YZC2nEK8H5rbE76Ucmn8SoEV1BuaNgkZgQ=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB5163.namprd04.prod.outlook.com (2603:10b6:5:1a::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Fri, 4 Jun
 2021 00:08:47 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.035; Fri, 4 Jun 2021
 00:08:47 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Colin Ian King <colin.king@canonical.com>
CC:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: dm: Forbid requeue of writes to zones
Thread-Topic: dm: Forbid requeue of writes to zones
Thread-Index: AQHXWMY2crVy6LmSRk+Dbf+Tih0t2g==
Date:   Fri, 4 Jun 2021 00:08:47 +0000
Message-ID: <DM6PR04MB708127E21C618C8F5F6B3DB6E73B9@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <7e7530a9-7939-2ad6-bfe1-d3aeeeed1f77@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:f9bc:fd30:41b8:96f2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49b71c6f-3832-4ec1-5b8c-08d926ececbe
x-ms-traffictypediagnostic: DM6PR04MB5163:
x-microsoft-antispam-prvs: <DM6PR04MB5163FF7EE964262C66B68FE2E73B9@DM6PR04MB5163.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YNJBMxT6aSS9V/7/9DmcwBzdXlPRfXt78QC7xDQh0v/NOG/XLfnPO7iGlwAwtOC505mL/AbZoQE8ia4UeBjExHlDRKD341+rsXxSwWCfv+p5+uNVqbpt/tXiABKHlg2RVAP4Df4QwU3bfA+M02IlMGZ8u0HBpoJ6j4nid3g3nVIVCaWnW/aRZcNPZIbJ/495BDLG9Jo+vDFdl05znV5eGtyVithpVav5ZvjIFgszqTyRIfbiy76Do4Fcfx3YG1jozPKBbj9HQV8QLpFUzqwoDZ0DW5kMI/kmz+Nz/4Osw+q7TYRiQpbqSOULrehNb6IewgzreBGS+FpzDaFJh2B5tgsVBZpzvmNHsqvjsz2qa1wSxkbxflK+w3QWiCi+nhwY6vq8Tno8QvSlpyoWx9nURQ9783uS8osMOlIA2gWBEv7/QRH4Vlu0nEVddCIwV1lj4wq8MOfhPN99blhV0tGM8Nwndvfd+suk5RrLjswBH19iWsBTciiJkx4u89JDjD0pSqlZnARYRyz8DTrEP8Yhx3ujmpGDq7YKeNxh0BQB2Xdo3KPpKhjfIwXebssE74OieqbZxXMbA3DueAFWpWPc2H74I4PK9f09kwfSxVeCSINvyfl8VMmoyfbQF0OBb9g0dHETDmsi0iaZVtVxXDL54Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39860400002)(366004)(316002)(8676002)(71200400001)(6916009)(8936002)(54906003)(66476007)(52536014)(86362001)(91956017)(38100700002)(4326008)(76116006)(33656002)(186003)(122000001)(478600001)(66446008)(5660300002)(53546011)(64756008)(9686003)(55016002)(6506007)(7696005)(66946007)(2906002)(66556008)(83380400001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?2DwNYlaXI2LxISLrvP8biIHsDXeDuwOzVC15pnEylAspL/m/kMZacCAEHu60?=
 =?us-ascii?Q?cqyJJ8WVD1I6tdYU0oqsGTtX5vLs3g+k4r8KzAzI5tSKjyGRYugbhvkLqtVi?=
 =?us-ascii?Q?49Q7x3R7+Zu92Cs9YJBhFQy77N2pb5SbSqRWK0GmJHLNkOWOnN3CoLnOQ1pi?=
 =?us-ascii?Q?NyZsOcOILbRlMHr4CpjaYj9PPLQsynjMxptCwtKd4VVHyt9Cvst8svyEglE9?=
 =?us-ascii?Q?CRHTPcZigmYJeo0A9WYRs5CSjlbIgDe491ARHfS+b4/k5aDkyUR81Gf1SEA7?=
 =?us-ascii?Q?tHApk0PSUuVSQh92n4qtlqAFf6TeDyaNZ/DgJs8fi3EO66GuI4SOt/eb27Fu?=
 =?us-ascii?Q?LBOUrBfkmKn455nibbqONt22f8kBvq9dG0Gte/iMJHaFZ5/cdqbKJ0JtXkw9?=
 =?us-ascii?Q?8m02UmTBAfpNKJYEZHJegZXEmN4/BHHZmluLDTzunuVCSRaRLWrShFjsqWUm?=
 =?us-ascii?Q?QdXp+JZrEZOgfgJdFC88nKA4Wz+WJD52S2+pdpQ8HD15sA1xDfxDBfyYz6il?=
 =?us-ascii?Q?kVbyI80Et/FHuQHzKN3fL0mZJ5On9dVqhDxcghxPPIgpWZE0/YHV2C7ZDJ3I?=
 =?us-ascii?Q?3JRWyBhTnI0om7p2zpKGfyWhsvherDyGkEKS0pHKmPTd1KxlXRf7fhZHb37J?=
 =?us-ascii?Q?DCbPQ5PwnX8Jw6NDDDYBG5xn7ZCV/fLusT5fQ1IWKCafQSn8l4ENY8XrvZxz?=
 =?us-ascii?Q?vec6ygJozz5nK5ztdGxt33KW4ZIV8uJyfk00tWaQb9J7juat6vDyFrtN5sRl?=
 =?us-ascii?Q?oRqzp+CQ/lDBux5fXGNRyL3FPjHIX3AoIR2TCOZbQRTa+zTN0L12NKiSZ2Io?=
 =?us-ascii?Q?tr8SYJgDabJlaOI47cGtzXP4/YkkUHMFLF3MDCB3+JjoOZ6KzcgifOSfIqkk?=
 =?us-ascii?Q?7M+1QdsKqA8PfC4fMRE5yslIRPLo8/MI+MDY4qC4ysd2dtKsJzonwcTG9Ymk?=
 =?us-ascii?Q?+dbuGU62jets8QbmopCk2HpNfpjw1Sr/r1Xupc4xwuck5pIKozpe7XWVxjNZ?=
 =?us-ascii?Q?NXqoNRd2uPyXf4DJUzB0V7Sgr5dMsO6ds0mYA0Wx0FA9eNHnEviHccbgDuYf?=
 =?us-ascii?Q?faJt9IcquwQCAiT7djeIm8mNGFr4C7NhOwGJ9gLL7Raxvh6KqiKvXBbdctAC?=
 =?us-ascii?Q?RupPmSMcKXIxFAo69AUo7UHuBftr6SCuuH6KSywqbDttAzA76dbR2iFzWdWn?=
 =?us-ascii?Q?ZAZ8CpVsqLo/j+dd0268oaxTS1LyvMRsvIte+qf9xxdLQfjb/egqfIw6dCMy?=
 =?us-ascii?Q?9rESuq8aH4dwKSNkq/h+xobf1RhJrN+3YsigIiEo0BKJHqhpMBc3oOoQIdAt?=
 =?us-ascii?Q?9OSy2SKFAcNiY5O+TbEC6XRwI/fqdEr9u8DV4R0cLHXFpkXcBAMBfMDKfTyt?=
 =?us-ascii?Q?1yb4wo8Vqu+lU29OsXbz78SDRXlnNb8K81Pmrbz91vZMLDXnwQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b71c6f-3832-4ec1-5b8c-08d926ececbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2021 00:08:47.4705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tqm2tSZr4khb6BmC/T0NaBccCSVNRl0Q4VVvnpkLd3iI2B4lySV3kh0cabXHHBQbs1X6m/Vk+gLTK7e8iBSaFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5163
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021/06/04 7:17, Colin Ian King wrote:=0A=
> Hi,=0A=
> =0A=
> Static analysis with Coverity on Linux next has found and issue in=0A=
> drivers/md/dm.c with the following commit:=0A=
> =0A=
> commit 2c243153d1d4be4e23735cd10984ac17c7a54531=0A=
> Author: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Date:   Wed May 26 06:24:58 2021 +0900=0A=
> =0A=
>     dm: Forbid requeue of writes to zones=0A=
> =0A=
> The analysis is as follows:=0A=
> =0A=
>  828 static void dec_pending(struct dm_io *io, blk_status_t error)=0A=
>  829 {=0A=
>  830        unsigned long flags;=0A=
>  831        blk_status_t io_error;=0A=
> =0A=
>     1. var_decl: Declaring variable bio without initializer.=0A=
=0A=
This one is related to #7.=0A=
=0A=
> =0A=
>  832        struct bio *bio;=0A=
>  833        struct mapped_device *md =3D io->md;=0A=
>  834=0A=
>  835        /* Push-back supersedes any I/O errors */=0A=
> =0A=
>     2. Condition !!error, taking true branch.=0A=
> =0A=
>  836        if (unlikely(error)) {=0A=
>  837                spin_lock_irqsave(&io->endio_lock, flags);=0A=
> =0A=
>     3. Condition io->status =3D=3D 11 /* (blk_status_t)11 */, taking fals=
e=0A=
> branch.=0A=
> =0A=
>  838                if (!(io->status =3D=3D BLK_STS_DM_REQUEUE &&=0A=
> __noflush_suspending(md)))=0A=
>  839                        io->status =3D error;=0A=
>  840                spin_unlock_irqrestore(&io->endio_lock, flags);=0A=
>  841        }=0A=
>  842=0A=
=0A=
My patch does not touch these hunks. They are as is. So that is not new.=0A=
=0A=
> =0A=
>     4. Condition atomic_dec_and_test(&io->io_count), taking true branch.=
=0A=
> =0A=
>  843        if (atomic_dec_and_test(&io->io_count)) {=0A=
> =0A=
>     5. Condition io->status =3D=3D 11 /* (blk_status_t)11 */, taking true=
=0A=
> branch.=0A=
> =0A=
>  844                if (io->status =3D=3D BLK_STS_DM_REQUEUE) {=0A=
>  845                        /*=0A=
>  846                         * Target requested pushing back the I/O.=0A=
>  847                         */=0A=
>  848                        spin_lock_irqsave(&md->deferred_lock, flags);=
=0A=
> =0A=
>     6. Condition __noflush_suspending(md), taking true branch.=0A=
> =0A=
>  849                        if (__noflush_suspending(md) &&=0A=
=0A=
I do not understand this one, nor #4.=0A=
=0A=
> =0A=
> Uninitialized pointer read=0A=
>     7. uninit_use_in_call: Using uninitialized value bio when calling=0A=
> dm_is_zone_write.=0A=
> =0A=
>  850                            !WARN_ON_ONCE(dm_is_zone_write(md, bio)))=
=0A=
>  851                                /* NOTE early return due to=0A=
> BLK_STS_DM_REQUEUE below */=0A=
>  852                                bio_list_add_head(&md->deferred,=0A=
> io->orig_bio);=0A=
=0A=
The kernel build robot signaled this one already. Will send an incremental =
patch=0A=
asap today.=0A=
=0A=
> =0A=
> The pointer bio is not initialized and yet is being used in the call to=
=0A=
> function dm_is_zone_write where pointer bio is being accessed. I'm not=0A=
> sure what the original intent was, but this looks incorrect.=0A=
> =0A=
> Colin=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
