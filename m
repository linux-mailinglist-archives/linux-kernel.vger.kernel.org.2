Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA1C421546
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 19:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbhJDRod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 13:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbhJDRoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 13:44:32 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57629C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 10:42:43 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id b22so429814pls.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dO2y9+bfdzEZFh/wkilYc1mXoP9qeWdBq8NEv0mAdf4=;
        b=G0Tyo1GVhmWLaHbDIGf7yb4Q/Rp5vjpVmNvgnGF+MQze6XmH2O02CWD7rxDWfGHilE
         TD9CQaVf3DQsRk8GyJIVFIH8sm+7wGJU3d52JAYO7Vs1NwT2nWZSLWS+ibkrDoxBOkBI
         MITFi+GKwRwlyWPQtnyrIMTbSbBT2NawJggXQBZTXbme8asi4nUcqAqYr4E3ulTANIfX
         DyzQNMp/KEK0kEbTn1i7i6opxNq3K/rHAqGCLbbChY/AidVSoUelDU74JxbwBxl7+pL0
         ryyt7Id9P5Kfte5KMyrSciNnMQ5/mGij4dgJOauKAfLQO4YXTWlfcISVvGDM0TS+4NaB
         RIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dO2y9+bfdzEZFh/wkilYc1mXoP9qeWdBq8NEv0mAdf4=;
        b=5ubOXEogqZpf7HJEuZvGIzg62UWUVSSc+71/j8tnPaxG/jnfSzmKyeuzAqcgkChiR7
         /cgBmiph1PJhHVxrfHYNiNyc3esk/OBCLShYsTguMcJoK+fi4gBuFwYLWIwp0Lv53S3P
         pG3Ey8X0WdFK4aHiayJ+NZXt31NzyenWeIj6XWgdipl7Kg5tYu2BkPtTar6NeOcvPozZ
         IhkwqdTYk/Scc7oQBH2zj2AdltSelJ2XwTeGhCT20GjK9AgYwIVxr8QshvA8+GPwmWXP
         ieq4ESA9xCJe7tSlYaIVnFwDKldrwr4WdflC0dY2iM89ACdNORWki+ppfeoCug5JzZ7G
         527w==
X-Gm-Message-State: AOAM530JiiZQszb185ZRwADcjiX8CpBruVCcXFyjGYitotOa6p1Ibr/+
        V9THGo8xSNW4yQzks4r18MDrcA==
X-Google-Smtp-Source: ABdhPJxmsPdHjvy96hiG5usgWEIqZSTGCKVPzejOVkZBQIrXaUNb1nwHUQ/rtjbqX4P2mPg+LhPwXQ==
X-Received: by 2002:a17:902:c406:b0:13b:7b40:9c5a with SMTP id k6-20020a170902c40600b0013b7b409c5amr846984plk.81.1633369362841;
        Mon, 04 Oct 2021 10:42:42 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id o72sm11108725pjo.50.2021.10.04.10.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 10:42:41 -0700 (PDT)
Date:   Mon, 4 Oct 2021 11:42:39 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        james.morse@arm.com, anshuman.khandual@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, will@kernel.org, lcherian@marvell.com,
        coresight@lists.linaro.org
Subject: Re: [PATCH v2 12/17] coresight: trbe: Add a helper to fetch cpudata
 from perf handle
Message-ID: <20211004174239.GB3263478@p14s>
References: <20210921134121.2423546-1-suzuki.poulose@arm.com>
 <20210921134121.2423546-13-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921134121.2423546-13-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21, 2021 at 02:41:16PM +0100, Suzuki K Poulose wrote:
> Add a helper to get the CPU specific data for TRBE instance, from
> a given perf handle. This also adds extra checks to make sure that
> the event associated with the handle is "bound" to the CPU and is
> active on the TRBE.
> 
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Mike Leach <mike.leach@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Leo Yan <leo.yan@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-trbe.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
> index 983dd5039e52..797d978f9fa7 100644
> --- a/drivers/hwtracing/coresight/coresight-trbe.c
> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
> @@ -268,6 +268,15 @@ static unsigned long trbe_snapshot_offset(struct perf_output_handle *handle)
>  	return buf->nr_pages * PAGE_SIZE;
>  }
>  
> +static inline struct trbe_cpudata *
> +trbe_handle_to_cpudata(struct perf_output_handle *handle)
> +{
> +	struct trbe_buf *buf = etm_perf_sink_config(handle);
> +
> +	BUG_ON(!buf || !buf->cpudata);
> +	return buf->cpudata;
> +}
> +
>  /*
>   * TRBE Limit Calculation
>   *
> @@ -533,8 +542,7 @@ static enum trbe_fault_action trbe_get_fault_act(struct perf_output_handle *hand
>  {
>  	int ec = get_trbe_ec(trbsr);
>  	int bsc = get_trbe_bsc(trbsr);
> -	struct trbe_buf *buf = etm_perf_sink_config(handle);
> -	struct trbe_cpudata *cpudata = buf->cpudata;
> +	struct trbe_cpudata *cpudata = trbe_handle_to_cpudata(handle);

There is two other places where this pattern is present:  is_perf_trbe() and
__trbe_normal_offset().

I have to stop here for today.  More comments tomorrow.

Thanks,
Mathieu

>  
>  	WARN_ON(is_trbe_running(trbsr));
>  	if (is_trbe_trg(trbsr) || is_trbe_abort(trbsr))
> -- 
> 2.24.1
> 
