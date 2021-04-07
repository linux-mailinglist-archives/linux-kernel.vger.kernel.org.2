Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29308356D87
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347417AbhDGNlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 09:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhDGNlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 09:41:15 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2ADC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 06:41:04 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ep1-20020a17090ae641b029014d48811e37so1324410pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UDd2vqVtreCXqy304zRKInOYxVQYZmvPh8rTcJV1Mqs=;
        b=BcMfcPZ/mDp1OQ8kmSSzzumFX9o9LU00pLf8uuGQQ0bSBr9z+iDYDcOt9yewSg+VMJ
         +UyvYX6TLVTYkywVcsrtxS/Y2UD58tSv0Qc2azHtJ34boojkik3DOAah5etz5m7LQMR/
         VkyqXDhF8R0rVFAxmNb21tYCT2YIqjJzlu8u0C1ZCJcAlYhzX0LQjAqIdzz6Uw2cT2MX
         8YPRnuehT6x+iRAGn6+I8g+LXtv5C0tHp2hNXZnKKHBXA6L2H2A0veHqZlVbPCAZ/cMM
         TVZNHJqxPZ9+HfZQ/AEi30zINCH+ADqAl8UIXA0IiugTDD9WRNJWXPANMoWYzmtOXWRn
         OZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UDd2vqVtreCXqy304zRKInOYxVQYZmvPh8rTcJV1Mqs=;
        b=ojAJdKJSjaPlTU/gC9+TL7oLFrOgDo4vqK8slLBMj4G4qiYOer7+HzRZCEG5PkqNMu
         JZP933OrVewqiba/5zxoeJndXUVyLkyYNQ/fP0wWQZzwBJzUY8tuRXbkX8A82cJ3w7fG
         g8mAhaH7CYbkcHykdxdkQTZ4qjIPJj/E5tqxtyqhOrFBHTs37z8uLRAu/yu1qjL6Gyh6
         7+xr1iEeX10E76D/AR0AaPtUp86VUHWYLsVuqDX3ui3PSmsIPl9kyqPDkaNhWIOxdEvd
         gRWuJ3odx2wyt4GXA9ascJJT8hR9w0KeCBkgpY1ZfRcCOU4J4S3kqTeOBlHaG0AJdDSD
         plaA==
X-Gm-Message-State: AOAM531mk6cYegE/ahe3z3VGs1Bmk7OB4EF0uCZrDn3nLMruu+avO6XL
        fflN5jBS9F8oBA2IraEV5N94Jg==
X-Google-Smtp-Source: ABdhPJzLoM0DuZlQ39mA1r5bPRxrB7mAwP42ocCw90DZI4pwgzt9nDknvWswfJXzn9dXAnZ6HDb/Uw==
X-Received: by 2002:a17:90a:314:: with SMTP id 20mr3448353pje.72.1617802864331;
        Wed, 07 Apr 2021 06:41:04 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.229])
        by smtp.gmail.com with ESMTPSA id d17sm20975471pfn.60.2021.04.07.06.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 06:41:03 -0700 (PDT)
Date:   Wed, 7 Apr 2021 21:40:58 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Al Grant <Al.Grant@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        James Clark <James.Clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] perf arm-spe: Enable timestamp
Message-ID: <20210407134058.GB585163@leoy-ThinkPad-X240s>
References: <20210403072346.30430-1-leo.yan@linaro.org>
 <AM6PR08MB335124DC0080EA95A817D71786769@AM6PR08MB3351.eurprd08.prod.outlook.com>
 <20210407131529.GA585163@leoy-ThinkPad-X240s>
 <0016288d-a490-f8fb-f108-0969b946494e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0016288d-a490-f8fb-f108-0969b946494e@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 04:28:40PM +0300, Adrian Hunter wrote:
> On 7/04/21 4:15 pm, Leo Yan wrote:
> > Hi Al,
> > 
> > On Tue, Apr 06, 2021 at 09:38:32AM +0000, Al Grant wrote:
> > 
> > [...]
> > 
> >>> This patch set is to enable timestamp for Arm SPE trace.  It reads out TSC
> >>> parameters from mmap page and stores into auxtrace info structure;
> >>
> >> Why not synthesize a PERF_RECORD_TIME_CONV - isn't that specifically to
> >> capture the TSC parameters from the mmap page? If a generic mechanism
> >> exists it would be better to use it, otherwise we'll have to do this again for
> >> future trace formats.
> > 
> > Good point!  Actually "perf record" tool has synthesized event
> > PERF_RECORD_TIME_CONV.  This patch series is studying the
> > implementation from Intel-PT, so the question is why the existed
> > implementations (like Intel-PT, Intel-BTS) don't directly use
> > PERF_RECORD_TIME_CONV for retriving TSC parameters.
> 
> PERF_RECORD_TIME_CONV was added later because the TSC information is
> needed by jitdump.

Thanks for the info, Adrian.

If so, it's good for Arm SPE to use PERF_RECORD_TIME_CONV for TSC
parameters.  Will spin patch series for this.

Leo
