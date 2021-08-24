Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2BF3F58C3
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhHXHQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbhHXHQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:16:03 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A1AC061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:15:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w8so18948875pgf.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 00:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B3DZwCiGkVmNfPs1kmc6eZRdfoDwLSE7ympCa4vCBUg=;
        b=Fs/ZdbDcAvJqK8Trhuf8JiuGwFl15mu7dBco02aPCOND1UIfOy9XmQxHxJ1YoohJJc
         a9b1LM2QZD0IiPb1JRTf5LCRqVTg5q0jqjKaPAXWylBEbTkMpqlFm9+2zdL8275ZDdD1
         0BEYscZdh57ugxFVka8EgiAdQXG625nhmEGAlXpm8Upqg7L2casssqHKEVe06+YmZUYZ
         72dbBprGjfxop6JmwYJSE2oVC1efjVd8SpzsG86B1nJa1+Z1gOHexmOJ9gi+k82JAtUP
         ck3LG//oy+GwFOivmJjlM9+inn6hfSxZBvs5GFfwDFseXSGm7NXrD+oC/KVAy8iEPSVc
         jrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B3DZwCiGkVmNfPs1kmc6eZRdfoDwLSE7ympCa4vCBUg=;
        b=frAJ3bwQM819LM811FITbKKrGVAtoIFo1AeXHsEdYJjMmZGN7CdP96aJ5kaBFbtayr
         8nGMunaauQe6Q6hrjpP8j7LdoxM5JpQd6VveJffiChJ741UH9a6TURuqup321c+kN5HO
         qUdydICtm8eidqXfKJ6PtlulDn6G+LZevvhY2/xhNn96J4jXdPB0GWT58MvZkJCBfUKs
         Z0MpeLC5fS0L0aj2b0mnxe5SXyMTeZhdu3Vihh/G/79z8M2MvYXegAarRrUGVeGWC9Sv
         LGbHqG7Vn67UL/rkMjn3Qur0B3i65rUTSV+IXTrKGLxOVQX87sd8WQPKu40Qn4EnxA4q
         +BFg==
X-Gm-Message-State: AOAM532/20SKpafQf1CBpOlDIkZu9zgOrd/8rEP2/DcNdq6+A2jY55Kf
        UTpoE5cbktAQd6DtTKjA3LvCEw==
X-Google-Smtp-Source: ABdhPJxsJjt/+GrwzodZdK9JxfM9zhKNEtTJFTKuMswEg0BpwVNBD9iVU5Yh+vnx/blg+cMNXJbVtA==
X-Received: by 2002:a63:1460:: with SMTP id 32mr35737205pgu.323.1629789319757;
        Tue, 24 Aug 2021 00:15:19 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id t14sm21260147pga.62.2021.08.24.00.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 00:15:19 -0700 (PDT)
Date:   Tue, 24 Aug 2021 15:15:12 +0800
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
Subject: Re: [PATCH v2 5/9] perf cs-etm: Fix typo
Message-ID: <20210824071512.GD204566@leoy-ThinkPad-X240s>
References: <20210806134109.1182235-1-james.clark@arm.com>
 <20210806134109.1182235-6-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806134109.1182235-6-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 02:41:05PM +0100, James Clark wrote:
> TRCIRD2 should be TRCIDR2
> 
> Signed-off-by: James Clark <james.clark@arm.com>

Reviewed-by: Leo Yan <leo.yan@linaro.org>

> ---
>  tools/perf/arch/arm/util/cs-etm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> index e3500b79d972..515aae470e23 100644
> --- a/tools/perf/arch/arm/util/cs-etm.c
> +++ b/tools/perf/arch/arm/util/cs-etm.c
> @@ -75,7 +75,7 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
>  	if (!cs_etm_is_etmv4(itr, cpu))
>  		goto out;
>  
> -	/* Get a handle on TRCIRD2 */
> +	/* Get a handle on TRCIDR2 */
>  	snprintf(path, PATH_MAX, "cpu%d/%s",
>  		 cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR2]);
>  	err = perf_pmu__scan_file(cs_etm_pmu, path, "%x", &val);
> -- 
> 2.28.0
> 
