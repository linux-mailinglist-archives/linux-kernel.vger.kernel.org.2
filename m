Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B2C399C37
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 10:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhFCIEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 04:04:07 -0400
Received: from mail-bn7nam10on2049.outbound.protection.outlook.com ([40.107.92.49]:64960
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229486AbhFCIEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 04:04:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHEvmtlmaVdegYlKjJUcS4dXj7nKuXkb/yuTI54g3Nzq0eMRXzwbSy4L53TiZRAlmuC/GYauSdovWsMEal3fnHAeoDQb2w5zXiuqjNXu1GdIbc2CN0IEXI3oY0j158sawzRY6wDeeXJGXoDmBRlyDaCMdDsNL39aGDdUNYOrBNe+HdDHCdLN1SYTLpJ490ySnfgZ39bJlKdAepevrB3kppszMd4Fp5twwaSVcRz8jADk5CKRwFsgIlZD7a8cCr2On2o3pbl0suXM9wtaj/t7nflUp646BaaY2ZIWzOAPxIP3TbSf5ngEPITfSTWcxYgDWIIJm4GoHWKsVGUwYTqkLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UnYIUefNtTy8yD01eBILHIYidCnLpBEp/kcmEHdgP4=;
 b=beGgyvveFZJCLCYD2NLKurmUl+HS70kx7+3adV8AXetvu7YM+jzID0nUByKNFbx8I9If59JkmuQQVYxcAVHDWln4GElop9DmQsU1VHV2qD2LBqAvAzuejSkAL2M6EU+1PfEQVnT47eG3wf/xrfFpOLWHIBT4i8VdZp2KM/ps9CQRV+mbavV2L5cr5qaFpStE6MvYsx+kpwXAY0USp0LrF3HNzgsoa7uBvk9JDgWVrQkGRqyquWyw7bd7PCUR+tAajDorGVX0muZ9I5m5LUguz1oFOv45XN05XbXT3ak4ZD5MJHcHFT62Ho5E8Nj35prmd4WjilzxPUNAPiDj00fG8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8UnYIUefNtTy8yD01eBILHIYidCnLpBEp/kcmEHdgP4=;
 b=dvTQvW4jUHm1TG3Sva44QpjWDiT9d3CaBU7R8y8KufK2sIeilQC9QwsrI++PKybXsxxplP1XfNRWXtkqK/2rKdLNVtTEnM1lBRK2whCNoOwWbuvTOMcQAg0zA7h2HQqCvyzj32RliKQwby1KS7qujTJFb9tScua9R7QzxOaYQywk9CuztcDrBvV6Lweks+zI0SpTdt6nWMAYijWm26O1tyRUpRr6flRIx3IZn+V4YBZgbt8t9Y7fS5ip0qyYnivKeFiIiStsWvlMt26KEcgCHG4wigkc2kX2vDuHFIxWDL3ppn/sRwxevsn9lNIVy+DEiSf9aSGfUxRZGOIaAqgFUw==
Received: from MW4PR03CA0165.namprd03.prod.outlook.com (2603:10b6:303:8d::20)
 by BYAPR12MB3095.namprd12.prod.outlook.com (2603:10b6:a03:a9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Thu, 3 Jun
 2021 08:02:19 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::3c) by MW4PR03CA0165.outlook.office365.com
 (2603:10b6:303:8d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.23 via Frontend
 Transport; Thu, 3 Jun 2021 08:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 08:02:19 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.187.5) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Jun 2021 08:02:16 +0000
Date:   Thu, 3 Jun 2021 11:02:11 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] vdpa/mlx5: Add support for doorbell bypassing
Message-ID: <20210603080211.GA59509@mtl-vdi-166.wap.labs.mlnx>
References: <20210602095358.83318-1-elic@nvidia.com>
 <f99c6019-3b7a-8a91-27fc-7db70e9f1c1c@redhat.com>
 <20210603073840.GB58414@mtl-vdi-166.wap.labs.mlnx>
 <3ec31690-4cd8-1ea8-31dd-dfd3a8a25180@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ec31690-4cd8-1ea8-31dd-dfd3a8a25180@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fda7f13c-cdff-4a62-3832-08d92665e91c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3095:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3095E726420BD676D99E76AFAB3C9@BYAPR12MB3095.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqF+gnh2zFxHz3lkryjJNl2Uf8AswFJ9pXHyU5e+VuMlpH4IAZPsN1LQjPZirOIlk46r++OBERMobNznTO7YBfM4UJ2t1NmyI1EmV4Jejzi4xHJXV8SpNWgmtXgnJ3ri/JrPy9FbRikWkFpRQeik1xkTgNoT2Sr9QTRuz3uhcAF0/zNYl3eMDqvywGX9J3tnr+MDoy+8ZHd4FiCzv4l+KCysrn8nQFTV5tzWA/Qx3Txy9BzZQznI3MYxFGD3SJpn/qkcqThf1D6VG8FOGOF1cdBvsngJzif2JdZuJuAcYkd1fkmuSkZpdNQRn4KmRBQHvp0X4o2bi/ouBMAnrT13n1o8Le8x8w4GqEeswVqCVtHtRhTZmdNzH2z3cNXUVZWMPRJojT+HYt+cMAkbFrbAUTAwVHSF2CeIAfPEvJHeK+1nJxUFoQeRcj+ly0K+OB/55PjUR1Oej2RNOwldS+aDdebgfnVsgmiG3tW+/VLvaENvIRaQeDZgvygeTJhzviiy7BYa8YW5j2riCt+I5PNtdHVv+sCcbK1m11jVM1m7i12Yg0H+J8LZ+dGulQQwShedijZELmgTWi0w8+1kvYtVw3dJXZSMaAEt3UQ9rErQgQsHtexsbviNGZdnqGCaSDLcHS5yCL+BrRqnt3D5vOWP31uFNUFOFmPnS6BclQQtuwQ=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(36840700001)(46966006)(55016002)(7696005)(70206006)(70586007)(6916009)(36906005)(5660300002)(316002)(54906003)(47076005)(82740400003)(86362001)(356005)(83380400001)(16526019)(26005)(9686003)(6666004)(186003)(7636003)(33656002)(2906002)(1076003)(8676002)(82310400003)(4326008)(478600001)(426003)(36860700001)(8936002)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 08:02:19.3070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fda7f13c-cdff-4a62-3832-08d92665e91c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3095
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 03:49:04PM +0800, Jason Wang wrote:
> 
> 在 2021/6/3 下午3:38, Eli Cohen 写道:
> > On Thu, Jun 03, 2021 at 03:11:51PM +0800, Jason Wang wrote:
> > > 在 2021/6/2 下午5:53, Eli Cohen 写道:
> > > > Implement mlx5_get_vq_notification() to return the doorbell address.
> > > > Since the notification area is mapped to userspace, make sure that the
> > > > BAR size is at least PAGE_SIZE large.
> > > > 
> > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > ---
> > > > v0 --> v1:
> > > >     Make sure SF bar size is not smaller than PAGE_SIZE
> > > > 
> > > >    drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
> > > >    drivers/vdpa/mlx5/core/resources.c |  1 +
> > > >    drivers/vdpa/mlx5/net/mlx5_vnet.c  | 17 +++++++++++++++++
> > > >    3 files changed, 19 insertions(+)
> > > > 
> > > > diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > index 09a16a3d1b2a..0002b2136b48 100644
> > > > --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > @@ -42,6 +42,7 @@ struct mlx5_vdpa_resources {
> > > >    	u32 pdn;
> > > >    	struct mlx5_uars_page *uar;
> > > >    	void __iomem *kick_addr;
> > > > +	u64 phys_kick_addr;
> > > >    	u16 uid;
> > > >    	u32 null_mkey;
> > > >    	bool valid;
> > > > diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> > > > index 836ab9ef0fa6..d4606213f88a 100644
> > > > --- a/drivers/vdpa/mlx5/core/resources.c
> > > > +++ b/drivers/vdpa/mlx5/core/resources.c
> > > > @@ -253,6 +253,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
> > > >    		goto err_key;
> > > >    	kick_addr = mdev->bar_addr + offset;
> > > > +	res->phys_kick_addr = kick_addr;
> > > >    	res->kick_addr = ioremap(kick_addr, PAGE_SIZE);
> > > >    	if (!res->kick_addr) {
> > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > index 5500bcfe84b4..1936039e05bd 100644
> > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > @@ -1871,8 +1871,25 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
> > > >    static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
> > > >    {
> > > > +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > >    	struct vdpa_notification_area ret = {};
> > > > +	struct mlx5_vdpa_net *ndev;
> > > > +	phys_addr_t addr;
> > > > +
> > > > +	/* If SF BAR size is smaller than PAGE_SIZE, do not use direct
> > > > +	 * notification to avoid the risk of mapping pages that contain BAR of more
> > > > +	 * than one SF
> > > > +	 */
> > > > +	if (MLX5_CAP_GEN(mvdev->mdev, log_min_sf_size) + 12 < PAGE_SHIFT)
> > > > +		return ret;
> > > > +
> > > > +	ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > +	addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
> > > > +	if (addr & ~PAGE_MASK)
> > > > +		return ret;
> > > 
> > > This has been checked by vhost-vDPA, and it's better to leave those policy
> > > checking to them driver instead of checking it in the parent.
> > > 
> > Not in all invocations of get_vq_notification(). For example, in
> > vhost_vdpa_fault() you call remap_pfn_range() with notify.addr >>
> > PAGE_SHIFT so it it was not aligned you mask this misalignment.
> 
> 
> In order to have vhost_vdpa_fault() works, it should first pass the check of
> vhost_vdpa_mmap().
> 
> Othewise we won't install vma->vm_ops so there won't be a page fault for the
> doorbell.

Right, thanks for pointing this out.
Will send another version.

> 
> Thanks
> 
> 
> > 
> > > Thanks
> > > 
> > > 
> > > > +	ret.addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
> > > > +	ret.size = PAGE_SIZE;
> > > >    	return ret;
> > > >    }
> 
