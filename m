Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 289B8410A2C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 08:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhISGjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 02:39:52 -0400
Received: from mail-dm6nam10on2040.outbound.protection.outlook.com ([40.107.93.40]:34369
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230158AbhISGjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 02:39:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCwJmA84c/R0TTVHAtCP7T4VbPDXTurPuHQYU6nYVAQV0+0bFnIcASEocYX+4hXu0u+3IHN7tmJPujTsDHtchqqt97FnY69KZZgbSOvLYQKnxIvWiajpWrJgqhKtnMMWq+ocpsl5mDBYDvg8DX8JsIYgurS3DqZr0JS0NaToobOkTK+DwpsbgJwOa8pDyt1mMLXYeBmBlrYwRhdxx+Fc8oue/6mGoL+yTJuPzdcGIL62nrXp6ahDEj29iGUALaDckNG0MeTWKed1tqBrYV/otVFUC8ucpUCnihN1P7w8n6J2IEiorPMd2VLcQXIkc0oPLl4OgM+qBjM4NbyzxcTE5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=GzKW+p+lnWXWvE3fydoOFvYb4rZTOtC9ZsLI4g4F/Xo=;
 b=lKpJGKsaaCno+O4zCx5xg+AM6EILM+QrLEcsVbkO4mBjL6LiSpx5RE6TAT/BMV3brnFfio/fPCw5omqWg/oTxas95F3wServ7FiQLZcJpNfH0y6r0l63GNklaElw/pB3j1xBNhpp/KZCMOXJzyJTThFyUpykQF+Qspvj+5wlZgp3cTdzefUIlm9R6HN20pYyFutZwF5/0S6UIECyGadgYoKTxVlEbT/wJacPYJY0+ItUfagRplgCTpRIU9iBhCIckKUHtpe9qe3i0sNLe7gJSw9vSEVro0JhgK4YAS2Im6wwHf7XyQOvS6RchpkfV6uMBgniqfYP4jnqsJXksN+YjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=zeniv.linux.org.uk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzKW+p+lnWXWvE3fydoOFvYb4rZTOtC9ZsLI4g4F/Xo=;
 b=Ir59+k7eGY13WNdL00QxSd4wkq1gxyROI6hs8QKVL7ylGXsBVe+JStRdlUIYvAtlKPU55DXbm9cj4OppPDnJQ9+UGzQt2eSL9X+4/AXGb7coOWd4nE2cFRtOT730xi/UsSNM3t9UfyriChP4WRPQYffn5K+bpFpqxTk5jkFsF6YOpfHPLjfkAvmSt+4J4qf2pRWauJYQgdgWPikRYwrub1AYAP0jZDGzcS08ygkHONKUXLNBZkMByXHYc9XjVjvjaEQTUXULd5tDzOnmov1WT8+agjDhKqpJ2EVMuE9wnGTyQqloarUoIpUw1+tN0g3IWkI+8qyniMsSWTGx3YRfbA==
Received: from BN6PR1401CA0004.namprd14.prod.outlook.com
 (2603:10b6:405:4b::14) by SN6PR12MB4765.namprd12.prod.outlook.com
 (2603:10b6:805:e4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.18; Sun, 19 Sep
 2021 06:38:25 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4b:cafe::d0) by BN6PR1401CA0004.outlook.office365.com
 (2603:10b6:405:4b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Sun, 19 Sep 2021 06:38:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Sun, 19 Sep 2021 06:38:24 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 19 Sep
 2021 06:38:24 +0000
Received: from localhost (172.20.187.6) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 19 Sep 2021 06:38:23
 +0000
Date:   Sun, 19 Sep 2021 09:38:20 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH -rc] init: don't panic if mount_nodev_root failed
Message-ID: <YUba3Jiw6F0GXXBl@unreal>
References: <b83c61f6ab34c8f17672d88e0853a9d324c3d48a.1631610487.git.leonro@nvidia.com>
 <YUbOv01OaWh9fQHp@unreal>
 <YUbT7H4fD0KvnbLa@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YUbT7H4fD0KvnbLa@zeniv-ca.linux.org.uk>
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c68c4c26-7fd5-4441-0175-08d97b3814ef
X-MS-TrafficTypeDiagnostic: SN6PR12MB4765:
X-Microsoft-Antispam-PRVS: <SN6PR12MB47658636D673BEB492C019B6BDDF9@SN6PR12MB4765.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HJI5vgfsw7GSCKjAu6DcuIRqs/jwzhG+S2upijTnaRRxTWefT2pzKzz5LmFJyEszp0Hhcyb0tNeOoXMvei0JhTdhN4wkB9YCt4XJk8kWXdK51yCd+/1zFkjH5dtMuodnn9UxdnfjfZDoPJ/DF+34epujk2n429bNTV+zOKQWreWZcFaIATYlFSX+g40vtlM1UTJIkZpV/P7CovWa0RBB/Z0zqx+u4V9LsvDuhtw6THUHq/pRnmTvfdKOradnG3oiIzUo+UkHgmxIZ08pz6kkqBe4AUHPgzDoG8Z0AOofcud0/vQsw6e9dATmhB0DAbF3s4Xm2/+wo8sPVKZEwPBiBoaXAeNcfM9UCEObsV/y0EMjJjnv9XGRdIpxPalKw2ZNMOoERk2ivt6Kqnrg6bmqhhWAqvY+jYTWYfSBulsUeETrrNzhwiMnFVpIpgq1V0/LE2+Hlt0Sab/Rq75mkZK50hzMnyjG8EN6FtyLIcVxCsyEfBnfOeQxgvRrlHxj+CZ6rUj9zIRveoSwn/gaOVJlKgez4SGYo8OmNjcZJxTy7RTkRo5OWCpzTY1F7PLGU7IBscmm2e2u11I769OgPczqSyIX4MvcgN+gP29+Z2DMR79kwSVcUaCkDruYbQ/UQ60CHJtqvRBbNzrKuYOJR7rC/plMjE7HTakG/bD1oUzliYzQijCi0kn1oqJhN5KfO/zDn64ZZz8cvZDY7BqwcmKQQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(7916004)(4636009)(136003)(39860400002)(346002)(396003)(376002)(36840700001)(46966006)(36860700001)(82740400003)(8936002)(336012)(33716001)(356005)(83380400001)(47076005)(36906005)(316002)(16526019)(9686003)(7636003)(70206006)(70586007)(8676002)(54906003)(86362001)(2906002)(5660300002)(4326008)(82310400003)(6916009)(478600001)(186003)(26005)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2021 06:38:24.7479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c68c4c26-7fd5-4441-0175-08d97b3814ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4765
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 19, 2021 at 06:08:44AM +0000, Al Viro wrote:
> On Sun, Sep 19, 2021 at 08:46:39AM +0300, Leon Romanovsky wrote:
> > On Tue, Sep 14, 2021 at 12:12:10PM +0300, Leon Romanovsky wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > Attempt to mount 9p file system as root gives the following kernel panic:
> > > 
> > >  9pnet_virtio: no channels available for device root
> > >  Kernel panic - not syncing: VFS: Unable to mount root "root" (9p), err=-2
> > >  CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc1+ #127
> > >  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > >  Call Trace:
> > >   dump_stack_lvl+0x45/0x59
> > >   panic+0x1e2/0x44b
> > >   ? __warn_printk+0xf3/0xf3
> > >   ? free_unref_page+0x2d4/0x4a0
> > >   ? trace_hardirqs_on+0x32/0x120
> > >   ? free_unref_page+0x2d4/0x4a0
> > >   mount_root+0x189/0x1e0
> > >   prepare_namespace+0x136/0x165
> > >   kernel_init_freeable+0x3b8/0x3cb
> > >   ? rest_init+0x2e0/0x2e0
> > >   kernel_init+0x19/0x130
> > >   ret_from_fork+0x1f/0x30
> > >  Kernel Offset: disabled
> > >  ---[ end Kernel panic - not syncing: VFS: Unable to mount root "root" (9p), err=-2 ]---
> > > 
> > > QEMU command line:
> > >  "qemu-system-x86_64 -append root=/dev/root rw rootfstype=9p rootflags=trans=virtio ..."
> > > 
> > > This error is because root_device_name is truncated in prepare_namespace() from
> > > being "/dev/root" to be "root" prior to call to mount_nodev_root().
> > > 
> > > As a solution, don't treat errors in mount_nodev_root() as errors that
> > > require panics and allow failback to the mount flow that existed before
> > > patch citied in Fixes tag.
> > > 
> > > Fixes: f9259be6a9e7 ("init: allow mounting arbitrary non-blockdevice filesystems as root")
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > > I'm not sure if this is the right thing to do, but it works for me.
> > > ---
> > >  init/do_mounts.c | 3 ---
> > >  1 file changed, 3 deletions(-)
> > 
> > Hi,
> > 
> > I assume that after Christoph gave his ROB [1], the patch is ok.
> > Should I do anything else in order to progress with merging it?
> 
> Sits in the local pile; will go to Linus tomorrow...

Thanks Al,

I have a question for the next time, is it possible to see the status
of the patches without nagging you?

Thanks
