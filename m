Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90B7A360BDA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhDOOeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOOeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:34:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F7CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:33:36 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so14508292pji.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 07:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S/Ac5p5sFlhYpJj45qpbkrcbzcCAGOqGDmLTdphHEcY=;
        b=uxXFkFcErUQRZZT2RsagDil40vU8fxQhVFq4L8Q1w8InnSx7O+aNifDs0SIao2TCdU
         5pMTUbhGK2infCJ4+Bp85Me6Su32E+vSzX/LFc6R8qE4w/ZwxDqWsDxaOdpcb38xjcj/
         Hb9rcWzLAB+UV5fMgbtGZl4qRUcGXpg3S+YJWnrDHyji/TpKZLLNJH33RhGbQL27N+WS
         3fk4+2QwXwZ76889lGDQ/xyHWDCTOls7q6GGSg+KfYx4V0GDopX9AslBRsmjI2wncGS4
         iX7HD1DwFOQ7KFMBMIbaCO45NOhS2tsXzqF3f/MUi/kQed6VMIrxutIh6V2AynvYzzIY
         rFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S/Ac5p5sFlhYpJj45qpbkrcbzcCAGOqGDmLTdphHEcY=;
        b=N6ZYAW8aTyoNDWbO6TVbwB61mKtMftHm5c0ZxjzDVSvbX4HVE8hRjrx+/EBywbZh7l
         1gARD5X/pyXUfPpmEA5YW2TjUuUpX1iy+FV6/3UURRhCu6PrOc7cetEtJPWkaB+o96Fw
         QttflMIAMeCHd3TpoQDL8tMHpOyU0w98q+xB7+rLLLZfCPTz5VcFLmpjnMFGJiI/gOZw
         5pkWw6KpaRJKgqXr25FaEfivQHSxfAyWjPEz2DOd5PTDiWIdKkCFCGWxOpyW2oRKFvVZ
         pc5QeDi2tctUiPd2I4TVPqhpUxqj6B24MymJwQCwf3tRsM2edfSJhlYMfMi7GqPG4a3i
         cAew==
X-Gm-Message-State: AOAM530/bmsQrOjfdDLtUOjR3uYeoHgDDELBkfiHH8kvljDcdbKIe/98
        Y02e4yhJeIiDlVrvTMx9CLncsQ==
X-Google-Smtp-Source: ABdhPJzdaH1Gm9JyqnfPTo7HQh23YJXi3M9xml+sUHCOLDFbpT44bFt/Dd06K8z2yY2wR/no/niRCQ==
X-Received: by 2002:a17:90b:3b4a:: with SMTP id ot10mr4193152pjb.48.1618497215586;
        Thu, 15 Apr 2021 07:33:35 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.232])
        by smtp.gmail.com with ESMTPSA id s22sm2971372pjs.42.2021.04.15.07.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 07:33:35 -0700 (PDT)
Date:   Thu, 15 Apr 2021 22:33:29 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] perf cs-etm: Set time on synthesised samples to
 preserve ordering
Message-ID: <20210415143329.GC1011890@leoy-ThinkPad-X240s>
References: <20210414143919.12605-1-james.clark@arm.com>
 <20210414143919.12605-2-james.clark@arm.com>
 <06e1cc2e-1108-81cd-59e4-79277807b80c@arm.com>
 <20210415123953.GB1011890@leoy-ThinkPad-X240s>
 <4c173b86-b045-0514-b293-c39cc74d353d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c173b86-b045-0514-b293-c39cc74d353d@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Thu, Apr 15, 2021 at 03:51:46PM +0300, James Clark wrote:

[...]

> > For the orignal perf data file with "--per-thread" option, the decoder
> > runs into the condition for "etm->timeless_decoding"; and it doesn't
> > contain ETM timestamp.
> > 
> > Afterwards, the injected perf data file also misses ETM timestamp and
> > hit the condition "etm->timeless_decoding".
> > 
> > So I am confusing why the original perf data can be processed properly
> > but fails to handle the injected perf data file.
> 
> Hi Leo,
> 
> My patch only deals with per-cpu mode. With per-thread mode everything is already working
> because _none_ of the events have timestamps because they are not enabled by default:
> 
> 	/* In per-cpu case, always need the time of mmap events etc */
> 	if (!perf_cpu_map__empty(cpus))
> 		evsel__set_sample_bit(tracking_evsel, TIME);
> 
> When none of the events have timestamps, I think perf doesn't use the ordering code in
> ordered-events.c. So when the inject file is opened, the events are read in file order.

The explination makes sense to me.  One thinking: if the original file
doesn't use the ordered event, is it possible for the injected file to
not use the ordered event as well?

Could you confirm Intel-pt can work well for per-cpu mode for inject
file?

> So it's not really about --per-thread vs per-cpu mode, it's actually about whether
> PERF_SAMPLE_TIME is set, which is set as a by-product of per-cpu mode.
>
> I hope I understood your question properly.

Thanks for info, sorry if I miss any info you have elaborated.

Leo
