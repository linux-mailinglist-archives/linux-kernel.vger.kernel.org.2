Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 419EA3715F3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 15:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhECN2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 09:28:18 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60420 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbhECN2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 09:28:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143DOAsx072599;
        Mon, 3 May 2021 13:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=C2VRdJwUili4pA13Xs4Ry8oGKa7QsPKsv0FwRng9RZo=;
 b=y9Yqid3spiOL6KfuIwAdLKz+mRrmI/enwBalnNbnGzUeE2b7/beJKUcO6Yy8I7/E6pzq
 8RV2A5DZqqpTpTk1Fi6HSZPdsjVJLIPG7bE51AsbdeWR8rIfQRWRSjHKTq049dh8p4+3
 Y+mc4aHlxCQXp/Zc3c3hKGJ6mCgomeln4wCJdzEb4Yv6afU1VE1ll9/FGJbT0S5GRilV
 nINSQyo4dgLWuGFh+qrFzy3IRnmKQVH+LVy/jg1Sxwgh+/xHXrFks92iH/5YaHtWsmqM
 YTD24hxxySv2KAVbfJ3UtZod1SzxERRKRyet/RiJ33DRpVJQcR/mzIt92azuzUjD2cLG 4g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 388xxmuk46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 13:27:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 143DPc0h185238;
        Mon, 3 May 2021 13:27:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 388w1cn2m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 13:27:14 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 143DRDdQ190495;
        Mon, 3 May 2021 13:27:13 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 388w1cn2kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 13:27:13 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 143DRBN9022832;
        Mon, 3 May 2021 13:27:12 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 03 May 2021 06:27:11 -0700
Date:   Mon, 3 May 2021 16:27:03 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Vivek Goyal <vgoyal@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Peng Tao <tao.peng@linux.alibaba.com>
Subject: [kbuild] fs/fuse/dax.c:113 fuse_setup_one_mapping() warn: should
 'start_idx << 21' be a 64 bit type?
Message-ID: <202105032112.SJqOaXpO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: FNR6ML4TBNUNAESIHAKIWUVT7MQWTO45
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: ng8Ktzev-Zmj76EXHZei_5slKJ0hIPzj
X-Proofpoint-ORIG-GUID: ng8Ktzev-Zmj76EXHZei_5slKJ0hIPzj
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9973 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030091
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   9ccce092fc64d19504fa54de4fd659e279cc92e7
commit: c2d0ad00d948de73c78f05d2b3e5bdfa605035cc virtiofs: implement dax read/write operations
config: i386-randconfig-m031-20210503 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
fs/fuse/dax.c:113 fuse_setup_one_mapping() warn: should 'start_idx << 21' be a 64 bit type?

Old smatch warnings:
fs/fuse/dax.c:197 dmap_removemapping_list() error: uninitialized symbol 'ret'.

vim +113 fs/fuse/dax.c

c2d0ad00d948de Vivek Goyal 2020-08-19  105  static int fuse_setup_one_mapping(struct inode *inode, unsigned long start_idx,
c2d0ad00d948de Vivek Goyal 2020-08-19  106  				  struct fuse_dax_mapping *dmap, bool writable,
c2d0ad00d948de Vivek Goyal 2020-08-19  107  				  bool upgrade)
c2d0ad00d948de Vivek Goyal 2020-08-19  108  {
c2d0ad00d948de Vivek Goyal 2020-08-19  109  	struct fuse_conn *fc = get_fuse_conn(inode);
c2d0ad00d948de Vivek Goyal 2020-08-19  110  	struct fuse_conn_dax *fcd = fc->dax;
c2d0ad00d948de Vivek Goyal 2020-08-19  111  	struct fuse_inode *fi = get_fuse_inode(inode);
c2d0ad00d948de Vivek Goyal 2020-08-19  112  	struct fuse_setupmapping_in inarg;
c2d0ad00d948de Vivek Goyal 2020-08-19 @113  	loff_t offset = start_idx << FUSE_DAX_SHIFT;

This is only an issue on 32 bit systems but "offset" is a 64bit and
"start_idx" is ulong.

c2d0ad00d948de Vivek Goyal 2020-08-19  114  	FUSE_ARGS(args);
c2d0ad00d948de Vivek Goyal 2020-08-19  115  	ssize_t err;
c2d0ad00d948de Vivek Goyal 2020-08-19  116  
c2d0ad00d948de Vivek Goyal 2020-08-19  117  	WARN_ON(fcd->nr_free_ranges < 0);
c2d0ad00d948de Vivek Goyal 2020-08-19  118  
c2d0ad00d948de Vivek Goyal 2020-08-19  119  	/* Ask fuse daemon to setup mapping */
c2d0ad00d948de Vivek Goyal 2020-08-19  120  	memset(&inarg, 0, sizeof(inarg));
c2d0ad00d948de Vivek Goyal 2020-08-19  121  	inarg.foffset = offset;
c2d0ad00d948de Vivek Goyal 2020-08-19  122  	inarg.fh = -1;
c2d0ad00d948de Vivek Goyal 2020-08-19  123  	inarg.moffset = dmap->window_offset;
c2d0ad00d948de Vivek Goyal 2020-08-19  124  	inarg.len = FUSE_DAX_SZ;
c2d0ad00d948de Vivek Goyal 2020-08-19  125  	inarg.flags |= FUSE_SETUPMAPPING_FLAG_READ;
c2d0ad00d948de Vivek Goyal 2020-08-19  126  	if (writable)
c2d0ad00d948de Vivek Goyal 2020-08-19  127  		inarg.flags |= FUSE_SETUPMAPPING_FLAG_WRITE;
c2d0ad00d948de Vivek Goyal 2020-08-19  128  	args.opcode = FUSE_SETUPMAPPING;
c2d0ad00d948de Vivek Goyal 2020-08-19  129  	args.nodeid = fi->nodeid;
c2d0ad00d948de Vivek Goyal 2020-08-19  130  	args.in_numargs = 1;
c2d0ad00d948de Vivek Goyal 2020-08-19  131  	args.in_args[0].size = sizeof(inarg);
c2d0ad00d948de Vivek Goyal 2020-08-19  132  	args.in_args[0].value = &inarg;
c2d0ad00d948de Vivek Goyal 2020-08-19  133  	err = fuse_simple_request(fc, &args);
c2d0ad00d948de Vivek Goyal 2020-08-19  134  	if (err < 0)
c2d0ad00d948de Vivek Goyal 2020-08-19  135  		return err;
c2d0ad00d948de Vivek Goyal 2020-08-19  136  	dmap->writable = writable;
c2d0ad00d948de Vivek Goyal 2020-08-19  137  	if (!upgrade) {
c2d0ad00d948de Vivek Goyal 2020-08-19  138  		dmap->itn.start = dmap->itn.last = start_idx;
c2d0ad00d948de Vivek Goyal 2020-08-19  139  		/* Protected by fi->dax->sem */
c2d0ad00d948de Vivek Goyal 2020-08-19  140  		interval_tree_insert(&dmap->itn, &fi->dax->tree);
c2d0ad00d948de Vivek Goyal 2020-08-19  141  		fi->dax->nr++;
c2d0ad00d948de Vivek Goyal 2020-08-19  142  	}
c2d0ad00d948de Vivek Goyal 2020-08-19  143  	return 0;
c2d0ad00d948de Vivek Goyal 2020-08-19  144  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

