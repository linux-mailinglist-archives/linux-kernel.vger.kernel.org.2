Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63BD32548A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 18:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhBYRaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 12:30:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBYRae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 12:30:34 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BAEC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 25 Feb 2021 09:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ST/Haa8ApvfQZwyll9UagFEHhmOAnskHO/715jxkpNk=; b=ZC8moU0YItGDXHkrjCixgQaLXa
        2rGw0VX+j7Z50DtXCftHeBU+hPA5sLGzP3ylpIPrs/vzPRBg9OjMQTHMcKGgqHbp96A1YsKsUrLDT
        Arud/lSLTvEzdUXGgcvyJ0GweDIewlMLI2R+lAf6wUeSpCXbgcR2zaqVaYCWB0M/dAOZx+HQQMPt2
        S17mF/oCoB8wlCRz9J5KyB524QqkOnWCcQfs0TJdpkVpDtNyzhENkc47asE/uTHEoqL0MBeDICL+l
        2zRpu0W3PYlffcioRHHIqaBzBQzole06GyF462JC/TRislIAQyfjZEFD9W9D26bqM5yAzgr3IeMf3
        7+R07vVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFKSR-0003JV-Ke; Thu, 25 Feb 2021 17:29:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 045DD3006D0;
        Thu, 25 Feb 2021 18:29:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B07C92D944B8C; Thu, 25 Feb 2021 18:29:43 +0100 (CET)
Date:   Thu, 25 Feb 2021 18:29:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     vincent.donnefort@arm.com
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, linux-kernel@vger.kernel.org,
        qperret@google.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com
Subject: Re: [PATCH v2 0/2] Fix task utilization accountability for EAS
Message-ID: <YDfehwwkMQUS3lAZ@hirez.programming.kicks-ass.net>
References: <20210225083612.1113823-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225083612.1113823-1-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 25, 2021 at 08:36:10AM +0000, vincent.donnefort@arm.com wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> 
> Changelog since v1:
>   - Fix the issue in compute_energy(), as a change in cpu_util_next() would
>     break the OPP selection estimation.
>   - Separate patch for lsub_positive usage in cpu_util_next()
> 
> Vincent Donnefort (2):
>   sched/fair: Fix task utilization accountability in compute_energy()
>   sched/fair: use lsub_positive in cpu_util_next()
> 
>  kernel/sched/fair.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)

Thanks!
