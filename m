Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A5B4212EB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 17:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235842AbhJDPpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 11:45:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22815 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235275AbhJDPpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 11:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633362201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ly4r/34bmILip5ZiID87hvZ8ITCLaIHuFra8lBUJoX4=;
        b=Y6BXGzXLQFAVdhULGfyGSphYCP9ppCMEESVPS4VzpY+NkBk6vIwqj4RjIsZ5KqA14GE8Qx
        vTLQ6xYrRdE8o4elQiYSY364mB+b5iLUGNWyFA5ido5CCPg5WlTwLT7eprNM6Dk2GtHYxs
        lf+yPLKHFdx49h3kCO2OQ9wEvCbYang=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-533-2-qRzhH_NPKb-nymldaDnQ-1; Mon, 04 Oct 2021 11:43:03 -0400
X-MC-Unique: 2-qRzhH_NPKb-nymldaDnQ-1
Received: by mail-wr1-f71.google.com with SMTP id r21-20020adfa155000000b001608162e16dso4252067wrr.15
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 08:43:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ly4r/34bmILip5ZiID87hvZ8ITCLaIHuFra8lBUJoX4=;
        b=mK3g8DywTjYNsxnCLGVAziDfMof1Uz+iI2VQOQKsoB6GBbXyLEJEXJfXHENL8hFwg4
         BMidQZqf8Fxaj3/JuU58YyT86QtrR+W35+tTI4bbvyOVmmcTnUe34laMk+E0N33tJqaa
         nzjjbxosQEtLDpgPW5pySbSdm0fp1VK7Hmj6tV4Mmbo9USsn4d2A4xzD0La7uvHs43Ig
         NP90qVN5Avk2hO/WS1U+KyCsqUxYsUMI89oCou/FCFfQRF46kwhI2hs0YQjcdfgwiL5L
         ofGejvKHdCfGNMTkVbNh5cTTDEqs57ycHMHMT0vyZVs7XQF0R1yudP67+Z+7AwV/BvSW
         1Hgw==
X-Gm-Message-State: AOAM530gsMsgojoyw8ne1TmiO9BdqW9UwIlMSopw3Tp02S7HuSD95sXk
        bUEt3fWg8jZRInM+9u2KVy/t7wpwuuShw8jPMI/NAHdU3wqlSf2W8vUUwf2I88FI+xSwCV9bBah
        2JXmZWEpFUpLxQbDxpF7MUFgL
X-Received: by 2002:a1c:2d6:: with SMTP id 205mr19092986wmc.48.1633362179146;
        Mon, 04 Oct 2021 08:42:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvVdCO9+tQVLBwMEaQbski8TndlK5YXfGMMiOGyoUzzbGJcAc6zeuM/PnUgFRqv5ltQR+ehA==
X-Received: by 2002:a1c:2d6:: with SMTP id 205mr19092966wmc.48.1633362178857;
        Mon, 04 Oct 2021 08:42:58 -0700 (PDT)
Received: from krava (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id y10sm4722840wrw.5.2021.10.04.08.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 08:42:58 -0700 (PDT)
Date:   Mon, 4 Oct 2021 17:42:56 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, linux-kernel@vger.kernel.org, ak@linux.intel.com
Subject: Re: [PATCH] perf tests attr: Support Topdown metrics events
Message-ID: <YVshAMbqreNnGVnj@krava>
References: <1633031566-176517-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1633031566-176517-1-git-send-email-kan.liang@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 12:52:46PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> The Topdown metrics events were added as perf stat default events since
> commit 42641d6f4d15 ("perf stat: Add Topdown metrics events as default
> events"). However, the perf attr tests were not updated accordingly.
> 
> The perf attr test fails on the platform which supports Topdown metrics.
> perf test 17
> 17: Setup struct perf_event_attr                        :FAILED!
> 
> Add Topdown metrics events into perf attr test cases. Make them optional
> since they are only available on newer platforms.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Fixes: 42641d6f4d15 ("perf stat: Add Topdown metrics events as default events")
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka

> ---
>  tools/perf/tests/attr/test-stat-default    |  97 +++++++++++++++++++
>  tools/perf/tests/attr/test-stat-detailed-1 | 113 ++++++++++++++++++++--
>  tools/perf/tests/attr/test-stat-detailed-2 | 137 +++++++++++++++++++++++----
>  tools/perf/tests/attr/test-stat-detailed-3 | 145 ++++++++++++++++++++++++-----
>  4 files changed, 440 insertions(+), 52 deletions(-)
> 
> diff --git a/tools/perf/tests/attr/test-stat-default b/tools/perf/tests/attr/test-stat-default
> index d9e99b3..d8ea6a8 100644
> --- a/tools/perf/tests/attr/test-stat-default
> +++ b/tools/perf/tests/attr/test-stat-default
> @@ -68,3 +68,100 @@ fd=10
>  type=0
>  config=5
>  optional=1
> +
> +# PERF_TYPE_RAW / slots (0x400)
> +[event11:base-stat]
> +fd=11
> +group_fd=-1
> +type=4
> +config=1024
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-retiring (0x8000)
> +[event12:base-stat]
> +fd=12
> +group_fd=11
> +type=4
> +config=32768
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> +[event13:base-stat]
> +fd=13
> +group_fd=11
> +type=4
> +config=33024
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> +[event14:base-stat]
> +fd=14
> +group_fd=11
> +type=4
> +config=33280
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> +[event15:base-stat]
> +fd=15
> +group_fd=11
> +type=4
> +config=33536
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> +[event16:base-stat]
> +fd=16
> +group_fd=11
> +type=4
> +config=33792
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> +[event17:base-stat]
> +fd=17
> +group_fd=11
> +type=4
> +config=34048
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> +[event18:base-stat]
> +fd=18
> +group_fd=11
> +type=4
> +config=34304
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> +[event19:base-stat]
> +fd=19
> +group_fd=11
> +type=4
> +config=34560
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> diff --git a/tools/perf/tests/attr/test-stat-detailed-1 b/tools/perf/tests/attr/test-stat-detailed-1
> index 8b04a05..b656ab9 100644
> --- a/tools/perf/tests/attr/test-stat-detailed-1
> +++ b/tools/perf/tests/attr/test-stat-detailed-1
> @@ -70,12 +70,109 @@ type=0
>  config=5
>  optional=1
>  
> +# PERF_TYPE_RAW / slots (0x400)
> +[event11:base-stat]
> +fd=11
> +group_fd=-1
> +type=4
> +config=1024
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-retiring (0x8000)
> +[event12:base-stat]
> +fd=12
> +group_fd=11
> +type=4
> +config=32768
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> +[event13:base-stat]
> +fd=13
> +group_fd=11
> +type=4
> +config=33024
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> +[event14:base-stat]
> +fd=14
> +group_fd=11
> +type=4
> +config=33280
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> +[event15:base-stat]
> +fd=15
> +group_fd=11
> +type=4
> +config=33536
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> +[event16:base-stat]
> +fd=16
> +group_fd=11
> +type=4
> +config=33792
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> +[event17:base-stat]
> +fd=17
> +group_fd=11
> +type=4
> +config=34048
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> +[event18:base-stat]
> +fd=18
> +group_fd=11
> +type=4
> +config=34304
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> +[event19:base-stat]
> +fd=19
> +group_fd=11
> +type=4
> +config=34560
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
>  # PERF_TYPE_HW_CACHE /
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event11:base-stat]
> -fd=11
> +[event20:base-stat]
> +fd=20
>  type=3
>  config=0
>  optional=1
> @@ -84,8 +181,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event12:base-stat]
> -fd=12
> +[event21:base-stat]
> +fd=21
>  type=3
>  config=65536
>  optional=1
> @@ -94,8 +191,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event13:base-stat]
> -fd=13
> +[event22:base-stat]
> +fd=22
>  type=3
>  config=2
>  optional=1
> @@ -104,8 +201,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event14:base-stat]
> -fd=14
> +[event23:base-stat]
> +fd=23
>  type=3
>  config=65538
>  optional=1
> diff --git a/tools/perf/tests/attr/test-stat-detailed-2 b/tools/perf/tests/attr/test-stat-detailed-2
> index 4fca9f1..9762509 100644
> --- a/tools/perf/tests/attr/test-stat-detailed-2
> +++ b/tools/perf/tests/attr/test-stat-detailed-2
> @@ -70,12 +70,109 @@ type=0
>  config=5
>  optional=1
>  
> +# PERF_TYPE_RAW / slots (0x400)
> +[event11:base-stat]
> +fd=11
> +group_fd=-1
> +type=4
> +config=1024
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-retiring (0x8000)
> +[event12:base-stat]
> +fd=12
> +group_fd=11
> +type=4
> +config=32768
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> +[event13:base-stat]
> +fd=13
> +group_fd=11
> +type=4
> +config=33024
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> +[event14:base-stat]
> +fd=14
> +group_fd=11
> +type=4
> +config=33280
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> +[event15:base-stat]
> +fd=15
> +group_fd=11
> +type=4
> +config=33536
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> +[event16:base-stat]
> +fd=16
> +group_fd=11
> +type=4
> +config=33792
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> +[event17:base-stat]
> +fd=17
> +group_fd=11
> +type=4
> +config=34048
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> +[event18:base-stat]
> +fd=18
> +group_fd=11
> +type=4
> +config=34304
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> +[event19:base-stat]
> +fd=19
> +group_fd=11
> +type=4
> +config=34560
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
>  # PERF_TYPE_HW_CACHE /
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event11:base-stat]
> -fd=11
> +[event20:base-stat]
> +fd=20
>  type=3
>  config=0
>  optional=1
> @@ -84,8 +181,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event12:base-stat]
> -fd=12
> +[event21:base-stat]
> +fd=21
>  type=3
>  config=65536
>  optional=1
> @@ -94,8 +191,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event13:base-stat]
> -fd=13
> +[event22:base-stat]
> +fd=22
>  type=3
>  config=2
>  optional=1
> @@ -104,8 +201,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event14:base-stat]
> -fd=14
> +[event23:base-stat]
> +fd=23
>  type=3
>  config=65538
>  optional=1
> @@ -114,8 +211,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event15:base-stat]
> -fd=15
> +[event24:base-stat]
> +fd=24
>  type=3
>  config=1
>  optional=1
> @@ -124,8 +221,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event16:base-stat]
> -fd=16
> +[event25:base-stat]
> +fd=25
>  type=3
>  config=65537
>  optional=1
> @@ -134,8 +231,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event17:base-stat]
> -fd=17
> +[event26:base-stat]
> +fd=26
>  type=3
>  config=3
>  optional=1
> @@ -144,8 +241,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event18:base-stat]
> -fd=18
> +[event27:base-stat]
> +fd=27
>  type=3
>  config=65539
>  optional=1
> @@ -154,8 +251,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event19:base-stat]
> -fd=19
> +[event28:base-stat]
> +fd=28
>  type=3
>  config=4
>  optional=1
> @@ -164,8 +261,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event20:base-stat]
> -fd=20
> +[event29:base-stat]
> +fd=29
>  type=3
>  config=65540
>  optional=1
> diff --git a/tools/perf/tests/attr/test-stat-detailed-3 b/tools/perf/tests/attr/test-stat-detailed-3
> index 4bb58e1..d555042 100644
> --- a/tools/perf/tests/attr/test-stat-detailed-3
> +++ b/tools/perf/tests/attr/test-stat-detailed-3
> @@ -70,12 +70,109 @@ type=0
>  config=5
>  optional=1
>  
> +# PERF_TYPE_RAW / slots (0x400)
> +[event11:base-stat]
> +fd=11
> +group_fd=-1
> +type=4
> +config=1024
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-retiring (0x8000)
> +[event12:base-stat]
> +fd=12
> +group_fd=11
> +type=4
> +config=32768
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-bad-spec (0x8100)
> +[event13:base-stat]
> +fd=13
> +group_fd=11
> +type=4
> +config=33024
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-fe-bound (0x8200)
> +[event14:base-stat]
> +fd=14
> +group_fd=11
> +type=4
> +config=33280
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-be-bound (0x8300)
> +[event15:base-stat]
> +fd=15
> +group_fd=11
> +type=4
> +config=33536
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-heavy-ops (0x8400)
> +[event16:base-stat]
> +fd=16
> +group_fd=11
> +type=4
> +config=33792
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-br-mispredict (0x8500)
> +[event17:base-stat]
> +fd=17
> +group_fd=11
> +type=4
> +config=34048
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-fetch-lat (0x8600)
> +[event18:base-stat]
> +fd=18
> +group_fd=11
> +type=4
> +config=34304
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
> +# PERF_TYPE_RAW / topdown-mem-bound (0x8700)
> +[event19:base-stat]
> +fd=19
> +group_fd=11
> +type=4
> +config=34560
> +disabled=0
> +enable_on_exec=0
> +read_format=15
> +optional=1
> +
>  # PERF_TYPE_HW_CACHE /
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event11:base-stat]
> -fd=11
> +[event20:base-stat]
> +fd=20
>  type=3
>  config=0
>  optional=1
> @@ -84,8 +181,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event12:base-stat]
> -fd=12
> +[event21:base-stat]
> +fd=21
>  type=3
>  config=65536
>  optional=1
> @@ -94,8 +191,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event13:base-stat]
> -fd=13
> +[event22:base-stat]
> +fd=22
>  type=3
>  config=2
>  optional=1
> @@ -104,8 +201,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_LL                 <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event14:base-stat]
> -fd=14
> +[event23:base-stat]
> +fd=23
>  type=3
>  config=65538
>  optional=1
> @@ -114,8 +211,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event15:base-stat]
> -fd=15
> +[event24:base-stat]
> +fd=24
>  type=3
>  config=1
>  optional=1
> @@ -124,8 +221,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1I                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event16:base-stat]
> -fd=16
> +[event25:base-stat]
> +fd=25
>  type=3
>  config=65537
>  optional=1
> @@ -134,8 +231,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event17:base-stat]
> -fd=17
> +[event26:base-stat]
> +fd=26
>  type=3
>  config=3
>  optional=1
> @@ -144,8 +241,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_DTLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event18:base-stat]
> -fd=18
> +[event27:base-stat]
> +fd=27
>  type=3
>  config=65539
>  optional=1
> @@ -154,8 +251,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event19:base-stat]
> -fd=19
> +[event28:base-stat]
> +fd=28
>  type=3
>  config=4
>  optional=1
> @@ -164,8 +261,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_ITLB               <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_READ            <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event20:base-stat]
> -fd=20
> +[event29:base-stat]
> +fd=29
>  type=3
>  config=65540
>  optional=1
> @@ -174,8 +271,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_ACCESS      << 16)
> -[event21:base-stat]
> -fd=21
> +[event30:base-stat]
> +fd=30
>  type=3
>  config=512
>  optional=1
> @@ -184,8 +281,8 @@ optional=1
>  #  PERF_COUNT_HW_CACHE_L1D                <<  0  |
>  # (PERF_COUNT_HW_CACHE_OP_PREFETCH        <<  8) |
>  # (PERF_COUNT_HW_CACHE_RESULT_MISS        << 16)
> -[event22:base-stat]
> -fd=22
> +[event31:base-stat]
> +fd=31
>  type=3
>  config=66048
>  optional=1
> -- 
> 2.7.4
> 

