Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFE845541E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 06:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243094AbhKRF1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 00:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243088AbhKRF1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 00:27:07 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684A3C061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 21:24:08 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso4577481pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 21:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h1yYI+IsG4+WOwL9bmLZrYVxC8ORAIsTweQQmnLHis8=;
        b=V2ioq5rFUnQt9RhBSFLNGsHhykx6b2CMW2UUY1wPs/2WIY7zyyElC+Z48IJ2MrmVpj
         TRglFhHcTDgvaxPtD9Ya69VnMsNRqeoPm+w1fvtDAB6ncmRAa6TZ5tbXcChvY4Ibp9uV
         eH+eMfijnfbWvnc2X1t62D6zZx/dDeEJyF0TRlWZkc6pFlWKhLrHYGtsoJIlhI2y1kCp
         XyPu9SRiLsjrEXvHFS4+gtH7lECEiyRgIvu8KFxxr6hQIepeor4Awwzw9MudjEmK58P3
         QETo/Q7PXAZFGA/UFI4CzaV4yvq5wyxJgZDfhW33m7ktIia8a7muZG4CtY8SEhy2ng1m
         0UfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h1yYI+IsG4+WOwL9bmLZrYVxC8ORAIsTweQQmnLHis8=;
        b=w8j7oaBCvAs24fyVHtgQ58uVVBEKLecE9yFl3BfwPKkoEt2bCYsUg/5xylNnOpWZoB
         3GQwRH/5BS5q2obNKlYRJX2WVEBHB5deoHK4L2TtERB9z5jEvdoPb70jeknPT54l09X0
         bs806loAW3oTHIWDdeUbu4uc5vUZPt+yZZ1WDTTCyDglBqjWyJTbPjisltHdWCR232PW
         or1te9cL0pG3K8VbbikceGFf6be0sIaBmp/Hi6Sh3+0f4znWIIYg6aC8Ed+yGqFg35ME
         AYdOOdHeJZHFRp4FXiDwu5IIvSygbwDzr43tJFXoaTY25BNBHltZHFFsmHgQRU5RxlH9
         reHA==
X-Gm-Message-State: AOAM532R3n52Rx6qiGnPm1AkRlG2rLdlu+qzkKJ4MJu8NEH9QQ/FeMOD
        u8rq4MG2YetK/ipN1XFJoQDy8Q==
X-Google-Smtp-Source: ABdhPJziTnXdjTP28//iOZJU7fMCqzECkcelQJZ01qAY7Soc702QiywgsfJDcPTs9/bAuXUIGUIYTA==
X-Received: by 2002:a17:903:10d:b0:142:6343:a48e with SMTP id y13-20020a170903010d00b001426343a48emr62507044plc.29.1637213047825;
        Wed, 17 Nov 2021 21:24:07 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([134.195.101.46])
        by smtp.gmail.com with ESMTPSA id i185sm1418211pfg.80.2021.11.17.21.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 21:24:07 -0800 (PST)
Date:   Thu, 18 Nov 2021 13:24:01 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     German Gomez <german.gomez@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [FYI][PATCH 1/1] perf tools: Set COMPAT_NEED_REALLOCARRAY for
 CONFIG_AUXTRACE=1
Message-ID: <20211118052400.GA69886@leoy-ThinkPad-X240s>
References: <YZT63mIc7iY01er3@kernel.org>
 <20211117144110.GC4771@leoy-ThinkPad-X240s>
 <YZUhUjuqzwhoqQM/@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YZUhUjuqzwhoqQM/@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2021 at 12:35:46PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > I think we should apply below code as well, if COMPAT_NEED_REALLOCARRAY
> > is enabled for AUXTRACE, it will be applied for cs-etm as well.  For
> > this reason, we can remove the redundant definition for CORESIGHT.
> 
> Isn't it possible to ask for:
> 
> 	make NO_AUXTRACE=1 CORESIGHT=1
> 
> ?

If AUXTRACE is disabled, then it has no chance to build cs-etm code;
this is decided by util/Build:

ifdef CONFIG_LIBOPENCSD
perf-$(CONFIG_AUXTRACE) += cs-etm.o
perf-$(CONFIG_AUXTRACE) += cs-etm-decoder/
endif

So we could safely remove the redundant definition for
COMPAT_NEED_REALLOCARRAY in CORESIGHT chunk.

Thanks,
Leo

> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 07e65a061fd3..2dbf086d1155 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -477,9 +477,6 @@ ifdef CORESIGHT
> >    $(call feature_check,libopencsd)
> >    ifeq ($(feature-libopencsd), 1)
> >      CFLAGS += -DHAVE_CSTRACE_SUPPORT $(LIBOPENCSD_CFLAGS)
> > -    ifeq ($(feature-reallocarray), 0)
> > -      CFLAGS += -DCOMPAT_NEED_REALLOCARRAY
> > -    endif
> >      LDFLAGS += $(LIBOPENCSD_LDFLAGS)
> >      EXTLIBS += $(OPENCSDLIBS)
> >      $(call detected,CONFIG_LIBOPENCSD)
