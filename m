Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18CF3679A2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 08:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbhDVGEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 02:04:42 -0400
Received: from mail-dm6nam11on2071.outbound.protection.outlook.com ([40.107.223.71]:45953
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229651AbhDVGEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 02:04:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dp+PpX78kNXVXKQEHRlFkssxUdOsTQHLSxSPv88u0kMM11IxTQrvwo+jZBqupz82PWzCWzMWJrKejOYEGWqcKwcDJGyF49BDUxp0zxmbgDeYU8raUkU+3AjtDaMsYq2150p6hdRKZ4Hjvi8dxBydKXMlKvEhDvl9hEulnF+2mVAsXddqDYjhEvcBNKZ438sU+oBTRUuKPfTuwpHxpcd+Q1PWz6fV0q7KGMUheJN2GiuxBUJFuLTbDYcfL6mPr7uV2IEvVMaJn+Z/dbTrMCtPXkpG/qY0694i9w+djBNTwDR0Ai6PcJjB7++m5R9bw/wflb6DGzQOE0LX0FPlCpNmeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeaYzhNltcWy7phHjbs6KJYElXPNik+xl5X0RunwDrc=;
 b=hOrq+Zk27GfUWcW207Z6XPkJRI1/aQEVjK8+yw+bDAloTxfM8SzeVyXyP7xgPprTNiAsjRIGm5IIXcCrUWW6Ukm9RQCZgTMJl9hLm1GoRMallY3TenZ41QttpIRpGKc98fNQizRuaG/sxywSSm9hVdzcpM51OSFSmsoi8hkyQwwnS6gujg1PjsXabWyp5ClIlCE2cvIseHfVF/VzOs7CE8HVt7mTtF6bbUtJCZ9r5dmfWqp0ssIZ1zhL/kKeK2TvQxcVBub2KyJHuMEjBpIpblXUeKxI3R9nlALd1mRT+5N1WN7jP35zdlUZbsQYO7Ri8P9KHrRetALa96NmNION+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeaYzhNltcWy7phHjbs6KJYElXPNik+xl5X0RunwDrc=;
 b=WFpiMSdD8B8jxgBYN4J03X+e3+y34Xh2uu2rMkiRPfEg1SxaBnek0H0Grsq2eEL1idMKOplCU2c6EeQrTtbP5Qi85yDAbxb6hQQpbGM/BZHscL5XngkGfM0Y0kjGaNgciYG+5ysbfhSk4E/u8X7DNi9a81VoTJPuv/YbsOSZGzziUmANmBDj/QUOyjwXNMWobMWPPcwIchC5p8QzL8fG5qaV1qwcj0AFqMG2Rkgm2EI0quwhkxMDFLaCN6IALDCfCIXa+UlqnPb96cpJze7c/90eBW273TjxdLUmN6oYbQy+CHMaL2eJ9/bPOgmCDSJSVIW/1KTA2sHGmFgMxJt4OQ==
Received: from DM5PR12CA0019.namprd12.prod.outlook.com (2603:10b6:4:1::29) by
 MN2PR12MB2975.namprd12.prod.outlook.com (2603:10b6:208:ce::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.20; Thu, 22 Apr 2021 06:04:04 +0000
Received: from DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::f8) by DM5PR12CA0019.outlook.office365.com
 (2603:10b6:4:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Thu, 22 Apr 2021 06:04:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT053.mail.protection.outlook.com (10.13.173.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Thu, 22 Apr 2021 06:04:04 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 22 Apr 2021 06:04:02 +0000
Date:   Thu, 22 Apr 2021 09:03:58 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
Message-ID: <20210422060358.GA140698@mtl-vdi-166.wap.labs.mlnx>
References: <20210421104145.115907-1-elic@nvidia.com>
 <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a40a3a16-763f-474d-a942-08d905546ed1
X-MS-TrafficTypeDiagnostic: MN2PR12MB2975:
X-Microsoft-Antispam-PRVS: <MN2PR12MB29755BB47D4A8A0EAF4A627EAB469@MN2PR12MB2975.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xehwE75c5Frrn9Vkw5EWx8c3GcUlGvlhNUZllOPLyxV32I14Q0xbHxhhvZz5FXa9XvvVqyiloqJQhon4diE9bgWEgudZTaqq7JXsrX+qzX54Gdjbs1kPGaL17DpeZIz0hOhehFPfYM2zdba8Wj28U/hh+e+aWaVVjAWQsVhygjj/lOxKEcJGLlex3dNUbsGIQJpPwed/kAL+uIzpKp0jUea9bRpqrTExd7Q2hD/wZPp/eUwG+hN6CKQI/n8h4VEyzv2Dq3AaoCVSRL/aKJ1OIi90CVJIPVyBf+PvRri/NwmrjvjCM/ShX4qriwhZAUYBSqY0Pv6WlhDjA32D+uBTMOINFb8niCrhrZjkwPPuGSksCZehqP5+H+R8PNhK2Bvu3/cVzbvKyXPNG+q0NtFktUxq5xBDqa/zJK1b6ZyP/ylLRO8gV5hbcVdNpt86V0ywVRgsxTMVcT3w2Bl2FKNim2Gw+HwkWahYCFBTZQNb3bHOKzQ0cs1dZ9ud/kzJsX7bx1K1Blo6RXtJy76u/fkOEJ6+CEX73KJwaLV6ruK502nqKDYJbitG8eJCye0oRlwsyVzW7wwyPO6qNT8uHBYysXOFbNcRfdT7/xXHgQ3CupVMfpyci2KzS+u9H2R5BFcaRjG8dVmF5dmr7iCAOPKWHjmWsp96vpklrjqBGWrKw+g=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(36840700001)(46966006)(7636003)(82740400003)(356005)(83380400001)(426003)(86362001)(2906002)(36906005)(70206006)(70586007)(9686003)(55016002)(33656002)(8676002)(8936002)(186003)(4326008)(316002)(1076003)(54906003)(26005)(478600001)(5660300002)(16526019)(36860700001)(82310400003)(7696005)(6916009)(6666004)(47076005)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 06:04:04.3202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a40a3a16-763f-474d-a942-08d905546ed1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2975
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 22, 2021 at 10:37:38AM +0800, Jason Wang wrote:
> 
> 在 2021/4/21 下午6:41, Eli Cohen 写道:
> > Implement mlx5_get_vq_notification() to return the doorbell address.
> > Size is set to one system page as required.
> > 
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> >   drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
> >   drivers/vdpa/mlx5/core/resources.c | 1 +
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 6 ++++++
> >   3 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > index b6cc53ba980c..49de62cda598 100644
> > --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > @@ -41,6 +41,7 @@ struct mlx5_vdpa_resources {
> >   	u32 pdn;
> >   	struct mlx5_uars_page *uar;
> >   	void __iomem *kick_addr;
> > +	u64 phys_kick_addr;
> >   	u16 uid;
> >   	u32 null_mkey;
> >   	bool valid;
> > diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> > index 6521cbd0f5c2..665f8fc1710f 100644
> > --- a/drivers/vdpa/mlx5/core/resources.c
> > +++ b/drivers/vdpa/mlx5/core/resources.c
> > @@ -247,6 +247,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
> >   		goto err_key;
> >   	kick_addr = mdev->bar_addr + offset;
> > +	res->phys_kick_addr = kick_addr;
> >   	res->kick_addr = ioremap(kick_addr, PAGE_SIZE);
> >   	if (!res->kick_addr) {
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 10c5fef3c020..680751074d2a 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -1865,8 +1865,14 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
> >   static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
> >   {
> > +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >   	struct vdpa_notification_area ret = {};
> > +	struct mlx5_vdpa_net *ndev;
> > +
> > +	ndev = to_mlx5_vdpa_ndev(mvdev);
> > +	ret.addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
> > +	ret.size = PAGE_SIZE;
> 
> 
> Note that the page will be mapped in to guest, so it's only safe if the
> doorbeel exclusively own the page. This means if there're other registers in
> the page, we can not let the doorbell bypass to work.
> 
> So this is suspicious at least in the case of subfunction where we calculate
> the bar length in mlx5_sf_dev_table_create() as:
> 
> table->sf_bar_length = 1 << (MLX5_CAP_GEN(dev, log_min_sf_size) + 12);
> 
> It looks to me this can only work for the arch with PAGE_SIZE = 4096,
> otherwise we can map more into the userspace(guest).
> 

Correct, so I guess I should return here 4096.

I also think that the check in vhost_vdpa_mmap() should verify that the
returned size is not smaller than PAGE_SIZE because the returned address
might just be aligned to PAGE_SIZE. I think this should be enoght but
maybe also use the same logic in vhost_vdpa_fault().
