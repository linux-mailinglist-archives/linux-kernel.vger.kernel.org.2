Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908E236AA6E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 03:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhDZBlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 21:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbhDZBlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 21:41:50 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B7AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 18:41:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id j7so29629044pgi.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Apr 2021 18:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I+Sh8EYFGPmDbslMrURueAi2FXlz6kxx3HeQf9lvCjE=;
        b=h4l6cTTdLEb6VcZy0qecF2ehn4GaIcmDh0CT/taq8wYAMUtr3p1BriwDeXlDO3f28C
         4e3BqOm/rAFwfnwpjvR0mWrXRnu9Rg5HebkSV7wXrco9+YRyBWRPdgrEodMdTXWyow3R
         6Yl1+mAWz3aoLLsvYEXh6pWU1SqZJsUpd+PpadIPVOT2t1h5tieh8eQpRq7nhbfN5oK/
         4d9LmMVTAFcY6/czSkG3oTF1E2yNqcd8ua2irjuBpl4bx66zzXpmuYUM8Xa00zsWw8W7
         VufeMZV8UNciMoVQ8JR1KQsaVtVA3pUoa3Q//zCpdLMq1tu28OhlKqnic4bWSKpS47cs
         jupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I+Sh8EYFGPmDbslMrURueAi2FXlz6kxx3HeQf9lvCjE=;
        b=c207jIfZ75MWGtE6YDpPC/l2JIfn5LoaC+xdPbTpyNyGZsHmqWF9SZ2gRF6m0Vsvpq
         OEuSp7hWbrZ0hsq9PeA9fKMScBN+Kj46rLm0J4cQI7E3B671cMWsXuVTBLF2hluzk/VE
         nRUyhr+1H2gbJTLX6YcQyWcTaeneUjHZjce5eFvG5HlyoQQSJf7hQwDDikbE+6QCHU2X
         /Mtd6sJCzI/4bNqRqv/Oq9djkndHscxA8pK6JxJmmemPaNDtDrHonHujxuUgNZ2lmO55
         ytKXk/ntXHFN4F8detIlmO6G74Cqp273SzjkYbavYANwkgGvSE9eLrt2v0hZpKt/Hki+
         qzGw==
X-Gm-Message-State: AOAM533aEtWREaiYBU5QXRRG5KGKbrAgbflXuLkUZNtCpNrlumXgG+Gx
        hA7+7ksoDbsHv9/+si2pi5nhww==
X-Google-Smtp-Source: ABdhPJwNhChGJRTAH8pT4yzviBH931A0srwDaHeS76htArBnKHVtvY5DjUTA7Q2skvZ9saCaSOt3Ww==
X-Received: by 2002:a63:4415:: with SMTP id r21mr14615350pga.222.1619401268947;
        Sun, 25 Apr 2021 18:41:08 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([116.206.101.229])
        by smtp.gmail.com with ESMTPSA id l3sm12815078pju.44.2021.04.25.18.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Apr 2021 18:41:08 -0700 (PDT)
Date:   Mon, 26 Apr 2021 09:41:02 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Steve MacLean <Steve.MacLean@Microsoft.com>,
        Yonatan Goldschmidt <yonatan.goldschmidt@granulate.io>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] perf: Allow TIME_CONV to be backwards-compatible
 and dump it
Message-ID: <20210426014102.GC176271@leoy-ThinkPad-X240s>
References: <20210412083459.462817-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412083459.462817-1-leo.yan@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 04:34:56PM +0800, Leo Yan wrote:
> The event PERF_RECORD_TIME_CONV was extended for clock parameters, but
> the tool fails to be backwards-compatible for the old event format.

Gentle ping ...

Adrian, could you take a look for this patch series?

Thanks,
Leo
