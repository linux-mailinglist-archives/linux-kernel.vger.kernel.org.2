Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90338407A2B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Sep 2021 20:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbhIKTAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 15:00:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:49702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233408AbhIKTAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 15:00:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1691B61074;
        Sat, 11 Sep 2021 18:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631386730;
        bh=736mCfz5ZV/x4n/cqKnk2rw3jmq+PzIfR34XdxDF/0I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=igFMQ2+j8ckrXsMKwR9xYb2B/ZvOCftDHUzlB3v3mOREvl4x/VTjhMn7/5NMFnO3U
         p0Xs6ZQwIWLH8sk9nI8Mg6zmZx84Zng9nWFTi4ANPkyotIDb+H2zLDsnWN/vFHkuJ4
         eU79BpwCB61dAeQxldpSyNhPRQTz/9UpFguMG+O43jRn81SnxR1yfK8N0Z7BCBi+Fv
         9br7NUUUzot5k79BPrnoV9CJ+fcsRSoiPSPzZhdYnQu5gZ6WtnzW3nvIDnhLyWaNG7
         icUX0c7r6yJ8dwq5dD5oDy+nSEV4zVEj25DVeovdY5xPVPXIDlcrtvTDSYcW/I423B
         iRGN+dALxfjVg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C0A484038F; Sat, 11 Sep 2021 15:58:47 -0300 (-03)
Date:   Sat, 11 Sep 2021 15:58:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix perf_event_attr__fprintf() missing/dupl.
 fields
Message-ID: <YTz8Zy4K3u43nkrF@kernel.org>
References: <20210911120550.12203-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210911120550.12203-1-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Sep 11, 2021 at 03:05:50PM +0300, Adrian Hunter escreveu:
> Some fields are missing and text_poke is duplicated. Fix that up.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/perf_event_attr_fprintf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/perf_event_attr_fprintf.c b/tools/perf/util/perf_event_attr_fprintf.c
> index 30481825515b..47b7531f51da 100644
> --- a/tools/perf/util/perf_event_attr_fprintf.c
> +++ b/tools/perf/util/perf_event_attr_fprintf.c
> @@ -137,6 +137,9 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>  	PRINT_ATTRf(cgroup, p_unsigned);
>  	PRINT_ATTRf(text_poke, p_unsigned);
>  	PRINT_ATTRf(build_id, p_unsigned);
> +	PRINT_ATTRf(inherit_thread, p_unsigned);
> +	PRINT_ATTRf(remove_on_exec, p_unsigned);
> +	PRINT_ATTRf(sigtrap, p_unsigned);
>  
>  	PRINT_ATTRn("{ wakeup_events, wakeup_watermark }", wakeup_events, p_unsigned);
>  	PRINT_ATTRf(bp_type, p_unsigned);
> @@ -150,7 +153,7 @@ int perf_event_attr__fprintf(FILE *fp, struct perf_event_attr *attr,
>  	PRINT_ATTRf(aux_watermark, p_unsigned);
>  	PRINT_ATTRf(sample_max_stack, p_unsigned);
>  	PRINT_ATTRf(aux_sample_size, p_unsigned);
> -	PRINT_ATTRf(text_poke, p_unsigned);
> +	PRINT_ATTRf(sig_data, p_unsigned);
>  
>  	return ret;
>  }
> -- 
> 2.17.1

-- 

- Arnaldo
