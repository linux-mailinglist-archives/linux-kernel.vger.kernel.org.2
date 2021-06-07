Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614B739D793
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 10:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFGIm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 04:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhFGImZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 04:42:25 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C3DC061766;
        Mon,  7 Jun 2021 01:40:25 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id q6so8422658qvb.2;
        Mon, 07 Jun 2021 01:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=Gqfcx7MMX4ha2LKkgjhOiUBKHhgwQx6KDDCCsIrUgZU=;
        b=GjaPxKmzKDPnVhCAofZcL+gkEnpV0/IMVajsYB7vWEQxpG2pPoTWUolMbY24dUwvH2
         iVh/y8CJjoa11A9m2p9GW2gsPNXyj7/u2IeYFgYDCcq5QIGh5taJ/Ez4qSSpiMJVlja4
         cgg1nt6qQdF1yH+Pwk8w6fPJ5TXhVWP4TmhwXFTQ3Fs/LOfPeggczeeTvWR2d11NjiRq
         2HKy1yyTilFIRKvZ2Fkmg1fO9f/dMLdroxfmcprp7SjtAszGau12h8lzZjZQs1B4Uc74
         Tq/s0vjyonZP+0Ne8zxUPyT3E6wtTH9PHVyBinlfARrPhvb60g7IYdBUJHLsAoTbQeM/
         N+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=Gqfcx7MMX4ha2LKkgjhOiUBKHhgwQx6KDDCCsIrUgZU=;
        b=JJd5NP22WyMEzHFlZW9e0yzms5XuBz6/fT6C3QPtnEXcuYynHbZQV1+5KAsgLd8Pd0
         vSbm1uwkTGWa4vlf87wFXUDHY3qYffCh29WPO6rD09UJFDvEpxHjJFM8+XqrV+jZeKhO
         aUg8R5CWKxPh+NrHNdBrQzOPqed5tk3ErimAfCd9Mefg4QMkt7DlMFbxTwApzQslnpcW
         nmJXLrnwAZy/doOK45qguusQMU3K/K9mjGMSrGiiU3fYnmRgwb/7Ycb7lgKbxQQEgB3/
         JIl9qPYHpskzHkVYvFckHKTH7pa1ehjDtZZJaa1XWf3MXF8Dt0HYCmeBR0gfeMIJM3MP
         1gLg==
X-Gm-Message-State: AOAM5327lFg4BkLu+SvylDPt3VJ6lRUWPO3rtya4k5CLvdVpXP8qDhAw
        q11tY2mn8+XnBWeLC5X5IAM=
X-Google-Smtp-Source: ABdhPJxzU9LINypXWHqu6BJOeLCjEzA6ggZHcJcyrTv/W0zBhQXZ+wr2E+0r+V4xvCA59ChcJd513g==
X-Received: by 2002:a05:6214:11ac:: with SMTP id u12mr16644617qvv.15.1623055224084;
        Mon, 07 Jun 2021 01:40:24 -0700 (PDT)
Received: from localhost.localdomain (ec2-35-169-212-159.compute-1.amazonaws.com. [35.169.212.159])
        by smtp.gmail.com with ESMTPSA id x10sm2895496qkf.42.2021.06.07.01.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 01:40:23 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
X-Google-Original-From: SeongJae Park <sjpark@amazon.de>
To:     sj38.park@gmail.com
Cc:     jgowans@amazon.com, akpm@linux-foundation.org,
        SeongJae Park <sjpark@amazon.de>, Jonathan.Cameron@Huawei.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        amit@kernel.org, benh@kernel.crashing.org,
        brendanhiggins@google.com, corbet@lwn.net, david@redhat.com,
        dwmw@amazon.com, elver@google.com, fan.du@intel.com,
        foersleo@amazon.de, greg@kroah.com, gthelen@google.com,
        guoju.fgj@alibaba-inc.com, mgorman@suse.de, minchan@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org,
        riel@surriel.com, rientjes@google.com, rostedt@goodmis.org,
        rppt@kernel.org, shakeelb@google.com, shuah@kernel.org,
        snu@zelle79.org, vbabka@suse.cz, vdavydov.dev@gmail.com,
        zgf574564920@gmail.com, linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 10/13] mm/damon/schemes: Activate schemes based on a watermarks mechanism
Date:   Mon,  7 Jun 2021 08:40:15 +0000
Message-Id: <20210607084015.1620-1-sjpark@amazon.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210531133816.12689-11-sj38.park@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sjpark@amazon.de>

On Mon, 31 May 2021 13:38:13 +0000 sj38.park@gmail.com wrote:

> From: SeongJae Park <sjpark@amazon.de>
> 
> DAMON-based operation schemes need to be manually turned on and off.  In
> some use cases, however, the condition for turning a scheme on and off
> would depend on the system's situation.  For example, schemes for
> proactive pages reclamation would need to be turned on when some memory
> pressure is detected, and turned off when the system has enough free
> memory.
> 
> For easier control of schemes activation based on the system situation,
> this commit introduces a watermarks-based mechanism.  The client can
> describe the watermark metric (e.g., amount of free memory in the
> system), watermark check interval, and three watermarks, namely high,
> mid, and low.  If the scheme is deactivated, it only gets the metric and
> compare that to the three watermarks for every check interval.  If the
> metric is higher than the high watermark, the scheme is deactivated.  If
> the metric is between the mid watermark and the low watermark, the
> scheme is activated.  If the metric is lower than the low watermark, the
> scheme is deactivated again.  This is to allow users fall back to
> traditional page-granularity mechanisms.
> 
> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  include/linux/damon.h | 52 +++++++++++++++++++++++++-
>  mm/damon/core.c       | 87 ++++++++++++++++++++++++++++++++++++++++++-
>  mm/damon/dbgfs.c      |  5 ++-
>  3 files changed, 141 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 565f49d8ba44..2edd84e98056 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -127,6 +127,45 @@ struct damos_speed_limit {
>  	unsigned int min_score;
>  };
[...]
>  static void set_kdamond_stop(struct damon_ctx *ctx)
>  {
>  	mutex_lock(&ctx->kdamond_lock);
> @@ -904,6 +982,13 @@ static int kdamond_fn(void *data)
>  	sz_limit = damon_region_sz_limit(ctx);
>  
>  	while (!kdamond_need_stop(ctx)) {
> +		unsigned long wmark_wait_us = kdamond_wmark_wait_us(ctx);
> +
> +		if (wmark_wait_us) {
> +			usleep_range(wmark_wait_us, wmark_wait_us + 1);
> +			continue;
> +		}

James Gowans (jgowans@amazon.com) found this will make kdamond sleeps in
TASK_UNINTERRUPTIBLE state.  So, when DAMON is deactivated due to the
watermarks rule, the sysadmin assumes it would do nothing and DAMON really do
nothing.  But, because it's sleeping in TASK_UNINTERRUPTIBLE state, which is
usually interpreted as waiting for I/O, '/proc/loadavg' like monitors will
report I/O loads, so that the sysadmin get confused.

In the next version of this RFC patchset, I will make this to use
'schedule_timeout_interruptible()' instead, if 'wmark_wait_us' is larger than
100ms.  I will continue using 'usleep_range()' for small sleep time, to keep
the precision high.


Thanks,
SeongJae Park

[...]
