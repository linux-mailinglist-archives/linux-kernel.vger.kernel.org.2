Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0E83E19C2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 18:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhHEQma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 12:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbhHEQm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 12:42:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6661CC061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 09:42:14 -0700 (PDT)
Date:   Thu, 5 Aug 2021 18:42:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628181731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M5DpbKfEBRwBFlm77J4m5ItMsLEEb0OMPYwxyZqu6YI=;
        b=QNdLCPGZZ/iz1RjEuSkliemqXTyHiUmWicguY/gxljUxCs9zDW5Tw4WwU5cHhFTaiG40RE
        ABR5g43Mf72L0H/181LUM4wNCO7IRzA4FZY+8zf5rpUwNHQ4zla82YpxwoyPbkiexSiXmf
        K9xi6fsgy31PynJjD4/9DNw/VCed7dR8R9mFjxS0ObIagBdAFDCNTH4xl+movtnmUS4yz2
        kfjCSWGNH+S+g83d/1CWwOxLluzUGHjgfAYp0CARDNi+0DTsIJl7yY1peCPSKfuAqvwVFq
        EHyN2lsRrsN+miB8JqaqnGT3lq9jrf6t6O2BOoVhnFVgZ3sJiNlzwx+hnGWsXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628181731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M5DpbKfEBRwBFlm77J4m5ItMsLEEb0OMPYwxyZqu6YI=;
        b=PRg9KRgp6YeiJqW4dowBin3ardQDUnL4/r+IbIvDyKgXtuxleW0fzuOfMIHYtKiz0sTw29
        R+y+PxxkoLxo6/BQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v4 00/35] SLUB: reduce irq disabled scope and make it RT
 compatible
Message-ID: <20210805164210.2zxpzn2sdogf4kx3@linutronix.de>
References: <20210805152000.12817-1-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210805152000.12817-1-vbabka@suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-05 17:19:25 [+0200], Vlastimil Babka wrote:
> Hi Andrew,
Hi,

> I believe the series is ready for mmotm. No known bugs, Mel found no !RT =
perf
> regressions in v3 [9], Mike also (details below). RT guys validated it on=
 RT
> config and already incorporated the series in the RT tree.

Correct, incl. the percpu-partial list fix.

=E2=80=A6
> RT configs showed some throughput regressions, but that's expected tradeo=
ff for
> the preemption improvements through the RT mutex. It didn't prevent the v=
2 to
> be incorporated to the 5.13 RT tree [7], leading to testing exposure and
> bugfixes.

There was throughput regression in RT compared to previous releases
(without this series). The regression was (based on my testing) only
visible in hackbench and was addressed by adding adaptiv spinning to
RT-mutex. With that we almost back to what we had before :)

=E2=80=A6
> The remaining patches to upstream from the RT tree are small ones related=
 to
> KConfig. The patch that restricts PREEMPT_RT to SLUB (not SLAB or SLOB) m=
akes
> sense. The patch that disables CONFIG_SLUB_CPU_PARTIAL with PREEMPT_RT co=
uld
> perhaps be re-evaluated as the series addresses some latency issues with =
it.

With your rework CONFIG_SLUB_CPU_PARTIAL can be enabled in RT since
v5.14-rc3-rt1. So it has been re-evaluated :)

Regarding SLAB/SLOB: SLOB has a few design parts which are incompatible
with RT (if my memory suits me so it was never attempted to get it
working). SLAB was used before SLUB and required a lot of love. SLUB
performed better compared to SLAB (in both throughput and latency) and
after a while the SLAB patches were dropped.

Sebastian
