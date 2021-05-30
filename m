Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86F5B395029
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 10:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhE3Izj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:55:39 -0400
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com ([40.107.237.82]:39061
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhE3Izi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:55:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wv9t4RyO/NHYbRmOroThnZDo9WBE3MDgGla8a7uEP5Va0YUAIJS3jv5RJYTOkCpk2UStQ59QzQ5+P8+UlffxgbekQP4n8MqKDrVgl9DBR8SiyYdWsod+5U89HOB+hsI92fx5GBGTuQexKcvF2BnwJF5XCWEn0jxsVWpYb/jGlaq2y90PNREClLSszv4qOXwgyGjgI0TEnccX7sAFXAjB+W011PMiczNHC8uRBHCfLu96c5opxsW8k4EmVOCeWWPbPDEYQMWguFf+A2zDwKfL9DUBpjYx0NgM1dbP5yPoPdFyRtSwegC3MrkTd43sFR3WUfgo2DdyGekY3xMgdHSr3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PjaX2IggDVlWqp49k0MyAa3NH1zsDVsbxyKrk7yJIw=;
 b=OWx7QZQ26Aaom5HWY/eLJHOwc8Oyc3htkzuBDB9zxUjNd7wzrQaMeAzBKDXkI574K1LFe3cmf6BXJS6aXX7G8uYRdpGg5GdfxxbmguAusSaq6UTolf+pL3n2qsYNqZjIYVFMo1c6IRO34P0WJzAmhXhisNC1DgaiYjybIoszOroT2PQMoN6GDGpuzAV2c+dikAkd3wfBNgySpaIs1vkFWoIFJwD9NjGX0D/oz9WUwtCbZiEzDr+0aIf8ZQxWHvNDfdl8IL3tjI1ACEiWXX5jf374/xL3Y62RK2+DvTc2P1+dr4ROHWc2Lsi/DiqjOJ0dQnaKw8Rcxuf40CB1eUJ0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PjaX2IggDVlWqp49k0MyAa3NH1zsDVsbxyKrk7yJIw=;
 b=CyiIQHxcb90oljjTWGfhgSz3Zl9j5A9d51PLXj0xBoIxc9N7k+trtrCqWLwGDa1qHKpAv8Sh85dB1VsPEbkeQBDMAcRBMQFuPV4WnOQnVmy3BPWe3/NG+LL1WbVezV4JUWNuNkJwNLI6utd/lEGBcpL0mBXySQKA9braNB2zvA/9t4fkjAuOdAnkE9iu8FhSSm06/dspZIY60ZeMqLkhOd9OJ25gm+Y6K2qpzp8zT+N8GOFD1qv8hVsr+Yc2EnU0J9Sj0TaTUkDwnLnph0BIU+GLpGIh1ihMng0VslYF7kqHV9AU7KPoZDnAeDIfHbd1mpqiHWFbQq8uSNxMbJQPkg==
Received: from DM6PR06CA0063.namprd06.prod.outlook.com (2603:10b6:5:54::40) by
 BN6PR1201MB0001.namprd12.prod.outlook.com (2603:10b6:404:a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Sun, 30 May
 2021 08:53:57 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::d2) by DM6PR06CA0063.outlook.office365.com
 (2603:10b6:5:54::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Sun, 30 May 2021 08:53:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 08:53:57 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 May 2021 08:53:55 +0000
Date:   Sun, 30 May 2021 11:53:52 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] vdpa/mlx5: Fix umem sizes assignments on VQ create
Message-ID: <20210530085352.GC120901@mtl-vdi-166.wap.labs.mlnx>
References: <20210530083548.6545-1-elic@nvidia.com>
 <20210530043721-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210530043721-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f122df58-32e1-4f5d-e622-08d923487605
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0001:
X-Microsoft-Antispam-PRVS: <BN6PR1201MB0001EBBFE68A365A18179680AB209@BN6PR1201MB0001.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:462;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3P0QvJJ+W+fxWoeYTWirvfc6R19j96EgXsfmveFN2cgs4fWAKdJSFmlt6euMy8sFpgg4OSfCXkS2tY1waYylfqafRXPdf4Q1ptyuwfTTg3nJ8p/m77HuwRZmVIvkRn4M6XG/pNIRAcVcpdKnYK+JzP2nhwT9oHFPE1zvkx6gL3VMKbns7WIYE1+QO70zOnH8Ca39NZidUp29f3kpx1m4dFaS0t+jjSNP1K5K+Y5qlkiLhz/s5CyAa7lfQOTrLCn+bha46Ay8vlwCmhzJTfFlJ2cQ8EpsSva8EtsD5GWSyPF5q/FeSLqe2IIZISVxnN4kXxtf2ryRTeS5j8w88ULW81NwspJLow9kFdM2rf5iyBp/9h3Htpt4FwTvtWGCGL7HiOl+suUXoTwzqRdLhnvGHss/tNHuaO5IlBFxrhsRKMJEtUuB33okowqxp9ke+1XhGyifzUwSKTqm1PQ2TvlJZBvHE6XppD6YxXE/WgsjRiw2dh0Z0+cHf20rqif6ebDXm97CmKVL1U5Fx7Sh73MNKpf1L+MtwF2s7OOz+zodooqx2gkTGWFtQ06MHFVcqopxRMmrK2Qdd5Uagy2SDSVEu9oEYLKg1qOZWZqqR/MznGZV4/Bg8bR4xKy66vivE4iU13yais4pQsTcyVXtH6QOAKlnPmfy11F/NpUbmEEimIM=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(39860400002)(346002)(36840700001)(46966006)(4326008)(36860700001)(26005)(70586007)(7636003)(426003)(47076005)(478600001)(82740400003)(7696005)(5660300002)(54906003)(33656002)(316002)(9686003)(2906002)(1076003)(356005)(186003)(6666004)(336012)(6916009)(82310400003)(8936002)(8676002)(70206006)(55016002)(36906005)(86362001)(16526019)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 08:53:57.3252
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f122df58-32e1-4f5d-e622-08d923487605
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0001
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 04:37:39AM -0400, Michael S. Tsirkin wrote:
> On Sun, May 30, 2021 at 11:35:48AM +0300, Eli Cohen wrote:
> > Fix copy paste bug assigning umem1 size to umem2 and umem3. The issue
> > was discovered when trying to use a 1:1 MR that covers the entire
> > address space where firmware complained that provided sizes are not
> > large enough.
> 
> .. creating the virtqueue then fails?
> 
> > 1:1 MRs are requied to support virtio_vdpa.
> 
> typo
> 
thanks

> > 
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> > V0 --> V1:
> > Add more information in changelog
> > 
> >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 189e4385df40..53312f0460ad 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -828,9 +828,9 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> >  	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
> >  	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
> >  	MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
> > -	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem1.size);
> > +	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem2.size);
> >  	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
> > -	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem1.size);
> > +	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
> >  	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
> >  	if (MLX5_CAP_DEV_VDPA_EMULATION(ndev->mvdev.mdev, eth_frame_offload_type))
> >  		MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0, 1);
> > -- 
> > 2.31.1
> 
