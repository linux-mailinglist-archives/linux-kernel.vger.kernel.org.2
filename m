Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA4631F033
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbhBRTnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:43:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232456AbhBRTIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:08:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE73464EC0;
        Thu, 18 Feb 2021 19:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613675251;
        bh=t9MJ2b77m8NwUi8a6NVhMCA3xClffdK2CFILp2riKxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q8ES6boZCMU66yeWrj4lhYFrLccxpa0sqO2OqNY4WqDxf66hqUhk00buXbe372aGS
         b3ONBEKz4aPRWmYlZ7iA4acdzSH1P3peiFf+wARQr9JVLufssDoHeR3HYLT66gQcd1
         qTpAo54S1JKPxIOFdUePyEYdwADednyRyPmjKEaWgKTZOyjWX5HQbfixcHFDBp8muP
         elcjReYwB56wVrSmrElZTSsfLuN9mVAIDAQ7FYkyex5cv96HC1gWQCudZyxCWGqrVF
         Bw2KPKJEfJm2k5M7eEXcY3PraAxIB5UNsLDYOIiTY89ibG/M/DtxlRV94pe/OGSfvr
         aIlCsI0eqKQUg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 920C440CD9; Thu, 18 Feb 2021 16:07:28 -0300 (-03)
Date:   Thu, 18 Feb 2021 16:07:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        atrajeev@linux.vnet.ibm.com, namhyung@kernel.org, jolsa@redhat.com,
        ak@linux.intel.com, yao.jin@linux.intel.com,
        maddy@linux.vnet.ibm.com
Subject: Re: [PATCH] perf tools: Support arch specific
 PERF_SAMPLE_WEIGHT_STRUCT processing
Message-ID: <YC668HJYFD3CoO8M@kernel.org>
References: <1612540912-6562-1-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612540912-6562-1-git-send-email-kan.liang@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 05, 2021 at 08:01:52AM -0800, kan.liang@linux.intel.com escreveu:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> For X86, the var2_w field of PERF_SAMPLE_WEIGHT_STRUCT stands for the
> instruction latency. Current perf forces the var2_w to the data->ins_lat
> in the generic code. It works well for now because X86 is the only
> architecture that supports the PERF_SAMPLE_WEIGHT_STRUCT, but it may
> bring problems once other architectures support the sample type.
> For example, the var2_w may be used to capture something else on
> PowerPC.
> 
> Create two architecture specific functions to parse and synthesize
> the weight related samples. Move the X86 specific codes to the X86
> version functions. Other architectures can implement their own functions
> later separately.

Thanks, applied.

- Arnaldo

 
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/arch/x86/util/event.c   | 25 +++++++++++++++++++++++++
>  tools/perf/util/event.h            |  3 +++
>  tools/perf/util/evsel.c            | 17 ++++++++---------
>  tools/perf/util/synthetic-events.c | 12 +++++++-----
>  4 files changed, 43 insertions(+), 14 deletions(-)
> 
> diff --git a/tools/perf/arch/x86/util/event.c b/tools/perf/arch/x86/util/event.c
> index 047dc00..9b31734 100644
> --- a/tools/perf/arch/x86/util/event.c
> +++ b/tools/perf/arch/x86/util/event.c
> @@ -75,3 +75,28 @@ int perf_event__synthesize_extra_kmaps(struct perf_tool *tool,
>  }
>  
>  #endif
> +
> +void arch_perf_parse_sample_weight(struct perf_sample *data,
> +				   const __u64 *array, u64 type)
> +{
> +	union perf_sample_weight weight;
> +
> +	weight.full = *array;
> +	if (type & PERF_SAMPLE_WEIGHT)
> +		data->weight = weight.full;
> +	else {
> +		data->weight = weight.var1_dw;
> +		data->ins_lat = weight.var2_w;
> +	}
> +}
> +
> +void arch_perf_synthesize_sample_weight(const struct perf_sample *data,
> +					__u64 *array, u64 type)
> +{
> +	*array = data->weight;
> +
> +	if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> +		*array &= 0xffffffff;
> +		*array |= ((u64)data->ins_lat << 32);
> +	}
> +}
> diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
> index 60752e4..9f123aa 100644
> --- a/tools/perf/util/event.h
> +++ b/tools/perf/util/event.h
> @@ -414,4 +414,7 @@ extern unsigned int proc_map_timeout;
>  #define PAGE_SIZE_NAME_LEN	32
>  char *get_page_size_name(u64 size, char *str);
>  
> +void arch_perf_parse_sample_weight(struct perf_sample *data, const __u64 *array, u64 type);
> +void arch_perf_synthesize_sample_weight(const struct perf_sample *data, __u64 *array, u64 type);
> +
>  #endif /* __PERF_RECORD_H */
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 30b5452..1da8903 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2106,6 +2106,13 @@ perf_event__check_size(union perf_event *event, unsigned int sample_size)
>  	return 0;
>  }
>  
> +void __weak arch_perf_parse_sample_weight(struct perf_sample *data,
> +					  const __u64 *array,
> +					  u64 type __maybe_unused)
> +{
> +	data->weight = *array;
> +}
> +
>  int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  			struct perf_sample *data)
>  {
> @@ -2347,16 +2354,8 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  	}
>  
>  	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
> -		union perf_sample_weight weight;
> -
>  		OVERFLOW_CHECK_u64(array);
> -		weight.full = *array;
> -		if (type & PERF_SAMPLE_WEIGHT)
> -			data->weight = weight.full;
> -		else {
> -			data->weight = weight.var1_dw;
> -			data->ins_lat = weight.var2_w;
> -		}
> +		arch_perf_parse_sample_weight(data, array, type);
>  		array++;
>  	}
>  
> diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
> index c6f9db3..412f4c3 100644
> --- a/tools/perf/util/synthetic-events.c
> +++ b/tools/perf/util/synthetic-events.c
> @@ -1507,6 +1507,12 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
>  	return result;
>  }
>  
> +void __weak arch_perf_synthesize_sample_weight(const struct perf_sample *data,
> +					       __u64 *array, u64 type __maybe_unused)
> +{
> +	*array = data->weight;
> +}
> +
>  int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_format,
>  				  const struct perf_sample *sample)
>  {
> @@ -1643,11 +1649,7 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type, u64 read_fo
>  	}
>  
>  	if (type & PERF_SAMPLE_WEIGHT_TYPE) {
> -		*array = sample->weight;
> -		if (type & PERF_SAMPLE_WEIGHT_STRUCT) {
> -			*array &= 0xffffffff;
> -			*array |= ((u64)sample->ins_lat << 32);
> -		}
> +		arch_perf_synthesize_sample_weight(sample, array, type);
>  		array++;
>  	}
>  
> -- 
> 2.7.4
> 

-- 

- Arnaldo
