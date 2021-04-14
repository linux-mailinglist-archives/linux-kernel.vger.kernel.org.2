Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 201FD35ED58
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 08:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349267AbhDNGlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 02:41:24 -0400
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:21345
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349260AbhDNGlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 02:41:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LSRhXMyWpv3RqBCJ3SdP+SqLF44WOHiEhgzxtZoxIaadVE0nBqmVNSrlO8CErUo73pykdnr0w5GVXby1QZO8UN8MFB0fPkrSbptAryfG2GsAyGaXjE7OfDRR2VZrizXmUcZ0m2Vr4v0Q7n6jz9Vq4ZkzZICv6ySh8XNttE139ylRf6ww9v4SgIL592SDZv9PwtZW7eJXK1c8iIFA2QhXQ8dqrSy5NVzNM8/6efgTLSLk2wELISOqo3xklfJdaMzlCP0Ou7P8jW6ven87Q/9nnXykgWygyABHoPXmSVIX7antm7FV69VFY5+LArh7RrjwC+ZD2nOEP51sVYOBVt83tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAiUET40OAF35aY0qsKAMN9sTr8csAvCWP0w92wtBzc=;
 b=IQjZo5RMFAUqxuNzIRbMX/v+M/TDj5qRWLsUEbz/KmTbai/AdnFVFcE3KkoKDD5QQU65DJrsyUy7fw/VXdLdfITnchmAAm9FsovTTP+dn0mEbQqL5B0K2ObHnr7fVutlgptEXCQSAPskk4BcXWtFmr2iDjLrWT2YaQkZY9e/yKvRbV+cGEv5WitOwc/2pcb1zETo2lg8p9XvgZ5T6i5PMGOSXg3k2nMzKcc6udfsajiDOSYson5sE8KUE5V4iBSPOJgdfn8HxrniDVogWhNgWkflnerA5bV8odC37iA+SaZFWvnVUPf19XYB4mKJJCxBpW/wZOpVE86K+Ggbe8vAPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAiUET40OAF35aY0qsKAMN9sTr8csAvCWP0w92wtBzc=;
 b=hzXKSOiTYO1CM7oAyGt5jnfck1EcIDmswQM9Xq0WZZ+dBLMR4MCIHB+wxdjK92+75k9ZcS67Dw0MvwgBDg1c6JXjv4KBsCg8Dlh1zTgrctw9vzCersjXRxKTjFpcuI2+OvTb44VmjkXFwCbGdL+sYbpoyvMH+DEH+lJG0IPOgF4=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none
 header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BYAPR03MB3942.namprd03.prod.outlook.com (2603:10b6:a03:6c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Wed, 14 Apr
 2021 06:40:56 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%8]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 06:40:56 +0000
Date:   Wed, 14 Apr 2021 14:40:46 +0800
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
Message-ID: <20210414144046.7641b845@xhacker.debian>
In-Reply-To: <YHXN9lqtdvisT8gn@intel.com>
References: <20210413170240.0d4ffa38@xhacker.debian>
        <YHXN9lqtdvisT8gn@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR05CA0005.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::10) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:33b::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.6 via Frontend Transport; Wed, 14 Apr 2021 06:40:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f295545c-d48c-4472-8bb3-08d8ff104199
X-MS-TrafficTypeDiagnostic: BYAPR03MB3942:
X-Microsoft-Antispam-PRVS: <BYAPR03MB39425F78A782BBC6056DEB12ED4E9@BYAPR03MB3942.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1Agdc9ZOk29XArNsBczUrFd6flugjqgyUc6dXcSto9vOGxTDsyd+cXF3uBOreN3fndjtpUftqwK/yFoUUVG/g+wgBYIhOrq9SWFe9aM4t7dWdbpxjFWZLtJNMausLrJcFPMhDasNVNLQ157oPByuFDQrwV44Fg6NaQldqIfZc1ehJYbkcFSNiaGcCXQGExduBGeZ7SahFKKHZT9pdf/PLhnR5ayiNpE9cTL/TNOoxe6qPaJ4UE7hc70Wa/jVgVmwSOsSB2mu8Arm4RiICJHGxrfo4/Z6jRg6WkiEO+qfBReKShbn1TehpbSWwAD44BFX8eHGCAh7571mE0/Ayp+1YujNAGQCWlbMP2aC+9g8loBFr0MgQuQ1UHFXzGL12IanidbyYk4QHip3sWc/wOGurQmiKIReliy+aioy1igZyhAzrtmME3y2ToPXF8/QzLfV/t66eRZY3uUXQNM7JRY0E0qBqj6UcHQdW0PhbHRGUau8MeW/678kfFhu02Z5G0ah+UyXuf6EIaYTqI7UdY3BvDIoHUU+uaLWltJPKzLVOqXitCmESDofhIzK62wD9XfVmhlxvQXjqvERww5L8IFvtZxkMpoCRXXhtW+hCKVQftCDBk6lABeTUQwoPMBgurdL6mC4nthKyF6J74Ay+KvTZQNC0+0aGohxwxvSS0Ctfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(346002)(376002)(396003)(366004)(136003)(83380400001)(1076003)(7696005)(4326008)(9686003)(186003)(86362001)(8936002)(6916009)(55016002)(26005)(316002)(6506007)(956004)(7416002)(66946007)(52116002)(54906003)(66574015)(2906002)(66556008)(38350700002)(66476007)(16526019)(8676002)(478600001)(6666004)(38100700002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VEpWMW43YWI1YS9kai96Mm9zZEUxenAxeGVnZXpUV2RrYjhWSExHOVNRVmM5?=
 =?utf-8?B?ZHVJWFkrTGZyTHYyeFhaV3BlQ3BUTkhIQm16a29KaEh6dVQ4Nmlwc2FGcFZS?=
 =?utf-8?B?RjJJcEVLY1Y0dnB0UmNENFl6NnpybXhVT3Q1ZytnUERZQU9NTkJ6RDJwU3JG?=
 =?utf-8?B?NmdxNWxSWTVrN213dnljM3IxTHhHeWl0cjAwb1ZlL2NNTVloanU3Nnp0bnlU?=
 =?utf-8?B?MXNrR1JlQ3RjQ0FNc2RVQzNuMDUzTTRkSGs4a0tSVHNUeFFLSWREakFZT2p6?=
 =?utf-8?B?MFV3RGZLK2FLY3lsWENhQUJpZUxJWjlUbEpkTmpwNUIySU5WTk9HRFA2ZU1F?=
 =?utf-8?B?UGQxKytJbURGRmM3eHdDRWIyZmJvaHQ4YXo4bXhyV1Z5T1NXODl6U0dqV2tM?=
 =?utf-8?B?STRqRDd1T24wYlBFL04vaTVrZk5pY0V4S1NLS2YxZXdhWkIxd05TOXJCR3BN?=
 =?utf-8?B?Um9yS0drcEx2a05lVDRDaGlCYzlKOTVrUXhhcmpTZmxLV2htd3BJVFkyaVFw?=
 =?utf-8?B?RFJRMVRLZzhvRFZsMlJJbktIREtFeWxEbVM5TUJ1Wm14OFJEcDlQYkZESGpE?=
 =?utf-8?B?T3pmT0luK2E4V2krTURySDhkS0Y3S2NYVGJXeElJdU9oUC9aV0tiZWw0RkYw?=
 =?utf-8?B?ME1jUVFKdktwMWhYaGw5Y200a0wxYnBnbS93SXJUREJpVkc2MUNGQXBoMGJD?=
 =?utf-8?B?WWtCbFRuc3JxTnRjd2hOUThLWU1TaWNkNStOOG81cTRDT0xZNWorSUo2d2I0?=
 =?utf-8?B?dnkxSHNCWlYwVkFFc3FtOHIzRzMxWEhsWlB0U2poV0JtT0dwNFU3NVVGQU4v?=
 =?utf-8?B?a1VHVmFIZTNIRW16cGhIdkcvSXpnNzY3QzlKYngrS2NheFc0R2pnY0N4S2V2?=
 =?utf-8?B?TGsrV1N0RmNBeDF1NTlkMDQ2NFFMN3dqRVk4ZG9oaHhuTFBBOTJyY0dwOW1x?=
 =?utf-8?B?NmUxTW9OSWVzYjAyUUhXWVJvZjRuYjE2NHlDTklBbDIvSUNjakpYMmZqYUZy?=
 =?utf-8?B?TUluTnBYZXFScksvYnd2VmZqS21GamJ4UWFjSk1MSFhJNFZkWDFwVGh2SWd3?=
 =?utf-8?B?V2pabk13UFVYT2lvVlk4cTEvdkxRZzdyNXNiSmlpbThXdmwwZG5XclRuWG1K?=
 =?utf-8?B?aTRteXRzckNhTXJQVjlXMGxmaThoZ3o5TXpKZU9mNE5LclpNUmFXVGJOcE9k?=
 =?utf-8?B?cWFpbWNiazZRUGNpNVlubjl0Y2N3YVRhQXZUVHhVYk0xWDBnM1N0bmpFL3B6?=
 =?utf-8?B?d2cxOFJVS0NRL20rbkhkSVo4VTEyNDlXc0VPVDdIL3ZzMU9RbUpQazIvZzZn?=
 =?utf-8?B?MHZDWHRNZU1Rc2ZIWjk3SlZJNkpweENmNkpRSVFUeVp0WXJ0QTdFQUsrcDFx?=
 =?utf-8?B?OFRwQ0hjTnlvT3ozeEdiWnB4eXRySlFmUmQwd214eTRSQThVWndkMW1jRSsv?=
 =?utf-8?B?NVJNVC8wM00zTDRpSW01WDY2NE51SzBkK3p2aHUxNGpZdk9RY3pkYlllam9H?=
 =?utf-8?B?SHVseTlnd2JIdENscG9IZm91d09JeWhkYWQwMi9MUDY4MTNPbFp1Q28walNE?=
 =?utf-8?B?VTJ0aWRURWMzT1ZlbWdCcWs2OEtPSXNJcW9HZWUxVWVSZjRFTnFSTkVnWWhi?=
 =?utf-8?B?anlTa21oQ3poNDVobzJ3S2hsUndFWkdJQzJmcmJubGZNSk4yMXdtckdvS1R3?=
 =?utf-8?B?MmRmSmthRFN2dE5uNmQ1QWEvWkp0OThFc2h3NWs2Z3FCVFU4N0o2T0EyT3JK?=
 =?utf-8?Q?IyDBNq8HDSp6IZkFHxx635I6UC35m0BYYqx/MTV?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f295545c-d48c-4472-8bb3-08d8ff104199
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 06:40:56.0366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8+w2LvWvi/f6XVVQQGpqDGwosTuRmGeZ06nEkFLENkPT+R+rGwI1fGlVGbujzx8eN/dEyE8ALqD+f/XKCQUczg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3942
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ville,

On Tue, 13 Apr 2021 19:59:34 +0300 Ville Syrj=C3=A4l=C3=A4 wrote:


>=20
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
> kernel/params.c itself seems to have some slab_is_available() magic
> around kmalloc().

Just tried the "usbcore.quirks" with usb builtin, I can't reproduce the
issue. Futher investigation shows that device_param_cb() macro is the
key, or the "6" in __level_param_cb(name, ops, arg, perm, 6) is the key.
While i915.mitigations uses module_param_cb_unsafe(), in which the level
will be "-1"

arch/um/drivers/virtio_uml.c also makes use of device_param_cb()

thanks
