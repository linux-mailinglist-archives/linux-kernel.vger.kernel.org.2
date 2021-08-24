Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9323F5883
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 08:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbhHXGyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 02:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbhHXGyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 02:54:12 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA5CC061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 23:53:26 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id w8so18902231pgf.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 23:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0jQVnHCLqBk2LRj/gOBDVJ368OV7bEid1vgTCabVIn4=;
        b=CObson2ozZr4tFYUquzE8I/b2cX2xxA/qYHDKIKqUeYkUozPkgJOn3tWUnbATZsIwT
         m9kFTKTS+nNahFBiAbviB7ffx524dlvod8STM/admTnWeaXzB+eoxKEtrCR1KggmJTcT
         Wk8ndfRjY1o9TLR6HO7Q2yC38+c77r71diVIc9puxfe9d+58beY6SeUjvuwb81eRqMF/
         YmHXo26h1esXoChffKqbCSl2M4vPpEi7J1hiOkbb9JT56tV4AttGUlWgp0l8anXBgHcu
         OcJsJa04T9X2p7gpi8OwmlXBxsWWuGrWw+ESoWKDS9JAF4HPwBRghT1MfVfVYWNjSPg2
         0xRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0jQVnHCLqBk2LRj/gOBDVJ368OV7bEid1vgTCabVIn4=;
        b=Gq2DvtF1N5YBkLt4bpTUelbCjcDk9IRYFVLeTvl+PjFya5pPG6MjgCMmriLLraYp+Z
         Y/KWs/Quh8LSwi3FUDdEfAQ+I0e+bLxW3Y8aorjZ+I5r5AaY0J+np+Q6SoKKyNQKYo7+
         SgTuCoK9K17g+TVwXTZYxt5vlPdlXt4PYPJaYjZh5sfkUkpHejAL1mfYLGhzJItIhKWn
         ftU/1/q1Kmt4ph9Sfi5B1foIs/OVo28WCX34/gD/t7XO37ZcxZ9shLRizeQ9r9OWG7b1
         w73UJygrowxjlR1s9zEJjB6zDdF8HGB3KiAG5KjjSbkYAgjEU+slIfQT8t3Jqheo2maz
         r0Uw==
X-Gm-Message-State: AOAM532Go737K4VJJlQFUb3el7M/24pQy57je9lQlMz+wIMwMTqUXrzp
        +uRAolYJdOXMgIEzrt5ygDS2iA==
X-Google-Smtp-Source: ABdhPJyQT1auFFvuxiRbl7EfawGmVwn+TYKdQI0bC+VKpLIPB1Nx34GRHbITbh/CG0k9x3TVMW1frw==
X-Received: by 2002:aa7:8c41:0:b0:3e3:1279:105 with SMTP id e1-20020aa78c41000000b003e312790105mr28189996pfd.80.1629788006083;
        Mon, 23 Aug 2021 23:53:26 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id i6sm18053841pfa.44.2021.08.23.23.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 23:53:25 -0700 (PDT)
Date:   Tue, 24 Aug 2021 14:53:19 +0800
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
Subject: Re: [PATCH v2 2/9] perf cs-etm: Initialise architecture based on
 TRCIDR1
Message-ID: <20210824065319.GA204566@leoy-ThinkPad-X240s>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-3-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806134109.1182235-3-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 02:41:02PM +0100, James Clark wrote:
> Currently the architecture is hard coded as ARCH_V8, but from ETMv4.4
> onwards this should be ARCH_AA64.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 187c038caa19..787b19642e78 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -126,6 +126,20 @@ static int cs_etm_decoder__gen_etmv3_config(struct cs_etm_trace_params *params,
>  	return 0;
>  }
>  
> +#define TRCIDR1_TRCARCHMIN_SHIFT 4
> +#define TRCIDR1_TRCARCHMIN_MASK  GENMASK(7, 4)
> +#define TRCIDR1_TRCARCHMIN(x)    (((x) & TRCIDR1_TRCARCHMIN_MASK) >> TRCIDR1_TRCARCHMIN_SHIFT)
> +static enum _ocsd_arch_version cs_etm_decoder__get_etmv4_arch_ver(u32 reg_idr1)
> +{
> +	/*
> +	 * For ETMv4 if the trace minor version is 4 or more then we can assume
> +	 * the architecture is ARCH_AA64 rather than just V8.
> +	 * ARCH_V8 = V8 architecture
> +	 * ARCH_AA64 = Min v8r3 plus additional AA64 PE features
> +	 */
> +	return TRCIDR1_TRCARCHMIN(reg_idr1) >= 4 ? ARCH_AA64 : ARCH_V8;
> +}
> +
>  static void cs_etm_decoder__gen_etmv4_config(struct cs_etm_trace_params *params,
>  					     ocsd_etmv4_cfg *config)
>  {
> @@ -140,7 +154,7 @@ static void cs_etm_decoder__gen_etmv4_config(struct cs_etm_trace_params *params,
>  	config->reg_idr11 = 0;
>  	config->reg_idr12 = 0;
>  	config->reg_idr13 = 0;
> -	config->arch_ver = ARCH_V8;
> +	config->arch_ver = cs_etm_decoder__get_etmv4_arch_ver(params->etmv4.reg_idr1);
>  	config->core_prof = profile_CortexA;
>  }

Reviewed-by: Leo Yan <leo.yan@linaro.org>

>  
> -- 
> 2.28.0
> 
