Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86FD13F8981
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242817AbhHZN61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:58:27 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:35437
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242807AbhHZN6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:58:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDwmEH5S0pzGW13uKhBe6mofccyF9pKv1Df8b5/92ImOKKWHDRXm6lD1EnFckUGL6z4DcH7X3322awU2ok8i4OCWUPsKeWJIfoGv52ajk8RzmMMQxmnsoulpPniAXuc7tG58WtB/MjuIcw+61RaZOyJJH3YfqDAhBH5MohCry7SXjwTPbWrbqBXow6V5uBsL2jnPzpkfEAAiDNpKVe0VtddArUaM/J0UYv4/xUzM3EIuoZHogz8PsHp9Y1Zb3eWcTZ1Pus9O2+AVjMtaS0DNhVZiRqg1tUaJ6Ei0AmFbsabrwKyZ/Hy/SbnwNndW9qMHGD7zopt+gHdCtxqcA9hqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfJ4LI0rnOqH/mMKbcNgvySKxaxi7Cv0Uvs2i1Uc3Fs=;
 b=AFiU+J5wwH86xAYZEmpcGl3zysY/tRRgk89ryyxn1yIhKPdU5sJ2E9sCidkIZkLh1zHYXyLhyrJFU9dB9wqBFPLOTFOuTXV2Yg8BVVkstLaZrz6O7VkQSZ88BKYWUr/bRVqA+heFmEMJ7Hk1P4HpicAJDS+vSpL5PiL/gZPJGd2oz+OcsTwAEiRNrQ0tArsEXJzXMXECx9gHw934VRqLfs1HSRfUGH+cbmffDGxFSmWREFLNaOeFk8D/rW6Uu8I+1Ss0g19z4TZlLxI1MYtB1xJLKVHOTp+WKcEFa4DaNdT2HpmiG6SyQ1qf0YEVUJrdRWCrvI2j3EjotHic1PbWeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfJ4LI0rnOqH/mMKbcNgvySKxaxi7Cv0Uvs2i1Uc3Fs=;
 b=nYoLqQgWKjtSHuJYqAYCF86om3EkHlJbPtmhtw3MrRqMOk089Pxww51fYJFHlxGkde2W0sV5pm74l7XQoDseqV2gbhxO21ZAXOf+Az6lIaBShGuP+1OyH5/edYGdMKkH52ylVZ6ex6kIbIQMsuTu0/3CKUTzFGZ0Jk94TpqLflE=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VI1PR04MB6272.eurprd04.prod.outlook.com (2603:10a6:803:fe::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Thu, 26 Aug
 2021 13:57:27 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::109:1995:3e6b:5bd0%2]) with mapi id 15.20.4436.027; Thu, 26 Aug 2021
 13:57:26 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     Vladimir Oltean <olteanv@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Biwen Li <biwen.li@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] mfd: syscon: request a regmap with raw spinlocks for
 some devices
Thread-Topic: [PATCH 2/2] mfd: syscon: request a regmap with raw spinlocks for
 some devices
Thread-Index: AQHXmfLpAPY5dWz5nEm89cB8YD+1YauEu2IAgAAJ7ICAAL8dAIAATEiA
Date:   Thu, 26 Aug 2021 13:57:26 +0000
Message-ID: <20210826135725.lrn2afoekxzzvtbf@skbuf>
References: <20210825205041.927788-1-vladimir.oltean@nxp.com>
 <20210825205041.927788-3-vladimir.oltean@nxp.com>
 <CAK8P3a1oDeU-S5dLqKTT3YFvGREvNt_a=PTkVoDhUJYquJGePQ@mail.gmail.com>
 <20210825220023.rqskspy2usvleoqr@skbuf>
 <CAK8P3a3FnsWbGRU7BNc8uwt0nFAHa7K4c+qpoZixwdW9kihC5w@mail.gmail.com>
In-Reply-To: <CAK8P3a3FnsWbGRU7BNc8uwt0nFAHa7K4c+qpoZixwdW9kihC5w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de51832b-823f-4bc1-0140-08d96899701b
x-ms-traffictypediagnostic: VI1PR04MB6272:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB62726D4964ACAC894A8DE64CE0C79@VI1PR04MB6272.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gNZAwWHS7ghcmU5+wsnDShx/z0x0rLRzltK8Fm0ydcG0iZsRFBy+6oSxMcvxe+0PaiYSmXBWGLUTVF3VVF39tsALZ7VPmVGgOvkDOz6sGb/Entfi7IdPVS/SlJKmuRBQJ1R1xAAZNLy6T68oJf4kFqMUTfpGqs/HDKi21eiraRkgXTLj7jiYpKct96ah4hP3ZeLDHfHuoFgzs4zmjZVbwxpA5vYVUTP6HCqS2HIyziXsMPXqI5l5LuN0oxMi4XnNK3oVQxTi/k5AEbi2USUaGrHTooJOWWqoVtFMWMgbmhZqwwn8AvN1UoYSPwYoM7Q5HpbWX/yp8YXHeCt5etOLHhvf1zH6NDdDYSa4O2+xcFwtOa9RXbPVPhnf9hMF0MMw1q5kQUWF3UqkO6d9j9bD128cQx0pIxLLsI2T+JaMXAqK5KqVR06OykV9xQyHu0Cr8yxsXmgXFBCsbFwZWcFHLa8Yso3rpbUu7Ud4tn4N3in4q16C0wv5pVfGgqAkYSs7q5hADq4xdUZKo6CDXyOexYS79Wj60z/NwdF4eNDv4XXnlmfXtQvaXQBhgrHYcPHAJfP+U1f2UwkjeiPDC1aTG3dTvDsruyPbrnIfxVLvwp6W1aFUyxh+Fxbjb8hwivmTnrhStaud3y+Tb5upb4r45zwciPZPTN2vzMVeaoOJth8lcVG4BnjFRhRtjutce4lD7aPFJ7yOCSkciS8nw4Uyhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(91956017)(53546011)(66476007)(66556008)(66946007)(64756008)(66446008)(6916009)(83380400001)(186003)(6506007)(76116006)(71200400001)(26005)(66574015)(6512007)(9686003)(86362001)(316002)(2906002)(6486002)(33716001)(4326008)(8676002)(1076003)(44832011)(7416002)(38070700005)(8936002)(38100700002)(54906003)(5660300002)(508600001)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?McQHMraMzsWVPDgtBwN6td2KEGM42SeHcKQfov2HxDmyRoE7tz4PM6XfkAMh?=
 =?us-ascii?Q?dIX6+e6u9aovbn+t1X+QYaKfb2DNomc3NmIBDMNqPeTo3I1bnwGBgIO/tQJ4?=
 =?us-ascii?Q?a3X/T4d+5DU/J/uqcbSecmP3hoTaXJgWhUvR7eQzGBtJIqysRtDhlbsaWnpl?=
 =?us-ascii?Q?y0lIUYPuCtcQ1TAktXXF+FC7TOPBpk8OfJiCXUwiEjmGvWQmIHhSNX+6qo6O?=
 =?us-ascii?Q?7HANSVrkI+0eP+0jseSa0ABZFHbgbP7S772tVw60MyVuJsXjoZf7dCSfjCqS?=
 =?us-ascii?Q?yktOsFsBDalHVadiADclnubYx26U8y150KpOq0+AjDWpnHXVBawKDQ3l2eik?=
 =?us-ascii?Q?GNlbtqIZmdc7uAPES1GuHM9NYXMjI0NW2gOiPZjZ1+/ReuWRdxJt/OXZ5qG/?=
 =?us-ascii?Q?2AN4WEEgU9qkTIkav7y4tQQO+nIPnU2cyvZS/5aeWumBYINpdpiszdwi1LnK?=
 =?us-ascii?Q?jDd6rQgl4DEKQJX800UEvBTbiVG2qVMsiGB24ZCMmi/1ZQ7pcUdqv6xF6seb?=
 =?us-ascii?Q?gSD+jIV4ikgI4kUtO+PZwZz7BbcItEHuTyFtS163oZiV8qg5GuR+uzOm4uAa?=
 =?us-ascii?Q?WgQ4/6qDJMhvh3zbXASYecAKi8P5Pbpav6Sc+9hLQ7IbvVlqZPLu5WVOISGp?=
 =?us-ascii?Q?qeH+oFZbyggdo/Zg8NtOLLrn2RrYWgiDSBrkv9/1dXJ+qjG5mXPg2trgd5Tm?=
 =?us-ascii?Q?Dbu6ppswLW/Dw3AWOM4sBobslszNkLEkwjZVO9jdnWj6WdrCPmSHY/MvfKmT?=
 =?us-ascii?Q?tB1RgZfLITi14vKpkLkGG8dCv8uu4tTUl76fgJ9UlJ6Kms5Aa3Vv1kcfAhvY?=
 =?us-ascii?Q?He3k7ALt0Bj7Z7/fybSbsYw40qxNmaIaTbDPNk87RaSekW6xee2RI4U2Bjtz?=
 =?us-ascii?Q?0iX0Xgg4LAAz03KDPZZ4W7UCPcmP+aVX4E+LWbnF9qeupWCQz8OkPAmkZ1tf?=
 =?us-ascii?Q?VOvxxcEe30z0hGxS1UPUfdK3fUlR9kRQoh93PX3JkWmBo/3YcZkz5KN/+sne?=
 =?us-ascii?Q?MvNGEL+x4AKQUP3sCAn0HzIZ9OTHinKaE8FyqBq6LKnFiOiFyd3UPR2PNF+o?=
 =?us-ascii?Q?zn8LkoVFR1RkbhJ2WKAmpB8sv2YjRVCRkMlQQaMCg5YIv/Rb79DRWnS/l12+?=
 =?us-ascii?Q?XZXRM+VewQ5k5Rxj7cG3CLjEnhrNwec0lhUbjDJLeZDaguBIsUJPsCJs02Ey?=
 =?us-ascii?Q?9mifPIziCAIE0h7/jbHlvgBvNOP7vR4pt1rCUeeVgOxdZzqKDzVWtckPSwcr?=
 =?us-ascii?Q?fufRyEsSqVzYUJFluL0TQ0cMT7DsoqXwR8dfp4NuTdW9MHfMwTH6QD9MFGX5?=
 =?us-ascii?Q?6b7HALRSxAvbbF+1YZcDCEVy?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1BDB2359C35C45418DA0715C935B99D6@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de51832b-823f-4bc1-0140-08d96899701b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2021 13:57:26.7869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60fG29acOGwpliNLTnzLf7UBbyPMVRKWX9Srs7kwLvY04qJXee+GYk4We/z4KSzfpLSZ+/7T9yHCU3/0USEk7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6272
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2021 at 11:24:24AM +0200, Arnd Bergmann wrote:
> On Thu, Aug 26, 2021 at 12:01 AM Vladimir Oltean <olteanv@gmail.com> wrot=
e:
> > On Wed, Aug 25, 2021 at 11:24:52PM +0200, Arnd Bergmann wrote:
> >
> > > Are there any other users of the syscon?
> >
> > Not that I can see, but that doesn't make the fact that it uses a sysco=
n a bad decision.
> >
> > For context, Layerscape devices have a "Misc" / "And Others" memory reg=
ion
> > called "Supplemental Configuration Unit" (SCFG) which "provides the
> > chip-specific configuration and status registers for the device. It is =
the
> > chip-defined module for extending the device configuration unit (DCFG) =
module."
> > to quote the documentation.
> >
> > The ls-extirq file is a driver around _a_single_register_ of SCFG. SCFG
> > provides an option of reversing the interrupt polarity of the external =
IRQ
> > pins: make them active-low instead of active-high, or rising instead of
> > falling.
> >
> > The reason for the existence of the driver is that we got some pushback=
 during
> > device tree submission: while we could describe in the device tree an i=
nterrupt
> > as "active-high" and going straight to the GIC, in reality that interru=
pt is
> > "active-low" but inverted by the SCFG (the inverted is enabled by defau=
lt).
> > Additionally, the GIC cannot process active-low interrupts in the first=
 place
> > AFAIR, which is why an inverter exists in front of it.
> >
> > Some other SCFG registers are (at least on LS1021A):
> >
> > Deep Sleep Control Register
> > eTSEC Clock Deep Sleep Control Register (eTSEC is our Ethernet controll=
er)
> > Pixel Clock Control Register
> > PCIe PM Write Control Register
> > PCIe PM Read Control Register
> > USB3 parameter 1 control register
> > ETSEC MAC1 ICID
> > SATA ICID
> > QuadSPI configuration
> > Endianness Control Register
> > Snoop configuration
> > Interrupt Polarity <- this is the register controlled by ls-extirq
> > etc etc.
> >
> > Also, even if you were to convince me that we shouldn't use a syscon, I=
 feel
> > that the implication (change the device trees for 7 SoCs) just to solve=
 a
> > kernel splat would be like hitting a nail with an atomic bomb. I'm not =
going to
> > do it.
>=20
> I was not suggesting changing the DT files. The way we describe syscon
> devices is generally meant to allow replacing them with a custom driver
> as an implementation detail of the OS, you just have a driver that binds
> against the more specific compatible string as opposed to the generic
> compatible=3D"syscon" check, and you replace all
> syscon_regmap_lookup_by_phandle() calls with direct function calls
> into exported symbols from that driver that perform high-level functions.
>=20
> In this particular case, I think a high-level interface from a drviers/so=
c/
> driver works just as well as the syscon method if there was raw_spinlock
> requirement, but with the irqchip driver needing the regmap, the custom
> driver would a better interface.

So basically you want me to create a platform driver under drivers/soc
which probes on:
	"fsl,lx2160a-isc"
	"fsl,ls2080a-isc"
	"fsl,ls2080a-isc"
	"fsl,ls1088a-isc"
	"fsl,ls1043a-scfg"
	"fsl,ls1046a-scfg"
	"fsl,ls1021a-scfg"
and does the same thing as syscon, but sets "syscon_config.use_raw_spinlock=
 =3D true;"
and that is the only difference?

By the way, how does syscon probe its children exactly? And how would
this driver probe its children?=
