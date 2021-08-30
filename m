Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7BD3FBE49
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 23:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbhH3V3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 17:29:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237699AbhH3V3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:29:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDAF360F3A;
        Mon, 30 Aug 2021 21:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630358928;
        bh=DoSIVZJnXQBzOFLGB4a+k1f27WeYyH45e38RAZgTL6I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tBfkX1qqTyFbrdQLFoco87CGTGwC/U1HagyX2D5DhEqCBag9RZPBEjP+e+MPfqGYD
         n126cWSbWstyd9319yb8PpDTvXqJBS1Xo7PdoGII9s860lioFfF5s9Z1CJ2mOweJ+W
         AklaDt4eOmhiPyX0r184NdkSo+Zjf8miGa8ZNviIy9Fow14yG5x5/Uea3pSc8xlmQd
         L43VlOk4lbxXtS10N+vi2sQ7fkmDgzrNHGjB+dIcPBoBFyH7pGdjMBJBeLtLuf43qa
         pzOi8K5CE1+816Ks0Mccrg31XjrX7QOsZTbKbsBA6RvpaaIoKd3bc6Cxl8BcusNeWe
         ZdBR9rw2qEBqg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 488364007E; Mon, 30 Aug 2021 18:28:46 -0300 (-03)
Date:   Mon, 30 Aug 2021 18:28:46 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joshua Martinez <jrm5317@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        eranian@google.com, Joshua Martinez <joshuamart@google.com>
Subject: Re: [PATCH] perf data: Correct -h output.
Message-ID: <YS1NjqFOa3cktyEq@kernel.org>
References: <20210824205829.52822-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824205829.52822-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 24, 2021 at 01:58:29PM -0700, Ian Rogers escreveu:
> From: Joshua Martinez <joshuamart@google.com>
> 
> There is currently only 1 perf data command, but supporting extra
> commands was breaking the help output. Simplify for now so that the help
> output is correct.
> 
> Before:
> $ perf data -h

Thanks, applied.

- Arnaldo

