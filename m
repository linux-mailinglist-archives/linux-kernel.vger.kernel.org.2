Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6CFC367CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 10:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhDVIjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 04:39:48 -0400
Received: from mail-dm6nam10on2069.outbound.protection.outlook.com ([40.107.93.69]:43615
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235249AbhDVIjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 04:39:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FC5bhQr8WMVP90EL2GDpyhNJF8yLV5u0UmbzLD8/NXJRE6sU3Rwjtfbs7axH0nUuAO5WTEWlDdAO4JgvWNUWLm6dXZRMpQTzauQMAoGt4eX4kRiIEIoIfRR+cMMbMyBsrekuwsDraCcDzXQbqyxiKifSkZJqvvf/kYYhG1v5XFlEBf5iQcsNvWWnWSbJCDWpQFc+GlsjUJ2zBwll8PTA+z/pcccngTOeilsExXVHrf8qxXQAVuLrhQhzSpunEA+W9xk3dzRAS8fnbab6QAguE6GXFOOrGL00hXHu2odKzLWEqDPBxS2DswJTYNED6jTtspweu/63q+qk9URG0xK7cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPyVeVh4hOBzS4aMpvbQra5zyqVcfJEzJM0931GaQb0=;
 b=ZyEQRXRT0JyMKg4An3uwhCNKloSJgXrYvDqnDfEyMpXZFR89Y4SToNbsaUuwbEzjym1Blj+Dtv0wpi+rUXGkSJuGZ7/KUQtnPgYMipvMf9wtaRNM8zpiiSq80XyNmT9d0qyEhi3YvSLXZ2Bl2T2N9gfg3q2njVzIwRVqQ65hlBHLyRSjl14vljiiXyydbaV2XFBttaWlaeN+5Ypk/2oD7xnTaf2pBN3RzfOsUnUARdEQRcYSiP5wCLtsaAPimQU8icfNpc5E/XioNjx22hWdUTJAjqjUHlaxQjqnmioetmXbT8qPqZum0bxm3vtObG1ep67cuDczdHnWU1XMkhUnSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPyVeVh4hOBzS4aMpvbQra5zyqVcfJEzJM0931GaQb0=;
 b=bdT/OKkTGS9R7isfGMs30LL6L+6WUQ62m/df3b1Tl1fwmDXd18a3wuMBxiXPYUcWJjMIF6WUBbnqhgUzI9FargFZj2ALprkdpz+E26//FGFeuXJ/KwRAMq2F8Nhou/PfT/Y8yRBfPXzsUhSUzSlFclqiZpvyn4MF7omfhEHM3qpMGWyRJTl2n0YnMyXRwqd9HZ3F2aROG18z720rp1XTHjyK6edeEAiO/LY/ucn484niyU3llWrtk5iicG8eZOUOD5jH3SYzZVWwKay3pTO2UC9ziheTXZnNUweaA/9dMJWquMzOToQYnOMOgHTlBE5yJKZP/L2AQozLoxENFuhBTw==
Received: from DM6PR17CA0002.namprd17.prod.outlook.com (2603:10b6:5:1b3::15)
 by CH2PR12MB3960.namprd12.prod.outlook.com (2603:10b6:610:24::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21; Thu, 22 Apr
 2021 08:39:08 +0000
Received: from DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::8a) by DM6PR17CA0002.outlook.office365.com
 (2603:10b6:5:1b3::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend
 Transport; Thu, 22 Apr 2021 08:39:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT044.mail.protection.outlook.com (10.13.173.185) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 08:39:07 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Apr 2021 08:39:05 +0000
Date:   Thu, 22 Apr 2021 11:39:02 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
Message-ID: <20210422083902.GA146406@mtl-vdi-166.wap.labs.mlnx>
References: <20210421104145.115907-1-elic@nvidia.com>
 <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
 <20210422060358.GA140698@mtl-vdi-166.wap.labs.mlnx>
 <20210422080725.GB140698@mtl-vdi-166.wap.labs.mlnx>
 <9d3d8976-800d-bb14-0a4a-c4b008f6872c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9d3d8976-800d-bb14-0a4a-c4b008f6872c@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6909307b-60a1-4f56-1c41-08d9056a17eb
X-MS-TrafficTypeDiagnostic: CH2PR12MB3960:
X-Microsoft-Antispam-PRVS: <CH2PR12MB39609E8EA2DB66B740DE6730AB469@CH2PR12MB3960.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ndZL6alcvOLhJK7QBFDQ/4Ezfmp/PWK5iJ6TDruEgY4hfdzfeJ4Dh9+lrTKZkQTU36cL8foDnH0Oc0Cs9zsMNaQPpDZfnNrcC/nOReM3pssdYbvwn9a1zACuvsNDFRvTQCx2apR/T0raCRUwAtxcE18PNmAxxqWNThKWPRbKfYTRmk8GMOPL0W//PpIk1s+4OV3CMFsJP8nc/Ffd29FkwP8eBcf7YjBW6CjqPDVPZCrqy5s9YJnEgg8kkjxBFYjVl4SZHCoiHL9MJM1unp9MPcEu7rpqGAcgePiCrKM7OZLPTVzihBedHPO9D/r3VjPGnZdhLJzlRao/6uY7lQMtZU2mB0JsIZ4wY8AKvhOCbYFSOhEs6/l6G/sAhTa7YmzaVRJhxjl2brIVqc8HZZV6dQLrl6GN6Hmv4iepCCsn/ZGEnID0g0gbVUgmN9QOHM1no0iHuowcgVtzZ9g2wde7F3wwxSPDbj6CH71o6vPuSXYMu5Sd1po+YDzYidseQLPkOgMhVrbHMxsOlk4LB+ZBz8tgGOPa7s191BFa3L4dXuV5MM1SGdZhkE5sKwprigGt5TFwtPxJrfHoo9sOXzkgo5QNpJGE9Gxe6qiIoX9e020iVriGGBuACpRT3lG44qFdlNzphdYkSr0uUG7G/xg/zN9FDrKfe5R9xrncivbFvU=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966006)(36840700001)(316002)(9686003)(478600001)(70586007)(2906002)(336012)(26005)(83380400001)(82740400003)(82310400003)(426003)(33656002)(7696005)(186003)(36906005)(8676002)(16526019)(55016002)(47076005)(86362001)(36860700001)(70206006)(1076003)(4326008)(6916009)(356005)(8936002)(54906003)(5660300002)(6666004)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 08:39:07.4552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6909307b-60a1-4f56-1c41-08d9056a17eb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3960
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 04:21:45PM +0800, Jason Wang wrote:
> 
> 在 2021/4/22 下午4:07, Eli Cohen 写道:
> > On Thu, Apr 22, 2021 at 09:03:58AM +0300, Eli Cohen wrote:
> > > On Thu, Apr 22, 2021 at 10:37:38AM +0800, Jason Wang wrote:
> > > > 在 2021/4/21 下午6:41, Eli Cohen 写道:
> > > > > Implement mlx5_get_vq_notification() to return the doorbell address.
> > > > > Size is set to one system page as required.
> > > > > 
> > > > > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > > > > ---
> > > > >    drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
> > > > >    drivers/vdpa/mlx5/core/resources.c | 1 +
> > > > >    drivers/vdpa/mlx5/net/mlx5_vnet.c  | 6 ++++++
> > > > >    3 files changed, 8 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > > index b6cc53ba980c..49de62cda598 100644
> > > > > --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > > +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > > > > @@ -41,6 +41,7 @@ struct mlx5_vdpa_resources {
> > > > >    	u32 pdn;
> > > > >    	struct mlx5_uars_page *uar;
> > > > >    	void __iomem *kick_addr;
> > > > > +	u64 phys_kick_addr;
> > > > >    	u16 uid;
> > > > >    	u32 null_mkey;
> > > > >    	bool valid;
> > > > > diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> > > > > index 6521cbd0f5c2..665f8fc1710f 100644
> > > > > --- a/drivers/vdpa/mlx5/core/resources.c
> > > > > +++ b/drivers/vdpa/mlx5/core/resources.c
> > > > > @@ -247,6 +247,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
> > > > >    		goto err_key;
> > > > >    	kick_addr = mdev->bar_addr + offset;
> > > > > +	res->phys_kick_addr = kick_addr;
> > > > >    	res->kick_addr = ioremap(kick_addr, PAGE_SIZE);
> > > > >    	if (!res->kick_addr) {
> > > > > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > index 10c5fef3c020..680751074d2a 100644
> > > > > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > > > > @@ -1865,8 +1865,14 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
> > > > >    static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
> > > > >    {
> > > > > +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> > > > >    	struct vdpa_notification_area ret = {};
> > > > > +	struct mlx5_vdpa_net *ndev;
> > > > > +
> > > > > +	ndev = to_mlx5_vdpa_ndev(mvdev);
> > > > > +	ret.addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
> > > > > +	ret.size = PAGE_SIZE;
> > > > 
> > > > Note that the page will be mapped in to guest, so it's only safe if the
> > > > doorbeel exclusively own the page. This means if there're other registers in
> > > > the page, we can not let the doorbell bypass to work.
> > > > 
> > > > So this is suspicious at least in the case of subfunction where we calculate
> > > > the bar length in mlx5_sf_dev_table_create() as:
> > > > 
> > > > table->sf_bar_length = 1 << (MLX5_CAP_GEN(dev, log_min_sf_size) + 12);
> > > > 
> > > > It looks to me this can only work for the arch with PAGE_SIZE = 4096,
> > > > otherwise we can map more into the userspace(guest).
> > > > 
> > > Correct, so I guess I should return here 4096.
> 
> 
> I'm not quite sure but since the calculation of the sf_bar_length is doen
> via a shift of 12, it might be correct.
> 
> And please double check if the doorbell own the page exclusively.

I am checking if it is safe to map the any part of the SF's BAR to
userspace without harming other functions. If this is true, I will check
if I can return PAGE_SIZE without compromising security. I think we may
need to extend struct vdpa_notification_area to contain another field
offset which indicates the offset from addr where the actual doorbell
resides.
> 
> 
> > > 
> > > I also think that the check in vhost_vdpa_mmap() should verify that the
> > > returned size is not smaller than PAGE_SIZE because the returned address
> > Actually I think it's ok since you verify the size equals vma->vm_end -
> > vma->vm_start which must be at least PAGE_SIZE.
> 
> 
> Yes.
> 
> Thanks
> 
> 
> > 
> > > might just be aligned to PAGE_SIZE. I think this should be enoght but
> > > maybe also use the same logic in vhost_vdpa_fault().
> 
