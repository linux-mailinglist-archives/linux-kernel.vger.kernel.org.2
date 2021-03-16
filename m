Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2510633CBA9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:02:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhCPDBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:01:49 -0400
Received: from mail-oln040092254088.outbound.protection.outlook.com ([40.92.254.88]:2368
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230087AbhCPDBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:01:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GaWWHHZDywqdhdKudIMFB9Di59+jpAorJYvwFOfh3MfY9STascKn/Z8Fwt3MKxPM7SpUc/1Hd8I03OMPi7TnVN7X/+C2/lFvcS85XW/cTFIj0DwB1snu99YXChjR3h0KGQwlyPA/bh0jZiGlX4+v6rDidYLisySNOIeQ3+PRXF51jLh3OuOpF0DIg5RtKXODm6QyDMOK3Dr/YvmKIky8TC9xGMhrlpx5kAOyLN4nG9/koGMrCtkQ+s+BqvIjarKUWPD6Y9yFQygzx4lormPelzNzpDCZddUX3izBAKWI1tDi0JjAJlup3OGaylxq4mOmcUJn8MYMpdaZfFMPIZqQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tyl2hoYLel169cE/+mDQDd0Lt5fJA9qZWU4FnGNXbJI=;
 b=dTmjfzJHZa/dJL81Iw1Rj2Qi/Vy5VN978P+bRDG/fcIa/51cjhnKsga2xhwsc/tsbPrtW0NsdSmi265Ok7GO7mlWNPKcaQ8WF6ZVZW2L2QnME74gc+1SHqDg7rWZgrxMcZvNdDfjapqmSqegluXSmlT9KQ7dGNsagsYTpdgqtpw4TiFJLv4y2QXHky1oy2bSlTj5dj0Pb2MwVKPEd0XYwIkJDyvoJ3LtfmS6KzRC4/SRtx39c8NXVQi8Y6y93AMfJpDdD5Xyv+jI6GLtN4JnWyhqnk0Aif1Jju47dKUlalBG/Gg0+CZR+TZRdBj6wfH9oe0Yvc6HUsVCw81ddvC4kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT112.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::48) by
 PU1APC01HT107.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::294)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Tue, 16 Mar
 2021 03:01:31 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (2a01:111:e400:7ebe::4f)
 by PU1APC01FT112.mail.protection.outlook.com (2a01:111:e400:7ebe::234) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend
 Transport; Tue, 16 Mar 2021 03:01:31 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:A71994C38A722B276A6B0B8151E5A819E574EF0A32B29142B8B4D00A3D82D83C;UpperCasedChecksum:E54319A6D39A535BD78296725950F8AC6D09223ED29BCB43D242B4A308D4BBEB;SizeAsReceived:7862;Count:46
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::415f:2d37:68bd:23eb]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::415f:2d37:68bd:23eb%10]) with mapi id 15.20.3933.032; Tue, 16 Mar
 2021 03:01:31 +0000
Date:   Tue, 16 Mar 2021 11:01:23 +0800
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/1] amdgpu: use MMIO to init atombios if device is
 Thunderbolt / USB4 attached
Message-ID: <PSXP216MB043819E5E33ECCDBBAB490BC806B9@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB0438E23D0F4C2DFF2D9B8686806D9@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <CADnq5_Mqc3H07BtJbaGpt8XGnpXgaZvxDsS_e0cnZ++kWdQR-g@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_Mqc3H07BtJbaGpt8XGnpXgaZvxDsS_e0cnZ++kWdQR-g@mail.gmail.com>
X-TMN:  [r9NpVUoPQFThsq+AuTNDAXK0OZRmt7olp+BGynrQ3uFCKDPdYNfh2/P2oG1kuMHj]
X-ClientProxiedBy: ME2PR01CA0097.ausprd01.prod.outlook.com
 (2603:10c6:201:2c::13) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
X-Microsoft-Original-Message-ID: <YFAfg8ATzQZ6E9d0@nicholas-dell-linux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nicholas-dell-linux (2001:4479:c200:d00:bf6a:7b68:e41d:33a3) by ME2PR01CA0097.ausprd01.prod.outlook.com (2603:10c6:201:2c::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Tue, 16 Mar 2021 03:01:29 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 46
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: cc5dffa9-f035-455d-caa7-08d8e827cc66
X-MS-TrafficTypeDiagnostic: PU1APC01HT107:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u47nhmnikYiAwuQ2lgOV2/7biV6MObewTFipuxQCp6BHyz1/UDz2QlQnYNUBVIYAvE0ZX2e3U1YF02IuFpymNTS30RYCrOzs1SUKbfNyF6Z0NoLFO2T1u7tiPglCve2nzrhC2OjTfdqfrLyCas4ejudOr8yt6pe+CMkh3WMW/Vq1NMLD7tpRqwU1GVMVab2gIB74OQTxFqyQK2gcLZN1CeniTyj905DuNCtqUyV+gK+/FzWLqsuNc1UHYhWFK8UhHyOEv4A1T2atiTMQb13TihbBTs67xTpjHdsk+OMgplTWtzUi2ZSDILnSzd1Lj39hA/eWAGRFy6RzKsiETjX4unr5XGgE8+DgoUq3jdEvv4JCP7yKM0mGMnKR6h3KJvmQfgoyF9tClgKlFTYowYqoZWCcL0/cxH+CvEVmSDPvpwY=
X-MS-Exchange-AntiSpam-MessageData: AfF/7hTzchJA5XiyLc1IhaaxmnrL9it/Bcdu+g9wC++YHlaiBPcNrQ8qqFvGpj8j7le+z0XKMY3o5e4dFMiduM1dmS8640KzShsHoKaUwvirVlQvZ2idFbfd94uLz4vif4D8cmD1AEN/etm2nUfhkttQgfiPTFNx9ZkcHb6O7PkWmYlz0IrWRaH9PAkD6fyKpLd8wSp3oDQJ3VNkDT7c2A==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5dffa9-f035-455d-caa7-08d8e827cc66
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2021 03:01:31.4437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: PU1APC01FT112.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 11:05:21AM -0400, Alex Deucher wrote:
> On Mon, Mar 15, 2021 at 4:04 AM Nicholas Johnson
> <nicholas.johnson-opensource@outlook.com.au> wrote:
> >
> > When using some Thunderbolt hosts using BIOS-assisted PCI enumeration
> > with IO BAR assigned, we get an atombios timeout, such as:
> >
> > [drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in loop for more than 20secs aborting
> > [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing B456 (len 304, WS 4, PS 0) @ 0xB51B
> > [drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing B104 (len 183, WS 0, PS 8) @ 0xB17E
> > amdgpu 0000:08:00.0: amdgpu: gpu post error!
> > amdgpu 0000:08:00.0: amdgpu: Fatal error during GPU init
> > amdgpu: probe of 0000:08:00.0 failed with error -22
> >
> > A workaround is to use MMIO to access ATOMBIOS when device is
> > Thunderbolt / USB4 attached.
> 
> Missing your signed-off-by.  Also, we can just remove the legacy IO
> callbacks altogether.  They are leftover from radeon and not required
> at all on amdgpu.
Sorry, it's been a while; I forgot "-s". And I like your patch much 
better. I look forward to the day when all new PCIe devices only have 
64-bit MMIO_PREF BARs.

Thanks for looking at this! If you are still doing work on surprise 
removal / driver unloading for Thunderbolt, then I am happy to do 
testing for you. Removal of DRM devices in Linux is the main sore point 
for me, and I would love to see it through.

Regards,
Nicholas Johnson
> 
> Alex
> 
> 
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> > index 86add0f4e..5d16ec10d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
> > @@ -1999,11 +1999,15 @@ int amdgpu_atombios_init(struct amdgpu_device *adev)
> >         atom_card_info->reg_read = cail_reg_read;
> >         atom_card_info->reg_write = cail_reg_write;
> >         /* needed for iio ops */
> > -       if (adev->rio_mem) {
> > +       if (adev->rio_mem && !pci_is_thunderbolt_attached(adev->pdev)) {
> >                 atom_card_info->ioreg_read = cail_ioreg_read;
> >                 atom_card_info->ioreg_write = cail_ioreg_write;
> >         } else {
> > -               DRM_DEBUG("PCI I/O BAR is not found. Using MMIO to access ATOM BIOS\n");
> > +               if (pci_is_thunderbolt_attached(adev->pdev))
> > +                       DRM_DEBUG("Device is attached via Thunderbolt / USB4. Using MMIO to access ATOM BIOS\n");
> > +               else
> > +                       DRM_DEBUG("PCI I/O BAR is not found. Using MMIO to access ATOM BIOS\n");
> > +
> >                 atom_card_info->ioreg_read = cail_reg_read;
> >                 atom_card_info->ioreg_write = cail_reg_write;
> >         }
> > --
> > 2.30.2
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
