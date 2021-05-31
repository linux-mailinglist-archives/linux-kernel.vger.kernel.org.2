Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900413954F0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 May 2021 07:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhEaFPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 01:15:03 -0400
Received: from mail-dm6nam10on2076.outbound.protection.outlook.com ([40.107.93.76]:13024
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229717AbhEaFPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 01:15:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjkZCtk51puE5FEjqqMP7RKCcEz5jLzGuivI+imcFjfwGwr7pyJ9+S/GHjAsSWtwVQ+4kJMOWnohRk2NE8NCHHb+TGlVyCWfIsoNNJuK9S+2vHx5P54o/TmfFYGPJH5UANvOaLE7zLicefL7jmTvxnQm864nvgRbVyzF9UNnqNvsCCWQ0CGUYz7502N+oJH5t0cn/rZciK5G9yAw+k9r1eXxlRjFCJQvLO+IhyVHd9srSC/+EpI+WR+/0D4rtifuZf0H63cWzXPSHER7FoxHc0isFhorbSr8A+NV7jwMhZIJDh20obofpcP0S7uDLn5AqVJ20DNV5+p4OA7CQo4r9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVkHsxq9+SONnX+M+j8wfrRaCavwo34zJF3CTpXmh24=;
 b=k/WP1krgTl486Qhkn1G8+H6fR7js//RxhzGWn86oENDkGN/wqj+WGGIVtxlryEc9W9ondbF4202mjX5bg/ii4DXDOWOffg2BCJY+DgFGLpnSnchijIt905H1IoQ2SjM+UM6+MTJ6Wym5tByxP6pF2O54pfwUK7XvROnK1cEVW1EjLfT0mKmrsZvIy6EVgpogUiwVQj/QxUkEISN1t7KqyPwpG5+TgkYG7v8TB9etdrp0PHYyucKgC0FCcArntlzazeRH0ynt1UuC7sJPHsjH21Xm5WKO/0hIgl/ZpWCCXGWJ1O4usKNJlzCGLFyD6g40mrzmjz0ckHRmgH/f6KUjIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVkHsxq9+SONnX+M+j8wfrRaCavwo34zJF3CTpXmh24=;
 b=ee8WT8PPO3C99Jf7JaDor2WHNf2atypbapirVZ08LMW4rm9BqenhQZveCbFF4YlbjKGhVF8rfvChSX38lNU88jubYEGt21OLfzFhugQl0ziKXr10/X1gw7bVoxncx1f3n0w5BlwfmLMMEu/lqZWTuYzJTfOihgqm9Jl2dPsryBzh+LXA0IaCIJZsJ2OGMj3yE0V+laVJ6tWaSZtR7XgwfoBMtKDiDTp0ppnWHFPiXrSSi0r8P+pTAoeewYSHvlV8TATk77lWxGdf2nGQ6T3Yl6xNhyYSShHM20Q+XLcBrgHcanMtThLqZP6UD0I2N68KYYmDQXUPyVh+IGTBU70eWw==
Received: from BN8PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:d4::17)
 by CH0PR12MB5075.namprd12.prod.outlook.com (2603:10b6:610:e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 31 May
 2021 05:13:14 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::87) by BN8PR04CA0043.outlook.office365.com
 (2603:10b6:408:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Mon, 31 May 2021 05:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Mon, 31 May 2021 05:13:13 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 31 May 2021 05:13:11 +0000
Date:   Mon, 31 May 2021 08:13:08 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] vdpa/mlx5: Add support for running with virtio_vdpa
Message-ID: <20210531051308.GC158940@mtl-vdi-166.wap.labs.mlnx>
References: <20210530075415.4644-1-elic@nvidia.com>
 <20210530075415.4644-3-elic@nvidia.com>
 <9b130015-d116-7fb0-1b86-2604353a2283@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b130015-d116-7fb0-1b86-2604353a2283@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dedcfed6-460f-4d40-1bbf-08d923f2cad7
X-MS-TrafficTypeDiagnostic: CH0PR12MB5075:
X-Microsoft-Antispam-PRVS: <CH0PR12MB5075C50DBEE28CCBA845C058AB3F9@CH0PR12MB5075.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:569;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lrXhdmSm8iKUJzliulyRxoOCgoJwQ6eDd9SnPPWs1mJHdR/5V0DQO7Lq8rfEhZDv8I21lwNTcC7KWPY+6nMWtOcFVu7TiYE/9Iv/HItzX7mdzZEmNIlbrtajffIoJKXuUyoFFqntv/YWOYxZL8SS+MRWRhlkInzT3mZF33adJp6LAUwDbqq0Zf7LeBVoUtXo+yebaCcBNVo5h8nBelLXNdkNhG6wWGGHlHmiFe7rAdLUyC8tuKHr5MFm6Dor5Awbx0QlW2d24BPGRkC6lu0EM10tjohT6uoLeHJcJLmFeZGiabjQ5RhM+kQZZLbPNn+wep0sXBNiPUIOl5MMWPJ0WyRAzqQC7cr+HWUneia+P3txZKCJY4u/7Cq5PnN985mC75MA6iluusmn+Tzxx5D3VTQJg+H/RaFoFmk8iTo1N239INjlaihNfJI6uawYa/2Zwu3Nlpkb615zy3i2RW7emNL+vRoX+IhZViFoGmMDMYJ3CE+/jipGVFIGqHwfN8xbnL7+QgggelquC1ecYwkJ/A9Yvwx2DfgZYuVbfjcIc+VXkEmaFt509QGhfIvvszvZZuA4DBql/oxOXiBsM03pX/FqIgk1oI4GmFFMydvGgM1XPJuWiLFJEjOJebUJWLjz2xEGCxhdGPpgf9EXUplLLPrzfnlqcSF6RKBdsuzOxSk=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(36840700001)(46966006)(8936002)(70206006)(70586007)(47076005)(86362001)(9686003)(1076003)(7696005)(83380400001)(8676002)(5660300002)(26005)(6916009)(2906002)(36860700001)(356005)(16526019)(55016002)(82310400003)(82740400003)(426003)(336012)(4326008)(6666004)(316002)(33656002)(478600001)(36906005)(186003)(7636003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2021 05:13:13.9250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dedcfed6-460f-4d40-1bbf-08d923f2cad7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5075
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 31, 2021 at 11:16:11AM +0800, Jason Wang wrote:
> 
> 在 2021/5/30 下午3:54, Eli Cohen 写道:
> > In order to support running vdpa using vritio_vdpa driver, we need  to
> > create a different kind of MR, one that has 1:1 mapping, since the
> > addresses referring to virtqueues are dma addresses.
> > 
> > We create the 1:1 MR in mlx5_vdpa_dev_add() only in case firmware
> > supports the general capability umem_uid_0. The reason for that is that
> > 1:1 MRs must be created with uid == 0 while virtqueue objects can be
> > created with uid == 0 only when the firmware capability is on.
> > 
> > If the set_map() callback is called with new translations provided
> > through iotlb, the driver will destroy the 1:1 MR and create a regular
> > one.
> > 
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> >   drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
> >   drivers/vdpa/mlx5/core/mr.c        | 81 ++++++++++++++++++++++++------
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 13 ++++-
> >   3 files changed, 80 insertions(+), 15 deletions(-)
> > 
> > diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > index b6cc53ba980c..09a16a3d1b2a 100644
> > --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > @@ -35,6 +35,7 @@ struct mlx5_vdpa_mr {
> >   	/* serialize mkey creation and destruction */
> >   	struct mutex mkey_mtx;
> > +	bool user_mr;
> >   };
> >   struct mlx5_vdpa_resources {
> > diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> > index 800cfd1967ad..020c0ce4d203 100644
> > --- a/drivers/vdpa/mlx5/core/mr.c
> > +++ b/drivers/vdpa/mlx5/core/mr.c
> > @@ -360,7 +360,7 @@ static int add_direct_chain(struct mlx5_vdpa_dev *mvdev, u64 start, u64 size, u8
> >    * indirect memory key that provides access to the enitre address space given
> >    * by iotlb.
> >    */
> > -static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> > +static int create_user_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> >   {
> >   	struct mlx5_vdpa_mr *mr = &mvdev->mr;
> >   	struct mlx5_vdpa_direct_mr *dmr;
> > @@ -374,9 +374,6 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
> >   	int err = 0;
> >   	int nnuls;
> > -	if (mr->initialized)
> > -		return 0;
> > -
> >   	INIT_LIST_HEAD(&mr->head);
> >   	for (map = vhost_iotlb_itree_first(iotlb, start, last); map;
> >   	     map = vhost_iotlb_itree_next(map, start, last)) {
> > @@ -414,7 +411,7 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
> >   	if (err)
> >   		goto err_chain;
> > -	mr->initialized = true;
> > +	mr->user_mr = true;
> >   	return 0;
> >   err_chain:
> > @@ -426,33 +423,89 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
> >   	return err;
> >   }
> > -int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> > +static int create_dma_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
> > +{
> > +	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
> > +	void *mkc;
> > +	u32 *in;
> > +	int err;
> > +
> > +	in = kzalloc(inlen, GFP_KERNEL);
> > +	if (!in)
> > +		return -ENOMEM;
> > +
> > +	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
> > +
> > +	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_PA);
> > +	MLX5_SET(mkc, mkc, length64, 1);
> > +	MLX5_SET(mkc, mkc, lw, 1);
> > +	MLX5_SET(mkc, mkc, lr, 1);
> > +	MLX5_SET(mkc, mkc, pd, mvdev->res.pdn);
> > +	MLX5_SET(mkc, mkc, qpn, 0xffffff);
> > +
> > +	err = mlx5_vdpa_create_mkey(mvdev, &mr->mkey, in, inlen);
> > +	kfree(in);
> > +	return err;
> > +}
> > +
> > +static void destroy_dma_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
> > +{
> > +	mlx5_vdpa_destroy_mkey(mvdev, &mr->mkey);
> > +}
> > +
> > +static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> >   {
> >   	struct mlx5_vdpa_mr *mr = &mvdev->mr;
> >   	int err;
> > -	mutex_lock(&mr->mkey_mtx);
> > +	if (mr->initialized)
> > +		return 0;
> > +
> > +	if (iotlb)
> > +		err = create_user_mr(mvdev, iotlb);
> > +	else
> > +		err = create_dma_mr(mvdev, mr);
> 
> 
> Do we need to set user_mr to false here?

I think the right place to do this should be inside create_dma_mr(), the
same as we set it true in ().
> 
> 
> > +
> > +	mr->initialized = true;
> > +	return err;
> > +}
> > +
> > +int mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb *iotlb)
> > +{
> > +	int err;
> > +
> > +	mutex_lock(&mvdev->mr.mkey_mtx);
> >   	err = _mlx5_vdpa_create_mr(mvdev, iotlb);
> > -	mutex_unlock(&mr->mkey_mtx);
> > +	mutex_unlock(&mvdev->mr.mkey_mtx);
> >   	return err;
> >   }
> > -void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> > +static void destroy_user_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_mr *mr)
> >   {
> > -	struct mlx5_vdpa_mr *mr = &mvdev->mr;
> >   	struct mlx5_vdpa_direct_mr *dmr;
> >   	struct mlx5_vdpa_direct_mr *n;
> > -	mutex_lock(&mr->mkey_mtx);
> > -	if (!mr->initialized)
> > -		goto out;
> > -
> >   	destroy_indirect_key(mvdev, mr);
> >   	list_for_each_entry_safe_reverse(dmr, n, &mr->head, list) {
> >   		list_del_init(&dmr->list);
> >   		unmap_direct_mr(mvdev, dmr);
> >   		kfree(dmr);
> >   	}
> > +}
> > +
> > +void mlx5_vdpa_destroy_mr(struct mlx5_vdpa_dev *mvdev)
> > +{
> > +	struct mlx5_vdpa_mr *mr = &mvdev->mr;
> > +
> > +	mutex_lock(&mr->mkey_mtx);
> > +	if (!mr->initialized)
> > +		goto out;
> > +
> > +	if (mr->user_mr)
> > +		destroy_user_mr(mvdev, mr);
> > +	else
> > +		destroy_dma_mr(mvdev, mr);
> > +
> >   	memset(mr, 0, sizeof(*mr));
> >   	mr->initialized = false;
> >   out:
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index fdf3e74bffbd..f16756661c19 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -1780,6 +1780,8 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
> >   		ndev->mvdev.status = 0;
> >   		ndev->mvdev.mlx_features = 0;
> >   		++mvdev->generation;
> > +		if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0))
> > +			mlx5_vdpa_create_mr(mvdev, NULL);
> 
> 
> I wonder if it's possible/worth to avoid the destroy and re-create of dma MR
> here. (In the case of it has been used by us).

If it is a user MR, you must destroy it since it is useless. If it's
DMA MR, you might be able to do it but since the DMA MR's are
lightweight, I don't think it's worth it.

> 
> Thanks
> 
> 
> >   		return;
> >   	}
> > @@ -1859,6 +1861,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
> >   	ndev = to_mlx5_vdpa_ndev(mvdev);
> >   	free_resources(ndev);
> > +	mlx5_vdpa_destroy_mr(mvdev);
> >   	mlx5_vdpa_free_resources(&ndev->mvdev);
> >   	mutex_destroy(&ndev->reslock);
> >   }
> > @@ -2023,9 +2026,15 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
> >   	if (err)
> >   		goto err_mtu;
> > +	if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> > +		err = mlx5_vdpa_create_mr(mvdev, NULL);
> > +		if (err)
> > +			goto err_res;
> > +	}
> > +
> >   	err = alloc_resources(ndev);
> >   	if (err)
> > -		goto err_res;
> > +		goto err_mr;
> >   	mvdev->vdev.mdev = &mgtdev->mgtdev;
> >   	err = _vdpa_register_device(&mvdev->vdev, 2 * mlx5_vdpa_max_qps(max_vqs));
> > @@ -2037,6 +2046,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
> >   err_reg:
> >   	free_resources(ndev);
> > +err_mr:
> > +	mlx5_vdpa_destroy_mr(mvdev);
> >   err_res:
> >   	mlx5_vdpa_free_resources(&ndev->mvdev);
> >   err_mtu:
> 
