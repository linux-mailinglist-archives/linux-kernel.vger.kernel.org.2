Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3326C3954DF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 06:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhEaFAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 01:00:03 -0400
Received: from mail-dm6nam10on2083.outbound.protection.outlook.com ([40.107.93.83]:14081
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229717AbhEaFAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 01:00:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRWaUZFSruiWJ2SnNzVUoAB0iYvFUumctMibhmrVDA7ObyeK7gasROK86yzDHiO4hYIQS3Amd3XDuzJls9uBRUwSkvo4mL8xTEuU/8EssYIkdkrXq5zXOHxFkjuhbdJiViOtR2bsvJ5bamk21T6cDiYWqpjTKB1D0BnYtbc14TDbkWFZOz7IOYiEm2C+6rSzRF84LpaYYfQxpCrf1VpvJwU7Z+OU7aU8tP01xwaCt3mGXorVpalMoZqztBp7w8ANLIf4Dz9WXpR4mbkKBn8Hx0NElvpkBupBMyPR0I0NebIvmCOq3GsnooCaWXJlN68AFD63iGYT91djE0ponF/Adg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g41cSaVpD9CogAEtTrP3NSqQFzdW4sqjhCosqy0EV4w=;
 b=ReRA2EtWeWbaOgNsGm+KSrk6MEK1Qr3FaXxIyIUH/z9h7rvpD/+EqQYa0cULXSev/P8I1kN++XRI9IOfRMR5mEEgYAwwqLtA1W3mEFjXcBaNAgSvh+vjYWR4at2RKhxSXc+15bpTOEnCt79fvI3ygT2/29DSMOGZgyFiVGyUZT3KZLwRuvYlOP9HDGyFfuwpln097QYShJRihy3IOVUiGv0Y8xSvnMQYcm6Q3EeIrx9fnAl5I0yXfULWFpH4JHzUZJ+DqLd169QifEiS0PfjcIpH8K1d7PATKNQwaKFJfW6gwOmNEjEs+0TYfvCQnm5ebJCBN/UpqKLBboegL4Sgaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g41cSaVpD9CogAEtTrP3NSqQFzdW4sqjhCosqy0EV4w=;
 b=DeElFLQEDdus4q20Xw6gGG1cyPFWuWawTM/p777qjFuIa/gEynAXu8pgsUDL46erF/4EtgE+0wnmzCSHOXA5eQAPm1DkLBuFSUy6GTRnwWcOt/v4uzdUejThurPMp7wxVysg4oaQXTx0zTjaCZknfPOpbXhQ3JXO9riEQqJFfU1htAir6TPw+bwKNTwjYdR8bVJA8Mu2W7HjX8Zzn9ENyoQyplptMETk9yAc4ejwnRk6Sm4VJfeS8LXdtWscpZPltyzb1Y8b5WlV0wfD6q8W+pgDj0QLUHqX0yd9sPGj8psT4NxMVxlxM4oZhMXj+fs7InYAAr5kPBFmGTAiB9NSQA==
Received: from DM3PR12CA0138.namprd12.prod.outlook.com (2603:10b6:0:51::34) by
 MW3PR12MB4364.namprd12.prod.outlook.com (2603:10b6:303:5c::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.22; Mon, 31 May 2021 04:58:20 +0000
Received: from DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:51:cafe::f8) by DM3PR12CA0138.outlook.office365.com
 (2603:10b6:0:51::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Mon, 31 May 2021 04:58:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT020.mail.protection.outlook.com (10.13.172.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Mon, 31 May 2021 04:58:20 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 May 2021 04:58:18 +0000
Date:   Mon, 31 May 2021 07:58:14 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Support creating resources with uid == 0
Message-ID: <20210531045814.GA158940@mtl-vdi-166.wap.labs.mlnx>
References: <20210530075415.4644-1-elic@nvidia.com>
 <20210530075415.4644-2-elic@nvidia.com>
 <7e4f741e-e595-fe19-91ef-e6faeec765d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e4f741e-e595-fe19-91ef-e6faeec765d4@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c2bde12-2674-439f-f588-08d923f0b622
X-MS-TrafficTypeDiagnostic: MW3PR12MB4364:
X-Microsoft-Antispam-PRVS: <MW3PR12MB43640C46585B9D685E60D62CAB3F9@MW3PR12MB4364.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33KDCWINDbARMwMep0EC8gzkwQ8GnwxKhIOT+grN0C41fnDX1/Um6WwHGEeIxVhrlIisucb0AMxcDNvfsIPxM3Fj7WC89uNRCd5Bwkrch+qbgu47qOSInrI3MyFJOsYTMazbD5/hzWpYT92jS4x5/k0BdFMm9cP73oW4/zmVmAkGHiRbd3HUUzjki4RIlRWVyknznj6lhrjBGXtAmPncL0rBKrFcQcfu/5XOvA6qpQ+wuMXVoDdnsDSt+oPYDVE/GKwG65FJl7OF4oeKM9izqEMtgDrYJvSwePB0J2Zj/KN1ibc3k4T+wdSB07e+GEhVmwgQeCiRQjV236j5Mx1pA5r1uUWQzJqX6Zojh/LURbL63kQuJ3aIAyyyYZN4jcEqt6MAqcjXYLs5LRmgpxPXcbmAz9QFNXpSoeIxkKeF3bmeyL7rD0g7cTMfwB/6OPGV1ctZVPJI8JfHKIgZ+uf0/eNhigWLu5TDx3ACbVPhTzsHzMwC3GjIpv5iWgx83xPDzMQr0jWN3zTzpiZkcu7Jxqmv1rAHVXGBkAj2yjfQEBa9q/L/wSGfkPqJ99LvITnad9R9r1nmdr10ltFjN+WhNCsK6JopV4tC0A4EDSEUjsUu9XBfCDwZSvRfDKPNl2XE3zlEakWiygWicHicqoDbSZ6515V0i+nFoYq0XGNcTQU=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(36840700001)(46966006)(6666004)(83380400001)(8676002)(82740400003)(6916009)(8936002)(7636003)(356005)(86362001)(186003)(70586007)(16526019)(47076005)(26005)(70206006)(55016002)(33656002)(5660300002)(2906002)(54906003)(316002)(36906005)(1076003)(9686003)(82310400003)(4326008)(336012)(426003)(478600001)(7696005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 04:58:20.3294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2bde12-2674-439f-f588-08d923f0b622
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4364
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 11:02:21AM +0800, Jason Wang wrote:
> 
> 在 2021/5/30 下午3:54, Eli Cohen 写道:
> > Currently all resources must be created with uid != 0 which is essential
> > userspace processes allocating virtquueue resources. Since this is a
> > kernel implementation, it is perfectly legal to open resources with
> > uid == 0.
> > 
> > In case frimware supports, avoid allocating user context.
> 
> 
> Typo "frimware".
> 
> Otherwise.
> 
> Acked-by: Jason Wang <jasowang@redhat.com>
> 
> (I don't see any code to check the firmware capability, is this intended?)
> 
> Thanks
> 
> 
> > 
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> >   drivers/vdpa/mlx5/core/resources.c | 6 ++++++
> >   include/linux/mlx5/mlx5_ifc.h      | 4 +++-
> >   2 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> > index 6521cbd0f5c2..836ab9ef0fa6 100644
> > --- a/drivers/vdpa/mlx5/core/resources.c
> > +++ b/drivers/vdpa/mlx5/core/resources.c
> > @@ -54,6 +54,9 @@ static int create_uctx(struct mlx5_vdpa_dev *mvdev, u16 *uid)
> >   	void *in;
> >   	int err;
> > +	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0))
> > +		return 0;
> > +

This checks that the "umem_uid_0" capability is set. If it is set, then
I don't create the user context which will result in uid being zero.

> >   	/* 0 means not supported */
> >   	if (!MLX5_CAP_GEN(mvdev->mdev, log_max_uctx))
> >   		return -EOPNOTSUPP;
> > @@ -79,6 +82,9 @@ static void destroy_uctx(struct mlx5_vdpa_dev *mvdev, u32 uid)
> >   	u32 out[MLX5_ST_SZ_DW(destroy_uctx_out)] = {};
> >   	u32 in[MLX5_ST_SZ_DW(destroy_uctx_in)] = {};
> > +	if (!uid)
> > +		return;
> > +
> >   	MLX5_SET(destroy_uctx_in, in, opcode, MLX5_CMD_OP_DESTROY_UCTX);
> >   	MLX5_SET(destroy_uctx_in, in, uid, uid);
> > diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
> > index 9c68b2da14c6..606d2aeacad4 100644
> > --- a/include/linux/mlx5/mlx5_ifc.h
> > +++ b/include/linux/mlx5/mlx5_ifc.h
> > @@ -1487,7 +1487,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
> >   	u8         uar_4k[0x1];
> >   	u8         reserved_at_241[0x9];
> >   	u8         uar_sz[0x6];
> > -	u8         reserved_at_250[0x8];
> > +	u8         reserved_at_248[0x2];
> > +	u8         umem_uid_0[0x1];
> > +	u8         reserved_at_250[0x5];
> >   	u8         log_pg_sz[0x8];
> >   	u8         bf[0x1];
> 
