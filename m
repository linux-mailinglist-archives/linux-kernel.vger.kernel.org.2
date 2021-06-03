Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC05399BBA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 09:38:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbhFCHkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 03:40:32 -0400
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:8288
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229635AbhFCHkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 03:40:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCrbkGdSlU8jZNmSoStHyHkRyF7Pf0s/XjXbaz5shd7Q2P50LCLMhFORvM2EvD2XeF4pAetd+/1H1LqUuIlibI0nJIiGwmxA5IZIvk/5PD37Sc88ChQBCLLzZ0h3PlzlyQdsBdQi/3+MQBUgCvqqTU1qXww9CvS5CDBnQmh+UkEeMoJPWZTdbZxJGAZS22nW/OuM+D2lrjfeD5pyEw0RtJO8UTdriQxn/Ar/AmPlJZeVIRYqwFKtcWAE8MHhWdQyYFISF09GEuYSbouew+O/g2txmAfmKjeg2XHQBtBB5szgbwy9IErgESCgCDDMKSJ0c6IiG8BlhJ8STIVnQtTy2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGTQbdsHGSewGj1Nmjqt2oLg4I8fUYIw4dXySyWdOjw=;
 b=MKQuMYne/UKJNcD+G6FZP+Ct6/Mtcz06DzPaxEB8Z+9Zp1/40jLwPk5oveAXRdDdC4IyYgulNrbRoX5xbneFnwjlsvYbVVd1d5NxrWquVMam+OheVXPByErk5MD9uumxqpDycq4YZD0Fv+SSMk/MxUuDYbAdepupswba3Zi7cBI+pANb2tm05dCXhdK+JWcK70D08lQo2eUw2i0378xrASNmV/gkgvLTdHzJYDw3DgzgkCS9w6Bm9x3nDyAtYjb6ObdgkuN/se7vvI7hh3wr1h+CDOK9YnPHRreJmRTCKvLvrkuONDlk08PLvxRpsgeEFAffofLgNQFvX+1oo/KD1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UGTQbdsHGSewGj1Nmjqt2oLg4I8fUYIw4dXySyWdOjw=;
 b=P7UEMWja9Pw/I8j3xoobm/0FcJhpIglRvUJ0+Zhodsg8ceSzQcmvlmHrE/LJLKZvRG9urp759enj5Bd5wEdZR3gCoYX81PenrXy5O7GdDHNLdEeewe93eINd8MG5VvLu6Jsm/MSEOMOw88bRLSqq2rapE5hReAAbg6ooRQXdXb60Q4rQAnIu4jEGkC3K8gEfrknUgOdZTdH3g1EkMtruxPnq/c5prkUhJPGdPCZoik9wLWA+58UssJpbWiVtlfDyTxdfTupkLM0DjrQinKSy89oyzektuJYssQM2XdEUuBtsamjXApY0aq8b5TvRsFoBcTMG98d4bA2zBfF+s2mmbw==
Received: from MW4PR04CA0388.namprd04.prod.outlook.com (2603:10b6:303:81::33)
 by MWHPR12MB1421.namprd12.prod.outlook.com (2603:10b6:300:12::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 3 Jun
 2021 07:38:46 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:81:cafe::3e) by MW4PR04CA0388.outlook.office365.com
 (2603:10b6:303:81::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20 via Frontend
 Transport; Thu, 3 Jun 2021 07:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.linux-foundation.org; dkim=none (message not
 signed) header.d=none;lists.linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4195.22 via Frontend Transport; Thu, 3 Jun 2021 07:38:45 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.187.5) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 3 Jun 2021 07:38:43 +0000
Date:   Thu, 3 Jun 2021 10:38:40 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] vdpa/mlx5: Add support for doorbell bypassing
Message-ID: <20210603073840.GB58414@mtl-vdi-166.wap.labs.mlnx>
References: <20210602095358.83318-1-elic@nvidia.com>
 <f99c6019-3b7a-8a91-27fc-7db70e9f1c1c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f99c6019-3b7a-8a91-27fc-7db70e9f1c1c@redhat.com>
User-Agent: Mutt/1.9.5 (bf161cf53efb) (2018-04-13)
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12fea711-d736-411b-b16f-08d926629eb6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1421:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1421BDF0092A92081EF0845FAB3C9@MWHPR12MB1421.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fzbFcwm1eyvRLNwWX6Kr2pSw0bGSB9ZlDGkAfJ8SHZqAglA8cmmQylK+ZR1bFgvrEFivbCSqSCefVeZokoRjwHtMfKhcsWfIblwCSIAb2SZj+urJkI4QaPjimYnUXsXzH57Z3nfGOc6lM9GcLrVbWatUFaztuePZZsQgjhrCcVD/kggm22MWGbHeaCNpdvN57bOHj2a4Q9wCw5MVckzDNpkba+BQ7u1OGLqBoxGNDD1JlmCMD7dDFEOxaLX9KkHbcABA77nZVtEpomUBlD9LBqLRajjOgIkvvmw+fIjlXzapPNxy5ShOBe9NqoOmOIR2bxAF/earIYh2LFuEVP26xm3OS0JuVlZUG1IgXXdj/NioZku+MNUOsrP68I9e+l0I+E+7Lo6wvtp9r56sncWjo//wyIJbbNBfItv9LeCzz+Wv6N0Va20+B+4Jw60AOS9xGZg8SgRLBOgjTVDaRewRYwFU8DvL3AysG5b9SKyuwNv9B2exZ20JOjmBho57KxX5xZjCEHkgO7d9DREEye3COzfIzRKxKrrzuhrSVsSe0n9X9ty0Unf398JAq73qE7WTCCpF5C0VuKG83dSFZkB57nL4q3aLi2Cf6JZIE9l5VBgxqGgIdG8pN4t6OFo4WM917QwlP9cm0xkZ+N5mYg4Tb3HZwCIL/gp2JGZJoXZa3q8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(46966006)(36840700001)(55016002)(4326008)(6916009)(8936002)(8676002)(478600001)(26005)(7696005)(426003)(336012)(9686003)(70206006)(2906002)(1076003)(70586007)(7636003)(5660300002)(36860700001)(36906005)(316002)(33656002)(83380400001)(54906003)(16526019)(82310400003)(356005)(47076005)(82740400003)(186003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2021 07:38:45.9400
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12fea711-d736-411b-b16f-08d926629eb6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1421
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2021 at 03:11:51PM +0800, Jason Wang wrote:
> 
> 在 2021/6/2 下午5:53, Eli Cohen 写道:
> > Implement mlx5_get_vq_notification() to return the doorbell address.
> > Since the notification area is mapped to userspace, make sure that the
> > BAR size is at least PAGE_SIZE large.
> > 
> > Signed-off-by: Eli Cohen <elic@nvidia.com>
> > ---
> > v0 --> v1:
> >    Make sure SF bar size is not smaller than PAGE_SIZE
> > 
> >   drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
> >   drivers/vdpa/mlx5/core/resources.c |  1 +
> >   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 17 +++++++++++++++++
> >   3 files changed, 19 insertions(+)
> > 
> > diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > index 09a16a3d1b2a..0002b2136b48 100644
> > --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
> > @@ -42,6 +42,7 @@ struct mlx5_vdpa_resources {
> >   	u32 pdn;
> >   	struct mlx5_uars_page *uar;
> >   	void __iomem *kick_addr;
> > +	u64 phys_kick_addr;
> >   	u16 uid;
> >   	u32 null_mkey;
> >   	bool valid;
> > diff --git a/drivers/vdpa/mlx5/core/resources.c b/drivers/vdpa/mlx5/core/resources.c
> > index 836ab9ef0fa6..d4606213f88a 100644
> > --- a/drivers/vdpa/mlx5/core/resources.c
> > +++ b/drivers/vdpa/mlx5/core/resources.c
> > @@ -253,6 +253,7 @@ int mlx5_vdpa_alloc_resources(struct mlx5_vdpa_dev *mvdev)
> >   		goto err_key;
> >   	kick_addr = mdev->bar_addr + offset;
> > +	res->phys_kick_addr = kick_addr;
> >   	res->kick_addr = ioremap(kick_addr, PAGE_SIZE);
> >   	if (!res->kick_addr) {
> > diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > index 5500bcfe84b4..1936039e05bd 100644
> > --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> > @@ -1871,8 +1871,25 @@ static void mlx5_vdpa_free(struct vdpa_device *vdev)
> >   static struct vdpa_notification_area mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
> >   {
> > +	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >   	struct vdpa_notification_area ret = {};
> > +	struct mlx5_vdpa_net *ndev;
> > +	phys_addr_t addr;
> > +
> > +	/* If SF BAR size is smaller than PAGE_SIZE, do not use direct
> > +	 * notification to avoid the risk of mapping pages that contain BAR of more
> > +	 * than one SF
> > +	 */
> > +	if (MLX5_CAP_GEN(mvdev->mdev, log_min_sf_size) + 12 < PAGE_SHIFT)
> > +		return ret;
> > +
> > +	ndev = to_mlx5_vdpa_ndev(mvdev);
> > +	addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
> > +	if (addr & ~PAGE_MASK)
> > +		return ret;
> 
> 
> This has been checked by vhost-vDPA, and it's better to leave those policy
> checking to them driver instead of checking it in the parent.
> 

Not in all invocations of get_vq_notification(). For example, in
vhost_vdpa_fault() you call remap_pfn_range() with notify.addr >>
PAGE_SHIFT so it it was not aligned you mask this misalignment.

> Thanks
> 
> 
> > +	ret.addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
> > +	ret.size = PAGE_SIZE;
> >   	return ret;
> >   }
> 
