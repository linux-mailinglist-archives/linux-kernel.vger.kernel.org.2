Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E08132A3D0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382569AbhCBJj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1838006AbhCBJRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:17:33 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73374C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 01:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rW9sPjatAJVmVqJxc1zaXchYwyYTqpwEvQn9jEI0lyY=; b=BVjNj063tPI6VOEugurjjHN9gy
        uu/3I7DnNGjKid8vDbhk1pk5p2cW87E7kYpUi42cMohWnenHfpwTy1phRMV11mWA9o4Lncz2Nlc6X
        LIb+A1DSJOzHn1RrWTzqaYDbFzFM2SfJIxL0YEK/EGWQp2pd1vPCvNgzzs/xSob7JIzAaKReMes7H
        b4G2lmzIfH/JFr9uf5ooXUn97s4cKH07HkTG9v3Cejfb7CbvUyTJXDoj7DF7MRQQOTF5J7I53bkd7
        VJ91uPnEyHChEQsFH3EqOzjBTSU4VKntEoSibfVTmIWuKRI6RWMpPQVp90WdzQmadL3/phfL/xc3y
        ccrqvFVg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lH18v-00GrwX-SE; Tue, 02 Mar 2021 09:16:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E7633003E1;
        Tue,  2 Mar 2021 10:16:37 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3FDB4234E17C3; Tue,  2 Mar 2021 10:16:37 +0100 (CET)
Date:   Tue, 2 Mar 2021 10:16:37 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>, andi.kleen@intel.com
Subject: Re: [PATCH] clocksource: don't run watchdog forever
Message-ID: <YD4CdQqX5Lea1rB5@hirez.programming.kicks-ass.net>
References: <1614653665-20905-1-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614653665-20905-1-git-send-email-feng.tang@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 10:54:24AM +0800, Feng Tang wrote:
> clocksource watchdog runs every 500ms, which creates some OS noise.
> As the clocksource wreckage (especially for those that has per-cpu
> reading hook) usually happens shortly after CPU is brought up or
> after system resumes from sleep state, so add a time limit for
> clocksource watchdog to only run for a period of time, and make
> sure it run at least twice for each CPU.
> 
> Regarding performance data, there is no improvement data with the
> micro-benchmarks we have like hackbench/netperf/fio/will-it-scale
> etc. But it obviously reduces periodic timer interrupts, and may
> help in following cases:
> * When some CPUs are isolated to only run scientific or high
>   performance computing tasks on a NOHZ_FULL kernel, where there
>   is almost no interrupts, this could make it more quiet
> * On a cluster which runs a lot of systems in parallel with
>   barriers there are always enough systems which run the watchdog
>   and make everyone else wait
> 
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Urgh.. so this hopes and prays that the TSC wrackage happens in the
first 10 minutes after boot.

Given the previous patch, the watchdog wouldn't be running at all on
modern machines, so why wreck it for the old machines where it's
actually needed?
