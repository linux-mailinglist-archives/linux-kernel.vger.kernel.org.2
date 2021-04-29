Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162C736ED4E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240679AbhD2PYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:24:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233148AbhD2PYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:24:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D0EC06138B
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:23:36 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id q10so47376732pgj.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 08:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wMYiQrMMxp1KAmD6rBJdeD74Yv1gPkBbA4QnPdt6Sj0=;
        b=BZkBythIdb/rLxPtJRW74b5TcaCa08gTAkZWc8/9jHfFgsEiXDRIAszwC4rSnq86Pk
         jzYbhlf+6BC9gjbrc/fBycvqqy05YA2//rZKNGPw2WrVNJAmbLE0UWnZuXI2GEcobo0u
         ey9AbkwKBqMX10ojHFgD2Vx3bECe97TE9Y1cB350VKDiutV+RtpCdVqntn8uHjOiBZgM
         EW2eefHRwbcm87xt1k/Td/Z+LL8SwQqNhRlWdiXlnfn9X2udXBtIByvK14w4FG/ZXVV8
         NAMcr4vq+EIlZnrmWGeCN0C7TIdQgtVNAYgB4ru2x2lxKsZ0jlo63iTuz/y9PGmKIWdo
         Lt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wMYiQrMMxp1KAmD6rBJdeD74Yv1gPkBbA4QnPdt6Sj0=;
        b=PsDWkUcqn3qPIpoYlp0NFRAE4p7XeexzR+3XNEvnDbEB5Qryj8zRmmTvnSJAhSFT4p
         9P51fJ/PmBG+l43O9HvyrrA891w1aVV8tsZdOpsdYcmqNJKMnl8hg/3IgVPYzFZTnbeq
         +GQjksdaeSMQEQukh+d3Vx5uONY/H6Pd9MV4wSCOZOPtd0gedb1snE+cWzipDELN/ZNM
         ZDdhgcFi0cwJy6pbxGGKsVB5B5SznqbI13B5DI3zD6+VISo4m+4Cs9vUW/ZAweo/aNc7
         F7SL6qvKe6WH2uC5i4HDqKOX5VWtXNElAQ79LnbfS8xlGTMRShHKqXhr6zHmneT7+Z3s
         Dc/w==
X-Gm-Message-State: AOAM530pS2Nx4TB/cXgVsaAzViSJYutNqVwuLlqow7VQHQDTz3ovMb6y
        m+ue3RFm5WmQsEqDKU1VRy+GWg==
X-Google-Smtp-Source: ABdhPJwat9n5OdJZby1DncnAT3k7z26/jxcDLk33gW9Eu8s4zfB/OraVURfsrF+29NdrkuMTMyekWA==
X-Received: by 2002:a65:42c3:: with SMTP id l3mr233498pgp.258.1619709816249;
        Thu, 29 Apr 2021 08:23:36 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.180.30])
        by smtp.gmail.com with ESMTPSA id h8sm2633662pjt.17.2021.04.29.08.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 08:23:35 -0700 (PDT)
Date:   Thu, 29 Apr 2021 23:23:26 +0800
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
Message-ID: <20210429152326.GA282348@leoy-ThinkPad-X240s>
References: <20210412091006.468557-1-leo.yan@linaro.org>
 <20210412091006.468557-5-leo.yan@linaro.org>
 <9036368a-e824-3d63-da5b-54cf32a86aed@arm.com>
 <20210415152348.GF1011890@leoy-ThinkPad-X240s>
 <c9c060d1-0884-b67d-7689-6b45ad10baa9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c060d1-0884-b67d-7689-6b45ad10baa9@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Apr 16, 2021 at 03:51:25PM +0300, James Clark wrote:

[...]

> >>> diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
> >>> index 23714cf0380e..c13a89f06ab8 100644
> >>> --- a/tools/perf/util/arm-spe.c
> >>> +++ b/tools/perf/util/arm-spe.c
> >>> @@ -234,7 +234,7 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
> >>>  	struct arm_spe_record *record = &speq->decoder->record;
> >>>  
> >>>  	if (!spe->timeless_decoding)
> >>> -		sample->time = speq->timestamp;
> >>> +		sample->time = tsc_to_perf_time(record->timestamp, &spe->tc);
> >>
> >>
> >> I noticed that in arm_spe_recording_options() the TIME sample bit is set regardless of any options.
> >> I don't know of a way to remove this, and if there isn't, does that mean that all the code in this
> >> file that looks at spe->timeless_decoding is untested and has never been hit?
> >>
> >> Unless there is a way to get a perf file with only the AUXTRACE event and no others? I think that one
> >> might have no timestamp set. Otherwise other events will always have timestamps so spe->timeless_decoding
> >> is always false.
> > 
> > Good point.  To be honest, I never noticed this issue until you
> > mentioned this.
> > 
> > We should fix for the "timeless" flow; and it's questionable for the
> > function arm_spe_recording_options(), except for setting
> > PERF_SAMPLE_TIME, it also hard codes for setting
> > PERF_SAMPLE_CPU and PERF_SAMPLE_TID.  Might need to carefully go
> > through this function.
> > 
> 
> Yeah, it's not strictly related to your change, which is definitely an improvement.
> But maybe we should have a look at the SPE implementation relating to timestamps as a whole.

Just now I sent another patch series "perf arm-spe: Correct recording
configurations", which is the following up for the issue you found at
here.

After correcting sample flags, and combining with current patch series
"perf arm-spe: Enable timestamp", I verified the Arm SPE decoding
flows for "timeless" decoding, which can work as expected.

So I think we can move forward for this patch series, for easier review,
I have uploaded my testing branch wiht the complete patches [1].  Could
you help confirm if this works for you?  Thanks!

Leo

[1] https://github.com/Leo-Yan/linux/tree/perf_arm_spe_timestamp_v4_with_correcting_sample_flags
