Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3A6395012
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 10:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbhE3IRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:17:22 -0400
Received: from mail-bn7nam10on2061.outbound.protection.outlook.com ([40.107.92.61]:13153
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhE3IRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:17:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q25LM0swsET8PU7ysAINInh5imURIXBXClBqEHXp2dTifoUfirsY0uNfgMDiL8zK33eKbp4H+63qTNNGkhETIS1UP0KeeWmAcwVephodyVFMJ+15AX6n7y0cavOJFdB0GrWHfJza961H1qYoH/OZhMJofmN0lAqCZVhNunpLhVhURJFIPZYP6uu30dC3tE+FYmqf/ox9fWFU4nB2vcVVdqCZmgzDNcFgqWz9gvg831EgEmbzHaRx24n8VwYoQgazxHv747zCc8EKum0NsiHw1vcMQN21Pg/zAnZ3LJXjNa+l4avTNx5slcJ8Flywa/VQMlI2ShYDMzKOlBjnZ+FNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFmwBZzaxPcvjXBaxb0tSAztd7VC2qfProEMG6cUJaY=;
 b=aQ7OKqo01kEjsSRJ0AXEonnUMcdiLpghRhUtKb7PkpCm4AFjOK/kckG9S8deTUp3YfFiX8iIONAtclZTWlUJEzsKCapDuIMjcxznZVpbZIsbsDdHpmIyrzSVYoJn3+2OL2gsl6VYWOUjMmaB6NRAtHkut5muhHLaiIvukk9t5BfDCQJXKRPce6JlmzWQC1lLv536rM852HmujpG932G9kx6aB2AUfbLhi5rpel+03t6eRqsC2z3TW3IRghX2UVjjmwWb5YtC0nChMJI0KQt9iUBLrLpC//iy2+vGVnEw7VZJ2tL3GkAS9HoX+fN+qx5MEJBOkJzMLsSo2nz2+hqUWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFmwBZzaxPcvjXBaxb0tSAztd7VC2qfProEMG6cUJaY=;
 b=Dzny+o58QZZhHH3HacRBTjAFvrkw+XUBHCyusyUzijBdc02ELaK/tpCturmHEbNK+OPUDqhEs6IYygD7+rbQ8xGfc1ApcIe3yxJulxMjdrb9VpI7AKVxBfKYGb+iG/IfsGE9u8Tby5d53nzfO4C869SjleUuMZ3g5etlYCommX9qDAIS6pkIq/wSYDoiU3yk3//jZCDI77XEy95RY1FIBQkIw6GwX6GZx9UKNAdRzgONOPUAD30l6N7WarGecRYstCgqGkUG94wti7K6QMGAqmtDknatMX/IbbBHhWu5OPYqnXMTDyAhZD9UcCoJtzJfOu5pTetQ3JJQh/PyaWcFpQ==
Received: from BN6PR11CA0015.namprd11.prod.outlook.com (2603:10b6:405:2::25)
 by MN2PR12MB3773.namprd12.prod.outlook.com (2603:10b6:208:164::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Sun, 30 May
 2021 08:15:42 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:2:cafe::a5) by BN6PR11CA0015.outlook.office365.com
 (2603:10b6:405:2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Sun, 30 May 2021 08:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 08:15:42 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 May 2021 08:15:39 +0000
Date:   Sun, 30 May 2021 11:15:36 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix umem sizes assignments on VQ create
Message-ID: <20210530081536.GA119906@mtl-vdi-166.wap.labs.mlnx>
References: <20210530063128.183258-1-elic@nvidia.com>
 <20210530040458-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210530040458-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf906267-62d6-45db-af2c-08d923431dfc
X-MS-TrafficTypeDiagnostic: MN2PR12MB3773:
X-Microsoft-Antispam-PRVS: <MN2PR12MB37737D8A9361FC732D2D76EBAB209@MN2PR12MB3773.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:792;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C0rMpndxkbkY0ZHJNSVILwJNRVOieO2Xe4YdR3AOgeiLNlGDTrq1DjNIQVFT1i1I/E7N5ooOvvsoVFuAdfZHco8B9IoNa6MUb9TLvoHkvxDpCxl3sWnkzspE+FMdlBuxJ9a2L6u6FNndOL39ST2M9VyciNEGtmFw9Pvv9yFfgE2T2ChNNI7zqYEMV4XZ/z4429t4J945UUMJGzGk1vHTXKybRj7TUfzBu12ht2VPpGt9kfxB04/fywuKnRjA+joqGJ46OBzUuKUn3NgLrpr7miEvCFvsfaCjMGJppGmSqsJS88HJyRq69AHd3SWuEW3rSkmBGUcxbKDWAHxxY79CBuJUWURWjbU5WJVhL31Z7FeGsPeE2s/psHe8/oqxX/hkCaZJS7OT6Q32T5Tw89vkkbC57IUNjYicQFu4HMgl31ASVFV553J5b6jdUfpcZYzEWj3sHGgAJPL2HoVoU1/pvjr6y68SwtK/gMmabbEsQ/fns/lijGTGlh8V4+W0jIN654bp3zYG7dTVTs4I3XG9sxyNY+U4t5VkVr1UUIe+1n9Cxf0IWNLCYyJpaK/JWmr0cWqNfpPoH8ADNsA2zs5rdQnNZ0aIy8sgQyzTpo/HJgIbBKE63N20B+rZlWVA+AnZRbsJJGIE+E0cu90pZB5lfMiQ3pjsuWnAlWZNRh1efbo=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(36840700001)(46966006)(426003)(8936002)(336012)(86362001)(4326008)(2906002)(7696005)(5660300002)(70206006)(55016002)(36906005)(7636003)(6666004)(316002)(8676002)(9686003)(33656002)(6916009)(54906003)(36860700001)(26005)(1076003)(82310400003)(186003)(478600001)(47076005)(356005)(70586007)(83380400001)(16526019)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 08:15:42.0706
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf906267-62d6-45db-af2c-08d923431dfc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3773
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 04:05:16AM -0400, Michael S. Tsirkin wrote:
> On Sun, May 30, 2021 at 09:31:28AM +0300, Eli Cohen wrote:
> > Fix copy paste bug assigning umem1 size to umem2 and umem3.
> > 
> > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> 
> could you clarify the impact of the bug please?
> 

I leads to firmware failure to create the virtqueue resource when you
try to use a 1:1 mapping MR. This kind of usage is presented in the
virtio_vdpa support I sent earlier.

> > ---
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
