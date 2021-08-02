Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29033DD625
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 14:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhHBM6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 08:58:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232629AbhHBM6Q (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:58:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C29560E09;
        Mon,  2 Aug 2021 12:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627909087;
        bh=3nRIOCHIQMck4hhnlunp2JWBMRr1XL9Ld88U9Zvw+GM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FddZZEUgEbQKH54AgrclVRRzOyILA9eXNtvrijWuCejs1dB83JHSlCAaF4VZDLH7s
         T0cZ2qVZ+ch2rBC+gHJpH3s/Iu1hQs1eWXcchhHrCMdI5YJSerQJyZl7ja1Js2LXIF
         NuPGtPklfSn1rfDpdRNs08OZoZ4q40+TPuGtEQV9GZQ2rD1OuHgXQ+ccx4gUTz58hZ
         binyT9JrX/TLBBtntG/Fe2TVV1bbD8ndEXvipjYu2CV1swfeeSuSgNlmr55W7A3xe9
         YazVJ3ToheKvomPMRvUBangf1GBlUu9v30fIdX4XRpg9D6JA0ehTU8YsgacUyQFgwU
         mnE5OwRG74cng==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EB71D403F2; Mon,  2 Aug 2021 09:58:04 -0300 (-03)
Date:   Mon, 2 Aug 2021 09:58:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 0/2] perf vendor events intel: Add core events and
 metrics for Elkhartlake
Message-ID: <YQfr3NFtOH3tu5ZV@kernel.org>
References: <20210802053440.21035-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802053440.21035-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 02, 2021 at 01:34:38PM +0800, Jin Yao escreveu:
> Add JSON events and metrics for Elkhartlake to perf.
> 
> Based on JSON list v1.02:
> 
> https://download.01.org/perfmon/EHL/

Thanks, applied.

- Arnaldo

 
> v2:
> ---
> Based on JSON list v1.02.
> Patchset is based on tmp.perf/core branch.
> 
> v1:
> ---
> Based on JSON list v1.01
> 
> Jin Yao (2):
>   perf vendor events intel: Add core event list for Elkhartlake
>   perf vendor events intel: Add basic metrics for Elkhartlake
> 
>  .../arch/x86/elkhartlake/cache.json           | 226 ++++++++++
>  .../arch/x86/elkhartlake/ehl-metrics.json     |  57 +++
>  .../arch/x86/elkhartlake/floating-point.json  |  24 +
>  .../arch/x86/elkhartlake/frontend.json        |  93 ++++
>  .../arch/x86/elkhartlake/memory.json          |  86 ++++
>  .../arch/x86/elkhartlake/other.json           | 424 ++++++++++++++++++
>  .../arch/x86/elkhartlake/pipeline.json        | 278 ++++++++++++
>  .../arch/x86/elkhartlake/virtual-memory.json  | 273 +++++++++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   1 +
>  9 files changed, 1462 insertions(+)
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/ehl-metrics.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/floating-point.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/frontend.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/elkhartlake/virtual-memory.json
> 
> -- 
> 2.17.1
> 

-- 

- Arnaldo
