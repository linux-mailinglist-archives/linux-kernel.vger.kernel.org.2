Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 206383DDC9D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhHBPmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbhHBPmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:42:02 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77EF7C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 08:41:53 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so522057pji.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IPGFm1JVt7oI2MPX9jivaw8zoW+8Rnmc7/BPuCII8Jo=;
        b=VwvaXSWrW68WjgLZEPqM4PM0EYl/IOdzxU8FSYgrgd33lc3Q+avni42/Rwj7BFvvDv
         na5Pvihf1rbv4b+OL5zHiFsm702Us8bW25rO4MbeXrGyq+ApYbt3x4DCuhre3sM2jwLC
         lcTOwpVumR221KSN7jnmm2w6B2RXK4GHYKbajgjEoWdzHPShLPGuZwZcBF+dW0yq82S0
         zxkVbmBfvoZ7roUsctuu/8nvpKUhkE6XsmNAqa1xhsqhOiNQT2ENIrNPSghAd5O5rzt/
         N7KpeEY1mItXsfx6LfgTVt61u5dmVqSoQmY69dsiXy48jA9++qzRLFyF17+g6XDmh3JO
         NW+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IPGFm1JVt7oI2MPX9jivaw8zoW+8Rnmc7/BPuCII8Jo=;
        b=PrNfNtuWvIKAGbjLwzUuTb+H8uaWc+HIlovqrqPP8kFQOBK8Lryl86pelNBt5+aiZu
         gbXnoc06kBua7E/N5OP2Pv6tytz36O9UPLHfHp9PknwO5EaNvlqkrlcq6ni79zvrrte3
         a/EMWDyrNq2Oak7xremBYicSxUPb3e7SYCs3wDVfV+nfyVn7/N6S2y+Zg6dNu9GCMTCY
         ksAWSpQz7arXpCxMZ+c1804/DYsPRJcg9kgBgCpy9VfMj3xxC5bnKPjppscBGwGrHmql
         Z1zcrCt+HXJobla4K5fancpNlO6W/yzJoUKlzW8RiYSNOrcM2pZNAkyfXKW1iPD8fV/v
         hapw==
X-Gm-Message-State: AOAM531+P9YI9qrTk3ux/4myes3JvtC5R703Qvm31DciUQDpyoeaf8Ly
        423HOTegUlKN4YRM9JCOk5khhA==
X-Google-Smtp-Source: ABdhPJyBZmJQKOQ93FLiKAY8bJep5+mWQ1DgLDqoZXSq76z6ETi50YV93BaQjdSZshivJlUEKVS+1g==
X-Received: by 2002:aa7:8d56:0:b029:327:6dc:d254 with SMTP id s22-20020aa78d560000b029032706dcd254mr17568179pfe.69.1627918912777;
        Mon, 02 Aug 2021 08:41:52 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id 198sm9871245pfu.32.2021.08.02.08.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:41:51 -0700 (PDT)
Date:   Mon, 2 Aug 2021 23:41:45 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 6/6] perf cs-etm: Add warnings for missing DSOs
Message-ID: <20210802154145.GC148327@leoy-ThinkPad-X240s>
References: <20210729155805.2830-1-james.clark@arm.com>
 <20210729155805.2830-7-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729155805.2830-7-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 04:58:05PM +0100, James Clark wrote:
> Currently decode will silently fail if no binary data is available for
> the decode. This is made worse if only partial data is available because
> the decode will appear to work, but any trace from that missing DSO will
> silently not be generated.
> 
> Add a UI popup once if there is any data missing, and then warn in the
> bottom left for each individual DSO that's missing.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 32ad92d3e454..e6851260d059 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -746,8 +746,16 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
>  
>  	len = dso__data_read_offset(al.map->dso, machine, offset, buffer, size);
>  
> -	if (len <= 0)
> +	if (len <= 0) {
> +		ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' to export data from the traced system.\n");
> +		if (!al.map->dso->auxtrace_warned) {
> +			pr_err("CS ETM Trace: Debug data not found for address %#"PRIx64" in %s\n",
> +				    address,
> +				    al.map->dso->long_name ? al.map->dso->long_name : "Unknown");
> +			al.map->dso->auxtrace_warned = true;
> +		}

This is very useful.

Just one comment: in particularly if the perf fails to find the kernel
symbols, the user needs to enable config "CONFIG_PROC_KCORE=y" or
specify option "-k /path/to/vmlinux".  In this case, using 'perf
archive' is not helpful.  So I think the UI warning can be imporved
like:

        ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' to export data from the traced system.\n"
                         " Enable CONFIG_PROC_KCORE or use option '-k /path/to/vmlinux' for kernel symbols\n");

With this improvement, the patch looks good to me:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

>  		return 0;
> +	}
>  
>  	return len;
>  }
> -- 
> 2.28.0
> 
