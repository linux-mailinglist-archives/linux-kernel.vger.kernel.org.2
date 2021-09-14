Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1272240AB64
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhINKGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhINKGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:06:45 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C046C061762
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 03:05:28 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id bb10so7834020plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 03:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z1muzdOPWzB0ytDKcRa+QFyNrcjjCHiCUrUvKj8zYFM=;
        b=ZV9YpuPTdGrvhLZWC7YTDjzQ+oyE4Tnvnl2GIQvc69ojO1KtUMsUfiP9jbd3N04ASM
         JSv+PVbTCW622AwkynaZ0Dj/sHs9nNGOzTgnmEOuguzXMzE+UMuDLtnQA+7BM07LZfB6
         q5TmSMD1rnsXyGKCFILbsVrXFHZn1SlA0lfUa4GVO25uojNy0n+O0Y7EMjBj8B0HaVFX
         0r81qzhcYX1QCmSPgFTKdnq6ytpycu4hgs/q7/XFqfX/4g8tGPY2dALaQtmcn44vk8I+
         DPDSduio6Ba8YeMc1isvG99CxKGYwUeAoBDymzxWpAI2oHcMj/2uqQduBfu6/o7PUv61
         NS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z1muzdOPWzB0ytDKcRa+QFyNrcjjCHiCUrUvKj8zYFM=;
        b=FQpVIzJyxGyWloFPY6vIq+N2b9kf1uAjBg+koChSK9yEV2Hk7VF1QAnWF/m55CUgsL
         4BQZvmFU3e216SO0i86Lp7adCDI/cQ7FFr+mOhaFi18dM/qwa+h7P/A7e5ioJdQRbhwf
         0vY23N1ldqc+5js37F8z89PKahGh/eZRKxuluym9eYpjHIlC5Mh46Q5vfgELRVGWasLX
         FUo0V9gxRt2mHSJsOKHy/Q6QGelMYbcGif3XSh+oYKlSIoadqQGUg8b7yMbsGG2XVnsV
         jteFhseWcNUVGkg9JteUSbHNsI0b0M/pMJOekC6P3K4XUcYzgLKYPcXVF2yNRgORd95I
         EnRw==
X-Gm-Message-State: AOAM530m4+s6eJKc1EvvHl1lt5HE0gVzOLvV3FfM2HS0y/IMrWyc+lj1
        JoKa+Rw7bM5+LN8J0wOsDLI8BA==
X-Google-Smtp-Source: ABdhPJw9bLFl5o1rEO6GGn86+0NLilPqU7PnCPV4PRYgtLRqPF5710VvVQ1ig7++JmoZFGHm1n8mQQ==
X-Received: by 2002:a17:90a:b392:: with SMTP id e18mr1151791pjr.205.1631613927864;
        Tue, 14 Sep 2021 03:05:27 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.224])
        by smtp.gmail.com with ESMTPSA id d5sm1082133pjs.53.2021.09.14.03.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 03:05:27 -0700 (PDT)
Date:   Tue, 14 Sep 2021 18:05:17 +0800
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
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Michael Petlan <mpetlan@redhat.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Song Liu <songliubraving@fb.com>, x86@kernel.org,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org
Subject: Re: [PATCH v5 4/9] perf/x86: Add compiler barrier after updating BTS
Message-ID: <20210914100517.GC1538480@leoy-ThinkPad-X240s>
References: <20210809111407.596077-1-leo.yan@linaro.org>
 <20210809111407.596077-5-leo.yan@linaro.org>
 <20210829105657.GC14461@leoy-ThinkPad-X240s>
 <YUBwqGuQskkw328z@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUBwqGuQskkw328z@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, Sep 14, 2021 at 11:51:36AM +0200, Peter Zijlstra wrote:
> On Sun, Aug 29, 2021 at 06:56:57PM +0800, Leo Yan wrote:
> > Hi Peter, or any x86 maintainer,
> > 
> > On Mon, Aug 09, 2021 at 07:14:02PM +0800, Leo Yan wrote:
> > > Since BTS is coherent, simply add a compiler barrier to separate the BTS
> > > update and aux_head store.
> > 
> > Could you reivew this patch and check if BTS needs the comipler
> > barrier in this case?  Thanks.
> 
> Yes, a compiler barrier is sufficient.
> 
> You want me to pick it up?

Maybe other maintainers are more suitable than me to answer this :)

Yeah, I think it's great if you could pick it.

Thanks,
Leo
