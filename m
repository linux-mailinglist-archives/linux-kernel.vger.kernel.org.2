Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014C2446C3C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 04:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbhKFDfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 23:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232715AbhKFDfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 23:35:00 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67297C061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 20:32:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id j9so9930829pgh.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 20:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kPw4IpQgVBr/ID80OekzGmZKKaWfDwtzZQlyt4TvPck=;
        b=WAi+C8/Ck8zZ0zAPSHoEakdHLL+EjKgGG6vUEqDWiAP+aOofMnXUPSfAw86q4mgO+g
         kHJ8YFyKAi38co/Cg1Vref/EzgQrBw7IiimsN09gvkvUUB0Hctu1ua7G6EuMpxXJlhmG
         9TGQIyWHLdoZViQKT+ba52KUi1sSx1d3Rg8TC/AmUxdvtmZYE/by6AYmphSPw6wMcKN3
         NEWp/kZhJyw/1lasVZOLlL/FtJReS+F1DUCxvR/55nsY4rwQ0Lz+XzhpYV+SX0L9Ku8z
         o8ChK3jAjD8fIyYSf7I+mviVbKARRVnKgGgGE3FNs09jh6NkpDxiRUk+Oh//qmJLoaul
         NAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kPw4IpQgVBr/ID80OekzGmZKKaWfDwtzZQlyt4TvPck=;
        b=PsP6G8HPqwmFGaHNTNYhKpAaMvqss+dl8guYN8mV7MRbGjXP4VM29So7+jT9vfZTil
         zmFngAIXVabrsZ8+EQ4kdFmOIgZU1MekKvQiD3tFPnHXlDtyABbiwwQSC79/vZ6HJ9Wf
         55CtAzYurOCYo3sBBvszz/U5Ya+Kd9xcNzFZiHJs8jeO6v/WjJwJ/0eJCHIPz4toBDAE
         XIymMOqXTe+8DWVJXP38+zRM5u9DHag8ZR/GBrDofnJFamNAed62RIs4EpgqJ4Bclv6g
         rEID/ilo3LrZT72H4s2o5hDUo6SCeoyw+vtZ7VfyMdvCLpY5EAC9mvJipokfgRQhbQot
         IJng==
X-Gm-Message-State: AOAM532Ck2WUrFwz5p387m9ANu1DjzFi0tFXV2ca/6iwh5MiR4DCV/E1
        /6bWl/aNUhOaCpl26KCbMnFupw==
X-Google-Smtp-Source: ABdhPJzw6SsCiB4uzMEDwuRTSSnGPepGGpqVQ+/aFnAW3PQvPu/K8rK4c3kiilDUM2Xm/4jruhK1sg==
X-Received: by 2002:a62:7cd3:0:b0:494:6e78:9959 with SMTP id x202-20020a627cd3000000b004946e789959mr13846321pfc.46.1636169539171;
        Fri, 05 Nov 2021 20:32:19 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id y4sm9048024pfi.178.2021.11.05.20.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 20:32:18 -0700 (PDT)
Date:   Sat, 6 Nov 2021 11:32:13 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/3] perf arm-spe: Save context ID in record
Message-ID: <20211106033213.GH477387@leoy-ThinkPad-X240s>
References: <20211102180739.18049-1-german.gomez@arm.com>
 <20211102180739.18049-3-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211102180739.18049-3-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2021 at 06:07:38PM +0000, German Gomez wrote:
> This patch is to save context ID in record, this will be used to set TID
> for samples.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: James Clark <james.clark@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 2 ++
>  tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> index 32fe41835..1b58859d2 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
> @@ -151,6 +151,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>  	u64 payload, ip;
>  
>  	memset(&decoder->record, 0x0, sizeof(decoder->record));
> +	decoder->record.context_id = -1;
>  
>  	while (1) {
>  		err = arm_spe_get_next_packet(decoder);
> @@ -180,6 +181,7 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
>  		case ARM_SPE_COUNTER:
>  			break;
>  		case ARM_SPE_CONTEXT:
> +			decoder->record.context_id = payload;
>  			break;
>  		case ARM_SPE_OP_TYPE:
>  			if (idx == SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC) {
> diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> index 59bdb7309..46a8556a9 100644
> --- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> +++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
> @@ -38,6 +38,7 @@ struct arm_spe_record {
>  	u64 timestamp;
>  	u64 virt_addr;
>  	u64 phys_addr;
> +	u64 context_id;
>  };
>  
>  struct arm_spe_insn;
> -- 
> 2.25.1
> 
