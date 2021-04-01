Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8806A351EFB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 20:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbhDAStz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 14:49:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54452 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbhDAS3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 14:29:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131E5M7T049686;
        Thu, 1 Apr 2021 14:07:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=sLK6zOQHnZG1HuSVK798EHRmx5dU8oG3uqDFjbJ8k9k=;
 b=p95oI/MXpGa4RWfw7jwz9i6Y2vPGL/mqCNwYID/ttPesJOa3VCNCOGbMFuy3mNclUowI
 IWIwOb7JnAVxyg+gNRSG52YbWS1QVBhbSPq6YfBDQGZs4g/LU0aRwDxJkg9va7m+Gtao
 NxswtjoqtmMRXrUfgg0xnRS5eYWainecn4UhyP7YQYdSLrmBxz6cn+TPKCPkcqi9cXVX
 9b2WiyMtJNUuLz3N+7LvJMNZZV9UxXP4eo9XLcRi8cQcEAU/K9BfZTGNAcDRlRA8XccW
 rKPqgh2i3WxlGMGrL7SBVLHWFbIpzXiK1UblsL2s5vn5Q5FMxN2IpTwilyjCLdvgpP96 ag== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37n30s9vp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 14:07:04 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131E5C4j181433;
        Thu, 1 Apr 2021 14:07:01 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 37n2aba69n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 14:07:01 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 131E6xkH025904;
        Thu, 1 Apr 2021 14:07:00 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 01 Apr 2021 07:06:59 -0700
Date:   Thu, 1 Apr 2021 17:06:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     kbusch@kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [bug report] node: Add memory-side caching attributes
Message-ID: <20210401140652.GT2088@kadam>
References: <YGWLtzMLqSW4cxma@mwanda>
 <20210401112511.GV1463678@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401112511.GV1463678@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010097
X-Proofpoint-GUID: lwzVbBSNsusYUcK1odCVGCUw-mL-2FAv
X-Proofpoint-ORIG-GUID: lwzVbBSNsusYUcK1odCVGCUw-mL-2FAv
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 mlxscore=0 spamscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 01, 2021 at 08:25:11AM -0300, Jason Gunthorpe wrote:
> On Thu, Apr 01, 2021 at 12:00:39PM +0300, Dan Carpenter wrote:
> > Hi Keith,
> > 
> > I've been trying to figure out ways Smatch can check for device managed
> > resources.  Like adding rules that if we call dev_set_name(&foo->bar)
> > then it's device managaged and if there is a kfree(foo) without calling
> > device_put(&foo->bar) then that's a resource leak.
> 
> It seems to be working from what I can see

This check is actually more simple, and older.  It just looks for

	device_register(dev);
	...
	kfree(dev);

I've written your proposed check of:

	device_register(&foo->dev);
	...
	kfree(foo); // warning missing device_put(&foo->dev);

But I just did that earler today and it will probably take a couple
iterations to work out the kinks.  Plus I'm off for a small vacation so
it will be a week before I have the results from that.

> 
> Also I wasn't able to convince myself that any locking around
> node->cache_attrs exist..
> 
> > Of course one of the rules is that if you call device_register(dev) then
> > you can't kfree(dev), it has to released with device_put(dev) and that's
> > true even if the register fails.  But this code here feels very
> > intentional so maybe there is an exception to the rule?
> 
> There is no exception. Open coding this:
> 
> >    282  free_name:
> >    283          kfree_const(dev->kobj.name);
> 
> To avoid leaking memory from dev_set_name is a straight up layering
> violation, WTF?
> 
> node_cacheinfo_release() is just kfree(), so there is no need.
> Instead (please feel free to send this Dan):

Sure, I can send this (tomorrow).

> 
> diff --git a/drivers/base/node.c b/drivers/base/node.c
> index f449dbb2c74666..89c28952863977 100644
> --- a/drivers/base/node.c
> +++ b/drivers/base/node.c
> @@ -319,25 +319,24 @@ void node_add_cache(unsigned int nid, struct node_cache_attrs *cache_attrs)
>  		return;
>  
>  	dev = &info->dev;
> +	device_initialize(dev)
>  	dev->parent = node->cache_dev;
>  	dev->release = node_cacheinfo_release;
>  	dev->groups = cache_groups;
>  	if (dev_set_name(dev, "index%d", cache_attrs->level))

Is calling dev_set_name() without doing a device_initialize() a bug?  I
could write a check for that.

regards,
dan carpenter

