Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2997C3DC425
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 08:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232262AbhGaGub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 02:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbhGaGua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 02:50:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8436C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:50:23 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id g23-20020a17090a5797b02901765d605e14so17536697pji.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Scp0XsH/8g/xK4xKxJDwfK0sTyUpWpPn5qW5XBp4RlQ=;
        b=t5KuRMuqXwprgBmPyYSxKUd9krVCGGA1/xFNfgaXMbWzxfPTXEG3OEi+Pa0OSrxk51
         HD841NZ6TGnggbZXbFfK5Y96Vg6U+w2CtczwKpMsaRA83Qylg6Vmi98cFMDopiEq9Qjv
         HMnOZNaLE4Oe6e2uXI+ElUBf9dSqD55l6oE470aYX0v0oyAxBcp/Q/Ty/sCsy6RQnekk
         6HWpWqrmzvVtxiG4c5ckM0DvM06cAd6/R6JXBGbSrwnp3MVCosssqU/vcmJc/ltpCh9K
         tcQK8ZganY6dzHe0CwjEduNH4rxJLjM9STZUSvURpuIDdqz62OobXT3en/qIocQjLoUN
         vFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Scp0XsH/8g/xK4xKxJDwfK0sTyUpWpPn5qW5XBp4RlQ=;
        b=Wm85eATQ5jUW+d52EOHlEEcH7+H5qXRSK78aNKNBgzKBQc5sl+CqaL33idSZbHGcQX
         yrtBZa1CP0Z3EG1ArNt656eXiRU/tCHfJlrUMosN74qll2wBa56aUIDXnjofdYbTK3ml
         s9CJVXIluTfqICda0Ux/Zyan0OIjgYgQI0zAKPmfI/32NYdxVsYIlyUdL2HRCprKt+VS
         /fQWD9iTIjOo57Sgg0Gjm4149gYY1vTrEjbQ579mVrFe+dsQbWaxuV+iuCfWyOQsc5nv
         HimkNIcexJqN0/y3xI+FBPzPyvaljalFuGDrDRhweWkWlijdM8Gryis37cKpBwfTFafM
         kOKA==
X-Gm-Message-State: AOAM531YYqkWi5ayWicOLUHC76eV8/8t/T60w2JrFff9CuQW/8UF9kuv
        1xwuCU/CTUnPdLG1kX5oWRtFcQ==
X-Google-Smtp-Source: ABdhPJyPuhbQY1xaqyLCuAYgPVh0gLGVPKGQCpoB6z7QVm3rnjclpY3xMn1x90IcjsEf9JHsoC15nQ==
X-Received: by 2002:a17:902:76cb:b029:12b:2fb8:7c35 with SMTP id j11-20020a17090276cbb029012b2fb87c35mr5751825plt.16.1627714223124;
        Fri, 30 Jul 2021 23:50:23 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.43])
        by smtp.gmail.com with ESMTPSA id g3sm4423116pfi.197.2021.07.30.23.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 23:50:22 -0700 (PDT)
Date:   Sat, 31 Jul 2021 14:50:12 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     acme@kernel.org, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, al.grant@arm.com,
        suzuki.poulose@arm.com, anshuman.khandual@arm.com,
        mike.leach@linaro.org, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/6] perf cs-etm: Update OpenCSD decoder for ETE
Message-ID: <20210731065012.GD7437@leoy-ThinkPad-X240s>
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-5-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721090706.21523-5-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 10:07:03AM +0100, James Clark wrote:
> OpenCSD v1.1.1 has a bug fix for the installation of the ETE decoder
> headers. This also means that including headers separately for each
> decoder is unnecessary so remove these.
> 
> Signed-off-by: James Clark <james.clark@arm.com>

IIUC, only the later patches in this patch set are dependent on OpenCSD
v1.1.1.  After I checked OpenCSD latest header, this change LGTM:

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/build/feature/test-libopencsd.c           | 4 ++--
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 --
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/build/feature/test-libopencsd.c b/tools/build/feature/test-libopencsd.c
> index 52c790b0317b..eb6303ff446e 100644
> --- a/tools/build/feature/test-libopencsd.c
> +++ b/tools/build/feature/test-libopencsd.c
> @@ -4,9 +4,9 @@
>  /*
>   * Check OpenCSD library version is sufficient to provide required features
>   */
> -#define OCSD_MIN_VER ((1 << 16) | (0 << 8) | (0))
> +#define OCSD_MIN_VER ((1 << 16) | (1 << 8) | (1))
>  #if !defined(OCSD_VER_NUM) || (OCSD_VER_NUM < OCSD_MIN_VER)
> -#error "OpenCSD >= 1.0.0 is required"
> +#error "OpenCSD >= 1.1.1 is required"
>  #endif
>  
>  int main(void)
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 5972a8afcc6b..60147c908425 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -13,8 +13,6 @@
>  #include <linux/zalloc.h>
>  #include <stdlib.h>
>  #include <opencsd/c_api/opencsd_c_api.h>
> -#include <opencsd/etmv4/trc_pkt_types_etmv4.h>
> -#include <opencsd/ocsd_if_types.h>
>  
>  #include "cs-etm.h"
>  #include "cs-etm-decoder.h"
> -- 
> 2.28.0
> 
