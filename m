Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D65366FBA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244207AbhDUQIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:08:50 -0400
Received: from mail-dm6nam11on2079.outbound.protection.outlook.com ([40.107.223.79]:63457
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240353AbhDUQIk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:08:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lmui5MkJxOKGr5wlfeDbj2Iet22Yv3w+DbKtJ/T/D/YrXrzg/14dPoIJRBwJFygismTt/6Q4LM1J7QhXQbP1A2D0Hl8TgVmYctXCJ29cfy2liGSbGJ+WicTZKfwqiArFZ/7e4mlGtpGn8o5d+APO9H0PYSH/gyzUmopShzGy/ubHRTqq5nPqKBEtliUPQ8pCc0k4Z7dggeMy7P39YIURvGvIJhcnl+AoEOoKmqX2W1eKLs3OwX7f+HXs4WFJjECVstEQtH0VhDSNZt5kSORm5yBHyauwci1UL7UFMMMc+anp6up5COJ1iJlfIRZsZ4G82gjqdr0gBj09L6xcNGARVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUwz81IN2dF9gVKq8DMKbid7UbWno1MoUio6DHK+l+I=;
 b=cI2cikCZ6GLgKtBTvMcCUkCSXuMc7eFS3f+CskcqeZBfY+fYmJOIxoruSbLyEg/uhasLBmDn1p697PsMc+K5asoHRYKVDlS402uFlni1R3J++BnTsxc9GSobZuzN79CAhPTyqfWhRpOKbsj0pWkYykq2zoia2p7MwPkwMSinoeZO5CR0UITQak50wmOGEJLGx9KVwrwpfhVXCsuAJZK+l94j2wsHnRpbzakKNb50u8JUUnSHr0rHsvlTNTdPpzRz4DM/61KyhPgOCVwF8hwiPMS+WXxxDPhx4oEPfDXeIdxXtMVLD/Gzjuf1UI/aRE7HukYI5pVD9TREbwkX/lPANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUwz81IN2dF9gVKq8DMKbid7UbWno1MoUio6DHK+l+I=;
 b=MCKjWng23Ij/KKuzixajplYcpnzew/NQnHomgwt1vAll8rDFCM0SapLNA+sV7iJ0NRc7ImmGG8vPbDRFxqA7wTxulOm+CkdEQVzqUut9F8AYTQ4AUKgCOkOR1fDCEqWiA6AjJVVmXn12kb/zRcX3VPrrb6uNsclZ/DsJcVjgdW8=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4993.namprd12.prod.outlook.com (2603:10b6:208:17e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 21 Apr
 2021 16:08:05 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 16:08:05 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Quan, Evan" <Evan.Quan@amd.com>, Aditya Pakki <pakki001@umn.edu>
Subject: RE: [PATCH 022/190] Revert "drm/radeon: Fix reference count leaks
 caused by pm_runtime_get_sync"
Thread-Topic: [PATCH 022/190] Revert "drm/radeon: Fix reference count leaks
 caused by pm_runtime_get_sync"
Thread-Index: AQHXNq6N7DzvlXIDNU2bpVeIp5b9dKq/I2wQ
Date:   Wed, 21 Apr 2021 16:08:05 +0000
Message-ID: <MN2PR12MB4488CE1D9E2133F4110D131EF7479@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-23-gregkh@linuxfoundation.org>
In-Reply-To: <20210421130105.1226686-23-gregkh@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-21T16:08:01Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=f0130b02-8258-4b2a-a264-a7abc0d67a08;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8000c34f-56f6-4631-454a-08d904dfa5bd
x-ms-traffictypediagnostic: BL0PR12MB4993:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB4993F04BFA8C9A90CA72976FF7479@BL0PR12MB4993.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gRu+lElbj2e5rkIW+uy+Hf6ZGj8Uzg9T7hJ7vafuvTmldi0eLh8NUpBWCj3d41PqRncI5OtjueR5NAclIBP5Tbz2FG0PVnpVcnfE+6BsEE66tzYIbNOnEKTxqGpiaeQ//nA3MqrI5o37qjXU41X6wP6VZT4hM3ETcST4qkZ9Orc3yVM63/KoXiraqwKAaCjfgPNJnMNQjzwgFyJj1Na6AWEZ2NYz30cDsA0aWCmqJwwyqaiqiXpCFr79aIvm3N3yovqXaQV/+bDUUIVMxf1rSf692cPlUUS7FeeVtYjIEMGK6sDGTu6ciiUjfegGxKahqkIaHnL+vy5mLHz3EyorESXDVvetvoV80EIHMHWgaNhhYNAc7dioMTql+REqKd78Qh2pIoIAvoFl8er3KOLebzssCPHio3BpeYKSaTQfmi7S22L3M/SwWHOO9vlx6SAwLOwzSTznmDHo1IfRyxqucYBgPR7ZSdabwx5foCvJQqWI1SDVIuh3gN3onkoqz98gDrNynKNHzpJSGiY22i2KbWvJEUOC3goji7Jos/6hzDrvU6xhtMyUjeaZzh3aFhdf8kBQQjSPi2mDm0+JqpC4Utv8IRS3eupsEPVAyGtpp3U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(66946007)(316002)(2906002)(53546011)(55016002)(66556008)(186003)(83380400001)(66446008)(64756008)(66476007)(7696005)(52536014)(54906003)(5660300002)(110136005)(8676002)(4326008)(8936002)(33656002)(86362001)(38100700002)(122000001)(26005)(9686003)(478600001)(6506007)(71200400001)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?dZ+E9TLsHcg9NCd/KNT8P3L9MHzwgONoJAkk8TTaePZeYctaqLY1WhIaeQlz?=
 =?us-ascii?Q?QmOQhEOUNMf8Uwzjb3loMp1u+FH1x21jQcT8teq+l+oqHgZHUoSf7cI6Fijo?=
 =?us-ascii?Q?lswBGwS61ZNXvKp83KG+xpKqI77kjzd0EtoZWoxMj1S55haTyTAUjMJD488o?=
 =?us-ascii?Q?rov6NT2h9Och9zHYAFt+jCZOPdmRxFBc9hc06Lvij4nrYiwGFysmfi54rdIX?=
 =?us-ascii?Q?uD/CbGb2k5XbfCnhsozEhPesnW9Tosksp2Fuqbovj/WEjm05OnMChb3qSJ6r?=
 =?us-ascii?Q?Hv53SxDVqvfzQ8/hmtOu0iCXK33UVw5ho6cDhP9Pm+TkZ2uQXQP0vdE1KjFo?=
 =?us-ascii?Q?+NchvWQAkqWGrKLvLCXopP36Dqz7a0mj4PLI90YLRgMPTrgEbG+u1aD+Hao1?=
 =?us-ascii?Q?o0Efp9OmxEOxHhYElf5Us3CTqZ2jeetIeFwcK65Ip7HUfbyHHRPOj8oO1Wwg?=
 =?us-ascii?Q?uuwbhMny0p2xS1Z455OnShpUUFuGsRipSKk1hrWrnNKNkO1bkTXoccxedgFK?=
 =?us-ascii?Q?CMo3jZllQurMROZR6oU23Bt6KBd+PVLUNC/jn10td6wnYHWD8IMKiPiZknhg?=
 =?us-ascii?Q?5eRxEDyk0HpG58zfhVrNaob51uXSjW00ExHDZzhWiVhq0DbYMdClf0wu0N4S?=
 =?us-ascii?Q?vRlPn4C7j8J8LT/AGqY/dBOrurZNMqq+d8lKzQGscrQSeQpTEDrxfHchGjwe?=
 =?us-ascii?Q?NOEgq0P6V0tfRnUOC8pYQSfPY2fVLD756cI340bVmAFTg1yzKhcxrP7wsBDz?=
 =?us-ascii?Q?dhYPtXWmcz9KwbGVAOEKidpPz0TAGQBirOpF9H+SbT/sdaWH7Ek5xX83egE1?=
 =?us-ascii?Q?zD3QR1twq+eNbsqV9uVNvovykbGBZsnKwd5e1k60jQrCwOOSerBoZJ+NNab5?=
 =?us-ascii?Q?sKXResZ2uSqERtFORIrGYWssdxYGICQR94d9+C+843Frq6vTsc5FxTzw9B6w?=
 =?us-ascii?Q?C3kn/6kWfG81NjqZNnNYlZdMdn94VHeIk0pQVTIBe/60UBZryc/g92BQlvd3?=
 =?us-ascii?Q?0JhqeUo5nMBfVECPVCfyB2l5FFGXbHnr4uGWXhEYN5AduZ7Jqt2S/5tanuHk?=
 =?us-ascii?Q?l+X+Wy0t/WE1Kxk8x2c/I9yZ1Ug05wJRWCJVkJbXd9spx9v3sYzyApDF8fFJ?=
 =?us-ascii?Q?wSIWnkgoNMMz66hTRwnnDWFtp6ot8GFqfE2cXCYDuprGJTrOdIWCmIyzgDK1?=
 =?us-ascii?Q?voZrwT80lVqOeku8/GXuA9PmN/mXucaVnxISgIz4fDP95uRjpsHAjkUp2Jhw?=
 =?us-ascii?Q?4mYmuJAiauRElYYMy7yWA/GXfy8lNa+oukMEeQ6hjp4XBlVthPp9tvelm6TK?=
 =?us-ascii?Q?p6+i35g0uq8yTluIzIT10/ow?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8000c34f-56f6-4631-454a-08d904dfa5bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 16:08:05.3970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ngtNEPLCX77H4eb0l6goTR6FbH8a/e5FbE0kJ10ODscMVxSkV4XK9HQUu2gYIDXvIX7Ehp/js6Z2dqJFCm/1TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4993
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, April 21, 2021 8:58 AM
> To: linux-kernel@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Quan, Evan
> <Evan.Quan@amd.com>; Aditya Pakki <pakki001@umn.edu>; Deucher,
> Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 022/190] Revert "drm/radeon: Fix reference count leaks
> caused by pm_runtime_get_sync"
>=20
> This reverts commit 9fb10671011143d15b6b40d6d5fa9c52c57e9d63.
>=20
> Commits from @umn.edu addresses have been found to be submitted in
> "bad faith" to try to test the kernel community's ability to review "know=
n
> malicious" changes.  The result of these submissions can be found in a pa=
per
> published at the 42nd IEEE Symposium on Security and Privacy entitled,
> "Open Source Insecurity: Stealthily Introducing Vulnerabilities via Hypoc=
rite
> Commits" written by Qiushi Wu (University of Minnesota) and Kangjie Lu
> (University of Minnesota).
>=20
> Because of this, all submissions from this group must be reverted from th=
e
> kernel tree and will need to be re-reviewed again to determine if they
> actually are a valid fix.  Until that work is complete, remove this chang=
e to
> ensure that no problems are being introduced into the codebase.
>=20
> Cc: Evan Quan <evan.quan@amd.com>
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

AFAICT, this patch is correct or at least does no harm.  Handling of pm_run=
time_get_sync() errors in the kernel seems to be inconsistent at best.

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_display.c | 4 +---
>  drivers/gpu/drm/radeon/radeon_drv.c     | 4 +---
>  drivers/gpu/drm/radeon/radeon_kms.c     | 4 +---
>  3 files changed, 3 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/radeon/radeon_display.c
> b/drivers/gpu/drm/radeon/radeon_display.c
> index 652af7a134bd..9f29ba6c2bed 100644
> --- a/drivers/gpu/drm/radeon/radeon_display.c
> +++ b/drivers/gpu/drm/radeon/radeon_display.c
> @@ -627,10 +627,8 @@ radeon_crtc_set_config(struct drm_mode_set *set,
>  	dev =3D set->crtc->dev;
>=20
>  	ret =3D pm_runtime_get_sync(dev->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_autosuspend(dev->dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>=20
>  	ret =3D drm_crtc_helper_set_config(set, ctx);
>=20
> diff --git a/drivers/gpu/drm/radeon/radeon_drv.c
> b/drivers/gpu/drm/radeon/radeon_drv.c
> index efeb115ae70e..468b364c2dab 100644
> --- a/drivers/gpu/drm/radeon/radeon_drv.c
> +++ b/drivers/gpu/drm/radeon/radeon_drv.c
> @@ -513,10 +513,8 @@ long radeon_drm_ioctl(struct file *filp,
>  	long ret;
>  	dev =3D file_priv->minor->dev;
>  	ret =3D pm_runtime_get_sync(dev->dev);
> -	if (ret < 0) {
> -		pm_runtime_put_autosuspend(dev->dev);
> +	if (ret < 0)
>  		return ret;
> -	}
>=20
>  	ret =3D drm_ioctl(filp, cmd, arg);
>=20
> diff --git a/drivers/gpu/drm/radeon/radeon_kms.c
> b/drivers/gpu/drm/radeon/radeon_kms.c
> index 2479d6ab7a36..df644bb68c0f 100644
> --- a/drivers/gpu/drm/radeon/radeon_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> @@ -644,10 +644,8 @@ int radeon_driver_open_kms(struct drm_device
> *dev, struct drm_file *file_priv)
>  	file_priv->driver_priv =3D NULL;
>=20
>  	r =3D pm_runtime_get_sync(dev->dev);
> -	if (r < 0) {
> -		pm_runtime_put_autosuspend(dev->dev);
> +	if (r < 0)
>  		return r;
> -	}
>=20
>  	/* new gpu have virtual address space support */
>  	if (rdev->family >=3D CHIP_CAYMAN) {
> --
> 2.31.1
