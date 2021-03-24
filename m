Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54E934793C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhCXNFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:05:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234685AbhCXNF0 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:05:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5290619E5;
        Wed, 24 Mar 2021 13:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616591121;
        bh=uDDm+TukW5vKhS7zq2XEdeNoAuZyplo/MAOIwTiB+UE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UL/hZiDrYb2UVWZjWWBGdhCerbTMrf7Ysi9sGVXNnhXusbFVW34hwAFg/WQaPGGoH
         aRxxV4TINgz5bzsj1td1yJnu5ezrDUFCJLaI+EaLRKABOrHmJwY/86Gcbt5WPuNJm6
         XO7SgCi4PdJAPolBsvzPSbcJ8tS2aZt6sJ2VX1a5/Dm2MZ4/ZIanrj8NaL/Xde+Z5c
         YMv1pw/eDkE5+apaJRvzshO38xywVLBGIClwk/5Ao/ktqu3yaWR+HO/tGPfNQzYo8m
         ZmPLRXeICuWKIPp8CRcBT11hFs44L3BSUtaLbTLGgrpI/6/eE0JyWPNdNZppWj2iTQ
         PsW3cPbunG6/A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C38CA40647; Wed, 24 Mar 2021 10:05:18 -0300 (-03)
Date:   Wed, 24 Mar 2021 10:05:18 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 2/2] perf test: Add CVS summary test
Message-ID: <YFs5DvUwtwblghqc@kernel.org>
References: <20210319070156.20394-1-yao.jin@linux.intel.com>
 <20210319070156.20394-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319070156.20394-2-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 19, 2021 at 03:01:56PM +0800, Jin Yao escreveu:
> The patch "perf stat: Align CSV output for summary mode" aligned
> CVS output and added "summary" to the first column of summary
> lines.
> 
> Now we check if the "summary" string is added to the CVS output.
> 
> If we set '--no-cvs-summary' option, the "summary" string would
> not be added, also check with this case.

You mixed up cvs with csv in various places, I'm fixing it up...

- Arnaldo
 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  v3:
>    - New in v3.
>  
>  tools/perf/tests/shell/stat+cvs_summary.sh | 31 ++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100755 tools/perf/tests/shell/stat+cvs_summary.sh
> 
> diff --git a/tools/perf/tests/shell/stat+cvs_summary.sh b/tools/perf/tests/shell/stat+cvs_summary.sh
> new file mode 100755
> index 000000000000..dd14f2ce7f6b
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat+cvs_summary.sh
> @@ -0,0 +1,31 @@
> +#!/bin/sh
> +# perf stat cvs summary test
> +# SPDX-License-Identifier: GPL-2.0
> +
> +set -e
> +
> +#
> +#     1.001364330 9224197  cycles 8012885033 100.00
> +#         summary 9224197  cycles 8012885033 100.00
> +#
> +perf stat -e cycles  -x' ' -I1000 --interval-count 1 --summary 2>&1 | \
> +grep -e summary | \
> +while read summary num event run pct
> +do
> +	if [ $summary != "summary" ]; then
> +		exit 1
> +	fi
> +done
> +
> +#
> +#     1.001360298 9148534  cycles 8012853854 100.00
> +#9148534  cycles 8012853854 100.00
> +#
> +perf stat -e cycles  -x' ' -I1000 --interval-count 1 --summary --no-cvs-summary 2>&1 | \
> +grep -e summary | \
> +while read num event run pct
> +do
> +	exit 1
> +done
> +
> +exit 0
> -- 
> 2.17.1
> 

-- 

- Arnaldo
