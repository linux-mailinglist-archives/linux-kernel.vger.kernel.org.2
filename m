Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1B632BF90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579878AbhCCSc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441811AbhCCQuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:50:24 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112B2C061765
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 08:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0DzFIM+EUTjiOjJVBMqKyqS4BHki234n3r4/jWOomlM=; b=C+MPKxnaArUY0J/dzHwZ6PfuGy
        P5yvOQnDgBJy9qLyYrTTVYo8dOl+ttvdFuY8M5OGYfBk6s8tcSgHxc+hsnmDODGozvZabI31z9KEv
        vTPbDuuCyhjA4wsjaTfpJ3DxrbVDstm/Z3P09enQdBlAlDdUpMwpIQoC0wmexw8Wqt8upFuzVPt2j
        TqU/55rv3WA6k3UBTxd4R9zcVcnvrKVGRFsvx9MUCw+r8B7sMigOwBKXNJEbXWDTcCadpwuSwdefw
        JEebpC9+j+bsMF9a97zgUj8SckQdBiKK8Xgm6XPo3ood9FapawPfkpdDcsUOaBSiGeJ+pidPCrMNk
        LqFZEqyw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lHTo0-005TYo-I9; Wed, 03 Mar 2021 15:52:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EECB0303205;
        Wed,  3 Mar 2021 16:52:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CF08723662BED; Wed,  3 Mar 2021 16:52:54 +0100 (CET)
Date:   Wed, 3 Mar 2021 16:52:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     hannes@cmpxchg.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH v2 2/4] psi: Use ONCPU state tracking machinery to detect
 reclaim
Message-ID: <YD+w1i6ndWNkgo4t@hirez.programming.kicks-ass.net>
References: <20210303034659.91735-1-zhouchengming@bytedance.com>
 <20210303034659.91735-3-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303034659.91735-3-zhouchengming@bytedance.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 03, 2021 at 11:46:57AM +0800, Chengming Zhou wrote:
> Move the reclaim detection from the timer tick to the task state
> tracking machinery using the recently added ONCPU state. And we
> also add task psi_flags changes checking in the psi_task_switch()
> optimization to update the parents properly.
> 
> In terms of performance and cost, this ONCPU task state tracking
> is not cheaper than previous timer tick in aggregate. But the code is
> simpler and shorter this way, so it's a maintainability win. And
> Johannes did some testing with perf bench, the performace and cost
> changes would be acceptable for real workloads.
> 
> Thanks to Johannes Weiner for pointing out the psi_task_switch()
> optimization things and the clearer changelog.
> 
Co-developed-by: Muchun ?
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
