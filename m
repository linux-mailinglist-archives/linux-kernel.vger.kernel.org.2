Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 033463970F4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 12:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbhFAKKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 06:10:22 -0400
Received: from mail-dm6nam11on2042.outbound.protection.outlook.com ([40.107.223.42]:30561
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229538AbhFAKKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 06:10:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdAK+rzw68loW43z4eC5G6BRdI15RJ+C/s0BxNE+sgg6otDSkG5tRWwkE0mJq2GrpXGPZP/P0NOTaTxNn4kFS/5gz9DCCx6JZnJBFxA3bPpQEP7NWkNkKEYr6adNEQF/nl36gKe0EgZWNR2Z951HQicSw9cW4gnImnvxymO2L7iOgjCpAVe7uAR2Yn4qQk2D+PdGvHgGr3igM90fpz47b4amffssV6r4he5pOG0PB72on6LsGub8PhhUWtgWksUz6+3QEaev5NwPCxUmDCUYk818nPShoTR0bpvQg1B47yIYE/G9tKutwCRtEOe7E2673qQn7LJv61Eh7IDXN5CiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skKY91CvY+iIimtxCff2eX15YcgkQY4CMKyv8XggZR8=;
 b=ROTGtbEhG7rA+aMy6okt/U+qEIZnrUTr5NHWdJDjM6+/aWhhNacxtmDCRZmZf6EbvPdSlnxu3vOipi65r1vQXdYQJfb6fO4ioQwYVwSsdMpjNfbMv9cpTCswb7yjrmfj93xtS51vf+se1ANJMfEgEPdOcCeTxatqydQDgJB3CKF44d8PRr5NMHLP83+eHD04I8huSH9pQe1rtTa4fohMrIA3OXOpxjX/JxR0Ny87tD+u/m8AmlKP4B+02HbuP9yaOybmDVNQUvi0pB8A+QUqi23ibqihOj0SG6J8PXeBYW8pn2ki+WolNUJ1tNY5MI4+Guk/gIYXLeIMvcBMEnqefA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=skKY91CvY+iIimtxCff2eX15YcgkQY4CMKyv8XggZR8=;
 b=qEKR/YzUcl1UntRbbncsqkZpJGKb9hZyUFGbaE6LUfH3+IvPiojOH5/g4OnfTV2Y83RaLnb3Wx18aOakKtfuZSuiQe3SCfZUWMezjXV/1hLFaY1STFqHj10PxLplGvDCoGT1eJ0lUefoDAkgfQH+YnWWB9vUcBa4PkLRKbzGbjxE5AyffwPBX+25i0mGbwUXJ8aoZXGdk7EhYsZr1Hc8cPBBUns9nohaTgPnQf/YSlgIDe9Pc3Pwk9rliprsBpiXjFS2o3/FWCKSTB9UtcxnVBwBbz170b1QYz6isPhGPcwLdvofiVRfyBGo8YI3p2A++DdSA2MeK/JzL+sZ/UiXeg==
Received: from BN9PR03CA0969.namprd03.prod.outlook.com (2603:10b6:408:109::14)
 by BY5PR12MB4195.namprd12.prod.outlook.com (2603:10b6:a03:200::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Tue, 1 Jun
 2021 10:08:37 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::2b) by BN9PR03CA0969.outlook.office365.com
 (2603:10b6:408:109::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 10:08:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 10:08:36 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Jun 2021 10:08:29 +0000
Date:   Tue, 1 Jun 2021 13:08:26 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] vdpa/mlx5: Add support for running with virtio_vdpa
Message-ID: <20210601100826.GA215954@mtl-vdi-166.wap.labs.mlnx>
References: <20210531160428.31454-1-elic@nvidia.com>
 <117f8549-85c5-6603-c941-77c63b596bdd@redhat.com>
 <20210601034018.GA203469@mtl-vdi-166.wap.labs.mlnx>
 <cd1aee86-86df-b7df-e6da-5402f9525ce5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd1aee86-86df-b7df-e6da-5402f9525ce5@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71c71ad8-a93f-4cd4-c3f1-08d924e538c4
X-MS-TrafficTypeDiagnostic: BY5PR12MB4195:
X-Microsoft-Antispam-PRVS: <BY5PR12MB41952D4D3823D2D84A9BCCCDAB3E9@BY5PR12MB4195.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oLmTH4Sll8tqmZfNCYQ97ZfM/xhzV79MPSchckQh8sBZhSYQWu9RtpeUYimNFt5QTrFNfysRJPE4EkDqyHygDi4d2FVaUqJ23UOgGbIrTC8J4C+fmE6VQgkJ4zuJIZ94GRgbWQdxswZmdBCZ4r6EH93YbQqclLxaAcY7W74AF6i3bAAR8KvzLl6+kerdmugf0COIQ/UhQ1iQI/Dv+3cwap9xN8a2rOSC8u2neOP7wCfVHX/JcOAD7B6cM4ol3J+1lFXyfxVtj1WQyKT2nxcwALYw1DFqzRUx9g7KHTmT2KgEn0Fw5CCumHbuxng5mkLYAUph/joT11PrWEJhNJmr9TLENnIvLFy6IOn4G2NSlef7QC6VcalOkLgjzE7yZg7htL3ey/Z4/fkwfukkOHj90rq/P8ew/lk+zCuAjdGYAFaKuCWrzRJFQT8x4uja8CLxvLkrBLy8GIllz+FTVq9dsllNB9GCDYVpngjD+yfFM3l3BL/GjX0FcsuSBUg8qA1Xgu6bDrpJeUgNFLf+UXL9jqRUvYznAdftAfICBoH3gSwiUt7tCLiL1t66s2sM3QVdHmr4IsRdPz2v4B6wSEvN4b/ZxbzA+l5mFWgLiZ0s+uKeRg/IC2okPxcK5rweCAxQTuuRIQ7bVFpZC82f+glnQp/Q03uZd+N5Htrg7PaikYQ=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(46966006)(5660300002)(2906002)(26005)(70586007)(55016002)(36906005)(36860700001)(7636003)(8936002)(16526019)(33656002)(186003)(86362001)(336012)(4326008)(356005)(9686003)(82740400003)(54906003)(316002)(70206006)(1076003)(478600001)(7696005)(47076005)(6666004)(6916009)(83380400001)(8676002)(82310400003)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 10:08:36.6356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c71ad8-a93f-4cd4-c3f1-08d924e538c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4195
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 01:00:05PM +0800, Jason Wang wrote:
> 
> 在 2021/6/1 上午11:40, Eli Cohen 写道:
> > On Tue, Jun 01, 2021 at 10:09:45AM +0800, Jason Wang wrote:
> > > 在 2021/6/1 上午12:04, Eli Cohen 写道:
> > > > In order to support running vdpa using vritio_vdpa driver, we need  to
> > > > create a different kind of MR, one that has 1:1 mapping, since the
> > > > addresses referring to virtqueues are dma addresses.
> > > > 
> > > > We create the 1:1 MR in mlx5_vdpa_dev_add() only in case firmware
> > > > supports the general capability umem_uid_0. The reason for that is that
> > > > 1:1 MRs must be created with uid == 0 while virtqueue objects can be
> > > > created with uid == 0 only when the firmware capability is on.
> > > > 
> > > > If the set_map() callback is called with new translations provided
> > > > through iotlb, the driver will destroy the 1:1 MR and create a regular
> > > > one.
> > > > 
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > ---
> > > > v0 --> v1:
> > > >     1. Clear user_mr after successful creation of DMA MR
> > > >     2. Check return code of mlx5_vdpa_create_mr() and emit warning if
> > > >        failed.
> > > > 
> > > >    drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
> > > >    drivers/vdpa/mlx5/core/mr.c        | 84 +++++++++++++++++++++++++-----
> > > >    drivers/vdpa/mlx5/net/mlx5_vnet.c  | 15 +++++-
> > > >    3 files changed, 85 insertions(+), 15 deletions(-)
> > > > 
> > > > diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > index b6cc53ba980c..09a16a3d1b2a 100644
> > > > --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > @@ -35,6 +35,7 @@ struct mlx5_vdpa_mr {
> > > >    	/* serialize mkey creation and destruction */
> > > >    	struct mutex mkey_mtx;
> > > > +	bool user_mr;
> > > >    };
> > > >    struct mlx5_vdpa_resources {
> > > > diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> > > > index 800cfd1967ad..3c6c1d846f5e 100644
> > > > --- a/drivers/vdpa/mlx5/core/mr.c
> > > > +++ b/drivers/vdpa/mlx5/core/mr.c
> > > > @@ -360,7 +360,7 @@ static int add_direct_chain(struct mlx5_vdpa_dev *mvdev, u64 start, u64 size, u8
> > > >     * indirect memory key that provides access to the enitre address space given
> > > >     * by iotlb.
> > > >     */
> > > > -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> > > > +static int create_user_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> > > >    {
> > > >    	struct mlx5_vdpa_mr *mr = &mvdev->mr;
> > > >    	struct mlx5_vdpa_direct_mr *dmr;
> > > > @@ -374,9 +374,6 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
> > > >    	int err = 0;
> > > >    	int nnuls;
> > > > -	if (mr->initialized)
> > > > -		return 0;
> > > > -
> > > >    	INIT_LIST_HEAD(&mr->head);
> > > >    	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
> > > >    	     map = vhost_iotlb_itree_next(map, start, last)) {
> > > > @@ -414,7 +411,7 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
> > > >    	if (err)
> > > >    		goto err_chain;
> > > > -	mr->initialized = true;
> > > > +	mr->user_mr = true;
> > > >    	return 0;
> > > >    err_chain:
> > > > @@ -426,33 +423,92 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
> > > >    	return err;
> > > >    }
> > > > -int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> > > > +static int create_dma_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
> > > > +{
> > > > +	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
> > > > +	void *mkc;
> > > > +	u32 *in;
> > > > +	int err;
> > > > +
> > > > +	in = kzalloc(inlen, GFP_KERNEL);
> > > > +	if (!in)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
> > > > +
> > > > +	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_PA);
> > > > +	MLX5_SET(mkc, mkc, length64, 1);
> > > > +	MLX5_SET(mkc, mkc, lw, 1);
> > > > +	MLX5_SET(mkc, mkc, lr, 1);
> > > > +	MLX5_SET(mkc, mkc, pd, mvdev->res.pdn);
> > > > +	MLX5_SET(mkc, mkc, qpn, 0xffffff);
> > > > +
> > > > +	err = mlx5_vdpa_create_mkey(mvdev, &mr->mkey, in, inlen);
> > > > +	if (!err)
> > > > +		mr->user_mr = false;
> > > 
> > > Rethink about this. I wonder this is correct when we fail to create memory
> > > key.
> > > 
> > > In this case, user_mr is true but user_mr is already destroyed. Can this
> > > lead double free for user mr?
> > mr->user_mr is a binary flag and its sole purpose is to tell the flavour
> > of the MR but is valid only when mr->initialized is true. MR won't be
> > freed if mr->initialized is false.
> 
> 
> So we have:
> 
> static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct
> vhost_iotlb *iotlb)
> {
>         struct mlx5_vdpa_mr *mr = &mvdev->mr;
>         int err;
> 
>         if (mr->initialized)
>                 return 0;
> 
>         if (iotlb)
>                 err = create_user_mr(mvdev, iotlb);
>         else
>                 err = create_dma_mr(mvdev, mr);
> 
>         mr->initialized = true;
>         return err;
> }
> 
> It looks to me we need to check err before set mr->initialized.

Correct, will fix.

> 
> Thanks
> 
> 
> > 
> > > Thanks
> > > 
> > > 
> > > > +
> > > > +	kfree(in);
> > > > +	return err;
> > > > +}
> > > > +
> > > > +static void destroy_dma_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
> > > > +{
> > > > +	mlx5_vdpa_destroy_mkey(mvdev, &mr->mkey);
> > > > +}
> > > > +
> > > > +static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> > > >    {
> > > >    	struct mlx5_vdpa_mr *mr = &mvdev->mr;
> > > >    	int err;
> > > > -	mutex_lock(&mr->mkey_mtx);
> > > > +	if (mr->initialized)
> > > > +		return 0;
> > > > +
> > > > +	if (iotlb)
> > > > +		err = create_user_mr(mvdev, iotlb);
> > > > +	else
> > > > +		err = create_dma_mr(mvdev, mr);
> > > > +
> > > > +	mr->initialized = true;
> > > > +	return err;
> > > > +}
> > > > +
> > > > +int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> > > > +{
> > > > +	int err;
> > > > +
> > > > +	mutex_lock(&mvdev->mr.mkey_mtx);
> > > >    	err = _mlx5_vdpa_create_mr(mvdev, iotlb);
> > > > -	mutex_unlock(&mr->mkey_mtx);
> > > > +	mutex_unlock(&mvdev->mr.mkey_mtx);
> > > >    	return err;
> > > >    }
> > > > -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> > > > +static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
> > > >    {
> > > > -	struct mlx5_vdpa_mr *mr = &mvdev->mr;
> > > >    	struct mlx5_vdpa_direct_mr *dmr;
> > > >    	struct mlx5_vdpa_direct_mr *n;
> > > > -	mutex_lock(&mr->mkey_mtx);
> > > > -	if (!mr->initialized)
> > > > -		goto out;
> > > > -
> > > >    	destroy_indirect_key(mvdev, mr);
> > > >    	list_for_each_entry_safe_reverse(dmr, n, &mr->head, list) {
> > > >    		list_del_init(&dmr->list);
> > > >    		unmap_direct_mr(mvdev, dmr);
> > > >    		kfree(dmr);
> > > >    	}
> > > > +}
> > > > +
> > > > +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> > > > +{
> > > > +	struct mlx5_vdpa_mr *mr = &mvdev->mr;
> > > > +
> > > > +	mutex_lock(&mr->mkey_mtx);
> > > > +	if (!mr->initialized)
> > > > +		goto out;
> > > > +
> > > > +	if (mr->user_mr)
> > > > +		destroy_user_mr(mvdev, mr);
> > > > +	else
> > > > +		destroy_dma_mr(mvdev, mr);
> > > > +
> > > >    	memset(mr, 0, sizeof(*mr));
> > > >    	mr->initialized = false;
> > > >    out:
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > index fdf3e74bffbd..02a05492204c 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -1780,6 +1780,10 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
> > > >    		ndev->mvdev.status = 0;
> > > >    		ndev->mvdev.mlx_features = 0;
> > > >    		++mvdev->generation;
> > > > +		if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> > > > +			if (mlx5_vdpa_create_mr(mvdev, NULL))
> > > > +				mlx5_vdpa_warn(mvdev, "create MR failed\n");
> > > > +		}
> > > >    		return;
> > > >    	}
> > > > @@ -1859,6 +1863,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
> > > >    	ndev = to_mlx5_vdpa_ndev(mvdev);
> > > >    	free_resources(ndev);
> > > > +	mlx5_vdpa_destroy_mr(mvdev);
> > > >    	mlx5_vdpa_free_resources(&ndev->mvdev);
> > > >    	mutex_destroy(&ndev->reslock);
> > > >    }
> > > > @@ -2023,9 +2028,15 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
> > > >    	if (err)
> > > >    		goto err_mtu;
> > > > +	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> > > > +		err = mlx5_vdpa_create_mr(mvdev, NULL);
> > > > +		if (err)
> > > > +			goto err_res;
> > > > +	}
> > > > +
> > > >    	err = alloc_resources(ndev);
> > > >    	if (err)
> > > > -		goto err_res;
> > > > +		goto err_mr;
> > > >    	mvdev->vdev.mdev = &mgtdev->mgtdev;
> > > >    	err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs));
> > > > @@ -2037,6 +2048,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
> > > >    err_reg:
> > > >    	free_resources(ndev);
> > > > +err_mr:
> > > > +	mlx5_vdpa_destroy_mr(mvdev);
> > > >    err_res:
> > > >    	mlx5_vdpa_free_resources(&ndev->mvdev);
> > > >    err_mtu:
> 
