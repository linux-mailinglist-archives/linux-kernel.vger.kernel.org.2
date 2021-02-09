Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447B13145F5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 03:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhBIB7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 20:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhBIB7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 20:59:48 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0550CC061788
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 17:59:09 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id cl8so683647pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 17:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IfhGG5EFiF0+GV+cXx/c1hFmnHr7EDLtq1/XLJ8Wrqw=;
        b=Jb86j9QXa47sQXQPZMFKIS6GO/j/tpp7DNNjLp7FiLlvZfMGz2BF8Y9cWJgnmPGEyf
         RKPyfFKtylW0GKsgl/J43mzsL9rO4f7WcGzQkFTz6iwMs5kYT4oisj3encefwLZfyl+9
         MmFRqGbdc2eyEWr19Le16H1qVZrIC518kjatEDtY0Kplu8XhMzGxrIYEc5DEiAK+gbpn
         0FjmJpcbshb55HO403qGIPNSx8iCYU536AabTz+HniBQh7Ju/Pv8m5mSALtV5M6PC+rM
         hY2Z/vtbWSQHThyOOWRP8S9YwQe1Dsw2DgMjUXXbBw+mYwpVlrhSVuV3qxrNSZr24Rz8
         TTEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IfhGG5EFiF0+GV+cXx/c1hFmnHr7EDLtq1/XLJ8Wrqw=;
        b=rLuTf2EkbFF+/+LJ0G1ADfBO82FrZ0zrOIjfIiPRbf58ePaeckwq+6Pwaq2WT2xD4A
         /XmlMmhg9qz8ki0URHu0mlIqj7jiO982ME5P/MP7MCw86rUbso/i2rDr9BBSil5DuaJH
         AoJoW0JnevAF4e/BPWtZ/lqRpODX2aqeI4Jxaxko3vLd2ahLmT77AurHcqRf23ezwByY
         LU1bCEobz4A2CMQ6Ie8O7Xc8R7jWE1zGU/4tcN0imhMnHUAijAgj93JbONnZ+5ShmprO
         6vS1jqutDBKTjKMNI9yAZlHxr+Iy+FafA/qfO9pw3DrN4QTbTaOisoA7n+qKXH3cBm4y
         P6JQ==
X-Gm-Message-State: AOAM533pjlHQnezDxRSRm3OGlvGtDeMYAoGEaTnhGDJ5CoGI8hML/qZB
        cjA6rI5VhbwXj1fBrTg3r7XlVw==
X-Google-Smtp-Source: ABdhPJwilBT/p4PwScBoN7sJjtCO4XCBK8l7i0c62IBmgxUh2caNLJYPIxyvl5DOanOztniAJyYOVA==
X-Received: by 2002:a17:903:2305:b029:df:c991:8c49 with SMTP id d5-20020a1709032305b02900dfc9918c49mr19696460plh.8.1612835948392;
        Mon, 08 Feb 2021 17:59:08 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([198.44.243.100])
        by smtp.gmail.com with ESMTPSA id h10sm19090046pfn.213.2021.02.08.17.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 17:59:07 -0800 (PST)
Date:   Tue, 9 Feb 2021 09:58:55 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>,
        Al Grant <al.grant@arm.com>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] perf cs-etm: Fix bitmap for option
Message-ID: <20210209015855.GA54680@leoy-ThinkPad-X240s>
References: <20210206150833.42120-1-leo.yan@linaro.org>
 <20210206150833.42120-5-leo.yan@linaro.org>
 <20210208204641.GE2077938@xps15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210208204641.GE2077938@xps15>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 08, 2021 at 01:46:41PM -0700, Mathieu Poirier wrote:
> On Sat, Feb 06, 2021 at 11:08:29PM +0800, Leo Yan wrote:
> > From: Suzuki K Poulose <suzuki.poulose@arm.com>
> > 
> > When set option with macros ETM_OPT_CTXTID and ETM_OPT_TS, it wrongly
> > takes these two values (14 and 28 prespectively) as bit masks, but
> > actually both are the offset for bits.  But this doesn't lead to
> > further failure due to the AND logic operation will be always true for
> > ETM_OPT_CTXTID / ETM_OPT_TS.
> > 
> > This patch defines new independent macros (rather than using the
> > "config" bits) for requesting the "contextid" and "timestamp" for
> > cs_etm_set_option().
> > 
> > [leoy: Extract the change as a separate patch for easier review]
> 
> This should go just above your name - see below.
> 
> > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > Reviewed-by: Mike Leach <mike.leach@linaro.org>
> 
>  Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>  [Extract the change as a separate patch for easier review]
>  Signed-off-by: Leo Yan <leo.yan@linaro.org>
>  Reviewed-by: Mike Leach <mike.leach@linaro.org>
> 
> > ---
> >  tools/perf/arch/arm/util/cs-etm.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > index bd446aba64f7..c25c878fd06c 100644
> > --- a/tools/perf/arch/arm/util/cs-etm.c
> > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > @@ -156,6 +156,10 @@ static int cs_etm_set_timestamp(struct auxtrace_record *itr,
> >  	return err;
> >  }
> >  
> > +#define ETM_SET_OPT_CTXTID	(1 << 0)
> > +#define ETM_SET_OPT_TS		(1 << 1)
> > +#define ETM_SET_OPT_MASK	(ETM_SET_OPT_CTXTID | ETM_SET_OPT_TS)
> > +
> 
> I would much rather see this fixed with the BIT() macro as it is done in the
> rest of this set than defining new constant.
> 
> With the above:
> 
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> 
> I have picked up the kernel portion of this set.  I suggest you fix the above
> and send another revision to Arnaldo with my RBs.

Will do this.  Thanks for suggestion, Mathieu.

Leo

[...]
