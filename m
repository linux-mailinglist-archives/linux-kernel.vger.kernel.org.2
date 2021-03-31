Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C87F3503B0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 17:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbhCaPjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 11:39:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236421AbhCaPiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 11:38:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CF1D60FED;
        Wed, 31 Mar 2021 15:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617205132;
        bh=zSKNNt8aHpVOX7T1mrGusbLW0X9P8mDEBnTRjCK5rWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kXb8HMKzNCMDmWEsyoz6cYK42VRs7763h3dgrABPa04VRqfZx0PIX+QlCr3xM30bG
         FXGIk8u9jl0Ks0KwB4Vtqqh4HJuhOOIM2TwuZ2lLhC35GkLsZwH+tGLxETrlvB/Xbq
         rN60C/MqtfB4tnmo9f1b3sCq8P/hOCh1F56NdYn9UWpHMpLb/Ts6vEPDWrIu7JDKfD
         nD8lMH5xZ7mm7ZK0sSTktM/1hcsEMINzyxc2toeRFA0hogjvHlXyX6dj2xYZV13N8S
         8hE3OIteR2wcc+0ePV3Zkros/1XNZERWRn0EhiQ/XTxMHZoNN3uXyg5zuRuYDQHm8w
         lF9TNTJX//avw==
Date:   Wed, 31 Mar 2021 16:38:46 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
        Zachary.Leaf@arm.com, Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 02/10] arm64: perf: Enable PMU counter direct access
 for perf event
Message-ID: <20210331153845.GB7815@willie-the-truck>
References: <20210311000837.3630499-1-robh@kernel.org>
 <20210311000837.3630499-3-robh@kernel.org>
 <20210330153125.GC6567@willie-the-truck>
 <CAL_JsqKN4=T4tHofEoBoWVEZSQEj_m=561_kEdEEkz5szHszhQ@mail.gmail.com>
 <CAL_JsqKqKKb8uXSxQKT4ZMqMv8dt3ABpP+T8x+A1-zb2RKjCNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKqKKb8uXSxQKT4ZMqMv8dt3ABpP+T8x+A1-zb2RKjCNA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 30, 2021 at 04:08:11PM -0500, Rob Herring wrote:
> On Tue, Mar 30, 2021 at 12:09 PM Rob Herring <robh@kernel.org> wrote:
> > On Tue, Mar 30, 2021 at 10:31 AM Will Deacon <will@kernel.org> wrote:
> > > The logic here feels like it
> > > could with a bit of untangling.
> >
> > Yes, I don't love it, but couldn't come up with anything better. It is
> > complicated by the fact that flags have to be set before we assign the
> > counter and can't set/change them when we assign the counter. It would
> > take a lot of refactoring with armpmu code to fix that.
> 
> How's this instead?:
> 
> if (armv8pmu_event_want_user_access(event) || !armv8pmu_event_is_64bit(event))
>         event->hw.flags |= ARMPMU_EL0_RD_CNTR;
> 
> /*
> * At this point, the counter is not assigned. If a 64-bit counter is
> * requested, we must make sure the h/w has 64-bit counters if we set
> * the event size to 64-bit because chaining is not supported with
> * userspace access. This may still fail later on if the CPU cycle
> * counter is in use.
> */
> if (armv8pmu_event_is_64bit(event) &&
>     (!armv8pmu_event_want_user_access(event) ||
>      armv8pmu_has_long_event(cpu_pmu) || (hw_event_id ==
> ARMV8_PMUV3_PERFCTR_CPU_CYCLES)))
>         event->hw.flags |= ARMPMU_EVT_64BIT;

I thought there were some cases where we could assign cycles event to an
event counter; does that not happen anymore?

Will
