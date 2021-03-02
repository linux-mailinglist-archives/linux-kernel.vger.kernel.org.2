Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A12A32A3C3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379053AbhCBJjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 04:39:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1837920AbhCBJL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 04:11:29 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1C3C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 01:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=JX1C5DGuVebGBtGesATRPTSUT33rJIsA6K22Xk8Yv98=; b=a7YZbcDsDOUveA3I4Y+6VqUd3W
        O1RTePZy5WpgcxfvRyDQ0uekheSN8gROr4PBlzBjFEMZ3AEVwYhd6RpyM2K6mpvoC9pkHy3zhy0WW
        GU+WkK0gidfJNlWdZzQeCDWTRy5QXCnhW645wlJIKm7dwtGgZAYwqEjQw2NWAOv8YTkT9u5zcqdKr
        RvLuRMmcLjKoX4jREuymY/LBDqAs+CIzVs88xhB/yyhTy32ccclezLL/fZ/j8fWWJjwFdKwTSQudz
        q6TOde15uhgOAI3cXxitn/WDeOyIwMTD9Wxv/KNSKhkq+7d4lrcXs0Je2DlS+zQmI5uPXgaC83Mrj
        EH706+3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lH135-00008O-IK; Tue, 02 Mar 2021 09:10:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A8DD30018A;
        Tue,  2 Mar 2021 10:10:33 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3A892215BD3B; Tue,  2 Mar 2021 10:10:32 +0100 (CET)
Date:   Tue, 2 Mar 2021 10:10:32 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Rik van Riel <riel@surriel.com>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Parth Shah <parth@linux.ibm.com>
Subject: Re: [PATCH] sched/fair: Prefer idle CPU to cache affinity
Message-ID: <YD4BCDlxvn7ub+9U@hirez.programming.kicks-ass.net>
References: <20210226164029.122432-1-srikar@linux.vnet.ibm.com>
 <ab046b9d5bcd29b2eb759cd999e2f578a683c673.camel@surriel.com>
 <YD0L6sba9RfXX+tM@hirez.programming.kicks-ass.net>
 <20210301170601.GJ2028034@linux.vnet.ibm.com>
 <YD0h5I7qmDO2zlkE@hirez.programming.kicks-ass.net>
 <20210302073946.GL2028034@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210302073946.GL2028034@linux.vnet.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 02, 2021 at 01:09:46PM +0530, Srikar Dronamraju wrote:
> > Oh, could be, I didn't grep :/ We could have core code keep track of the
> > smt count I suppose.
> 
> Could we use cpumask_weight(cpu_smt_mask(this_cpu)) instead?

cpumask_weight() is potentially super expensive. With CPUMASK_OFFSTACK
you get at least one more cache miss and then the bitmap might be really
long.

Best to compute the results once and use it later.
