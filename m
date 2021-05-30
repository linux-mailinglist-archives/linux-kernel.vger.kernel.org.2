Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B036739501A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 10:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhE3I2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:28:34 -0400
Received: from mail-dm6nam11on2056.outbound.protection.outlook.com ([40.107.223.56]:10208
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229579AbhE3I2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:28:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=byC6NbxItpSADYjH7tRfQ7nbrVRFglxYZnJKD8tNcVJwyO3e2BRXCniE1+HVJtOeWV2b6+6Y2BHcLKFxMwdSDFGWUWBOYVNUbrGCQwVcBKHb11py6T7pUWp4rv3XjlYbfn2VjtolFQFYeAje9S1S7XZw/zsgcNrbIKRn5zr9s0nAnWVTugtPBXyAxan1lYT+2HE4WeQ7KBwvz3YZT0j6Gg8iGISE5C7DsAYADOQ1l/GgGpVlpw0TYL5V5NHHAC6mFeO/sLbTV37oD/FrrcSxGtK0/86wWZPUpmTiLJSW+v742UdYlyCqOC0bselF+MPeScWBrABKhW6UmxSOzCWmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/puGIxE+w1trwJyyDEeBQuVkScYOSGnwAHnoFzFR68g=;
 b=FLCriNZOQvxsYa7PLUGnwrfYMp5Y7+aH0NOHVCxkDSfN/yWpvanOlsb1vfXoEJVtKEovYqutHljvXiOQ7rWo+Y+vLa+6DxfdZws4HlMOjfYi/gqVy5RDxDVFekCYcE/bld+avhlOEzp8n4/uPz0gTEyfqjGds5Y6MP8UlxpI2njmhQCwv57fhmnV0zrUITgDpyC60rGt4QOPARPq+E1TD+Nbo6iZDKCKyq+M/OFxPKvrQeoSs5wT6vdh6Di83BoLaNBcmwh0A5pGs5KPeozGYh82jkWYfSK+NugIIP5MteDEtfs9aYImhCotIR4hrncwKtz/hCa9DDRsVCfgPmocWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/puGIxE+w1trwJyyDEeBQuVkScYOSGnwAHnoFzFR68g=;
 b=LQcpXH5H+M2HbhMZThE+7tydO+r1TMC7PkU1155LtcGpj7zpxLDNJDCsBcP/iICdOTXqyVKqbv2DUs7I/aVRLqk435zvDovd5lM41p0SGIXWMBzAYKyckaUJFMVM4oBs8W3RHnUJt6n6KTZD9v5a7V1hdix03aBKy3Rpc9WC+ZoPWfg7TlmrtxJR2uORIsNfaDtz2nRmTsD0floFLH7qntaVhuUa+yvp+23rhAuFFFBm+T/qlzuxyBWy+37unwbz8VZSS5rJZErgiRMVFt6G+iPkdq6zAdY0AFA5BSxzghkpHZfO5VXIIIZG8MFUkcC9pQIdkypxv87zGhQFK45/xg==
Received: from MWHPR19CA0021.namprd19.prod.outlook.com (2603:10b6:300:d4::31)
 by BY5PR12MB4049.namprd12.prod.outlook.com (2603:10b6:a03:201::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Sun, 30 May
 2021 08:26:52 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::e8) by MWHPR19CA0021.outlook.office365.com
 (2603:10b6:300:d4::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Sun, 30 May 2021 08:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 08:26:51 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 May 2021 08:26:50 +0000
Date:   Sun, 30 May 2021 11:26:46 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix umem sizes assignments on VQ create
Message-ID: <20210530082646.GA120333@mtl-vdi-166.wap.labs.mlnx>
References: <20210530063128.183258-1-elic@nvidia.com>
 <20210530040458-mutt-send-email-mst@kernel.org>
 <20210530081536.GA119906@mtl-vdi-166.wap.labs.mlnx>
 <20210530041624-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210530041624-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a596042-498e-47d8-1771-08d92344acfc
X-MS-TrafficTypeDiagnostic: BY5PR12MB4049:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4049EBFCEF1C6DB02F9C6DFBAB209@BY5PR12MB4049.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LtHGAOhfatBj6U9SeJEp65mCHC7KxZ4O1lWTNJXiitcous2JieVgKeOM7Wl0oEYtlp7YTxBBbjscwCfTpL+srT+dYW7FfGpkvmXt6qXJAN9KQU17GwzkHjxCTKruIZba6xJp72NklTK+XWfXo2lhk8Hwz+MKQLZRchekwIYkP9Ivy/sF9mB+GA9dtporuPcaaux+i8OmI0CbhlTvj3FJXo2wLmWxuWGq5EDc/OO9VY40qZRk5WusGweE75J18d9KSjkGye3E9L7+WGugZdC+Gl9ygH763IguK4N5TEOAVyWdiuHoxqxAJvzii6FtI/SDqDnxWPJXFAdxpBVGt12rgL09Q18b5HkDoqaw85+rz78lJz5r32zS14c9n2br05OJEu5IvExaIzHLj6r1jwWwPX5+grIz8ol9xj8jFcnCXC8PH8CHuiiVVzsjE7BJCiQdFdz+71Bw7eTa3IMw2xfeNgAVTINoD+NsDv2nt3lKUCnw6/+jj9CrZS2YdI70LtMyzb9y0t9USBHCbeAw0cHSGTEreOIZbsqqegmwH4AO1Av/cK08h9BpeJUi4WHX94p7a5+1y4LG/QA67TWl7hfGSo5sFgPIbBCEWehbxbezb6tWFEKyf/uBm6MQOxB+AFCTB+efDpjdc6LFLQPD1ME5rYjQ/zqXC1TSONZhoi3YuIs=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(36840700001)(46966006)(426003)(316002)(36906005)(86362001)(2906002)(26005)(16526019)(5660300002)(82740400003)(55016002)(36860700001)(7636003)(8676002)(54906003)(9686003)(336012)(6666004)(186003)(70586007)(70206006)(83380400001)(33656002)(1076003)(47076005)(82310400003)(6916009)(356005)(7696005)(8936002)(4326008)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 08:26:51.5556
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a596042-498e-47d8-1771-08d92344acfc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4049
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 04:19:01AM -0400, Michael S. Tsirkin wrote:
> On Sun, May 30, 2021 at 11:15:36AM +0300, Eli Cohen wrote:
> > On Sun, May 30, 2021 at 04:05:16AM -0400, Michael S. Tsirkin wrote:
> > > On Sun, May 30, 2021 at 09:31:28AM +0300, Eli Cohen wrote:
> > > > Fix copy paste bug assigning umem1 size to umem2 and umem3.
> > > > 
> > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > 
> > > could you clarify the impact of the bug please?
> > > 
> > 
> > I leads to firmware failure to create the virtqueue resource when you
> > try to use a 1:1 mapping MR. This kind of usage is presented in the
> > virtio_vdpa support I sent earlier.
> 
> OK pls include this info in the commit log.
OK

> And is 1:1 the only case where
> sizes differ? Is it true that in other cases sizes are all the same?
> 
The sizes are calculated based on firmware published paramters and a
formula provided by the spec. They do differ but it so happened that
size1 was larger than size2 and size3 so we did not see failures till
now.

> > > > ---
> > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > index 189e4385df40..53312f0460ad 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -828,9 +828,9 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > > >  	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
> > > >  	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
> > > >  	MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
> > > > -	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem1.size);
> > > > +	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem2.size);
> > > >  	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
> > > > -	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem1.size);
> > > > +	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
> > > >  	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
> > > >  	if (MLX5_CAP_DEV_VDPA_EMULATION(ndev->mvdev.mdev, eth_frame_offload_type))
> > > >  		MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0, 1);
> > > > -- 
> > > > 2.31.1
> > > 
> 
