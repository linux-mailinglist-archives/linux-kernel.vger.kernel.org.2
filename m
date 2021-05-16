Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443AE381E24
	for <lists+linux-kernel@lfdr.de>; Sun, 16 May 2021 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbhEPKoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 May 2021 06:44:24 -0400
Received: from azhdrrw-ex02.nvidia.com ([20.64.145.131]:35501 "EHLO
        AZHDRRW-EX02.NVIDIA.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbhEPKoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 May 2021 06:44:23 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 May 2021 06:44:23 EDT
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 mxs.oss.nvidia.com (10.13.234.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.858.12; Sun, 16 May
 2021 03:28:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5EchiO+YAOgAGUP2+qUgOevdEfCtxWnXfZV0MTYDZYAPtB42m/0iDk6K6UYZcedo5AKRChbU4/+/IaocKM0Td6DcutmRYPBabcLJgiWC9SBw3uQ90aY+hC+Q2BUYEodcjSkdnw5BVJlEKlgcoG97nd3p4gIe12/w/T+WeGvVXcDrMqVEuZ+8E1o+jyZQl+FdU63GcIFuSVVi/PVM4In/Vl952GPzFbyIZMHs33z+EgAi1YDRfOHzdbwUIZaH4M7suT1OWBZQO3DxoPQpYGFN5IV4KKSHwx3RULPulxHStSABNwUtg/svQTDeQXk3ZUhmj8gf1PToqlf/tuz1dIMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m44QMISXdn8+PjPL5mcH9SmTZ2cmw9EecgVOgoyLaE=;
 b=j96d4K8mcYv0yhnzD6jGSa6pOTsAz36tlhsCj2pKxyuyTVTSES9O5hWmv0y3q5OliuujZ8WhoBeH/rbPnT/zsVtymG/KSCGmX7r1uLIqQACzPOBTBEFIlZ6SRskS7I4fN/viV7KCDDMQnt7oxM4uwD5Vbdl6eaF1g2UzUbrt9412H6meiznangmckHb32lcAcorPWCAMf4KE+FrDb+NGnu6KDD7VdzSMAltbh/w6aojnfJUcux/TQVpSU59G7tZF415CwzVnOKWXvsNFdfoBO0IUiYi1L8iupUWOP9pADptzsBfmWFBiiMEWfoljhh6Hzg3pSmEw3c399PZeHiY7XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.01.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m44QMISXdn8+PjPL5mcH9SmTZ2cmw9EecgVOgoyLaE=;
 b=CVLqOguZ1irFuOc5Acb6Mz7ilceY0yo0zzHLs3T96xdiMR9XQKK+kWF0pijm603lNodW8E1/dFWQSAk1CEn9qDHLxoaospj2AOdDTb9epwvwPHpO6z1aMQSmAdP8w9xa7n4ijq/rmnPTKodJuUc9RAZGEum9sAtTCs3o2mozRWV++z56+Y7YsDMNFulncDFaHvKOignfP4BO5itsr6+fVZ/ERVdQjNocQqH//9s0lbbHA2lrcJNIagpCNVkW1xoqIf09Ilb/jWSSAyewxa26MYreCTtDQPWgFpsk4Xa614kttyTkkNMgLWzJqA01M8X3uTRUJWVpnIOwLXHXUvC4Uw==
Received: from BN9PR03CA0407.namprd03.prod.outlook.com (2603:10b6:408:111::22)
 by MWHPR12MB1536.namprd12.prod.outlook.com (2603:10b6:301:6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Sun, 16 May
 2021 10:28:06 +0000
Received: from BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::3b) by BN9PR03CA0407.outlook.office365.com
 (2603:10b6:408:111::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Sun, 16 May 2021 10:28:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT051.mail.protection.outlook.com (10.13.177.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Sun, 16 May 2021 10:28:05 +0000
Received: from localhost (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 16 May
 2021 10:28:05 +0000
Date:   Sun, 16 May 2021 13:28:01 +0300
From:   Ido Schimmel <idosch@OSS.NVIDIA.COM>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     <kbuild@lists.01.org>, <lkp@intel.com>, <kbuild-all@lists.01.org>,
        <linux-kernel@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@OSS.NVIDIA.COM>
Subject: Re: drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3598
 mlxsw_sp_nexthop_group_refresh() warn: missing error code 'err'
Message-ID: <YKDzsdYqQFnTGyTK@shredder>
References: <202105141823.Td2h3Mbi-lkp@intel.com>
 <YJ/tWBNKXrobK9RU@shredder>
 <20210515165343.GI1922@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210515165343.GI1922@kadam>
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4941908-f957-4fa4-9e88-08d918554b16
X-MS-TrafficTypeDiagnostic: MWHPR12MB1536:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1536D7FC9DFA95156DDF1DBFB22E9@MWHPR12MB1536.namprd12.prod.outlook.com>
X-MS-Exchange-Transport-Forked: True
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G2cSdZfGa19im4RUnxSvTPtMlaPHinl/dl+0GpCImcsLmTWC1bowGTFhzUQTo/W/g1vPW/Mvli/9trYar6MfK3QhvmTVt0buLwNcKHvq1gRw2/3i77+ZUYPy1H7wzE+1fbyz7VjCFRYuki8szT1SxERjR/d3yl8vatotDNU5Sw9qodHL2w8vfp+pd0JQFcJVKTKF8unn1zVqUK3c1Aa0Xwm1+83iGdw8Sh0IUOxweOHLzvNe2zFAK+W4uIVyUxClZQ2SYaHgpvjPVtcBkXcdjDxTBCBpHgZpbBFUggHiypAkOcAjPFzA2N1zuJ4hB5UZsgfWX2CmqQ0ok4hs3a4MufkhshPjg31mlrHV+3f0AQ/PcE7kJtg69inN8CVSkm1KdjbsjyIfrSSjDGDIU4ZJT2YkVwSmrPTyrcRNUsZaKRAPnWfumWIB0NrQxiS/sYhplxea52/PVwNnZdTo/BrfdftquWq8vOfUImyflqXxxlIHcbnCD/uhdTlSa/h1tO0tIqBVjTS6KEEALv/wWt+gyXpb+/ExbsAVJOM5I8YmQZAeNC7DZEcgy/WuvvSoH/+vyNg8hgD+PS3NTUaMh5WrRozdLH49YXJjljy9MQL5Z3x/qnn/sQhX5XYhHsF8S5seDT4OfdlrTuuuYVudUJFiT10ebgVKAIeapU9zvxHKl5HvZNchfwYlo3deUtXU3+wGkSjubh3EMZCZAwIhhm1Qm9au+ae8BxsPpTZXJF1BQYw=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(7916004)(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(2906002)(54906003)(70586007)(70206006)(426003)(966005)(336012)(36860700001)(107886003)(6862004)(4001150100001)(9686003)(4326008)(186003)(33716001)(36906005)(316002)(82740400003)(5660300002)(16526019)(66574015)(7636003)(8676002)(47076005)(86362001)(82310400003)(83380400001)(6666004)(8936002)(26005)(478600001)(356005);DIR:OUT;SFP:1101;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2021 10:28:05.9117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4941908-f957-4fa4-9e88-08d918554b16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1536
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 15, 2021 at 07:53:43PM +0300, Dan Carpenter wrote:
> On Sat, May 15, 2021 at 06:48:40PM +0300, Ido Schimmel wrote:
> > On Fri, May 14, 2021 at 05:35:00PM +0300, Dan Carpenter wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> > > head:   315d99318179b9cd5077ccc9f7f26a164c9fa998
> > > commit: e3ddfb45bacdc623eedea7f7bf9e7879257471d6 mlxsw: spectrum_router: Allow returning errors from mlxsw_sp_nexthop_group_refresh()
> > > config: x86_64-randconfig-m031-20210514 (attached as .config)
> > > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > > 
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > 
> > > smatch warnings:
> > > drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3598 mlxsw_sp_nexthop_group_refresh() warn: missing error code 'err'
> > > 
> > > vim +/err +3598 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
> > > 
> > > e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3555  static int
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3556  mlxsw_sp_nexthop_group_refresh(struct mlxsw_sp *mlxsw_sp,
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3557  			       struct mlxsw_sp_nexthop_group *nh_grp)
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3558  {
> > > 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3559  	struct mlxsw_sp_nexthop_group_info *nhgi = nh_grp->nhgi;
> > > eb789980d0aa6c Ido Schimmel       2017-10-22  3560  	u16 ecmp_size, old_ecmp_size;
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3561  	struct mlxsw_sp_nexthop *nh;
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3562  	bool offload_change = false;
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3563  	u32 adj_index;
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3564  	bool old_adj_index_valid;
> > > e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3565  	int i, err2, err = 0;
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3566  	u32 old_adj_index;
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3567  
> > > 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3568  	if (!nhgi->gateway) {
> > > b3e8d1ebad2d04 Ido Schimmel       2017-02-08  3569  		mlxsw_sp_nexthop_fib_entries_update(mlxsw_sp, nh_grp);
> > > e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3570  		return 0;
> > > b3e8d1ebad2d04 Ido Schimmel       2017-02-08  3571  	}
> > > b3e8d1ebad2d04 Ido Schimmel       2017-02-08  3572  
> > > 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3573  	for (i = 0; i < nhgi->count; i++) {
> > > 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3574  		nh = &nhgi->nexthops[i];
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3575  
> > > 56b8a9ed276bc1 Petr Machata       2017-07-31  3576  		if (nh->should_offload != nh->offloaded) {
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3577  			offload_change = true;
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3578  			if (nh->should_offload)
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3579  				nh->update = 1;
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3580  		}
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3581  	}
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3582  	if (!offload_change) {
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3583  		/* Nothing was added or removed, so no need to reallocate. Just
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3584  		 * update MAC on existing adjacency indexes.
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3585  		 */
> > > 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3586  		err = mlxsw_sp_nexthop_group_update(mlxsw_sp, nhgi, false);
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3587  		if (err) {
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3588  			dev_warn(mlxsw_sp->bus_info->dev, "Failed to update neigh MAC in adjacency table.\n");
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3589  			goto set_trap;
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3590  		}
> > > e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3591  		return 0;
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3592  	}
> > > 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3593  	mlxsw_sp_nexthop_group_normalize(nhgi);
> > > 7f7a417e6a11d7 Ido Schimmel       2020-11-13  3594  	if (!nhgi->sum_norm_weight)
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3595  		/* No neigh of this group is connected so we just set
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3596  		 * the trap and let everthing flow through kernel.
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05  3597  		 */
> > > a7ff87acd995e3 Jiri Pirko         2016-07-05 @3598  		goto set_trap;
> > > 
> > > The comments sort of imply that this is a success path so no error
> > > code necessary.  It's sort of hard to be positive though...
> > 
> > Thanks for the report, Dan. This is indeed a success path. How do you
> > suggest to handle it in order to avoid the warning on future smatch
> > invocations? I regularly run smatch before submitting patches and I
> > would like to keep it error/warning free.
> > 
> 
> You could move setting the error to within 4 lines of the goto:
> 
> 		err = 0;
> 		goto set_trap;

OK, I have a patch. Will test it and send to net-next together with
other patches I have in the queue.

Thanks!

> 
> This check basically assumes that if you have a cleanup block after
> a return 0; then it should return a negative error code.  It finds
> quite a few bugs and I'm generally happy with it.  But like this is
> open source and all so I'm also always open to different ideas if you
> have a way to improve the check.
> 
> regards,
> dan carpenter
> 
