Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C9C3B9A6E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 03:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234634AbhGBBM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 21:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbhGBBM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 21:12:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0C1C061764
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 18:10:26 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id g24so5416943pji.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 18:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JantWklceKfv6/zMusJnOkfOPSC2WPvuw18tN7HKnNU=;
        b=cjs6QVxqqYYQcMhA5nx3you/PrSYoyzAsHFX3x1zLyZC45F9QIHxftqXbW4MEN6WCl
         b2N8t6/gQibIDbO0qSV6ZFObSK3VOOqR5rcbHOVYOBhAodsR/CLtGB6adS3nmdVJxldK
         wl/Md0kiy2chL+RlaUZ187N36ELlo0W+03QrFpEmcCKgUOhYrmKmx177GImcKYAKyBVz
         GcAHaf3+mWbf8eZmOJRZjBo+9Zdj3NqqY0epjYCWfpQGadYovJNSx2Gl/5F5ySohp/cL
         qmH3MoTxCO857c2cvGRNS64c0XbfAvfvA8gJwqQ74UyZp0dbEWa1cielgK6uBsevXzC/
         SjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JantWklceKfv6/zMusJnOkfOPSC2WPvuw18tN7HKnNU=;
        b=H/NYl3ecVVR5KBPbPqCL9uYFJE0aVcOPCyTPIaoEqdQondjvi0tsj7WQeTQgm+ryBq
         OAjLo0OjvZaaD6SwNqD4evlyJeR41Jv7ciorhbFyZYOWiNIcqC44YmVWVViMff1osDwQ
         Wbsi9p3cjRH75YXEKJffw6k9DwdevzlYO+6IIkA3WoyZp5s41e/n7UFwuf/dmEO0xKL/
         VAaZbYTtRodakBG145n+FkoiSWM6n0HXx8NtX891FuN9Tv/PJ6k4ERnhMzdSvqM6XUDC
         Ke0ykEeHi1NALyF1oH1M5ffV5uOwxzmGt7ydcDGL5mZjEbg/57DGG4n5pnZp5vakB5oD
         0cEw==
X-Gm-Message-State: AOAM532AZwSdDVAcuBeMDdMDr68IRPCtbqsr4+7G/0/Gi/PvgPsp0Z9u
        f71dHPcJiW/6MQBZSMghTO58lg==
X-Google-Smtp-Source: ABdhPJwz8rWNxxuJkudd1gVKdbLvllvLppFghanqADn8r477rztHcZuGHLSxaWyULG/PnZ/wYCwfsw==
X-Received: by 2002:a17:902:8203:b029:129:2607:6bf4 with SMTP id x3-20020a1709028203b029012926076bf4mr1963866pln.57.1625188226046;
        Thu, 01 Jul 2021 18:10:26 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([103.207.71.35])
        by smtp.gmail.com with ESMTPSA id h10sm1294927pfh.33.2021.07.01.18.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 18:10:25 -0700 (PDT)
Date:   Fri, 2 Jul 2021 09:10:18 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <James.Clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Daniel Kiss <daniel.kiss@arm.com>,
        Denis Nikitin <denik@google.com>
Subject: Re: [PATCH v2 2/3] perf cs-etm: Remove callback
 cs_etm_find_snapshot()
Message-ID: <20210702011018.GA251512@leoy-ThinkPad-X240s>
References: <20210701093537.90759-1-leo.yan@linaro.org>
 <20210701093537.90759-3-leo.yan@linaro.org>
 <YN3sas8tWPfWjFqE@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YN3sas8tWPfWjFqE@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2021 at 01:25:14PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jul 01, 2021 at 05:35:36PM +0800, Leo Yan escreveu:
> > The callback cs_etm_find_snapshot() is invoked for snapshot mode, its
> > main purpose is to find the correct AUX trace data and returns "head"
> > and "old" (we can call "old" as "old head") to the caller, the caller
> > __auxtrace_mmap__read() uses these two pointers to decide the AUX trace
> > data size.
> > 
> > This patch removes cs_etm_find_snapshot() with below reasons:
> > 
> > - The first thing in cs_etm_find_snapshot() is to check if the head has
> >   wrapped around, if it is not, directly bails out.  The checking is
> >   pointless, this is because the "head" and "old" pointers both are
> >   monotonical increasing so they never wrap around.
> > 
> > - cs_etm_find_snapshot() adjusts the "head" and "old" pointers and
> >   assumes the AUX ring buffer is fully filled with the hardware trace
> >   data, so it always subtracts the difference "mm->len" from "head" to
> >   get "old".  Let's imagine the snapshot is taken in very short
> >   interval, the tracers only fill a small chunk of the trace data into
> >   the AUX ring buffer, in this case, it's wrongly to copy the whole the
> >   AUX ring buffer to perf file.
> > 
> > - As the "head" and "old" pointers are monotonically increased, the
> >   function __auxtrace_mmap__read() handles these two pointers properly.
> >   It calculates the reminders for these two pointers, and the size is
> >   clamped to be never more than "snapshot_size".  We can simply reply on
> >   the function __auxtrace_mmap__read() to calculate the correct result
> >   for data copying, it's not necessary to add Arm CoreSight specific
> >   callback.
> 
> Thanks, applied.

Thanks a lot for picking up the patch, Arnaldo!

Hi Mathieu, I supposed to get your review before merging; since
Arnaldo moves quickly, if you want me to follow up anything relevant
to this change, please let me know.  Thanks!

Leo
