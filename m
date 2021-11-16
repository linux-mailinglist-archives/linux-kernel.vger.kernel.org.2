Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83650452D14
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:45:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhKPIsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:48:20 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:61682 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbhKPIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:48:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1637052316; x=1668588316;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tBCVh1HtyrWMpW082fBR3FngnVuKoSJ2LekGiCysijs=;
  b=DLX2xNfRSsjVM70wOXITHh9P3MwW43epw68cGpx3UBGjIarjPJ41KbEF
   gr04u62WZsu7y3dEQLQNwTA7AToDeEQs7HxbyAr9DAxH8xiwYhS2vX8gh
   FmT8FAwtZatwbXfd1KFdNzIM2FXAgOx898jF8h9BvA542tluLj3kjXVCx
   PLEemRD2LbOOwQexwqhOinPtulYInZcgKJM28qN8NNbVLD6SD16JH3d/k
   f94nt7eDFO5Z7P2iCIdUSUr4u8XEfli8VGeVIxpgke1ChElEHCUBjC7nz
   0mM5ys14yalj2wGaZyWZKHFatLzD4upkJFfOrmH5cealPdJ/uBlLTbJ3C
   g==;
X-IronPort-AV: E=Sophos;i="5.87,238,1631548800"; 
   d="scan'208";a="190527308"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
  by ob1.hgst.iphmx.com with ESMTP; 16 Nov 2021 16:45:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9LiRFaOYzAFy3UFKiqOI5d3cfvFlyI+NJ8VJa4w1+Nx5U6fZQ/2b8c0RlrIAeiozRFQwQTuPkgmPdKjHBf+dAfl7ndHPbeDfjD4ZvExcj3bOTEWr6DIeo8yUVUYxHvBYLBqm9+HOPxlEmSexrevFJVIzRmd8pCvLIPWkiZcZA5XJdKpuxpquEthKPqrqaPSUZahf9dVNyUV88rJngqV88LCwMw3DyK5Dc9LfAFOSzCP5Zg9Q/X0fLgbVGHq64T3yGc9WvtffyXVrSVmnIaAXJKdYeGZLFhRX2tmkF7KALRMx9ofJUc8L6ueIu81dKhcagjbzUTUAi4NBLCBQw65EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBCVh1HtyrWMpW082fBR3FngnVuKoSJ2LekGiCysijs=;
 b=Z/peAHYWA3ycJqtPL8QoLUK7Bm0p9TSixVQeatNonRE2nda9ImhawvncQ4yqZFIJXeS3XIj16n2TSPHYPmQP9s9Cq0PzFCGydJBnZSVsu9crhodPLlcc1Cso5BnPzKhwNf2d13z40Hcw/w0e6HEYySXs3iBUE82sqapi4sSZVn6MtEVcfmsM+1F76ia2HpLoPnDOx7tw4fcN3ZiGddjT16c/FiwdepPsPcb6LKLhDkEa6jPh85GekO1danRu2eO22BF1jRAgk/BgsI99AXFaaoLEZbsZONDKAahrbuJv9EPvWBYHavonLig0BM8OVbpZ+e5VuNK4I+c8ih9yEFmfRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBCVh1HtyrWMpW082fBR3FngnVuKoSJ2LekGiCysijs=;
 b=PjzYLsUIW1Tqdf8RR+J3lGF8V05Fs200uUT6Vbnb84DKVc+QfutGaZv0HiLVr2cTJs1B+zjtHRV1qG0scDMU+HDAs3BeqT2qMoFp/vv9vdNITn+qIB6nHkkyQ2bBvBYTxNE8dGdt3RSFkYhInLM7VwLiYuqHoE+ptp1VJ1oub6I=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by SJ0PR04MB7727.namprd04.prod.outlook.com (2603:10b6:a03:326::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.16; Tue, 16 Nov
 2021 08:45:12 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61%3]) with mapi id 15.20.4690.027; Tue, 16 Nov 2021
 08:45:12 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Valentin Schneider <Valentin.Schneider@arm.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "jing-ting.wu@mediatek.com" <jing-ting.wu@mediatek.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] sched/core: Mitigate race
 cpus_share_cache()/update_top_cache_domain()
Thread-Topic: [PATCH] sched/core: Mitigate race
 cpus_share_cache()/update_top_cache_domain()
Thread-Index: AQHX2g37TPTJ8je3+U2WwmDdbyK6N6wE6pEAgADh9QCAAAvmgA==
Date:   Tue, 16 Nov 2021 08:45:12 +0000
Message-ID: <20211116084511.ocupfvgrkqrttghg@shindev>
References: <20211104175120.857087-1-vincent.donnefort@arm.com>
 <20211115104601.lwcwxoc67ftbf6uh@shindev> <87h7cdqne7.mognet@arm.com>
 <CAKfTPtAPaMU343=uRuo-LvoP6HnGwnLhTcEMyFVBisdjnT-Spg@mail.gmail.com>
In-Reply-To: <CAKfTPtAPaMU343=uRuo-LvoP6HnGwnLhTcEMyFVBisdjnT-Spg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 731f316c-4582-4034-76a1-08d9a8dd6771
x-ms-traffictypediagnostic: SJ0PR04MB7727:
x-microsoft-antispam-prvs: <SJ0PR04MB772735C4CBD8BEFFC85D71D9ED999@SJ0PR04MB7727.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wYKdwK9fkdpt1806SyUaP91A1CMsv+fIfokJu0z6hBOC9UsyteCUQYaG2FmmUAwIiGBZHyPEjdmqxJ3IeEwlR2AYmGepQWQxC4DZ2T72HttTV36QyoBeYoooRIQhLS6/c0LtPJd+cweXejPxaUMSOb9uEdADxsT1NXdZKzTk9JXt1zFt9bCgGAKRvHWxbCP2V7JOEdYT4zrFBjHTUo9cEjYtaTvNTZIl2vc9d40JBmpurbklXhNyt4X0a5S0viShJyRCwTJ/9pp8wEn+q5pEXn/09WXqvoADRL0dWlk5fCBnrMzoZfP7feE2qde13gC1YHurq3ECi8vJLGDCCZRcLhms8CrnCOC1seKLodCrLK66hLw05CIeHnQKKjf0YurmOokMDeB9jsine1MsUE9n61XDBkzNHaD8/qHSQioYktvm0nn5QMgdOhRkO/k4FfP7rQDPk8/F8sbgatCy4YIokC2tczLxclSkrwE2UPkz/TCD3lw04B2jrSPjPXDSkUHgOCtcjfqA9yHuT21XUXISJaMJ4jOFPu4ZxbeVluUqmK3jKWYoVDufNHZg8RbVWIaD63cVftDQ2vF3RdWhx9qBclbows+WRCjQ+43C+Nr3Fq4p/pAtj6vdDliTBC+Z2XHA1KZNhbORKrtr2rop/ju8gY/JvWFGxLmQpm9poEEghfX0dx2Ti1NPm4KQdyoxt63VpA2y13ygfyqlzMQc9RMPR9CswgAoZn/avWXChgN6xIcNZ8fTZtBzuNvje32yuvc0FTDnV1OaV6sUTPErkMlx6s3qMYeZdZ49zJdDlJ1QLqE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(66476007)(66556008)(64756008)(66946007)(66446008)(71200400001)(38070700005)(1076003)(86362001)(6512007)(4326008)(38100700002)(33716001)(53546011)(186003)(76116006)(122000001)(6506007)(15650500001)(9686003)(6916009)(82960400001)(316002)(26005)(83380400001)(508600001)(966005)(8676002)(8936002)(6486002)(5660300002)(3716004)(44832011)(2906002)(54906003)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ftbH12qaOXcsFVlyso8cjo3ejd72CzEwUjIHlnPP843JbJKqFjZc1PNTenyK?=
 =?us-ascii?Q?hAs5yMXtgzzTiXD4llfw6NNwqW9uTFrMJfBlUKq19IBcRHfjSPr+nDCUiNEe?=
 =?us-ascii?Q?no1RgcXAyF9pWIYflOfBRhrJj+rs8hVFc/pxX01PMouXhu4MTnX1NtD2UvuT?=
 =?us-ascii?Q?uttwKD+HqIoVHFzifgjOKTlqfiD0dm5nyU+dMEr/PdwHmNPlAQX5Id+W+3jb?=
 =?us-ascii?Q?5gHK0qSoXW8fTiXLclu1tHtcf0CVCQmCIgWwepDPF0ktIpksmFf7JI44JfHl?=
 =?us-ascii?Q?87kIGBLhMOowYyocPm67rkLQGXVxRbhmeVjfQZSyxg+rpoB6CDzAMCVninQf?=
 =?us-ascii?Q?6mJ89P+BSqgy/WcmQqBa8ZqHwjT5cYbpY7CzqwhsvZIMCFNjsA4lD9I/nwbZ?=
 =?us-ascii?Q?Ihwe4/InG9mweFQTE3RmhLe78cREdSPSSDM3IYtsEq68/des/86E/w6yu0Sx?=
 =?us-ascii?Q?dU6LnehqGQq1LldGB6YarAICVAJOl+0EWTBTpZOaNXo9Ppc3CN6rPYk7pTJ1?=
 =?us-ascii?Q?p0NluoFHJu2+Ar+W3DbT8RdVFfJ6CcDPfW5D7qyA5SxmDBpbYrT+COjjRa96?=
 =?us-ascii?Q?eLFbEQA/Psm9GAy1aYZBDCK9D0Jsv1HF/s3E2xjm82Z4QyDy3Pe+0w9uC1yy?=
 =?us-ascii?Q?U3nXU4Hu0m5/cEan3dtBYZmAkLg8rRc42ePrzim2GViCkXWbu1JNQdzONEo6?=
 =?us-ascii?Q?8wRxpzw7aIpJDkYA08vNjqXK7ut45gtN53DeMShBAFWBzlITrte+/bMp9s5n?=
 =?us-ascii?Q?KYXnCOXZsSWqcdGiWL8aPKSU5WKb68CsNPvLS6s2/INd7KhMWa6rRuStAwdV?=
 =?us-ascii?Q?yHaHD0gaU5Q/TR/QEKbKkI5FuAyw9uG8zvUjkWAydYwI96ZgPX/ZQJMezF98?=
 =?us-ascii?Q?f4ryvYNO1yoW05SehTtv4AmotoY3oNZoisHsmCWNa3+NIiGyLE5Gf4DkyBUm?=
 =?us-ascii?Q?dvfy2Ht5tjXKQfmSpvSaM5jsVuvhn5zXNIRABMZA9QejFTG7zctu9WLqDdko?=
 =?us-ascii?Q?eCniDL9JXiWDRQ9dqtpo+xquFIJtMk7lISs0yY1sWzTyEqOYifjCtN4ZHGRl?=
 =?us-ascii?Q?vnLXqpLduZUUmqzHBTzz4knpasmXgh/6Gw0eYvOpfwBzXsM7C5rMMC3lzMN3?=
 =?us-ascii?Q?poxS9pA5OXzvAtvIrF+IDdcbWplAaN+mFHOq8owl6CnnGIEftbWm7fYtDMac?=
 =?us-ascii?Q?LAWnsIRhXJ74ZgOG8hMN6KAp8FrBU72FbXiCxB5dvqkCis89RBjeCZChWxpl?=
 =?us-ascii?Q?/Vg5Gr5OW5PxpNfVUilOoAL3bUZkFYauvXLq5MrIOOvVRTyK/SHX9oimna91?=
 =?us-ascii?Q?OIBVrQYqDjfl5/u9CGplfwNGtU+CuvAsCW1WAW5f5PDqoieEGzMFljbsyl85?=
 =?us-ascii?Q?zx2L20cTD6LhqSKFbn7hfubNdJxn3cMNb0l9Bu8R/J9ugw16OBqxLWAvTvH1?=
 =?us-ascii?Q?zm0lQhzj8rFnVhgenKX4hbx1vJln5jdhPlWHmF2VmX03LuCE0ohpbx+PiAI5?=
 =?us-ascii?Q?K+a3sPgGRx2iORbB07C0vOxpy7IPI044y5HnxS2supVQ7BJTmO1GhJ0Cx1vw?=
 =?us-ascii?Q?8y4VkMTmVITdAXJSwMDR5cT/yoEuwfsjR2ppAbM2slYvVMd/o2F5XbzaKSRD?=
 =?us-ascii?Q?5yv/0WY4t9+IWJ+BJ9fKm1yP4pZTJpQhbR/VI9u5crg9T7CJ0Rn2aJAytM8A?=
 =?us-ascii?Q?3bziz+/KDmA0Kf/lqtiiUTmXq2c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EAB112DF5BC71C4DB1D624D48005CAD0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 731f316c-4582-4034-76a1-08d9a8dd6771
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2021 08:45:12.5119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5su4oxBlZ9KH9qFyn1Pdty75Zis2v0YrjHzbwW1CktQbr/3O5m+DJgrY30h3aoNNB/G///R4ROyvhdOdNfXnNmcmOpPWGbvDJIEthIa2VDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7727
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 16, 2021 / 09:02, Vincent Guittot wrote:
> Hi Shinichiro
>=20
> On Mon, 15 Nov 2021 at 19:34, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
> >
> > On 15/11/21 10:46, Shinichiro Kawasaki wrote:
> > > Oh, this is the exactly same fix as I posted before [1]. It is a litt=
le bit sad
> > > that my post did not get reviewed. Anyway, good to see the issue fixe=
d. Thanks.
> > >
> > > [1] https://lore.kernel.org/all/20211029005618.773579-1-shinichiro.ka=
wasaki@wdc.com/
> > >
> >
> > Oh, that sucks, sorry about that. I do try to keep an eye out for sched
> > stuff sent to LKML, but clearly there are some that fall through :(
>=20
> I would advise you to use get_maintainer.pl to make sure to not miss
> to cc someone.
> Like valentin, this patch has been lost in the lkml flow and i haven't
> noticed it

Hi Velentin, Vincent, thank you for the comments.

I have run get_maintainer.pl on may patch, and it listed 9 maintainers and
reviewers. But my patch had only 2 out of the 9 in its To/Cc list, which wa=
s
too small. For next time, I will use get_maintainer.pl and post with full
To/Cc list. Thanks!

--=20
Best Regards,
Shin'ichiro Kawasaki=
