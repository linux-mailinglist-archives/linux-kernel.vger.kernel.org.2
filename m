Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E12348102
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 19:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237726AbhCXSyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 14:54:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237571AbhCXSyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 14:54:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC4E961A07;
        Wed, 24 Mar 2021 18:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1616612073;
        bh=8fWPNDYKXJqAFEWuKiNC/u4xN9UBeB93KGJ+cFLB/58=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y5s/EiFwG7iGYKvQ+qcNVg6I4vBZhsw8bSKBZKr2omh0QBqMEou7s1ddnRXMp60i5
         GP2srrVXjdUz8dahnI9GubC6fxM0UdWGjCbFNsqm2BQL79w6pZ84A+Qz0fdlxO9IvY
         m8UUoAz3PUKls12i+TbhnYcesfpJ13A5LnK5YjZg=
Date:   Wed, 24 Mar 2021 11:54:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        debian-ia64 <debian-ia64@lists.debian.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Anatoly Pugachev <matorola@gmail.com>
Subject: Re: [PATCH] ia64: Ensure proper NUMA distance and possible map
 initialization
Message-Id: <20210324115432.4102cd93d35a2edb1742dec7@linux-foundation.org>
In-Reply-To: <20210318130617.896309-1-valentin.schneider@arm.com>
References: <20210318130617.896309-1-valentin.schneider@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2021 13:06:17 +0000 Valentin Schneider <valentin.schneider@arm.com> wrote:

> John Paul reported a warning about bogus NUMA distance values spurred by
> commit:
> 
>   620a6dc40754 ("sched/topology: Make sched_init_numa() use a set for the deduplicating sort")
> 
> In this case, the afflicted machine comes up with a reported 256 possible
> nodes, all of which are 0 distance away from one another. This was
> previously silently ignored, but is now caught by the aforementioned
> commit.
> 
> The culprit is ia64's node_possible_map which remains unchanged from its
> initialization value of NODE_MASK_ALL. In John's case, the machine doesn't
> have any SRAT nor SLIT table, but AIUI the possible map remains untouched
> regardless of what ACPI tables end up being parsed. Thus, !online &&
> possible nodes remain with a bogus distance of 0 (distances \in [0, 9] are
> "reserved and have no meaning" as per the ACPI spec).
> 
> Follow x86 / drivers/base/arch_numa's example and set the possible map to
> the parsed map, which in this case seems to be the online map.
> 
> Link: http://lore.kernel.org/r/255d6b5d-194e-eb0e-ecdd-97477a534441@physik.fu-berlin.de
> Fixes: 620a6dc40754 ("sched/topology: Make sched_init_numa() use a set for the deduplicating sort")
> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> ---
> This might need an earlier Fixes: tag, but all of this is quite old and
> dusty (the git blame rabbit hole leads me to ~2008/2007)
> 

Thanks.  Is this worth a cc:stable tag?
