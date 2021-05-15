Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4019D3819BA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 18:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhEOQFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 12:05:08 -0400
Received: from azhdrrw-ex01.nvidia.com ([20.51.104.162]:1064 "EHLO
        AZHDRRW-EX01.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbhEOQFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 12:05:02 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 May 2021 12:05:02 EDT
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by mxs.oss.nvidia.com (10.13.234.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.858.12; Sat, 15 May 2021 08:48:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfVYQiwYHwLx/xTsN1NbMkisr7wbC5Io5ZYz3qzlBbzwWMAJv0E5GdhZvLvZVi6HGyePwd7boA8/l8m/+2aEI5s5/Ocj4W9ylkw1fqrg8jTkk5teqFTSX3FqStodV17HIsHbINHPoOyVwL1oxLIEQ7rNSEsVqtN04PVKxyukFRaGC4Des6gUdhsV+h/wR6yuZgRoyvlgcPeWSyymLmqCjWVbAM60GjwLGL2t4FmJBxZig5p2PVqHgOkGq0h6Am/t6BQnXzUcPMl/11PbUnfs+Ck788KQ2PiQ7HeOyvx73EjxG2TXf1R/PAe4bH/iNZEhd2yDlQU/MJcFkuMxiff/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GpJm1kFCYsQ7V+4u+y7QHuGItacSzYR1yd+xT0EwWY=;
 b=NHoFl7lRczyS8S90F/e5Ppx6SPGT/zHrU1pOg75O9d0vloVv7muNrcEqRiCzJYa5e32Z1II79BjFhCUUc3ZXKdUx2hNq76Wg2ChVF4zhR/QqfzeaeV2OjA3POn9AQOP0smxf7inq3hVG0NT5w8v+5KwEdfs35lwaeTLrq1yqRtbtszYN77t7cb6yceZZJBG5/6v5sYs/enYKQktp0Jg/dcR5ROpuAirokT+qZxPO7U2iR1+1ujCYAGSDp2xwAsPa1Kb8kfqTQRyo4tchY2rGPZhHSNxmziB0GWIgsETQ6HMlfiaXJlOAN78CaydoWXqRq9iieHZvHIxCLe52dGHNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.01.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3GpJm1kFCYsQ7V+4u+y7QHuGItacSzYR1yd+xT0EwWY=;
 b=sHxSrds0/qqDXgcv+tkPI3dAhM772mkvIkmr1pVnVh4Twa+zOe18P2c6Lm9RINHFx5bIMUGKRJmdss1QyYtHl8qlANRbKOXcROtqlj8hKt2Yy1I7oDZ7Gk8zw3kLOE2CphUP5yB0GU/pm3vPtEHXnX1TPRdWfu3EUOBew1iy5+1VolxJmzd0sa2u/Y/n3kWTgE8RaQM/Uo7A9uO7VpgDIfJwbat/EkfSSId42qdDxGy9B7c0GX2tNtHOJxR7a6v6MpfIcbAr3v3P2z+k4TZE8zo+8dcFLCKp3/DuT6ezWdtdUissVoKdSgJMk2fSEGdZqOKSzOdtDri8RdO3W9An+w==
Received: from MWHPR03CA0009.namprd03.prod.outlook.com (2603:10b6:300:117::19)
 by MN2PR12MB4815.namprd12.prod.outlook.com (2603:10b6:208:1bf::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Sat, 15 May
 2021 15:48:44 +0000
Received: from CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::b2) by MWHPR03CA0009.outlook.office365.com
 (2603:10b6:300:117::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.32 via Frontend
 Transport; Sat, 15 May 2021 15:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT039.mail.protection.outlook.com (10.13.174.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Sat, 15 May 2021 15:48:44 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 15 May
 2021 15:48:43 +0000
Date:   Sat, 15 May 2021 18:48:40 +0300
From:   Ido Schimmel <idosch@OSS.NVIDIA.COM>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <kbuild@lists.01.org>, <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@OSS.NVIDIA.COM>
Subject: Re: drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3598
 mlxsw_sp_nexthop_group_refresh() warn: missing error code 'err'
Message-ID: <YJ/tWBNKXrobK9RU@shredder>
References: <202105141823.Td2h3Mbi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <202105141823.Td2h3Mbi-lkp@intel.com>
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b288293e-bab2-4381-0116-08d917b8ebb8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4815:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4815972F7CE8F6A6B41A7389B22F9@MN2PR12MB4815.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09wnR4Ot14vF5FPhzrMGcvskZq2sT/POx0EE39+LShFEKBnRJw0s+MRPJpBEcrxfzd+w/xbTexeulay9162TQ3hCgoyWFJOMpbWlFXtyZkqrQCG/j1n6OXKPyPOua54pQ3KqaBb/rMZNNyl/TXe860/FEuqBrRofyZl7lyT4FIcwYx4Z8NbmaULDE1wCT45gEapItq1O0QE3oqj4GD+JIYnKHcAHWeciZloNezycvXxK/HRCcMdmpffHQc9rScYygyxbb2V+9tf1gVyt2pxBrI3x7pPIkFfIXsPScfxTsfd8XqlBO1Y2O09M7opP17xbbwbfjVWIZgJaioJvfCQ+d425AWl5RQ5HkuZP4+Ejt5J59BRrgykqPWOQNWj1kwzq3daPH3sGNZ99JzwfmsmeFDVDz8B5TrUGpb4z8M5HOsp2ndpCyZSkvocGlkSdr3HE6+j+x8Y1521G2ysoCDYqTOS/Yt1SjBnlA0hsBs+DI3J4M+N02PaZF6EA+6S0Ks5bqdLuUvagbjZ81TSISsDnLbLDkW7HEbfvCZ5Q3P6aNEPAhtPJL7UwBXUNQhfju6LdPUoB1b9mGbwAecgtofc/KsxdhhKCRyGlzgbSpfj0NZfxbDSJWdaL01NuP0EeMaPY/pZopSpPZZQWy9lSeC/XIniMmz3kDWqN5peLPbFdc4bXnWQs0gh0LULd3SkU+HuhpsZYGAtweDKiqURWwqKw077TQ5HlYKIVb56KKLogZk4=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(7916004)(136003)(376002)(346002)(396003)(39860400002)(36840700001)(46966006)(2906002)(5660300002)(86362001)(82310400003)(66574015)(54906003)(8936002)(336012)(26005)(966005)(83380400001)(9686003)(426003)(36860700001)(107886003)(47076005)(33716001)(316002)(70206006)(36906005)(70586007)(7636003)(356005)(6862004)(478600001)(4326008)(8676002)(16526019)(186003)(82740400003)(4001150100001);DIR:OUT;SFP:1101;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2021 15:48:44.4502
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b288293e-bab2-4381-0116-08d917b8ebb8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT039.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4815
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 05:35:00PM +0300, Dan Carpenter wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   315d99318179b9cd5077ccc9f7f26a164c9fa998
> commit: e3ddfb45bacdc623eedea7f7bf9e7879257471d6 mlxsw: spectrum_router: Allow returning errors from mlxsw_sp_nexthop_group_refresh()
> config: x86_64-randconfig-m031-20210514 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3598 mlxsw_sp_nexthop_group_refresh() warn: missing error code 'err'
> 
> vim +/err +3598 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> 
> e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3555  static int
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3556  mlxsw_sp_nexthop_group_refresh(struct mlxsw_sp *mlxsw_sp,
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3557  			       struct mlxsw_sp_nexthop_group *nh_grp)
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3558  {
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3559  	struct mlxsw_sp_nexthop_group_info *nhgi = nh_grp->nhgi;
> eb789980d0aa6c Ido Schimmel       2017-10-22  3560  	u16 ecmp_size, old_ecmp_size;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3561  	struct mlxsw_sp_nexthop *nh;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3562  	bool offload_change = false;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3563  	u32 adj_index;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3564  	bool old_adj_index_valid;
> e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3565  	int i, err2, err = 0;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3566  	u32 old_adj_index;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3567  
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3568  	if (!nhgi->gateway) {
> b3e8d1ebad2d04 Ido Schimmel       2017-02-08  3569  		mlxsw_sp_nexthop_fib_entries_update(mlxsw_sp, nh_grp);
> e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3570  		return 0;
> b3e8d1ebad2d04 Ido Schimmel       2017-02-08  3571  	}
> b3e8d1ebad2d04 Ido Schimmel       2017-02-08  3572  
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3573  	for (i = 0; i < nhgi->count; i++) {
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3574  		nh = &nhgi->nexthops[i];
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3575  
> 56b8a9ed276bc1 Petr Machata       2017-07-31  3576  		if (nh->should_offload != nh->offloaded) {
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3577  			offload_change = true;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3578  			if (nh->should_offload)
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3579  				nh->update = 1;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3580  		}
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3581  	}
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3582  	if (!offload_change) {
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3583  		/* Nothing was added or removed, so no need to reallocate. Just
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3584  		 * update MAC on existing adjacency indexes.
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3585  		 */
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3586  		err = mlxsw_sp_nexthop_group_update(mlxsw_sp, nhgi, false);
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3587  		if (err) {
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3588  			dev_warn(mlxsw_sp->bus_info->dev, "Failed to update neigh MAC in adjacency table.\n");
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3589  			goto set_trap;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3590  		}
> e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3591  		return 0;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3592  	}
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3593  	mlxsw_sp_nexthop_group_normalize(nhgi);
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3594  	if (!nhgi->sum_norm_weight)
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3595  		/* No neigh of this group is connected so we just set
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3596  		 * the trap and let everthing flow through kernel.
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3597  		 */
> a7ff87acd995e3 Jiri Pirko         2016-07-05 @3598  		goto set_trap;
> 
> The comments sort of imply that this is a success path so no error
> code necessary.  It's sort of hard to be positive though...

Thanks for the report, Dan. This is indeed a success path. How do you
suggest to handle it in order to avoid the warning on future smatch
invocations? I regularly run smatch before submitting patches and I
would like to keep it error/warning free.

> 
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3599  
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3600  	ecmp_size = nhgi->sum_norm_weight;
> 425a08c67317ac Ido Schimmel       2017-10-22  3601  	err = mlxsw_sp_fix_adj_grp_size(mlxsw_sp, &ecmp_size);
> 425a08c67317ac Ido Schimmel       2017-10-22  3602  	if (err)
> 425a08c67317ac Ido Schimmel       2017-10-22  3603  		/* No valid allocation size available. */
> 425a08c67317ac Ido Schimmel       2017-10-22  3604  		goto set_trap;
> 425a08c67317ac Ido Schimmel       2017-10-22  3605  
> 4b6b18692aec20 Jiri Pirko         2018-07-08  3606  	err = mlxsw_sp_kvdl_alloc(mlxsw_sp, MLXSW_SP_KVDL_ENTRY_TYPE_ADJ,
> 4b6b18692aec20 Jiri Pirko         2018-07-08  3607  				  ecmp_size, &adj_index);
> 1312444374241f Arkadi Sharshevsky 2017-03-25  3608  	if (err) {
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3609  		/* We ran out of KVD linear space, just set the
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3610  		 * trap and let everything flow through kernel.
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3611  		 */
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3612  		dev_warn(mlxsw_sp->bus_info->dev, "Failed to allocate KVD linear area for nexthop group.\n");
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3613  		goto set_trap;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3614  	}
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3615  	old_adj_index_valid = nhgi->adj_index_valid;
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3616  	old_adj_index = nhgi->adj_index;
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3617  	old_ecmp_size = nhgi->ecmp_size;
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3618  	nhgi->adj_index_valid = 1;
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3619  	nhgi->adj_index = adj_index;
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3620  	nhgi->ecmp_size = ecmp_size;
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3621  	mlxsw_sp_nexthop_group_rebalance(nhgi);
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3622  	err = mlxsw_sp_nexthop_group_update(mlxsw_sp, nhgi, true);
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3623  	if (err) {
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3624  		dev_warn(mlxsw_sp->bus_info->dev, "Failed to update neigh MAC in adjacency table.\n");
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3625  		goto set_trap;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3626  	}
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3627  
> 8c5a5b9b9185e5 Ido Schimmel       2020-01-14  3628  	mlxsw_sp_nexthop_group_offload_refresh(mlxsw_sp, nh_grp);
> 8c5a5b9b9185e5 Ido Schimmel       2020-01-14  3629  
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3630  	if (!old_adj_index_valid) {
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3631  		/* The trap was set for fib entries, so we have to call
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3632  		 * fib entry update to unset it and use adjacency index.
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3633  		 */
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3634  		err = mlxsw_sp_nexthop_fib_entries_update(mlxsw_sp, nh_grp);
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3635  		if (err) {
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3636  			dev_warn(mlxsw_sp->bus_info->dev, "Failed to add adjacency index to fib entries.\n");
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3637  			goto set_trap;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3638  		}
> e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3639  		return 0;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3640  	}
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3641  
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3642  	err = mlxsw_sp_adj_index_mass_update(mlxsw_sp, nh_grp,
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3643  					     old_adj_index, old_ecmp_size);
> 4b6b18692aec20 Jiri Pirko         2018-07-08  3644  	mlxsw_sp_kvdl_free(mlxsw_sp, MLXSW_SP_KVDL_ENTRY_TYPE_ADJ,
> 0304c00546fce7 Jiri Pirko         2018-07-08  3645  			   old_ecmp_size, old_adj_index);
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3646  	if (err) {
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3647  		dev_warn(mlxsw_sp->bus_info->dev, "Failed to mass-update adjacency index for nexthop group.\n");
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3648  		goto set_trap;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3649  	}
> 77d964e66cfad0 Ido Schimmel       2017-08-02  3650  
> e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3651  	return 0;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3652  
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3653  set_trap:
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3654  	old_adj_index_valid = nhgi->adj_index_valid;
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3655  	nhgi->adj_index_valid = 0;
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3656  	for (i = 0; i < nhgi->count; i++) {
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3657  		nh = &nhgi->nexthops[i];
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3658  		nh->offloaded = 0;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3659  	}
> e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3660  	err2 = mlxsw_sp_nexthop_fib_entries_update(mlxsw_sp, nh_grp);
> e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3661  	if (err2)
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3662  		dev_warn(mlxsw_sp->bus_info->dev, "Failed to set traps for fib entries.\n");
> 8c5a5b9b9185e5 Ido Schimmel       2020-01-14  3663  	mlxsw_sp_nexthop_group_offload_refresh(mlxsw_sp, nh_grp);
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3664  	if (old_adj_index_valid)
> 4b6b18692aec20 Jiri Pirko         2018-07-08  3665  		mlxsw_sp_kvdl_free(mlxsw_sp, MLXSW_SP_KVDL_ENTRY_TYPE_ADJ,
> 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3666  				   nhgi->ecmp_size, nhgi->adj_index);
> e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3667  	return err;
> a7ff87acd995e3 Jiri Pirko         2016-07-05  3668  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
