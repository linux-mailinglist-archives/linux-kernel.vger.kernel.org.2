Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A5536AC55
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 08:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbhDZGpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 02:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhDZGpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 02:45:08 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C507AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 23:44:27 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v13so14800464ple.9
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 23:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2ta9gXjXgcquWRvrXKtAiy1yF32B2OLE+lPZ5gmEnYA=;
        b=qAhSyvwP4dBeahZgAFcMiicRnQVdHF5bCk0YRPtKVj7P0zrps2zVuV4QyXwhI2eAQG
         DsaaUEBzLqADzggHAiqi0WTz9Wv2YMW761SjCfj885otU5QUIADbbt7wrm5DlIY6TsUt
         w+3dUV/0jQ330O3D+CQSNZxht1Evesznd81U9VeL5g2rpFKaPCCVgacGI2eQFN+3owNU
         2hle2ZhRyOrlRsDVQXPtz5lciXv+Ywr5RPlw2uqH33ojfOM5vee0nCVmM7MuGqq5uvbF
         4iC0Iy5pxxP/EMrXTA4tdAQPqFeUoiFQFhSROXgBehViTy3Ekb/D00s6XomOmykBteSs
         2lfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2ta9gXjXgcquWRvrXKtAiy1yF32B2OLE+lPZ5gmEnYA=;
        b=M1dRWCptjWV7oQuRI/Av7AprdgM+XGpguNmwjmo6ioktS70p9pmKwNJyv7cMvMJdoY
         zgzY+w3XkXJiWidrWlebgGtFf0/648UmUbN8dixFkxoU3Zh80MZUrJc5itbsoYmt8b6X
         Cy9lALh1ymB6oqs8OZ0puD1ha/jQgmjtzJ0Rcy3iQ6mZ4G1fpw18KsVY81KERj3Kwr5D
         iDry9tCjTOuIm+3U422UUHHJ+kjjpqIDoV4ia2jykDrL1c3VW8GrwSTD8PGKDV8MUEwq
         iYO0GGUpcEusNOZGSltKAzoY4MhsAiJkm60NB90fjbZm/BL3Gb9LnBz84l8UuRLpipt+
         KwRQ==
X-Gm-Message-State: AOAM533Jyp1bSynUPO+gkqFIbQzR75bPWaX0d3dKpdjWEQ3yl0tHeD8W
        sr9HCvJGKAoCc0Y0aqItJSOaFA==
X-Google-Smtp-Source: ABdhPJwhLywn2n1pr1B0bMLhgNfisa0K0M8hkl95VsKIf0QptA4M9YHrXnF58xZi5bsEjlDHMNmxIA==
X-Received: by 2002:a17:90a:f68f:: with SMTP id cl15mr693214pjb.99.1619419467293;
        Sun, 25 Apr 2021 23:44:27 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id z22sm9938387pgf.16.2021.04.25.23.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 23:44:26 -0700 (PDT)
Date:   Mon, 26 Apr 2021 14:44:21 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] perf session: Add swap operation for event
 TIME_CONV
Message-ID: <20210426064421.GA327854@leoy-ThinkPad-X240s>
References: <20210412083459.462817-1-leo.yan@linaro.org>
 <20210412083459.462817-3-leo.yan@linaro.org>
 <1b4fa7c3-79cd-6f73-873e-4792b8a1b732@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b4fa7c3-79cd-6f73-873e-4792b8a1b732@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, Apr 26, 2021 at 08:40:00AM +0300, Adrian Hunter wrote:

[...]

> > +static void perf_event__time_conv_swap(union perf_event *event,
> > +				       bool sample_id_all __maybe_unused)
> > +{
> > +	size_t time_zero_size;
> > +
> > +	event->time_conv.time_shift = bswap_64(event->time_conv.time_shift);
> > +	event->time_conv.time_mult  = bswap_64(event->time_conv.time_mult);
> > +	event->time_conv.time_zero  = bswap_64(event->time_conv.time_zero);
> > +
> > +	time_zero_size = (void *)&event->time_conv.time_cycles - (void *)event;
> > +	if (event->header.size > time_zero_size) {
> 
> I wonder if we could have a helper for this e.g. (untested)
> 
> #define event_contains(obj, mem) (obj.header.size > offsetof(typeof(obj), mem))
> 
> 	if (event_contains(event->time_conv, time_cycles)) {

Yeah, this is a better implementation.  Will refine patch for this.

> > +		event->time_conv.time_cycles = bswap_64(event->time_conv.time_cycles);
> > +		event->time_conv.time_mask = bswap_64(event->time_conv.time_mask);
> > +		event->time_conv.cap_user_time_zero =
> > +			bswap_32(event->time_conv.cap_user_time_zero);
> > +		event->time_conv.cap_user_time_short =
> > +			bswap_32(event->time_conv.cap_user_time_short);
> 
> 'struct perf_record_time_conv' contains bool, the sizeof which, AFAIK, is not defined.
> Is it really 4 bytes on your implementation?  It is only 1 byte with gcc on x86.

On Arm64, bool is also 1 byte with GCC.

When working on this patch, I checked the size for structure
perf_record_time_conv, it gave out the structure size is 56; I wrongly
thought the bool size is 4 bytes and there have no padding.  In fact,
bool size is 1 byte and GCC pads 6 bytes at the end of structure.

> Either way, you should change 'struct perf_record_time_conv' so it uses a type of known size.
> Since you are the only one using it, it should match your implementation.

Will change to "unsigned int" value.  Thank you for reviewing and
suggestions.

Leo

> > +	}
> > +}
> > +
> >  typedef void (*perf_event__swap_op)(union perf_event *event,
> >  				    bool sample_id_all);
> >  
> > @@ -985,7 +1005,7 @@ static perf_event__swap_op perf_event__swap_ops[] = {
> >  	[PERF_RECORD_STAT]		  = perf_event__stat_swap,
> >  	[PERF_RECORD_STAT_ROUND]	  = perf_event__stat_round_swap,
> >  	[PERF_RECORD_EVENT_UPDATE]	  = perf_event__event_update_swap,
> > -	[PERF_RECORD_TIME_CONV]		  = perf_event__all64_swap,
> > +	[PERF_RECORD_TIME_CONV]		  = perf_event__time_conv_swap,
> >  	[PERF_RECORD_HEADER_MAX]	  = NULL,
> >  };
> >  
> > 
> 
