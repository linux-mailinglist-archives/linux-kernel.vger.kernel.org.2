Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12B5E345879
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhCWHT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbhCWHTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:19:50 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB62C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:19:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id s21so9700208pjq.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BPquWIfp6E7g9HIeoKveZqVwGYBc5+UjaXcfopywIAg=;
        b=csNqnxz+3yqhBUxQfHtn4xR38Z5vSRTJP9PBv448TYYs+pZSQlMpcsCiGijiSA9zBu
         izPev4j5TRwj2FepauT5Mg+sa+c3TbjavWrpIC/o8EW79xSJoATLor07UOJJsH53HOx9
         EXAJiRwYAE4BZGtNRyoYcNAVC3akuvft72C80Ie/cHZDB+6PLxynIs9f0v1ynBggh1cW
         Yq9hvG2SrdaX8ZqzSYykf+dl+ZFEOuCoIWrJUUffwIYR1hJvTGBWEyWRmVfX4M4XnWff
         9L7tT5fDLoWAPYUCIIXdgEYQDSbP5byoBmne5havqwX2oRDsRZJ3d2TnR7Cx6Bv5ND/0
         4n8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BPquWIfp6E7g9HIeoKveZqVwGYBc5+UjaXcfopywIAg=;
        b=s+ooMIQ2KF2N4PRB02KMdU7jk+7tul8J/o8VUdcX5RCsn/yulZEDZFju3lOKAhhSh4
         Uqu+cOlufglfQBWZuV/SrdEuqNOb6SGrG4eNbINRwa0m2yWyGBG5xHT5DrV0tPoILNMS
         UFjGELhJ3MX8k4GUriwxfyaZqDHiugsXWg5aAysOrOhkCXdDlpIMjMYQUFIH7pBSCu8b
         Edmc/6YdWlIzKZS6nBwuvRSd2pKe0Ge7ODcSMkUJr1j3eLQmeSXo7DeFJvyS3dgCFCw1
         EAbR/2w3mmmS9Ux4vQS7zJx1SrSZe53JfNtLvGIZKezOTwHeXCYMY04ZMUR31N7Uxv9V
         TGUQ==
X-Gm-Message-State: AOAM530KQ8zApAU3ZG+w9HhsxaeRPq4asLJsMft/M+12GA2Cf8p2clUg
        b1hm6gU+2LFb/Owb/dHcbc5oPg==
X-Google-Smtp-Source: ABdhPJxx1bUOKQ1IxfOZGUNrFItZZ5NIqZkAfRU8xAVL6+uawqnr0rqmMJQXl33Wd88ygrGq4ptviA==
X-Received: by 2002:a17:90a:f68a:: with SMTP id cl10mr3171398pjb.87.1616483989591;
        Tue, 23 Mar 2021 00:19:49 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id l3sm15427132pfc.81.2021.03.23.00.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 00:19:49 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:19:44 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] coresight: etm-perf: Mark format_attr_contextid
 with static keyword
Message-ID: <20210323071944.GA55918@leoy-ThinkPad-X240s>
References: <20210323075452.38920-1-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323075452.38920-1-zou_wei@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 07:54:52AM +0000, Zou Wei wrote:
> Fix the following sparse warning:
> 
> drivers/hwtracing/coresight/coresight-etm-perf.c:61:25: warning: symbol
> 'format_attr_contextid' was not declared. Should it be static?
> 
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  drivers/hwtracing/coresight/coresight-etm-perf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 0f603b4094f2..bdbb77334329 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -58,7 +58,7 @@ static ssize_t format_attr_contextid_show(struct device *dev,
>  	return sprintf(page, "config:%d\n", pid_fmt);
>  }
>  
> -struct device_attribute format_attr_contextid =
> +static struct device_attribute format_attr_contextid =
>  	__ATTR(contextid, 0444, format_attr_contextid_show, NULL);
>  
>  static struct attribute *etm_config_formats_attr[] = {
> -- 
> 2.17.1
> 
