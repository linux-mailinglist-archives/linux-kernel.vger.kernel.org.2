Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F27836E84A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 12:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238133AbhD2KB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 06:01:28 -0400
Received: from mail-dm6nam11on2068.outbound.protection.outlook.com ([40.107.223.68]:56000
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238002AbhD2KB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 06:01:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/25Ku6/90fFyQVsf8Cg1+O6+OosGPUHbaoDvPYR+7ppzlTruQ4fBLKwcpziVFz9qoHmZuvFFh1cpKoQU19Jt40NTHAGmqMh7h27ENrJVlsvECLTzu0Yqz4IwsIAoT3LU7QX3xrePabMou2NaUuN/c7eju6wj9VSmI4xz9Vxjw7OHzJZUDDH59Gu4KxrXtPqqKlrawX0ryxcKwTME9afztPnJudp+IF6gkDZ00mws0ng00sAakJvdIrOxroRtzQUMO2awlVp+jlk2LIkd0aETGlFoRpPQm2nD/n8yE159cj4LSYP95jdw5l3RepB9+gLr8vvSugzXa6Q7hODIZzSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx+4cRTViXtVwq59zdR2mx0nyeUM5h3PBmLG66I/UDM=;
 b=JbF+Uaf6c1TYdPK+RYINSanHUyNGTxi56qAYFRhinwx0IJWMr+/8sr/FrEG9GAp/y050ttg8jJzwcdvNhvqbqoa6LR2HwVsTTNO8m6/lTlgNuNwFqgvpo6xlm9Zp75SVR7owdVZEHfGx1lWhVF8Vef/heyu+k4JzAbOv+dLwdx6ODUgp4fYOv3J5ROy9+XBBEsU7Z986c14umAvBxgnvI0axoSEf3ckScY4ktmEtqvilMvv5AIUqTwKPmGR5uE+eMnHZsXPPjpPgb/bHfnoiAWyR3g68hr+0MSnExOo8ia2uAkvSKxThVzcEo0rX1LgDi9GhbZGuJbCmoVCG0sy1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dx+4cRTViXtVwq59zdR2mx0nyeUM5h3PBmLG66I/UDM=;
 b=f8HR0PUhd6YYq8P+28LnPdwDrhBU+EGTG+Xi/3Fs0jN/7KVA3wu+gL1gXTnN2RmLroJSooKsYOVY3sAq17SkiW2EDElo2NJiaDCHfWBQRoaz0e5Bdo9O/JAxFU+UhyOEEyeBqBn73osDxkrz3JETQn9GEQlDjwBrGC3nuVb3YPdsgQizlv1SdTx0RAU9js5eGq2WXUCObETZpfEJKEiLRGZpVd3yja+cgp4IogOG/yWva1QbZA6Yz4kqStKpNugqdf+3w/2GaFBomhlr78B44VyxouGhQRihYOzzeHLEuZoTBP7/zw6lIe5gxw4j9PtuMoPVgPa+9cdcWVvvF7QXbQ==
Received: from MWHPR12CA0056.namprd12.prod.outlook.com (2603:10b6:300:103::18)
 by CH0PR12MB5091.namprd12.prod.outlook.com (2603:10b6:610:be::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Thu, 29 Apr
 2021 10:00:40 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:103:cafe::25) by MWHPR12CA0056.outlook.office365.com
 (2603:10b6:300:103::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 10:00:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 10:00:39 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 29 Apr 2021 10:00:37 +0000
Date:   Thu, 29 Apr 2021 13:00:33 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
Message-ID: <20210429100033.GA215200@mtl-vdi-166.wap.labs.mlnx>
References: <20210421104145.115907-1-elic@nvidia.com>
 <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
 <20210422060358.GA140698@mtl-vdi-166.wap.labs.mlnx>
 <20210422080725.GB140698@mtl-vdi-166.wap.labs.mlnx>
 <9d3d8976-800d-bb14-0a4a-c4b008f6872c@redhat.com>
 <20210422083902.GA146406@mtl-vdi-166.wap.labs.mlnx>
 <bdf10e38-8746-51cf-b460-a904a133329c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bdf10e38-8746-51cf-b460-a904a133329c@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eedf7d96-aa7e-4124-33fd-08d90af5a4c9
X-MS-TrafficTypeDiagnostic: CH0PR12MB5091:
X-Microsoft-Antispam-PRVS: <CH0PR12MB50915EDDCA080606E2C69146AB5F9@CH0PR12MB5091.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wi8fU++17Kcnk6wGS6rvazbKddA7aBsABFRGcG8X2QZDVVFceCcgvOYdvvhuuoaT0unhe4fqkHL/PKCmWB78ydemydMul0tMqjVyQIMluPHiB1QsbKuToVi/C25jnNYa/SehGyj401aIh3Lw/Z9FyPeyhObgB8KO12aLdnf8cDNWBNCbY48Ex1fziM296S+BfrfAIX4C6iAGHku2Aqi0QuEYgWsI3fbl7AbV3TtW7UfnnPapFIThL38Id8U/7pvl6xHKVIoR9aDLwV+6enrabKAAfV35RgNKRMCOUmjmqE1GaHIvy+2FV97YldRCZldwY+RHtWCYJUF136ShYjB8Zy6S7j0MdBOtFIEoOoWXx/pj0Qo0pW/BNtnTC0xFgqxKL6AQWM9nxGyUkhwNChhp2EW01h2wLNRfkqYRwrkp1YG1aR7gK4GSu/ejCoG7XWof8c7QIkZlXJLrVvhubze2KJ0/fDuV5eCzcLtBONaZxU9EsNu5n3TDPlS0/XV3QyyMFX8ZUsYpO8i//2+W+HMh4Rr79x/b2Dgxp9AgVD/2pAGaIbXEGs/X2is1jkEZ7GrlxPVyQeV2zAUtuqK6WwO+RNJfSJNVk0aQXoNqsH/HRmB1up2QLMiew/xC2KCrmPzT7iWVGdO+2sEfFeNO3p4Rx//TfPjSd9/8OBGO5R7lExs=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39850400004)(36840700001)(46966006)(356005)(82740400003)(478600001)(8676002)(6916009)(316002)(336012)(2906002)(6666004)(83380400001)(54906003)(36906005)(9686003)(55016002)(36860700001)(82310400003)(26005)(7636003)(5660300002)(7696005)(186003)(70586007)(426003)(1076003)(16526019)(4326008)(70206006)(33656002)(86362001)(47076005)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 10:00:39.6491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eedf7d96-aa7e-4124-33fd-08d90af5a4c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 04:59:11PM +0800, Jason Wang wrote:
> 
> 在 2021/4/22 下午4:39, Eli Cohen 写道:
> > On Thu, Apr 22, 2021 at 04:21:45PM +0800, Jason Wang wrote:
> > > 在 2021/4/22 下午4:07, Eli Cohen 写道:
> > > > On Thu, Apr 22, 2021 at 09:03:58AM +0300, Eli Cohen wrote:
> > > > > On Thu, Apr 22, 2021 at 10:37:38AM +0800, Jason Wang wrote:
> > > > > > 在 2021/4/21 下午6:41, Eli Cohen 写道:
> > > > > > > Implement mlx5_get_vq_notification() to return the doorbell address.
> > > > > > > Size is set to one system page as required.
> > > > > > > 
> > > > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > > > ---
> > > > > > >     drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
> > > > > > >     drivers/vdpa/mlx5/core/resources.c | 1 +
> > > > > > >     drivers/vdpa/mlx5/net/mlx5_vnet.c  | 6 ++++++
> > > > > > >     3 files changed, 8 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > > > > index b6cc53ba980c..49de62cda598 100644
> > > > > > > --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > > > > +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > > > > @@ -41,6 +41,7 @@ struct mlx5_vdpa_resources {
> > > > > > >     	u32 pdn;
> > > > > > >     	struct mlx5_uars_page *uar;
> > > > > > >     	void __iomem *kick_addr;
> > > > > > > +	u64 phys_kick_addr;
> > > > > > >     	u16 uid;
> > > > > > >     	u32 null_mkey;
> > > > > > >     	bool valid;
> > > > > > > diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> > > > > > > index 6521cbd0f5c2..665f8fc1710f 100644
> > > > > > > --- a/drivers/vdpa/mlx5/core/resources.c
> > > > > > > +++ b/drivers/vdpa/mlx5/core/resources.c
> > > > > > > @@ -247,6 +247,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
> > > > > > >     		goto err_key;
> > > > > > >     	kick_addr = mdev->bar_addr + offset;
> > > > > > > +	res->phys_kick_addr = kick_addr;
> > > > > > >     	res->kick_addr = ioremap(kick_addr, PAGE_SIZE);
> > > > > > >     	if (!res->kick_addr) {
> > > > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > index 10c5fef3c020..680751074d2a 100644
> > > > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > > > @@ -1865,8 +1865,14 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
> > > > > > >     static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
> > > > > > >     {
> > > > > > > +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > > > > >     	struct vdpa_notification_area ret = {};
> > > > > > > +	struct mlx5_vdpa_net *ndev;
> > > > > > > +
> > > > > > > +	ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > > > +	ret.addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
> > > > > > > +	ret.size = PAGE_SIZE;
> > > > > > Note that the page will be mapped in to guest, so it's only safe if the
> > > > > > doorbeel exclusively own the page. This means if there're other registers in
> > > > > > the page, we can not let the doorbell bypass to work.
> > > > > > 
> > > > > > So this is suspicious at least in the case of subfunction where we calculate
> > > > > > the bar length in mlx5_sf_dev_table_create() as:
> > > > > > 
> > > > > > table->sf_bar_length = 1 << (MLX5_CAP_GEN(dev, log_min_sf_size) + 12);
> > > > > > 
> > > > > > It looks to me this can only work for the arch with PAGE_SIZE = 4096,
> > > > > > otherwise we can map more into the userspace(guest).
> > > > > > 
> > > > > Correct, so I guess I should return here 4096.
> > > 
> > > I'm not quite sure but since the calculation of the sf_bar_length is doen
> > > via a shift of 12, it might be correct.
> > > 
> > > And please double check if the doorbell own the page exclusively.
> > I am checking if it is safe to map the any part of the SF's BAR to
> > userspace without harming other functions. If this is true, I will check
> > if I can return PAGE_SIZE without compromising security.
> 
> 
> It's usally not safe and a layer violation if other registers are placed at
> the same page.
> 
> 
> >   I think we may
> > need to extend struct vdpa_notification_area to contain another field
> > offset which indicates the offset from addr where the actual doorbell
> > resides.
> 
> 
> The movitiaton of the current design is to be fit seamless into how Qemu
> model doorbell layouts currently:
> 
> 1) page-per-vq, each vq has its own page aligned doorbell
> 2) 2 bytes doorbell, each vq has its own 2 byte aligend doorbell
> 
> Only 1) is support in vhost-vDPA (and vhost-user) since it's rather simple
> and secure (page aligned) to be modelled and implemented via mmap().
> 
> Exporting a complex layout is possbile but requires careful design.
> 
> Actually, we had antoher option
> 
> 3) shared doorbell: all virtqueue shares a single page aligned doorbell

I am not sure how this could solve the problem of 64KB archs.
The point is that in ConnectX devices, the virtio queue objects doorbell
is aligned to 4K. For larger system page sizes, the doorbell may not be
aligned to a system page.
So it seems not too complex to introduce offset within the page.

BTW, for now, I am going to send another patch that makes sure page
boundaries are not vilated. It requires some support from mlx5_core
which is currently being reviewed internally.

> 
> This is not yet supported by Qemu.
> 
> Thanks
> 
> 
> > > 
> > > > > I also think that the check in vhost_vdpa_mmap() should verify that the
> > > > > returned size is not smaller than PAGE_SIZE because the returned address
> > > > Actually I think it's ok since you verify the size equals vma->vm_end -
> > > > vma->vm_start which must be at least PAGE_SIZE.
> > > 
> > > Yes.
> > > 
> > > Thanks
> > > 
> > > 
> > > > > might just be aligned to PAGE_SIZE. I think this should be enoght but
> > > > > maybe also use the same logic in vhost_vdpa_fault().
> 
