Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5AE3A9529
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 10:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbhFPIkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 04:40:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:24410 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231318AbhFPIke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 04:40:34 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15G8Zbks028128;
        Wed, 16 Jun 2021 08:38:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=1gflDtV265seh+MHrLlcgWdJG8g8fxQjYrRcYA0G8kk=;
 b=tNEp+KB31FAmNvawbO0ZYGFSv9YLdjgeaXzI+GzqdEbYYHOxYpMU6gM267k6pbgDmkho
 9xpnwJM3ytRunbCGUv00U9EDg4u8llULjR2dgsio0xcj8OnNbH7TEBkS4ndlDjx4bca7
 gGdFUMmjguE3WfxJankVvceVRgp3zn4Hcvs3BWob/Lx6ooOMDUQSY6E147VDa491Bjew
 yw+O4Htwo+EEYfLYy1U41eXjADCd4Xwkr6qEqLjwQub3La3SQoalJYW76fLz0y8ZVmt5
 8MNERP2sroRfUtRb1gCHBOaLsWArz29SXGeweDfLlVo+8INuuSskZxLqgZi5M/ZSLiEI Cw== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 396tjdsqg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 08:38:23 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 15G8aE0x162476;
        Wed, 16 Jun 2021 08:38:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 396wanj7u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 08:38:22 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15G8cLLd166760;
        Wed, 16 Jun 2021 08:38:21 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 396wanj7t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Jun 2021 08:38:21 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 15G8c9E3018177;
        Wed, 16 Jun 2021 08:38:09 GMT
Received: from kadam (/41.212.42.34)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Jun 2021 08:38:08 +0000
Date:   Wed, 16 Jun 2021 11:37:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     Thomas Hellstr <C3@mwanda>, B6@mwanda,
        m <thomas.hellstrom@linux.intel.com>,
        Huang Rui <ray.huang@amd.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/ttm: fix error handling in ttm_bo_handle_move_mem()
Message-ID: <20210616083758.GC1901@kadam>
References: <YMmadPwv8C+Ut1+o@mwanda>
 <03d0b798-d1ab-5b6f-2c27-8140d923d445@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <03d0b798-d1ab-5b6f-2c27-8140d923d445@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: goOkPdFG9ndrNJUlbPLkAgpvhrm8v5Nh
X-Proofpoint-GUID: goOkPdFG9ndrNJUlbPLkAgpvhrm8v5Nh
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 08:46:33AM +0200, Christian König wrote:
> Sending the first message didn't worked, so let's try again.
> 
> Am 16.06.21 um 08:30 schrieb Dan Carpenter:
> > There are three bugs here:
> > 1) We need to call unpopulate() if ttm_tt_populate() succeeds.
> > 2) The "new_man = ttm_manager_type(bdev, bo->mem.mem_type);" assignment
> >     was wrong and it was really assigning "new_mem = old_mem;".  There
> >     is no need for this assignment anyway as we already have the value
> >     for "new_mem".
> > 3) The (!new_man->use_tt) condition is reversed.
> > 
> > Fixes: ba4e7d973dd0 ("drm: Add the TTM GPU memory manager subsystem.")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > ---
> > This is from reading the code and I can't swear that I have understood
> > it correctly.  My nouveau driver is currently unusable and this patch
> > has not helped.  But hopefully if I fix enough bugs eventually it will
> > start to work.
> 
> Well NAK, the code previously looked quite well and you are breaking it now.
> 
> What's the problem with nouveau?
> 

The new Firefox seems to excersize nouveau more than the old one so
when I start 10 firefox windows it just hangs the graphics.

I've added debug code and it seems like the problem is that
nv50_mem_new() is failing.


> >   drivers/gpu/drm/ttm/ttm_bo.c | 14 ++++++++------
> >   1 file changed, 8 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
> > index ebcffe794adb..72dde093f754 100644
> > --- a/drivers/gpu/drm/ttm/ttm_bo.c
> > +++ b/drivers/gpu/drm/ttm/ttm_bo.c
> > @@ -180,12 +180,12 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
> >   		 */
> >   		ret = ttm_tt_create(bo, old_man->use_tt);
> >   		if (ret)
> > -			goto out_err;
> > +			return ret;
> >   		if (mem->mem_type != TTM_PL_SYSTEM) {
> >   			ret = ttm_tt_populate(bo->bdev, bo->ttm, ctx);
> >   			if (ret)
> > -				goto out_err;
> > +				goto err_destroy;
> >   		}
> >   	}
> > @@ -193,15 +193,17 @@ static int ttm_bo_handle_move_mem(struct ttm_buffer_object *bo,
> >   	if (ret) {
> >   		if (ret == -EMULTIHOP)
> >   			return ret;
> > -		goto out_err;
> > +		goto err_unpopulate;
> >   	}
> >   	ctx->bytes_moved += bo->base.size;
> >   	return 0;
> > -out_err:
> > -	new_man = ttm_manager_type(bdev, bo->mem.mem_type);
> 
> This here switches new and old manager. E.g. the new_man is now pointing to
> the existing resource manager.

Why not just use "old_man" instead of basically the equivalent to
"new_man = old_man"?  Can the old_man change part way through the
function?

regards,
dan carpenter

