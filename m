Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1A933962C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 19:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbhCLSUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 13:20:37 -0500
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:27841
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232518AbhCLSU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 13:20:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5L7zElYBXpNFdHTHWO5Pbi+D93Gn/4y9jn5dvEUkYI5Y0NPWUDLNPcprFBSt2U1QjRu3974Uz2qa9lVBUCeItvqBt16KApNeIAV4hGlr1agRjnC0ULFtV0iuVYXgRM69YPMlM+hSjl0LoMcbhgsm6AJKk5bJupgDA6KtTWl7FlhAGoy7vtSOrfD6Kf7QdfU2Y0+iD2GI3JWqKIE/DyVeBl+CiGBUk5ZylVJQ+b3FQVpjAnw2J9+Q3QGpa6qXsyW7ozkwtjUsadrJ7mdXXtCuN/uJh+Z6ZckAQOQE3OTUozUzfmu6/V6bmdA1OuXuU2GrsOcbn/lGtPcAiEIJDsH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+qY/PA7o/w/dwTVlOsR1rWOpz4r8kQu9fjxJUtIqSM=;
 b=gI//4wU3LaF7jHpJcMMR1iqIPIRQ/g1LRe3OiqPiSUlYJaPHvHiclofqn5fPtN6GAqT2bISqgKK/obGRRpYXhCUh4YcbJNzgVhPDE1D463fomgw28xXziz4bR6cfJu8hQeo6nFtyd1Sv7n7nlZK5ghVqccumjKc0R41SfvOHsGhkqIGj7nefipAk0VePfAQhBNh/0t4rV6Ih6Ld6TasAtEI/y2ydqRkvrzI2fBk0xr9U/525a7YHlK1Bl9UWvry53QJYzBBusM2EjaCvJtsC/NcCLXjyK59rKJtPT+BW5lL9akPaPXVKhnX8UHXzN/jaL5xx1Rq8mYrJ9vDJatpjMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+qY/PA7o/w/dwTVlOsR1rWOpz4r8kQu9fjxJUtIqSM=;
 b=aN2dQZidWdUpfm985u6Y6gmD+0nvD+r4j+GuXroWkyGDcl7Rxuyupd6/KhJhDdMQLtsOyZIJg+13BuGLgFDOLKPZFHbjEh7zHq/ViG/IwacE5r3TRazgmUBTTbqe47CpGj37XO+x6UiMFeqs3JBXIVXFApf2IiNwrUqEhp2mtLg=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4456.namprd12.prod.outlook.com (2603:10b6:208:266::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.30; Fri, 12 Mar
 2021 18:20:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::5deb:dba7:1bd4:f39c%5]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 18:20:25 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC:     "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        lkml <linux-kernel@vger.kernel.org>, x86-ml <x86@kernel.org>
Subject: RE: amdgpu, WARNING: CPU: 12 PID: 389 at
 arch/x86/kernel/fpu/core.c:129 kernel_fpu_begin_mask+0xd5/0x100
Thread-Topic: amdgpu, WARNING: CPU: 12 PID: 389 at
 arch/x86/kernel/fpu/core.c:129 kernel_fpu_begin_mask+0xd5/0x100
Thread-Index: AQHXF2uqAa6gWi0wvE+RUJq4kBT6wKqAqQRQ
Date:   Fri, 12 Mar 2021 18:20:25 +0000
Message-ID: <MN2PR12MB4488E771571F247B1E3ECEF3F76F9@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210312181511.GC22098@zn.tnic>
In-Reply-To: <20210312181511.GC22098@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-03-12T18:20:20Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=4263a8a5-b858-49c6-85f0-119740e998d7;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.247]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37ef14bd-aafb-4f5e-0262-08d8e58381cb
x-ms-traffictypediagnostic: MN2PR12MB4456:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB445603717075C57B47B9FF1AF76F9@MN2PR12MB4456.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:366;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zQ3CJoCM2zOJ0NRISSBl5mmNY98sWtplT1ILNC/fiyvwB//BdCAAdlfXesST0Sq8/REhJosHwIyixggAH8SfXS3Z+XkYPmhsGLY7b8A2xX3bvEbdrlgktilCwhbtKV6cP1Ii/RL3z+NC41/6/BsP3ftyeAjNbqMAezSvqLlBATJmGejQCdtInbEssmxQJWkXQFvLo3GDJgeB3FBTr3oZWasFPOuyLE8iKwp7QAlBb+H2xKd51Vhu9U6c9SpT6wnFEEnjRyjtp42kzBrfg4DyMI1I3WKDsZxQrL5eiaw94Tx3dvfuYFoZZf7EHIjPI6/JlRkt/8zfVbHCh17LL8fK6azxWkW2wwnlrDFUhmrjNbo8C8PaOHiGLmGcahxcCzQ/L0/K5dFdH8Gq8KqPIrPC4I3vGq+JbN/XIBlkhU89GUTQ9bz7xncug3Veqj4horqoROYYngtB+emkUghg2jc4oVaLuJ1kfl0yEn1klpceVNs/BtW3O7XYJKMeXuDcXAaVN4K/0pXee7WXdpGkFhK2ni0uy/C97wNfFdX5Ca5Ch6ah3ib0Nw3BpvaWP4ZHlpWp7GjW8jSucPunp620d1TT85+bxBeR1Dgx8xW0QWAULoA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(26005)(5660300002)(186003)(4326008)(52536014)(966005)(30864003)(7696005)(8936002)(478600001)(6506007)(66946007)(316002)(54906003)(86362001)(76116006)(83380400001)(55016002)(2906002)(66476007)(45080400002)(33656002)(9686003)(8676002)(71200400001)(110136005)(53546011)(66446008)(66556008)(64756008)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1JsAvRiWk9dx4n7wbho5pCBgzusXf3d0w11M2734qHbVbkgmezeusC1nIyim?=
 =?us-ascii?Q?uP7FQD3k6Dzja5PxSPm1nxDkreY+OgnBFVm3JvoZN5CN+zT+QuFEj9uLpd+1?=
 =?us-ascii?Q?03ScUYeMpIRvBs2wGXg6Do0xkErPIxmv0zAvX8vjSVIDQRMoEeIUTmKF8fp8?=
 =?us-ascii?Q?ydQD1hCFbGn+Xr2geMj/neXtAevwA4MnkRd9iBGN14BuzXnDzgyNJFToWJIH?=
 =?us-ascii?Q?RKjzEA0qgHNR570ycdnQRGcgMGimrvbDjLf+JHuuyiSZs7lsKy+h8IBETLBW?=
 =?us-ascii?Q?KZU2tUtSDSvJtZzCriWTN1YS1zomx478dcRNfB2Vuhzn4+9HHEX3iwdHwm+W?=
 =?us-ascii?Q?5x8zcI6YrcW+N8ro61F5aqJopiBQuDApz1SkL5fZzA/A3uExqM4ZOauDeLAF?=
 =?us-ascii?Q?8kEiouqXMEwcwMTJYPgrI//q7S5Wxt5PLh08j5pGqLSu11czmylmBFYH25tm?=
 =?us-ascii?Q?swid3/Ej8yjfaQemhXJNgIh5XYPtrCLbY7lBVg2xOOel9eI5kLRAohI/JK2S?=
 =?us-ascii?Q?yryMrYPkSBjJXF52uqZZMHmXCh2EBPSJdg+rOJ6HlyyQkB9uVTmfSIdvBrOM?=
 =?us-ascii?Q?sh1XUDyrGJQwCEXMgXdY2fdKwCeGbq4yk1K4aK55Nu3pDb+YePN8MPxU1qHX?=
 =?us-ascii?Q?6Z2D0F9i0bDR2SHacSRfgSpUepKrwHsba0l3kpikkNM5WmJr3lkjfwVTsMV7?=
 =?us-ascii?Q?cvg+fmaf7LozXB6U3iA+EtH0CfuFv4pUddVDCnczGaUqxxEBLGWuSgB+zdtD?=
 =?us-ascii?Q?YmhwZfhnY5tHVCmBc2tgIcCjKBIGnKpVR2gLSRR2zbzmI9tHWSdgIFFMY7aT?=
 =?us-ascii?Q?DObJgQH9zL67M8E3jvjjLq9aRdNUkEhmysfkD1HxmeN3C+5Qkw9lCTy5opD9?=
 =?us-ascii?Q?qUpMXXVIQazoeqhUS9NQ6Jk3SXzGxaNwkyNpcGXvj8yQR96oj5x63JatMu98?=
 =?us-ascii?Q?Xr8hbqd35zim1e5TIM/gcAT7YbbLmhwJ/qT1Ax81s2o0rPc1oEvX7iz/ZiVb?=
 =?us-ascii?Q?BrUqIjYs9JtuWi6ntesxvBCOf7ldqOk09JfXIC+hTLPqXV0ILd/FIiBafPRR?=
 =?us-ascii?Q?IWfg6Xh18TDFirQ8Fne+TKhUWkwSJkf9q0qjtITnXXp64HosorrdEY9CGpNc?=
 =?us-ascii?Q?6ADBNhFHBV8NayTcUcBSwkfDeYXKW4wQlHFujReqeJjrKY3ad+zOi69pBjjw?=
 =?us-ascii?Q?7B0RI9lbA8w1Ai4KNsNJZRb2Wd3p5iJwkz/xPh2mABk5J2UKHpTNmoKoPHCE?=
 =?us-ascii?Q?rXK2/9hL/x5cNkPGxVTJg2Rc2cMKLDMqwvVf4bK8TZpBkz/Z9w8ZkolJ7sjh?=
 =?us-ascii?Q?jjsEz2dM2lwWGsRXATmca2Ju?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37ef14bd-aafb-4f5e-0262-08d8e58381cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 18:20:25.2812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BNie4WJTEoLrxOdREP/sXwn0w5PdSIFEzWQe5jQylo3RvUlwLWEaEipDpGVllBU+LBItwfLMluiWtfFxubzksA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4456
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Friday, March 12, 2021 1:15 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo)
> <Sunpeng.Li@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; lkml <linux-kernel@vger.kernel.org>; x86-ml
> <x86@kernel.org>
> Subject: amdgpu, WARNING: CPU: 12 PID: 389 at
> arch/x86/kernel/fpu/core.c:129 kernel_fpu_begin_mask+0xd5/0x100
>=20
> Hi folks,
>=20
> I get the below on -rc2+tip/master. I added printks to your FPU macros:
>=20
> ---
> diff --git a/drivers/gpu/drm/amd/display/dc/os_types.h
> b/drivers/gpu/drm/amd/display/dc/os_types.h
> index 126c2f3a4dd3..49629dc03f99 100644
> --- a/drivers/gpu/drm/amd/display/dc/os_types.h
> +++ b/drivers/gpu/drm/amd/display/dc/os_types.h
> @@ -53,8 +53,18 @@
>  #if defined(CONFIG_DRM_AMD_DC_DCN)
>  #if defined(CONFIG_X86)
>  #include <asm/fpu/api.h>
> -#define DC_FP_START() kernel_fpu_begin() -#define DC_FP_END()
> kernel_fpu_end()
> +#define DC_FP_START()					\
> +({							\
> +	pr_emerg("%s: DC_FP_START\n", __func__);	\
> +	kernel_fpu_begin();				\
> +})
> +
> +#define DC_FP_END()					\
> +({							\
> + 	pr_emerg("%s: DC_FP_END\n", __func__);		\
> +	kernel_fpu_end();				\
> +})
> +
>  #elif defined(CONFIG_PPC64)
>  #include <asm/switch_to.h>
>  #include <asm/cputable.h>
>=20
> and I get wrong nesting of FPU usage with amdgpu:
>=20
> ...
> [    2.480080] [drm] reserve 0x400000 from 0xf41f800000 for PSP TMR
> [    2.577011] amdgpu 0000:06:00.0: amdgpu: RAS: optional ras ta ucode is=
 not
> available
> [    2.585556] amdgpu 0000:06:00.0: amdgpu: RAP: optional rap ta ucode is=
 not
> available
> [    2.585567] amdgpu 0000:06:00.0: amdgpu: SECUREDISPLAY: securedisplay
> ta ucode is not available
> [    2.586024] amdgpu 0000:06:00.0: amdgpu: SMU is initialized successful=
ly!
> [    2.587396] [drm] kiq ring mec 2 pipe 1 q 0
> [    2.588930] [drm] Display Core initialized with v3.2.122!
> [    2.601665] [drm] DMUB hardware initialized: version=3D0x01000000
> [    2.620813] snd_hda_intel 0000:06:00.1: bound 0000:06:00.0 (ops
> amdgpu_dm_audio_component_bind_ops [amdgpu])
> [    2.698383] input: TPPS/2 Elan TrackPoint as
> /devices/platform/i8042/serio1/serio2/input/input15
> [    2.713147] [drm] VCN decode and encode initialized successfully(under
> DPG Mode).
> [    2.713180] [drm] JPEG decode initialized successfully.
> [    2.715003] kfd kfd: Allocated 3969056 bytes on gart
> [    2.715251] Virtual CRAT table created for GPU
> [    2.715412] amdgpu: Topology: Add dGPU node [0x1636:0x1002]
> [    2.715421] kfd kfd: added device 1002:1636
> [    2.715428] amdgpu 0000:06:00.0: amdgpu: SE 1, SH per SE 2, CU per SH =
18,
> active_cu_number 27
> [    2.716496] [drm] fb mappable at 0x410CE0000
> [    2.716510] [drm] vram apper at 0x410000000
> [    2.716515] [drm] size 8294400
> [    2.716518] [drm] fb depth is 24
> [    2.716522] [drm]    pitch is 7680
> [    2.716710] fbcon: amdgpudrmfb (fb0) is primary device
> [    2.716922] dcn21_validate_bandwidth: DC_FP_START
> [    2.716969] patch_bounding_box: DC_FP_START
>=20
> This should not happen. You need DC_FP_END before the next
> DC_FP_START because FPU usage cannot nest.
>=20
> But who knows, maybe this is fixed already...

Should be fixed with these patches:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D15e8b95d5f7509e0b09289be8c422c459c9f0412
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3D680174cfd1e1cea70a8f30ccb44d8fbdf996018e

Alex

>=20
> [    2.716973] ------------[ cut here ]------------
> [    2.716974] WARNING: CPU: 12 PID: 389 at arch/x86/kernel/fpu/core.c:12=
9
> kernel_fpu_begin_mask+0xd5/0x100
> [    2.716986] Modules linked in: joydev edac_mce_amd edac_core iwlmvm
> kvm_amd mac80211 libarc4 kvm irqbypass crct10dif_pclmul crc32_pclmul
> iwlwifi crc32c_intel snd_hda_codec_realtek snd_hda_codec_generic
> amdgpu(+) ghash_clmulni_intel snd_hda_codec_hdmi snd_hda_intel
> snd_intel_dspcfg snd_hda_codec rtsx_pci_sdmmc snd_hwdep mmc_core
> snd_hda_core aesni_intel libaes crypto_simd wmi_bmof thinkpad_acpi
> sp5100_tco snd_pcm cryptd nvram ucsi_acpi(+) ledtrig_audio watchdog rapl
> rtsx_pci platform_profile snd_timer pcspkr cfg80211 efi_pstore typec_ucsi
> k10temp ccp i2c_piix4 gpu_sched mfd_core r8169 roles snd typec wmi
> soundcore ac battery video i2c_scmi acpi_cpufreq button psmouse
> serio_raw nvme nvme_core
> [    2.717057] CPU: 12 PID: 389 Comm: systemd-udevd Not tainted 5.12.0-rc=
2+
> #1
> [    2.717062] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC,
> BIOS R1BET58W(1.27 ) 10/20/2020
> [    2.717065] RIP: 0010:kernel_fpu_begin_mask+0xd5/0x100
> [    2.717070] Code: 40 75 af f0 80 4f 01 40 48 81 c7 c0 0b 00 00 e8 d1 f=
b ff ff eb
> 9c db e3 eb c7 0f 0b 66 0f 1f 84 00 00 00 00 00 e9 62 ff ff ff <0f> 0b 66=
 0f 1f 84
> 00 00 00 00 00 e9 61 ff ff ff 66 66 2e 0f 1f 84
> [    2.717073] RSP: 0018:ffffc90001427528 EFLAGS: 00010202
> [    2.717076] RAX: 0000000000000001 RBX: 0000000000000002 RCX:
> 0000000000000000
> [    2.717078] RDX: 0000000000000000 RSI: 0000000000000082 RDI:
> 0000000000000001
> [    2.717080] RBP: ffff8881301e0000 R08: ffffffff82a246a0 R09:
> 5f4344203a786f62
> [    2.717082] R10: 625f676e69646e75 R11: 6f625f6863746170 R12:
> ffff888181783000
> [    2.717083] R13: 0000000000000000 R14: ffffc900014275cc R15:
> ffffffffa10c87c0
> [    2.717085] FS:  00007f53f5f1a8c0(0000) GS:ffff8883fb100000(0000)
> knlGS:0000000000000000
> [    2.717088] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.717091] CR2: 00005572e3f6fc90 CR3: 00000001026ce000 CR4:
> 0000000000350ee0
> [    2.717093] Call Trace:
> [    2.717100]  dcn21_calculate_wm.cold+0x27/0x3a8 [amdgpu]
> [    2.717560]  dcn21_validate_bandwidth_fp+0x4f8/0x5d3 [amdgpu]
> [    2.717995]  dcn21_validate_bandwidth+0x3e/0x63 [amdgpu]
> [    2.718412]  dc_validate_global_state+0x2db/0x370 [amdgpu]
> [    2.718858]  amdgpu_dm_atomic_check+0xbc9/0xce0 [amdgpu]
> [    2.719317]  drm_atomic_check_only+0x5bb/0x8d0
> [    2.719324]  ? _raw_spin_unlock_irqrestore+0x1b/0x40
> [    2.719331]  ? drm_connector_list_iter_next+0x85/0xb0
> [    2.719335]  ? drm_atomic_add_affected_connectors+0xfa/0x110
> [    2.719340]  drm_atomic_commit+0x1e/0x70
> [    2.719343]  drm_client_modeset_commit_atomic+0x1e4/0x220
> [    2.719350]  drm_client_modeset_commit_locked+0x56/0x160
> [    2.719354]  drm_client_modeset_commit+0x31/0x60
> [    2.719358]  drm_fb_helper_set_par+0xc7/0xf0
> [    2.719364]  fbcon_init+0x270/0x510
> [    2.719369]  visual_init+0xcb/0x130
> [    2.719374]  do_bind_con_driver.isra.0+0x202/0x320
> [    2.719380]  do_take_over_console+0x116/0x190
> [    2.719385]  do_fbcon_takeover+0x5b/0xc0
> [    2.719388]  fbcon_fb_registered+0x72/0xe0
> [    2.719392]  register_framebuffer+0x1e2/0x300
> [    2.719398]  __drm_fb_helper_initial_config_and_unlock+0x319/0x490
> [    2.719404]  amdgpu_fbdev_init+0xd0/0x110 [amdgpu]
> [    2.719753]  amdgpu_device_init.cold+0x164f/0x1afb [amdgpu]
> [    2.720186]  ? pci_bus_read_config_word+0x4d/0x80
> [    2.720193]  amdgpu_driver_load_kms+0x64/0x270 [amdgpu]
> [    2.720563]  amdgpu_pci_probe+0x151/0x1d0 [amdgpu]
> [    2.720896]  local_pci_probe+0x50/0xa0
> [    2.720903]  ? pci_match_device+0xd7/0x100
> [    2.720906]  pci_device_probe+0x108/0x1c0
> [    2.720911]  really_probe+0x109/0x470
> [    2.720916]  driver_probe_device+0xe1/0x150
> [    2.720919]  device_driver_attach+0xbd/0xd0
> [    2.720923]  __driver_attach+0x9e/0x150
> [    2.720926]  ? device_driver_attach+0xd0/0xd0
> [    2.720928]  ? device_driver_attach+0xd0/0xd0
> [    2.720931]  bus_for_each_dev+0x7a/0xc0
> [    2.720936]  ? klist_add_tail+0x4f/0x90
> [    2.720940]  bus_add_driver+0x14d/0x210
> [    2.720945]  driver_register+0x8b/0xe0
> [    2.720949]  ? 0xffffffffa11b6000
> [    2.720951]  do_one_initcall+0x44/0x200
> [    2.720956]  ? kmem_cache_alloc_trace+0x18c/0x210
> [    2.720961]  do_init_module+0x5c/0x260
> [    2.720966]  __do_sys_finit_module+0xca/0x140
> [    2.720972]  do_syscall_64+0x33/0x80
> [    2.720978]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    2.720983] RIP: 0033:0x7f53f63c4959
> [    2.720987] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 4=
8 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff
> 73 01 c3 48 8b 0d 07 55 0c 00 f7 d8 64 89 01 48
> [    2.720990] RSP: 002b:00007ffc27e37318 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000139
> [    2.720995] RAX: ffffffffffffffda RBX: 00005572e3f50f20 RCX:
> 00007f53f63c4959
> [    2.720997] RDX: 0000000000000000 RSI: 00007f53f6550e4d RDI:
> 000000000000000c
> [    2.720999] RBP: 0000000000020000 R08: 0000000000000000 R09:
> 00005572e3f50d68
> [    2.721000] R10: 000000000000000c R11: 0000000000000246 R12:
> 00007f53f6550e4d
> [    2.721002] R13: 0000000000000000 R14: 00005572e3f4f650 R15:
> 00005572e3f50f20
> [    2.721006] ---[ end trace 1304f710de137125 ]---
> [    2.721010] patch_bounding_box: DC_FP_END
> [    2.721565] dcn21_validate_bandwidth: DC_FP_END
> [    2.721568] ------------[ cut here ]------------
> [    2.721569] WARNING: CPU: 12 PID: 389 at arch/x86/kernel/fpu/core.c:15=
5
> kernel_fpu_end+0x35/0x50
> [    2.721576] Modules linked in: joydev edac_mce_amd edac_core iwlmvm
> kvm_amd mac80211 libarc4 kvm irqbypass crct10dif_pclmul crc32_pclmul
> iwlwifi crc32c_intel snd_hda_codec_realtek snd_hda_codec_generic
> amdgpu(+) ghash_clmulni_intel snd_hda_codec_hdmi snd_hda_intel
> snd_intel_dspcfg snd_hda_codec rtsx_pci_sdmmc snd_hwdep mmc_core
> snd_hda_core aesni_intel libaes crypto_simd wmi_bmof thinkpad_acpi
> sp5100_tco snd_pcm cryptd nvram ucsi_acpi(+) ledtrig_audio watchdog rapl
> rtsx_pci platform_profile snd_timer pcspkr cfg80211 efi_pstore typec_ucsi
> k10temp ccp i2c_piix4 gpu_sched mfd_core r8169 roles snd typec wmi
> soundcore ac battery video i2c_scmi acpi_cpufreq button psmouse
> serio_raw nvme nvme_core
> [    2.721633] CPU: 12 PID: 389 Comm: systemd-udevd Tainted: G        W
> 5.12.0-rc2+ #1
> [    2.721637] Hardware name: LENOVO 20Y2MMMMCC/20Y2MMMMCC,
> BIOS R1BET58W(1.27 ) 10/20/2020
> [    2.721638] RIP: 0010:kernel_fpu_end+0x35/0x50
> [    2.721642] Code: 7e 84 c0 74 25 65 c6 05 a0 22 ff 7e 00 bf 01 00 00 0=
0 e8 1e 0a
> 08 00 65 8b 05 d7 22 ff 7e 85 c0 74 02 f3 c3 e8 d3 d1 fd ff c3 <0f> 0b 66=
 0f 1f 84
> 00 00 00 00 00 eb ce 66 66 2e 0f 1f 84 00 00 00
> [    2.721645] RSP: 0018:ffffc90001427638 EFLAGS: 00010246
> [    2.721647] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> 0000000000000000
> [    2.721649] RDX: 0000000000000000 RSI: 0000000000000086 RDI:
> 00000000ffffffff
> [    2.721651] RBP: ffff88810aa80000 R08: ffffffff82a246a0 R09:
> 6874646977646e61
> [    2.721653] R10: 625f65746164444e R11: 61765f31326e4e45 R12:
> 0000000000000001
> [    2.721654] R13: ffff888102e11800 R14: ffff88810aa81548 R15:
> ffff88810aa80000
> [    2.721656] FS:  00007f53f5f1a8c0(0000) GS:ffff8883fb100000(0000)
> knlGS:0000000000000000
> [    2.721659] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    2.721661] CR2: 00005572e3f6fc90 CR3: 00000001026ce000 CR4:
> 0000000000350ee0
> [    2.721664] Call Trace:
> [    2.721666]  dcn21_validate_bandwidth+0x5b/0x63 [amdgpu]
> [    2.722107]  dc_validate_global_state+0x2db/0x370 [amdgpu]
> [    2.722548]  amdgpu_dm_atomic_check+0xbc9/0xce0 [amdgpu]
> [    2.723001]  drm_atomic_check_only+0x5bb/0x8d0
> [    2.723007]  ? _raw_spin_unlock_irqrestore+0x1b/0x40
> [    2.723012]  ? drm_connector_list_iter_next+0x85/0xb0
> [    2.723017]  ? drm_atomic_add_affected_connectors+0xfa/0x110
> [    2.723021]  drm_atomic_commit+0x1e/0x70
> [    2.723024]  drm_client_modeset_commit_atomic+0x1e4/0x220
> [    2.723030]  drm_client_modeset_commit_locked+0x56/0x160
> [    2.723035]  drm_client_modeset_commit+0x31/0x60
> [    2.723039]  drm_fb_helper_set_par+0xc7/0xf0
> [    2.723045]  fbcon_init+0x270/0x510
> [    2.723050]  visual_init+0xcb/0x130
> [    2.723055]  do_bind_con_driver.isra.0+0x202/0x320
> [    2.723060]  do_take_over_console+0x116/0x190
> [    2.723065]  do_fbcon_takeover+0x5b/0xc0
> [    2.723068]  fbcon_fb_registered+0x72/0xe0
> [    2.723072]  register_framebuffer+0x1e2/0x300
> [    2.723077]  __drm_fb_helper_initial_config_and_unlock+0x319/0x490
> [    2.723083]  amdgpu_fbdev_init+0xd0/0x110 [amdgpu]
> [    2.723429]  amdgpu_device_init.cold+0x164f/0x1afb [amdgpu]
> [    2.723870]  ? pci_bus_read_config_word+0x4d/0x80
> [    2.723878]  amdgpu_driver_load_kms+0x64/0x270 [amdgpu]
> [    2.724216]  amdgpu_pci_probe+0x151/0x1d0 [amdgpu]
> [    2.724560]  local_pci_probe+0x50/0xa0
> [    2.724566]  ? pci_match_device+0xd7/0x100
> [    2.724569]  pci_device_probe+0x108/0x1c0
> [    2.724574]  really_probe+0x109/0x470
> [    2.724578]  driver_probe_device+0xe1/0x150
> [    2.724582]  device_driver_attach+0xbd/0xd0
> [    2.724585]  __driver_attach+0x9e/0x150
> [    2.724588]  ? device_driver_attach+0xd0/0xd0
> [    2.724590]  ? device_driver_attach+0xd0/0xd0
> [    2.724593]  bus_for_each_dev+0x7a/0xc0
> [    2.724598]  ? klist_add_tail+0x4f/0x90
> [    2.724601]  bus_add_driver+0x14d/0x210
> [    2.724606]  driver_register+0x8b/0xe0
> [    2.724610]  ? 0xffffffffa11b6000
> [    2.724612]  do_one_initcall+0x44/0x200
> [    2.724617]  ? kmem_cache_alloc_trace+0x18c/0x210
> [    2.724621]  do_init_module+0x5c/0x260
> [    2.724626]  __do_sys_finit_module+0xca/0x140
> [    2.724632]  do_syscall_64+0x33/0x80
> [    2.724637]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [    2.724642] RIP: 0033:0x7f53f63c4959
> [    2.724645] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 4=
8 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff
> 73 01 c3 48 8b 0d 07 55 0c 00 f7 d8 64 89 01 48
> [    2.724648] RSP: 002b:00007ffc27e37318 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000139
> [    2.724652] RAX: ffffffffffffffda RBX: 00005572e3f50f20 RCX:
> 00007f53f63c4959
> [    2.724654] RDX: 0000000000000000 RSI: 00007f53f6550e4d RDI:
> 000000000000000c
> [    2.724656] RBP: 0000000000020000 R08: 0000000000000000 R09:
> 00005572e3f50d68
> [    2.724658] R10: 000000000000000c R11: 0000000000000246 R12:
> 00007f53f6550e4d
> [    2.724660] R13: 0000000000000000 R14: 00005572e3f4f650 R15:
> 00005572e3f50f20
> [    2.724663] ---[ end trace 1304f710de137126 ]---
> [    2.729729] ucsi_acpi: probe of USBC000:00 failed with error -5
> [    2.787392] dcn21_validate_bandwidth: DC_FP_START
> [    2.787443] patch_bounding_box: DC_FP_START
> [    2.787447] patch_bounding_box: DC_FP_END
> [    2.787985] dcn21_validate_bandwidth: DC_FP_END
> [    2.788210] Console: switching to colour frame buffer device 240x67
> [    2.788311] dcn21_validate_bandwidth: DC_FP_START
> [    2.788357] patch_bounding_box: DC_FP_START
> [    2.788359] patch_bounding_box: DC_FP_END
> [    2.788888] dcn21_validate_bandwidth: DC_FP_END
> [    2.788971] dcn21_validate_bandwidth: DC_FP_START
> [    2.789004] patch_bounding_box: DC_FP_START
> [    2.789005] patch_bounding_box: DC_FP_END
> [    2.789529] dcn21_validate_bandwidth: DC_FP_END
> [    3.072980] amdgpu 0000:06:00.0: [drm] fb0: amdgpudrmfb frame buffer
> device
> [    3.074708] amdgpu 0000:06:00.0: amdgpu: ring gfx uses VM inv eng 0 on
> hub 0
> [    3.076259] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.0 uses VM inv e=
ng
> 1 on hub 0
> [    3.077811] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.0 uses VM inv e=
ng
> 4 on hub 0
> [    3.079332] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.0 uses VM inv e=
ng
> 5 on hub 0
> [    3.080846] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.0 uses VM inv e=
ng
> 6 on hub 0
> [    3.082330] amdgpu 0000:06:00.0: amdgpu: ring comp_1.0.1 uses VM inv e=
ng
> 7 on hub 0
> [    3.083798] amdgpu 0000:06:00.0: amdgpu: ring comp_1.1.1 uses VM inv e=
ng
> 8 on hub 0
> [    3.085270] amdgpu 0000:06:00.0: amdgpu: ring comp_1.2.1 uses VM inv e=
ng
> 9 on hub 0
> [    3.086791] amdgpu 0000:06:00.0: amdgpu: ring comp_1.3.1 uses VM inv e=
ng
> 10 on hub 0
> [    3.088254] amdgpu 0000:06:00.0: amdgpu: ring kiq_2.1.0 uses VM inv en=
g
> 11 on hub 0
> [    3.089734] amdgpu 0000:06:00.0: amdgpu: ring sdma0 uses VM inv eng 0 =
on
> hub 1
> [    3.091224] amdgpu 0000:06:00.0: amdgpu: ring vcn_dec uses VM inv eng =
1
> on hub 1
> [    3.092700] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc0 uses VM inv eng=
 4
> on hub 1
> [    3.094157] amdgpu 0000:06:00.0: amdgpu: ring vcn_enc1 uses VM inv eng=
 5
> on hub 1
> [    3.095602] amdgpu 0000:06:00.0: amdgpu: ring jpeg_dec uses VM inv eng=
 6
> on hub 1
> [    3.119749] [drm] Initialized amdgpu 3.40.0 20150101 for 0000:06:00.0 =
on
> minor 2
> [    3.372594] Adding 999420k swap on /dev/nvme0n1p3.  Priority:-2 extent=
s:1
> across:999420k SS
> [    3.391787] EXT4-fs (nvme0n1p2): re-mounted. Opts: errors=3Dremount-ro=
.
> Quota mode: disabled.
> [    3.884636] Generic FE-GE Realtek PHY r8169-500:00: attached PHY drive=
r
> (mii_bus:phy_addr=3Dr8169-500:00, irq=3DMAC)
> [    4.092855] r8169 0000:05:00.0 eth1: Link is Down
> [    5.648793] r8169 0000:05:00.0 eth1: Link is Up - 100Mbps/Full - flow =
control
> rx/tx
> [    5.650564] IPv6: ADDRCONF(NETDEV_CHANGE): eth1: link becomes ready
> [    6.443233] dcn21_validate_bandwidth: DC_FP_START
> [    6.443288] patch_bounding_box: DC_FP_START
> [    6.443292] patch_bounding_box: DC_FP_END
> [    6.443833] dcn21_validate_bandwidth: DC_FP_END
> [    6.450332] dcn21_validate_bandwidth: DC_FP_START
> [    6.450380] patch_bounding_box: DC_FP_START
> [    6.453685] patch_bounding_box: DC_FP_END
> [    6.454228] dcn21_validate_bandwidth: DC_FP_END
> [    6.491039] dcn21_validate_bandwidth: DC_FP_START
> [    6.492849] patch_bounding_box: DC_FP_START
> [    6.494494] patch_bounding_box: DC_FP_END
> [    6.496756] dcn21_validate_bandwidth: DC_FP_END
> [    6.496840] dcn21_validate_bandwidth: DC_FP_START
> [    6.500038] patch_bounding_box: DC_FP_START
> [    6.500041] patch_bounding_box: DC_FP_END
> [    6.500657] dcn21_validate_bandwidth: DC_FP_END
> [    6.553312] dcn21_validate_bandwidth: DC_FP_START
> [    6.555085] patch_bounding_box: DC_FP_START
> [    6.556904] patch_bounding_box: DC_FP_END
> [    6.559140] dcn21_validate_bandwidth: DC_FP_END
> [    6.560938] dcn21_validate_bandwidth: DC_FP_START
> [    6.562655] patch_bounding_box: DC_FP_START
> [    6.562657] patch_bounding_box: DC_FP_END
> [    6.563182] dcn21_validate_bandwidth: DC_FP_END
> [    6.570850] dcn21_validate_bandwidth: DC_FP_START
> [    6.570903] patch_bounding_box: DC_FP_START
> [    6.570907] patch_bounding_box: DC_FP_END
> [    6.571447] dcn21_validate_bandwidth: DC_FP_END
> [    6.571507] dcn21_validate_bandwidth: DC_FP_START
> [    6.571542] patch_bounding_box: DC_FP_START
> [    6.571543] patch_bounding_box: DC_FP_END
> [    6.572067] dcn21_validate_bandwidth: DC_FP_END
> [    6.794475] dcn21_validate_bandwidth: DC_FP_START
> [    6.794535] patch_bounding_box: DC_FP_START
> [    6.794540] patch_bounding_box: DC_FP_END
> [    6.795081] dcn21_validate_bandwidth: DC_FP_END
> [    6.795136] dcn21_validate_bandwidth: DC_FP_START
> [    6.795171] patch_bounding_box: DC_FP_START
> [    6.795174] patch_bounding_box: DC_FP_END
> [    6.795699] dcn21_validate_bandwidth: DC_FP_END
> [    6.894809] dcn21_validate_bandwidth: DC_FP_START
> [    6.894870] patch_bounding_box: DC_FP_START
> [    6.894875] patch_bounding_box: DC_FP_END
> [    6.895419] dcn21_validate_bandwidth: DC_FP_END
> [    6.895480] dcn21_validate_bandwidth: DC_FP_START
> [    6.895516] patch_bounding_box: DC_FP_START
> [    6.895518] patch_bounding_box: DC_FP_END
> [    6.896044] dcn21_validate_bandwidth: DC_FP_END
> [    6.979250] dcn21_validate_bandwidth: DC_FP_START
> [    6.979311] patch_bounding_box: DC_FP_START
> [    6.979317] patch_bounding_box: DC_FP_END
> [    6.979858] dcn21_validate_bandwidth: DC_FP_END
> [    6.980820] dcn21_validate_bandwidth: DC_FP_START
> [    6.980880] patch_bounding_box: DC_FP_START
> [    6.980886] patch_bounding_box: DC_FP_END
> [    6.981426] dcn21_validate_bandwidth: DC_FP_END
> [   15.859486] dcn21_validate_bandwidth: DC_FP_START
> [   15.859547] patch_bounding_box: DC_FP_START
> [   15.859552] patch_bounding_box: DC_FP_END
> [   15.860095] dcn21_validate_bandwidth: DC_FP_END
> [   15.861096] dcn21_validate_bandwidth: DC_FP_START
> [   15.861167] patch_bounding_box: DC_FP_START
> [   15.861173] patch_bounding_box: DC_FP_END
> [   15.861894] dcn21_validate_bandwidth: DC_FP_END
> [   15.866043] dcn21_validate_bandwidth: DC_FP_START
> [   15.866098] patch_bounding_box: DC_FP_START
> [   15.866102] patch_bounding_box: DC_FP_END
> [   15.866645] dcn21_validate_bandwidth: DC_FP_END
> [   15.866704] dcn21_validate_bandwidth: DC_FP_START
> [   15.866739] patch_bounding_box: DC_FP_START
> [   15.866741] patch_bounding_box: DC_FP_END
> [   15.867267] dcn21_validate_bandwidth: DC_FP_END
> [   15.882518] dcn21_validate_bandwidth: DC_FP_START
> [   15.882573] patch_bounding_box: DC_FP_START
> [   15.882577] patch_bounding_box: DC_FP_END
> [   15.883116] dcn21_validate_bandwidth: DC_FP_END
> [   15.883175] dcn21_validate_bandwidth: DC_FP_START
> [   15.883209] patch_bounding_box: DC_FP_START
> [   15.883211] patch_bounding_box: DC_FP_END
> [   15.883734] dcn21_validate_bandwidth: DC_FP_END
> [   15.899206] dcn21_validate_bandwidth: DC_FP_START
> [   15.899260] patch_bounding_box: DC_FP_START
> [   15.899264] patch_bounding_box: DC_FP_END
> [   15.899804] dcn21_validate_bandwidth: DC_FP_END
> [   15.899864] dcn21_validate_bandwidth: DC_FP_START
> [   15.899898] patch_bounding_box: DC_FP_START
> [   15.899900] patch_bounding_box: DC_FP_END
> [   15.900450] dcn21_validate_bandwidth: DC_FP_END
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeo
> ple.kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7Calexander.deucher%40amd.com%7C4b8
> 8ef5d439646b824aa08d8e582cb31%7C3dd8961fe4884e608e11a82d994e183d
> %7C0%7C0%7C637511697225075475%7CUnknown%7CTWFpbGZsb3d8eyJWIj
> oiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1
> 000&amp;sdata=3DN4ZIe%2FT94pYNAZM08IFteTl2N9JrHoexa0f3Na7%2Bzdg%3
> D&amp;reserved=3D0
