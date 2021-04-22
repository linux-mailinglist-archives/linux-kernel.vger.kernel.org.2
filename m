Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65B5E367BBB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhDVIIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:08:11 -0400
Received: from mail-dm6nam11on2055.outbound.protection.outlook.com ([40.107.223.55]:48480
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229655AbhDVIIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:08:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4DK0SsrVbYiXYT/HNs3k/fS8QUyWcZP002CK0Pdo6RkJqU3cHqL/RyvPEwOB1ggeqNFnDCNK72Bo4lxzr6ehF+gf3bfBtuI0OsuqgMaOTruP7X+9/jqT6Ho0JMYGR5WpQTAbxwf4BdlrxS+ZDzLq7mIqL33iey+bqJwqhG7X5e/N6PkufVE6vXhozvu8xUBlsUAnIE8WCvGgI9l+BifLr7Qxrc1Gtbj3n9rb6TBffmuYB25ZpuI5ZHwP6Q1wpbH6eDjkQfb9eemRYmKyGMWuvI7ORd1BApCDftDkxpJF/fDbk4FEOCSfoeylOmmu9scz1FhtqT44M8igSIhEdQ9+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx4k4GebG1y4Rz9Vm5MG3GRh5+X/pKl4kI4ymEPWCqs=;
 b=WNxPo9Ysmqhu7pNmiV3Ev4P5Ck9Bbfs/gUwjYh6ipByibmA50tWH00O5d94JmeOg8k+azuFvoS49G6/7oRpo1tIrRoGU/Ky+uXgnu0NqVwl4BTLIq77IqxLgMUybgZkOaomlY88SBdMH+/1+p64FXfXmYFTxsGfnYTbH1qXPUMXr91m2zuFq77aWvZuZpcjKh4+sqFm9xZ725nhel+AxdeqWMVNcEVrUYLGXKffrSAOBrU/pbImBaqiu62JYnuSALIxgHq3r9LUSESIYBfWrMA/68zJ3YPmgAsl8Ou+dg+03hsvytCJZZRdjcoRh/pEql4w6ZN7xVEx97fX+1woX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cx4k4GebG1y4Rz9Vm5MG3GRh5+X/pKl4kI4ymEPWCqs=;
 b=f7F2chtVuOoxnko24QxnJd8pNQKJE38rIo5hqIyUBR08K8FUDhgTdi6wsL/tceuJVYmutR7nlhLD60g2wrGr5aUqCiIepMYSwkRX+E+wOggMF562GMpsGbM6xWAvAO9MlrugBdbX64A8yPFrw2yp9gSh/QIeBdjYnb/ZZ/fMUyx4qnUpSVDwl1z+qtRuQwtpB1Qq03rcKMBAzmVu682P6MfL0fctGPrTo0YgWiYyPz+JpKoZGuQhzLAAsZd+KEr6UiX34i2+s/Jo4yP4r6aArCj5vio9tPV8rVQM0ZIhxL8obKOFwuWSCutYu0VWIHzGnPEnfgFU4t/s9eZswZxp1A==
Received: from MWHPR10CA0068.namprd10.prod.outlook.com (2603:10b6:300:2c::30)
 by BN8PR12MB3346.namprd12.prod.outlook.com (2603:10b6:408:45::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 08:07:32 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:2c:cafe::5b) by MWHPR10CA0068.outlook.office365.com
 (2603:10b6:300:2c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Thu, 22 Apr 2021 08:07:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 08:07:31 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Apr 2021 08:07:29 +0000
Date:   Thu, 22 Apr 2021 11:07:25 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
Message-ID: <20210422080725.GB140698@mtl-vdi-166.wap.labs.mlnx>
References: <20210421104145.115907-1-elic@nvidia.com>
 <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
 <20210422060358.GA140698@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210422060358.GA140698@mtl-vdi-166.wap.labs.mlnx>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 529526dd-afb4-477c-9923-08d90565adc8
X-MS-TrafficTypeDiagnostic: BN8PR12MB3346:
X-Microsoft-Antispam-PRVS: <BN8PR12MB334608EFE1B901208B2D8263AB469@BN8PR12MB3346.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U9NZxbwqK4E8DOv9qf80lMUVxXBoSUTBTwilH4z1DxuV2sLdVgdq4BP6JwUFONoubMbKDtoLB6xZC3Ftv/9gpHok2oAsGMRa1dQLcpKxZP6gR8bA7ymln+d7UEv568tXKBx00lEGqHTun4iGuWj0TcAvHmmY1mrOMd2AgIH92SALNr1dSTVvulDrtJ7WVOODicgavAzw3TNrctqj3f9oJ6n1/FS3/ZP+Bglb25g5egrWRcY1f39e4yZQVIkqb7GmWdv4mJBoPqpCuHmnOimv/XGpZHptXyxrNry5WxWXuG7rJLH0GaceFZehYPFNUfXJNii5gAeit1x6JEwcHiaVc+7Out/1lV/MP02953Za7Mbzs8uug59qA/9ouEb5s8gZgZ2HCBcBx6k61ZewNdRUhsdRe0RqFG8StbMzMs30Xo4WjTq/UdSFcJMV+O1VSH8iDn+cFiq2W00h0wYybd79lqhrFp+Nbg29orPbfv7xO8EfISuLCBFhFkLyAJxcSNX54kgAh8unWawRc2YwFK7EM7CDxgle+t1+SuFb83F2YByQ7JXep5kVnOEwoGONe/91YMVCBW5rt9rVmM3Lr9Xpjz10+L2s+uFkNkLjQzwI+O3/FS4qBADlb/IYIq6qW8aox/U42IaxIjaeajYCG/PlXWh7gqcPvKJJo/IP1UmdbBI=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(136003)(46966006)(36840700001)(55016002)(6916009)(54906003)(186003)(6666004)(8936002)(9686003)(36906005)(316002)(5660300002)(1076003)(4326008)(26005)(33656002)(336012)(356005)(2906002)(7696005)(8676002)(7636003)(36860700001)(82310400003)(70586007)(82740400003)(478600001)(70206006)(47076005)(83380400001)(16526019)(426003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 08:07:31.3947
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 529526dd-afb4-477c-9923-08d90565adc8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3346
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 09:03:58AM +0300, Eli Cohen wrote:
> On Thu, Apr 22, 2021 at 10:37:38AM +0800, Jason Wang wrote:
> > 
> > 在 2021/4/21 下午6:41, Eli Cohen 写道:
> > > Implement mlx5_get_vq_notification() to return the doorbell address.
> > > Size is set to one system page as required.
> > > 
> > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > ---
> > >   drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
> > >   drivers/vdpa/mlx5/core/resources.c | 1 +
> > >   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 6 ++++++
> > >   3 files changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > index b6cc53ba980c..49de62cda598 100644
> > > --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > @@ -41,6 +41,7 @@ struct mlx5_vdpa_resources {
> > >   	u32 pdn;
> > >   	struct mlx5_uars_page *uar;
> > >   	void __iomem *kick_addr;
> > > +	u64 phys_kick_addr;
> > >   	u16 uid;
> > >   	u32 null_mkey;
> > >   	bool valid;
> > > diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> > > index 6521cbd0f5c2..665f8fc1710f 100644
> > > --- a/drivers/vdpa/mlx5/core/resources.c
> > > +++ b/drivers/vdpa/mlx5/core/resources.c
> > > @@ -247,6 +247,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
> > >   		goto err_key;
> > >   	kick_addr = mdev->bar_addr + offset;
> > > +	res->phys_kick_addr = kick_addr;
> > >   	res->kick_addr = ioremap(kick_addr, PAGE_SIZE);
> > >   	if (!res->kick_addr) {
> > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > index 10c5fef3c020..680751074d2a 100644
> > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > @@ -1865,8 +1865,14 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
> > >   static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
> > >   {
> > > +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > >   	struct vdpa_notification_area ret = {};
> > > +	struct mlx5_vdpa_net *ndev;
> > > +
> > > +	ndev = to_mlx5_vdpa_ndev(mvdev);
> > > +	ret.addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
> > > +	ret.size = PAGE_SIZE;
> > 
> > 
> > Note that the page will be mapped in to guest, so it's only safe if the
> > doorbeel exclusively own the page. This means if there're other registers in
> > the page, we can not let the doorbell bypass to work.
> > 
> > So this is suspicious at least in the case of subfunction where we calculate
> > the bar length in mlx5_sf_dev_table_create() as:
> > 
> > table->sf_bar_length = 1 << (MLX5_CAP_GEN(dev, log_min_sf_size) + 12);
> > 
> > It looks to me this can only work for the arch with PAGE_SIZE = 4096,
> > otherwise we can map more into the userspace(guest).
> > 
> 
> Correct, so I guess I should return here 4096.
> 
> I also think that the check in vhost_vdpa_mmap() should verify that the
> returned size is not smaller than PAGE_SIZE because the returned address

Actually I think it's ok since you verify the size equals vma->vm_end -
vma->vm_start which must be at least PAGE_SIZE.

> might just be aligned to PAGE_SIZE. I think this should be enoght but
> maybe also use the same logic in vhost_vdpa_fault().
