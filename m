Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9044396BEE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 05:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhFADmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 May 2021 23:42:10 -0400
Received: from mail-mw2nam10on2056.outbound.protection.outlook.com ([40.107.94.56]:26720
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232516AbhFADmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 May 2021 23:42:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UzCD6MTIRrZZhk2vpFLzKaPMJtBSxz/ROIqJ2hjzHjVYACmMQy8Sm4hc3Hxe/K+YTMHOgYzZhWeBtaUW+N5fV0xJS3jTTmX5uKCSiWkjszKYjLFWjdLfblO760sTLxEFRE+BtKuntFSHXf9dYTpcYsSZIqguq2hBP1DwX07Azk/r5MuQCGntnvbHmqUf3IZbN94VYFSbPbm6VS5EZ8NescwZb/425OnoZT4jEaynzPj1x0alZsnnXMW1Kg6nBEDke8oFfpdP+nVFmInbfL5tNeoVHW1/0kgmNwVoYLyOKZhuniCyioKB4EUMK7lN/OfA3sx7XlkXRgNV34QkWcy7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3sUBZMgj7VA77lHO+7ulx9Csy6dU7Cru+Ra7xOx8g0=;
 b=i43RnEeJGZWOzUR6gbgNx2MiRuPXMJ6b76awDnNPmlPN+TC1OUxWCP26hJ16LZZmbWlmakudrXlRSLsnMTHQ3JuKqQyw6grGDrYxYmiueVDM0vW2lqsT2bVxi8dpaiRDyi+KsHpX9BKlBDiXqQVPEekZMGvwkvEO3YEhHeABpfNQQ81IdQRTfu8rykFuaZMDJ6EwTsUdnDIeXjLjvWeqjK5Hyk7YCxdkZt7xYnC1q1qNx7UjHqUOOT8iuHG10jJVxpt/s0HcDsSZC1Q5AAIp1RfMJB7IlLOS25xFHVRSMd97PktwoSbdh+fMpJpfKB9o01qRaNAMTAy9y/7UKgVWuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3sUBZMgj7VA77lHO+7ulx9Csy6dU7Cru+Ra7xOx8g0=;
 b=WhSmVx4i6T1wC8/p8bTxv9pg6+1U2ne0mFfQQ4dXiDP1mVNnARozRf2srxLjw5mR/G6BoF86Jb0KLraodqe8MAaBlNJbaqTho5rGN8vDY+nQd2I+JGOLk8athZHD0nH0o8ZTpH3NDju4vxjJxjIbzkGW6tyaE2zUYF3YfU3d6vL+Z8M1KpPar/QOiqrWfZ9LPnwpEg/J1xZ/n7+7G9bNnVHUZJ2LDJ82tgG5H1jWTABMnmGpqWoahJQOcx9EExk3iF2IJ1x/+t6AcLNVhdR+9AXvGmLft8krzXVoGEMTtX1D0zVUVydgUMMxVF6/5iJ01DjqI0luz7c6m9vied5hrQ==
Received: from BN8PR15CA0016.namprd15.prod.outlook.com (2603:10b6:408:c0::29)
 by CH2PR12MB4806.namprd12.prod.outlook.com (2603:10b6:610:f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Tue, 1 Jun
 2021 03:40:27 +0000
Received: from BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::45) by BN8PR15CA0016.outlook.office365.com
 (2603:10b6:408:c0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Tue, 1 Jun 2021 03:40:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT018.mail.protection.outlook.com (10.13.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4150.30 via Frontend Transport; Tue, 1 Jun 2021 03:40:26 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 1 Jun 2021 03:40:23 +0000
Date:   Tue, 1 Jun 2021 06:40:18 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] vdpa/mlx5: Add support for running with virtio_vdpa
Message-ID: <20210601034018.GA203469@mtl-vdi-166.wap.labs.mlnx>
References: <20210531160428.31454-1-elic@nvidia.com>
 <117f8549-85c5-6603-c941-77c63b596bdd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <117f8549-85c5-6603-c941-77c63b596bdd@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1db454e6-65b5-456d-b045-08d924aefe8e
X-MS-TrafficTypeDiagnostic: CH2PR12MB4806:
X-Microsoft-Antispam-PRVS: <CH2PR12MB48067ACBDB51FC8D14E3AFA6AB3E9@CH2PR12MB4806.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:376;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Oci6H8D3K1M3BwQ5Dq0rfDvNdPHoI8zs3UXFqHLBsnlkxZ/OqoNcxrzZDR9uQnsb9VMHDdztldOQbpYa05uZkVVJm1zvw4xYTSvIyoQaStE59pIpBVPI3XdZavoy4sODqAsdUMWWjGSQRIngjc0JqxxNaZgJQtTJu4tzd4YWRlzHAqgCQS3AyvtJJDD78E58qR7QEl0Q29Kvp9szUv63tx1P4iyHQF/90IPJgWxr8j/u0YDKkY4clqFQMfXeGngq6ZAY49zujHGD76aNEMIWwFmjhO19P+ir7eNj0+cfXqzv7JkxzqF4v9CecuOg0RqjlDIlU/DZCU5N//sB/v9r5fHqSaqhKkMnvQhmoj9XlfMAhCRSQ0xrF9vFU+eNt7wRlnk7Jw3JnxdXatcbEQ/6gBMnR0GgNRXXwe5WTJBfzDszC1N4oiHp7Xb+eVEZHKC3Xop/meBc/Mi2tF1Yif7Vo6dOyC9ENB0/Fv4M2/tddsF3d2gteINQuD6G6YC6jjBNgKdDNeZGAoVdeEz6lsMQjgU9/mUus/uHL43UhiEyZLsuuVyCs6hlO8qPVpJf09x35uTaURtitKdp7tvk7qkjoSFNYjlIVm7VDyqJoRlrD/yeX9n1wn977k0QHbPTjP7erdJEnUJXHjOWDMR2n6RKBK+trorQcErp9LcoAEyGoKw=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(376002)(136003)(346002)(46966006)(36840700001)(4326008)(478600001)(8676002)(8936002)(86362001)(2906002)(36906005)(426003)(9686003)(16526019)(82740400003)(6916009)(336012)(7696005)(7636003)(83380400001)(356005)(5660300002)(26005)(6666004)(33656002)(82310400003)(1076003)(316002)(36860700001)(55016002)(54906003)(70586007)(186003)(47076005)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2021 03:40:26.1570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1db454e6-65b5-456d-b045-08d924aefe8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4806
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2021 at 10:09:45AM +0800, Jason Wang wrote:
> 
> 在 2021/6/1 上午12:04, Eli Cohen 写道:
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
> > v0 --> v1:
> >    1. Clear user_mr after successful creation of DMA MR
> >    2. Check return code of mlx5_vdpa_create_mr() and emit warning if
> >       failed.
> > 
> >   drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
> >   drivers/vdpa/mlx5/core/mr.c        | 84 +++++++++++++++++++++++++-----
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 15 +++++-
> >   3 files changed, 85 insertions(+), 15 deletions(-)
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
> > index 800cfd1967ad..3c6c1d846f5e 100644
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
> > @@ -426,33 +423,92 @@ static int _mlx5_vdpa_create_mr(struct mlx5_vdpa_dev *mvdev, struct vhost_iotlb
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
> > +	if (!err)
> > +		mr->user_mr = false;
> 
> 
> Rethink about this. I wonder this is correct when we fail to create memory
> key.
> 
> In this case, user_mr is true but user_mr is already destroyed. Can this
> lead double free for user mr?

mr->user_mr is a binary flag and its sole purpose is to tell the flavour
of the MR but is valid only when mr->initialized is true. MR won't be
freed if mr->initialized is false.

> 
> Thanks
> 
> 
> > +
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
> > index fdf3e74bffbd..02a05492204c 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -1780,6 +1780,10 @@ static void mlx5_vdpa_set_status(struct vdpa_device *vdev, u8 status)
> >   		ndev->mvdev.status = 0;
> >   		ndev->mvdev.mlx_features = 0;
> >   		++mvdev->generation;
> > +		if (MLX5_CAP_GEN(mvdev->mdev, umem_uid_0)) {
> > +			if (mlx5_vdpa_create_mr(mvdev, NULL))
> > +				mlx5_vdpa_warn(mvdev, "create MR failed\n");
> > +		}
> >   		return;
> >   	}
> > @@ -1859,6 +1863,7 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
> >   	ndev = to_mlx5_vdpa_ndev(mvdev);
> >   	free_resources(ndev);
> > +	mlx5_vdpa_destroy_mr(mvdev);
> >   	mlx5_vdpa_free_resources(&ndev->mvdev);
> >   	mutex_destroy(&ndev->reslock);
> >   }
> > @@ -2023,9 +2028,15 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
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
> > @@ -2037,6 +2048,8 @@ static int mlx5_vdpa_dev_add(struct vdpa_mgmt_dev *v_mdev, const char *name)
> >   err_reg:
> >   	free_resources(ndev);
> > +err_mr:
> > +	mlx5_vdpa_destroy_mr(mvdev);
> >   err_res:
> >   	mlx5_vdpa_free_resources(&ndev->mvdev);
> >   err_mtu:
> 
