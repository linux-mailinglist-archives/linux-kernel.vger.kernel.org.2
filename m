Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C59AC381A06
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 18:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233888AbhEOQ6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 12:58:30 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56736 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhEOQ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 12:58:19 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14FGsd1u155622;
        Sat, 15 May 2021 16:56:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=CQkiaUaeyV4sPcKbz65R0d6m27SyDrmT9qYy+CNUe1U=;
 b=HXjTy/U+98DUA9qI7uQp1JfxwDWUxpVF19q27SGyCVTz1Ko9U1Q9cZ0FrcSOzpTZ+gXX
 S32fhs8PmwqidhZn7QFhV/OfXSI3LeFoyIC5NjQOdDbVk9WJyHqEHxeGeIOP6wEJqgZP
 /VJZUHKQPOzHEvpB9LF0eYVdYkekUjW8nG33P0IT6geI80KI+xMC/p8/5d3capEt9nfK
 H3fdhzTXjKBSt+SHz+ypTHMCaIdIjHs/jmZ7bNwmz2/fKtgsfcDHp15NOVK9MDG+puHg
 x+soqH+SwQVzWK0+3lE9wurmhmE/g00uv8M60JUQb5nig5UgVmeeKSYfSbrHLiYT0dUr /Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 38j3tb8pnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 16:56:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14FGuSUv151377;
        Sat, 15 May 2021 16:56:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38j3drst5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 16:56:57 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14FGuuVB152124;
        Sat, 15 May 2021 16:56:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 38j3drst5p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 15 May 2021 16:56:56 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14FGutM4032097;
        Sat, 15 May 2021 16:56:55 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 15 May 2021 16:56:54 +0000
Date:   Sat, 15 May 2021 19:56:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ido Schimmel <idosch@nvidia.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@nvidia.com>
Subject: Re: drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c:3598
 mlxsw_sp_nexthop_group_refresh() warn: missing error code 'err'
Message-ID: <20210515165647.GJ1922@kadam>
References: <202105141823.Td2h3Mbi-lkp@intel.com>
 <YJ/tWBNKXrobK9RU@shredder>
 <20210515165343.GI1922@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210515165343.GI1922@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: p11hkZfwA7iYGZZZRsdNpU1ewolKY_ca
X-Proofpoint-GUID: p11hkZfwA7iYGZZZRsdNpU1ewolKY_ca
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9985 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105150127
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
> 
> This check basically assumes that if you have a cleanup block after
> a return 0; then it should return a negative error code.  It finds
> quite a few bugs and I'm generally happy with it.  But like this is
> open source and all so I'm also always open to different ideas if you
> have a way to improve the check.

Actually, duh, I could make it a rule that if there is a comment like
this before the goto then it's probably fine.

This is quite tricky to implement in Smatch because Smatch works on the
preprocessed code so I can't promise that I will implement that change
right away.

regards,
dan carpenter

