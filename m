Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5409395027
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 10:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhE3IyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:54:13 -0400
Received: from mail-bn8nam11on2050.outbound.protection.outlook.com ([40.107.236.50]:24545
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhE3IyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:54:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhBN8KWiugt7S8hJ+b5rNo8AklKwIGTYfcxW8HlMQW6ZNrSw/sNrtXiSHM7Fq/odeY7igPRYsJ4+sSpJqq433hQiei81txNIipwSOoTUYBfhxRY+IuAIZThqT8lPMpvPEmA0KnxozoQKN+/2hTAOfdZ4UckiBftyIiW74cPnt3N3ry3I+1ZG+JKENKUvdgkAxpCwyOANeG8gNxGL//aYwvS1UUitbLP4j8hBkVqMCf4LnyU1P2CB63oburTIQMvC3UtWIFk+lCFeI1aydDD2WtY1/lVewiUd+Bbzc6+X4zzoJJRKteYydHcU2x/jrMkjkvJCFfCFsFC7EfUpN844eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMxfeWsRQlXr4MrxqNgU9xkKovTP2cyb6ZBKBHkpUa4=;
 b=W98qnz/Y3zTOWhd4e5Zxm/rBMlq/lSDxhIlVMuw66S78nZtU1UrCIz8YmtldiUYnJIdgPxOaxmpGODDew5CgCPaEeMpYiYlezrqt1Pn/gMuJz8mT1EeRLKSFiP/6n+Ub6QKjHqlsyLKMVIkOjyLYzZibtbFAeOg8O4HM7wlWcA8r5rNoYmrTSmVEXYu4lZc8CAV4r5ghHlS42J2XMePxHmtRp0aY1PgJmnzIuWEGqiRsicUrZeo7TvDqXV6yp1nKU8dXwZuBrGX+pt4YR+N74N8ISUcu9McG/V7Xto0fKNulqLh+mzr670fXLCs6Bq3ZokBj3P9pC2bfntLhTnqLNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMxfeWsRQlXr4MrxqNgU9xkKovTP2cyb6ZBKBHkpUa4=;
 b=FhuO2OSleEAPEXwe5tSIXwJLK2R7FDGFSnsRgHthC4i1y7VKzaSWud+temFJXqg8aEKUXgXpiY24RwfHMbaNg0TO9VpLQPPkwFddyZQkOL5danHPJ5xRf33JEwVEU9/VmB/Nmy5SU2U5RCGkGGq3rnn41frxGmKmz6rPv/M6kBO33G5RJ9BJylB/AooYRxNqb+2gcxaVLKT7Wc5dc2whguzympqBbCYH/uIgtWrVBI/d31oYz/QTLJHxTf28MT9lVgRkfjzC8P/3QqurRXkJUx5pnUCSfs11nK0+yiFVfsup5KkKBKVgFEDOKcfACIF+7w1+LitFTo6cPyZ5hdYshA==
Received: from DM5PR13CA0053.namprd13.prod.outlook.com (2603:10b6:3:117::15)
 by CH2PR12MB5531.namprd12.prod.outlook.com (2603:10b6:610:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Sun, 30 May
 2021 08:52:33 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::d7) by DM5PR13CA0053.outlook.office365.com
 (2603:10b6:3:117::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.9 via Frontend
 Transport; Sun, 30 May 2021 08:52:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 08:52:32 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 May 2021 08:52:30 +0000
Date:   Sun, 30 May 2021 11:52:27 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] vdpa/mlx5: Fix umem sizes assignments on VQ create
Message-ID: <20210530085227.GA120901@mtl-vdi-166.wap.labs.mlnx>
References: <20210530063128.183258-1-elic@nvidia.com>
 <20210530040458-mutt-send-email-mst@kernel.org>
 <20210530081536.GA119906@mtl-vdi-166.wap.labs.mlnx>
 <20210530041624-mutt-send-email-mst@kernel.org>
 <20210530082646.GA120333@mtl-vdi-166.wap.labs.mlnx>
 <20210530043536-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210530043536-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62d72eb7-7ecf-4946-c630-08d923484391
X-MS-TrafficTypeDiagnostic: CH2PR12MB5531:
X-Microsoft-Antispam-PRVS: <CH2PR12MB5531BD9A9287DC5DDA17C9B8AB209@CH2PR12MB5531.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VOXb+kEl5Fd4uWjuzrwYyP81q+XSPohU8vn7xv1i6emXJmaK9e3nqYavtOWosJc2AZ7MQTZe5x08PyfNPo889uGa+lCH3a0JkUPZderriUKP4nRe7thnVzsOLlQcbdrEk2YSengP5xlnly3+jgfGK4kJoYTPCCmE1m+y1f7KCTpPhYJYxgnFRYnpmjL0Xj1mn4G+ly8E3LLsyKYH/Fpfn5oEafT57h9/2W2W4ZepmFSJUntodKm+sLdpJpmmtTyWM6ee/3lyj3ivkbjc/5mE9trzV8ZYmUrYf/qfWCjoZAWbdGQscVa6ckhLJi0RAoAHjNy3nGkQaGcR+EA4GcuVtTtfSSMGUAAfxXBkCsJm+24pFadHZ1XsWK9YpIdzSEkj7Jh70GW5ahNWz3S3RSarOn9xeRdg3ZyMPQwuZL+u+mK/2XM70Y4LbT1U6Y6wFBM9FY/rGaXXqxautSJc+n3mZXy7Rx/RJpDRDlLG0dPozNuHeGjE+XlSklQ/TlCtVrP8SbX3ChmBKV/RAd4bwR7nOG5xiLbWGogYFUYV3bIXGk5ANeBmepXqKIr8HlzEeKGby1A3WLaDrmtoDtp3BjKLjvwEtHnhXM9512dcc3B4q1dT8uSEI+EbIvbkyBsFzXx+j2jWkt7VvjU0pzL4V382mEzc6Z24j2WBGVDdDqzY6wo=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966006)(36840700001)(55016002)(478600001)(8936002)(7696005)(47076005)(4326008)(6666004)(7636003)(356005)(33656002)(82310400003)(2906002)(54906003)(82740400003)(186003)(8676002)(26005)(336012)(36906005)(9686003)(426003)(316002)(70586007)(70206006)(16526019)(83380400001)(86362001)(36860700001)(1076003)(6916009)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 08:52:32.6700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d72eb7-7ecf-4946-c630-08d923484391
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5531
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 04:36:17AM -0400, Michael S. Tsirkin wrote:
> On Sun, May 30, 2021 at 11:26:46AM +0300, Eli Cohen wrote:
> > On Sun, May 30, 2021 at 04:19:01AM -0400, Michael S. Tsirkin wrote:
> > > On Sun, May 30, 2021 at 11:15:36AM +0300, Eli Cohen wrote:
> > > > On Sun, May 30, 2021 at 04:05:16AM -0400, Michael S. Tsirkin wrote:
> > > > > On Sun, May 30, 2021 at 09:31:28AM +0300, Eli Cohen wrote:
> > > > > > Fix copy paste bug assigning umem1 size to umem2 and umem3.
> > > > > > 
> > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > 
> > > > > could you clarify the impact of the bug please?
> > > > > 
> > > > 
> > > > I leads to firmware failure to create the virtqueue resource when you
> > > > try to use a 1:1 mapping MR. This kind of usage is presented in the
> > > > virtio_vdpa support I sent earlier.
> > > 
> > > OK pls include this info in the commit log.
> > OK
> > 
> > > And is 1:1 the only case where
> > > sizes differ? Is it true that in other cases sizes are all the same?
> > > 
> > The sizes are calculated based on firmware published paramters and a
> > formula provided by the spec. They do differ but it so happened that
> > size1 was larger than size2 and size3 so we did not see failures till
> > now.
> 
> can this have a security impact? e.g. can guest access addresses
> outside of it's memory with this?
> 

No, this memory is accesible only by firmware for its internal use.

> > > > > > ---
> > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 4 ++--
> > > > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > index 189e4385df40..53312f0460ad 100644
> > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > @@ -828,9 +828,9 @@ static int create_virtqueue(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtque
> > > > > >  	MLX5_SET(virtio_q, vq_ctx, umem_1_id, mvq->umem1.id);
> > > > > >  	MLX5_SET(virtio_q, vq_ctx, umem_1_size, mvq->umem1.size);
> > > > > >  	MLX5_SET(virtio_q, vq_ctx, umem_2_id, mvq->umem2.id);
> > > > > > -	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem1.size);
> > > > > > +	MLX5_SET(virtio_q, vq_ctx, umem_2_size, mvq->umem2.size);
> > > > > >  	MLX5_SET(virtio_q, vq_ctx, umem_3_id, mvq->umem3.id);
> > > > > > -	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem1.size);
> > > > > > +	MLX5_SET(virtio_q, vq_ctx, umem_3_size, mvq->umem3.size);
> > > > > >  	MLX5_SET(virtio_q, vq_ctx, pd, ndev->mvdev.res.pdn);
> > > > > >  	if (MLX5_CAP_DEV_VDPA_EMULATION(ndev->mvdev.mdev, eth_frame_offload_type))
> > > > > >  		MLX5_SET(virtio_q, vq_ctx, virtio_version_1_0, 1);
> > > > > > -- 
> > > > > > 2.31.1
> > > > > 
> > > 
> 
