Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3063236AEE8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 09:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhDZHtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 03:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbhDZHjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 03:39:54 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9535EC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 00:39:12 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f29so2391797pgm.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 00:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bXy/ygoPkgcjegxfI2VhCVQQxDu76KFJsRt94gWCMh8=;
        b=E7J1MTlkT5KHEAWVLxcgEPVNKXMnJVSaMbDMX/Qf3dNzgEZCuk9s9nwBSAVN8v6bTt
         kJMFsIrMrIFr68G8MofmX6yfRlruDcIbxVUX6ApH1D5Q6npuJJBaE4TmFV+Rmjs0t8JA
         sKHPx+sQ6p3cqLg9Ei4eM6sadR/F0xipeGKS1YP3TFJLfKsTTQV7rMCQTbPeA+vM2Ogl
         LZqwNQzA6lZ737dr9GYwve31zyk+nHwp7GTO6yewqv8KxdK0OdtbW/fuoaa1NwTswaqR
         UYDWKU4G6J7GpT1NAP18FMn1y3wR6pc4HjWdB2eiep04WE4n5yh6t7fMeJBCn0+uTITP
         sSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bXy/ygoPkgcjegxfI2VhCVQQxDu76KFJsRt94gWCMh8=;
        b=PAf7NbTzziG/d+HL25DvT912VDsEEBeJlrXyJpbKBwdvKzsRo/jONiUBuRAQWRsHIV
         DYPYqzSl9jGf0Vh/Ap1eyBAuTWEokObpI3uKMCjbOQiwyxH3raj6ghTTI4f8U6COcw79
         CTdBmvks2SZOlzGGxCHy6hM6plFRmMjL7KUC/fEwa0Tgzcr53Hi8b65iyyT5r14klgzW
         28tlAcUUxzIqEzWC1IEE930zkAHaxAUs/frc0MXW2KH+xDvyTDhSD6eY/62+TfOOJc2d
         4C8o+h3tavR5SX+XIiHAZuDKjAE39Jx7Ocoilxnjv24GI0y5Xj715hfGOKprLIx/JnLs
         Apcw==
X-Gm-Message-State: AOAM532bKVzt4QOP2a/w6HST34zIwHr1LS+USoL8DHtibVgzS81AmcWa
        Uxw4eX2m2vRyLcw9XWmTYKCfSA==
X-Google-Smtp-Source: ABdhPJzlLmHB5IdtL9dCM7C/R4HlTc7UlojAcC75hAQmanmwrfX3Vnwdrbyflp8FhxXavmL0NTP2gw==
X-Received: by 2002:aa7:824e:0:b029:20a:3a1:eeda with SMTP id e14-20020aa7824e0000b029020a03a1eedamr16073157pfn.71.1619422751538;
        Mon, 26 Apr 2021 00:39:11 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id 123sm10417766pfz.127.2021.04.26.00.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 00:39:11 -0700 (PDT)
Date:   Mon, 26 Apr 2021 15:39:06 +0800
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
Message-ID: <20210426073906.GB327854@leoy-ThinkPad-X240s>
References: <20210412083459.462817-1-leo.yan@linaro.org>
 <20210412083459.462817-3-leo.yan@linaro.org>
 <1b4fa7c3-79cd-6f73-873e-4792b8a1b732@intel.com>
 <20210426064421.GA327854@leoy-ThinkPad-X240s>
 <7f21edac-1bd9-ab98-aeca-2109e5edf5c3@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f21edac-1bd9-ab98-aeca-2109e5edf5c3@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2021 at 10:26:12AM +0300, Adrian Hunter wrote:
> On 26/04/21 9:44 am, Leo Yan wrote:
> > Hi Adrian,
> > 
> > On Mon, Apr 26, 2021 at 08:40:00AM +0300, Adrian Hunter wrote:
> > 
> > [...]
> > 
> >>> +static void perf_event__time_conv_swap(union perf_event *event,
> >>> +				       bool sample_id_all __maybe_unused)
> >>> +{
> >>> +	size_t time_zero_size;
> >>> +
> >>> +	event->time_conv.time_shift = bswap_64(event->time_conv.time_shift);
> >>> +	event->time_conv.time_mult  = bswap_64(event->time_conv.time_mult);
> >>> +	event->time_conv.time_zero  = bswap_64(event->time_conv.time_zero);
> >>> +
> >>> +	time_zero_size = (void *)&event->time_conv.time_cycles - (void *)event;
> >>> +	if (event->header.size > time_zero_size) {
> >>
> >> I wonder if we could have a helper for this e.g. (untested)
> >>
> >> #define event_contains(obj, mem) (obj.header.size > offsetof(typeof(obj), mem))
> >>
> >> 	if (event_contains(event->time_conv, time_cycles)) {
> > 
> > Yeah, this is a better implementation.  Will refine patch for this.
> > 
> >>> +		event->time_conv.time_cycles = bswap_64(event->time_conv.time_cycles);
> >>> +		event->time_conv.time_mask = bswap_64(event->time_conv.time_mask);
> >>> +		event->time_conv.cap_user_time_zero =
> >>> +			bswap_32(event->time_conv.cap_user_time_zero);
> >>> +		event->time_conv.cap_user_time_short =
> >>> +			bswap_32(event->time_conv.cap_user_time_short);
> >>
> >> 'struct perf_record_time_conv' contains bool, the sizeof which, AFAIK, is not defined.
> >> Is it really 4 bytes on your implementation?  It is only 1 byte with gcc on x86.
> > 
> > On Arm64, bool is also 1 byte with GCC.
> > 
> > When working on this patch, I checked the size for structure
> > perf_record_time_conv, it gave out the structure size is 56; I wrongly
> > thought the bool size is 4 bytes and there have no padding.  In fact,
> > bool size is 1 byte and GCC pads 6 bytes at the end of structure.
> > 
> >> Either way, you should change 'struct perf_record_time_conv' so it uses a type of known size.
> >> Since you are the only one using it, it should match your implementation.
> > 
> > Will change to "unsigned int" value.
> 
> If it is 1 byte, I'd have thought __u8 i.e.
> 
> struct perf_record_time_conv {
> 	struct perf_event_header header;
> 	__u64			 time_shift;
> 	__u64			 time_mult;
> 	__u64			 time_zero;
> 	__u64			 time_cycles;
> 	__u64			 time_mask;
> 	__u8			 cap_user_time_zero;
> 	__u8			 cap_user_time_short;
> 	__u8			 unused[6];
> };
> 

Ah, yes, thanks a lot for reminding.
