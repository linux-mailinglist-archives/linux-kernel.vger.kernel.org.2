Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A350F32A68F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1575648AbhCBPWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:22:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:57020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1447268AbhCBMvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:51:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BA2364F67;
        Tue,  2 Mar 2021 12:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614689466;
        bh=snWlFecSozN/+Z1SVMxPp6ymMP4eIR8ctYaRZQ3bRpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gr08070vY3h2zkwgpsY6qRtgbr9hA3a8uwOr2xjLjtPBy+sRCGGlrEIoF+TFL9Etx
         z9dRnBJThhZpccyWdwUjUXQ+t8FJWZbxKo3S8gIKru2jX6zOxwGFHp2/OkKzKYhnhh
         Cfpqh8gElzWwu6wuxFlJwRV8Zczha2M7IKOt0V2llEitnBcwCet1ktqIVjttYI3hog
         DmoLYTuo0gM3I7DsYTmlPuR8ZtigMdJlXIB6BSZDGG+GSviPUcA+NjnQ2NCQXjvAkB
         CSLGL5QkbZdO/UwvQwInDeQK1zJKGwSa3NofUPbMjiRMZ0k0kSgkbiJPr8lG8LteSL
         c+k2Jn6LwP2Ag==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2173840CD9; Tue,  2 Mar 2021 09:51:04 -0300 (-03)
Date:   Tue, 2 Mar 2021 09:51:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] coresight: Patches for v5.12 (perf tools)
Message-ID: <YD40uOBoDxHhKzNb@kernel.org>
References: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210224164835.3497311-1-mathieu.poirier@linaro.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 24, 2021 at 09:48:29AM -0700, Mathieu Poirier escreveu:
> Good day Arnaldo,
> 
> I noticed there is a couple of patchsets [1][2] that haven't made it
> to your tree for the coming v5.12 cycle.  Do you think that can still
> be done? 

Thanks, applied, unfortunately the window is closed and I missed
processing these in time, so it'll make v5.13, sorry.

- Arnaldo
 
> I tallied the patches here to make it easier for you to pick up.
> 
> Applies cleanly on perf/core (84b7725536d8)
> 
> Thanks,
> Mathieu
> 
> [1]. https://lore.kernel.org/lkml/20210202214040.32349-1-mike.leach@linaro.org/
> [2]. https://lore.kernel.org/lkml/20210213113220.292229-1-leo.yan@linaro.org/
> 
> Leo Yan (2):
>   tools headers UAPI: Update tools' copy of linux/coresight-pmu.h
>   perf cs-etm: Add helper cs_etm__get_pid_fmt()
> 
> Mike Leach (1):
>   perf: cs-etm: update ETM metadata format
> 
> Suzuki K Poulose (3):
>   perf cs-etm: Fix bitmap for option
>   perf cs-etm: Support PID tracing in config
>   perf cs-etm: Detect pid in VMID for kernel running at EL2
> 
>  tools/include/linux/coresight-pmu.h           |  20 +-
>  tools/perf/arch/arm/util/cs-etm.c             |  76 +++--
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  38 ++-
>  tools/perf/util/cs-etm.c                      | 277 +++++++++++++++---
>  tools/perf/util/cs-etm.h                      |  31 +-
>  5 files changed, 368 insertions(+), 74 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 

- Arnaldo
