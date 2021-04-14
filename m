Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE95D35ED19
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349113AbhDNGR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:17:29 -0400
Received: from mail-bn8nam11on2063.outbound.protection.outlook.com ([40.107.236.63]:36456
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232679AbhDNGRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:17:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esAIjVuLZimaH9PdWi4dg8kAGI3Xl403zJqbl/Tladozx5QVDr748gNwa5YjTfr4jpEPIK+4MWsWSQF7pyq3UOmf4vJ4vMcNH3NUFGhjeeQYMS8gVDDuC3n6qn97XA0AZpn49erRu5x210xip67KdFtYMAVQFDJKg6FLrF9CKZ/7vZmodY1jveWdwa2zXRZs2nk2Xj4YjI0ucUDfyVMfKR6aQycy2bAxKnX+uD1OVIHF6tviZ/GWtht3wQfb+VHCP38+IUv6EcSppEA6z6u878tsJHD/eyWFKpjqJHkti6jXCjVz8Zf6zfMVc01BUXoLJGZl2mYxU5mAs9a36ExpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ctm0BCMZoTWHosv2ES4NAqA5h2Q9d4q5DfdJJijMhgU=;
 b=e3apNk2eCwXlPIHm0oqZk98w2Z5uTIo9iaZXBHFL0GtdsdBSL+6n+34VjN+ZQQDYMHppkZUiAeYY28TrRCgnvLHc6vfnxi7JjzxC4XAw2fw73EBy3fnDhOBVSA2lEtShiKLLGBpjKLWhqdvVwwSZwjpLgZdsEEesBRMjBJDBvDkWJS3ZJv55jzWmni+bEMN3gT/WsZqe+YsJMMvWDrOpEO/zjnyPWhNTPFYual+tfRcW64HkBcwQKdEqdF14Wk/XPrYW7F99tB12Kw6fIqzgMRy0Ro7oNh6yjKvZYi1iK0DoGgmuqpJsdUsYRuKDWSoS9dTnIcu8gQXZoJsd3Gnomw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ctm0BCMZoTWHosv2ES4NAqA5h2Q9d4q5DfdJJijMhgU=;
 b=UBBlsZns/WNTzkDrFc0qd8WZiiqe5roDMXPocACMLrAA/sx01LJ84A0phA953qoxDLETUjr2XMLpCCYlEu2tK44v4NiEnoJ1bNjUhvuK+dgFPz84YvB2RXGTFi4kSnO/VDo/88oB8WuCc0a04dDuc1ALGOKMuN0J8OurcGmCd4U=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BYAPR03MB4245.namprd03.prod.outlook.com (2603:10b6:a03:18::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Wed, 14 Apr
 2021 06:17:01 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%8]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 06:17:01 +0000
Date:   Wed, 14 Apr 2021 14:16:53 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Jon Bloomfield <jon.bloomfield@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: Fix "mitigations" parsing if i915 is builtin
Message-ID: <20210414141653.07235214@xhacker.debian>
In-Reply-To: <YHXN9lqtdvisT8gn@intel.com>
References: <20210413170240.0d4ffa38@xhacker.debian>
        <YHXN9lqtdvisT8gn@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR03CA0321.namprd03.prod.outlook.com
 (2603:10b6:a03:39d::26) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR03CA0321.namprd03.prod.outlook.com (2603:10b6:a03:39d::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Wed, 14 Apr 2021 06:16:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1a270b75-2d0a-4bc4-6494-08d8ff0cea52
X-MS-TrafficTypeDiagnostic: BYAPR03MB4245:
X-Microsoft-Antispam-PRVS: <BYAPR03MB424583A73CD734E1A8FA1178ED4E9@BYAPR03MB4245.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1mziHeXHbKqt0aSLSwuTcGIbUCQ8Ry1hAaDkmtCHV3BWBQ1IkZRHtvF5oUD4fzXBepf63iCEY6dS9GwQjAuPJw6mBXLjiB2AxTtvbY+qlhjy3alBzfdsfIknfU0qHSC5DTCBtN8DxjR0E88T6jqWeccttTOmIK2Lf4dUr00+fVoKazuni84aNRD+fuiobdoYu29SlsRGoX+95NY+uhA4cO8K/hUYcBxtvX3ciqFD+Hy18vauTRqE7WSAcp2W5GqYCk2n4u4ArL6B8kQLW0wMAYs/MaRhsrHvTTbHJoiuzy7o3tqxAx4SYrGqbtLG+xK7iMYzfYN2NaiP/7m5K3TMUDn5O3QfKDnJm2gnHolHKgxl6Z80PAI1GZHY/LyNp6lKtlQxarsHpmSooSuZkMfKxUapBhJSIP9o1NV4NZ672XIhh61UZkPWQI3w+Gr8XZknw8d3xz37l96J301uCFTqyDDC33n2yYYUmaNuphhm2X6NYFwc3dbIz+ScCsv9mIEWOHoi7724xpvzyShwmFjXFDiFHGjh4dJQARbBIJ3jwSe6GWBV9575zdFHSsCd66sCD2Cqdax6SwWuFGjKW6S/ufMp+WQrJvfhVs1qSvrU5h4dlocjLwEmOfIEfjalmnH8Czbx+qu0TknEqVgIo6/nYKE6AfTyo0+69BCUvw5M/6s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(136003)(39850400004)(376002)(366004)(396003)(956004)(2906002)(38100700002)(186003)(1076003)(38350700002)(66946007)(478600001)(54906003)(6916009)(66574015)(83380400001)(9686003)(16526019)(6666004)(6506007)(26005)(4326008)(66556008)(316002)(7416002)(86362001)(7696005)(52116002)(5660300002)(8676002)(55016002)(66476007)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SXB1aThadVUxTy9mOVJTUnZiaSttYTRacU1hWnl2b0p1bElTVDV0dXduMWI0?=
 =?utf-8?B?cjZGTElPeUxja24zUHhjUmVOS2lSSkxRZzFrcHVnNDlYRDkxbXd4aFVhNVVE?=
 =?utf-8?B?UFEzaU14dFVmVE9yd2JJeDJQS3h0RVZqOE1vQ1JFby9qVk42Rm5Nd0xKbTBx?=
 =?utf-8?B?MFhVVStUYk5sT0M2cWRhZTBycVpzWnFMS053RnJhMjhudmlWVi9hRDN5ZkNu?=
 =?utf-8?B?VXZlK0pCWmFMVlpPNWxNdi9WcVNydFVDVko2UExIcU85bHJqV2dkekRxSjFx?=
 =?utf-8?B?ODdOVzRkVzMwV3RuVTNoclhJYUsrSys0bmttTTJLL2JBVTdGVkJYa3pZOXgx?=
 =?utf-8?B?SFV5aXhnUUk2RjE1S1BRSklPdXpSNlN1QnB0Zk02ODVac0JPMWdVWHBudlRF?=
 =?utf-8?B?Vll0U3o3REloMTUrL3gwQmEzVlJ6aGU0Y3J2bTl6Yzl3Y0pkLzZBS0NjWm4z?=
 =?utf-8?B?YWlabWN3UzVZTlFrcERpVVBxMXlkZzFUbXlpVlVCMm9LSlh0MExacklDSy95?=
 =?utf-8?B?a2JjYXZFTC9WMmJBYzh4cy9kSFhyM25Pd0FxNGpKNmlLWFJMRlJNYUlQc1Zs?=
 =?utf-8?B?MW5XWUFJQURLZEJSMkhycjU5WXlxdHVUMjRxVldDYmI5a2lSbFVVcjVFaGFQ?=
 =?utf-8?B?U01FdU5YQm5nN3F6QnRQejdXVURaVGNaNFhyR1RhWjNPNlZJMWkzR1NRcFR1?=
 =?utf-8?B?STROMWVhMjJOMnJjL2psc09JeDA2V3JnRG5QaXpaeHV5L1lKQXpNbU4zWGk1?=
 =?utf-8?B?eXRHNEhucERBYUxKeDdtaVFFVXBTWGFZcFNxeExrSlpOeWRZQTQzU1k0cjEv?=
 =?utf-8?B?eDM5cWVUbmpQc05YT0orOEF6OGRnTXdXTzc5LzdyUDFaUmFNSzM0ay9DTDFW?=
 =?utf-8?B?UVgwVVpiQkNRZ3JiOXNZSCsrYWkvQjFvVDcxWG9TdmtIKzBSeFdPUGVkdTFT?=
 =?utf-8?B?TXJIdDZGMkFnNGhmK0ZTS0UzNGUvaklNMW1LNTB3N0ltenFiUzdLdmhiNFZU?=
 =?utf-8?B?VWIzalFXeCtGdTlKQjEzbDhmaWw5TlZ6TjFUQTY3bXdFTW5ObkZjTzFnM2xQ?=
 =?utf-8?B?VUppVXEydmFnQytNSTRDdm9tVVJMWUp1aVJhZ1MvUm0xa0VXWEtGUUJRejNF?=
 =?utf-8?B?L2h2clI5ZHVtbk9SWEVGL3k3WEVHTis3aFBpTFRsZCtUM1JWWGQ1WE9UZ01E?=
 =?utf-8?B?R0NwaVg2UmtDSTNNVFZ4NHdpSTJjUDJpUVowQjQrYUhHNlZ0dXphOUIvazN2?=
 =?utf-8?B?VXpVR0t5b3NGNmJucjlERDc1SXkzbFZUSGE0OFRPbnkvcDlzWWZGaGZXSGx4?=
 =?utf-8?B?dndIcDZXWFBNTjBWQmp0emJHQy9iSjNkYS8wZUhRWjJhUHVSOXBxekZBWU9w?=
 =?utf-8?B?RHlOTTRadXRJYTQ2Mnc0ZEVvVlpwNzIwQ0Z3MzFKeXBhdFlNWExBaVRFbkxG?=
 =?utf-8?B?cEhiTWR1dE5yZ3M5SU5udVBWeDBPMGIyekZrSUpWLy9lQ1Q0Zk44dW81a2hS?=
 =?utf-8?B?cVJtZDE2MWFOVGFEWVBjWXdVc3M5bXUzZWRaRHcxR2dGQXhSQW9rMVo5UUdr?=
 =?utf-8?B?bGF1WE5KMDFKZTFpTWZXN3N5OGwyK0JWY3FCbVkvN1EzWGZieTF5dW9VVU9y?=
 =?utf-8?B?R1lCS05tSTlHQVdUeldEUmY1SnBOWkNUQWw1NkFoZ3FHNkNkcys0YmlqTUhX?=
 =?utf-8?B?dTVhMEkrRnQ5TE5FelllSEtjMksvd3RiTzBBS2g2YXBXK2Z1V1E3K0ZpT0ta?=
 =?utf-8?Q?1ZstA8ixTU+46pXPpQLI9V90XdrnFSaUsQiv2wm?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a270b75-2d0a-4bc4-6494-08d8ff0cea52
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 06:17:01.0257
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zgv6/QScLfxv7+cJlLEnIA5YMGSvFRFBgY/QOm+vSbqTlKd6FIdfg6d4+qn8bml/V1ScRisIMwynXNiWtor5OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4245
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 19:59:34 +0300 Ville Syrj=C3=A4l=C3=A4 wrote:


>=20
> On Tue, Apr 13, 2021 at 05:02:40PM +0800, Jisheng Zhang wrote:
> > I met below error during boot with i915 builtin if pass
> > "i915.mitigations=3Doff":
> > [    0.015589] Booting kernel: `off' invalid for parameter `i915.mitiga=
tions'
> >
> > The reason is slab subsystem isn't ready at that time, so kstrdup()
> > returns NULL. Fix this issue by using stack var instead of kstrdup().
> >
> > Fixes: 984cadea032b ("drm/i915: Allow the sysadmin to override security=
 mitigations")
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/gpu/drm/i915/i915_mitigations.c | 7 ++-----
> >  1 file changed, 2 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/i915/i915_mitigations.c b/drivers/gpu/drm/=
i915/i915_mitigations.c
> > index 84f12598d145..7dadf41064e0 100644
> > --- a/drivers/gpu/drm/i915/i915_mitigations.c
> > +++ b/drivers/gpu/drm/i915/i915_mitigations.c
> > @@ -29,15 +29,13 @@ bool i915_mitigate_clear_residuals(void)
> >  static int mitigations_set(const char *val, const struct kernel_param =
*kp)
> >  {
> >       unsigned long new =3D ~0UL;
> > -     char *str, *sep, *tok;
> > +     char str[64], *sep, *tok;
> >       bool first =3D true;
> >       int err =3D 0;
> >
> >       BUILD_BUG_ON(ARRAY_SIZE(names) >=3D BITS_PER_TYPE(mitigations));
> >
> > -     str =3D kstrdup(val, GFP_KERNEL);
> > -     if (!str)
> > -             return -ENOMEM;
> > +     strncpy(str, val, sizeof(str) - 1); =20
>=20
> I don't think strncpy() guarantees that the string is properly
> terminated.
>=20
> Also commit b1b6bed3b503 ("usb: core: fix quirks_param_set() writing to
> a const pointer") looks broken as well given your findings, and
> arch/um/drivers/virtio_uml.c seems to suffer from this as well.

wow thank you so much. I will send out patches to fix them as well.

> kernel/params.c itself seems to have some slab_is_available() magic
> around kmalloc().
>=20
> I used the following cocci snippet to find these:

Nice cocci script.


> @find@
> identifier O, F;
> position PS;
> @@
> struct kernel_param_ops O =3D {
> ...,
>         .set =3D F@PS
> ,...
> };
>=20
> @alloc@
> identifier ALLOC =3D~ "^k.*(alloc|dup)";
> identifier find.F;
> position PA;
> @@
> F(...) {
> <+...
> ALLOC@PA(...)
> ...+> =20
> }
>=20
> @script:python depends on alloc@
> ps << find.PS;
> pa << alloc.PA;
> @@
> coccilib.report.print_report(ps[0], "struct")
> coccilib.report.print_report(pa[0], "alloc")
>=20
> That could of course miss a bunch more if they allocate
> via some other function I didn't consider.
>=20
> --
> Ville Syrj=C3=A4l=C3=A4
> Intel

