Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856B841600B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 15:36:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241328AbhIWNhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 09:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbhIWNhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 09:37:32 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E772C061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 06:36:00 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id pf3-20020a17090b1d8300b0019e081aa87bso4953211pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 06:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LJqsayGSV0vpx1xLxjFKNF/KjYBVBG9Ud2Yl5xQheZo=;
        b=D2Rh5rHhzAV1xWW2d/eJUB9j5HU67L2BY92Ko4tZU0fYJMt469/jTf4snBMuv0HODu
         MaCYguDaTCKfeB+gJbasD0PbWzQ22JqgOV3M9ZG1FZ9U+jsRrLi7QGG/YOjPKp/6mOYK
         vTsMUSN1xpVRgLjWUvaCHGfk8lEJNdWk53MfypTBsKKt5tGiNZbRllmzOdSko/3yfZUt
         kOtTiqs24RLPgebhTijL3N7NnXM+TcIBKix/vF6Ys1NyFeYvrkLsq8SXzgSoaeHAFfDC
         w7XjQREBoRSTDUKAwmk/4OfV3pmTjQEMiVLz9tsZXQ6gNLEW7oyoDiCzTB4ZywJmItOn
         P2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LJqsayGSV0vpx1xLxjFKNF/KjYBVBG9Ud2Yl5xQheZo=;
        b=S63GEVUYKiCM+vhCmYc08jk5KKNObSWVLyk7vquUGjsUWUJm/1OUrbPImj/7ii83Ru
         LwgDIjTGFanHNy3GGibQV44tM3S/GQECbCOMLdqpgPFS8/JPL5sbe/RZOoyixEUTEaJz
         ievWQef7ECqqGkIE3wM43Mf7ThwVH+De73e4w3EDJ1ZznFJTSLIfeCn1W7qMO8MkvdiG
         33wHQhirLLuMiepsk4vSVKOdaAhYlsMVDeDUzxXEl80WId8iycDiFXfRs8JnFcvlIS0x
         yclYhQvpIyPwhqaAQq5dYYes6KX+Lpw6nMw8m1yi0JuRtkXKL7ndVOS/GHsgw6WCxkoS
         kbpQ==
X-Gm-Message-State: AOAM533isKeVWe+a6gA2/61xa5sqwstvUo1vpm9pPFtcKRCkuloKMYgc
        LVAMRU30zEvJ6jT7QjD9Xqf9bA==
X-Google-Smtp-Source: ABdhPJy7AdMNlnQsmc7ahmOLVyKj7KOQ0/XwFlLX4I3udO/Hou5pjQYlp3yMffNH8puN+0qemFNS+g==
X-Received: by 2002:a17:90b:4d07:: with SMTP id mw7mr17215427pjb.66.1632404159921;
        Thu, 23 Sep 2021 06:35:59 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([213.173.35.225])
        by smtp.gmail.com with ESMTPSA id p10sm6259198pge.38.2021.09.23.06.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 06:35:59 -0700 (PDT)
Date:   Thu, 23 Sep 2021 21:35:54 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH 2/5] perf arm-spe: Print size using consistent format
Message-ID: <20210923133554.GF400258@leoy-ThinkPad-X240s>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-2-german.gomez@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916154635.1525-2-german.gomez@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2021 at 04:46:32PM +0100, German Gomez wrote:
> From: Andrew Kilroy <andrew.kilroy@arm.com>
> 
> Since the size is already printed earlier in hex, print the same data
> using the same format, in hex.
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> Signed-off-by: Andrew Kilroy <andrew.kilroy@arm.com>
> Signed-off-by: German Gomez <german.gomez@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/util/arm-spe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> index 58b7069c5a5f..2196291976d9 100644
> --- a/tools/perf/util/arm-spe.c
> +++ b/tools/perf/util/arm-spe.c
> @@ -100,7 +100,7 @@ static void arm_spe_dump(struct arm_spe *spe __maybe_unused,
>  	const char *color = PERF_COLOR_BLUE;
>  
>  	color_fprintf(stdout, color,
> -		      ". ... ARM SPE data: size %zu bytes\n",
> +		      ". ... ARM SPE data: size %#zx bytes\n",
>  		      len);
>  
>  	while (len) {
> -- 
> 2.17.1
> 
