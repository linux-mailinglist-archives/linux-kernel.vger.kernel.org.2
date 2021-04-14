Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7343E35F640
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 16:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348098AbhDNOeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 10:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhDNOdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 10:33:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5E5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:33:31 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h4so11076392wrt.12
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 07:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AzPqofie8S4/307Q+JGBaV3nZF2oRY+QG7tGoCslWTQ=;
        b=ivyUGSCJW5Oy1agUXb7fQ8fZhQZScSHy8gATp63BlLsR3lVPvuGQC6BSPIsbHt1SDC
         QA44D5Mt97NMbOcepbctxZ/ep8vVpl3gbk8Eq0kQ0cKiK0GK9Vd3KFkXkZl9giCmJ3Dc
         Kj4UWWb/1BIKUee373nLQW5zNVnPvtsYrJVsBcc3a0l1ZVGlUIAGRMvE9jOfGyjzi9XT
         6+ZSSwZKO7F1PizRlYcp5Lk0dI2IvxMKc5W7KdQl0L0PtZ+cjkHfynFd411DdOemi07l
         Nwphbh53+QQwhXyfM47uLidp3NQDXCsbO5u25Ic9VHwbU3aqnEktLR/jMwAyzfbLwrY0
         LIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AzPqofie8S4/307Q+JGBaV3nZF2oRY+QG7tGoCslWTQ=;
        b=RPJD0yI09U8MTnorwAtQyS3qpGpjVcIm/zdvuBqC8MtKhFvhu5C8upNugA5/hAePe0
         8aI0nGmbfTqNY2PVXK64zvPqeA4BJbmi+VOtSlyCpI47cvnmRjMuqT2rnzWNIEyS1lGp
         AaI70HwMFPfWtq/lKs9mKPwbKMKlC+A+BHqppQTNtHtkhpkwucLn7NhPuorKi2PdgSde
         X6+X1FRpPCMdTmCqrwuilFpTeWPHkIAJAWl0neViHBlaWJvkIqF1yOjYbE5tnWDrlbVU
         ADXCc+Yh2r/1copA43OouH4Ov2tY/33ojSxgAem2j6B607Q0y2mu39Nj5m5C+oNykgEu
         YhkQ==
X-Gm-Message-State: AOAM533/+lSTd5byEolxEzieDVFVUlJMasD+xV7CIAGDFxB+34sqawDm
        MhlNzDR6+WL/VhHZLcAhdLiv9XyKgBxX8A==
X-Google-Smtp-Source: ABdhPJyRVzD3Z+5b7I/zBSA9W6qxTsY3tbyLXEmBAfTs6fnuwlE7a/7DMZmkZPSIZWCajX5vFmwgKw==
X-Received: by 2002:a05:6000:18ab:: with SMTP id b11mr42497602wri.403.1618410808267;
        Wed, 14 Apr 2021 07:33:28 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:15:13:4051:8ddb:9de4:c1bb])
        by smtp.gmail.com with ESMTPSA id v7sm22682913wrs.2.2021.04.14.07.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 07:33:27 -0700 (PDT)
Date:   Wed, 14 Apr 2021 16:33:22 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, kernel test robot <lkp@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [peterz-queue:perf/core 18/22] kernel/events/core.c:6418:22:
 sparse: sparse: incorrect type in assignment (different address spaces)
Message-ID: <YHb9Mi1IwY5qtJxp@elver.google.com>
References: <202104142209.hLOfOONR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202104142209.hLOfOONR-lkp@intel.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 14, 2021 at 10:10PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/core
> head:   0da503cd07380952599b67ded6efe030d78ea42d
> commit: c7d4112e9f0e69edd649665836ce72008b95ab9f [18/22] perf: Add support for SIGTRAP on perf events
[...]
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
[...]
>   6416		info.si_errno = event->attr.type;
>   6417		info.si_perf = event->attr.sig_data;
> > 6418		info.si_addr = (void *)event->sig_addr;
>   6419		force_sig_info(&info);

I think it wants the below (feel free to squash into "perf: Add support
for SIGTRAP on perf events").

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Wed, 14 Apr 2021 16:26:26 +0200
Subject: [PATCH] perf: Fix cast to void __user pointer

sparse let us know that si_addr is 'void __user *', therefore add the
missing __user attribute to the cast.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1d2077389c0c..2677438ed668 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6414,7 +6414,7 @@ static void perf_sigtrap(struct perf_event *event)
 	info.si_code = TRAP_PERF;
 	info.si_errno = event->attr.type;
 	info.si_perf = event->attr.sig_data;
-	info.si_addr = (void *)event->sig_addr;
+	info.si_addr = (void __user *)event->sig_addr;
 	force_sig_info(&info);
 }
 
-- 
2.31.1.295.g9ea45b61b8-goog

