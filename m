Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE93B42755E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 03:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhJIBWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 21:22:39 -0400
Received: from mail-bn7nam10on2043.outbound.protection.outlook.com ([40.107.92.43]:41277
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232001AbhJIBWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 21:22:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YP3NqO+sYVsMX2hgSVUD+1RGyaNUohH5lPRDRf76WwE+5+3LUM5Q6I/y6XKPsrudTPSnFrt4142Y0sybbJRuNdVuUzhHoW7sagVvC7J1xgRZEC5p9vWp4mTbGwbHUeg+pKxiV1gbG+GISqT8YHDT0y573a44mpr37qQXL9Izp04fmQH9h249LVHZ5XAo7jbp0aeO8XKFuZ5EiFUYVSjM6UWTKTiggOoaukG9IncQ/vxKR5c1jcdnzrp1W5oN7cWz+gp0qkgJrd2/AtjCqyxiBAmnmf/ugR43LlqNnIpkD2nJ5nn28S2qfiBH1vomMCjb+pl2bLYelA3CqAy+m404bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaCIQs+nNoVALfBjp1AyYLpV2Bze8qrBYjsPR2rO5Jk=;
 b=e34SSAsQL899SYS+gTWNOfgSv3B8ov7MrIB27Ut9ktPVxBM/ZH1IJDmfC5Meznt2zytCaurHm5I1HEBsKQG1Z7yMPXHTnQ4FjY7ybQb1oHEIE4XSROfzlZnpeNnfQmOakjy11J7e8WWRPY5WlkRrvCLUuiY5Eb+DAD7yVwcfCHY+e4m1JERS2b6ynJP//ptVOzC3/EjMHQv1dRMgm6q0EKFKDKcC4mZ2hDxppU+DmaYxsQ4p5WOvfkApeCsnbGwYC8JbqUNCozotuGnfEkOQhOtcHqzAdip2wmBfyEPQuvz51ziV6+59bqkAKVOXcn/RpUyVXvS3yQJm2QEFEznKUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaCIQs+nNoVALfBjp1AyYLpV2Bze8qrBYjsPR2rO5Jk=;
 b=wsRYaOIy3iHUczoeX9Y1hOIkm+pzvsbgvfdj5a28CT0M8bAW7syAD+W3Tzc3OqNDcIM7Ic5mIz/fFRpFu7Wla1xvjUTWOMV3GPySLBH/Y/tw78X0XGhXK6rhvwQSMKmjm/VDue9t35stYsfygIjPt1w89QU13CZtVmsmioP3j8c=
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3083.namprd12.prod.outlook.com (2603:10b6:5:11d::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.22; Sat, 9 Oct 2021 01:20:39 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::35c8:7b2f:1090:d3a5%6]) with mapi id 15.20.4566.026; Sat, 9 Oct 2021
 01:20:39 +0000
From:   "Quan, Evan" <Evan.Quan@amd.com>
To:     Borislav Petkov <bp@alien8.de>,
        Alex Deucher <alexdeucher@gmail.com>
CC:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "Chen, Guchun" <Guchun.Chen@amd.com>
Subject: RE: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
Thread-Topic: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris12
 UVD/VCE on suspend")
Thread-Index: AQHXu6U/ZEe6vPjmAkGizCNrJ1mPBavJLxGAgAAFT4CAAAIugIAABoCAgACjCrA=
Date:   Sat, 9 Oct 2021 01:20:39 +0000
Message-ID: <DM6PR12MB2619FD47CD826ADC91F87AFBE4B39@DM6PR12MB2619.namprd12.prod.outlook.com>
References: <YV81vidWQLWvATMM@zn.tnic>
 <CADnq5_NjiRM9sF6iAE3=KbzuSVc1MeLe0nUCdJfEpNQ=RDz4Zw@mail.gmail.com>
 <YWBeD7fd2sYSSTyc@zn.tnic>
 <CADnq5_MeEP-PbDp+Js3zEsuj=CvxDAD2qcFSskWhW4b4SkhwEQ@mail.gmail.com>
 <YWBlVzZK35ecQHNZ@zn.tnic>
In-Reply-To: <YWBlVzZK35ecQHNZ@zn.tnic>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-09T01:20:35Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=6a411f34-10e4-4932-a974-aacbf60df6ef;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45139965-984f-4451-58ca-08d98ac3014c
x-ms-traffictypediagnostic: DM6PR12MB3083:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR12MB3083981FDBDF73600E0E773AE4B39@DM6PR12MB3083.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4I27CD42OhbcBLjoJsSeTmhkrecC6Bfq+SNm6eeG9O9pJtNYxredI4GZPdrxRJd+kVUw5UIssPzUuOX1EwAQ7JXKeeIFp0aja2iSR7VXYoTM72gs2XviDIZIy1axrkFiVvRJQ7BL8Psq6zsX05Gpp7hO+XlbNErMc1kcyJaJfmup7VHH+GhAcpqy/coac1C1DE3ykB2MD1EF3pkO0nfHfDvZoa7aPVfpw/0uduXwaOAplJIBagtvXGobP9Y0Dxsp9DYQQ7JHbxO0BxlJwkDjNDo2o5uq+9fu4cyPTR/M7rsFvvrrQLFUrdeT6OeZCp0Xs7/saaV9hP8qaK5kpSLag1gmnuShkSoTEun26GBKfAa1eACW48qf6V3f+K0eaHvCsBtqYMvTKN3a3rsNyY8LWgiwTEESMDh3WHYbSOpmMWkffmSwFstuFkKlnN/ZPf9fYNul5fnEAac6gz3LS3NOSBTqUDqA084UvJuNZFCWUtzHxlYtMSdpJ/aLuOKjEeaaTgxRPERp9b+OGV9Z08UklqAB5LbDlWLRJJrMtYd/ml2ZejNccXz9v5j4RMFMOMgUlfLZyb9LALTY794RxMXi5sMNK4C9QIpnU2eT4gzOru117VGWJFVQoMaPwfwmnYoRXjMm2gRLPUzZYElbv1TYzAzxi/MjRWm6dORJwsAN7ltl6zL0yD3rUcjfuyHnE8NidkJKU/PMFJeEd9k/pQR6omrNBikRBMkCT/fruapZuOFh+XHDHXgte/0ud7SLZ10AnZNLxz7HAT2FXi+J3D/FXOXbQjZvsYyapi60UBfF9VY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB2619.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(33656002)(4326008)(53546011)(6506007)(71200400001)(122000001)(26005)(38100700002)(966005)(508600001)(186003)(8676002)(52536014)(9686003)(66476007)(110136005)(66446008)(83380400001)(66556008)(316002)(38070700005)(15650500001)(76116006)(64756008)(45080400002)(2906002)(54906003)(7696005)(66946007)(8936002)(86362001)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4WnYHjPiTVXtm/XtHUzxHqWw2Fe6AyudIjr6ovAesZp/Q5qZNQcFlq8v0nek?=
 =?us-ascii?Q?J4sZA5EqEd8hQhQZPOq7L9D0RX7w2/kzZey7Ktdh6bfef1U41QyBGvwbURV0?=
 =?us-ascii?Q?Bd8PJpY14volj137EzAUX+LfUBk4sOwMMGxRNVfogbEBlnqUOgKBQSIuqpEd?=
 =?us-ascii?Q?lBzDl9IKb0HMNncAfPYQTWoCrBXbtkcmLbukZEmE5ia6NvxcHOjaWSOVBaw0?=
 =?us-ascii?Q?o9kpCufWwRdx4uzVVTPzpYcUCsnUJjPHockgmKcceeto4cLDDxeK2KHwdlsv?=
 =?us-ascii?Q?Dt/9BxBjaolGzM+VSo+e/JBfoq8XWUlThpuyKxrWHTmIZQUeuAoeUjlQZOMS?=
 =?us-ascii?Q?mXP+byQM1jsfQbIEQ5nqg6UhMoUB+6Zj8Qv2KZIxPmsMYfuyLouUkIT9LD1B?=
 =?us-ascii?Q?kQ69izHK7WA2b9jcum9Sw4ttbsUuK5y0eQqkZ9HaJb8WsRoqVeByawFWAEdu?=
 =?us-ascii?Q?27N8UTHyTPow8vtYr8HwOxV6cRwLlYl/QglrxF1yZgZI2QvggQV3sgc7Ibo8?=
 =?us-ascii?Q?mih3tQ+6x8ruQIM11h7njUyRIERThpDyuIWNhog93waEQM77Yk1cjsHectPj?=
 =?us-ascii?Q?nccjxhCpU6zPZoPRb6lrPUzsyjScl9kaylN0XVkHXaZkqX3iGVW/s+aOxjQH?=
 =?us-ascii?Q?LyXxRhYvz/keB3fVQCYOPcr9fVwcQ5lcHFIgSsgosGK46t2SSHNLIqnFLIqd?=
 =?us-ascii?Q?3HDSNtTkPTwHHwb896rLBpfzFY7WcoD2JqzprerTUunPIMc0JEnX78Ip4NGJ?=
 =?us-ascii?Q?3/I/SkE+qjMH2y0xfOf3epvTJP2EyjvrDcodtnnTpyu9BtxsKyz36lxodHBD?=
 =?us-ascii?Q?JhYsrv1lvnhXXf0/XBgnRgnTolZ2NUCOniXroouAe5p3TBZifA/kPWnQ/fL4?=
 =?us-ascii?Q?42t1UZr2ciH0931BHDNb6shL0a6JbRCnbL3Dvr8wjNkZxHA9r/c0f6UXuixv?=
 =?us-ascii?Q?iyBD7weKy3UtFMKFpycBIrxdyXbqnEoJ7lBSmD45Sfim/9NLF8yb9Tn4+PgJ?=
 =?us-ascii?Q?OOxsPvMMnkDtzBkNZR+3+tViwyn9noFPk6Qv2CKgYQZmiUUzdAE/hvThSy6y?=
 =?us-ascii?Q?PixD1P/51dNfW8qOMbCiv4e1l8ecqbtul0+a1pQEfDbRqkopZyuul1y2j62D?=
 =?us-ascii?Q?Dx2MCTQZc8X0aDaFVVX3SQeiuVRVRPmql4MC3ad/+OdLe7L3dPPRrHl6PUbk?=
 =?us-ascii?Q?t3n3Lhwmtso+TB0oE/74TpIQ/2LkqAXrFhDaacOaA4EkUB3XK51rXzcY3FmN?=
 =?us-ascii?Q?e7yh6yyeFaMKJSc4NaeRfxJZrEjEfvNwTYVP6K0MnPR0ackUYuTV+CjDfGHC?=
 =?us-ascii?Q?Zor0CxpvEIo2WK93C9UUuBC+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45139965-984f-4451-58ca-08d98ac3014c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2021 01:20:39.3313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1dwpUzzfUNAEP0q/WGBXbUIPnNcDXrF7OcohG9kHRqoWbtnMVWxreDrfytircDm+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3083
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Official Use Only]

Maybe the change below can address your issue.
https://lists.freedesktop.org/archives/amd-gfx/2021-September/069006.html

BR
Evan
> -----Original Message-----
> From: Borislav Petkov <bp@alien8.de>
> Sent: Friday, October 8, 2021 11:36 PM
> To: Alex Deucher <alexdeucher@gmail.com>
> Cc: Quan, Evan <Evan.Quan@amd.com>; amd-gfx list <amd-
> gfx@lists.freedesktop.org>; LKML <linux-kernel@vger.kernel.org>; Deucher,
> Alexander <Alexander.Deucher@amd.com>; Pan, Xinhui
> <Xinhui.Pan@amd.com>; Chen, Guchun <Guchun.Chen@amd.com>
> Subject: Re: bf756fb833cb ("drm/amdgpu: add missing cleanups for Polaris1=
2
> UVD/VCE on suspend")
>=20
> On Fri, Oct 08, 2021 at 11:12:35AM -0400, Alex Deucher wrote:
> > Can you try swapping the order of
> > amdgpu_device_ip_set_powergating_state() and
> > amdgpu_device_ip_set_clockgating_state() in the patch?
>=20
> Nope, the diff below didn't change things.
>=20
> Should I comment them out one by one and see whether the clockgating or
> the powergating causes it?
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> index bc571833632e..99e3d697cc24 100644
> --- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
> @@ -561,10 +561,10 @@ static int uvd_v6_0_hw_fini(void *handle)
>  	} else {
>  		amdgpu_asic_set_uvd_clocks(adev, 0, 0);
>  		/* shutdown the UVD block */
> -		amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_UVD,
> -						       AMD_PG_STATE_GATE);
>  		amdgpu_device_ip_set_clockgating_state(adev,
> AMD_IP_BLOCK_TYPE_UVD,
>  						       AMD_CG_STATE_GATE);
> +		amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_UVD,
> +						       AMD_PG_STATE_GATE);
>  	}
>=20
>  	if (RREG32(mmUVD_STATUS) !=3D 0)
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 9de66893ccd6..a36612357d0f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -507,10 +507,10 @@ static int vce_v3_0_hw_fini(void *handle)
>  		amdgpu_dpm_enable_vce(adev, false);
>  	} else {
>  		amdgpu_asic_set_vce_clocks(adev, 0, 0);
> -		amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_VCE,
> -						       AMD_PG_STATE_GATE);
>  		amdgpu_device_ip_set_clockgating_state(adev,
> AMD_IP_BLOCK_TYPE_VCE,
>  						       AMD_CG_STATE_GATE);
> +		amdgpu_device_ip_set_powergating_state(adev,
> AMD_IP_BLOCK_TYPE_VCE,
> +						       AMD_PG_STATE_GATE);
>  	}
>=20
>  	r =3D vce_v3_0_wait_for_idle(handle);
>=20
> --
> Regards/Gruss,
>     Boris.
>=20
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fpeo
> ple.kernel.org%2Ftglx%2Fnotes-about-
> netiquette&amp;data=3D04%7C01%7CEvan.Quan%40amd.com%7C2389690487
> 7248b6368708d98a715267%7C3dd8961fe4884e608e11a82d994e183d%7C0%7
> C0%7C637693041605567349%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&am
> p;sdata=3DBZ9lDD4SnWzTYPdCRPFIAsjlncoQAetHWCo%2FqIjalE0%3D&amp;res
> erved=3D0
