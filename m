Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3270360EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 17:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbhDOPYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 11:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234651AbhDOPYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 11:24:21 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4B0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 08:23:57 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id il9-20020a17090b1649b0290114bcb0d6c2so14627840pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 08:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bXZxdjLr/YJtMGDnsZ/dq4aApS/Fn+Nhc7T69iiHUaY=;
        b=bF68ElFunrnYdZcOGR/8Q/rHowlvo7APAr7Hq5kadkOOxjPovxtI55ahBVF3U14bFp
         Gi/aV/EFpS3RE/4Up73hh5RIGSmUH0JSePXBXjLb4CFNw5ePV+LGVlJIH5eHqU5HeaWW
         gO8PAfrPtTKs7xXyNMRq7q5H5QFZoZXxZJKy8hzRqDKeMk1LSQ9aI03h49JgTfrPx293
         GHkPBeXMh+JtG8NfERTLZ0x4RgfiC5oZdExx38Xr+lFKWT8aaOqvONS2+IExUlQpT6ND
         YojO+fXGbbhzlWT6kQMvm30scQYxH8gA/3La47WWCpDIOaaNlWSP4/jXbdwfZpr+A0PO
         rS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bXZxdjLr/YJtMGDnsZ/dq4aApS/Fn+Nhc7T69iiHUaY=;
        b=fNqiSZeAYrOkSTcN5sJa4ZGOEQ5eeCbkAXTmrhd2czGK0Rbffiqe+HZMbprxu/nj12
         FUU+GeW3TeF6eC6GsCMqejugYFqX4t9lW4w2w/JWrvUy6vp/k7XOFtVD430lJqc/ukw+
         kzNQjb0yOtd392eO/CF+WVsbiqYC4I5QuHr6yRHjIvxVimmAzUhW++iJNTqtq9nRjXt2
         a28pr4dd/+30JxjFV5J2s8Z1OiviidZewU+9Db5yNN2YRFyrL2bFijLgnKQt7XMkKjDx
         qDhTxqXnsBCRiGwTX5JvIFoSem6t1ygGz3MwWln4osfk1VGvs+S6XVFgoMXbSOUOTPTY
         JmcA==
X-Gm-Message-State: AOAM530XHTZt6VjSfJ+WEo8QelY5sDqbAZedSk0+BkBTiGdGW5wcrfr9
        w5J5FkPgXSNajtoJ6cKl5rv/VA==
X-Google-Smtp-Source: ABdhPJx+RCHZAhVrJd03I0vARqND3wOxI6Nuy9rGZAR7ngHF61YSr8tsfAUZ871yB8qtDNNBt7WASw==
X-Received: by 2002:a17:902:7616:b029:e9:a757:b191 with SMTP id k22-20020a1709027616b02900e9a757b191mr4330017pll.74.1618500236906;
        Thu, 15 Apr 2021 08:23:56 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id fa6sm2821169pjb.2.2021.04.15.08.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 08:23:56 -0700 (PDT)
Date:   Thu, 15 Apr 2021 23:23:48 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Al Grant <Al.Grant@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] perf arm-spe: Assign kernel time to synthesized
 event
Message-ID: <20210415152348.GF1011890@leoy-ThinkPad-X240s>
References: <20210412091006.468557-1-leo.yan@linaro.org>
 <20210412091006.468557-5-leo.yan@linaro.org>
 <9036368a-e824-3d63-da5b-54cf32a86aed@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9036368a-e824-3d63-da5b-54cf32a86aed@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 15, 2021 at 05:46:31PM +0300, James Clark wrote:
> 
> 
> On 12/04/2021 12:10, Leo Yan wrote:
> > In current code, it assigns the arch timer counter to the synthesized
> > samples Arm SPE trace, thus the samples don't contain the kernel time
> > but only contain the raw counter value.
> > 
> > To fix the issue, this patch converts the timer counter to kernel time
> > and assigns it to sample timestamp.
> > 
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  tools/perf/util/arm-spe.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> > index 23714cf0380e..c13a89f06ab8 100644
> > --- a/tools/perf/util/arm-spe.c
> > +++ b/tools/perf/util/arm-spe.c
> > @@ -234,7 +234,7 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
> >  	struct arm_spe_record *record = &speq->decoder->record;
> >  
> >  	if (!spe->timeless_decoding)
> > -		sample->time = speq->timestamp;
> > +		sample->time = tsc_to_perf_time(record->timestamp, &spe->tc);
> 
> 
> I noticed that in arm_spe_recording_options() the TIME sample bit is set regardless of any options.
> I don't know of a way to remove this, and if there isn't, does that mean that all the code in this
> file that looks at spe->timeless_decoding is untested and has never been hit?
> 
> Unless there is a way to get a perf file with only the AUXTRACE event and no others? I think that one
> might have no timestamp set. Otherwise other events will always have timestamps so spe->timeless_decoding
> is always false.

Good point.  To be honest, I never noticed this issue until you
mentioned this.

We should fix for the "timeless" flow; and it's questionable for the
function arm_spe_recording_options(), except for setting
PERF_SAMPLE_TIME, it also hard codes for setting
PERF_SAMPLE_CPU and PERF_SAMPLE_TID.  Might need to carefully go
through this function.

Thanks,
Leo
