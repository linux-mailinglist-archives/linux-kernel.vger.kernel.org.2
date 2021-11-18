Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4E49456139
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 18:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbhKRRRW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 12:17:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbhKRRRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 12:17:17 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D422C061574
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:14:17 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id b68so6656815pfg.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Nov 2021 09:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J+5qoZN6RFmZ8I4gX8ZKa9PdwhWdgu4uQ/QeSOkGnT4=;
        b=TSa+pkzB5HxxShH4xzazQWj/w5WlJOkeq9niNmoDmtSak5kedy1zQTDygLFf8tvX8F
         XHDNTGf7VfcjX/oNgOax4AKiJq+cIpi1aR4gic7AuVhFdqe64hJ0Wm8HJ29lGSqXZBCq
         UYPDlWc2pVy1AaV9pixcGiuoMHl8U35mRM8vp/Dyy1mpcZGomlg8Z+WVQuWF1gG29O70
         ZihfStszLVRHs2bWtyf6sngdvVRQQ9d/INeRJvtD+rI/EJT83EfFd05HcC2W1+Q0CAD9
         FocP7Zh1qIcUTmBOaqdkny0H/mOsNuKHVFAlRu17/aanCq0ac9dYQF0xOchC68TyuB8i
         2czQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J+5qoZN6RFmZ8I4gX8ZKa9PdwhWdgu4uQ/QeSOkGnT4=;
        b=jUBqS28SW84IHdAtJVDFBLTL8EtYKIPACbnwH+gHZZ3Ffneb8fml4uT/PW9eodkQov
         GhyHu7+fqqRVswsDKvpdXlcU+g8THTXuQJP4J0gDyWVI3fl7epfqf+G78gYbf4p2wRUa
         5py/iTOZEij3CAKuQAOLfGvYW4UiNAVKEg39oYauzDF6hLxin0FBt21d5ddrdYzThetU
         Zh+K8habYlk+2U92eisYNTpi9iLgm1BumHc4setUDnEupLSrpf9CMOh8vxZ0dUQhwg1c
         +NPiJyxTRIhlIBBrtgeKsdRvibzH0VQc8nUCeXN3srsUkaKo8kfKXFLfT5aekuR82KqJ
         /IWA==
X-Gm-Message-State: AOAM532NBbOZfl+GBPJHp82GPTxW9YtM9tPkg/vjs8N4gdBMb67Q2ErJ
        zebTJHWEgX5w2o/aaYR9DsZWtQ==
X-Google-Smtp-Source: ABdhPJyC5yO7VYar9XM1O9Y16uC2oeR27KBNZfFJ+wvJfp3UpQLLsPuJSfTDFqrEcufxnvHW73mTBg==
X-Received: by 2002:a05:6a00:2290:b0:49f:c63a:2a5f with SMTP id f16-20020a056a00229000b0049fc63a2a5fmr57690492pfe.69.1637255656872;
        Thu, 18 Nov 2021 09:14:16 -0800 (PST)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f15sm212467pfe.171.2021.11.18.09.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 09:14:15 -0800 (PST)
Date:   Thu, 18 Nov 2021 10:14:12 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf cs-etm: Pass -1 as pid value for
 machine__set_current_tid()
Message-ID: <20211118171412.GB2530497@p14s>
References: <20211113143540.53957-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211113143540.53957-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Leo,

On Sat, Nov 13, 2021 at 10:35:40PM +0800, Leo Yan wrote:
> Currently, cs-etm passes the tid value for both tid and pid parameters
> when calling machine__set_current_tid(), this can lead to confusion for
> thread handling.  E.g. we arbitrarily pass the same value for pid and
> tid, perf tool will be misled to consider it is a main thread (see
> thread__main_thread()).
> 
> On the other hand, Perf tool only can retrieve tid from Arm CoreSight
> context packet, and we have no chance to know pid (it maps to kernel's
> task_struct::tgid) from hardware tracing data.  For this reason, this
> patch passes -1 as pid for function machine__set_current_tid().
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> index f323adb1af85..eed1a5930072 100644
> --- a/tools/perf/util/cs-etm.c
> +++ b/tools/perf/util/cs-etm.c
> @@ -1118,7 +1118,7 @@ int cs_etm__etmq_set_tid(struct cs_etm_queue *etmq,
>  	if (cs_etm__get_cpu(trace_chan_id, &cpu) < 0)
>  		return err;
>  
> -	err = machine__set_current_tid(etm->machine, cpu, tid, tid);
> +	err = machine__set_current_tid(etm->machine, cpu, -1, tid);

I remember wondering about what to do with the pid parameter when I wrote this
patch... 

Do you have a before-and-after snapshot you can add to the changelog?  I also
think it will require a "Fixes" tag.  In your next revision please CC James
since you guys are working in that area nowadays.

Thanks,
Mathieu

>  	if (err)
>  		return err;
>  
> -- 
> 2.25.1
> 
