Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F15236A77D
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 15:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbhDYN0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 09:26:11 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:54112
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229688AbhDYN0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 09:26:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FR8c7/ei7RoQ6lErIIXh0Lo+xtnsIUwrkbyQPm+umk+Z03gS9u3OUG1/YxQ1Ydob3nvo9vueZ84Pz5SCj+12otpB/AmBFmDjskt6ZFuZK8DgN5Bi5ytLa3QpCLlEVlE+pKi4826RiBJ2Bk6N0u5ykof93iTJ0invd9DIWq7XzZwshoNyLSO33FYxIuYYc/jzxeXuYHFmmmhuyNG4x1ACNvwLDwTJYcQwXJ06L0uxokw96S7TYY17DHnF9im50pBDzDvMwwtQQCPve++ak5ym+XnJQ4LsMMqt5a3HSe/Wm4P6TPpNuo1Vtjsu8kMjYyJfOoa9kR2bxpZxxvXicQsN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fru3fRmdZZ49M+6RxL1lkx9WfUKWakhQxk6txESo48I=;
 b=cnHn1iBW/vn12NgWr8FxjEQu/83S7dazZvmc+tMVp4dyWYtcJoNK9++F7kUSOfEbnoE6dEsVsQEPLD/x6NU4v1d3/ditgohKQSv9JX6XHbJKRqU9nlSb7EklS9/is63HjyfxqPxBE567L8qnXUL8GffAqtZvSXIOJC8w2U6VqdxUWjVPm0SnhCqTusn17yxTQTiOXPBbUncOKgQDf/1i9Cokg37wm5OsMiwSJb8tauy6WC5uKV06pwSM3F48nRg1Y3dR/LEboWj84UwdtAjwCdHnBS9ZX3pHlx4N3WNmMoPxFDFQSsA5N3dzJfl68/wtjrJB0WY4DfUCUMHYCn7Ytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fru3fRmdZZ49M+6RxL1lkx9WfUKWakhQxk6txESo48I=;
 b=UOAIwW50f1Jl2ZpXmQ3X9ze7+aWmDDvQeF8nbbGR3oCHqs0SdBgQPBiGSYaEv2Ucl8tLJgv5ID8VXBV9D8+b/HwiheDmNSs78CMNURw0i6GoPMMV3FmQGJ7td77OqwX+uMhvKa9dlG21G70qv5U4hlqaITZSQ65HM1RVSK486j6JoF5uvF3rF6ViD3z1t/Rw/yMnWVv0o+EHLWfxNRveGPNsQ5oahlab5/ZNCjJ2zguL/uoV2M3DkLIsX2KBhNg+6o6qAxjEa9cKd+AJgk1RgW0xHhyrWI/eRuAm6wkgUq63VL9zv8D85+DqI4LgyJ+isq6OM9WXpx+PtKJi0HJTFQ==
Received: from DM6PR08CA0055.namprd08.prod.outlook.com (2603:10b6:5:1e0::29)
 by BN9PR12MB5068.namprd12.prod.outlook.com (2603:10b6:408:135::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Sun, 25 Apr
 2021 13:25:29 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::d8) by DM6PR08CA0055.outlook.office365.com
 (2603:10b6:5:1e0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Sun, 25 Apr 2021 13:25:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4065.21 via Frontend Transport; Sun, 25 Apr 2021 13:25:29 +0000
Received: from mtl-vdi-166.wap.labs.mlnx (172.20.145.6) by
 HQMAIL107.nvidia.com (172.20.187.13) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 25 Apr 2021 13:25:27 +0000
Date:   Sun, 25 Apr 2021 16:25:23 +0300
From:   Eli Cohen <elic@nvidia.com>
To:     Jason Wang <jasowang@redhat.com>
CC:     <mst@redhat.com>, <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Zhu, Lingshan" <lingshan.zhu@intel.com>
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
Message-ID: <20210425132523.GA43506@mtl-vdi-166.wap.labs.mlnx>
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
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b49fce5-0448-453b-7222-08d907ed9877
X-MS-TrafficTypeDiagnostic: BN9PR12MB5068:
X-Microsoft-Antispam-PRVS: <BN9PR12MB506894BD3B2B15687A1EE355AB439@BN9PR12MB5068.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XSj4SI42M3br5rvbvx67e1/ZDn/BjF1eBNDz6ntHi+OkRptKKTscr3QiHd2di3H3/EvsVIwvGZ3OAMOnza/mwiSg0c2z3NeoJa1THfxe8mVcPbYTIrejg1k/r9wqOeOMZo4XCV4faGk6yt/9J0zmuTaugMBXrRNan7V5HbuPvFliiwSK31AVXePwoZbQZ/xqbk6SpZ9pdTkJH1Z4C+P+UI+FNPstt+EujZb5xCKVaSylQEKhaynvO3xXAdqtb8xL6Du6UypPBb3yz1vuwjSWXA9tnQgQJ+xnT+MqS4BxgulFWWOogJZHAvYVQfDHP9FrNfOyqO++AT6Zw/1H8r9TxBMrsMVKvsILZMrBd3Z3oNkWMH4XYxIyUhENfnxGdoQDSQvD0O98943fNqEflc8J0JBZ5wmbD2dVwGaS1N3mt6+JmxZq8lX9W3wh+zz3kLh+do5XLhSHyhrcjH5FZTM79sZWaa3mjHeru5R9ypkzy6pZTzkqGXh1MK4U7n5W2/wSoTCo22ljLAQgw29zXHBSdOfAgbeTgjtdLw/kYpWT3szdzcT2xvcJ7hOhMGQ12HrJfHoV/rXSDK8oRqHplOL5sOoAclURFE6eqV7JnSGmO5UykduObYgWE7tmSlCsJYjXu7GZcreqlFrBXVtNpIebIb+m9y5k2MEGMxKSUj//XK8=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(46966006)(36840700001)(336012)(33656002)(8676002)(70206006)(16526019)(6916009)(82740400003)(356005)(9686003)(8936002)(426003)(26005)(83380400001)(70586007)(36906005)(7636003)(478600001)(4326008)(47076005)(54906003)(5660300002)(82310400003)(316002)(2906002)(186003)(7696005)(86362001)(36860700001)(55016002)(1076003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2021 13:25:29.5244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b49fce5-0448-453b-7222-08d907ed9877
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5068
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
> 

This nearly matches we have in ConnectX devices. All the doorbells are
located at the same place. For 4K page size atchitectures it is aligned
to the start of the page. For larger page sizes it is not aligned.
If we don't allow to some offset within the page, it means that direct
doorbells will not work for 64K page size archs over ConnectX.

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
