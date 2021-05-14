Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE7DF380BEB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbhENOg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:36:27 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:37540 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbhENOg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:36:26 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EEXxb6144163;
        Fri, 14 May 2021 14:35:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=ofXVR2YY3iIbhWrB+fJ2sowMKy/iOgcuiTsB/zObxKQ=;
 b=QxtQhYRuIrrtRSlUDoOSCQpw18z0Av5r8Mch6XVJO26mGoyTfylnBzoBwaQIGYhvtnAp
 vROLBrz9X3WgXIQMRCJ/9Z5VDW4g9OEkyFQTgiayeCwNh+dE7vz79AGPJUD+20U3KF/V
 HrB31oWY71H5qS8yR0WnM42/GpeY1cHeZj7FPJvATqxKnhYHoj6W+8UoznX2MYARgAqL
 e67C+N6rqe5nxhz82SOVcMNWhRQ/3UgISABIIdSlZB/L38q3MKZTYrSKzChDiQcVjURJ
 FMNka6UvTyfl3n7hVvDTuD1Sz8/fohZSSntmhZeKWqWV2QjMkWVJuw9xAqUozQTUApVo dg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 38gpnemgpw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 14:35:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14EEQCTF044521;
        Fri, 14 May 2021 14:35:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 38gpph98s7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 14:35:08 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14EEY4P5061689;
        Fri, 14 May 2021 14:35:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 38gpph98r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 14:35:08 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14EEZ6Q0008920;
        Fri, 14 May 2021 14:35:07 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 May 2021 07:35:06 -0700
Date:   Fri, 14 May 2021 17:35:00 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Ido Schimmel <idosch@nvidia.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3598
 mlxsw_sp_nexthop_group_refresh() warn: missing error code 'err'
Message-ID: <202105141823.Td2h3Mbi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: t2jSsmSKEOs8RHwDSRDsKcuFW8ZcTHOS
X-Proofpoint-ORIG-GUID: t2jSsmSKEOs8RHwDSRDsKcuFW8ZcTHOS
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9984 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 clxscore=1011 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105140118
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   315d99318179b9cd5077ccc9f7f26a164c9fa998
commit: e3ddfb45bacdc623eedea7f7bf9e7879257471d6 mlxsw: spectrum_router: Allow returning errors from mlxsw_sp_nexthop_group_refresh()
config: x86_64-randconfig-m031-20210514 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3598 mlxsw_sp_nexthop_group_refresh() warn: missing error code 'err'

vim +/err +3598 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c

e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3555  static int
a7ff87acd995e3 Jiri Pirko         2016-07-05  3556  mlxsw_sp_nexthop_group_refresh(struct mlxsw_sp *mlxsw_sp,
a7ff87acd995e3 Jiri Pirko         2016-07-05  3557  			       struct mlxsw_sp_nexthop_group *nh_grp)
a7ff87acd995e3 Jiri Pirko         2016-07-05  3558  {
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3559  	struct mlxsw_sp_nexthop_group_info *nhgi = nh_grp->nhgi;
eb789980d0aa6c Ido Schimmel       2017-10-22  3560  	u16 ecmp_size, old_ecmp_size;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3561  	struct mlxsw_sp_nexthop *nh;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3562  	bool offload_change = false;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3563  	u32 adj_index;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3564  	bool old_adj_index_valid;
e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3565  	int i, err2, err = 0;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3566  	u32 old_adj_index;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3567  
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3568  	if (!nhgi->gateway) {
b3e8d1ebad2d04 Ido Schimmel       2017-02-08  3569  		mlxsw_sp_nexthop_fib_entries_update(mlxsw_sp, nh_grp);
e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3570  		return 0;
b3e8d1ebad2d04 Ido Schimmel       2017-02-08  3571  	}
b3e8d1ebad2d04 Ido Schimmel       2017-02-08  3572  
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3573  	for (i = 0; i < nhgi->count; i++) {
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3574  		nh = &nhgi->nexthops[i];
a7ff87acd995e3 Jiri Pirko         2016-07-05  3575  
56b8a9ed276bc1 Petr Machata       2017-07-31  3576  		if (nh->should_offload != nh->offloaded) {
a7ff87acd995e3 Jiri Pirko         2016-07-05  3577  			offload_change = true;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3578  			if (nh->should_offload)
a7ff87acd995e3 Jiri Pirko         2016-07-05  3579  				nh->update = 1;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3580  		}
a7ff87acd995e3 Jiri Pirko         2016-07-05  3581  	}
a7ff87acd995e3 Jiri Pirko         2016-07-05  3582  	if (!offload_change) {
a7ff87acd995e3 Jiri Pirko         2016-07-05  3583  		/* Nothing was added or removed, so no need to reallocate. Just
a7ff87acd995e3 Jiri Pirko         2016-07-05  3584  		 * update MAC on existing adjacency indexes.
a7ff87acd995e3 Jiri Pirko         2016-07-05  3585  		 */
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3586  		err = mlxsw_sp_nexthop_group_update(mlxsw_sp, nhgi, false);
a7ff87acd995e3 Jiri Pirko         2016-07-05  3587  		if (err) {
a7ff87acd995e3 Jiri Pirko         2016-07-05  3588  			dev_warn(mlxsw_sp->bus_info->dev, "Failed to update neigh MAC in adjacency table.\n");
a7ff87acd995e3 Jiri Pirko         2016-07-05  3589  			goto set_trap;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3590  		}
e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3591  		return 0;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3592  	}
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3593  	mlxsw_sp_nexthop_group_normalize(nhgi);
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3594  	if (!nhgi->sum_norm_weight)
a7ff87acd995e3 Jiri Pirko         2016-07-05  3595  		/* No neigh of this group is connected so we just set
a7ff87acd995e3 Jiri Pirko         2016-07-05  3596  		 * the trap and let everthing flow through kernel.
a7ff87acd995e3 Jiri Pirko         2016-07-05  3597  		 */
a7ff87acd995e3 Jiri Pirko         2016-07-05 @3598  		goto set_trap;

The comments sort of imply that this is a success path so no error
code necessary.  It's sort of hard to be positive though...

a7ff87acd995e3 Jiri Pirko         2016-07-05  3599  
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3600  	ecmp_size = nhgi->sum_norm_weight;
425a08c67317ac Ido Schimmel       2017-10-22  3601  	err = mlxsw_sp_fix_adj_grp_size(mlxsw_sp, &ecmp_size);
425a08c67317ac Ido Schimmel       2017-10-22  3602  	if (err)
425a08c67317ac Ido Schimmel       2017-10-22  3603  		/* No valid allocation size available. */
425a08c67317ac Ido Schimmel       2017-10-22  3604  		goto set_trap;
425a08c67317ac Ido Schimmel       2017-10-22  3605  
4b6b18692aec20 Jiri Pirko         2018-07-08  3606  	err = mlxsw_sp_kvdl_alloc(mlxsw_sp, MLXSW_SP_KVDL_ENTRY_TYPE_ADJ,
4b6b18692aec20 Jiri Pirko         2018-07-08  3607  				  ecmp_size, &adj_index);
1312444374241f Arkadi Sharshevsky 2017-03-25  3608  	if (err) {
a7ff87acd995e3 Jiri Pirko         2016-07-05  3609  		/* We ran out of KVD linear space, just set the
a7ff87acd995e3 Jiri Pirko         2016-07-05  3610  		 * trap and let everything flow through kernel.
a7ff87acd995e3 Jiri Pirko         2016-07-05  3611  		 */
a7ff87acd995e3 Jiri Pirko         2016-07-05  3612  		dev_warn(mlxsw_sp->bus_info->dev, "Failed to allocate KVD linear area for nexthop group.\n");
a7ff87acd995e3 Jiri Pirko         2016-07-05  3613  		goto set_trap;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3614  	}
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3615  	old_adj_index_valid = nhgi->adj_index_valid;
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3616  	old_adj_index = nhgi->adj_index;
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3617  	old_ecmp_size = nhgi->ecmp_size;
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3618  	nhgi->adj_index_valid = 1;
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3619  	nhgi->adj_index = adj_index;
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3620  	nhgi->ecmp_size = ecmp_size;
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3621  	mlxsw_sp_nexthop_group_rebalance(nhgi);
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3622  	err = mlxsw_sp_nexthop_group_update(mlxsw_sp, nhgi, true);
a7ff87acd995e3 Jiri Pirko         2016-07-05  3623  	if (err) {
a7ff87acd995e3 Jiri Pirko         2016-07-05  3624  		dev_warn(mlxsw_sp->bus_info->dev, "Failed to update neigh MAC in adjacency table.\n");
a7ff87acd995e3 Jiri Pirko         2016-07-05  3625  		goto set_trap;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3626  	}
a7ff87acd995e3 Jiri Pirko         2016-07-05  3627  
8c5a5b9b9185e5 Ido Schimmel       2020-01-14  3628  	mlxsw_sp_nexthop_group_offload_refresh(mlxsw_sp, nh_grp);
8c5a5b9b9185e5 Ido Schimmel       2020-01-14  3629  
a7ff87acd995e3 Jiri Pirko         2016-07-05  3630  	if (!old_adj_index_valid) {
a7ff87acd995e3 Jiri Pirko         2016-07-05  3631  		/* The trap was set for fib entries, so we have to call
a7ff87acd995e3 Jiri Pirko         2016-07-05  3632  		 * fib entry update to unset it and use adjacency index.
a7ff87acd995e3 Jiri Pirko         2016-07-05  3633  		 */
a7ff87acd995e3 Jiri Pirko         2016-07-05  3634  		err = mlxsw_sp_nexthop_fib_entries_update(mlxsw_sp, nh_grp);
a7ff87acd995e3 Jiri Pirko         2016-07-05  3635  		if (err) {
a7ff87acd995e3 Jiri Pirko         2016-07-05  3636  			dev_warn(mlxsw_sp->bus_info->dev, "Failed to add adjacency index to fib entries.\n");
a7ff87acd995e3 Jiri Pirko         2016-07-05  3637  			goto set_trap;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3638  		}
e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3639  		return 0;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3640  	}
a7ff87acd995e3 Jiri Pirko         2016-07-05  3641  
a7ff87acd995e3 Jiri Pirko         2016-07-05  3642  	err = mlxsw_sp_adj_index_mass_update(mlxsw_sp, nh_grp,
a7ff87acd995e3 Jiri Pirko         2016-07-05  3643  					     old_adj_index, old_ecmp_size);
4b6b18692aec20 Jiri Pirko         2018-07-08  3644  	mlxsw_sp_kvdl_free(mlxsw_sp, MLXSW_SP_KVDL_ENTRY_TYPE_ADJ,
0304c00546fce7 Jiri Pirko         2018-07-08  3645  			   old_ecmp_size, old_adj_index);
a7ff87acd995e3 Jiri Pirko         2016-07-05  3646  	if (err) {
a7ff87acd995e3 Jiri Pirko         2016-07-05  3647  		dev_warn(mlxsw_sp->bus_info->dev, "Failed to mass-update adjacency index for nexthop group.\n");
a7ff87acd995e3 Jiri Pirko         2016-07-05  3648  		goto set_trap;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3649  	}
77d964e66cfad0 Ido Schimmel       2017-08-02  3650  
e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3651  	return 0;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3652  
a7ff87acd995e3 Jiri Pirko         2016-07-05  3653  set_trap:
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3654  	old_adj_index_valid = nhgi->adj_index_valid;
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3655  	nhgi->adj_index_valid = 0;
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3656  	for (i = 0; i < nhgi->count; i++) {
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3657  		nh = &nhgi->nexthops[i];
a7ff87acd995e3 Jiri Pirko         2016-07-05  3658  		nh->offloaded = 0;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3659  	}
e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3660  	err2 = mlxsw_sp_nexthop_fib_entries_update(mlxsw_sp, nh_grp);
e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3661  	if (err2)
a7ff87acd995e3 Jiri Pirko         2016-07-05  3662  		dev_warn(mlxsw_sp->bus_info->dev, "Failed to set traps for fib entries.\n");
8c5a5b9b9185e5 Ido Schimmel       2020-01-14  3663  	mlxsw_sp_nexthop_group_offload_refresh(mlxsw_sp, nh_grp);
a7ff87acd995e3 Jiri Pirko         2016-07-05  3664  	if (old_adj_index_valid)
4b6b18692aec20 Jiri Pirko         2018-07-08  3665  		mlxsw_sp_kvdl_free(mlxsw_sp, MLXSW_SP_KVDL_ENTRY_TYPE_ADJ,
7f7a417e6a11d7 Ido Schimmel       2020-11-13  3666  				   nhgi->ecmp_size, nhgi->adj_index);
e3ddfb45bacdc6 Ido Schimmel       2020-11-17  3667  	return err;
a7ff87acd995e3 Jiri Pirko         2016-07-05  3668  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

