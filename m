Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EF83C3B24
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jul 2021 10:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbhGKIK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jul 2021 04:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbhGKIKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jul 2021 04:10:55 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F168EC0613DD
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 01:08:07 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id d9-20020a17090ae289b0290172f971883bso10229037pjz.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jul 2021 01:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uoCCXZXvrI1rDzjVf/fCu+A/YGEVLGhBR8+AmTK+J0g=;
        b=nkvEfNPrkZ14CAZBB2c+ZcblrbsE5/lHUZQ+id/905lrUSb8SJuMEfca56Cj7l6bfn
         6Od72UoVGjRaARvUzTksn2P5XKXAGpkhRH6VKfVMDNu4u3X4s90iKLz65HWTHcsN96C4
         pX6IO61HhJKP6TOZERzHkmM3UbZ4t6IqK+MCAHT2w+U5+n/Pv+J+Yr4RGFRBoaAgm6/g
         y0wh4QlPWBmxec+EeyLFVTPZXw2o3wObzm52+2wWR6fHFLB3N/45RzZcCWm4Nyuv7eIE
         kuQ66P/wu+fKbF+w1grRW/9doUyh6RxU67MacmvQoDB79CtaGArSlOHFacde8WJSzj/3
         Ps8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uoCCXZXvrI1rDzjVf/fCu+A/YGEVLGhBR8+AmTK+J0g=;
        b=hNLm4pZ/4sb8dyrd8QH76f5NX+/HBn885cEueyFA7Kb7Uw3/CIRpt18aTTmDa/kRjG
         JY34D7NfV8qbMQXd8yAgCtrUuuMYE4PTSnYr1Paa4lPBSpxq6bkLYCH3rILZy33XEUk5
         rJHuyrYyuF20YQIqFFgCRHXxb/g7kJ1vIs+AdkN73Pj1Snxp/f2ktWFirofXxnmsB6o9
         iHKVY2mm61xc5jCNzho/0okiPwPsTQ73k3LdoKgmXG0NpwjB3sarjgk0AoTuLSJ6qX//
         yHS8YjLFJWsVtuXzuNGUl3lWa82OuWcLXehM25AkW5ZYGrwz6oIb71fwqi3wmOXn6wvj
         GGiA==
X-Gm-Message-State: AOAM531vno2+N84bw+gHPvy1ORLnLOEFOwd/nn38UteB0DoGtjvvbIm5
        jFRTa6ZA+g5mWzcZPNxANLWr2A==
X-Google-Smtp-Source: ABdhPJy9WSM9plj/arZagBkfTvNz3p9NQ5BVrKge1/+AbtvvWIAeYCdVgS7pN1pwU3FJzkhcbfHF5A==
X-Received: by 2002:a17:90a:9f06:: with SMTP id n6mr8060917pjp.219.1625990887376;
        Sun, 11 Jul 2021 01:08:07 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.131.71.237])
        by smtp.gmail.com with ESMTPSA id b19sm10319016pjh.29.2021.07.11.01.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 01:08:06 -0700 (PDT)
Date:   Sun, 11 Jul 2021 16:08:00 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 07/10] perf: Cleanup for
 HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT
Message-ID: <20210711080800.GD273828@leoy-ThinkPad-X240s>
References: <20210704071644.107397-1-leo.yan@linaro.org>
 <20210704071644.107397-8-leo.yan@linaro.org>
 <86cd5d3d-2441-2f8e-28ab-54802e47c68b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cd5d3d-2441-2f8e-28ab-54802e47c68b@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Sat, Jul 10, 2021 at 03:36:53PM +0300, Adrian Hunter wrote:
> On 4/07/21 10:16 am, Leo Yan wrote:
> > Since the __sync functions have been dropped, This patch removes unused
> > build and checking for HAVE_SYNC_COMPARE_AND_SWAP_SUPPORT in perf tool.
> > 
> > Note, there have a test for SYNC_COMPARE_AND_SWAP and the test file is
> > located in build/feature/test-sync-compare-and-swap.c.  Since there
> > still has several components using the sync functions, it's deliberately
> > to not be removed.
> 
> I don't quite follow that.  If they aren't using the feature test
> macro, then why keep the feature test?

There are files are still using __sync_xxx_compare_and_swap() functions,
e.g. in the folder tools/testing/selftests/bpf.  On the other hand,
after drop __sync functions from perf, there have no any Makefile check
the feature 'feature-sync-compare-and-swap'.  So it's safe to remove the
feature test.

Sorry for confusion.  Will drop the feature test in new patch set.

Thanks,
Leo
