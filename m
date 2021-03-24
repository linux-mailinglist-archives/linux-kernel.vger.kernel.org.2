Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08E43479F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235709AbhCXNum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:50:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:50202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235681AbhCXNuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:50:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69F0E61A05;
        Wed, 24 Mar 2021 13:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616593811;
        bh=aNIUJZa/lZ03wNw+yFa9d/Wbwsmp+EQorebI01Hw0SA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gAh7pspTnjWZxJXblhn2RL44rPrDx1ZD6MuOB/1/m9eRHKcTBYfh4V2uSRS2qS3ds
         2n/fUEgqoGsMSQ1yqs8W8iGQguvA4HtS1pc4Th3gdPYM+9QN7weSdYMNqT8liBfIoM
         nvCkrExNO1N6CDvaLv5FFC8fFCUZDhDgVsOSJP1hsxlikvv+y/poTCaTQSJAQHr29r
         FUheR5l5RwBKBcajnsvUvdsPxdNGusJ4SSRYMIl4iYrfB4BC7AoedAcnZ7zqqGRmzH
         3yYidZ2/sqhMgZuFmxbVwi+2NXZNdqTc7ZLYJ2tn1CCHoVGF0qD2pK1R4QSnNWjeKu
         w5KJB3HbXaGlw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1241440647; Wed, 24 Mar 2021 10:50:09 -0300 (-03)
Date:   Wed, 24 Mar 2021 10:50:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf test: Change to use bash for daemon test
Message-ID: <YFtDkN3IZz6UDmC/@kernel.org>
References: <20210320104554.529213-1-leo.yan@linaro.org>
 <CAM9d7ch4TQtwK_VxHuJCB=szyq8K0MurKgFjJAcNbw6dDVU8=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ch4TQtwK_VxHuJCB=szyq8K0MurKgFjJAcNbw6dDVU8=g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 24, 2021 at 10:45:22AM +0900, Namhyung Kim escreveu:
> On Sat, Mar 20, 2021 at 7:46 PM Leo Yan <leo.yan@linaro.org> wrote:
> > [1] https://bugs.launchpad.net/ubuntu/+source/dash/+bug/139097
> >
> > Fixes: 2291bb915b55 ("perf tests: Add daemon 'list' command test")
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied.

- Arnaldo

