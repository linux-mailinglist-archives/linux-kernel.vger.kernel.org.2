Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B914C366FB9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 18:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244005AbhDUQH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 12:07:56 -0400
Received: from mail-mw2nam08on2085.outbound.protection.outlook.com ([40.107.101.85]:54464
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240353AbhDUQHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 12:07:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=klhwhoUqBtN2V+oWCS4XpxDvOOmt+OaPKbh5MIv0OljUMlpfAzuGC1kG30QKU6lyPzwTu3rTL7A8CNQMbh9SFQZ5fPTJsMIFLZNZ4m/+rmPizrTYiuHr7vzKeASCFeck9DqXYGC8Dw9Sz3HKzdjWJgBc6tg1Kz6PbXia+6FTrIaVXbk6hVE9jTKpogj3KtLJjk7J9nfIDuL1dMlzMCHyq33/sn4I0gxijNZoN72j9fipVPMfXQVnq5vqAJJefrSQHDjwEhAo4d+WY93e+3LYgc+/C4bfKs5AjbDREwWQ0qLv6IDlO9+wcbY04flAU0imHXGhAojZEPrbNpntojAGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XCE0QSlAaSUShnuH8f6DxwJZ7iroz0Bd7F0iqL1Dzs=;
 b=TgK1fFqtDH7yc9hawCTBxdSS8TV3Q996MUTZtcFrmABLBQnP+QLAxr0/hezhs0N4FdMAdiEod4IkLquWdSLQLWVNkb5ApR5+ww5QSjT0cN54Jzgqx7w3+yFpyEqPjIDz6J/m7F2mIEJgZ75IobgYR/ukjZt1Ew3f/q3NWFpAcq0IjYCca2D5D7C/A2cFuE1F2ViPPtesnhGnCcNuPM9261QEYTiG7h8k3WNHrdM+0suDNA6S26bBVgaqjqX1SDfx+xmcJHNyPVuLRT9Li+A9sP/WCCBzBHI4ipMtzQ0xvI+EoyoufoPUFCvIPec4PYLdGw7tBnbBowck7cyTok6ccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XCE0QSlAaSUShnuH8f6DxwJZ7iroz0Bd7F0iqL1Dzs=;
 b=AAZOekkVuW1t3V+yVnWvLlY3FpDJkC4al1iVkjay1C2QpdsS4VG6QSc9f1jGwInSajJTQnEDD25bUY0nryJo+lCVz7MzLFqE7HV0jIFyPxNH8D+9gLnl2wdXQ2+4BUG6IGCtf+iJ5+Szzemh8rU47MY7iaYVuvAbJhw97DY2/iM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4849.namprd12.prod.outlook.com (2603:10b6:208:1c2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 21 Apr
 2021 16:07:14 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 16:07:14 +0000
From:   "Deucher, Alexander" <Alexander.Deucher@amd.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Aditya Pakki <pakki001@umn.edu>
Subject: RE: [PATCH 023/190] Revert "drm/radeon: fix multiple reference count
 leak"
Thread-Topic: [PATCH 023/190] Revert "drm/radeon: fix multiple reference count
 leak"
Thread-Index: AQHXNq6NqBit+VV0pkGmOO8mOXvUjKq/IpgA
Date:   Wed, 21 Apr 2021 16:07:14 +0000
Message-ID: <MN2PR12MB44889F62CD7F3EAC7572AEA2F7479@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-24-gregkh@linuxfoundation.org>
In-Reply-To: <20210421130105.1226686-24-gregkh@linuxfoundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Enabled=true;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SetDate=2021-04-21T16:07:08Z;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Method=Privileged;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_Name=Public_0;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ActionId=c6374574-5ad3-44c4-aebe-12b4d8ca387c;
 MSIP_Label_0d814d60-469d-470c-8cb0-58434e2bf457_ContentBits=1
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5817a181-a6e1-4747-c7fd-08d904df873b
x-ms-traffictypediagnostic: BL0PR12MB4849:
x-microsoft-antispam-prvs: <BL0PR12MB484940CC2832EC023B58C736F7479@BL0PR12MB4849.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:608;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BTlBYoENxHX1uLBTjhPfo66elreGjS8cFYJHykqAYSPalVhoPIegp/bXgR77E2pl26CnxVO8Y2rx8pa+y2yfATFo0YNeZsCdeVlKVOxA+NVCtiTlfMwbCBxYKMTXsifRx9U++3E5Pyr8NCGSoLR9PLjx0XZCJv5akg9Y7b8DdcsClrxibLzK27oc8YCeQdI0U1E1aBOCN4el6679eoQrJCFIgw9f4nIxOIVCVQn2EyH54h153BRx8ZoIjW/ftgq2eMqlvOvg9/NNE9PAprU2QmjcMdTvphcTdigX/L5U7NRFly1Xa2ZVqghVrx4i+RPsjkmpf5Ii34ddhg/2mMZZHxPb7/UPa+MN2SrnlQpmJx5qUKVLRge0+/jNqAj87ZTWGHgRQXtUGcNNfEewc+bAj9+2xcJOtThUxq2PSUFkjZcJeg5xR0pqU2Ld5B//i6vUHoQpYtY2WpQFSFUc/JUoKoB3N/kH2ZJ3xOGc2eUdJF+rk/1kx3RMwzTUAs/ljH5xKg4peDq/VspTSJs8kNPAK6pMruBkwkjjMuG7+LQFb8+oChvX1HNHlpwS8UZ2lMTxZBiDIc+4+GUDuHKc1/kqljdvmgM8/qIEcR2cxx0STOQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4488.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(2906002)(110136005)(316002)(26005)(478600001)(8936002)(5660300002)(53546011)(6506007)(52536014)(38100700002)(66946007)(66476007)(66556008)(66446008)(122000001)(4326008)(9686003)(76116006)(64756008)(7696005)(55016002)(186003)(71200400001)(86362001)(83380400001)(33656002)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?SFO0IrzZVElGzfLwEY8s8etGZaNqvpooIZTEG4BDh2S+ElzF2zWi+7EKYD0T?=
 =?us-ascii?Q?fm/gKDMz9d6K6RBAWkR3yDCa1IIcq9XLewgSzMWXBbiEmPuKVCIHHkK0LKrZ?=
 =?us-ascii?Q?UHa0QU1ObWFnGf5jG0wGf+kK/ZJStuqX5/41VnQUvykSxcRNmWVIH7uCWEUt?=
 =?us-ascii?Q?UqV9oyqidEVs7lPLcYHy82S81A5ozFCtV0FzkF3uv9PDwfkmP9K3PYV71Vhu?=
 =?us-ascii?Q?KkQ9AAe0A2gdAPN2D4b+HiVi0+ohG9N64uDb7QbIbZD4k5RgZt7Q74ky8GpH?=
 =?us-ascii?Q?+k92ufGbs3UOCStKSifZbjytQ58s7+WTT7QDIMW9z/RJVngem4hxu7AzXbgw?=
 =?us-ascii?Q?IRaZQJOAAdoSYzkTmrhVwk6IqfPe71kVeFym/n6m5i6HmPVlK4TWLhJg/fve?=
 =?us-ascii?Q?L8fiETQeEv2gc7j48M9PSfNG1T4ffXbhpVyPAt3b7XCob+d0l6uN6ttCZxgX?=
 =?us-ascii?Q?O2VtgFxIE6g9kV1M34YVTutT+uCvRi7FwKZYDyg4QWU13bmW+5S3FdoVBxeS?=
 =?us-ascii?Q?LIxb+jHQkaT9vQrA+jqHcuVHtVz2MzkBNXtlsyJt6rpeUnGFAZC5Z0rS+CTr?=
 =?us-ascii?Q?VQ4QNnCs/Q7qqP3LnN0Sgcz9BLthV+wBdd5lokmRn7lByCgq1yQM2gyW4znS?=
 =?us-ascii?Q?bi37eyqYslaYOZJShZg2dWCTcLMt/2Sk+eIJntDpRQ5RAGWnDO42L3IBWLjW?=
 =?us-ascii?Q?r4y9qmzq+MHxe+wPqSMBWj/0V+FbTVQAk+8C8xXQoK7KVtQUUZXtahjplLre?=
 =?us-ascii?Q?XxbSTT0QZ3NdL80UbrNWiSpiqLnWOoddWE/XsqoerWoaPCiz8bhzKfzVQHOg?=
 =?us-ascii?Q?xD4jPXyvTw+VY98z6qkUR4LIx5SFNezpH7D5M86eMYzAcFh/4T7/JjJY9S31?=
 =?us-ascii?Q?ceuAxVjgnis719OBVfuesLT09eo2yYNPcnFZZUOuacj/mYH8ohye5fhjNE6p?=
 =?us-ascii?Q?EJFhzY6aHsCYuxgroieZ2bQgk090XULXhTiPG/eWWuBmq9B4dkClaE5x1fLX?=
 =?us-ascii?Q?k3Qty0cffBktCmQTX+TwSpHlBT6ZI9ipHAAWTTftC5RVP86YXhT0yLkvRvDx?=
 =?us-ascii?Q?cZVc6rDRHVuIO9QubnGddJLz6nlLYpWDl5fpvYE6FabecHlVKRA0TJ5b6cBI?=
 =?us-ascii?Q?3swwl06mSBun+Ue6BKjwH7ikrUnBcu2MIgtS2yRe4D9aMrrVXQDMMEAfoMnL?=
 =?us-ascii?Q?mEWoCCCc58A05VNeRhxGPZN/+Y5gMP7uyOAwkpDm8DXIkID4U3VrX7wTmsHA?=
 =?us-ascii?Q?vP8dJczAO6J5TQvKuPumaaeMO1JWEiCOeM/m/WR7hmGOhsDnXav09pP5fQHc?=
 =?us-ascii?Q?OQTZSP+Lwxb3X9CFfOmyRSyD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5817a181-a6e1-4747-c7fd-08d904df873b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2021 16:07:14.1680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BVUrvMZ3rjSMETy9qVyY5z4zXjy6bDZDWsbE+t3pqyco91imyRSX/80bxwITpaKiGSsXCeTnmqFPYhEo7S4/kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4849
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[AMD Public Use]

> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Wednesday, April 21, 2021 8:58 AM
> To: linux-kernel@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Aditya Pakki
> <pakki001@umn.edu>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: [PATCH 023/190] Revert "drm/radeon: fix multiple reference count
> leak"
>=20
> This reverts commit 6f2e8acdb48ed166b65d47837c31b177460491ec.
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
> Cc: Aditya Pakki <pakki001@umn.edu>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

AFAICT, this patch is correct or at least does no harm.  Handling of pm_run=
time_get_sync() errors in the kernel seems to be inconsistent at best.

Alex

> ---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c
> b/drivers/gpu/drm/radeon/radeon_connectors.c
> index 607ad5620bd9..ba8885676676 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -879,10 +879,8 @@ radeon_lvds_detect(struct drm_connector
> *connector, bool force)
>=20
>  	if (!drm_kms_helper_is_poll_worker()) {
>  		r =3D pm_runtime_get_sync(connector->dev->dev);
> -		if (r < 0) {
> -			pm_runtime_put_autosuspend(connector->dev-
> >dev);
> +		if (r < 0)
>  			return connector_status_disconnected;
> -		}
>  	}
>=20
>  	if (encoder) {
> @@ -1027,10 +1025,8 @@ radeon_vga_detect(struct drm_connector
> *connector, bool force)
>=20
>  	if (!drm_kms_helper_is_poll_worker()) {
>  		r =3D pm_runtime_get_sync(connector->dev->dev);
> -		if (r < 0) {
> -			pm_runtime_put_autosuspend(connector->dev-
> >dev);
> +		if (r < 0)
>  			return connector_status_disconnected;
> -		}
>  	}
>=20
>  	encoder =3D radeon_best_single_encoder(connector);
> @@ -1167,10 +1163,8 @@ radeon_tv_detect(struct drm_connector
> *connector, bool force)
>=20
>  	if (!drm_kms_helper_is_poll_worker()) {
>  		r =3D pm_runtime_get_sync(connector->dev->dev);
> -		if (r < 0) {
> -			pm_runtime_put_autosuspend(connector->dev-
> >dev);
> +		if (r < 0)
>  			return connector_status_disconnected;
> -		}
>  	}
>=20
>  	encoder =3D radeon_best_single_encoder(connector);
> @@ -1253,10 +1247,8 @@ radeon_dvi_detect(struct drm_connector
> *connector, bool force)
>=20
>  	if (!drm_kms_helper_is_poll_worker()) {
>  		r =3D pm_runtime_get_sync(connector->dev->dev);
> -		if (r < 0) {
> -			pm_runtime_put_autosuspend(connector->dev-
> >dev);
> +		if (r < 0)
>  			return connector_status_disconnected;
> -		}
>  	}
>=20
>  	if (radeon_connector->detected_hpd_without_ddc) { @@ -1665,10
> +1657,8 @@ radeon_dp_detect(struct drm_connector *connector, bool
> force)
>=20
>  	if (!drm_kms_helper_is_poll_worker()) {
>  		r =3D pm_runtime_get_sync(connector->dev->dev);
> -		if (r < 0) {
> -			pm_runtime_put_autosuspend(connector->dev-
> >dev);
> +		if (r < 0)
>  			return connector_status_disconnected;
> -		}
>  	}
>=20
>  	if (!force && radeon_check_hpd_status_unchanged(connector)) {
> --
> 2.31.1
