Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447203A083A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 02:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhFIAY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 20:24:27 -0400
Received: from mail-pl1-f175.google.com ([209.85.214.175]:44599 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFIAY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 20:24:27 -0400
Received: by mail-pl1-f175.google.com with SMTP id b12so5624913plg.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jun 2021 17:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SUSurW0ZMpnhJbzbS53tzEqvRTwb1JQbgIpFtsDUWIc=;
        b=goZ/SSCbwi7fd6AwwMEZoYjuXpEq5Qpa/PVXI2TpzZL1qeEBx92eBiFPVPZe4ELYzh
         0s87uJVTFrMy0eoj7jUOzZviLk4ERwufGsLCFoXKARsjB93n9pyK8jWVgtFltmV75aRM
         XUMz5bIBsWr06SsrNmdY5hc6pIuqD7aQ3nAD5PLog2kQxr2iPsk9If/UKa2SLorT1mko
         drZUZQxFvZ8RQtsCrRrmeFUbVLsj1yGPnwVOCyo3VeBvDXJsDK23dhpxPnUDXMR8QJ3K
         ZX/Fm5cEvZhcJ+WVP20cemfigfPm9g+FF64KDIzzHZnmHiMWK7evyS2IPoKsMwf1n8GA
         0Q7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SUSurW0ZMpnhJbzbS53tzEqvRTwb1JQbgIpFtsDUWIc=;
        b=fjEveFAxe19qp7rkYkPqJaQcMRnO6iZyZCZHwAdr11oThJs8Yyo7GiL6lxqx2xfopd
         nYlETBLdu4hKVJeVQBYfEAXDdP8BYrSjH8v029nVCeul24pMoK34WkYxjey7H8R8WFTM
         L5j4P1rCraojJlwsH6Y+t6+C2e8D3WmZEA40rhEhSwYO/MHLsdcqDKrU/ACSdogOrqcQ
         J/Qbjq++OEseQjsNR6Q/z76v621DPeUppE/cE+EAoMfrSUS1xcauJ14p0GrIGGT48uVv
         Sr32BONt+YWl3TzecRmlfhrr3IAK2/UNkJ/C4klbv3wRcKza4XBfOZA9hIN2wDCWHpRs
         7Z6g==
X-Gm-Message-State: AOAM533WgIXc6pLqEX0UFgIY7/W91qSJBVswKJD2oaEfFNpyk8H3UD2H
        FaI1HJjU5LPSjhCbn5rnwE0+Cw==
X-Google-Smtp-Source: ABdhPJzz/Yg5KVuOOZfw/OoZ0q9ATA2yy973WJeZW1TwozVYZniWMUiBan3/hasgUiRAdAz0S2kOJQ==
X-Received: by 2002:a17:90a:4092:: with SMTP id l18mr7543340pjg.35.1623198079227;
        Tue, 08 Jun 2021 17:21:19 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (ec2-18-167-84-74.ap-east-1.compute.amazonaws.com. [18.167.84.74])
        by smtp.gmail.com with ESMTPSA id fs10sm3314608pjb.31.2021.06.08.17.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 17:21:18 -0700 (PDT)
Date:   Wed, 9 Jun 2021 08:21:11 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 7/8] perf auxtrace: Use WRITE_ONCE() for updating
 aux_tail
Message-ID: <20210609002111.GC4640@leoy-ThinkPad-X240s>
References: <20210602103007.184993-1-leo.yan@linaro.org>
 <20210602103007.184993-8-leo.yan@linaro.org>
 <YL47tdD0ygaErZu+@hirez.programming.kicks-ass.net>
 <YL+jHu4c5rLkKb9i@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL+jHu4c5rLkKb9i@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Jun 08, 2021 at 02:04:30PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jun 07, 2021 at 05:31:01PM +0200, Peter Zijlstra escreveu:
> > On Wed, Jun 02, 2021 at 06:30:06PM +0800, Leo Yan wrote:
> > > Use WRITE_ONCE() for updating aux_tail, so can avoid unexpected memory
> > > behaviour.
> > > 
> > > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Leo, this one is dependendant on the 6/8, will wait for a resubmission,
> keeping 5/8 tho, as was Acked and applies cleanly, perf/core.

Yeah, will respin for patches 6/8 and 7/8.

Thanks for merging patch 5/8.

Leo
