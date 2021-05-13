Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2180237FDC2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhEMTDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 15:03:39 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:57632
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231993AbhEMTDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 15:03:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBXTmASCBGNjDPgs3Mdavawcjt2uxW1AIFrFV9MGJIIuwlJj9tvmD6THyRSmM5FfRKqjs1bEfySOP4/gl8XBMEQgPWjm+8XDXR4SX1bf6O6gY8j5nBB4Chlli9tmu7bdwNkIIftzX0O4vzM78V1NabRhQKThR8r86t+kFwKAXh101elB694xrlIBHiQwzIDibF4nJoQQpDp1yteJA1vimoMeWE8F8Yauq+RozNuhaPZ3gFJhYsc3/+L/jGFNZErJ9mEntmtBbVnNYuzNEKYZEbtv6f9p9xxOw9lxELgMMvuKydwsBH6Lc5fgMM4dh0uqaJiTmXqoXeaoRiLvMhN7fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf9HApO2tM1ceoGTA23mqhoIqOXlm5olSP5ONBpc6Cg=;
 b=EshQJypnac21AK1DSgPs5UI8pwMcuRSJ1F1y3s+J2nsF/WsUlp1JtCQcGxObmmcNlzm2RT1LiXsnXKlUO5Hx56mi/Ya1kUDHKv27+3h3ejftUVrs9GvjyfS9GIjTKmIQYgrKDi6u0+ZWYNjonio2ElF3edPdgPPo8iV2s5qdIMAfGGlMyUXk9nyI1Cq8JBlZuVL5s3rUT/ZGVolIJr1D8TGE9TbVuJ7vhAIiojgeoZZza0HC/h/LZBqGy9N9BJ4ryBSDBLePcRRed71KTzN6sd0IayPtRYU4ralN3RefBejicwgNF7HvcY8KVhLaE8E0Ye4ex52qjcKLlYti7H8s4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kf9HApO2tM1ceoGTA23mqhoIqOXlm5olSP5ONBpc6Cg=;
 b=mrmli+YIyD2vvJlbUUYtRZV0E73gjt9dXS6D00KIlYATuZQ6GRCbvdrpdG9JbC1ymyzFVbVz8nkxRHsaOxqZG6/A2dfEEi4vMpH+vGMfeStm1NOVzYULH5AZ371iiRnoRtenjYtZyxgP0lQjCjZxd/pJTkPvKQF2s/etBiNyFPI=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4032.namprd12.prod.outlook.com (2603:10b6:208:16d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Thu, 13 May
 2021 19:02:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Thu, 13 May 2021
 19:02:25 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     =?Windows-1252?Q?Thomas_=93illwieckz=93_Debesse?= 
        <dev@illwieckz.net>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: On disabling AGP without working alternative (PCI and PCIe are
 also affected)
Thread-Topic: On disabling AGP without working alternative (PCI and PCIe are
 also affected)
Thread-Index: AQHXSCf9oieY1dTgdUez1KCkWnvsiarhwpAg
Date:   Thu, 13 May 2021 19:02:25 +0000
Message-ID: <MN2PR12MB4488D3F9625D8F48F9832502F7519@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <6941f046-d9a6-7603-0338-e7831917a540@illwieckz.net>
 <MN2PR12MB448814C93AA0664284E1DA32F7EA0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <0ce2f491-ab60-8965-0292-4da44ebf7fc7@illwieckz.net>
 <488fd133-fcae-2fdb-5b7a-86131f97efdf@illwieckz.net>
In-Reply-To: <488fd133-fcae-2fdb-5b7a-86131f97efdf@illwieckz.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-05-13T19:02:21Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=45bafdf5-1c04-455e-8ca7-e08ee1da28ce;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: illwieckz.net; dkim=none (message not signed)
 header.d=none;illwieckz.net; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.11.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4241c27a-7075-4462-142b-08d91641a597
x-ms-traffictypediagnostic: MN2PR12MB4032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4032F018153B1793A65A9C8EF7519@MN2PR12MB4032.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HekueS82x+n1TrHLyPZ1SzE8eVDN0mD7kyGPZqacYmNWIheB2UFwhB/P7uFjq9ytWgXbHNY5InRazWdzbhItErPcq7Q7HOqxCICuGwoVloEYP21AaMc9Tkpz/lgAooOYIHEal2bnx9OawJ6jNbEEvBxx4yXxBA+LAS6L3BXydqnTRvfdq1dozNqdD24lLGgIwkLSKlPMZGSsxyLQ2NDBsgXZTJIwQ2pJHRKrPaaixEqbFxDhoT6Vbs+1mmBRVvUC3dCejj49Qf9oD/AXQ9rr1CrQw3WbHZiSca2Lzmio+gZuYCbIbqFxKykni6dbvkNXSG5qgJR3isWdrdKkvb5pzk2uF8zXcWK5ibosUTKFUqv+W2x9XT7PwxrCnNE4ol3Jkl4vugsZ5iIESOJNFIbl7eA7hngcwdL76SdZ/ZFiyE63TcFq6SRM7UARjA+Tu7FEAJ5VtfZzvqnykZ0rBUqnxcSZadTIn39ltDD+6ZmHz4HkbM9J9kIN7HB0HaL6YGJfupxVreY+ASj8vbdaoyjJvj9/Ag3dT+ju04ZImxSTlc73hgqX30oDNyNKRwPSpsrsSW0OAeJZpMkHcMqV3h9qyzEtmK/+AC5tcv2L9JAsoOsiG8oK0sFOgEzs4bAwnoD2xid6Bz7BkVMRY+gb/D2MSzdUYdwWFcv2CHH9b7r0S4ArC8IW80xFpWnR3K9JooG4K1wJ5PybF3z/EULERjJBjtaVVk92l08wWYg7E0QjQpE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(316002)(122000001)(7696005)(66574015)(38100700002)(64756008)(8936002)(55016002)(83380400001)(9686003)(66476007)(110136005)(66556008)(2906002)(478600001)(76116006)(966005)(33656002)(71200400001)(45080400002)(186003)(53546011)(86362001)(8676002)(66446008)(6506007)(30864003)(26005)(5660300002)(52536014)(66946007)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?roN+6u8PgBAmhEg5XyfbPTlKYpiNWJk4H1j+q2D91X+tshk8dT2j3fvB?=
 =?Windows-1252?Q?qMYkdeCDZM3uooO3D0IYoXilnuJbu2mYSwFGutyzPCmXWgmrhPdLGlRs?=
 =?Windows-1252?Q?X1pWD1f1e4npJCnpYVX055GQmrAvZlsv++5OYoul0aqaQN11NzkRVFaf?=
 =?Windows-1252?Q?8Nl1STyX8V9ymmLOox6K3JkEFRJfll6VwsDAvG4WiKf6TGcIQngFdMvs?=
 =?Windows-1252?Q?i808q4PKmar6umtpm0+qsLaBTIbTEOIhm9JeNwcAaZaCYzm6g87hYx3U?=
 =?Windows-1252?Q?VAE6mB7LlxSfoIV5/I2Qf7JKMXHeTDl/8HOPIDE1ELsS7kgsi6VSeV2o?=
 =?Windows-1252?Q?9f5Gw7SnwbXuQv+7lqU3fVOOHquqXEwCEful9yQATdgJcuipA2uEL5C/?=
 =?Windows-1252?Q?lCt6wzH9bFapIog6kdRtcK9zIYW6W3WtA9yj5TPOXlENb5vv/iC9vYVt?=
 =?Windows-1252?Q?vejRSDrPwsLAwW4uhKt/wm5WP9ff/o4mrR+1VfxHwjFEMp5u5oYFTMPO?=
 =?Windows-1252?Q?oLFrDI3NTiqQ8oOOhWyp7P961aFp+0D/0NZovsYYIvVb3skem02hIK0R?=
 =?Windows-1252?Q?mvTK/Qg4APGLzW0ccpdQJl820TeugXUr5G3RaZ4V2g6OITeLobYRIOJu?=
 =?Windows-1252?Q?O2LVq8PEfHw4/FQFehMXFI3i49maTewvOHW/A673XUCZmyByV0orEz6v?=
 =?Windows-1252?Q?x3zAlxQUpayV+dqkSLJaZQ6RlVCalh/Kejm+S+QRztv4oFldVPoYSP61?=
 =?Windows-1252?Q?3AtKanGNlRnJGCnuA6cT9Dvj8I8BYKcZyAXHqJ3E3ZRSowiDzv/f+PYw?=
 =?Windows-1252?Q?W7xYWXwM9eD79C4lgNegibFA2YZOMQC5UaPrhv1ICcptqHuZuw6vTDt7?=
 =?Windows-1252?Q?SCcSUUvOmKczoZc3gpcEtGUk+i9hkL87FxK2Q/uRLZOZAf6zPm7KhJqz?=
 =?Windows-1252?Q?euRSaJYrVvN8xb0DWQ/dJa4ZWZysd4lykppykatFv6/2IW32FnANz3P9?=
 =?Windows-1252?Q?GSf2n7hKzgEzelNx4fZ6D0YU/+uA5wkZRlH79aT1wKVxh7XjsJ96xlJO?=
 =?Windows-1252?Q?ppwGv5zOO8eQP+dGJkbpV83YzN8iM0oabXus585Q1yTYyVGeTQP8PlQf?=
 =?Windows-1252?Q?DoWI+ETPHwGmEe7Ca4y1fwnswW58SSAlMpspc/kG8wJrKh44B2e6sblN?=
 =?Windows-1252?Q?yRm90MdloA7zgY63PLyslLEn3xl5o6iqJJtL8Jt+Uq3hsOSrdQpTq7cN?=
 =?Windows-1252?Q?Utyn8uVSfzHx+FtDqDZdjYXV2S/ajHQzxMClDYGIlTGz7Lz4+ydixTUM?=
 =?Windows-1252?Q?MwdUI5FCbXwoSyuL3uK4oan8BxanVRFfwF7nucePAmQEeW+Z9tCWZW66?=
 =?Windows-1252?Q?jGyxJiNsVrgBzWr8g5P6n4cSECjEgw50RaSqfwkDvg7aR078csb0/k/O?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4241c27a-7075-4462-142b-08d91641a597
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 19:02:25.4740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dxsLWmevij3YfZJfpzjo23AHFlSsjxVXsjZjLtIHlnIZaiynONMjLDmwcfhVSCvDwrPWaVYAoR15pfk+7RUoRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4032
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Thomas =93illwieckz=93 Debesse <dev@illwieckz.net>
> Sent: Thursday, May 13, 2021 2:42 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; LKML <linux-kernel@vger.kernel.org>
> Subject: Re: On disabling AGP without working alternative (PCI and PCIe a=
re
> also affected)
>=20
> Erratum: In my previous e-mail I forgot to remove that sentence about Int=
el
> platform:
>=20
> > If I'm right, AGP cards seems to work as PCI ones as well. That may
> > makes sense because previously I did not test AGP Radeon cards on
> > Intel platforms.
>=20
> I first wrote that after having beeing fooled by a lucky hardware combina=
tion.
> It exchanged immediate failure at desktop load for later computer reboot =
at
> game load (but with successfully loaded desktop, hence the illusion it wo=
rked
> at first).
>=20
> The valid statement, after more testing, is (quoted from the previous mai=
l
> which had then contradictory statements):
>=20
> > Note: on some very old cards (like the 9700 Pro from 2002) with
> > radeon.agpmode -1 (AGP as PCI), the symptom is different, the desktop
> > loads properly, but loading a game (Unvanquished) leads to a GPU
> > lockup.
> > While on newer hardware like ATI Radeon HD 4670 AGP (which was still
> > sold as new in 2012), the desktop won't load, displaying the exact
> > same symptoms as ATI/AMD PCI on ATI/AMD CPU. If I'm right, the old
> > ones like the 9700 Pro is likely to be a native AGP card, while the
> > latest ones like the HD 4670 may be natively PCIe with a bridge on the
> > AGP card.
> > Maybe that can ring a bell=85
>=20
> Not only the GPU can lockup, but the computer may also crash and reboot i=
n
> that scenario. The same hardware and software combination works perfectly
> when AGP is enabled.
>=20
> Those AMD/ATI AGP cards are then known to be affected on both AMD and
> Intel host platforms.

I don't think I have a functional AGP system anymore, but I do have PCIe ca=
pable systems and they work fine. =20
Does this patch[1], help by any chance?  The change to add support for root=
 ports with addressing limitations seemed to break a lot of old systems,
but never really got resolved.  If not, your best bet is probably to try an=
d bisect if something broke your system(s).

Alex

[1] - https://www.spinics.net/lists/amd-gfx/msg52961.html

>=20
> Best regards,
>=20
> PS: I wish to be personally CC'ed the answers/comments posted to the list=
 in
> response to my posting.
>=20
> --
> Thomas =93illwieckz=94 Debesse
>=20
> Le 06/05/2021 =E0 07:37, Thomas =93illwieckz=93 Debesse a =E9crit=A0:
> > Hi! First, thank you both Alex and Christian for your answers. Since
> > that time I did more experiments with more hardware. And=85 the new
> > knowledge is that the bug affects PCIe cards on PCIe slot when the
> > host also offers AGP slot, meaning those computers have to rely on AGP
> > cards (or PCI ones) instead of PCIe ones to get a working and usable
> desktop.
> > This bug is older than the AGP disablement that happened with 5.9-rc1
> > (out of curiosity I also reproduced the bug on Linux 4.15 from Ubuntu
> > Xenial, for example).
> >
> > We now know the issue affects both AGP, PCI, and PCIe. We know that
> > the issue affects both ATI/AMD and Nvidia hardware. The bugs occur
> > given this or that host / card combination, while everything works
> > with other combinations of the same hosts and cards (all of them being
> > validated to be working at some point). We know that, for PCI-related
> > issues, it even affects post-AGP AMD platforms like Bulldozer/Piledrive=
r.
> >
> > The PCIe issue affects both ATI/AMD and Nvidia GPUs and the symptoms
> > are consistent with the ones experienced with legacy PCI ATI/AMD and
> > Nvidia GPUs on platform we know PCI GPUs do not work. When I talk
> > about GPUs with legacy PCI port I talk about TeraScale/Tesla ones with
> > GL3 support, 512MB of VRAM and HDMI support, not ones from the Rage
> > era, just to make sure this is clear enough.
> >
> > Among the PCIe GPUs I managed to reproduce the bug with, I can name:
> >
> > - ATI Radeon HD 5870 Eyefinity 6 (RV870 Cypress XT, TeraScale 2,
> > OpenGL 4.3, 2GB of VRAM, 6 miniDP, released 2010-03).
> > - AMD FirePro 3D V4800 (RV830 Redwood XT GL, Terascale2, OpenGL 3.3,
> > 1GB VRAM, 1 DVI-I + 2 DP, released 2010-04).
> > - AMD Radeon HD 6970 (RV910 Caicos, TeraScale 3, OpenGL 4.3, 2GB VRAM,
> > 2 DVI-D + 1 HDMI + 2 miniDP, released 2010-12).
> >
> > Those GPUs don't have PCI or AGP counterparts anyway. And we know
> some
> > Linux PCI bugs can even affect TeraScale 3 PCIe GPUs with OpenGL 4 and
> > OpenCL support.
> >
> > We also know some Nvidia GPU (PCI and PCIe) can be affected.
> >
> > It looks like the problems are less on the GPU side, but more on the
> > PCI platform (bridge? chipset? I don't know). So while AMD is more
> > affected, and maybe AMD specific code is affected since AMD symptoms
> > are different than Nvidia symptoms, even combinations to reproduce
> > bugs may differ given the brand, my attention is now focused on PCI.
> >
> > ## What we already knew at the time of previous emails ##
> >
> > 1. PCI ATI/AMD Radeon and PCI Nvidia GPUs don't work on AMD platform,
> > this was verified on K8 (AMD Athlon 64 3200+, AMD Athlon 64 X2), K10
> > (AMD Phenom II X4 970 8 core) and Piledriver (FX-9590 8 core), so we
> > can probably assume all AMD64 platforms before Ryzen, Ryzen-based
> > motherboard usually don't have legacy PCI anyway (I've heard of the
> > Biostar Racing X470GTA motherboard but well, it's more rare than
> > legacy PCI and AGP).
> >
> > So there are known issues with legacy PCI on pre-Ryzen architecture,
> > including bulldozer ones, which is far more recent than AGP.
> >
> > At the same time, those PCI ATI/AMD Radeon and PCI Nvidia GPUs work
> on
> > Intel platforms, this was verified on multiple hosts including ones
> > with Pentium E5200 dual core (with Intel 82801) and Core 2 Quad Q6600
> > (with VIA PT880/VT82xx) to name somes.
> >
> > The brokenness of PCI ATI/AMD Radeon GPU on AMD platform is
> unrelated
> > to the platform offering AGP or PCIe. Both K8 with AGP and K8 with
> > PCIe behaves the same when a PCI ATI/AMD Radeon GPU is plugged in.
> The
> > PCI Radeon sample used for the test is a Radeon HD 4350 which is
> > fairly
> > capable: TeraScale, GL 3.3, 512M VRAM, HDMI.
> >
> > 2. AGP Radeon cards stopped to work on AMD platforms when AGP was
> > disabled by default in 5.9-rc1. The only way to make them work is to
> > use
> > radeon.agpmode=3D1 kernel command line option. Because distributions
> > like Ubuntu LTS distributed the patch backported on 5.8 kernel (either
> > because they backported it themselves or kernel developers did it
> > upstream, I don't know), after the update the computers were not able
> > to complete the boot because they never reached the desktop. This
> > affected pretty capable computers like the one I previously quoted,
> > which runs the quad core AMD AM3 Phenom II CPU X4 970 (3.5GHz) with
> > 16GB of RAM and featuring AGP Radeon HD 4600 (TeraScale, GL 3.3, 1GB
> VRAM, HDMI).
> >
> > If I use startx with lxsession I can get a working X.org environement,
> > but that is super slow and not really usable. Very slow disk IO are
> > reported and audio glitches are experienced, this has side-effects on
> > a wider scale than the sole display. Starting a more complexe
> > environment like GNOME will just make the computer unusable.
> >
> > 3. AGP Radeon cards running as PCI cards on AMD platforms display the
> > same broken behaviour we can see with PCI Radeon cards, which is not
> > surprising given it is expected they would run the same way. At least
> > this prediction got verified. ATI/AMD AGP as PCI on AMD platform is as
> > broken as ATI/AMD PCI on AMD platform.
> >
> > 4. Some problems were said to have been noticed by kernel developers
> > with latest AMD Radeon hardware and it was said disabling AGP improved
> > the support for those recent cards, that's why AGP was disabled
> > starting with 5.9-rc1 in hope to fix the latest AMD Radeon hardware
> > (but that brokes older ones in the process).
> >
> > ## What is new knowledge since that time ##
> >
> > 1. PCIe ATI/AMD Radeon GPUs running on Intel host having both AGP and
> > PCIe slots do not work and displays the same broken behaviour we can
> > see with AGP Radeon cards running as PCI cards, or PCI Radeon cards on
> > AMD platform.
> >
> > This was verified with a wide range of AMD/ATI PCIe GPUs, both
> > consumer Radeon or professionnal FirePro cards.
> >
> > Interestingly, the testbed is an Intel-based platform (Core 2 Quad
> > Q6600) and then PCI Radeon cards work as we seen with other Intel
> > based hosts. If I'm right, AGP cards seems to work as PCI ones as
> > well. That may makes sense because previously I did not test AGP
> > Radeon cards on Intel platforms.
> >
> > But then, as I said, the PCIe Radeon cards just fails as AGP ones
> > running as PCI and PCI ones on AMD platforms. But for them,
> > radeon.agpmode=3D1 does not make sense, so there is no solution.
> >
> > By failing I mean grub displays things correctly, then linux displays
> > things correctly, including framebuffer, but when X.org starts and
> > open the desktop, some background is painted but the desktop never
> > complete the startup. The mouse pointer can be moved with the mouse
> > but that's all. The tested desktop is GNOME, and the shell itself does =
not
> display.
> >
> > So, with all those experiments done, and with all that knowledge, it
> > appears there is some serious issues in the PCI code.
> >
> > Note: on some very old cards (like the 9700 Pro from 2002) with
> > radeon.agpmode -1 (AGP as PCI), the symptom is different, the desktop
> > loads properly, but loading a game (Unvanquished) leads to a GPU lockup=
.
> > While on newer hardware like ATI Radeon HD 4670 AGP (which was still
> > sold as new in 2012), the desktop won't load, displaying the exact
> > same symptoms as ATI/AMD PCI on ATI/AMD CPU. If I'm right, the old
> > ones like the 9700 Pro is likely to be a native AGP card, while the
> > latest ones like the HD 4670 may be natively PCIe with a bridge on the =
AGP
> card.
> > Maybe that can ring a bell=85
> >
> > 2. PCIe Ndidia GPUs on Intel host having both AGP and PCIe slots do
> > not work and displays the same broken behaviour we can see with PCI
> > Nvidia card running on AMD host. The graphical glitches are exactly
> > the sames with Nvidia PCI on the AMD host and Nvidia PCIe on the Intel
> > host (but not the same as PCI and AGP-as-PCI and PCIe Radeon
> symptoms).
> >
> > So, we can reproduce the Nvidia-specific glitches with both PCI and
> > PCIe, and we can reproduce the ATI/AMD-specific symptoms with both
> > PCI, AGP, and PCIe.
> >
> > ## Various answers and questions ##
> >
> > Christian K=F6ning said:
> >
> >> That is interesting but doesn't make much sense from the technical
> > perspective.
> >> See AGP is build on top of PCI, if PCI doesn't work AGP won't work
> > either. So why should AGP work while PCI doesn't?
> >
> > Now we know that both PCI, AGP and PCIe are affected. Which makes
> sense.
> >
> > What's makes hard to track the bugs is that the bugs may occur or not
> > occur given the host and cards combination. This is probably about
> > GPU/PCI bridge combination (and motherboard chipset when it makes
> > sense) or things like that.
> >
> > Alex Deucher said:
> >
> >> For newer AGP hardware like the RV730 you point out (or anything
> >> newer
> > than R300), there is no reason to run AGP mode. The on chip GART is
> > far superior.
> >
> > So, on paper, AGP-as-PCI is expected to work, and on paper again, some
> > of those card may even work better this way. Experience currently
> > displays the exact opposite, which not only means there is bugs
> > somewhere, but also that the behaviour of the PCI code is
> > unpredictable, because predictions fail.
> >
> > Christian K=F6ning said:
> >
> >> We simply don't have the time to support that older GPU and disabling
> > AGP fixed quite a number of them.
> >
> > Was disabling AGP motivated by some issues with identified causes and
> > it was decided to not fix them, or was disabling AGP motivated by the
> > observation it fixed some other issues but without identifying the caus=
es?
> >
> > What's now interesting is that on some PCIe-compatible platforms, PCIe
> > is broken and AGP is the working fallback, and now that AGP is
> > disabled by default in code, none work out of the box.
> >
> > I can understand how it would be easier to not support older hardware,
> > but on the other hand what's the purpose of Mesa/RadeonSI supporting
> > them on the userland side if the kernel can't host the hardware to
> > begin with?
> >
> > Also, that may be seen as unfortunate, but AGP is not only about Rage
> > 128 cards or those very very old thing that would not fullfill current
> > needs. Unlike Nvidia, there was AMD/ATI AGP hardware that were
> > produced and sold very lately and those are still capable to fullfill
> > current needs. At the same time, AMD ensured very good compatibility
> > of it's hardware, that's why it was possible to have the quoted quad
> > core AM3 Phenom II on an AM2 motherboard with AGP for example. This is
> > precisely why AMD is appreciated by customers, not like Intel with
> > frustrating market segmentation where, for example (real use case),
> > one Pentium
> > E5200 with IGP can support OpenGL 3 but not virtualization, while
> > another Pentium E5200 with IGP cannot support OpenGL 3 but supports
> > virtualization, or (another real example), supporting PAE while hiding
> > it to the operating system. Buying AMD is all about not having to
> > choose between this or this feature, and buying AMD is all about being
> > able to get hardware that works over multiple hardware generations.
> >
> > But anyway, outside of those considerations, it now appears the PCI
> > code has serious issues and the behaviour can't be predicted. Newer
> > hardware may be working, but do we know how much luck is involved?
> >
> > I may be busy, doing those extra tests and reporting the results took
> > me some extra months, but at least, I have access to a wide range of
> > hardware to test any patch that would aim to fix the
> > PCI/AGP/PCIe-related bugs. I would be happy to help on that topic. AGP
> > is just one aspect of it, now we know those PCI-related bugs affect
> > legacy PCI and PCI express as well.
> >
> > Christian K=F6ning said:
> >
> >> We simply can't invest time maintaining a technology which is
> > deprecated for nearly 15 years now.
> >
> > It now appears that the bugs not only affect AGP and PCI but also PCI
> > Express. AGP disclosed those bugs, but PCI seems to be at fault there.
> >
> > One interesting thing is that some ATI/AMD cards on AMD hosts are more
> > buggy than the same ATI/AMD cards on Intel hosts. The underlying bugs
> > may even not be related to the cards themselves but on the host PCI
> > code (chipsets, PCI bridges or things like that).
> >
> > Note: one interesting thing is that I have access to two Radeon HD
> > 4670, one AGP model, one PCIe model, from the same vendor, exact same
> > generation, vendor and model, just one being AGP and one being PCIe
> > variant. On the same Intel-based motherboard supporting both AGP and
> > PCIe, only the AGP model works. The PCIe model is not faulty, it works
> > as expected on AMD-based motherboards only having an AGP port and no
> > PCIe port. Getting things working seems to be about luck, not about
> > what the implementation is said to do.
> >
> > I also have access to two X1950 pro, one PCIe, one AGP, from different
> > vendors, though this one is less interesting because not a TeraScale
> > one. But this may be useful for testing because I can test both on the
> > same motherboard having both an AGP and a PCIe slot. Currently, only
> > AGP works on that host anyway because when using AMD/ATI or Nvidia
> > PCIe GPUs on that Intel host I reproduce the issues I get with AMD/ATI
> > or Nvidia PCI  GPUs on AMD host=85
> >
> > Who are the ones working on the PCI platform code? Maybe those would
> > be better interlocutors, it looks like the issue is not AMD specific,
> > it affects Nvidia GPUs and Intel platforms as well.
> >
> > Is there options similar to radeon.agpmode but for PCI / PCI Express I
> > can experiment with?
> >
> > I'll build one day the latest vanilla kernel to reproduce the issues
> > and probably open a ticket on the kernel bugzilla regarding
> > PCI-related problems in general (even if there is AMD-specific variants=
 of
> the bug).
> > That would be a good start.
> >
> > Thank your very much for your attention, best regards,
> >
> > PS: I wish to be personally CC'ed the answers/comments posted to the
> > list in response to my posting.
> >
> > --
> > Thomas =93illwieckz=94 Debesse
> > Le 09/11/2020 =E0 18:37, Deucher, Alexander a =E9crit=A0:
> >> [AMD Public Use]
> >>
> >>> -----Original Message-----
> >>> From: Thomas =93illwieckz=93 Debesse <dev@illwieckz.net>
> >>> Sent: Monday, November 9, 2020 6:41 AM
> >>> To: LKML <linux-kernel@vger.kernel.org>
> >>> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
> >>> <Alexander.Deucher@amd.com>
> >>> Subject: On disabling AGP without working alternative (PCI fallback
> >>> is broken for years)
> >>>
> >>> Hi, on May 12 2020, a commit (ba806f9) was merged disabling AGP in
> >>> default build.
> >>>
> >>> It was signed-off by Christian K=F6nig and Reviewed by Alex Deucher.
> >>> Distributions started to backport this commit, and it seems to have
> >>> happened with 5.4.0-48-generic on Ubuntu 20.04 LTS side, which was
> >>> built on Sep 10 2020.
> >>>
> >>> Around that time I noticed AGP computers experiencing lock-ups and
> >>> other problems making them unusable after the upgrade. After
> >>> investigating what was happening bisecting Linux versions, I
> >>> reverted the commit and those computers were working again.
> >>>
> >>> Commit message was:
> >>>
> >>>> This means a performance regression for some GPUs, but also a bug
> >>>> fix for some others.
> >>>
> >>> Unfortunately, this commit does not only introduce a performance
> >>> regression but makes some computers unusable, maybe all computers
> >>> with AMD CPUs.
> >>>
> >>> One of the root cause may be that PCI GPUs are broken for years on
> >>> AMD platforms, it was tested and verified on:
> >>>
> >>> - K8-based computer with AGP
> >>> - K8-based computer with PCI Express
> >>> - K10-based computer with AGP
> >>> - Piledriver-based computer with PCI Express
> >>>
> >>> The breakage was tested and reproduced from Linux 4.4 to Linux
> >>> 5.10-rc2 (I have not tried older than 4.4).
> >>>
> >>> PCI GPUs may be broken on some other platforms, but I have found
> >>> that testing on an Intel PC (with PCI Express) does not reproduce
> >>> the issue when the PCI GPU hardware is plugged in.
> >>>
> >>> There is two patches I'm requesting comments for:
> >>>
> >>> ## drm/radeon: make all PCI GPUs use 32 bits DMA bit mask
> >>>
> >>>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flk
> >>>
> ml.org%2Flkml%2F2020%2F11%2F5%2F307&amp;data=3D04%7C01%7CAlexand
> er.Deu
> >>>
> cher%40amd.com%7C24731393d8ef426b573e08d9163ed4ae%7C3dd8961fe48
> 84e60
> >>>
> 8e11a82d994e183d%7C0%7C0%7C637565282618094458%7CUnknown%7CTW
> FpbGZsb3
> >>>
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D
> >>>
> %7C2000&amp;sdata=3DttmqSG4h28zhGya9KRnHkK7ftzmHVdrGsZDvTFiuX10%
> 3D&amp
> >>> ;reserved=3D0
> >>>
> >>> This one is not enough to fix PCI GPUs but it is enough to prevent
> >>> to fail r600_ring_test on ATI PCI devices. Note that Nvidia PCI GPUs
> >>> can't be fixed by this, and this uncovers other bug with AGP GPUs
> >>> when AGP is disabled at build time. Also, this patch may makes PCI
> >>> GPUs working on a non-optimal way on platform that accepts them with
> >>> 40-bit DMA bit mask (like Intel- based computers that already work
> without any patch).
> >>>
> >>> This patch is inspired from the patch made to solve that issue from
> >>> 2012 on kernel 3.5:
> >>>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbu
> >>>
> gzilla.redhat.com%2Fshow_bug.cgi%3Fid%3D785375&amp;data=3D04%7C01%7
> CAl
> >>>
> exander.Deucher%40amd.com%7C24731393d8ef426b573e08d9163ed4ae%7
> C3dd89
> >>>
> 61fe4884e608e11a82d994e183d%7C0%7C0%7C637565282618313502%7CUnkn
> own%7
> >>>
> CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwi
> LCJ
> >>>
> XVCI6Mn0%3D%7C2000&amp;sdata=3D7uF7JHP9LQnD6yJsZBhT9Tzwo%2BoM2
> bnaxxXKk
> >>> jpRfbw%3D&amp;reserved=3D0
> >>>
> >>> At the time, such change may have been enough to fix the issue, it's
> >>> not true any more. More breakage may have been introduced since.
> >>>
> >>> Also, maybe this patch becomes useless when other PCI bugs are
> >>> fixed, who knows? At least, this is an entry-point for investigations=
.
> >>
> >> I think you may be seeing fallout from this patch:
> >>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit
> >>
> .kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git
> >>
> %2Fcommit%2F%3Fid%3D33b3ad3788aba846fc8b9a065fe2685a0b64f713&am
> p;data
> >>
> =3D04%7C01%7CAlexander.Deucher%40amd.com%7C24731393d8ef426b573e0
> 8d9163e
> >>
> d4ae%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6375652826183
> 13502%
> >>
> 7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLC
> JBTiI6I
> >>
> k1haWwiLCJXVCI6Mn0%3D%7C2000&amp;sdata=3DFYFOtp1DYw1RU%2BxdJcV
> NNpyk5NMr
> >> GPjDSEFiM3kvx8k%3D&amp;reserved=3D0 That patch lead to screen
> >> corruption and other issues on older radeons.  It seemed to be related=
 to
> AGP and/or HIMEM.  Disabling either of those fixes the issues.
> >> I proposed reverting the change, but there was push back to find the r=
oot
> cause:
> >>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fww
> w
> >>
> .spinics.net%2Flists%2Fstable%2Fmsg413960.html&amp;data=3D04%7C01%7CA
> le
> >>
> xander.Deucher%40amd.com%7C24731393d8ef426b573e08d9163ed4ae%7C3
> dd8961
> >>
> fe4884e608e11a82d994e183d%7C0%7C0%7C637565282618313502%7CUnkno
> wn%7CTW
> >>
> FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> VCI
> >>
> 6Mn0%3D%7C2000&amp;sdata=3DXPVqb5fLOb7os1uz6sizBCKNiI2OfaNzYjy5fkq
> XlqM%
> >> 3D&amp;reserved=3D0
> >>
> >>
> >>>
> >>> ## Revert "drm/radeon: disable AGP by default"
> >>>
> >>>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flk
> >>>
> ml.org%2Flkml%2F2020%2F11%2F5%2F308&amp;data=3D04%7C01%7CAlexand
> er.Deu
> >>>
> cher%40amd.com%7C24731393d8ef426b573e08d9163ed4ae%7C3dd8961fe48
> 84e60
> >>>
> 8e11a82d994e183d%7C0%7C0%7C637565282618313502%7CUnknown%7CTW
> FpbGZsb3
> >>>
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D
> >>>
> %7C2000&amp;sdata=3DLEOPG4tHCHYtehnG3orDvb0FBEwMBd%2FYkhhpAvBo
> nTM%3D&a
> >>> mp;reserved=3D0
> >>>
> >>> This is the simple fix but currently only solution to make AMD hosts
> >>> with AGP port to get a display again, as without this reverts, those
> >>> computers do not have any alternative to run a display (even not PCI
> GPUs).
> >>>
> >>> I'm asking for comments on those patches. I may have reached my own
> >>> skill cap on kernel development anyway. I can repurpose hardware to
> >>> test any other patch and can contribute time for such testing.
> >>> Unlike AGP GPUs, PCI GPUs are hard to find, so you may appreciate
> >>> the time and availability offered.
> >>>
> >>> The PCI GPU on AMD CPU issue was verified with both Nvidia (GS
> >>> 8400GS
> >>> rev.2) and ATI (Radeon HD 4350) PCI GPUs, such GPU sample not being
> >>> old cards from the previous millennial but capable
> >>> ones: TeraScale RV710 architecture on ATI side and Tesla 1.0 NV98 on
> >>> Nvidia side. They can both do OpenGL 3.3 and feature both 512M of
> >>> VRAM. The ATI one had HDMI port, and it is known some variant of the
> >>> Nvidia one (not the one I own but same specification) had HDMI port
> too.
> >>>
> >>> Also, fixing PCI GPUs may not be enough to fix AGP GPUs running as
> >>> PCI ones, since fixing some issues (not all) on PCI side raises new
> >>> issues with AGP GPUs running as PCI ones but not on native PCI GPUs
> (see below).
> >>>
> >>> Bugs aside, one thing that is important to consider against the AGP
> >>> disablement is that there is such hardware that is very capable and
> >>> not that old out there. For example the ATI Radeon HD 4670 AGP
> >>> (RV730 XT) was still sold brand new after 2010 and is a powerful and
> >>> featureful GPUs with 1GB of VRAM and HDMI port. Performance with it
> >>> is still pretty decent on competitive games. To compare with other
> >>> =A0open source drivers mainlined in Linux, to outperform this GPU an
> >>> =A0user has to get an Intel UHD 600 or an Nvidia GTX 1060 from 2016.
> >>>
> >>> Also, yet another thing that is important to consider against AGP
> >>> disablement is that if PCI Express was introduced in 2004, there was
> >>> still AGP compatible hardware being designed, produced and sold very
> >>> lately, especially on AMD side. Computers with quad core 64-bit CPUs
> >>> with virtualisation, 16GB of RAM and AGPs exist, and this is widely
> >>> distributed consumer hardware, not specific esoteric hardware.
> >>>
> >>> So, not only powerful AGP GPUs were still sold brand new in the
> >>> current decade, but there was also very capable computers to host
> >>> them. Because of those AGP computers, fixing PCI GPUs fallback is
> >>> not a solution because PCI fallback is not a solution.
> >>>
> >>
> >> For newer AGP hardware like the RV730 you point out (or anything newer
> than R300), there is no reason to run AGP mode.  The on chip GART is far
> superior.  The only chips where performance may be a problem is the older
> R1xx/R2xx radeons, and the issue there is more around the size of the TLB=
 on
> the on chip GART vs the TLB in the AGP bridge. Also as Christian mentione=
d,
> AGP is PCI so if PCI doesn't work, you have bigger problems.
> >>
> >> Alex
> >>
> >>
> >>> All that range of hardware became unusable with that commit
> >>> disabling AGP, without alternative.
> >>>
> >>> Not only those AGP GPUs don't work with kernel's PCI fallback, but
> >>> unplugging those AGP GPUs and plugging physical PCI-native GPUs
> >>> instead does not work.
> >>>
> >>> You'll find more details about the various issues on those bugs,
> >>> I've invested multiple full time day to test and reproduce bugs on a
> >>> wide range of hardware, I've attached, quoted and commented a lot of
> logs:
> >>>
> >>> -
> >>>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbu
> >>>
> gs.launchpad.net%2Fbugs%2F1899304&amp;data=3D04%7C01%7CAlexander.D
> euch
> >>>
> er%40amd.com%7C24731393d8ef426b573e08d9163ed4ae%7C3dd8961fe4884
> e608e
> >>>
> 11a82d994e183d%7C0%7C0%7C637565282618313502%7CUnknown%7CTWFp
> bGZsb3d8
> >>>
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7
> >>>
> C2000&amp;sdata=3DKh1pP0j%2BNGZL9tXcCz8kU3rqhvfS%2BRfCJ8HX12%2Bg
> Mf0%3D
> >>> &amp;reserved=3D0
> >>>> AGP disablement leaves GPUs without working alternative (PCI
> >>>> fallback is broken), makes very-capable ATI TeraScale GPUs unusable
> >>>
> >>> -
> >>>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbu
> >>>
> gs.launchpad.net%2Fbugs%2F1902981&amp;data=3D04%7C01%7CAlexander.D
> euch
> >>>
> er%40amd.com%7C24731393d8ef426b573e08d9163ed4ae%7C3dd8961fe4884
> e608e
> >>>
> 11a82d994e183d%7C0%7C0%7C637565282618313502%7CUnknown%7CTWFp
> bGZsb3d8
> >>>
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7
> >>>
> C2000&amp;sdata=3DOe0vd4XdPqiqwkUYAY9UGNkZx%2BWfweCMgnkIbn5Gx
> q0%3D&amp
> >>> ;reserved=3D0
> >>>> AGP GPUs driven as PCI ones (when AGP is disabled at kernel build
> >>>> time) are known to fail on K8 and K10 platforms
> >>>
> >>> -
> >>>
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbu
> >>>
> gs.launchpad.net%2Fbugs%2F1902795&amp;data=3D04%7C01%7CAlexander.D
> euch
> >>>
> er%40amd.com%7C24731393d8ef426b573e08d9163ed4ae%7C3dd8961fe4884
> e608e
> >>>
> 11a82d994e183d%7C0%7C0%7C637565282618313502%7CUnknown%7CTWFp
> bGZsb3d8
> >>>
> eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7
> >>>
> C2000&amp;sdata=3DddgbHRV99Xike%2F4weyiQmH9gfcmHXl21yusU9jdw6QA
> %3D&amp
> >>> ;reserved=3D0
> >>>> PCI graphics broken on AMD K8/K10/Piledriver platform (while it
> >>>> works on Intel) verified from Linux 4.4 to 5.10-rc2
> >>>
> >>> I wish to be personally CC'ed the answers/comments posted to the
> >>> list in response to my posting.
> >>>
> >>> Thank you for your attention.
> >>>
> >>> --
> >>> Thomas =93illwieckz=94 Debesse
