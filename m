Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC62419E84
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbhI0Sq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:46:26 -0400
Received: from mail-co1nam11on2099.outbound.protection.outlook.com ([40.107.220.99]:31180
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236274AbhI0SqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:46:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byP26pBkEMlZroylmp/YXrjMKrRYsH6zswQm/rdAI7xHAbLBoXUji/rnkoeThLxL7djJo6Ji2QF2OsQ7m0CglzKDUYiXtu+JoTm7IpwDvnLcwGIZLsdVIQ5YqSNNrKhi007px2NxrARvudF9SxnM0DQXdON6mFqh99HrQ8kG/PfYVYMjDeinJSCO1qamJXh0bFgR59qI49jq1IyLUuDZLTYYY2vhLe6RXeWjezRsIaKOc37264/OfZHxP56lN+fs4T6AocQMompteP+UkcvDF4MesvDEiVKmi52Xxdn+v58a+N+BAn3HcqHwaB733aygjxazPeOlAatqHL0H6NP/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ORRLEw0Wsbe1xT5ivTI1y+6dqHpInulVCodMz7Mz17g=;
 b=dJuHKsdu5cnKeUU+GZo4wyviRBKgUVP2/f5fGETxv+/oNeL6FjiAgRh9qtduZL/gs93rU6wxwiFfmLCOL4LrsQaZ0ZK1FlZ9fYXigH4uPcv8PLcLC1XEDR+v75hUUFu/fPyy7bCJnLfzgLlKmR2Qg6eqQWyXTssQiyRNlTrBKv5vu6S9v4eBLVkEbiwXS601ufq+jmu3VEJ3S7EaHISQpelfsOTMKPmWKn2gnRAUxs68PJqLxBl1yrz9KqPPdIqe59gGDU2iFWruZQ/sFxU1DHNYA+Rq+khI/U+Cvmhrh08tXEgrH/7FWIKtgGo+BAssgetWYE+jVu5LJTUe9mqWPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORRLEw0Wsbe1xT5ivTI1y+6dqHpInulVCodMz7Mz17g=;
 b=gGuUlvNZW48T8BpQ/ocqcHz/k1hz/PngSm4YD5w9akKQop3UABX+M9EIGXaS5IMl/XibaHl0lMyBs541PBKIkTviK8QZxKqOOnz/ine25PA+Ya9Mat+H+GGCYaCrcPPRaoKLUu7/pFWDMfaK2d6cV9pFr4sW5IcuDvRDZ/uOZS4=
Received: from SJ0PR11MB5661.namprd11.prod.outlook.com (2603:10b6:a03:3b9::5)
 by SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Mon, 27 Sep
 2021 18:44:45 +0000
Received: from SJ0PR11MB5661.namprd11.prod.outlook.com
 ([fe80::31bb:4f91:1eb5:7178]) by SJ0PR11MB5661.namprd11.prod.outlook.com
 ([fe80::31bb:4f91:1eb5:7178%7]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 18:44:45 +0000
From:   Ryan Lee <RyanS.Lee@maximintegrated.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "yung-chuan.liao@linux.intel.com" <yung-chuan.liao@linux.intel.com>,
        "guennadi.liakhovetski@linux.intel.com" 
        <guennadi.liakhovetski@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sathya.prakash.m.r@intel.com" <sathya.prakash.m.r@intel.com>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH] ASoC: max98373: Mark cache dirty before
 entering sleep
Thread-Topic: [EXTERNAL] Re: [PATCH] ASoC: max98373: Mark cache dirty before
 entering sleep
Thread-Index: AQHXsZF45/jZbOMADUKIjx+r35kUIKu3/BEAgAAPiFCAAAR+AIAAC+UAgAAIKhA=
Date:   Mon, 27 Sep 2021 18:44:45 +0000
Message-ID: <SJ0PR11MB5661814BCC6B79EDE1B0967AE7A79@SJ0PR11MB5661.namprd11.prod.outlook.com>
References: <20210924221305.17886-1-ryans.lee@maximintegrated.com>
 <1b21bbf1-12c7-726d-bff8-76ec88ff8635@linux.intel.com>
 <SJ0PR11MB566107A6AB3D18ABDEDCF245E7A79@SJ0PR11MB5661.namprd11.prod.outlook.com>
 <20210927160622.GE4199@sirena.org.uk>
 <7b8c3875-3f12-f3cb-7da8-4e850e59ee2b@linux.intel.com>
In-Reply-To: <7b8c3875-3f12-f3cb-7da8-4e850e59ee2b@linux.intel.com>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=maximintegrated.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 747e6ccd-6070-451e-fc50-08d981e6e076
x-ms-traffictypediagnostic: SJ0PR11MB5598:
x-microsoft-antispam-prvs: <SJ0PR11MB5598AAEE793C28DAF8AB1A75E7A79@SJ0PR11MB5598.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HacFYvOAWKQPLGiIEALKxlym6/wIHerCYpFT2FNaTEH2+/4y8+IcWc4S8FzRyvtSzfAs/PLCL/6EGfyGHomKF2W4e8QelNevgViuVk1E6C0ogIQE69Gu6dgMgd0O3UMYWnzGOfP65ZWdoyS5BMimnE7+DOuAW7WZbqJHvwuy574OkrxxTaYlpzWzL4fC5UcAWJZJKUrAh7oYYZ308F8aLVmEKLO5mW42OLXAJ7wmZBcaVrTDlx4Gd0yhdq4rQPB/FD60XHatBCafwfmZA+HCRTwPQCU+sI46PkQUn9rp138YHaENgj+4cKJkoWluzcZ7T7SKcgpbpNzp/uyPy0bwgvSoQA+lLVufaKNplMaIGTkB761V1c8wtcsy1phFEn3XFGQX1l1Mz2Q/Je/vWGpGlsZrfo0ApfooLnKexaJIUP6+1FQZdtVH2xrcSrXMTOe59fFxrHz6TFZQkXPOb8qqNdtfGrXApyMjkUv/PvA+1oSYODay84LaNK3kwjUeNSbkXV+9Mrk7L/LO0FJd273NCwhTGpXnwNAh8HBBuhFu871e2+fHo80ViigSuEoCH1hNT/YjhOz1nZ4Amg0eg1r/mdnvidGwKJenkgiRGOy61kYAZ2orkjwsLyOFsKkt1OAYwhGsq9cr1M9pTZxuJsANkp+zEYXDddTRWPUtFCLtU8NAn6QCXsJXn/OY5Xdho/mdfiRsy9zv23mGLY+XX0d3TaC+cT3n3+cZLAvA5ZQSSdQwXcukxDwBPOBX2mp4GfsK8L06hXNTlXfALy/snS5BeFkozI5Z4PBGaZfGUQp1VW0+OiAGfNOI24UWfw4TeSuj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5661.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(6506007)(508600001)(55016002)(38070700005)(7696005)(71200400001)(4326008)(33656002)(86362001)(53546011)(83380400001)(186003)(122000001)(54906003)(26005)(52536014)(7416002)(76116006)(66446008)(110136005)(66946007)(66476007)(66556008)(64756008)(9686003)(8936002)(316002)(2906002)(5660300002)(8676002)(45080400002)(14143004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?f9K7ngj3gBzIsnBAHhSPA0FZZC/M6fIhzbTNf90rsrLAE6HJYkkCH0okjzrJ?=
 =?us-ascii?Q?bvpp5uKJpVQhS2A5vZI2ynZvpoToB+06USiNTm7N6gBfFstiG6gwd7++TuMi?=
 =?us-ascii?Q?9Of+XauGLhNUDUSx9u79PvmzOxX4TqYnG8bkMP/DgIq92tvHQOT05gBL6aJ/?=
 =?us-ascii?Q?3RNbXT5I1pQcsP1IS0fIH+7cGfvQPk6AsqeQdqUHMt/56vSiAAIeuS6juSvO?=
 =?us-ascii?Q?Rq41oRaScxK0id2DvToSwGlZwVmIsgXI1N6SxefEttm5b4SFpFGYMv0HGHsY?=
 =?us-ascii?Q?uwBMXENmUhVxI+PboGBJATqW0F0MKAPth/q4oYUJCvockjhjbww5MMV4uIsA?=
 =?us-ascii?Q?aNAj/3xie6cKbD+mbxKHR7NNR8XgM2+TWci6BKLVaB8aL/KW7g8JHb9Dn2br?=
 =?us-ascii?Q?djGUX/XJhzK0wBqeL0eMVsOBA96+z/Y8Mxm5fGCy0Qsu1P1Fii8hUiPe/yjw?=
 =?us-ascii?Q?CiDon9DtekT1ccc8VBqDrbyy2F9MtbH+BLwAWJnx6XZWbZJe2X7A7w6ICF0Z?=
 =?us-ascii?Q?a6n2F0EZgZfYjXTo4d+FjhieACm5Qq7QIdkGBtmSOphor8h36/0G7xl4Y/Yu?=
 =?us-ascii?Q?Cl+jc2Q43d5kih/cD8AreGTUqJHuF1vWCV96BODUQ3WXJhdl0FaHKbC1IgVb?=
 =?us-ascii?Q?twb8ITwdm37jsR3yMNN1fJG5pSwRuRLF4r/dzN5MRVkhP9OdEG82DuA8d3qv?=
 =?us-ascii?Q?hjXBySmadmY2r6lDyDEh5/3v7MlDXpm+oOhifPzeQqKVOHxeC867Qmcs5aaO?=
 =?us-ascii?Q?RSLTFy4RmM1U+ltA0w9Jg67NR/jbNhhhChj5rPrndOoq/HtPmnhs1ScX40o6?=
 =?us-ascii?Q?YgSAZ/D0buTTttaFiwruSHG37oXssFhwvmI4mrGPCkNQT/IUs6POG/DneW6w?=
 =?us-ascii?Q?Q5nxF8Hr6YvqQXAC5nrFKYRxF6oH3TqpMp9iaxu+MfWhha1/m0mqpp9/bfWl?=
 =?us-ascii?Q?v/Lxm3iA2GgJCAEEBuTxzoHLUMpV0tpf/9CFktcwi5CKIhkc7VQfEFLhUNvW?=
 =?us-ascii?Q?bEup023blxeZFzNVpii7T9qtH43HGIqSiClMNVaPFU6ezmbuoXDkasBO9GIp?=
 =?us-ascii?Q?SKisz0F2DUwUHl9/1fmXHZLu9MDWgLJfe1jHFPkK5lQreM0Uhu6I3d6MrOCd?=
 =?us-ascii?Q?WxGWNutnK/CgbH747ZNle33M4M72rFqAXy3+FG4o2vyIqfACLiOOyx6TmHP4?=
 =?us-ascii?Q?PiufnRIocKs+56oJYvhXs+KfTKUJtSFka36r8x+yx0Y3BbGmllYkZmn8OIKk?=
 =?us-ascii?Q?rp1kud3oYigKrF6sal6vo3IJQxTqoJMc5l5dfXMmmU/dTgRoU05MOHBJnUWY?=
 =?us-ascii?Q?fg2rGiN/KqyUEIduKNBuG6mt?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5661.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747e6ccd-6070-451e-fc50-08d981e6e076
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 18:44:45.6368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q0/BkHoICM1o8QWD4+nwgkvUB82pNVtdmpXi1y+6f+A5kNkZ3GN0n+tMYoAdi4JmN3a1QYWoDrDTl9T16pIMjSV9prepR+e2CMRGZ+bfQGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5598
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Sent: Monday, September 27, 2021 9:49 AM
> To: Mark Brown <broonie@kernel.org>; Ryan Lee
> <RyanS.Lee@maximintegrated.com>
> Cc: lgirdwood@gmail.com; perex@perex.cz; tiwai@suse.com; yung-
> chuan.liao@linux.intel.com; guennadi.liakhovetski@linux.intel.com; alsa-
> devel@alsa-project.org; linux-kernel@vger.kernel.org;
> sathya.prakash.m.r@intel.com; ryan.lee.maxim@gmail.com
> Subject: Re: [EXTERNAL] Re: [PATCH] ASoC: max98373: Mark cache dirty
> before entering sleep
>=20
> EXTERNAL EMAIL
>=20
>=20
>=20
> On 9/27/21 11:06 AM, Mark Brown wrote:
> > On Mon, Sep 27, 2021 at 04:01:25PM +0000, Ryan Lee wrote:
> >
> >>>>       regcache_cache_only(max98373->regmap, true);
> >>>> +     regcache_mark_dirty(max98373->regmap);
> >
> >>> We already do the following sequence in max98373_io_init() when the
> >>> amplifier re-attaches:
> >
> >>>         if (max98373->first_hw_init) {
> >>>                 regcache_cache_bypass(max98373->regmap, false);
> >>>                 regcache_mark_dirty(max98373->regmap);
> >>>         }
> >
> >>> I don't see what marking the cache as dirty on suspend might do, we
> >>> will do a sync only in the resume step.
> >
> >>> IIRC this is a patch that we've seen before and removed since it
> >>> wasn't aligned with any other codec driver.
> >
> >> Yes, it does. There was an mute problem report due to amp register
> >> reset during suspend/resume. and we confirmed that the modification
> >> is effective.
> >>
> (https://nam02.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpa
> >>
> rtnerissuetracker.corp.google.com%2Fissues%2F194472331&amp;data=3D04%
> 7C
> >>
> 01%7Cryans.lee%40maximintegrated.com%7C56f7bb3f05ae4c199dce08d98
> 1d6b8
> >>
> 94%7Cfbd909dfea694788a554f24b7854ad03%7C0%7C0%7C6376835814870
> 22873%7C
> >>
> Unknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJB
> TiI6Ik1
> >>
> haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DU1LZabH5MbrotS976TKK8Rh
> 9nqi0ueRO
> >> %2FxR0obeQlrM%3D&amp;reserved=3D0) The added code helps to re-write
> >> valid values in cache to the amp hardware when audio resume. Same
> >> code was there on i2c driver, but not on Soundwire driver.
>=20
> Ryan, we removed this in f184892613dd ('ASoC: codecs: max98373-sdw:
> align regmap use with other codecs'), so even if this was needed you'd ne=
ed
> a mention that this is a revert and why this sequence is better.
> You are suggesting a change based on an analogy with I2C which is
> questionable: when a SoundWire device regains sync on the bus, it will be=
 re-
> initialized using a callback, and the resume waits for the initialization=
 to
> complete.

I think there is always possibility that amp lose its power or is reset by =
hw reset
pin control during audio suspension to minimize current consumption.
Register restoration process is required for both i2c and Soundwire case
when the amp was reset by some reason.
max98373_update_status () is called when audio resume but
' sdw_slave_status' remains ' SDW_SLAVE_ATTACHED' and ' first_hw_init' is 1=
,
so restoration is not happening. This is software variable and the value re=
mains
the same for the amp hardware reset not triggered by the software driver.
If regcache_mark_dirty() is not called, regcache_sync() will assume that
the hardware state still matches the cache state which causes the mute
problem here.

>=20
> > More specifically what it does is make the invalidation of the
> > register cache unconditional.  It doesn't really matter if the
> > invalidation is done on suspend or resume, so long as it happens
> > before we attempt to resync - this could also be done by deleting the
> first_hw_init check.

I tried to delete the first_hw_init, but it didn't work because
other status variable is also related.
Calling regcache_mark_dirty() is needed to solve a synchronization issue
between cache and actual hardware value during suspend/resume,
but it was not called.

>=20
> Mark, that's exactly my point: if the amp rejoins the bus, we will
> *always* mark the cache as dirty, before the resync is done in the resume
> sequence.
>=20
> I am really trying to figure out if we have a major flaw in the resume
> sequence and why things are different in the case of the Maxim amp.

Maybe other amps were not reset during audio suspend/resume.
Even max98373 was okay with the previous gen. Intel board.

>=20
> Instead of changing the suspend sequence, can we please try to modify the
> max98373_io_init() routine to unconditionally flag the cache as dirty, ma=
ybe
> this points to a problem with the management of the
> max98373->first_hw_init flag.

max98373_io_init() is not called because ' sdw_slave_status' remains
' SDW_SLAVE_ATTACHED' and 'max98373->hw_init' is already true.
Removing 'if (max98373->hw_init || status !=3D SDW_SLAVE_ATTACHED)'
condition in max98373_update_status() function instead of adding
regcache_mark_dirty() into max98373_suspend() can be an alternative way.
I think it is all about where regcache_mark_dirty() is called from.
The difference is that max98373_io_init() really do the software reset and
do amp initialization again which could be an overhead.
