Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77972430EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 06:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJREaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 00:30:16 -0400
Received: from mail-co1nam11on2135.outbound.protection.outlook.com ([40.107.220.135]:29249
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229589AbhJREaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 00:30:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XeHZ2Z9IiZ1ykmOOeszGqRzxQ3ejNJ4itNR9OLbjGmvPJNWsYSqGo+9WZO+WW+MBh652r96z1kAlWk+Yse4IzW8FJU835i8KnHt7avfJPounmHzstFvZ7WZyOIMIOqGAKeD+5zLEAgEkjOSVIiDukzptxPudKvLHvLbPYfisThhzziuGXVwqNAlAfSFj7mSoIa6I/+ijyfD08NLDVxNLyfq1sNiBS7Ep79XbmiMMPbVFNf9CtdIRroZ40k0ZMU0/mza/c3mKO05iPVTMOQx0KNkPLtAe3FyRxOXh1TOEM0j4wZbyKxnnkdrJq0465HoS9vq5xNu8n/A8i1mF7Y2KEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFibBbwC9OXO9CmAIv8TmpN9dJyrTkVB1TMRj5IHhIE=;
 b=PAmdPzuGql9TfQymm1GaWJ4ixO0XphLg8DpRBHgyxL5ABtE4cjbYZrzvGN8MUhIIYSWnvGRW9TztPFu7alOi/tDyehuhPePMvLhC7teR/3HuHnG31dcMpTynvIr+H/DuhbgE1bFuRGsCxqcZ9A/lvbQWqdQDNDcxxvo2MfvGMnooeSqTKJhdkrvZNB58JfOcP7QKuZEuDzDvsQWlfeWwdQVQPq3ruK1Nx7lqkicfc6EGJcKSh97aEhUHUbdyp4ZQrqVxFNnyy50mbIKbCpAPWs0XGwUynJTuT8sHcNK/uf2lewVF/QXwfDouaK+l5XakoQwh1cEOc68bqJ37GUdtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maximintegrated.com; dmarc=pass action=none
 header.from=maximintegrated.com; dkim=pass header.d=maximintegrated.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com;
 s=selector2-maximintegrated-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFibBbwC9OXO9CmAIv8TmpN9dJyrTkVB1TMRj5IHhIE=;
 b=FHyGPAIhP78SwikvGFdTY+oqgn+Kn1j5SIscAAN9UbLHnWkUPR9CLwWXoZZ6DvhUJm94JN1kPD1LKdDO3qxXokdVzYvdjfmmgDft8gYDQzuRaJgiZP5Jv2s2GcSRzjw9dyHBqaVM00mCXlouepxnXZQx2WiazivJKsBjkk9bORE=
Received: from BYAPR11MB3671.namprd11.prod.outlook.com (2603:10b6:a03:b3::15)
 by BYAPR11MB3479.namprd11.prod.outlook.com (2603:10b6:a03:1e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Mon, 18 Oct
 2021 04:28:03 +0000
Received: from BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94]) by BYAPR11MB3671.namprd11.prod.outlook.com
 ([fe80::49d4:a1dd:5b55:4c94%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 04:28:03 +0000
From:   George Song <George.Song@maximintegrated.com>
To:     Mark Brown <broonie@kernel.org>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "george.song@analog.com" <george.song@analog.com>,
        Ryan Lee <RyanS.Lee@maximintegrated.com>,
        Steve Lee <SteveS.Lee@maximintegrated.com>
Subject: RE: [EXTERNAL] Re: [v2 2/2] ASoC: max98520: modified alignment and
 blank
Thread-Topic: [EXTERNAL] Re: [v2 2/2] ASoC: max98520: modified alignment and
 blank
Thread-Index: AQHXwZYe2v0WPMfB7UKNOh7WkmfetqvURqgAgAPnPkA=
Date:   Mon, 18 Oct 2021 04:28:03 +0000
Message-ID: <BYAPR11MB3671C1C3541CE36FD630F746F4BC9@BYAPR11MB3671.namprd11.prod.outlook.com>
References: <20211015072709.3167-1-george.song@maximintegrated.com>
 <20211015072709.3167-2-george.song@maximintegrated.com>
 <YWmxmBh7J1x2SaXi@sirena.org.uk>
In-Reply-To: <YWmxmBh7J1x2SaXi@sirena.org.uk>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=maximintegrated.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38f6acb0-b5fd-4649-29c0-08d991efacf5
x-ms-traffictypediagnostic: BYAPR11MB3479:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3479EF4FD84F4B13E831433EF4BC9@BYAPR11MB3479.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kTM941J7UB5n3wDX/Mc19QEGsdnXrI2mrAish4IocBN87kOfK1MSsN5/wd3WF7nKUBhakThG/mQFyCZEf7WJddu8nW04zzjyabsax54G2kHfH7QJZO8431uo+zMj8BPAkcV2JvjK8g7OD8Y32jIgxC3YOsGkC2aB6Y46sLq0Tj4/bGNjw/WmAodDSfBc8ye2vgYsbNFtykhrwypFsHKQidj2Kc0gntnFSdwq/toojF0gjeM7JGzqHteAZEI4Yc0nL1cbk4zBIzqtmMBJd5wfFpxwegO6PAQHQtUmpqSJ1uqlrBfS68KCouvsIHnMk3AJJiYzIgH1Hv3lS8b0M8AiTHDegH90SbVaAHfFU7GQEe83IQ+Y3PuD2YMOroGa02v1EpYTq1z/MfS9o0274VYaMi0qjcmy6P7Zfdavti22X2wVYjT5ZxD5eHkN5sou18VxmdS9TxjL4wNnQLPOmA7RJeH/UhT1obCXRPid4gS9l+VoLrGJXS4m/21b/Y0Vf80fXbYU7j2ow006vzNbPvON1/GTm+EDwoFvLFRfkAp4ipJ3rJsuyR+sjfL+zaDboFu2RQbPRifmpbNqYivwSXyT4MpWVWl3ZxRrjRbJR+4oS8r1j8XbwAhq31eA0t9tGCPyBTrQ9rOQut+5n0mUypWgWCTRYcm2lVtk8njlfFVdfhWUtpcYPUG6zaICMEj2WIJ37WmA3AGiLpGnWJf9td00rQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3671.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(508600001)(7696005)(86362001)(54906003)(66446008)(38070700005)(83380400001)(316002)(5660300002)(9686003)(186003)(66556008)(38100700002)(64756008)(66946007)(6506007)(71200400001)(33656002)(52536014)(4326008)(55016002)(76116006)(26005)(8676002)(8936002)(107886003)(2906002)(66476007)(4744005)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fXngW8g25bfDFdCFZJ4yH1fEHhBea1t7KOpSCvyKiMg9OeYnjU4fMe1Pnc25?=
 =?us-ascii?Q?lwc2wvBL+GKXkxMzLeQwK9743TAXHhqf+a318ldE/k1bjYMc75cOL1cQp4qo?=
 =?us-ascii?Q?YFNbtRKo7G97ExrUTOlLUW6KlTdZgBVvg6U746tr0fORg8K88HblwW4J075D?=
 =?us-ascii?Q?POiBSKI3Ye3sMccEvg9TDuxZ9sFtx9wht5pQnS+IjdOaR74BJvjymgdhZxhq?=
 =?us-ascii?Q?OLATK+/XtFOCuPGo9bno/qKG9TJYmiGkT0PBz9Uj/41JfYDbpYRDXCNNHkAg?=
 =?us-ascii?Q?yLTrNX7uHD2o9ecaCU9O8/+Q4nV2V/T3orIPK6je1w8Inv2CU9D3O1QsfmyH?=
 =?us-ascii?Q?7cOZ21r5jSaAtbgN7vdnifE0yPY59PFB0Tx8DBQfgMUpLjjWg9B2eEuNmbt4?=
 =?us-ascii?Q?ub0vv7PeKqxpdg6kIuyg3YmnGUwtacPtbc6UU7y4jbtc2yWeNFfJ5AxnZXD/?=
 =?us-ascii?Q?2CFgqyejm71xDtd3TNgCYxBy/GmOhYGsvaGmiVJtkBcfE9UoW/o/MfNKB8bw?=
 =?us-ascii?Q?bBtEp0ZTzpmlzAd1kGYcHx2VOUImSPXhzHBrfjIUoaednuDJsSdwrEcwIUS5?=
 =?us-ascii?Q?btIbNDX2O0bChaOn2VQ/PLdU3z5Npu8RXU6xeJKy1sKX6pH6/joxgZUJ+HKf?=
 =?us-ascii?Q?5yICY0TWRCukZm3qw6RADVETno2dBtm6wRdJ6pqRivgBtQyqN6vc+ilFdkp0?=
 =?us-ascii?Q?SkDyQ4L0gSmn36gnDKts/nA3FXSVGDhp1xlxuDVV0/ZmYf0TdV5tQVmcWA/4?=
 =?us-ascii?Q?8hNvqFDihcjLqZDJDFLVkdYeaB7zvia8VULidb3Sn/EIkHyH2ICcfNTlAdXn?=
 =?us-ascii?Q?dwn4Ink2EK0UJZS15LHC79cR85/bdyD7US3f92BYD1XIxFXwvCoN3NmSUUuV?=
 =?us-ascii?Q?tOhETZyc/b2NJ35NccD9ey66o+elF5SF+2zL9DVhfZupUhrxjdvKKVcf0SM/?=
 =?us-ascii?Q?umWxcL+hlxrTrdsGKtvGLyepBgdtlnBI6g5xZiJIe1xYwdB2YDA2oCHNHcb7?=
 =?us-ascii?Q?k9ONL+FHBwFRGxDjdGCJImwfThtbsO/9QKtDGfl2GjEovRGlYzkA7SuPiK0l?=
 =?us-ascii?Q?Fh9hCINIvxZcI2XglmC2VmPHgoXoB7/y7RN5jiL9JbqjTi59AGdmxQKgCwZQ?=
 =?us-ascii?Q?5M92sy0+gB/AF+4VXMt8KzYkp7hA87TcpYOZApOMnqkm+G6wOF38KksuWhOQ?=
 =?us-ascii?Q?YsU0pZvmBnqWYERLs38y42u7jT/FbQGYLOnkPUkmTH/iphZwwTCiK/DKnx3y?=
 =?us-ascii?Q?tMDCHTpY+ePTQi4/r+9lxEEirTrjhqAX9BkmWUEsUwREO8R1wcXrgo/Uf4nd?=
 =?us-ascii?Q?a5PFpFiC0P73Xv1ARDAm9VHr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3671.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f6acb0-b5fd-4649-29c0-08d991efacf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2021 04:28:03.2926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YoW8u1qwrUDXtpKVaQiGsalJzG0S6gtQzbhiOCEg/iWTqDckUfTMiwCfF1Sw4GX83LnNu524RQQD4FIBv+DKUj6NzMk0IdI2XEdnMmnLcEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3479
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Oct 15, 2021 at 04:27:09PM +0900, George Song wrote:
> > fixed all CHECK and WARNING for checkpatch --strict result removed
> > MODULE_AUTHOR to make one maintainer.
> >
> > Signed-off-by: George Song <george.song@maximintegrated.com>
> > ---
> >  sound/soc/codecs/Kconfig    |   7 +++
> >  sound/soc/codecs/max98520.c | 121
> > +++++++++++++++++-------------------
> >  2 files changed, 64 insertions(+), 64 deletions(-)
>=20
> Looks like the same issue here - squash the fixes into your original patc=
h
> and then resend that as your version 2.
OK I see. I`ll re send patch including whole things.
