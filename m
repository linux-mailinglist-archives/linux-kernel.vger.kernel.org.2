Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEAC93FBE2C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbhH3V10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:27:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:50702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237570AbhH3V1E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:27:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 17E2060525;
        Mon, 30 Aug 2021 21:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630358770;
        bh=cwTDsHGL0uCYft5qpdHjbNIwp0MPLb/NeC4IlzXPbNo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OMD/Bldtwbh0cz/ugaAzy2JQL4ouL+iaip75YWkIFQ8b+5yOX9e/Sm7s9m0CO0S35
         f4wSUfenfLbeIIHKb/WHUGRD4vI5x8vqGqR1CacYIkeP5cIFUBxb5v5xSzxVIXAkPd
         SL4U5Oe9cI+FWcIc79vcLiOe3p/if2utElIM1AtJ3KOzAcBlP+j6F0gk+Drzyb3JBl
         C0bclGwPCDDS/p+QLwg249mQJGwBQzFIIXgYJxxpEpDwAVoLdTTpUc73I/LlaVqbiD
         UREItm5+4jmn30vushExlpp7P9aEj2Yxcp80pzgmSe5ldp02gs1805F2he6eVy0lu9
         qcBZYrVbBQHVg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7C8224007E; Mon, 30 Aug 2021 18:26:07 -0300 (-03)
Date:   Mon, 30 Aug 2021 18:26:07 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf header: Fix spelling mistake "cant'" -> "can't"
Message-ID: <YS1M75hgstYhaOHd@kernel.org>
References: <20210826121801.13281-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826121801.13281-1-colin.king@canonical.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 26, 2021 at 01:18:01PM +0100, Colin King escreveu:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a warning message. Fix it.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  tools/perf/util/header.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> index 563dec72adeb..9016541c55f9 100644
> --- a/tools/perf/util/header.c
> +++ b/tools/perf/util/header.c
> @@ -1284,7 +1284,7 @@ static int memory_node__read(struct memory_node *n, unsigned long idx)
>  
>  	dir = opendir(path);
>  	if (!dir) {
> -		pr_warning("failed: cant' open memory sysfs data\n");
> +		pr_warning("failed: can't open memory sysfs data\n");
>  		return -1;
>  	}
>  
> -- 
> 2.32.0

-- 

- Arnaldo
