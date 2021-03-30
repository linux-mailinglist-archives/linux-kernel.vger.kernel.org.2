Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2B1934E77C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhC3M17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:27:59 -0400
Received: from mail-vi1eur05on2044.outbound.protection.outlook.com ([40.107.21.44]:42464
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231574AbhC3M1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:27:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNj6D8TZETDBAJuaCgLUWgyiy3WZCVn5qtfslUoCWObxL+le+o7UG34uberFIUqH7FCGBlAVdRExVosXfEoUdWeRPXwXEdTA8BZ5d4wskfzfBk4Szq7RYXNX3iTf0I2GGt14YOolILfxkdZ+3g1G5uLcZHf3ZMPeJ6/uZBbMGG7+DPRFqeYdbm1scmYp+i+lzhh7qIbSEeWvvu6SyLFkh1tKiZuG8pGjt47a4090cqXoTxGsiWdu9qzIlsPgpI1Z9+TkfGazBpMehyy48tDTwW+dscYe8O9ZlBEFYHqTjpGsaeQrOHZOHHSh6p5muBgJGT9351AMm2CNdkgXnrExGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5s6WNxi2j1rEpnkA75JipgiK2/0KbP+M1STRrNyPgw=;
 b=KWrGvPDQTyXkEMayDThQKSXQCDtLU6fIU20epSGHk+7uFzGcYiMql8WT8/j2o836xKP+KZ2lsbo7DskRNPCQrnHdxKlT1eV9lZW9NjrHggsvZEbjbrOpzY4hwClcfZeOcE6jr96Zo97wIf9BrrIZiE/TdeEO+nEqzOAEd5ai05/zvf21jMSS0UkzfpQ3bIMmolAeoSANeGwzFOC82lU7ZEFLSO9EtQnKMZKwpc2l+727CVqC9zl6mb7CO+baHBV75601imHFmWwP/DzvGmLEmAOaOTRKG91bo0hrLYXd612pf+AnKO4HAzJH6KZPgx+/dNE86PwLZ9OPx8CjL4NZ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F5s6WNxi2j1rEpnkA75JipgiK2/0KbP+M1STRrNyPgw=;
 b=Ticj67BGoLYsZ6JCvzRocV8MD84tucBypIh6KdJkCacZpCYBORtqcx8FWYJ5R7bXClYgd57wO2Cq0DWKxjkDE1BTd+WLis/Y+vUOmPngUgfifAfI+sTJwAeyqj3LDU534+gW3v2wtnGJ6uEYobA/5Zj+P4eJ1TN2bF+t7/WTBXw=
Received: from DB6PR0401MB2407.eurprd04.prod.outlook.com (2603:10a6:4:4b::7)
 by DB8PR04MB6666.eurprd04.prod.outlook.com (2603:10a6:10:108::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.32; Tue, 30 Mar
 2021 12:27:44 +0000
Received: from DB6PR0401MB2407.eurprd04.prod.outlook.com
 ([fe80::8007:e187:6f31:719]) by DB6PR0401MB2407.eurprd04.prod.outlook.com
 ([fe80::8007:e187:6f31:719%9]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 12:27:44 +0000
From:   "J.d. Yue" <jindong.yue@nxp.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>
Subject: RE: [EXT] Re: [PATCH] tick/broadcast: Allow later probed device enter
 oneshot mode
Thread-Topic: [EXT] Re: [PATCH] tick/broadcast: Allow later probed device
 enter oneshot mode
Thread-Index: AQHXJFwPSAAuVzz//Euy01jdhbmDC6qbeTUAgAD2wvA=
Date:   Tue, 30 Mar 2021 12:27:44 +0000
Message-ID: <DB6PR0401MB240701FC5686C984D74AE0F5FB7D9@DB6PR0401MB2407.eurprd04.prod.outlook.com>
References: <20210329052555.24487-1-jindong.yue@nxp.com>
 <878s657j7p.ffs@nanos.tec.linutronix.de>
In-Reply-To: <878s657j7p.ffs@nanos.tec.linutronix.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [117.80.152.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc2fd50a-4420-44e3-989c-08d8f377384a
x-ms-traffictypediagnostic: DB8PR04MB6666:
x-microsoft-antispam-prvs: <DB8PR04MB666644C1A8674A4AC4212FBDFB7D9@DB8PR04MB6666.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UbX2PhWSGjnzWD7JFUO1IYOtXvGzQELmV0U4nLCJaU2Kbd/7tpdbCIlvPv8MHSBlNKWuITmC0ZV4ScrLjOPO+sGgKZRddM/kW/C0muTcI4rE63mg2Yu8xzLRuqYNsWD7ZOtde2G3XxiO+yPMZZMTXe0m6UasNJAwlYDvLgbTzggm8f8nlcucnTK9hstli6of9lSyFA2F60mzHpmVoKS/gIdwa8MpyzLgS32ovtla3fg/SJuaoCMMrQb750ScylqQHPVeSp7WTjdHo7hyiMvs7kOcsfgEyDmcJ2dD3tU3BAWW7i04HLzzp1h1PIUrbRgiqmGGmlIWDhU0p8jZegWR99mzhTfkEKkYWW1grfY381cFMjCor41YSCPsOAm/juAIeQ+z4IdYGlX1eNRRimGTLwAw2g33q/8w4pUugs37zD6s8iRfRYhqRJWhLD/U8xt8thcEoDhbqR3nKdxmmOoYNX7QXaCn/FlJuGKIEDQTTzxsQnQZzHy59QjqAhJe9ZrEvPwW+B+govZt06iEkcqS/bqys7R9u0kNenY12+Kb+s8UBTSMvN6p+uT6LEQmoHcdv9/9qhQtrBgUy3tIc7qYRxMDlT7lJPGgnF+dFtSGPzzI86sMh/wtawn9C17uuJES+Q1689BIMpIujCuq3LabTqasOF21Bg1TpVsWwoLbGck=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(478600001)(38100700001)(6506007)(5660300002)(186003)(54906003)(66446008)(7696005)(53546011)(52536014)(71200400001)(4326008)(26005)(9686003)(83380400001)(55016002)(66946007)(6916009)(8676002)(316002)(76116006)(86362001)(64756008)(8936002)(66476007)(66556008)(33656002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?IQrR0y/EaSX7Z2LIvpIyd+Ke3NgkaSLoSHJKHAZwNVrlfYF+k97hzpzQn0Wk?=
 =?us-ascii?Q?HQVQoaVG3G8BRE52zQtPu1vLXH8/ehFrxGNriLKmxnmFaVq70jdNxD8KsbnV?=
 =?us-ascii?Q?FfAkkVfasc8D80zS8GdPKzPQRtt7OoG0mPfHejg6nTWoNwlKXyISRVhXhbMT?=
 =?us-ascii?Q?E5xAz7SkbjlI+64yHURTGWKXFvLwwbblCaJtyfPw0M18MTorMoAr82BCPgXk?=
 =?us-ascii?Q?43xHU4Yurki+JqsQ5q1Angg0ucbiObLl69E1li0psnQX3HKYinv5YZj809a1?=
 =?us-ascii?Q?z5Ct4BVTtsantOM1Z+PojNyFmyhGbp08ze+Puob+wpHuSiDFV9JEppB9tKZw?=
 =?us-ascii?Q?wnQLRJOIJd5UCw+dz/P8IqPJeVeFOvTbAzuPlf7FWf3s/9IY6UIwwP/31jgV?=
 =?us-ascii?Q?4W4upgfmkrxF/QVHWknn46laPMLXT0RjfgVBpabpN7gUB/smdWso6TRURtaR?=
 =?us-ascii?Q?y3i6e7ILfYQABmHg74GVry4qlWoAkI5hx5sztl/nHs1/HSubGFsLmOjySS0c?=
 =?us-ascii?Q?BQHGFHSqBoupgcM2tGsBH5mXpz0NHaQxowyLWoO4a7ZjRc2IMfx0oCZ629dk?=
 =?us-ascii?Q?OMWC/Ogrwrshz3YWvF3nxSP8h+wYsk6qaxda7j97odVwg49rzuy34akj00Qs?=
 =?us-ascii?Q?wldsHACmRU9ymdUrswrnwc50b2e0phy3Nc8bDEZCdk50cOVcw+aurxeHxANS?=
 =?us-ascii?Q?dTgDC18sy8IKwNPiOxEzTJX8Yghhd7dx71hiDi3D2czl3v5ARnWAoOsSokah?=
 =?us-ascii?Q?VGpkr71PHHycZGvYKwRteWNu57IVmG/owBooUM88CnFN80sBqAvTS59pPvm3?=
 =?us-ascii?Q?TWIJcbOD8ZyAY7gT9UAoq0N6r8vgeSN5YN0p3YHzjvPu7xDdj76gESu94be8?=
 =?us-ascii?Q?IoIkQ/e4FkwCjUQnhZL05YwVhooft0JHl6+9OqrluzyvubKgoQu6YUaHZobV?=
 =?us-ascii?Q?s/f1loAbi3LR9nztVMUQoAqS7rtd+Fg+2XnS7LavYv/iLaCMk0D5S+SvZtU3?=
 =?us-ascii?Q?ssAd6jNn3tSzUVg+SfFuI4YWJSstag+fqoBN+L+Njw7MshF+RC/Uz8O40yJx?=
 =?us-ascii?Q?Rrf8Z5Ftb28y0h+rR5LmRC3ZFt1ZJ/l8NxQT3Y0HDt8dDDuD6jlRIHiVJxjF?=
 =?us-ascii?Q?fcHscsrt/QbbmRCDhbQYo8ktuZVBGLqq2Et+1U3OWUL9gTT8FwYAvbhGvhzb?=
 =?us-ascii?Q?jitSvsXZ3SNPmwdvAm0ZOs0IxpvjEJl9Ntth6aMY0yCekyEgkaRm1jxGKv+K?=
 =?us-ascii?Q?KqeZ2Z4p+OqLhA2bzXo798m2A0acXK+HsSNEL+41kOUhKHHh9x3hGEXQl70l?=
 =?us-ascii?Q?w/tuG0g4oaLLrKt1eNTQ8JiK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc2fd50a-4420-44e3-989c-08d8f377384a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 12:27:44.2686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wT9DymTV5ssKY+JLRyDgnQMJcqcyrX5KTZ3s7mbfymeeESYkWy2qckXs/nbg5z61WcqrO8XgdplzM8Tfp9WzbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6666
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Tuesday, March 30, 2021 5:18 AM
> To: J.d. Yue <jindong.yue@nxp.com>
> Cc: linux-kernel@vger.kernel.org; fweisbec@gmail.com; mingo@kernel.org
> Subject: [EXT] Re: [PATCH] tick/broadcast: Allow later probed device ente=
r
> oneshot mode
>=20
> Caution: EXT Email
>=20
> On Mon, Mar 29 2021 at 13:25, Jindong Yue wrote:
>=20
> >  /*
> >   * Debugging: see timer_list.c
> > @@ -115,8 +116,20 @@ void tick_install_broadcast_device(struct
> clock_event_device *dev)
> >        * notification the systems stays stuck in periodic mode
> >        * forever.
> >        */
> > -     if (dev->features & CLOCK_EVT_FEAT_ONESHOT)
> > +     if (dev->features & CLOCK_EVT_FEAT_ONESHOT) {
> >               tick_clock_notify();
>=20
> If the kernel runs in oneshot mode already, then calling
> tick_clock_notify() does not make sense.

Yes, there should be more check before tick_clock_notify().

>=20
> > +             /*
> > +              * If new broadcast device is installed after high resolu=
tion
> > +              * timers enabled, it can not switch to oneshot mode
> anymore.
>=20
> This is not restricted to high resolution timers. The point is that the m=
ode is
> ONESHOT which might be either HIGHRES or NOHZ or both.

Got it, after kernel enters ONESHOT mode, new registered broadcast device c=
an't be switched to ONESHOT mode.=20

>=20
> > +              */
> > +             if (tick_broadcast_oneshot_active() &&
> > +                 dev->event_handler !=3D tick_handle_oneshot_broadcast=
)
> > + {
>=20
> How would that condition ever be false for a newly installed device?

Okay, will remove this condition.

>=20
> > +                     tick_broadcast_switch_to_oneshot();
> > +             }
>=20
> So what you really want is:
>=20
>         if (!(dev->features & CLOCK_EVT_FEAT_ONESHOT))
>                 return;
>=20
>         if (tick_broadcast_oneshot_active()) {
>                 tick_broadcast_switch_to_oneshot();
>                 return;
>         }
>=20
>         tick_clock_notify();
>=20
> Thanks,
>=20
>         tglx

Thanks for your quick review and advice. I will test this code locally and =
send V2 patch later.
Jindong
