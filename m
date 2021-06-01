Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4A33973A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 14:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233911AbhFAM6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 08:58:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233064AbhFAM6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 08:58:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C02496139A;
        Tue,  1 Jun 2021 12:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622552229;
        bh=+tNYRrbJaNJpLw0qIAcircs1AmrNncomZDxq2GxZ4vQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mDJclJmxB+QtzHuW4UrMAQ/Uea/iCtbWGfJSbZzoAME42LQMRwSk88NvM8LJksv+N
         W1xaLgLNiMCy7yYI+ivzK3tIGOfR/ipjEtgXuvxnlm/YMdtmvzHoMPpM+f36nrL+N8
         MMRI4ibGehWKZymtUWuwMdlrGXEJKfMCqyDKZyLw43YM9NAhIH8C5fCv4MKqD/qf8k
         nw8UVfH9A07Tb1aOV+A3VZP68PhmKAV72azIC+NcaS8537kwSlwPCd1rfJ8aya4UAJ
         5P3aqjtyKWR4CV4sfN+B1+W8IdlmQykBllQUstBvPdu3cdNHW3j8Gc+vg33+0EmJ4m
         LdjXUDG11+Lvg==
Date:   Tue, 1 Jun 2021 13:57:03 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        honnappa.nagarahalli@arm.com, Zachary.Leaf@arm.com,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 4/5] arm64: perf: Add userspace counter access disable
 switch
Message-ID: <20210601125703.GC28025@willie-the-truck>
References: <20210517195405.3079458-1-robh@kernel.org>
 <20210517195405.3079458-5-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210517195405.3079458-5-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, May 17, 2021 at 02:54:04PM -0500, Rob Herring wrote:
> Like x86, some users may want to disable userspace PMU counter
> altogether. Add a sysfs 'rdpmc' file to control userspace counter
> access. The default is '1' which is enabled. Writing '0' disables
> access.
> 
> In the case of multiple PMUs (i.e. big.LITTLE), the control is per PMU
> and userspace must disable access on each PMU.
> 
> Note that x86 also supports writing '2' to globally enable user access.
> As there's not existing userspace support to worry about, this shouldn't
> be necessary for Arm. It could be added later if the need arises.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v8:
>  - Adjust due to patch 3 changes
> v7:
>  - New patch
> ---
>  arch/arm64/kernel/perf_event.c | 64 ++++++++++++++++++++++++++++++++--
>  include/linux/perf/arm_pmu.h   |  4 ++-
>  2 files changed, 65 insertions(+), 3 deletions(-)

I understand you've tried to follow the x86 behaviour here, but I think it
might be better to implement this as a sysctl on arm64, with the default
behaviour being that userspace access is _disabled_. Having the attribute
per-PMU doesn't really make a lot of sense to me and we don't have any
compatibility issues to worry about given that we've not exposed this to
userspace yet.

That should also be straightforward to implement (famous last words... yell
if it isn't).

Will
