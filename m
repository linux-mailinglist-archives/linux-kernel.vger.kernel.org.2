Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C59E3BA029
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 14:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbhGBMDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 08:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbhGBMDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 08:03:16 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817CFC061764
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 05:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=D59vjIFHsm1bwSteYMmO3Ib3ErHnsCny5NoZ3raY1vo=; b=l9ffb1YsS4W/xQ4gKtVC/5wkLQ
        DHi7qgqIscJ1Ae4y9g/YeweFURc7Tv/tSo9aNi+oJEZVHwtBP2iKKkQTqEIEp8EbpP666EikPmFuq
        tRi9J0OHjN1Vg4V9UU1jRAPYH6SgwsyFFZ3a8Cmv1hgqPUKqPQBgs1wmqT04Vo5+oZo9Aqcu/Fe2N
        LnyTNaq8w32s6wmNybdErCXJCqtrRb8uAC02w8TlkEFO2DaQg78+ZlOSCqerXUHM4u86RnVxPhSMb
        1QUllXIZiln4Ushqu1tzTsyfGSt66/diyHCLbgxTWjiJc5OvSkJW9q+mrsv6ORomFWlbR5sG+0TKo
        3whEk7Ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lzHqQ-00Dqnn-7z; Fri, 02 Jul 2021 12:00:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A2070300091;
        Fri,  2 Jul 2021 14:00:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 728D92CEACB1C; Fri,  2 Jul 2021 14:00:29 +0200 (CEST)
Date:   Fri, 2 Jul 2021 14:00:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Xuewen Yan <xuewen.yan94@gmail.com>, valentin.schneider@arm.com,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        patrick.bellasi@matbug.net, qperret@google.com
Subject: Re: [PATCH v2] sched/uclamp: Avoid getting unreasonable ucalmp value
 when rq is idle
Message-ID: <YN7/3RkISFqM4rt+@hirez.programming.kicks-ass.net>
References: <20210630141204.8197-1-xuewen.yan94@gmail.com>
 <YN70sbUGh2pViWEQ@hirez.programming.kicks-ass.net>
 <20210702115421.gcju2vluhof6rp6f@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210702115421.gcju2vluhof6rp6f@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2021 at 12:54:21PM +0100, Qais Yousef wrote:
> Yep. How about the below?
> 
> --->8---
> 
> sched/uclamp: Ignore max aggregation if rq is idle
> 
> When a task wakes up on an idle rq, uclamp_rq_util_with() would max
> aggregate with rq value. But since there is no task enqueued yet, the
> values are stale based on the last task that was running. When the new
> task actually wakes up and enqueued, then the rq uclamp values should
> reflect that of the newly woken up task effective uclamp values.
> 
> This is a problem particularly for uclamp_max because it default to
> 1024. If a task p with uclamp_max = 512 wakes up, then max aggregation
> would ignore the capping that should apply when this task is enqueued,
> which is wrong.
> 
> Fix that by ignoring max aggregation if the rq is idle since in that
> case the effective uclamp value of the rq will be the ones of the task
> that will wake up.
> 
> --->8---

Much better, I've updated it. Thanks!
