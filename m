Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED6A13A308B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 18:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbhFJQ0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 12:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbhFJQ0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 12:26:53 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304E8C061760
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 09:24:57 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o17-20020a17090a9f91b029015cef5b3c50so4048173pjp.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VN0XVB///d61kKRXkCK9H/d2Ol9ZLrpAFz4mHjzp1Zc=;
        b=ix9fD5LAnx1QqJV/6k2ss+1TfixF9sf8viMtveQRBWj1NMBx0MoehFRGfgYbERv3pP
         TGDwriYmSD+N4RUW77j9cMTdmUxWzXAZ11KyTVYTxpGBntElM72bFq5FPHd++H3PhuL/
         odKoaFI5GdEyhSrj3fVsOUBIpgYjlvKFP6F0fnUOkISHK7emRx1aNPHZ5+SedGSu0881
         sirBIf4SdgL6Ml+OVi2tntv5APuhU9mAdYv8Wf5UHmNR+g84ryM9l98BnNCRlG2gZcR9
         G/qWxynDdEOAW+Fssh1jyu09oUCqwSnl9+I97otExFus0cwiVY41fe8akxVtdiYd9LTc
         Lz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VN0XVB///d61kKRXkCK9H/d2Ol9ZLrpAFz4mHjzp1Zc=;
        b=a9JR6wC5m/v1aHL7Im0mnEGV0g3I83P0nUV5yMcyM6WsNdC4E5OmE2EePxKHYkS3rD
         7aP9Dxx0etI2oAWIuyvQ8+Dize5DjSOo5JTo1cNjvSqKndT7CdPcVjzZAiwW4ai/xJye
         FOAQEyNHZkf1uVSD/fSYEH9mGbUT6ZuglHt0hKSXct3bL7HkRD5H0u5Z1AGYrdeOCNkv
         9deiIVaxDTG4NJvUvad4QGeF6YXKWj3biOB/VnPPbhdHI+ee0NwVG0hMrILyuyBMZyO5
         MQUVCu6hZxo0ppIpaRYaCI8SaHy9a0s0GSuGRufOgfvFHTCoLb35Z+leEhwnBV7r/6/K
         WNFQ==
X-Gm-Message-State: AOAM530IjnFmNqWFaOUYAQ/wXvNbg4Ay8AoBQwkMns3V8rNofov0VdaP
        75zjzdjFAJiXp8A4aFej+3BYkA==
X-Google-Smtp-Source: ABdhPJzG0lwwxsj52DYgCi2LXUt60r14gsFgQSZsW8S3Q+X+zKNiV9KhHE55OqhhmGGxUA80CDAjSQ==
X-Received: by 2002:a17:90a:744d:: with SMTP id o13mr4290348pjk.34.1623342296573;
        Thu, 10 Jun 2021 09:24:56 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e188sm2905217pfe.23.2021.06.10.09.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 09:24:55 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:24:53 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, coresight@lists.linaro.org, leo.yan@linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf cs-etm: Delay decode of non-timeless data until
 cs_etm__flush_events()
Message-ID: <20210610162453.GC34238@p14s>
References: <20210609130421.13934-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210609130421.13934-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch doesn't apply on coresight next.  

On Wed, Jun 09, 2021 at 04:04:20PM +0300, James Clark wrote:
> Currently, timeless mode starts the decode on PERF_RECORD_EXIT, and
> non-timeless mode starts decoding on the fist PERF_RECORD_AUX record.
> 
> This can cause the "data has no samples!" error if the first
> PERF_RECORD_AUX record comes before the first (or any relevant)
> PERF_RECORD_MMAP2 record because the mmaps are required by the decoder
> to access the binary data.
> 
> This change pushes the start of non-timeless decoding to the very end of
> parsing the file. The PERF_RECORD_EXIT event can't be used because it
> might not exist in system-wide or snapshot modes.
> 
> I have not been able to find the exact cause for the events to be
> intermittently in the wrong order in the basic scenario:
> 
> 	perf record -e cs_etm/@tmc_etr0/u top
> 
> But it can be made to happen every time with the --delay option. This is
> because "enable_on_exec" is disabled, which causes tracing to start
> before the process to be launched is exec'd. For example:
> 
> 	perf record -e cs_etm/@tmc_etr0/u --delay=1 top
> 	perf report -D | grep 'AUX\|MAP'
> 
> 	0 16714475632740 0x520 [0x40]: PERF_RECORD_AUX offset: 0 size: 0x30 flags: 0 []
> 	0 16714476494960 0x5d0 [0x40]: PERF_RECORD_AUX offset: 0x30 size: 0x30 flags: 0 []
> 	0 16714478208900 0x660 [0x40]: PERF_RECORD_AUX offset: 0x60 size: 0x30 flags: 0 []
> 	4294967295 16714478293340 0x700 [0x70]: PERF_RECORD_MMAP2 8712/8712: [0x557a460000(0x54000) @ 0 00:17 5329258 0]: r-xp /usr/bin/top
> 	4294967295 16714478353020 0x770 [0x88]: PERF_RECORD_MMAP2 8712/8712: [0x7f86f72000(0x34000) @ 0 00:17 5214354 0]: r-xp /usr/lib/aarch64-linux-gnu/ld-2.31.so
> 
> Another scenario in which decoding from the first aux record fails is a
> workload that forks. Although the aux record comes after 'bash', it
> comes before 'top', which is what we are interested in. For example:
> 
> 	perf record -e cs_etm/@tmc_etr0/u -- bash -c top
> 	perf report -D | grep 'AUX\|MAP'
> 
> 	4294967295 16853946421300 0x510 [0x70]: PERF_RECORD_MMAP2 8723/8723: [0x558f280000(0x142000) @ 0 00:17 5213953 0]: r-xp /usr/bin/bash
> 	4294967295 16853946543560 0x580 [0x88]: PERF_RECORD_MMAP2 8723/8723: [0x7fbba6e000(0x34000) @ 0 00:17 5214354 0]: r-xp /usr/lib/aarch64-linux-gnu/ld-2.31.so
> 	4294967295 16853946628420 0x608 [0x68]: PERF_RECORD_MMAP2 8723/8723: [0x7fbba9e000(0x1000) @ 0 00:00 0 0]: r-xp [vdso]
> 	0 16853947067300 0x690 [0x40]: PERF_RECORD_AUX offset: 0 size: 0x3a60 flags: 0 []
> 	...
> 	0 16853966602580 0x1758 [0x40]: PERF_RECORD_AUX offset: 0xc2470 size: 0x30 flags: 0 []
> 	4294967295 16853967119860 0x1818 [0x70]: PERF_RECORD_MMAP2 8723/8723: [0x5559e70000(0x54000) @ 0 00:17 5329258 0]: r-xp /usr/bin/top
> 	4294967295 16853967181620 0x1888 [0x88]: PERF_RECORD_MMAP2 8723/8723: [0x7f9ed06000(0x34000) @ 0 00:17 5214354 0]: r-xp /usr/lib/aarch64-linux-gnu/ld-2.31.so
> 	4294967295 16853967237180 0x1910 [0x68]: PERF_RECORD_MMAP2 8723/8723: [0x7f9ed36000(0x1000) @ 0 00:00 0 0]: r-xp [vdso]
> 
> A third scenario is when the majority of time is spent in a shared
> library that is not loaded at startup. For example a dynamically loaded
> plugin.
> 
> Testing
> =======
> 
> Testing was done by checking if any samples that are present in the
> old output are missing from the new output. Timestamps must be
> stripped out with awk because now they are set to the last AUX sample,
> rather than the first:
> 
> 	./perf script $4 | awk '!($4="")' > new.script
> 	./perf-default script $4 | awk '!($4="")' > default.script
> 	comm -13 <(sort -u new.script) <(sort -u default.script)
> 
> Testing showed that the new output is a superset of the old. When lines
> appear in the comm output, it is not because they are missing but
> because [unknown] is now resolved to sensible locations. For example
> last putp branch here now resolves to libtinfo, so it's not missing
> from the output, but is actually improved:
> 
> Old:
> 	top 305 [001]  1 branches:uH: 402830 _init+0x30 (/usr/bin/top.procps) => 404a1c [unknown] (/usr/bin/top.procps)
> 	top 305 [001]  1 branches:uH: 404a20 [unknown] (/usr/bin/top.procps) => 402970 putp@plt+0x0 (/usr/bin/top.procps)
> 	top 305 [001]  1 branches:uH: 40297c putp@plt+0xc (/usr/bin/top.procps) => 0 [unknown] ([unknown])
> New:
> 	top 305 [001]  1 branches:uH: 402830 _init+0x30 (/usr/bin/top.procps) => 404a1c [unknown] (/usr/bin/top.procps)
> 	top 305 [001]  1 branches:uH: 404a20 [unknown] (/usr/bin/top.procps) => 402970 putp@plt+0x0 (/usr/bin/top.procps)
> 	top 305 [001]  1 branches:uH: 40297c putp@plt+0xc (/usr/bin/top.procps) => 7f8ab39208 putp+0x0 (/lib/libtinfo.so.5.9)
> 
> In the following two modes, decoding now works and the "data has no
> samples!" error is not displayed any more:
> 
> 	perf record -e cs_etm/@tmc_etr0/u -- bash -c top
> 	perf record -e cs_etm/@tmc_etr0/u --delay=1 top
> 
> In snapshot mode, there is also an improvement to decoding. Previously
> samples for the 'kill' process that was used to send SIGUSR2 were
> completely missing, because the process hadn't started yet. But now
> there are additional samples present:
> 
> 	perf record -e cs_etm/@tmc_etr0/u --snapshot -a
> 	perf script
> 
> 		stress 19380 [003] 161627.938153:    1000000    instructions:uH:      aaaabb612fb4 [unknown] (/usr/bin/stress)
> 		  kill 19644 [000] 161627.938153:    1000000    instructions:uH:      ffffae0ef210 [unknown] (/lib/aarch64-linux-gnu/ld-2.27.so)
> 		stress 19380 [003] 161627.938153:    1000000    instructions:uH:      ffff9e754d40 random_r+0x20 (/lib/aarch64-linux-gnu/libc-2.27.so)
> 
> Also tested was the round trip of 'perf inject' followed by 'perf
> report' which has the same differences and improvements.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index 57aea2c7fc77..ceed0b038796 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -2407,6 +2407,11 @@ static int cs_etm__process_event(struct perf_session *session,
>  			return err;
>  	}
>  
> +	/*
> +	 * Don't wait for cs_etm__flush_events() in per-thread/timeless mode to start the decode. We
> +	 * need the tid of the PERF_RECORD_EXIT event to assign to the synthesised samples because
> +	 * ETM_OPT_CTXTID is not enabled.
> +	 */
>  	if (etm->timeless_decoding &&
>  	    event->header.type == PERF_RECORD_EXIT)
>  		return cs_etm__process_timeless_queues(etm,
> @@ -2424,7 +2429,6 @@ static int cs_etm__process_event(struct perf_session *session,
>  		 * onwards.
>  		 */
>  		etm->latest_kernel_timestamp = sample_kernel_timestamp;
> -		return cs_etm__process_queues(etm);
>  	}
>  
>  	return 0;
> -- 
> 2.28.0
> 
