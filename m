Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C37362388
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 17:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245546AbhDPPHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 11:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245035AbhDPPHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 11:07:38 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24688C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 08:07:12 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id f2-20020a17090a4a82b02900c67bf8dc69so16567051pjh.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qvRPd9mJKRx11Shv+OyTN/o/Bvjy/gaC5xNSiISaZwo=;
        b=g08ANfEZT2d6VY2y52OdJOvS9/b1mZSA7c+Jo1sA2FPH8q9i+09GskgqqXvKUdkSOx
         iu+y+gK8WpaNyA1V6z0XT0TBhreeLBI7aJM7oeDrKwdaeWEZN6vY54tnEpTmqK/obSTe
         FaAi9VsJM5SHEqfam9+6cCvsCAwwlmwgC79oYHhb9WdD5i0K59EdQBXEXyodLndfRBpl
         NnCacMIFBKoZUTG0epfo1NbtUn19WXN8yAIuY6Ob1faQMb/6Tn3pYntUNub3bnIYMauj
         Qd1WSq8tp28qVml5F7HkyqUVX0qR89M3nUTMTlpCXCANmB2Z5DBKQDc5T/lLxCag8Nq2
         eE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qvRPd9mJKRx11Shv+OyTN/o/Bvjy/gaC5xNSiISaZwo=;
        b=le/U5uRRGw8LXTs1NYjIs7igOYmUzrzWkHww3aomYqsuXgxM1VlCXOJ5MAVDbuWgwB
         DGtkSvez4Ps/VBO3w0XSBUbpMHxRfHOI8TE1GnYUjUzB8l9W46YRMStqKm7SaEJf1aZe
         nPW3FqlpkkFnlXKtqevULYTufrAj31Uvavk051ezNkjx2zUxG8DMhUuQ58F/3u9ZHFz3
         nKHYAqLkdhpxZAErkmBAMsJxx9fpGpovUSI3PO3NbTVcWIZUQUkDrcpuClX1bw07WR6F
         IOQQehV1tRSGLSFJOlNpERhfmzXyDJADPaolS+Y7g3Xn7OycrDyBht7zBh6MKGZx51EA
         ZhBw==
X-Gm-Message-State: AOAM531wfaiDy8f2+NA/Qe5yMa8PWtaUx3lTxAn/+aahU1joxHcscSQs
        FBs6r26q/TDA14cAy8DoynV7Ug==
X-Google-Smtp-Source: ABdhPJw/TvRlw4eu+nGgPjVquPv+r/N1Q8Ytb4wzK/E+5VbvXcS28/9OfbX37TdfIIoycQvIdJO+/Q==
X-Received: by 2002:a17:903:2310:b029:eb:73d5:3e4e with SMTP id d16-20020a1709032310b02900eb73d53e4emr9661606plh.66.1618585631641;
        Fri, 16 Apr 2021 08:07:11 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t184sm5196525pgt.32.2021.04.16.08.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 08:07:11 -0700 (PDT)
Date:   Fri, 16 Apr 2021 09:07:09 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, acme@kernel.org, al.grant@arm.com,
        branislav.rankov@arm.com, denik@chromium.org,
        suzuki.poulose@arm.com, Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf cs-etm: Set time on synthesised samples to
 preserve ordering
Message-ID: <20210416150709.GA1046932@xps15>
References: <20210416105632.8771-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416105632.8771-1-james.clark@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On Fri, Apr 16, 2021 at 01:56:30PM +0300, James Clark wrote:
> Changes since v1:
>  * Improved variable name from etm_timestamp -> cs_timestamp
>  * Fixed ordering of Signed-off-by
> 

You forgot to add the RB and AB you received.  Since Arnaldo is responsible for
the perf tools subsystem, please send another revision.

Thanks,
Mathieu

> James Clark (2):
>   perf cs-etm: Refactor timestamp variable names
>   perf cs-etm: Set time on synthesised samples to preserve ordering
> 
>  .../perf/util/cs-etm-decoder/cs-etm-decoder.c | 18 +++----
>  tools/perf/util/cs-etm.c                      | 52 ++++++++++---------
>  tools/perf/util/cs-etm.h                      |  4 +-
>  3 files changed, 39 insertions(+), 35 deletions(-)
> 
> -- 
> 2.28.0
> 
