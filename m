Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F62F4308C0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245702AbhJQMjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245677AbhJQMjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:39:02 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA873C061765
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 05:36:52 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id s1so7580731plg.12
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 05:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oPvgJePPPBGbk8CW4Cm7B5m1/jymObsgz0pZkmP9Ef4=;
        b=lp3WHIE32fPaO3XawzQCwVOWXW5PLHElCa8VcFcbpcVoQFDVeONnA2Kbrj2yevKHwP
         bGPzLFHE8Zs6iJ+1Ar1XM/IT+sX8mch/4stT3BrVKql4fWFc+FWXSgKLUm+fItxiyI6Y
         JQSocx8NHvtdy9o8JXvXvn0nKjX2bpwlygGAQVtnzzjy3Au97jwb97d2OhiphKTFw8jr
         Gj2Wj71i22U+563cE+Jeu4hP9M3ZZi9mBl4Ip/6kh16GRZhR7dJQnpd09t3CA8jIzc61
         1nNDgkcF6FiDRkTlSlLyX2cHsXGzYnudulqt+nZSbTf2yLCuvbWlopx5E1wIjo6RTNR7
         a/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oPvgJePPPBGbk8CW4Cm7B5m1/jymObsgz0pZkmP9Ef4=;
        b=kdnXajZK1AMmqfzLSjjtSwOOlhNJZrrVSBcUJvkhllM2dYK6viS1bADkD/0Jscil4/
         lj4/Alyd3D2HmEPHBZ6rT63hw4pKH8uVwDeP0VvlGFzxlieyUE2loDSiJ6KuxLvQgJ9Q
         IdwkOrBYHbquIq+UbUmmqpzvwCiR+9R2+FzeHdIWJ9JwyCO5g+dN1GfGRB8QwcZ3KECy
         vLBOFiHuj1l7kf/ceS0l3NaTo+RHYY68lHvg6/V9+CDg4JZBmV3ldWCYSwUadj/kfFjZ
         LDR2P7pxqegIi/HMma8htz7DLoLdTLWN/5UbEMW+qxEDz8lOVcu+R5b/G+wxzKJ2qK7r
         KggQ==
X-Gm-Message-State: AOAM530m5oo5gUUPnE+RuCbE1F00v+VVDhxVIpWRdb+DktCNn5uM9YL6
        KvAStPbbCZPKIApExRD7wPzKjQ==
X-Google-Smtp-Source: ABdhPJwz2fdpS5sQkuZLqAK1HrQMi++7H83aRWHfRxdAe96fuAfHWyHJmMCI7Vmzx88o2V/ndJc8wQ==
X-Received: by 2002:a17:90b:3809:: with SMTP id mq9mr26762607pjb.7.1634474212020;
        Sun, 17 Oct 2021 05:36:52 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([148.163.172.147])
        by smtp.gmail.com with ESMTPSA id 21sm16373500pjg.57.2021.10.17.05.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Oct 2021 05:36:51 -0700 (PDT)
Date:   Sun, 17 Oct 2021 20:36:46 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     German Gomez <german.gomez@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Subject: Re: [PATCH 4/5] perf arm-spe: Implement find_snapshot callback
Message-ID: <20211017123646.GC130233@leoy-ThinkPad-X240s>
References: <20210916154635.1525-1-german.gomez@arm.com>
 <20210916154635.1525-4-german.gomez@arm.com>
 <20211017120546.GB130233@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017120546.GB130233@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 08:05:46PM +0800, Leo Yan wrote:

[...]


> To allow arm_spe_buffer_has_wrapped() to work properly, I think we
> need to clean up the top 8 bytes of the AUX buffer in Arm SPE driver
> when start the PMU event (please note, this change has an assumption
> that is meantioned in another email that suggests to remove redundant
> PERF_RECORD_AUX events so the function arm_spe_perf_aux_output_begin()
> is invoked only once when start PMU event, so we can use the top 8
> bytes in AUX buffer to indicate trace is wrap around or not).
> 
> 
> diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> index d44bcc29d99c..eb35f85d0efb 100644
> --- a/drivers/perf/arm_spe_pmu.c
> +++ b/drivers/perf/arm_spe_pmu.c
> @@ -493,6 +493,16 @@ static void arm_spe_perf_aux_output_begin(struct perf_output_handle *handle,
>         if (limit)
>                 limit |= BIT(SYS_PMBLIMITR_EL1_E_SHIFT);
> 
> +       /*
> +        * Cleanup the top 8 bytes for snapshot mode; these 8 bytes are
> +        * used to indicate if trace data is wrap around if they are not
> +        * zero.
> +        */
> +       if (buf->snapshot) {
> +               void *tail = buf->base + (buf->nr_pages << PAGE_SHIFT) - 8;
> +               memset(tail, 0x0, 8);

Here need to add below code for flushing data cache:

                 flush_dcache_range((unsigned long)tail, (unsigned long)tail+8);

Sorry for spamming.

Leo

> +       }
> +
>         limit += (u64)buf->base;
>         base = (u64)buf->base + PERF_IDX2OFF(handle->head, buf);
>         write_sysreg_s(base, SYS_PMBPTR_EL1);
