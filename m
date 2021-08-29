Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074543FAAF6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 12:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235114AbhH2K4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 06:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbhH2K4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 06:56:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EBEC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 03:55:10 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id d3-20020a17090ae28300b0019629c96f25so5118084pjz.2
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 03:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CuDrEYU1TGpB0c6uwd1ZNHwHEuDsZ2GreT0CBPG8RhI=;
        b=qMXNvM4HR2ycfB8cf5whuw2XTsE0w0S8Kg7tcQYelCfD2Ov0LWEDUmV5hFfnJR+S49
         d772PbQOD31c737kSZjXMkTJZe2oJpVtWHDSMYDLD9oghK2V1k+IJT7UT7Tbhps5cuk2
         kIc9flBBAfsEVGgWCq2hbFeBE5PmHRzuhWNMzequugSxu42BoE6E21aVBnxeghxayeh8
         SDaj2a6Yj3KcTf8zzecDpjpwij8m/qYGZowrt3lfr3q+8lNwTaa5/cYjPCRpgfBJCKY0
         bwwOILcwvroinQ9LG/badgZp8SFy0KPREjcdfTtF7O28DmnpskCEcb/Gvqiucr1A6DjY
         skCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CuDrEYU1TGpB0c6uwd1ZNHwHEuDsZ2GreT0CBPG8RhI=;
        b=JdG2nTXBKyiuvqomQIl0jC15K6n7R/pVNROBRtLJBd47l7FkD4U90Xl5iOZ5MGIYwL
         qw4p1voWp89RK2R2noNtMYQAxqU3REuSp3X3Go0WvCpV7rZTVv12b3NrWZ65SKbsWYtu
         bZSkFuiNL2Gk/ROjEXkOE3t1kKDElQggz8oSwnxTOftQUIpyogVBKmMEoQwFWQd9025v
         Nws+k5XUxvEmdk79WLXy27LEct90D1ERHPPMM7q/4KJD3nbSqICCaL7dMcgtZqNX6Dab
         kiQFfnupUv4tSmJbQuYzRjHMI3HDCiSmgLtZ98M6XFz02qxY2jUiWUQM0pwfIwghx923
         UHfQ==
X-Gm-Message-State: AOAM5312LgJZOXEdLsQEtjrHXLAVyXw/0zyJh0cBD/WP+M14X4/raiIc
        vi/xxo0XMRcAYS7tiBpFOLo4qA==
X-Google-Smtp-Source: ABdhPJxb+YwSW5sulq0PfaREnttI5UqvdpA6jz4l6GfS8qGqUzeXhA+GkBweb1zefOGCCrulngIdqw==
X-Received: by 2002:a17:90a:2b89:: with SMTP id u9mr20939389pjd.116.1630234509366;
        Sun, 29 Aug 2021 03:55:09 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id i1sm17575257pjs.31.2021.08.29.03.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 03:55:08 -0700 (PDT)
Date:   Sun, 29 Aug 2021 18:55:00 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH v5 2/9] coresight: tmc-etr: Add barrier after updating
 AUX ring buffer
Message-ID: <20210829105500.GB14461@leoy-ThinkPad-X240s>
References: <20210809111407.596077-1-leo.yan@linaro.org>
 <20210809111407.596077-3-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809111407.596077-3-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu, Suzuki,

On Mon, Aug 09, 2021 at 07:14:00PM +0800, Leo Yan wrote:
> Since a memory barrier is required between AUX trace data store and
> aux_head store, and the AUX trace data is filled with memcpy(), it's
> sufficient to use smp_wmb() so can ensure the trace data is visible
> prior to updating aux_head.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Could you pick up patches 02 and 03 in this series?  Please note,
patch 02 has the review tag from Suzuki, but I didn't receive the
review tag for patch 03.

If anything need to follow up, just let me know.  Thanks!

> ---
>  drivers/hwtracing/coresight/coresight-tmc-etr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index acdb59e0e661..13fd1fc730ed 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -1563,6 +1563,14 @@ tmc_update_etr_buffer(struct coresight_device *csdev,
>  	 */
>  	if (etr_perf->snapshot)
>  		handle->head += size;
> +
> +	/*
> +	 * Ensure that the AUX trace data is visible before the aux_head
> +	 * is updated via perf_aux_output_end(), as expected by the
> +	 * perf ring buffer.
> +	 */
> +	smp_wmb();
> +
>  out:
>  	/*
>  	 * Don't set the TRUNCATED flag in snapshot mode because 1) the
> -- 
> 2.25.1
> 
