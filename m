Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0F432F7F2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 04:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbhCFDFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 22:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCFDFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 22:05:18 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1EFC06175F
        for <linux-kernel@vger.kernel.org>; Fri,  5 Mar 2021 19:05:18 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 16so1964103pfn.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 19:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C3NLEHrnsN9ERk6AvvzJ5QN+B7qHrtPpBVa7hDiDUzw=;
        b=M1kxf5FFuBGbYf80LTez2uwZPcP1lv5lFoZXNRisoDLzEBxL3joYrkfG8RN+5hpe/9
         6Xz7y+vW23H60eGxTsn2ds+KgMAqSgEcZvR/Pv1INKDfQAowaHJBxE54hwq8JNFDwMDJ
         5NV0/J8ns3/MUu+sGdP3OapdxbpgsWQjwL5r47oU6Ixee4nV8BO5zi3OA0Lx0Hrk9jXI
         8S0uzY/xMqmEaOhc8vWhKZED4i3M3oWVFxScA3dgqmWmUpGbg7fbNQeZ4G2wgT4ai38r
         dk93z8mOfi0wNDipeanuJEid7/vsPzDKgi6hKIA8v4Pokh0za8FlmQawRsv6ZWFBqm3i
         2YqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C3NLEHrnsN9ERk6AvvzJ5QN+B7qHrtPpBVa7hDiDUzw=;
        b=MXpurqafN1TAroTwD+pYWbqbMsEl64LgOKoMhXIeeQhsVh3s9Npjq343jAP8lyOcxN
         IRXEQHBTGhfNQC3VOsEUX+wXmJQCN0P8dj/cpx8TU12ZSwHxDMQJc3TD0yemw4yNA1fm
         e0wcotTp2b/hkhI+LZzgyZr0zXxsWMkDSobu0PtvEJJOdwA2BIN3CO/GfBwr7JXviS6q
         gfK4z9bOfNVLyk9m733fWWlVHTkIOApDSw3wE2VwSKerkD9jEk9Dmyn7VEgsaKZ446Ye
         YAtmaXFvUbQOM+rdAZzNubXWobzLti0laW2FXoo/FQWPu0OwL44JkvC2VE/+H+0Aq3b9
         omHw==
X-Gm-Message-State: AOAM531kcYRukgFb6iZrUQLo4Z2ZLYl8q5onunUuqa9e2LgKUoLzOiLN
        JzX9/Jv82qSXFj6IJ562Z3RLvQ==
X-Google-Smtp-Source: ABdhPJxPKR48rF0f9k74bRjzyzQ9501I3wZwxWa7o8VClbp2FhAkOOqOgBOKFQr1/IEEE1joJwICrA==
X-Received: by 2002:a63:e5d:: with SMTP id 29mr11134045pgo.450.1614999918067;
        Fri, 05 Mar 2021 19:05:18 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([103.136.125.226])
        by smtp.gmail.com with ESMTPSA id j35sm3929857pgj.45.2021.03.05.19.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 19:05:17 -0800 (PST)
Date:   Sat, 6 Mar 2021 11:05:12 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
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
Message-ID: <20210306030512.GD5478@leoy-ThinkPad-X240s>
References: <20210206150833.42120-1-leo.yan@linaro.org>
 <20210206150833.42120-5-leo.yan@linaro.org>
 <20210208204641.GE2077938@xps15>
 <20210209015855.GA54680@leoy-ThinkPad-X240s>
 <YEJqiNkIsNWS0E2G@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YEJqiNkIsNWS0E2G@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Fri, Mar 05, 2021 at 02:29:44PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Feb 09, 2021 at 09:58:55AM +0800, Leo Yan escreveu:
> > On Mon, Feb 08, 2021 at 01:46:41PM -0700, Mathieu Poirier wrote:
> > > On Sat, Feb 06, 2021 at 11:08:29PM +0800, Leo Yan wrote:
> > > > From: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > > 
> > > > When set option with macros ETM_OPT_CTXTID and ETM_OPT_TS, it wrongly
> > > > takes these two values (14 and 28 prespectively) as bit masks, but
> > > > actually both are the offset for bits.  But this doesn't lead to
> > > > further failure due to the AND logic operation will be always true for
> > > > ETM_OPT_CTXTID / ETM_OPT_TS.
> > > > 
> > > > This patch defines new independent macros (rather than using the
> > > > "config" bits) for requesting the "contextid" and "timestamp" for
> > > > cs_etm_set_option().
> > > > 
> > > > [leoy: Extract the change as a separate patch for easier review]
> > > 
> > > This should go just above your name - see below.
> 
> I fixed this up and added this patch to my perf/urgent branch, for
> v5.12, since the kernel bits are upstream and this is a fix.

Yeah, it makes sense to pick this patch into perf/urgent branch since
it's a fixing patch.

Actually, this patch has been merged into the tmp.perf/core branch [1],
after you move it to the perf/urgent branch, I can confirm all other
patches for perf tool in this series have been merged into the
tmp.perf/core branch.

Thanks,
Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/commit/?h=tmp.perf/core&id=8c559e8d68630d64d932bada633705f6551427df
