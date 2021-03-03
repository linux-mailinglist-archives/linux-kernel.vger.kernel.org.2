Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6705832BFF5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386347AbhCCSOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:14:43 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:36551 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449286AbhCCPoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614786239; x=1646322239;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iYlE76sMi6RoE2zZ2UAVek5NzgKjFO6xX9AqZXR7QDs=;
  b=R5rwYjOf8pWLx8Gcb8qBoeoqxDFrEeiSMsB8exnUxE56cSNqIrxfCkSf
   xoB9TEEp5KEaX4iMf+9weg2tsBUIDEvi0UtWuZEVqLaPtrqn4C9cpbyx4
   b6gOot3ohIz76tPGd9bgi8GUl+L7SGjZpPkW7b2LgcU4iwgSsU9G2FSId
   JnI1yWr/Z9lqOMhyRCaa8ntBBkJppq3sS6ul7YCPAj8BLxFFpwbtJP+8c
   zUfXvS2Gc1qmW9Hn0WOvQjf+2wAst7cd1MpTLo9nb/ascWuGLYW1bFngU
   oozscoXeOgRweEazMUdcrAngaqPYy6zohFYG6f7YXpcVoiwyI/DeW/piy
   w==;
IronPort-SDR: 37UYwhfKIDiNQij6vQB/IK+MOgkzNPKCqvSMD53S+jh6PZqWSPcFb30ImNpoPjPoE/wTtLuz5N
 VrB5DAtBtnG8G20GASwhROre1x1p/7IhOmyA0Nt4bn/ZHWWCOTlbcjpRfEklqcNssdkdCV0ZFb
 hkXWAxNUS+dENBfoCl9ZExvbynea2P1DGC5eFSV862d1awG3OgKU3DVXvCciiM/OpDMqjuTDvb
 xMM/2jaYxCx+aF3uzySIhYQ3yH/dfi10nCR5uHpApUoZsThV11qpZn0SPkE7J7ZwByVTh1pNMP
 A/o=
X-IronPort-AV: E=Sophos;i="5.81,220,1610434800"; 
   d="scan'208";a="108624761"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2021 08:42:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 3 Mar 2021 08:42:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Wed, 3 Mar 2021 08:42:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V27mLiy6Nmm1oMiT633mkuXpKgnWAiDNgUNurekTrVMy68nBl11NRRuvZrNoasm9jXlKstWkBDQbgZh1rOnO5nWjbuVa2LQFEP1TrW/i3i/1voc85wAth9oDl1j+pghbf0EUUTi1bCPaHLfZ1g3CaWxPPqJU8oaq9Hz66CYxYcMuJvmU3oXLqidV54z4AsrYTcpZBF9Va8K+A9wA3oaZqpbix+XK/pmytW+rpLcKQljJTtWXyrr8wrpSR6gc8DHkAij/4hU8A/rZcCYvFrdOR+8RHMKd+QYvhRrSwwOXs/fRiZL8zO/q1v/kK65h90xpHhZ5944Sr08o8Fz7ygeJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOIpPg8oLReTGZVxYCrGx//uCdW0X5J+qMU06CphduY=;
 b=S+lnx3Ko5dl+Y7kOFUmD6SrJWUCvDcwJRNjAHjD1a/Q8gtfO3p5vBDsllb63qM+v3LFfWCKRp+sL8c0zocYXz6DpI/wWJ0JAEplku6KJ58OJlPRj/ZZZf7NgxK0G85MYMyAKiBJJ6VpihDGzCwE3+vQ0/HtS7IN5Crg4Tdzx852n2YV1A10YqWBV0aZ1orlPI4izHXH0NDaStAr44cSKMuNoqjb217o8bL00E26M/ckkffh3F+qYRkkQOr5QJwVsXzLz8iw2e9ryEPEKDjgBBMro0gcX9xjvZCuxJ4KI3FzF+53cWr9YIKZ51EEy2B6p4xc27WU2soP6EElAgsVxVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOIpPg8oLReTGZVxYCrGx//uCdW0X5J+qMU06CphduY=;
 b=ay93GcnHpY+q0mfVOnY/Gqqw0JE76iA2itN1JY4MOmvTw0SKiXu9u7E4Mw12+KozJOGW7g6+l/8xYJHaL1T4eeubDwYFSBkwUsU1IEzRPdiWxSFRAtVCgKwXGbclbhuT9CkN8tPM8wQ3shg0Cd+x1z3Go/on2U79kES3L0e9ggI=
Received: from SN6PR11MB2848.namprd11.prod.outlook.com (2603:10b6:805:5d::20)
 by SA2PR11MB5067.namprd11.prod.outlook.com (2603:10b6:806:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 15:42:39 +0000
Received: from SN6PR11MB2848.namprd11.prod.outlook.com
 ([fe80::ccd1:992c:7bc5:4b00]) by SN6PR11MB2848.namprd11.prod.outlook.com
 ([fe80::ccd1:992c:7bc5:4b00%3]) with mapi id 15.20.3912.017; Wed, 3 Mar 2021
 15:42:39 +0000
From:   <Don.Brace@microchip.com>
To:     <slyich@gmail.com>, <glaubitz@physik.fu-berlin.de>
CC:     <linux-ia64@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jszczype@redhat.com>, <Scott.Benesh@microchip.com>,
        <Scott.Teel@microchip.com>, <thenzl@redhat.com>,
        <martin.petersen@oracle.com>
Subject: RE: [bisected] 5.12-rc1 hpsa regression: "scsi: hpsa: Correct dev
 cmds outstanding for retried cmds" breaks hpsa P600
Thread-Topic: [bisected] 5.12-rc1 hpsa regression: "scsi: hpsa: Correct dev
 cmds outstanding for retried cmds" breaks hpsa P600
Thread-Index: AQHXD8NYByGFLRaE+E6Jw8YXZ2CxsqpyZ9Dg
Date:   Wed, 3 Mar 2021 15:42:39 +0000
Message-ID: <SN6PR11MB284899AF468190BE10031BA7E1989@SN6PR11MB2848.namprd11.prod.outlook.com>
References: <20210222230519.73f3e239@sf>
        <cc658b61-530e-90bf-3858-36cc60468a24@kernel.dk>
        <8decdd2e-a380-9951-3ebb-2bc3e48aa1c3@physik.fu-berlin.de>
        <20210223083507.43b5a6dd@sf>
        <51cbf584-07ef-1e62-7a3b-81494a04faa6@physik.fu-berlin.de>
        <9441757f-d4bc-a5b5-5fb0-967c9aaca693@physik.fu-berlin.de>
        <20210223192743.0198d4a9@sf>    <20210302222630.5056f243@sf>
        <25dfced0-88b2-b5b3-f1b6-8b8a9931bf90@physik.fu-berlin.de>
 <20210303002236.2f4ec01f@sf>
In-Reply-To: <20210303002236.2f4ec01f@sf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [76.30.208.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0c8b974a-1d37-442b-86a0-08d8de5af9f4
x-ms-traffictypediagnostic: SA2PR11MB5067:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA2PR11MB5067ADC77DC71D3659086F56E1989@SA2PR11MB5067.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W9yGcnGqyNWasCRRHvzl0OziJV3J2KkWAF6pSVaHNQhlKAhfV3OmjxNQybrxJeSiSIKLmy605yhjFyVPCbvboOimbClfashcy4grRjcxDDgOTiJlrl+f4PVQxj2xXhVKDLhhwYWzRToyshcJGKs+slKUDnoyCNLdwhTjZ2Tw+zds1ITu9mjqCZpYKZZPsz48k9/WegahRFlP5YvJCxC52UfOcM0L4Zwqcal+1pMZ+EOVtgMsZ8DBysQziLsst45p+iSds28RpJp5zR+AXaGSBC7mPghy/GW0f736naLrZLYfVbJ76B9pvYyn/0/q7gyL55iuxQerkVrs3TdmOEAjSVIjMMDJ2S52FLyxhAtGBR2SJPUTa3Re4lpqsBrMMLwQAuPwz+Pfx4U2LsihQtwNugL926lM8n+UUB9YI8xFYpc8WjLygpSq5AATk3zbaxeNzsbK5hfD8yBnnkBKgPgxajhWEgCYAbLswbkZprIq2gMI+wCD97io6myA+DG8WM1yTgkSkWdhhBIaS65pbyqtKo7B+mSjKM2ohA4K3VYVshXhERI5oFlzkRu/yN1XGFEy+gQtooEUDdemwSUS/9ZllsuZdGmc+murP+plDD6ZLTY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2848.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(396003)(376002)(346002)(54906003)(316002)(9686003)(8936002)(55016002)(33656002)(53546011)(966005)(186003)(6506007)(8676002)(52536014)(86362001)(5660300002)(71200400001)(76116006)(83380400001)(66556008)(66476007)(2906002)(66446008)(64756008)(66946007)(7696005)(110136005)(478600001)(4326008)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?FoiMNvWYkoCrZpcNYjDdFr54wXGca3ANlwX0uPyMEOhKSB3Y76/OMOTaTn/6?=
 =?us-ascii?Q?viEBUee7/OhWG29Talw6/Uru/lsSPLYnMLe+ZXnvp/r+ygDxkZyC+rh4eYaw?=
 =?us-ascii?Q?CvYCStY2eNIBgqbdrjf8d+8MkIujnWw9rJil8gOTDE9Gsdpr3Q1k7u68ye0l?=
 =?us-ascii?Q?WipBbAhHJ5ei4oBT3miPYTY79d5U2ZviCY232FBD6D8xQk5hl4/bcrx1qeAo?=
 =?us-ascii?Q?tU42BCDsL07lJXOxI7VxiODrEUbnB2U+dXeMXJJZPeb1/c+bs3PRAMO0HmaZ?=
 =?us-ascii?Q?GuCbossK3YtPCyiCS7Psx03nfc6i/iJcAX1qd3q5pL+I7nS7g4yC7ms+uo7A?=
 =?us-ascii?Q?kSVw26lyvPG+V7wHUhblgVmNkugqEtr6neJZ0V/+KwNNg/+pURvye7D60mt0?=
 =?us-ascii?Q?fZ0UQ2Mp13PrnKnw+KqYH93gTtSB2ExUtCqkYBHU/I92uhRl45UV/O/JVBIe?=
 =?us-ascii?Q?Peq2U9/HlsPmVm3yTxUuTOZkwz+D/p7vI7M9aQFLjfVR3J7pEyZXhPCJajR9?=
 =?us-ascii?Q?XrDES/7Fi/A5BAZ8AgpJjBTKCQoOTVu9Bne0cRoC5sUPSk0lbgtM2TJD5pMc?=
 =?us-ascii?Q?keq1Em3m6zGPBr41gMZN9Q4ecGGMxj8E7Z1LL3+c5UHftD6fFeIhzv1lZ4R8?=
 =?us-ascii?Q?OHhHWsZyc97EoMHcoXrGDngD+bUO2b78N6h3+wNYi3I26OdpgEULRwWh7Um8?=
 =?us-ascii?Q?k6DpQP46viufNrkpzWjTyUzOerWGVwRBbfi5kwAosWNrirHZSgnZyt9DqZoa?=
 =?us-ascii?Q?zCs26mPUcBeVgRsmNd8scCJn7c/PNJ1HlH9IsMqVgD4xqnMyY12FZL5PGAWS?=
 =?us-ascii?Q?ETjPjxKzFDOL4wpg6dA9EM/EFV3oPoJzVgb3aZZG2Q7hz2tJq+qxyJwpyfxy?=
 =?us-ascii?Q?+LIDMYGDVsZVhNoglTGN0+u7MraidJ5GpR/NEw+EdyOtXQaSWRWPpk492l72?=
 =?us-ascii?Q?RwW8C4zGQtGg/64vYwW4ZfXSWaZX5zeZ6M5N28pIXcFo4pSjukgD64srhrHu?=
 =?us-ascii?Q?uNdGU24T0jIWl4EqicGI8SlMWCsHD2yoHj29htwhg6/CPt999/VPieqBcEQT?=
 =?us-ascii?Q?rDlZ5RQkcSPbBhOCu/eXY9+8gSJjNa3I0GRsb9L2/nOIdeuhdL84E1YOEnO5?=
 =?us-ascii?Q?pGsglmTV74Tyg9zkNAfLRSiggI0lOPh5kQ8IebYbvpWFgKDXE6Dy00GZp+QZ?=
 =?us-ascii?Q?N3x+9NmVLQEX0136CChmX1ChQddSnDMuuJegLDXG5eSvqyMXtHyMWSzfBgvy?=
 =?us-ascii?Q?ekK6OZufe1EqspJNW5y1g6yPBPLjZPovLDhfBMlUy4snm4cUadZtf4jZXfx/?=
 =?us-ascii?Q?7GY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2848.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8b974a-1d37-442b-86a0-08d8de5af9f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 15:42:39.4000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Cr6lxm2uY/crCLI+61yqRYYu6DY3ytf/pWActAsTL0fdmM5bjlm7PDjpHhQpvFtEJ6cqfd146r2oQuE7JNfLgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-----Original Message-----
From: Sergei Trofimovich [mailto:slyich@gmail.com]=20
Sent: Tuesday, March 2, 2021 6:23 PM
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>; Don Brace - C=
33706 <Don.Brace@microchip.com>
Cc: linux-ia64@vger.kernel.org; linux-kernel@vger.kernel.org; Joe Szczypek =
<jszczype@redhat.com>; Scott Benesh - C33703 <Scott.Benesh@microchip.com>; =
Scott Teel - C33730 <Scott.Teel@microchip.com>; Tomas Henzl <thenzl@redhat.=
com>; Martin K. Petersen <martin.petersen@oracle.com>
Subject: [bisected] 5.12-rc1 hpsa regression: "scsi: hpsa: Correct dev cmds=
 outstanding for retried cmds" breaks hpsa P600

EXTERNAL EMAIL: Do not click links or open attachments unless you know the =
content is safe

On Tue, 2 Mar 2021 23:31:32 +0100
John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> Hi Sergei!
>
> On 3/2/21 11:26 PM, Sergei Trofimovich wrote:
> > Gave v5.12-rc1 a try today and got a similar boot failure around=20
> > hpsa queue initialization, but my failure is later:
> >     https://dev.gentoo.org/~slyfox/configs/guppy-dmesg-5.12-rc1
> > Maybe I get different error because I flipped on most debugging=20
> > kernel options :)
> >
> > Looks like 'ERROR: Invalid distance value range' while being very=20
> > scary are harmless. It's just a new spammy way for kernel to report=20
> > lack of NUMA config on the machine (no SRAT and SLIT ACPI tables).
> >
> > At least I get hpsa detected on PCI bus. But I guess it's discovered=20
> > configuration is very wrong as I get unaligned accesses:
> >     [   19.811570] kernel unaligned access to 0xe000000105dd8295, ip=3D=
0xa000000100b874d1
> >
> > Bisecting now.
>
> Sounds good. I guess we should get Jens' fix for the signal regression=20
> merged as well as your two fixes for strace.

"bisected" (cheated halfway through) and verified that reverting
f749d8b7a9896bc6e5ffe104cc64345037e0b152 makes rx3600 boot again.

CCing authors who might be able to help us here.

commit f749d8b7a9896bc6e5ffe104cc64345037e0b152
Author: Don Brace <don.brace@microchip.com>
Date:   Mon Feb 15 16:26:57 2021 -0600

    scsi: hpsa: Correct dev cmds outstanding for retried cmds

    Prevent incrementing device->commands_outstanding for ioaccel command
    retries that are driver initiated.  If the command goes through the ret=
ry
    path, the device->commands_outstanding counter has already accounted fo=
r
    the number of commands outstanding to the device.  Only commands going
    through function hpsa_cmd_resolve_events decrement this counter.

     - ioaccel commands go to either HBA disks or to logical volumes compri=
sed
       of SSDs.

    The extra increment is causing device resets to hang.

     - Resets wait for all device outstanding commands to complete before
       returning.

    Replace unused field abort_pending with retry_pending. This is a
    maintenance driver so these changes have the least impact/risk.

    Link: https://lore.kernel.org/r/161342801747.29388.13045495968308188518=
.stgit@brunhilda
    Tested-by: Joe Szczypek <jszczype@redhat.com>
    Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
    Reviewed-by: Scott Teel <scott.teel@microchip.com>
    Reviewed-by: Tomas Henzl <thenzl@redhat.com>
    Signed-off-by: Don Brace <don.brace@microchip.com>
    Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

Don, do you happen to know why this patch caused some controller init failu=
re for device
    14:01.0 RAID bus controller: Hewlett-Packard Company Smart Array P600 ?

Boot failure: https://dev.gentoo.org/~slyfox/configs/guppy-dmesg-5.12-rc1
Boot success: https://dev.gentoo.org/~slyfox/configs/guppy-dmesg-5.12-rc1-g=
ood

The difference between the two boots is
f749d8b7a9896bc6e5ffe104cc64345037e0b152 reverted on top of 5.12-rc1 in -go=
od case.

Looks like hpsa controller fails to initialize in bad case (could be a race=
?).

--

  Sergei

Don:
I see aligned access. Let me run pahole to see if anything jumps out.
What controller are you using?
