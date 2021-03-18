Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646E53406C4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbhCRNWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231201AbhCRNV4 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:21:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A94DF64EF6;
        Thu, 18 Mar 2021 13:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616073715;
        bh=EzRZfMoErI7SpOr28oczHPC/NPJ0PuQ4sfKgbL99TPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7+oHsjUfHF8z9IIXqF2nSRJwwX1GEhdA6EOxzs+LQJ7kxYo1EIbc28Oajx7uHR9v
         8FH8KEvEavNNJ5dnx4UjEdBlbwYiIXebWT+Bb+5SVSCiEtcUzMviItLLCGiuXFHw4T
         de6nXjdkAg7ple498WPlGcQTmnaXBD2FEH9+g4D+oPyT9efgA8JK6ex5o36bguVCV+
         QzYF/dZB6J4YgwsO8QoyJCm99qmdPMelM6VhYFn/UZ/cLNo0Z1YW3xVT+EuJkjbsiv
         r44v3nu40PVwmjqJKpd/JdNfzIyobKahQoBxx6HolG3zCm5GqMAEgroC/RAafcseKU
         gXKt9Es9NZxig==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7F4C440647; Thu, 18 Mar 2021 10:21:53 -0300 (-03)
Date:   Thu, 18 Mar 2021 10:21:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>, Mark Rutland <mark.rutland@arm.com>
Cc:     "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2 11/27] perf parse-events: Support hardware events
 inside PMU
Message-ID: <YFNT8YpR7bnCjmdf@kernel.org>
References: <YEu9usdFl6VSnOQ7@krava>
 <c40d6187-9391-40de-aea8-7389bb369555@linux.intel.com>
 <YE+balbLkG5RL7Lu@krava>
 <fd88f214-f0a4-87bc-ef52-ee750ca13a8d@linux.intel.com>
 <YFC615nTdUR/aLw5@krava>
 <65624432-2752-8381-d299-9b48ec508406@linux.intel.com>
 <YFHUo1I8cYf502qJ@krava>
 <b0ec8d05-acbc-3021-2e74-684d119de2db@linux.intel.com>
 <YFIHVQPG3TEeiOpP@kernel.org>
 <YFNEpRILOTwh3svv@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFNEpRILOTwh3svv@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Mar 18, 2021 at 01:16:37PM +0100, Jiri Olsa escreveu:
> On Wed, Mar 17, 2021 at 10:42:45AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Wed, Mar 17, 2021 at 08:17:52PM +0800, Jin, Yao escreveu:
> > > I'm OK to only support 'cpu_core/cpu-cycles/' or 'cpu_atom/cpu-cycles/'. But
> > > what would we do for cache event?

> > > 'perf stat -e LLC-loads' is OK, but 'perf stat -e cpu/LLC-loads/' is not supported currently.

> > > For hybrid platform, user may only want to enable the LLC-loads on core CPUs
> > > or on atom CPUs. That's reasonable. While if we don't support the pmu style
> > > event, how to satisfy this requirement?

> > > If we can support the pmu style event, we can also use the same way for
> > > cpu_core/cycles/. At least it's not a bad thing, right? :)

> > While we're discussing, do we really want to use the "core" and "atom"
> > terms here? I thought cpu/cycles/ would be ok for the main (Big) CPU and
> > that we should come up with some short name for the "litle" CPUs.

> > Won't we have the same situation with ARM where we want to know the
> > number of cycles spent on a BIG core and also on a little one?

> > Perhaps 'cycles' should mean all cycles, and then we use 'big/cycles/' and
> > 'little/cycles/'?

> do arm servers already export multiple pmus like this?
> I did not notice

I haven't checked, but AFAIK this BIG/Little kind of arch started there,
Mark?

- Arnaldo
 
> it'd be definitely great to have some unite way for this,
> so far we have the hybrid pmu detection and support in
> hw events like cycles/instructions.. which should be easy
> to follow on arm
> 
> there's also support to have these events on specific pmu
> pmu/cycles/ , which I still need to check on
