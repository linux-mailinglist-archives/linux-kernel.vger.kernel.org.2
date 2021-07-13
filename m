Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D40E93C7389
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 17:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhGMPwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 11:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237005AbhGMPwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 11:52:41 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5D5C0613E9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:49:51 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id v7so21995514pgl.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jul 2021 08:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xIr7FKkevos4uJS/s/2W3WMmX7MImMI8fcXTB3RkfNY=;
        b=ld1ysusVDnVFh7auocWjpLwv4c2/uGDwjHNxZqgOt2LPGuahJsVCZsBfzcYpirpPU4
         IIQAfcolkuLX7zZ9KoQflvMbX9JK56qTDf/N9syv+ro2lYtEsEyuOHH/+M1JMijKeEcw
         ZrMGPiObM7dLrNbM8A+QHaiP1H7uyauZ5wYAZnXWyjNh6An7f8POLOz2FIKFZvxfKbO6
         ZZL0dEBja488ed431/yduACNztDNtvu1e9fS4AxQeh7MsywlHyxGOG2xPxKIH/Hy1eR9
         Mww+icrX4Xa5G02y3NbSWXdXc1LwAoal1Ipgy9brOlJE9VSiM2U9T66dOsp4ttIfGqzn
         TgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xIr7FKkevos4uJS/s/2W3WMmX7MImMI8fcXTB3RkfNY=;
        b=US0EYQ/6Z5HiCqoBfC2vq8iRCFRrIy24UzNPGrgEb9+yPdInvsIU6MQdIv0L16aUQC
         9EWufRgjanN/O2xcpCSZoDpqFYFz0VAYKR7uklDNB+Z0X4UvgAlBZyhATecPAUbwWk+h
         m7ftC8IbG4JUjnBot+VtV0ADVXyVGBdEJ+ILKIJBNTe81UvAtLX3h6AyKWDwivnyPUfw
         KuW1ee1Yd6EaWTA88+8BnXDYNT1E0Uo/zauHqhjw+yy+H4L56B2TsZl72DpSeJJeAD8G
         qOD9Mfg0dw1H495JpvNuMVrG7EafvmE4BFDgrL4OeQuob5Bko/t1lJZcarWtcGnIcNNT
         TGAw==
X-Gm-Message-State: AOAM533jU4wYwhDHXoYbU4vBONFfWl8Q4jNHSTSVqGP97vrpmRpilikQ
        ZbWcpZ18dj5LdgFwI5/7rp9vvw==
X-Google-Smtp-Source: ABdhPJzpe3HJtSU8mjK2lE1MRl7KBnXXIR52RtNoTejDMu+Emz7S0efhdZHCv0Xha2xqI10oHmWDRQ==
X-Received: by 2002:a63:ed4b:: with SMTP id m11mr4987313pgk.14.1626191390733;
        Tue, 13 Jul 2021 08:49:50 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id a6sm17015325pjq.27.2021.07.13.08.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 08:49:50 -0700 (PDT)
Date:   Tue, 13 Jul 2021 23:49:35 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 03/11] coresight: tmc-etf: Add comment for store
 ordering
Message-ID: <20210713154935.GF748506@leoy-ThinkPad-X240s>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-4-leo.yan@linaro.org>
 <20210713125606.GB4170@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713125606.GB4170@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 13, 2021 at 02:56:06PM +0200, Peter Zijlstra wrote:
> On Sun, Jul 11, 2021 at 06:40:57PM +0800, Leo Yan wrote:
> > AUX ring buffer is required to separate the data store and aux_head
> > store, since the function CS_LOCK() has contained memory barrier mb(),
> > mb() is a more conservative barrier than smp_wmb() on Arm32/Arm64, thus
> > it's needless to add any explicit barrier anymore.
> > 
> > Add comment to make clear for the barrier usage for ETF.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/hwtracing/coresight/coresight-tmc-etf.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > index 45b85edfc690..9a42ee689921 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
> > @@ -553,6 +553,12 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
> >  	if (buf->snapshot)
> >  		handle->head += to_read;
> >  
> > +	/*
> > +	 * AUX ring buffer requires to use memory barrier to separate the trace
> > +	 * data store and aux_head store, because CS_LOCK() contains mb() which
> > +	 * gives more heavy barrier than smp_wmb(), it's not necessary to
> > +	 * explicitly invoke any barrier.
> > +	 */
> >  	CS_LOCK(drvdata->base);
> 
> 'more heavy' is not a correctness argument :-)
> 
> The argument to make here is that CS_LOCK() ensures completion /
> visibility of the hardware buffer.

Will correct for this, thanks for reminding!
