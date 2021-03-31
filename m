Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9895F34FBC0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhCaIhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 04:37:10 -0400
Received: from mail-eopbgr60047.outbound.protection.outlook.com ([40.107.6.47]:45440
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230350AbhCaIg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 04:36:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJa9UpoNM5VFWjjX5zSn4+vGTLWFZLtl+yj1fm7yfYRCQNlPPaNl3nWX+CbC/sIk9sFrnlutRr/XoKb1iQm+cV3BvzY3nXoxQcBmhMUNJS8IIzNu86BNXEtlrU2BU4+2HJSCrLDdz1LKqXNTrsp6eCq3gpkmoCoqEyLV8kXEjiLxPz2/flrIP7ezzfc92dOhvEaDf5ZjXLtOZQoHXnklf+bDTMgNM+ukyM47QOzbsgW2raGgoIQ3XrQcl7CD6DGGLgheNgcnQCV17TDvV2azUY2xW3XP7wB15OgG1UDYZ0Fn75gAysUAchYNQc74o8SlP+0O7Ncx9qmp4YcmBBtabQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOkNLgUSmiYyltivefYrDX64zKWst1bwHOax64GwDJs=;
 b=UUPuABafpADn2fhbEIiz4tpXA35bPzP0rQcloD+626i5/faqu4doUOtrD6HP+W5376PocgIPbApw7hQD1g5FkVoWl3bPc8Su7jxtWpzOajVlDxaKvjwsScMFjtXxiVk/OKsy/YaSjGbbGUMTAo7rZHf3RYvC4rhqqOeR6QEdsGldJ54F316/a3KJkPBtMZQIICoMVsw2cXlYbCVyXlV1Htr/x1r9A51FRpDqkvvcBtoQnTIZDZRdiiihSgKuk5IN1RJ95EjPIba3+D1a2W1b5RlK+4eViMLs+rQ/VHMSrxnvyZjU9trGv3qPBi2q4ePJsi3aS+UmOq6Xbi2cqOXNsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOkNLgUSmiYyltivefYrDX64zKWst1bwHOax64GwDJs=;
 b=l5I25O7dyDPclErmKGtwuT2tQCgaJTOS0dO+l1KMtgtoJAyo4f7HysjHoyd3rJm/8a6csvnnlcm6uTNs0kG2k80RMP8TmJnunZw0/7WwC2xWBIcnPWWyZcpy9XsDDmKZAV7mSaGw3y2e2zSAzAtYPFNlwBozX5hCYkH270Wujgg=
Received: from DB6PR0401MB2407.eurprd04.prod.outlook.com (2603:10a6:4:4b::7)
 by DBBPR04MB7913.eurprd04.prod.outlook.com (2603:10a6:10:1ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 31 Mar
 2021 08:36:55 +0000
Received: from DB6PR0401MB2407.eurprd04.prod.outlook.com
 ([fe80::8007:e187:6f31:719]) by DB6PR0401MB2407.eurprd04.prod.outlook.com
 ([fe80::8007:e187:6f31:719%9]) with mapi id 15.20.3999.027; Wed, 31 Mar 2021
 08:36:55 +0000
From:   "J.d. Yue" <jindong.yue@nxp.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "fweisbec@gmail.com" <fweisbec@gmail.com>,
        "mingo@kernel.org" <mingo@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v2] tick/broadcast: Allow later registered
 device enter oneshot mode
Thread-Topic: [EXT] Re: [PATCH v2] tick/broadcast: Allow later registered
 device enter oneshot mode
Thread-Index: AQHXJcq7ZFUFxVdDYUCzmUhdysoTlqqdvg2AgAAHblA=
Date:   Wed, 31 Mar 2021 08:36:55 +0000
Message-ID: <DB6PR0401MB2407333158EC1F8525A31D4BFB7C9@DB6PR0401MB2407.eurprd04.prod.outlook.com>
References: <20210331011045.25381-1-jindong.yue@nxp.com>
 <87ft0b6926.ffs@nanos.tec.linutronix.de>
In-Reply-To: <87ft0b6926.ffs@nanos.tec.linutronix.de>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f6bcede5-d369-46d1-1f4b-08d8f42023f0
x-ms-traffictypediagnostic: DBBPR04MB7913:
x-microsoft-antispam-prvs: <DBBPR04MB7913E7FE9868D9E5E3E695E1FB7C9@DBBPR04MB7913.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4fR0i+gBaBLaauDB5PBCLOZf9PDfMXgusjwns6GwNMYtBXS2yqDosvgIlSnimTxE+MN410TnFBPWYefke+k2uSPSS6RwB2h8egI5m6xlOAvi3bqVenYVRmBjE/nrqvwR035ZeFLR/hFJPTdhpmNf5kWrKkwtkaJTc98XTLX4+dnsvyhr/OJXhvq84VlfaY7Tn3lsQw3b1mpJVGbjdM7JsZj5J0V/Hplyko+MnBBStmPrgxxvzmpR73VdrX6phJSSQLK3yVEYahQGDnFxXTNPP21aQVPrSSHjHebmecA0aF2NiJD8oP94vikFuj5lk450q6rKxJ67fOaeiidgfXZuYxjY+P5UW3aeDLuuNLxJRcwkYEkHf+tD3pAIFO3pyaOzTM2+eqkV8TkS+P2D620oTXU/y7uFcQCluKvhfEoizd+7mR6/WFiuSVWa2+cpfpxc9eyUZIqqkBIXt6D7HQ3RmwdhZ/QrB2+JhHhBTLv4MgYBYldlMIKId94vyOjsG0rB5NRPsADqbBwOydewHY87UGZO0unPLA4pUmFQyL/fj1M0tsZOWp5gPYccjTTg/WyYtjnsXcmVESwzvvJ0MAyLw5XGeSPkRHJtn/KcQQxaGPpY2dnhI/MEZf7J4R91T3TP8ZLgdZGARdH0l1w7Aihdzjkrs0Cn97Yql9yrBc27bWc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2407.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(498600001)(86362001)(7696005)(66476007)(66446008)(64756008)(9686003)(66556008)(5660300002)(110136005)(71200400001)(33656002)(83380400001)(55016002)(2906002)(26005)(52536014)(4326008)(6506007)(38100700001)(8936002)(8676002)(186003)(53546011)(66946007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CiKvZPx+lqyDGn1mjH2L09R/LvaCNnNDaKT3Gl+9ouGl7OmAs0CP6Hw8BgUc?=
 =?us-ascii?Q?uQ8s1qBp6TM9/EBa5cs5MWLBtk6O+zE1q/tfoH7XfEgmxaQ+s0BTgIRQAfpz?=
 =?us-ascii?Q?Yt11tLdefA9EqWWXGqL9J3H48eBqTxNUUfjyK9VoeEeJsNzB3/xNRiE7GbHc?=
 =?us-ascii?Q?kEAbjOA1jK9FIvT3enrNQTs9FxiOPv+Esqm6fDTSSZW6b9EHQXozeNuuNU/r?=
 =?us-ascii?Q?Ms6nord9XoQtGnCSrVZo5pR2UMbyWPbFUI5lpHw+A7YyykSIBVvnaSLS0B52?=
 =?us-ascii?Q?ZWUjSCKroncSHAGw0CdJtfp262+gDPnNDThqNyh6hJSGweNS/4Fuoi5LwMPC?=
 =?us-ascii?Q?7Q+p6n9gwmJ1S7lQ4n7CJAUkpxwI2IsWhBYgOJR52j6BEy4kdWzpghXFFUn8?=
 =?us-ascii?Q?rSvFQVJmlLMSk1Xb7nLts8MfvZfhCmDghoBA3wO+Ihr0ogqumMSbTPGwVZWt?=
 =?us-ascii?Q?LL9VMoP4JdMcGSMCtPSdIJsZwQyzNKdU/NF6apWhgoN5qVFPDNg6/Qb8jYEg?=
 =?us-ascii?Q?jiA0CtxQvbLCRe0v5fOrCi1oXBinxrMKl6zQmP9RFp/oIGRkTOrgwENXGRsE?=
 =?us-ascii?Q?X2Rs1S4X4UkN7vgvuQePvxGe5mxYh2iyX9S7gHJWz/CXsKa+aIL5xl9231cX?=
 =?us-ascii?Q?dQLpt5Q7iVcsXfvVOgaeYN+6v7Pf8vPkU05Zx+jwGtvQ7e8ABC/zs4xj8Jew?=
 =?us-ascii?Q?I2s82N8n4GIT91fOcM84DcQd5STLuYv5FW1G4WrqancIhIbqaSpJ32hg8wX0?=
 =?us-ascii?Q?2D0Fe97fin2b7H1tSAeVjCGa1+gccEJgv32Lv/yUVMW/qYiQoGqHnuh7pS8k?=
 =?us-ascii?Q?+oo3HYY3VUh3mMBULXsezEcbV302brzvys5dEgMxJ9KhY7fv6P6QdfwvuBdc?=
 =?us-ascii?Q?T2t9IfzgiDVIVqZIU5Eu+cA3YJAekJeE8QXAThFWINQlGP7bkx44qvAiLxfS?=
 =?us-ascii?Q?Vj8uA9JGj944YGfCesgv7W1TsVe/Mpb96oXkkhDQDAosEI03Wb9rER14VzCO?=
 =?us-ascii?Q?6Fu8oBH8urM5V9kiWkoDCbJxjKDqioTerz6+M+J6R+TLYQMWyR8pBs30nQyw?=
 =?us-ascii?Q?p111zDdGLD5+x3r6uYwBq2ZffMfqsyl9LpBQjUBCog+Nw5bqkVKu17lwuOG2?=
 =?us-ascii?Q?q4xfWSJhpvJlaUNXf7OTmaMGxmqehZkU+DE3rANp4l8qrL4hAoAM9aa9nn6x?=
 =?us-ascii?Q?kB29xBzl4VlOTzTSateGFMNgzaDqxuXL/OGq+G1L0ddcDy4DBm+FwI0MX9AH?=
 =?us-ascii?Q?ggb9b3Rhvk1qEePoq/QN+KZNeteSrfxgCNsV6fH6uXru2wzkysOMeQKlXQ6h?=
 =?us-ascii?Q?uPk=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0401MB2407.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6bcede5-d369-46d1-1f4b-08d8f42023f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2021 08:36:55.0965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2cdewuuV/c1qlddEqSZiZxyoz6WHvMj+CYtX0fqYl2voMRsm5QR1/tuDSgQ51CrVGQLdD3C4OHzwVqiHL3qChA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7913
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Wednesday, March 31, 2021 4:07 PM
> To: J.d. Yue <jindong.yue@nxp.com>; fweisbec@gmail.com; mingo@kernel.org
> Cc: linux-kernel@vger.kernel.org; J.d. Yue <jindong.yue@nxp.com>
> Subject: [EXT] Re: [PATCH v2] tick/broadcast: Allow later registered devi=
ce
> enter oneshot mode
>=20
> Caution: EXT Email
>=20
> On Wed, Mar 31 2021 at 09:10, Jindong Yue wrote:
> > --- a/kernel/time/tick-broadcast.c
> > +++ b/kernel/time/tick-broadcast.c
> > @@ -47,6 +47,7 @@ static inline void
> > tick_resume_broadcast_oneshot(struct clock_event_device *bc)  static
> > inline void tick_broadcast_oneshot_offline(unsigned int cpu) { }  #
> > endif  #endif
> > +static void tick_handle_oneshot_broadcast(struct clock_event_device
> > +*dev);
>=20
> Leftover ...

Removed in v3.

>=20
> >  /*
> >   * Debugging: see timer_list.c
> > @@ -107,6 +108,19 @@ void tick_install_broadcast_device(struct
> clock_event_device *dev)
> >       tick_broadcast_device.evtdev =3D dev;
> >       if (!cpumask_empty(tick_broadcast_mask))
> >               tick_broadcast_start_periodic(dev);
> > +
> > +     if (!(dev->features & CLOCK_EVT_FEAT_ONESHOT))
> > +             return;
> > +
> > +     /*
> > +      * If system already runs in oneshot mode, switch new registered
>=20
> the system .... the newly registered
>=20
> > +      * broadcast device to oneshot mode explicitly if possiable.
>=20
> s/possible/possiable/
>=20
> But the 'if possible' makes no sense here. The above check for
> CLOCK_EVT_FEAT_ONESHOT established that it _is_ possible. So just remove
> the 'if ...'.

I should be more careful ...
Please check v3 patch.

Thanks
Jindong

>=20
> > +      */
> > +     if (tick_broadcast_oneshot_active()) {
> > +             tick_broadcast_switch_to_oneshot();
> > +             return;
> > +     }
>=20
> Thanks,
>=20
>         tglx
