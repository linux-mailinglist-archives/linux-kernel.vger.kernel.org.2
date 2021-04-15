Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED79436139A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 22:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbhDOUiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 16:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbhDOUiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 16:38:01 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D97C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 13:37:37 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id p67so11911453pfp.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 13:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vObk5zpfxMuIbD3QrtDnjfXIj3YNa+wCetzq4YqI/Ys=;
        b=jFuHk7s+f9q7wrY3o3n5mT6FaLvMYQsuXRb9E4r2sVuVSavAoOQE97qyAqwGwSHPjL
         cxyNkCn51HFKKfiQg4YuflgIVh/sU+5/TJTLTNXy88r4eCREQ6yOPW5iVGc8/M1UwFNf
         dNotMU2eu0pi6gYuk5WEDtEIrI2ef5JDgprKeTwKMurZg4MMlt0Cq58NToqv7Xne0En6
         SstFDcQUu2WaoGHmxixsZJ1E5O/3RQN77l22m4uYjtIMP7D4k4kFrNkhGjh+amrlo/Gn
         WsW/ETiiioEpndHSdUOzl+M6mEAkWVPCz+/YMErQnbXH4vx6UNXfNHGDarQis8Kjkooz
         TQjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vObk5zpfxMuIbD3QrtDnjfXIj3YNa+wCetzq4YqI/Ys=;
        b=V7A40mxxn0+/AYI+IpIcWp6KA2M/NBGBGmt7LO/OGztfTpQ1hltx/IVRe6jE0zRzZb
         S5yquauLxLVimuOfoTl4y8B5RYIVDWmg0YLIAadNQJGo5D8p6mQcZKSow/ineEHyVHI8
         K/wSngVjclEwG94exKx4i8HM3i8HbWHSnCADfLYPhOzpgjvCZEiZEQari4D5cVQdl21u
         vRjS5VlBfR4vpzyIU74/d2ji7huvpiCEtLbkH5EMuKRmjEiojHg1n7YHVdUSqxVfJWVz
         6StMZE7z4/uaneTadYSKxRtDuv4rEV+bezTqCtlbJb0b9lsYyv2XCTKT2QEUcGnflrXH
         qgmQ==
X-Gm-Message-State: AOAM533NylNH9izmHpzu4LJyUvrVpTE5lry4VKG3T4XK+34OMgQc/4Qp
        qLmiikDQuSVn1IdL4oZ+bxpYKg==
X-Google-Smtp-Source: ABdhPJyfg2R+ssZa5r6cIL/CR4EUg2vTi5YKkIspyQJx2qSZYuKvfHn4PzCtsx/al20OzOj0WXdsGg==
X-Received: by 2002:a63:fb15:: with SMTP id o21mr5024855pgh.337.1618519056848;
        Thu, 15 Apr 2021 13:37:36 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id g18sm2828703pfb.178.2021.04.15.13.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 13:37:30 -0700 (PDT)
Date:   Thu, 15 Apr 2021 14:37:28 -0600
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
Message-ID: <20210415203728.GD937505@xps15>
References: <20210212144513.31765-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212144513.31765-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

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

This patchset is now at the top of the coresight review list.  I suggest you
rebase this on top of your two timestamp related patches and send another
revision.
 
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
