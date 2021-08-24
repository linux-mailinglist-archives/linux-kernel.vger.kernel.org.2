Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 850B03F5892
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 08:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhHXG7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 02:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbhHXG7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 02:59:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFBDC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 23:58:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id b9so7284578plx.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 23:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hxmjjXl6haOlUyFAodOeN6Rid/V7VeRFHdShmZUvvps=;
        b=gQUOEkb9jVQiUcTryVHj8YyC5b+IVDtVMTww8NE+oRIGz8i4pRkgVU7Sxge0sWL7U+
         4SBj2XaIq5LEDPAe12U+CF712yba2yYpcj5ThnkNIfNz/VVo3plIJMLda6ILSwsNesPR
         56DrL1xYLwK/PPMh/OQzeyRTBelTu2huqtE1mZbCYXT0N8zh9MY1HnN4brzmyCSt+TwA
         HZAUBXrkvDLkJ1TZQE9oSJ4tehixfFz5YRd1FOXC6CV3T287hZaLKU43qX5BNfISMp4L
         6Q14e37amSgJ6ndGSWUdHv4NtFONfJWdWv9KG6yTyO0iPLka9AC5uf3fVWMXjRAv7b+q
         SOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hxmjjXl6haOlUyFAodOeN6Rid/V7VeRFHdShmZUvvps=;
        b=qdQT1hZEblRX2s+1uQtbgddlzvf3xg0sD4POD/doR0PSJVpin6GZctYgaExv79I7BA
         1gwjJZGxJP/sD2TYQpxITI7gf3GQs2PGuzjTDjU2la1rQhOsBaoG3VRymTjExsvOKYhX
         rKowymsJyxsO3Axp6B7sRSGbTYtaiVhAM2Wbn8OHJSDiBatJSlOcwmnNpos57gZ236+c
         C+lKmO5/a1ni6Ymz7N3G9nRw8BEuXDHPWW2BU9g0QgTOm00jRA9NPUHkM8r3j14Z5Ojt
         rIluriKGc44g2GZw8ItlxEYELPDas3NVApqSCc2Klbnt/c8kDkDpGtkDi/eVLFoDsPlL
         wrTg==
X-Gm-Message-State: AOAM5327yJjlDsJxEf/Jbuzw8LpD0LgyHSFDqN/stMsH5RLG3vJx1f82
        dyfiJSrdVoxQlhJbCp5xnbmuwQ==
X-Google-Smtp-Source: ABdhPJxv5fGaGFUoAHH4NEpea5BSJ1aA34eW3Z8d6rlBEEw6xgHxu7zqJkZzQ9QlExxymvkto8O/IA==
X-Received: by 2002:a17:902:9a04:b029:12b:8d54:7c2 with SMTP id v4-20020a1709029a04b029012b8d5407c2mr32555237plp.62.1629788336725;
        Mon, 23 Aug 2021 23:58:56 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id 10sm1460505pjc.41.2021.08.23.23.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 23:58:56 -0700 (PDT)
Date:   Tue, 24 Aug 2021 14:58:48 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, mike.leach@linaro.org,
        acme@kernel.org, suzuki.poulose@arm.com,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/9] perf cs-etm: Refactor out ETMv4 header saving
Message-ID: <20210824065848.GB204566@leoy-ThinkPad-X240s>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-4-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806134109.1182235-4-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 02:41:03PM +0100, James Clark wrote:
> Extract a function for saving the ETMv4 header because this will be used
> for ETE in a later commit.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/arch/arm/util/cs-etm.c | 46 +++++++++++++++----------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index 85168d87b2d7..ecb6fa55a210 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -607,6 +607,28 @@ static int cs_etm_get_ro(struct perf_pmu *pmu, int cpu, const char *path)
>  	return val;
>  }
>  
> +static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr, int cpu)
> +{
> +	struct cs_etm_recording *ptr = container_of(itr, struct cs_etm_recording, itr);
> +	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
> +
> +	/* Get trace configuration register */
> +	data[CS_ETMV4_TRCCONFIGR] = cs_etmv4_get_config(itr);
> +	/* Get traceID from the framework */
> +	data[CS_ETMV4_TRCTRACEIDR] = coresight_get_trace_id(cpu);
> +	/* Get read-only information from sysFS */
> +	data[CS_ETMV4_TRCIDR0] = cs_etm_get_ro(cs_etm_pmu, cpu,
> +					       metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
> +	data[CS_ETMV4_TRCIDR1] = cs_etm_get_ro(cs_etm_pmu, cpu,
> +					       metadata_etmv4_ro[CS_ETMV4_TRCIDR1]);
> +	data[CS_ETMV4_TRCIDR2] = cs_etm_get_ro(cs_etm_pmu, cpu,
> +					       metadata_etmv4_ro[CS_ETMV4_TRCIDR2]);
> +	data[CS_ETMV4_TRCIDR8] = cs_etm_get_ro(cs_etm_pmu, cpu,
> +					       metadata_etmv4_ro[CS_ETMV4_TRCIDR8]);
> +	data[CS_ETMV4_TRCAUTHSTATUS] = cs_etm_get_ro(cs_etm_pmu, cpu,
> +						     metadata_etmv4_ro[CS_ETMV4_TRCAUTHSTATUS]);
> +}
> +
>  static void cs_etm_get_metadata(int cpu, u32 *offset,
>  				struct auxtrace_record *itr,
>  				struct perf_record_auxtrace_info *info)
> @@ -620,29 +642,7 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
>  	/* first see what kind of tracer this cpu is affined to */
>  	if (cs_etm_is_etmv4(itr, cpu)) {
>  		magic = __perf_cs_etmv4_magic;
> -		/* Get trace configuration register */
> -		info->priv[*offset + CS_ETMV4_TRCCONFIGR] =
> -						cs_etmv4_get_config(itr);
> -		/* Get traceID from the framework */
> -		info->priv[*offset + CS_ETMV4_TRCTRACEIDR] =
> -						coresight_get_trace_id(cpu);
> -		/* Get read-only information from sysFS */
> -		info->priv[*offset + CS_ETMV4_TRCIDR0] =
> -			cs_etm_get_ro(cs_etm_pmu, cpu,
> -				      metadata_etmv4_ro[CS_ETMV4_TRCIDR0]);
> -		info->priv[*offset + CS_ETMV4_TRCIDR1] =
> -			cs_etm_get_ro(cs_etm_pmu, cpu,
> -				      metadata_etmv4_ro[CS_ETMV4_TRCIDR1]);
> -		info->priv[*offset + CS_ETMV4_TRCIDR2] =
> -			cs_etm_get_ro(cs_etm_pmu, cpu,
> -				      metadata_etmv4_ro[CS_ETMV4_TRCIDR2]);
> -		info->priv[*offset + CS_ETMV4_TRCIDR8] =
> -			cs_etm_get_ro(cs_etm_pmu, cpu,
> -				      metadata_etmv4_ro[CS_ETMV4_TRCIDR8]);
> -		info->priv[*offset + CS_ETMV4_TRCAUTHSTATUS] =
> -			cs_etm_get_ro(cs_etm_pmu, cpu,
> -				      metadata_etmv4_ro
> -				      [CS_ETMV4_TRCAUTHSTATUS]);
> +		cs_etm_save_etmv4_header(&info->priv[*offset], itr, cpu);
>  
>  		/* How much space was used */
>  		increment = CS_ETMV4_PRIV_MAX;
> -- 
> 2.28.0
> 
