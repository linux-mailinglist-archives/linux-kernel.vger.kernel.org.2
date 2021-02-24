Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1C4323FF9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 16:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbhBXOah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 09:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232821AbhBXNQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 08:16:49 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B398AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 05:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bO+IGxOgmPE2yAEb0gyPEe1omFXVyB0p0GBPLMxhBBk=; b=ZCqPcNPfFGfdAGX1u/LGswuiWV
        iOPCv5wwtSeptZeVVNSqvdmatlqjkvzylFa7RgI82hCRvGdHv8ZYJ4yuOm4lr436gFWjXDGQMfgLT
        OkRHW6ONVNfodhALsFk12GjMuuq9AjLiGNiFm5RbdQidVNHqiNlFC6xLbjOe8VjD4WXFBWSXGnFQG
        pehOt94sO0EDJNfubvJcZewXLkZqN6QxLMKVusaIJenz5lnsJP+TKIbrSg+RgSQhfff2jc1CuDh0q
        sQsuXHTxjQs3XXNYh1Nuzp53cCIA/dzMCucMaLuDId9D1tx36LpDQnDdLPat08/JSEV/mnabkZ5BS
        YzaQePAw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lEu14-00076J-6O; Wed, 24 Feb 2021 13:15:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2A499305C11;
        Wed, 24 Feb 2021 14:15:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C8E5A207B3A65; Wed, 24 Feb 2021 14:15:42 +0100 (CET)
Message-ID: <20210224122439.176543586@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 24 Feb 2021 13:24:39 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        Andi Kleen <andi@firstfloor.org>
Subject: [PATCH 0/6] sched: Fix affine_move_task() wreckage
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The long and short of it is that commit 6d337eab041d ("sched: Fix
migrate_disable() vs set_cpus_allowed_ptr()") is utterly wrecked and it is a
miracle it doesn't insta explode for anybody (else).

The longer story is that after some initial confusion and tracing I found the
first problem and send (patch #1):

  https://lkml.kernel.org/r/YCfLHxpL+L0BYEyG@hirez.programming.kicks-ass.net

and was hoping that was the end of it (ha!). Obviously the one machine that did
manage to trigger this instantly found the next problem, now addressed in patch
#5.

The even longer story is that Monday last I sat down with a large piece of
(virtual) paper, basically threw the entire affine_move_task() /
migration_cpu_stop() logic out and while doodling re-implemented it all.

The difficult machine was happy on the second try after that.

Ofcourse, at that point I had a single huge rewrite of commit 6d337eab041d, and
I pondered sending it like that. However I figured that for review and
posterity it might be easier/better to do smaller steps. So today I reverse
engineerd a possible logical path between the two states.

I'm hoping nothing got wrecked while doing the cleanups :-)

Patches also in:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/urgent


