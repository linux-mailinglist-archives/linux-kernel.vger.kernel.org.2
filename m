Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B77A3B17CD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 12:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFWKJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 06:09:57 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36014 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230031AbhFWKJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 06:09:55 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15NA6wKJ015075;
        Wed, 23 Jun 2021 10:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=ewkNgiDCeist8wg1hpa5RS49GBeyP6cC/nbwp3IopYM=;
 b=kctPgj5jAElYGXM6Uk5dCVI7VoDOSn/KV/Nhi5+JfWWyJiJErGy48HCiLht+HA0XcHpj
 9Lut1b3H4E8Vj72Wlj5NLOPywmYW4PvsttEdDIYQy4VcjptD/2ATsX8wSzmHwNqv13eo
 Qij2jopoW0UAbfTpw1C46SyD7HZzk5f9pqoQdGpe8aZ8g8pZvAOcMs7Ua0WH3gH8cB9a
 D05WKgDKj7hknKx3Am2Z1O0OMF0TXH5fLT0O0q8dJR+M0zt3RumCV3UhY80NCJGfOmJg
 /h+DWyolSMmOn7srl2AXdRxxkOLsBIGnkMr3OzR9DIMQt7frxyqyaVubY/0Q7dljW+LO ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39c2wng033-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 10:07:34 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15NA5T7k017908;
        Wed, 23 Jun 2021 10:07:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 3998d8wm2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 10:07:33 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15NA7XK1023670;
        Wed, 23 Jun 2021 10:07:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 3998d8wm2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 10:07:33 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15NA7T6m028890;
        Wed, 23 Jun 2021 10:07:29 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jun 2021 03:07:29 -0700
Date:   Wed, 23 Jun 2021 13:07:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Chuck Lever <chuck.lever@oracle.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: net/sunrpc/xprtrdma/frwr_ops.c:647 frwr_unmap_async() error:
 potentially dereferencing uninitialized 'last'.
Message-ID: <202106231840.ECkPJRDx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: PLs-kkyNdMCUuNXmL-EoJGgKFuJ8YN9N
X-Proofpoint-ORIG-GUID: PLs-kkyNdMCUuNXmL-EoJGgKFuJ8YN9N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0c18f29aae7ce3dadd26d8ee3505d07cc982df75
commit: e10fa96d347488d1fd278e84f52ba7b25067cc71 xprtrdma: Move cqe to struct rpcrdma_mr
config: x86_64-randconfig-m001-20210622 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
net/sunrpc/xprtrdma/frwr_ops.c:647 frwr_unmap_async() error: potentially dereferencing uninitialized 'last'.

Old smatch warnings:
net/sunrpc/xprtrdma/frwr_ops.c:546 frwr_unmap_sync() error: potentially dereferencing uninitialized 'last'.

vim +/last +647 net/sunrpc/xprtrdma/frwr_ops.c

d8099feda4833b Chuck Lever 2019-06-19  608  void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
d8099feda4833b Chuck Lever 2019-06-19  609  {
d8099feda4833b Chuck Lever 2019-06-19  610  	struct ib_send_wr *first, *last, **prev;
5ecef9c8436695 Chuck Lever 2020-11-09  611  	struct rpcrdma_ep *ep = r_xprt->rx_ep;
d8099feda4833b Chuck Lever 2019-06-19  612  	struct rpcrdma_frwr *frwr;
d8099feda4833b Chuck Lever 2019-06-19  613  	struct rpcrdma_mr *mr;
d8099feda4833b Chuck Lever 2019-06-19  614  	int rc;
d8099feda4833b Chuck Lever 2019-06-19  615  
d8099feda4833b Chuck Lever 2019-06-19  616  	/* Chain the LOCAL_INV Work Requests and post them with
d8099feda4833b Chuck Lever 2019-06-19  617  	 * a single ib_post_send() call.
d8099feda4833b Chuck Lever 2019-06-19  618  	 */
d8099feda4833b Chuck Lever 2019-06-19  619  	frwr = NULL;
d8099feda4833b Chuck Lever 2019-06-19  620  	prev = &first;
265a38d4611360 Chuck Lever 2019-08-19  621  	while ((mr = rpcrdma_mr_pop(&req->rl_registered))) {

Is it possible for the ->rl_registered list to be empty?  If not, then
just ignore this email.

d8099feda4833b Chuck Lever 2019-06-19  622  
d8099feda4833b Chuck Lever 2019-06-19  623  		trace_xprtrdma_mr_localinv(mr);
d8099feda4833b Chuck Lever 2019-06-19  624  		r_xprt->rx_stats.local_inv_needed++;
d8099feda4833b Chuck Lever 2019-06-19  625  
d8099feda4833b Chuck Lever 2019-06-19  626  		frwr = &mr->frwr;
d8099feda4833b Chuck Lever 2019-06-19  627  		last = &frwr->fr_invwr;
d8099feda4833b Chuck Lever 2019-06-19  628  		last->next = NULL;
e10fa96d347488 Chuck Lever 2021-04-19  629  		last->wr_cqe = &mr->mr_cqe;
d8099feda4833b Chuck Lever 2019-06-19  630  		last->sg_list = NULL;
d8099feda4833b Chuck Lever 2019-06-19  631  		last->num_sge = 0;
d8099feda4833b Chuck Lever 2019-06-19  632  		last->opcode = IB_WR_LOCAL_INV;
d8099feda4833b Chuck Lever 2019-06-19  633  		last->send_flags = IB_SEND_SIGNALED;
d8099feda4833b Chuck Lever 2019-06-19  634  		last->ex.invalidate_rkey = mr->mr_handle;
d8099feda4833b Chuck Lever 2019-06-19  635  
e10fa96d347488 Chuck Lever 2021-04-19  636  		last->wr_cqe->done = frwr_wc_localinv;
e10fa96d347488 Chuck Lever 2021-04-19  637  
d8099feda4833b Chuck Lever 2019-06-19  638  		*prev = last;
d8099feda4833b Chuck Lever 2019-06-19  639  		prev = &last->next;
d8099feda4833b Chuck Lever 2019-06-19  640  	}
d8099feda4833b Chuck Lever 2019-06-19  641  
d8099feda4833b Chuck Lever 2019-06-19  642  	/* Strong send queue ordering guarantees that when the
d8099feda4833b Chuck Lever 2019-06-19  643  	 * last WR in the chain completes, all WRs in the chain
d8099feda4833b Chuck Lever 2019-06-19  644  	 * are complete. The last completion will wake up the
d8099feda4833b Chuck Lever 2019-06-19  645  	 * RPC waiter.
d8099feda4833b Chuck Lever 2019-06-19  646  	 */
e10fa96d347488 Chuck Lever 2021-04-19 @647  	last->wr_cqe->done = frwr_wc_localinv_done;

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

