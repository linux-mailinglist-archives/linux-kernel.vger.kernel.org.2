Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE8D13B1A29
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 14:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhFWMa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Jun 2021 08:30:56 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36954 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231336AbhFWMaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jun 2021 08:30:30 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15NCCAHv019382;
        Wed, 23 Jun 2021 12:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=E/rZF6f/E1j3A2n1P6pKXv312XOIRxH+4M3jl3gzcXg=;
 b=Rh3iCHZ836i/QMvrrsAMY8emsUCWt1OK0HzMy0NrN/F4f3Celhs97ycqwy3SALZyfg/1
 cwTSVWyf+1y6tky1y52MinJVsWbKIQvwmQdAKzUwWysZx11yx6MNdRuOW/hV/zxy9y0Q
 P9aOTO1mlcueCQSDI59dU9C5yFnHYK5iaxtuICANjG3Xa8Yk4Gb0J+Pe5mT5LVjkEPGR
 DemyYCjzh74xwvzDViD/neZ/XyecfsFBU/CxMeFXR17N96y2tX5GHU2RVBLBddPOE98q
 iWE6y7cN2xD6Ew+5Cr77KiMb6ESaaMQ8tBWdQ0/oX62CCHwgEivu7n/l2xQ3e5Z5gWb1 ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39aqqvwqx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 12:28:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15NCFHPN025458;
        Wed, 23 Jun 2021 12:28:09 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3995py66j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 12:28:09 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15NCS8l3064004;
        Wed, 23 Jun 2021 12:28:08 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3995py66hv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jun 2021 12:28:08 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15NCS4U0007448;
        Wed, 23 Jun 2021 12:28:04 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jun 2021 05:28:03 -0700
Date:   Wed, 23 Jun 2021 15:27:57 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "kbuild@lists.01.org" <kbuild@lists.01.org>,
        kernel test robot <lkp@intel.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: Re: net/sunrpc/xprtrdma/frwr_ops.c:647 frwr_unmap_async() error:
 potentially dereferencing uninitialized 'last'.
Message-ID: <20210623122756.GB2094@kadam>
References: <202106231840.ECkPJRDx-lkp@intel.com>
 <AAA93115-ABDD-44DA-9784-B8A001E9CEC5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAA93115-ABDD-44DA-9784-B8A001E9CEC5@oracle.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: ghOfa99bWbv9CnQn-6TM7BsGh81Z1BKB
X-Proofpoint-GUID: ghOfa99bWbv9CnQn-6TM7BsGh81Z1BKB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 03:20:10PM +0300, Chuck Lever III wrote:
> Howdy Dan!
> 
> > On Jun 23, 2021, at 6:07 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   0c18f29aae7ce3dadd26d8ee3505d07cc982df75
> > commit: e10fa96d347488d1fd278e84f52ba7b25067cc71 xprtrdma: Move cqe to struct rpcrdma_mr
> > config: x86_64-randconfig-m001-20210622 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > New smatch warnings:
> > net/sunrpc/xprtrdma/frwr_ops.c:647 frwr_unmap_async() error: potentially dereferencing uninitialized 'last'.
> > 
> > Old smatch warnings:
> > net/sunrpc/xprtrdma/frwr_ops.c:546 frwr_unmap_sync() error: potentially dereferencing uninitialized 'last'.
> > 
> > vim +/last +647 net/sunrpc/xprtrdma/frwr_ops.c
> > 
> > d8099feda4833b Chuck Lever 2019-06-19  608  void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
> > d8099feda4833b Chuck Lever 2019-06-19  609  {
> > d8099feda4833b Chuck Lever 2019-06-19  610  	struct ib_send_wr *first, *last, **prev;
> > 5ecef9c8436695 Chuck Lever 2020-11-09  611  	struct rpcrdma_ep *ep = r_xprt->rx_ep;
> > d8099feda4833b Chuck Lever 2019-06-19  612  	struct rpcrdma_frwr *frwr;
> > d8099feda4833b Chuck Lever 2019-06-19  613  	struct rpcrdma_mr *mr;
> > d8099feda4833b Chuck Lever 2019-06-19  614  	int rc;
> > d8099feda4833b Chuck Lever 2019-06-19  615  
> > d8099feda4833b Chuck Lever 2019-06-19  616  	/* Chain the LOCAL_INV Work Requests and post them with
> > d8099feda4833b Chuck Lever 2019-06-19  617  	 * a single ib_post_send() call.
> > d8099feda4833b Chuck Lever 2019-06-19  618  	 */
> > d8099feda4833b Chuck Lever 2019-06-19  619  	frwr = NULL;
> > d8099feda4833b Chuck Lever 2019-06-19  620  	prev = &first;
> > 265a38d4611360 Chuck Lever 2019-08-19  621  	while ((mr = rpcrdma_mr_pop(&req->rl_registered))) {
> > 
> > Is it possible for the ->rl_registered list to be empty?
> 
> The one and only call site for frwr_unmap_async() in in rpcrdma_reply_handler():
> 
> 1483         if (!list_empty(&req->rl_registered))
> 1484                 frwr_unmap_async(r_xprt, req);
> 1485                 /* LocalInv completion will complete the RPC */
> 1486         else
> 1487                 kref_put(&req->rl_kref, rpcrdma_reply_done);
> 
> 
> > If not, then just ignore this email.
> 
> I seem to recall smatch catching this problem before. Is there a way
> to annotate frwr_unmap_async() to calm smatch's nerves?

In theory, if you have the cross function DB built then it's not
supposed to print this warning.  But in reality it does.  The data is
stored correctly in DB, but it's not used correctly.  Huh...  I will
investigate.

I don't think the kbuild bot uses the cross function DB, but it only
sends the warning once so who cares.

regards,
dan carpenter

