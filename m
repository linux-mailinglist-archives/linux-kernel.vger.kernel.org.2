Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6067C3954E0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 06:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhEaFBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 01:01:03 -0400
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:28899
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229730AbhEaFBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 01:01:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AI3iQ6s7jwhs5hKdoArnRsxidYCc5aLZ0nnxfi9u+c43o0tgpzXxeycdpJW4BLFa8gUTPgbhSJxfoWAwtpx38eWkmUgtpO/oTf5MbfIgduOogbJZ65pdcuW8GDVBwCc7k7pMQ+685xS5hZDt8EEVqhXdWpLSsggqFk//3tFu/+vCRm96LY7kFAwsKsXLj3Z5grwt9HUPcLQ457LxXwnsZcwYYvEsMkTKlV7cOeBbOmsyku4Xg8LWy4JOPw24P37DLSgFgLhv4P552xrWsptViPYYkEoNcWnZ4NPFpJF/3wyZzQpD9Iy3A12m8TQu7w0HSFfKjPFP5htYC/pUzrfXnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YW7rYVSHdhEIbcda3IfM+lDHDGbz/fTEuFkZpIQnlME=;
 b=izmhTA5pEUqkd5maitsQXx6sQzvb3+1GNWV2J8T35gauMlrJXA/EF3j3Yv+WL34bd2ECa3X1XUAGt3qqIOk8zNtH/68BuoOZ4mRk6G2enAJrYarSKq4JqVprmGGIYHFhneq9Pmcnv+/htgY8mLNn7HRQcvdPyTjplNYeKnNhPA+QXkRvShyQHRD1BBbRWyAC/vm7gRlNjzovc5EiqnrgeyoA71fW6My6VeQ1lxaW47g4L0ifl6X5snitju36e4zaJyDCyXvAcMkgUzdZI2wLv/eGWlZ9KwqgUy8iFoXJxYjXpgx7xm//2TOAffZg+alyFxI0UrMJe9fns/ZS6QpFZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YW7rYVSHdhEIbcda3IfM+lDHDGbz/fTEuFkZpIQnlME=;
 b=icx/Qk1i/DG+ibMp88wq25gFyjsWUbpBEKjWJQn4jVQ0pIWKr8E1tNPKzJuZI6/3xd4LEZRnpKhoDgGdlOu/iFR8lvVQZMe3uKI7Q5lJqzw6fkwMdb7JLHbdvbsaYEsMfSsa4JI7oJCtTIn3joa9jgQQnbJUTPHTKK5PTgNQ1Jwes1AR+Us5cN3YSEWPqhL9NrssSkWnaFvDYCOo3F6eV1+9AOf1XUMkZ5jCxdCxsihzBqD2owB31yCVFUJx1prO3CVppOSxp0M63dAb4eoO+vnO6UN6HP5dIBl1KIYxGYS06VhsvmfYoEaFjgWlhex+Knulsp9qM79defWUlOqAbg==
Received: from MW4PR04CA0193.namprd04.prod.outlook.com (2603:10b6:303:86::18)
 by CH0PR12MB5106.namprd12.prod.outlook.com (2603:10b6:610:bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Mon, 31 May
 2021 04:59:20 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::5a) by MW4PR04CA0193.outlook.office365.com
 (2603:10b6:303:86::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Mon, 31 May 2021 04:59:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Mon, 31 May 2021 04:59:19 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 May 2021 04:59:18 +0000
Date:   Mon, 31 May 2021 07:59:14 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Support creating resources with uid == 0
Message-ID: <20210531045914.GB158940@mtl-vdi-166.wap.labs.mlnx>
References: <20210530075415.4644-1-elic@nvidia.com>
 <20210530075415.4644-2-elic@nvidia.com>
 <7e4f741e-e595-fe19-91ef-e6faeec765d4@redhat.com>
 <c9c2a453-7ceb-a0ad-7731-d150b3bc1e53@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9c2a453-7ceb-a0ad-7731-d150b3bc1e53@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1e109c1-ccdb-451b-7970-08d923f0d9a4
X-MS-TrafficTypeDiagnostic: CH0PR12MB5106:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5106C63D029E1D121878D23BAB3F9@CH0PR12MB5106.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O87oCLEj1PatiSj0CpNfU0fVH/7wUcuxodnhfiECcPbD1zBV7TWxJ9xNf6oJEo8YYUms0/VxpZ3HnMVYzJP0Grb3WB+YAak13e+oWRiGhSsoto4ZeIy5hBHTDGNWCD0H5HrWCi7nTY8p7qtHA1n31JYYQiyo/gi4ksBo1ZzuzWISY7hHNKMgTZtXxd8+NTYzzroQOh5HYfHNsXHKNcsnxVt7fmiwlPIxGj6i+uSpi6VaH5cyVUJsHaJ0zTE0U6Xeb0KZgSSIVhUuoHkwV/cKYDiVomF/UGj0sZh9HvOx/jfjafBGCJUi8Mi/eT7sljob5xg7UYJAXaQnriR/NwVRaGmPegUmHTd5e7opSQjckkKNw0XHg5VDqqvg/wyCRkwDm0WPgk4sVqeidjIZi0wqph1KCE25bpOJQ4SwnKv9+saQwhSm/WJo5oS7wP5q2hrVLqSsV0sOfOKOvP3VMfG4cXPk3qzaOD7Qda1Nl38FPyQbZnqkfruGn9BEvJD3fwl+R/DkuOHcX35xBniAqE4/AbpbVGsWBw7Mx37NJ0KsUIMEHKTVsve3kApG9TqGGfJw4YaiWMzxWBiUWdr/fmxuDMbnkw6IGjH/RsPOFjPV9OpIyK78wCICPJDOvXRUvUg5kPyJBesNBt4PpLAqY54R2RdVJWsdQ5pDZS+9835gLPM=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(39860400002)(346002)(36840700001)(46966006)(82310400003)(7636003)(6916009)(8676002)(2906002)(70206006)(426003)(7696005)(36860700001)(55016002)(336012)(186003)(6666004)(33656002)(54906003)(356005)(70586007)(82740400003)(478600001)(316002)(36906005)(83380400001)(26005)(5660300002)(4326008)(86362001)(47076005)(8936002)(1076003)(9686003)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 04:59:19.9014
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e109c1-ccdb-451b-7970-08d923f0d9a4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 11:06:59AM +0800, Jason Wang wrote:
> 
> 在 2021/5/31 上午11:02, Jason Wang 写道:
> > 
> > 在 2021/5/30 下午3:54, Eli Cohen 写道:
> > > Currently all resources must be created with uid != 0 which is essential
> > > userspace processes allocating virtquueue resources. Since this is a
> > > kernel implementation, it is perfectly legal to open resources with
> > > uid == 0.
> > > 
> > > In case frimware supports, avoid allocating user context.
> > 
> > 
> > Typo "frimware".
> > 
> > Otherwise.
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> > 
> > (I don't see any code to check the firmware capability, is this
> > intended?)
> 
> 
> Speak too fast. I see the MLX5_CAP_GEN(), so it's fine.

And I responded too fast :-)
> 
> Thanks
> 
> 
> > 
> > Thanks
> > 
> > 
> > > 
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >   drivers/vdpa/mlx5/core/resources.c | 6 ++++++
> > >   include/linux/mlx5/mlx5_ifc.h      | 4 +++-
> > >   2 files changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/core/resources.c
> > > b/drivers/vdpa/mlx5/core/resources.c
> > > index 6521cbd0f5c2..836ab9ef0fa6 100644
> > > --- a/drivers/vdpa/mlx5/core/resources.c
> > > +++ b/drivers/vdpa/mlx5/core/resources.c
> > > @@ -54,6 +54,9 @@ static int create_uctx(struct mlx5_vdpa_dev
> > > *mvdev, u16 *uid)
> > >       void *in;
> > >       int err;
> > >   +    if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0))
> > > +        return 0;
> > > +
> > >       /* 0 means not supported */
> > >       if (!MLX5_CAP_GEN(mvdev->mdev, log_max_uctx))
> > >           return -EOPNOTSUPP;
> > > @@ -79,6 +82,9 @@ static void destroy_uctx(struct mlx5_vdpa_dev
> > > *mvdev, u32 uid)
> > >       u32 out[MLX5_ST_SZ_DW(destroy_uctx_out)] = {};
> > >       u32 in[MLX5_ST_SZ_DW(destroy_uctx_in)] = {};
> > >   +    if (!uid)
> > > +        return;
> > > +
> > >       MLX5_SET(destroy_uctx_in, in, opcode, MLX5_CMD_OP_DESTROY_UCTX);
> > >       MLX5_SET(destroy_uctx_in, in, uid, uid);
> > >   diff --git a/include/linux/mlx5/mlx5_ifc.h
> > > b/include/linux/mlx5/mlx5_ifc.h
> > > index 9c68b2da14c6..606d2aeacad4 100644
> > > --- a/include/linux/mlx5/mlx5_ifc.h
> > > +++ b/include/linux/mlx5/mlx5_ifc.h
> > > @@ -1487,7 +1487,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
> > >       u8         uar_4k[0x1];
> > >       u8         reserved_at_241[0x9];
> > >       u8         uar_sz[0x6];
> > > -    u8         reserved_at_250[0x8];
> > > +    u8         reserved_at_248[0x2];
> > > +    u8         umem_uid_0[0x1];
> > > +    u8         reserved_at_250[0x5];
> > >       u8         log_pg_sz[0x8];
> > >         u8         bf[0x1];
> 
