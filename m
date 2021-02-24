Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFBA324696
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 23:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbhBXWVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 17:21:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:55398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234147AbhBXWVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 17:21:18 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 094F064E05;
        Wed, 24 Feb 2021 22:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614205238;
        bh=S2yZyBOFkSePiXlAXkn4okVjIDCQjqacx6ZRgMYxcHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E9K3QJgsVNhzUx+7v/HZmyGGeVUyRuEDBbto7+MSwReE3SQWABZnwNC3UGFjlUeet
         DqgoPaqu05uD+SkfGUq9H86k+10lMgZ3X9PCNKXyeVhYeYbORos+iRc3FBuShXMHGg
         8n2Qg8lzYnEh5XK2FTeatPq6jnUC+qiPKWsw9eBBq8ElNmKrm7nyV10hCaGdXWISdZ
         AUnmdE5O8XkhFs+L93vqLpyu9Igph6j7r1As04/yBP3iZhJE8p7ooV4PYpZe7kIit8
         AA7RV56U60xgXdLVylHxZgcmt42DmJgdIzjiBvEZ3gCpxkO60HZ3dpTt0DoYIvJHKq
         6aQuKpgRyuCWg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6D2B140CD9; Wed, 24 Feb 2021 19:20:36 -0300 (-03)
Date:   Wed, 24 Feb 2021 19:20:36 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     mike.leach@linaro.org, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] coresight: Patches for v5.12 (perf tools)
Message-ID: <YDbRNJemiGQrHNIP@kernel.org>
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

Sure, I'll go thru them, hopefully we'll get it in v5.12-rc1.

Thanks,

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
