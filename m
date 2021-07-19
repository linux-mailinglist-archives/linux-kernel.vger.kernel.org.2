Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44AFF3CEDB1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386636AbhGSTf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 15:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385462AbhGSTAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 15:00:48 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2510C061788
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:31:46 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id u126so9721100pfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 12:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fFuXsI4PgyPBGNuMhPa281s8CQuE4AWpLc5Xceic260=;
        b=ECiX0oNLlcFpWmilqN5OxAdbfaPG4SI/FYoyMUhgO6rGqvzRbd4O8okKz6He/+mk4N
         X82VoHVUOn1ejX7uUGUggH07qc4nAiIrHskUJdEbwrekzZ39/etYvl195Oee2LkLuum7
         SzN9RhjYIR0Gt8edNDQInjXwZEblPSMvCSyFaXqA7rmKOuUNoULZ2mdzbjDE1BrSHb3H
         cD5E9c1X5VG40NnzwX/gCsGjlgKPg0ORwuwuwVc3J/YXlVYtftAN8VpWU4ZfmdcBspSy
         imvGfdFYOFi6UVYvgwN7eSxsO9rC/McbDLIzshd6NJEx392PYakf04rT0lJpB38Fx1Az
         89Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fFuXsI4PgyPBGNuMhPa281s8CQuE4AWpLc5Xceic260=;
        b=DsbMyX6LMYOLwRfgd33v/z3LW5BjPdDjp5NXHEMA78UcLsWM9JzHnCVYs09HcIHyJN
         36LLiRA0XUD0aKowO1JXyVxh/MncUWfYzLdZ4gUFu3LTEhoY80o3rMhui4e1UOyDbET0
         4OAJFtDbB9dqEdltVNgHgO2FaV5FtNfWLSpe7sDQt6GR6ttmUuO1fjtVCBIaqWpOWXFW
         E78M5hF12QQz6deOv/YUDdId174iu7nXah/pt+j3R5MYNMO20776SepR6C8fEzs8Qcbc
         tcibGHdEbe4ZvhRy/MyDitrpuR+SVoRuqbkBtjvvp2AieL2Xlcs74hMkLqvosdOH7H8W
         aJAQ==
X-Gm-Message-State: AOAM530B0OHjXESg2H3V+9oPWZyyb2qJWBiJd0zQW+TwBw2zZ3KZxVgl
        +fLTMZFyeigeSHmftA6Sq2hMjg==
X-Google-Smtp-Source: ABdhPJxFKcaSE33JIxQuQEL7vCmz1D74iz2EYew7MfencyWpYdy/Jt286p6phb6zm/weKNVUd7aPIw==
X-Received: by 2002:aa7:8f07:0:b029:332:958b:1513 with SMTP id x7-20020aa78f070000b0290332958b1513mr27832606pfr.4.1626723572793;
        Mon, 19 Jul 2021 12:39:32 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id n12sm21573191pgr.2.2021.07.19.12.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:39:31 -0700 (PDT)
Date:   Mon, 19 Jul 2021 13:39:29 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, coresight@lists.linaro.org, leo.yan@linaro.org,
        al.grant@arm.com, branislav.rankov@arm.com, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] perf cs-etm: Suppress printing when resetting decoder
Message-ID: <20210719193929.GE2255168@p14s>
References: <20210713154008.29656-1-james.clark@arm.com>
 <20210713154008.29656-5-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713154008.29656-5-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 04:40:06PM +0100, James Clark wrote:
> The decoder is quite noisy when being reset. In a future commit,
> dump-raw-trace will use a code path that resets the decoder rather than
> creating a new one, so printing has to be suppressed to not flood the
> output.
> 
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 3e1a05bc82cc..ed1f0326f859 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -35,6 +35,7 @@
>  struct cs_etm_decoder {
>  	void *data;
>  	void (*packet_printer)(const char *msg);
> +	bool suppress_printing;
>  	dcd_tree_handle_t dcd_tree;
>  	cs_etm_mem_cb_type mem_access;
>  	ocsd_datapath_resp_t prev_return;
> @@ -74,9 +75,10 @@ int cs_etm_decoder__reset(struct cs_etm_decoder *decoder)
>  	ocsd_datapath_resp_t dp_ret;
>  
>  	decoder->prev_return = OCSD_RESP_CONT;
> -
> +	decoder->suppress_printing = true;
>  	dp_ret = ocsd_dt_process_data(decoder->dcd_tree, OCSD_OP_RESET,
>  				      0, 0, NULL, NULL);
> +	decoder->suppress_printing = false;
>  	if (OCSD_DATA_RESP_IS_FATAL(dp_ret))
>  		return -1;
>  
> @@ -146,8 +148,10 @@ static void cs_etm_decoder__print_str_cb(const void *p_context,
>  					 const char *msg,
>  					 const int str_len)
>  {
> -	if (p_context && str_len)
> -		((struct cs_etm_decoder *)p_context)->packet_printer(msg);
> +	const struct cs_etm_decoder *decoder = p_context;
> +
> +	if (p_context && str_len && !decoder->suppress_printing)
> +		decoder->packet_printer(msg);
>  }
>  
>  static int
> -- 
> 2.28.0
> 
