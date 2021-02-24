Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D413241F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhBXQRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbhBXQOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:14:08 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179CDC061788
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:13:23 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id l2so1772264pgb.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3FZdsf6XJR67eODXmbRF6cVAh1XeOXuhlF5t976l7j4=;
        b=nyplz0egG1ZE6DKF+WBViBtTmkq57r1y4/WrOJRBP+zvNdbtVL9ro3/gUhjk0t3EJY
         knieBe+/Zqqj8EyI75aZuwydHXn6/glZ4/NlhqzvSo9H8u4iKqSh7t4ojxe7AORg7iTJ
         /tC7QLdPHHMFfdbQSsap88uhtwzjmh5GO555zmW9OTIGAdEPhWlTHeDmgzZXbKyxndlf
         jrBS9ld1Bv9+TQTaYtkHFsND+dClH/HUtywBlAxWI9i+8AwTmDoT5RTjInZwdqvKzgbd
         uRUmF6COHLQ8XGrIpBKuqD9KCaT40tl0Hpc/jaU0GIVGvkY91YUyjyylU1wB7VEZIF9i
         oFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3FZdsf6XJR67eODXmbRF6cVAh1XeOXuhlF5t976l7j4=;
        b=Krnfb5/yumsbiVDl0vra+oscC6OyIlEl5R86iOdTadhaFQLzSMZ0CA06S5RYJLz7lh
         3me0jtgcpZ5BXfoHiqXT1MmyWbp4uPPk1i6cV8T9oOJIw4p4FIGe5LMH66Q8uSUJqQS5
         crtiN3IjZzJBFuQ5L8nYBya8YOpzYIRsBUw+eMDAt6YfWsYxfq8tR1Hn6o19V8jdCK7b
         /zBTslK/CaIu3sU6JYJf6TWAT4TfOF4c1u0z8jlySIRfxeFjR4YFPTMpzi1v0IZ98+2E
         MbJDvQDUNkEMOT9V8ObD/bsLQYW+K8RvgzLwxM/CSWwmXb8QN8NpRuLH+jPiQhnQ/wcs
         o8CA==
X-Gm-Message-State: AOAM530BZskdwvIFStbVFqQCxpiHs9iVOI2bpIdWSuDkop+8gWCnOfHA
        7fnOkIsRvUy2xIye/UcZrmjCQg==
X-Google-Smtp-Source: ABdhPJx/DJXPG0XU6qb5mGGFjx1HgwHMwaiQcD3TQBk61ZFy/l3KG8Z04RbBxc7j/J8XkKrY4wuSew==
X-Received: by 2002:a63:4e26:: with SMTP id c38mr3861088pgb.81.1614183202598;
        Wed, 24 Feb 2021 08:13:22 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id v4sm3054021pff.156.2021.02.24.08.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 08:13:22 -0800 (PST)
Date:   Wed, 24 Feb 2021 09:13:19 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Split Coresight decode by aux records
Message-ID: <20210224161319.GA3495326@xps15>
References: <20210212144513.31765-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212144513.31765-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good day James,

I have received your patchset and added it to my queue.  On the flip side it
will be 3 to 4 weeks (from today) before I get a chance to look at it.  As such
I suggest you don't wait on me before addressing the issues found by Leo.

Thanks,
Mathieu

On Fri, Feb 12, 2021 at 04:45:06PM +0200, James Clark wrote:
> Hi All,
> 
> Since my previous RFC, I've fixed --per-thread mode and solved
> most of the open questions. I've also changed --dump-raw-trace
> to use the same code path so it's also working now.
> 
> I think the only open questions are:
>   * General approach
>   * If aux records need to be saved, or if they can be pulled
>     from elsewhere.
> 
> I've also tested perf inject which is now working with troublesome
> files.
> 
> Thanks
> James
> 
> James Clark (7):
>   perf cs-etm: Split up etm queue setup function
>   perf cs-etm: Only search timestamp in current sample's queue.
>   perf cs-etm: Save aux records in each etm queue
>   perf cs-etm: don't process queues until cs_etm__flush_events
>   perf cs-etm: split decode by aux records.
>   perf cs-etm: Use existing decode code path for --dump-raw-trace
>   perf cs-etm: Suppress printing when resetting decoder
> 
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  10 +-
>  tools/perf/util/cs-etm.c                      | 300 ++++++++++--------
>  2 files changed, 168 insertions(+), 142 deletions(-)
> 
> -- 
> 2.28.0
> 
