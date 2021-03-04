Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03C232C926
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 02:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355861AbhCDBD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 20:03:59 -0500
Received: from z11.mailgun.us ([104.130.96.11]:34272 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347083AbhCDA1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 19:27:39 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1614817635; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=uE9hP3j3+L0cujvmr8lHFtYLXiD1MZIk/QBrVFBYt6k=;
 b=TjQYx52jzR7NjT3NYGxOwNnnkbQ/2kw5cZpalseYh+vBrtgbgS8nT9VyBnlEJbeTWhnvqkMB
 zBtZoKC3zIHNYr3p3LB9Nkejkj5gL8dsHCCsfi3pY3jfM1AQJfXJwhEop5sdDmgPTTtINS4/
 MDhE02EjgNNLxTaiW4xfR1i2qr4=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 60402963cb774affa981c1d1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 Mar 2021 00:27:15
 GMT
Sender: abhinavk=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BB109C5514A; Thu,  4 Mar 2021 00:27:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: abhinavk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 439A1C58A25;
        Thu,  4 Mar 2021 00:27:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 03 Mar 2021 16:27:12 -0800
From:   abhinavk@codeaurora.org
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Rob Clark <robdclark@chromium.org>
Subject: Re: drivers/gpu/drm/msm/dp/dp_debug.c:218 dp_debug_init() warn:
 passing zero to 'PTR_ERR'
In-Reply-To: <20210301071431.GO2087@kadam>
References: <20210301071431.GO2087@kadam>
Message-ID: <cb25d69c78e9bb754bd76701c9253f44@codeaurora.org>
X-Sender: abhinavk@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan

Thanks for reporting this, will submit a change to fix this.

Abhinav

On 2021-02-28 23:14, Dan Carpenter wrote:
> tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master
> head:   fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8
> commit: d11a93690df7e9a7e07c0784ecad019a627b1449 drm/msm/dp: add
> debugfs support to DP driver
> config: arm64-randconfig-m031-20210301 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> New smatch warnings:
> drivers/gpu/drm/msm/dp/dp_debug.c:218 dp_debug_init() warn: passing
> zero to 'PTR_ERR'
> 
> Old smatch warnings:
> drivers/gpu/drm/msm/dp/dp_debug.c:227 dp_debug_init() warn: passing
> zero to 'PTR_ERR'
> 
> vim +/PTR_ERR +218 drivers/gpu/drm/msm/dp/dp_debug.c
> 
> d11a93690df7e9 Abhinav Kumar 2020-09-12  209  static int
> dp_debug_init(struct dp_debug *dp_debug)
> d11a93690df7e9 Abhinav Kumar 2020-09-12  210  {
> d11a93690df7e9 Abhinav Kumar 2020-09-12  211  	int rc = 0;
> d11a93690df7e9 Abhinav Kumar 2020-09-12  212  	struct dp_debug_private
> *debug = container_of(dp_debug,
> d11a93690df7e9 Abhinav Kumar 2020-09-12  213  			struct
> dp_debug_private, dp_debug);
> d11a93690df7e9 Abhinav Kumar 2020-09-12  214  	struct dentry *dir, 
> *file;
> d11a93690df7e9 Abhinav Kumar 2020-09-12  215
> d11a93690df7e9 Abhinav Kumar 2020-09-12  216  	dir =
> debugfs_create_dir(DEBUG_NAME, NULL);
> d11a93690df7e9 Abhinav Kumar 2020-09-12  217  	if (IS_ERR_OR_NULL(dir)) 
> {
> d11a93690df7e9 Abhinav Kumar 2020-09-12 @218  		rc = PTR_ERR(dir);
> d11a93690df7e9 Abhinav Kumar 2020-09-12  219  		DRM_ERROR("[%s]
> debugfs create dir failed, rc = %d\n",
> d11a93690df7e9 Abhinav Kumar 2020-09-12  220  				  DEBUG_NAME, rc);
> d11a93690df7e9 Abhinav Kumar 2020-09-12  221  		goto error;
> 
> Debugfs function never return NULL, but actually debugfs functions
> aren't supposed to be checked in the normal case (the abnormal case is
> where you are trying to dereference "dir" and "file" within the driver
> itself, so it doesn't apply here).
> 
> So then the function becomes a lot simpler, if it's written in the
> canonical way.  This should probably be documented better in the
> Documentation/filesystems/debugfs.rst file...  :/
> 
> static void dp_debug_init(struct dp_debug *dp_debug)
> {
> 	struct dp_debug_private *debug = container_of(dp_debug,
> 						      struct dp_debug_private, dp_debug);
> 
> 	debug->root = debugfs_create_dir(DEBUG_NAME, NULL);
> 	debugfs_create_file("dp_debug", 0444, dir, debug, &dp_debug_fops);
> }
> 
> d11a93690df7e9 Abhinav Kumar 2020-09-12  222  	}
> d11a93690df7e9 Abhinav Kumar 2020-09-12  223
> d11a93690df7e9 Abhinav Kumar 2020-09-12  224  	file =
> debugfs_create_file("dp_debug", 0444, dir,
> d11a93690df7e9 Abhinav Kumar 2020-09-12  225  			debug, 
> &dp_debug_fops);
> d11a93690df7e9 Abhinav Kumar 2020-09-12  226  	if 
> (IS_ERR_OR_NULL(file)) {
> d11a93690df7e9 Abhinav Kumar 2020-09-12  227  		rc = PTR_ERR(file);
> d11a93690df7e9 Abhinav Kumar 2020-09-12  228  		DRM_ERROR("[%s]
> debugfs create file failed, rc=%d\n",
> d11a93690df7e9 Abhinav Kumar 2020-09-12  229  				  DEBUG_NAME, rc);
> d11a93690df7e9 Abhinav Kumar 2020-09-12  230  		goto error_remove_dir;
> d11a93690df7e9 Abhinav Kumar 2020-09-12  231  	}
> d11a93690df7e9 Abhinav Kumar 2020-09-12  232
> d11a93690df7e9 Abhinav Kumar 2020-09-12  233  	debug->root = dir;
> d11a93690df7e9 Abhinav Kumar 2020-09-12  234  	return rc;
> d11a93690df7e9 Abhinav Kumar 2020-09-12  235   error_remove_dir:
> d11a93690df7e9 Abhinav Kumar 2020-09-12  236  	debugfs_remove(dir);
> d11a93690df7e9 Abhinav Kumar 2020-09-12  237   error:
> d11a93690df7e9 Abhinav Kumar 2020-09-12  238  	return rc;
> d11a93690df7e9 Abhinav Kumar 2020-09-12  239  }
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
