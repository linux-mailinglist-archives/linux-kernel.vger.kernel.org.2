Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA203CFE3C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 17:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbhGTPIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 11:08:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbhGTOgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 10:36:17 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8C8C0613DD
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 08:15:48 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id y17so22755660pgf.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 08:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t7POuqHMK0kiOcKyuNd0t9xpyvgUftGZKOfPl7wRXV8=;
        b=OEWMJUpDESSYgSUzi8u/Y8eVz9gAEAdoMdd1mUvESbEkyjoFgCmbOfi+V5WMd2Zt6/
         ZbBAhTzIkISUGAWoOuySQBUATU886tL+cRD6qYIjBQW75vyoxAdTeyoDeI9asb1vK/8C
         G1+WXvhxSS6sYpQHeTgXHe9jrv12FYNVWW0FwdNFfODPdaI2nBmp4tmC9/2adYJbwXXN
         EKpcqsYkZSg63UrMZqqWFYrwz9d8+WMJ/rOS6mRrVzDGVGgGx6zNhALmTSc4SDncf+Ml
         dqMnL35SRkwygoSCFp8m4ItZQQ82hmZphB7/1hWmQ4oLTx0eZJieCAcBJl4eCWJ6vDi4
         9TSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t7POuqHMK0kiOcKyuNd0t9xpyvgUftGZKOfPl7wRXV8=;
        b=gIHZIGK28mQ0jBA3Zb1+3NvjkED2+HbZrxzbW+p0v+zdZOT/HC5eRM3c2jA0IeDaco
         T3ZIrhw9UHJpVeuI9pxvWzHBe44Rp2QByIAQA6k1QjnRwEOvN12iKA0cZG3oxO0Gm5BI
         4CoDWUIRQ7s/dsgbYEZDlepjJEDEtyHRlP843ezrZFZDn/k4E7P6J7IqHPXLtHFXi3j1
         n8VPqmNfB9lPPaWfN9pPm8TQlJuBY9jxZcoo7DrNQVXESOUhIa9AFTG6HStFcYbIiwQx
         0F55xPl6JW3SwgjsKz21KuTmzc9Ql20kcdZRnqdw25Sn7B8OOpFZ9FPmiMP6poGwL/99
         oN9Q==
X-Gm-Message-State: AOAM531RN++wi4TMsndwvYvSHWzYqJTQoorQqNo7gdZsBDBY0hQcbBM5
        8avTxAS1MmpgbOUlPqx5vBCo4A==
X-Google-Smtp-Source: ABdhPJxAQUx7377uhcaFrBC1bTT0cHvXp4BSlpdPHXq1j6NjA06uAiRU53oovxLWEe98StBK44zYiQ==
X-Received: by 2002:aa7:8e51:0:b029:332:920f:1430 with SMTP id d17-20020aa78e510000b0290332920f1430mr32274930pfr.1.1626794148448;
        Tue, 20 Jul 2021 08:15:48 -0700 (PDT)
Received: from p14s (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id c204sm9544646pfb.90.2021.07.20.08.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 08:15:45 -0700 (PDT)
Date:   Tue, 20 Jul 2021 09:15:43 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        leo.yan@linaro.org, al.grant@arm.com, branislav.rankov@arm.com,
        denik@chromium.org, suzuki.poulose@arm.com,
        anshuman.khandual@arm.com, John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] perf cs-etm: Split --dump-raw-trace by AUX records
Message-ID: <20210720151543.GA2296792@p14s>
References: <20210624164303.28632-1-james.clark@arm.com>
 <20210624164303.28632-3-james.clark@arm.com>
 <20210705193338.GB1493103@p14s>
 <YO8ivntow2JfdQWW@kernel.org>
 <20210719163336.GA2255168@p14s>
 <YPXcOrkjYdUJ3iRl@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YPXcOrkjYdUJ3iRl@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 05:10:34PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jul 19, 2021 at 10:33:36AM -0600, Mathieu Poirier escreveu:
> > Hi Arnaldo,
> > 
> > On Wed, Jul 14, 2021 at 02:45:34PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Mon, Jul 05, 2021 at 01:33:38PM -0600, Mathieu Poirier escreveu:
> > > > On Thu, Jun 24, 2021 at 05:43:03PM +0100, James Clark wrote:
> > > > > for example:
> > > > > 
> > > > >         Idx:808; ID:1c; I_BAD_SEQUENCE : Invalid Sequence in packet.[I_ASYNC]
> > > > >         ...
> > > > >         PKTP_ETMV4I_0016 : 0x0014 (OCSD_ERR_INVALID_PCKT_HDR) [Invalid packet header]; TrcIdx=822
> > > > > 
> > > > > Signed-off-by: James Clark <james.clark@arm.com>
> > > > > ---
> > > > >  tools/perf/util/cs-etm.c | 20 ++++++++++++++++++--
> > > > >  1 file changed, 18 insertions(+), 2 deletions(-)
> > > > > 
> > > > 
> > > > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > 
> > > 
> > > 
> > > Thanks, applied.
> > 
> > This patch is the second of a two patch series[1][2].  The first one was applied and
> > is in Linus' current master branch.  But I can't find the second one in
> > either your core branch or Linus', and that despite your reply above that it has been
> > applied.  As such I am guessing something went wrong with the process.  
> > 
> > How do you want to proceed - should we resend the second patch[2] or you still
> > have it somewhere in your Inbox?
> 
> My bad, its no in tmp.perf/urgent, after testing together with other
> patches will move to perf/urgent and by the end of this week I'll submit
> it to Linus, sorry.
>

Very good - thanks for the follow up.

> - Arnaldo
>  
> > Thanks,
> > Mathieu
> > 
> > [1]. https://lists.linaro.org/pipermail/coresight/2021-June/006575.html
> > [2]. https://lists.linaro.org/pipermail/coresight/2021-June/006576.html
> > 
> > > 
> > > - Arnaldo
> > > 
> 
> -- 
> 
> - Arnaldo
