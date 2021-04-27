Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4619036CB9C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 21:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238618AbhD0TZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 15:25:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:35618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235563AbhD0TY4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 15:24:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4BBC1613F4;
        Tue, 27 Apr 2021 19:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619551452;
        bh=nUcQgzFrXvLoVtK/WRCzyBpanEbNK+FnqFAf7DNEjAI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oCoF92ZD0vmnpPGehs99wLLmyfTRZaH2The2kM/kUSKxqXLzu/gzh66botWAq7hI7
         kA441SThV0hQ6YsBkSMzM1cI6vuZJdHJuaVBvyfvK7JN3McZfB5KQ5m1myTBIeCCYr
         qW7AQzCS0N3TFYsVq0FP1wMV4OOeM+e/Dizb2E/aSWz9WKwaK37Y81petnRbHTrHPN
         ocmBPtqbLjK7EkltmlUopYf2/5R+vvd55a7lqHDI1iHhjBIqw62i1N4Civuzi19CUS
         HvOZDw7xrEdjDWKC1EQ5YTzLTjwC48ITIoQdLqT0zoXpRyzbpgXQHr+f7pTMYaO3iP
         KHPBtWNYqZ1+A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 978FB40647; Tue, 27 Apr 2021 16:24:09 -0300 (-03)
Date:   Tue, 27 Apr 2021 16:24:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v6 01/26] tools headers uapi: Update tools's copy of
 linux/perf_event.h
Message-ID: <YIhk2XkvUcoIPbgc@kernel.org>
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
 <20210427070139.25256-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427070139.25256-2-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 27, 2021 at 03:01:14PM +0800, Jin Yao escreveu:
> To get the changes in:
> 
> Liang Kan's patch
> [PATCH V6 21/25] perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
> 
> Kan's patch is upstreamed yet but perf/core branch doesn't have it
> at this moment. But next perf tool patches need this interface for
> hybrid support.
> 
> This patch can be removed after Kan's patch is merged in perf/core
> branch.

Nope, it is already in tip/perf/core as:

  55bcf6ef314ae8ba ("perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE")

And your patch, the one below, shouldn't include the kernel file, i.e. include/uapi/linux/perf_event.h
as tooling only uses the one in tools/include/uapi/linux/perf_event.h.

Leave the perf tool build warning there, as soon as both acme/perf/core
and tip/perf/core hit torvalds/master, all gets solved.

So I'm removing it here in addition to updating the commit log message.

Ah good news, the test builds passed in all my test build containers.

I'll refresh tmp.perf/core once I update these messages, etc. So that we
can continue from there in case you need to respin a v7.

Thanks,

- Arnaldo.


 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
> v6:
>  - No update.
> 
> v5:
>  - Update the commit message to mention that Kan's patch is
>    upstreamed but not merged to perf/core branch.
> 
> v4:
>  - Updated by Kan's latest patch,
>    '[PATCH V6 21/25] perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE'
> 
>  include/uapi/linux/perf_event.h       | 15 +++++++++++++++
>  tools/include/uapi/linux/perf_event.h | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> index ad15e40d7f5d..14332f4cf816 100644
> --- a/include/uapi/linux/perf_event.h
> +++ b/include/uapi/linux/perf_event.h
> @@ -37,6 +37,21 @@ enum perf_type_id {
>  	PERF_TYPE_MAX,				/* non-ABI */
>  };
>  
> +/*
> + * attr.config layout for type PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
> + * PERF_TYPE_HARDWARE:			0xEEEEEEEE000000AA
> + *					AA: hardware event ID
> + *					EEEEEEEE: PMU type ID
> + * PERF_TYPE_HW_CACHE:			0xEEEEEEEE00DDCCBB
> + *					BB: hardware cache ID
> + *					CC: hardware cache op ID
> + *					DD: hardware cache op result ID
> + *					EEEEEEEE: PMU type ID
> + * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
> + */
> +#define PERF_PMU_TYPE_SHIFT		32
> +#define PERF_HW_EVENT_MASK		0xffffffff
> +
>  /*
>   * Generalized performance event event_id types, used by the
>   * attr.event_id parameter of the sys_perf_event_open()
> diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> index ad15e40d7f5d..14332f4cf816 100644
> --- a/tools/include/uapi/linux/perf_event.h
> +++ b/tools/include/uapi/linux/perf_event.h
> @@ -37,6 +37,21 @@ enum perf_type_id {
>  	PERF_TYPE_MAX,				/* non-ABI */
>  };
>  
> +/*
> + * attr.config layout for type PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE
> + * PERF_TYPE_HARDWARE:			0xEEEEEEEE000000AA
> + *					AA: hardware event ID
> + *					EEEEEEEE: PMU type ID
> + * PERF_TYPE_HW_CACHE:			0xEEEEEEEE00DDCCBB
> + *					BB: hardware cache ID
> + *					CC: hardware cache op ID
> + *					DD: hardware cache op result ID
> + *					EEEEEEEE: PMU type ID
> + * If the PMU type ID is 0, the PERF_TYPE_RAW will be applied.
> + */
> +#define PERF_PMU_TYPE_SHIFT		32
> +#define PERF_HW_EVENT_MASK		0xffffffff
> +
>  /*
>   * Generalized performance event event_id types, used by the
>   * attr.event_id parameter of the sys_perf_event_open()
> -- 
> 2.17.1
> 

-- 

- Arnaldo
