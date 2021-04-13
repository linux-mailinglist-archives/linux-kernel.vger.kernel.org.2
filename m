Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1535E6C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 21:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347906AbhDMTCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 15:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230397AbhDMTCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 15:02:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ECD1B613CA;
        Tue, 13 Apr 2021 19:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618340550;
        bh=Z8hvYdgOv69qiQpsJ+/2l0t6WJw1oLulD+XPkN84TGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D+l+kCe2DASf1Itba+L3RUIn5GHGmIWMrWTvE9P4UYaA2Uvq9Xgk34GRs0eskvbEj
         4tLnvGakon86bakacrjaioMM6CTbP3rHJPZdGymJoHUSio8Jy0zuon/gMinFpfI71I
         jtR4kZyAg9VG+/ZrhMZmzyFxrLNySXRuQSxH8/GzS+IixC3jlMHu6JU3H4eQi3/U8J
         o76OtLQ186HXOkVJiec9Kum6ISJpLpV2OmarQ9bL2slmWt1Y9c2tVvlcslWj93/eEP
         gAq34+SWUTQ+ihEw6IAPOZBW1TTSa6dEsme59C5Vx+Bq/7JzsP31DnFzY41kNikeaX
         3BMq2w1SYKiYQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3676240647; Tue, 13 Apr 2021 16:02:27 -0300 (-03)
Date:   Tue, 13 Apr 2021 16:02:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: Re: [PATCH v7 3/4] libperf: tests: Add support for verbose printing
Message-ID: <YHXqw4FQAtH/ikMJ@kernel.org>
References: <20210413171606.1825808-1-robh@kernel.org>
 <20210413171606.1825808-4-robh@kernel.org>
 <YHXnu2xRzPpaI3cn@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YHXnu2xRzPpaI3cn@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 13, 2021 at 03:49:31PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Apr 13, 2021 at 12:16:05PM -0500, Rob Herring escreveu:
> > Add __T_VERBOSE() so tests can add verbose output. The verbose output is
> > enabled with the '-v' command line option.
> 
> You forgot to show how this is used, I'm trying:
> 
>   # cd tools/lib/perf
>   # sudo make tests
> 
> So how from the command line one asks for verbose output from the tests?
> 
>   Should be:
> 
>   # sudo make tests V=1
> 

> I'm only getting a move verbose output for the Makefile steps, not from
> the actual tests.
> 
> Perhaps if I read the last cset... will do that now.

Ok, I misread, I thought that was adding a way to enable verbose mode
for _pre-existing tests_, so I tried to use it, it is only used in the
following patch...

- Arnaldo
