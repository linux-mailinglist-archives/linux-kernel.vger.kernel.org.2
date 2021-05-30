Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B86395028
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 10:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhE3IzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:55:02 -0400
Received: from mail-bn8nam12on2067.outbound.protection.outlook.com ([40.107.237.67]:47887
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229500AbhE3Iy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:54:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd1IhhuI4Yb7d1pZWqGY2/lFa6NhbQd/j1QkEfA7W08OSo9R5djr32r01G5Ep3Z7s5JKmNJ2Pw1fAJtf7N2IuurxbD9pRti/R6KJ/GWK7ZMN5NUcFU9kt6pI+1kUYbDBqu+fNVMDXWczElk8PWSJr5Yn286SBjsaIiuerlYX1oYFCKdQ8B1BJxoX8LXRADAston8VXmAUbuLouUX8kq4k6RQhvNlvxTIN19jjra0Pvrg1yxsM6I8osVKFX8/1PJve20+SkzJcWbeCbrGjoVcEULe+ogzvWiuXkYOKBCt1c+hBiGomd6dsSyg1kokiqtE/EIOFuHVY98wAExXTgpYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xP7i0IE4Cu/kHjMLJdhJLQsre/GCNdmfw5gWapvi+M=;
 b=XdlY0MeRp/Cmp4v5u/C34kKBWYEzdBzSyXJ1XFTHbepIzWw5q6Sfhi5YWZSonT6dxroWFWldtQAVDas8n6Kjk1F8TM15LxQD22ASOhhFDQgN1M0vxgBVfcZdNxTatwsHk/804NTPgaPScmYEEI9ihFSz3pwnD1MXeGcwBx+39Sfu4KpehGX9q/Qe6rtjcUP7xPlga4X8d8XbiWvSq7ZqJ1x3+s8sdlPKVRcMOPeh5HGU1ATJCNiFZcbtIz5h2StSjS+jA1HLHNfvtqaHWoEpdCb+pyJYBKtIaYc5dmNH+f1iJcurfvOtgpnf3OGF/axV/OGGZLHDRNdslsvq4D2kUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xP7i0IE4Cu/kHjMLJdhJLQsre/GCNdmfw5gWapvi+M=;
 b=Q+1myqPxPRB3l2UgFKcCUFQ1Lk0j8Tn6KwrDADdo4Ze2vbNtr9wKvKUZUdDyIUiiSyKuiscY6c1baJj5T1a387QnwrQIDLm5GOQCH/u6R3BObz5nu4CwQ0xgi8I1CJAHtt1ycxemexg+5GdhH2JmrrfUJalQKueHRdU1wbl5rsY1WnB7f8oZUcOvOr9fOmujmp4T0hAn4LCG8po3P9DmvVKZnqVzX5rP0a73xROYexgm+VoMOzx3a+i0EkejpxLRQEJqyCLNz2CmIyK3n3Bzq5UR3RNyKyzSmzXlGt+4X8zg4KK/+32VrCvZDiPQnPyNN3L67t4MMH2JZ/B5iUnCZw==
Received: from DS7PR05CA0005.namprd05.prod.outlook.com (2603:10b6:5:3b9::10)
 by BN8PR12MB2850.namprd12.prod.outlook.com (2603:10b6:408:95::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Sun, 30 May
 2021 08:53:20 +0000
Received: from DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::83) by DS7PR05CA0005.outlook.office365.com
 (2603:10b6:5:3b9::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.10 via Frontend
 Transport; Sun, 30 May 2021 08:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT033.mail.protection.outlook.com (10.13.172.221) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Sun, 30 May 2021 08:53:19 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 30 May 2021 08:53:17 +0000
Date:   Sun, 30 May 2021 11:53:13 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
CC:     <jasowang@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] vdpa/mlx5: Fix possible failure in umem size
 calculation
Message-ID: <20210530085313.GB120901@mtl-vdi-166.wap.labs.mlnx>
References: <20210530063214.183335-1-elic@nvidia.com>
 <20210530040523-mutt-send-email-mst@kernel.org>
 <20210530081721.GB119906@mtl-vdi-166.wap.labs.mlnx>
 <20210530042055-mutt-send-email-mst@kernel.org>
 <20210530082748.GB120333@mtl-vdi-166.wap.labs.mlnx>
 <20210530043634-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210530043634-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af0743ec-7d2a-4421-bbcb-08d923485f93
X-MS-TrafficTypeDiagnostic: BN8PR12MB2850:
X-Microsoft-Antispam-PRVS: <BN8PR12MB285074A958432C472F71C33FAB209@BN8PR12MB2850.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ujrjX4Mol9gKa171ctaCd3YokfS9HHNdrD9q0d85D0s5/LLtsogSCBocsiaLMKHB/ctRkE7KyDn/pgCr0VPukyaVecbNfM/o7m4EN+eMQia0y6hNE2Vwy3/ul+pBpAmBpbTQtR3ha2KSRgU26dRkgZ4+rsscqj51TBOyfl4LyDHb217NXLVeyB8Q0yr++ltJtJFA/ffnIO5rFA3zlQRm7YhNGU4IA5av9GPoT/mibi60rBnll2tTub3iPnAd2su17uPhWTHS2/7ksu6v+5MQSNC1m8Qc5YwHHM0gYMLabCbkauC7eSmzGwruXXHgD4HJOH2kfEXjNC6C4zB0K6/fy3UFgZgQ0IteNk/FEsRp0nzyEVJTSMF0ON7HcuoyOxSA0rJITLe9fwWm8shzJVI3NBaRJRwlSYb7U2TG49U+cpaB2lfn+1E89XvQ4mEQT5vm7aeapzJfXsCaBg7ugqn7L5X004M3PGbANPFlsULJDVWvOAdajhL952v/DDvPCXthPh9m7UMi6Ymvk4a7bG/tFscS7gaezWr+aJLLYMymoKqjKdD3mRvvjcFtWLVOTvQy09ZN8aMeG+kTptONVH7SgdIaS7qNAC8N5MWDsDAR0XCLj+7Min1dhPib1KqSp1MekG9V0k+aaE1x46jVjaanKIbac+2g4GpdJs6zgT25Ak8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(39860400002)(346002)(36840700001)(46966006)(70586007)(356005)(7636003)(316002)(82740400003)(83380400001)(478600001)(26005)(86362001)(5660300002)(36906005)(70206006)(6916009)(4326008)(7696005)(55016002)(54906003)(2906002)(1076003)(426003)(8676002)(33656002)(8936002)(36860700001)(47076005)(6666004)(336012)(186003)(16526019)(9686003)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2021 08:53:19.6671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af0743ec-7d2a-4421-bbcb-08d923485f93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT033.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2850
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2021 at 04:36:59AM -0400, Michael S. Tsirkin wrote:
> On Sun, May 30, 2021 at 11:27:48AM +0300, Eli Cohen wrote:
> > On Sun, May 30, 2021 at 04:21:07AM -0400, Michael S. Tsirkin wrote:
> > > On Sun, May 30, 2021 at 11:17:21AM +0300, Eli Cohen wrote:
> > > > On Sun, May 30, 2021 at 04:05:57AM -0400, Michael S. Tsirkin wrote:
> > > > > On Sun, May 30, 2021 at 09:32:14AM +0300, Eli Cohen wrote:
> > > > > > umem size is a 32 bit unsigned value so assigning it to an int could
> > > > > > cause false failures. Set the calculated value inside the function and
> > > > > > modify function name to reflect the fact it updates the size.
> > > > > > 
> > > > > > Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > 
> > > > > could you clarify the impact of the bug please?
> > > > > 
> > > > 
> > > > This was found by code revew. I did not see it causing trouble becuase
> > > > umem sizes are small enough to fit in int. Nevertheless it's a bug that
> > > > deserves a fix.
> > > 
> > > ok pls include this info in the commit log.
> > > 
> > 
> > Not sure what info do you want me to include. Seems to me that the
> > changelog already provides the required information.
> 
> 
> that this was found by code review and has no practical impact.

ok
> 
> > > > > 
> > > > > > ---
> > > > > >  drivers/vdpa/mlx5/net/mlx5_vnet.c | 15 +++++----------
> > > > > >  1 file changed, 5 insertions(+), 10 deletions(-)
> > > > > > 
> > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > index 53312f0460ad..fdf3e74bffbd 100644
> > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > @@ -610,8 +610,8 @@ static void cq_destroy(struct mlx5_vdpa_net *ndev, u16 idx)
> > > > > >  	mlx5_db_free(ndev->mvdev.mdev, &vcq->db);
> > > > > >  }
> > > > > >  
> > > > > > -static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> > > > > > -		     struct mlx5_vdpa_umem **umemp)
> > > > > > +static void set_umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq, int num,
> > > > > > +			  struct mlx5_vdpa_umem **umemp)
> > > > > >  {
> > > > > >  	struct mlx5_core_dev *mdev = ndev->mvdev.mdev;
> > > > > >  	int p_a;
> > > > > > @@ -634,7 +634,7 @@ static int umem_size(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *mvq
> > > > > >  		*umemp = &mvq->umem3;
> > > > > >  		break;
> > > > > >  	}
> > > > > > -	return p_a * mvq->num_ent + p_b;
> > > > > > +	(*umemp)->size = p_a * mvq->num_ent + p_b;
> > > > > >  }
> > > > > >  
> > > > > >  static void umem_frag_buf_free(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_umem *umem)
> > > > > > @@ -650,15 +650,10 @@ static int create_umem(struct mlx5_vdpa_net *ndev, struct mlx5_vdpa_virtqueue *m
> > > > > >  	void *in;
> > > > > >  	int err;
> > > > > >  	__be64 *pas;
> > > > > > -	int size;
> > > > > >  	struct mlx5_vdpa_umem *umem;
> > > > > >  
> > > > > > -	size = umem_size(ndev, mvq, num, &umem);
> > > > > > -	if (size < 0)
> > > > > > -		return size;
> > > > > > -
> > > > > > -	umem->size = size;
> > > > > > -	err = umem_frag_buf_alloc(ndev, umem, size);
> > > > > > +	set_umem_size(ndev, mvq, num, &umem);
> > > > > > +	err = umem_frag_buf_alloc(ndev, umem, umem->size);
> > > > > >  	if (err)
> > > > > >  		return err;
> > > > > >  
> > > > > > -- 
> > > > > > 2.31.1
> > > > > 
> > > 
> 
