Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730FF410A25
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Sep 2021 07:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhISFsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 01:48:12 -0400
Received: from mail-bn1nam07on2062.outbound.protection.outlook.com ([40.107.212.62]:48495
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229558AbhISFsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 01:48:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJ4V73HVMAJP3aRJa+xVGi1/Ax1HFlWpBw2kaW+AQEQbzo6G/4Qb7xZzo5OVhFsbTPFW6PLChaCYgpsK6v+pw/DNbXwD+rv07Tgl/BwzgOMLruCyHAuCXwI3GqHo0ft+tSMCfdU/GV/NC+bstVSkYNKyhesCQvs3DfJC9i62nIk8V3szg1GKAF1VssAXTjWSdevO++jHTGUSoYwfALi7mcqiMNkrgBalkDPY6EJDzW3Gorxk9gDe3WOFqUDIVI1bE0oaL8RMXWz9JwRImAddp5s+0gUU4W1Ka3Dye/rVOkIhJx+qAGVMj+YRZemR9/ineGbF9CBG6/GTnbmtyzIreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=wwYFwqNFBSvrg2/XL+iiODSzWlM08n/EZ4f4uQc5vlA=;
 b=Ewt81hCjsLgWe3OHxg622SATumdXmqmC4WCS1n4thUGqFaCTSxOdXRr30NJP8ImhqrCiPntQqj99uR0FPb1vr4kGeOzXmv9/wAjB/laYTubMaC2qms9wb2Ga6tZC22u0/IbN0S699Lvjed1ovMlK75JEQpufpYT1jzqDoWulMCvoIHq8W9IzaTjJp/69kn3p3U33GSYV9aiqRqxDIqzkvBvWoQNdPj9n78Ui9vkJyNQ9IpXga4+cjjwLFJRYg5UN3v34usM+IKSWHrHFnBA8tFDUAM96I1AAHbqCJLHT+T7pOgF7AtgDzHeuXenYabePVDTV0uhVb7FYfWLcZVbXyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=zeniv.linux.org.uk
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wwYFwqNFBSvrg2/XL+iiODSzWlM08n/EZ4f4uQc5vlA=;
 b=AtKKj70VZKFJAwjiKvC5WRZOLBBjR4RKTkuAZBYJA0e5NiiijbOCcInwKth1Yrchjzw7XTFFepTaHowWMtbpSMJSwxWrUwFeIBtp2SULJT1E1R5JEWfeyccKkCx6eQRVJUs5bjSDo9EKEA1DPBzY0kYcYe7PmTzSIyD9d/A4r3zI6gG4+8GHxfk8W3tJkHLwk0vl7g5UlNW6U2B6NKtRQwwijJeSkAYfH+41BsWVeVCQjQCXcxKBaljs6NL8mag8SmxkgLeW1BeVVgpCG9OiyFeE48wdTM0vTPbSbQgELGdBYdD2YmKf1+Q0YBdWL8mVnFPB2uBc36R7mV14E+YNMQ==
Received: from MW4PR03CA0272.namprd03.prod.outlook.com (2603:10b6:303:b5::7)
 by BN8PR12MB2914.namprd12.prod.outlook.com (2603:10b6:408:95::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Sun, 19 Sep
 2021 05:46:44 +0000
Received: from CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::8b) by MW4PR03CA0272.outlook.office365.com
 (2603:10b6:303:b5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend
 Transport; Sun, 19 Sep 2021 05:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; zeniv.linux.org.uk; dkim=none (message not signed)
 header.d=none;zeniv.linux.org.uk; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 CO1NAM11FT057.mail.protection.outlook.com (10.13.174.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4523.14 via Frontend Transport; Sun, 19 Sep 2021 05:46:44 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 19 Sep
 2021 05:46:43 +0000
Received: from localhost (172.20.187.5) by DRHQMAIL107.nvidia.com (10.27.9.16)
 with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sun, 19 Sep 2021 05:46:42
 +0000
Date:   Sun, 19 Sep 2021 08:46:39 +0300
From:   Leon Romanovsky <leonro@nvidia.com>
To:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>
CC:     <linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Subject: Re: [PATCH -rc] init: don't panic if mount_nodev_root failed
Message-ID: <YUbOv01OaWh9fQHp@unreal>
References: <b83c61f6ab34c8f17672d88e0853a9d324c3d48a.1631610487.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b83c61f6ab34c8f17672d88e0853a9d324c3d48a.1631610487.git.leonro@nvidia.com>
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8336dfa5-c8b4-43fc-769b-08d97b30dcc1
X-MS-TrafficTypeDiagnostic: BN8PR12MB2914:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2914053059674749C997DECEBDDF9@BN8PR12MB2914.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AB5K+J3dAI5OgUybOth/9BGFaX6AetwwpZ+yJoRTDl3AlKQxL6kTZEqAVXviF0SM8D9CYDrfEGNWNxs7LCdeoTK9twrf2nBwAx5xqAoNRI/REmxJ/3exa3H6DNyvU+dfAV6zyUquvbz6dVnKWZ7QhDj/CxOqefbC6B0p4RS1xvkEZppxYgts8yWbpIzAXn6oyQxP5YJJMIsLfhMJFuyb1sVZqsz2KsYAz02A+Hh9oelCFNxTjjeOYESCiQ3jVzsOhTtYBw7xW+8yXteNiMtVGNZztiow0p7V2zUR7lMeWuiGcKy/i+lIa7MH0qigFgxpZlyRCDYKnTDy9oTqsUNG8hg1IDqH8MFfMwK6yvOu/IFq1K5aHcyqlsB/PMn7MSG7eDmnKdB+OBE96ZPJ+Unirgd/IXsK2BAtnVtTFcbETm9oZEqqPOgAhhVs6zzJ5GMppTNRAuDBLsJv9MShVyClv7Zcod1FAMHdrCczMtVWqHmaKvH+QqUztfB0a4PVMb9D8wMwrbCx7KHOHEO7Lne2oDfcQksGwIh0NbmYVSYbUr1HBbGIbfCLJAYYxAKHmvSQlmYpxbhMrFPZ9WtgFX4OFfdr4obWSudX68UKDUTpIi/ZfSOIiOeJDO7XEHsasKR7n+m4EzK30GVY25kGd37G6KYRwdhX5Od3YeY3Pb/+bnKcrvGe1M79d+yKJ/vpTLSteHRw2ksPwhXm2wuUSKytyAJ/oW8h3sKVO+p1e3pcqxCEVPR+p8hEhO8FlAu8J61Hiy+ksfVTZpMU/hYfeLHmttNSFdum6XCdMuZ0YnudNLE=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(7916004)(346002)(39860400002)(396003)(376002)(136003)(36840700001)(46966006)(8676002)(82740400003)(316002)(86362001)(82310400003)(54906003)(70586007)(36906005)(9686003)(6666004)(5660300002)(33716001)(4326008)(356005)(8936002)(83380400001)(186003)(36860700001)(2906002)(110136005)(7636003)(26005)(478600001)(16526019)(966005)(47076005)(70206006)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2021 05:46:44.0979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8336dfa5-c8b4-43fc-769b-08d97b30dcc1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2914
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 12:12:10PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Attempt to mount 9p file system as root gives the following kernel panic:
> 
>  9pnet_virtio: no channels available for device root
>  Kernel panic - not syncing: VFS: Unable to mount root "root" (9p), err=-2
>  CPU: 2 PID: 1 Comm: swapper/0 Not tainted 5.15.0-rc1+ #127
>  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
>  Call Trace:
>   dump_stack_lvl+0x45/0x59
>   panic+0x1e2/0x44b
>   ? __warn_printk+0xf3/0xf3
>   ? free_unref_page+0x2d4/0x4a0
>   ? trace_hardirqs_on+0x32/0x120
>   ? free_unref_page+0x2d4/0x4a0
>   mount_root+0x189/0x1e0
>   prepare_namespace+0x136/0x165
>   kernel_init_freeable+0x3b8/0x3cb
>   ? rest_init+0x2e0/0x2e0
>   kernel_init+0x19/0x130
>   ret_from_fork+0x1f/0x30
>  Kernel Offset: disabled
>  ---[ end Kernel panic - not syncing: VFS: Unable to mount root "root" (9p), err=-2 ]---
> 
> QEMU command line:
>  "qemu-system-x86_64 -append root=/dev/root rw rootfstype=9p rootflags=trans=virtio ..."
> 
> This error is because root_device_name is truncated in prepare_namespace() from
> being "/dev/root" to be "root" prior to call to mount_nodev_root().
> 
> As a solution, don't treat errors in mount_nodev_root() as errors that
> require panics and allow failback to the mount flow that existed before
> patch citied in Fixes tag.
> 
> Fixes: f9259be6a9e7 ("init: allow mounting arbitrary non-blockdevice filesystems as root")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> I'm not sure if this is the right thing to do, but it works for me.
> ---
>  init/do_mounts.c | 3 ---
>  1 file changed, 3 deletions(-)

Hi,

I assume that after Christoph gave his ROB [1], the patch is ok.
Should I do anything else in order to progress with merging it?

Thanks

[1] https://lore.kernel.org/all/20210914150709.GA32708@lst.de/
