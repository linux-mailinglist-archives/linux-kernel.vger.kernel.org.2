Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1D6D33D3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 13:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhCPM2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 08:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhCPM2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 08:28:19 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDD4C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hwHlWbWTEczqDkBikUULbYZy11mMgXktJCLbUnZWv88=; b=QQ2CNxaCMQej97kooYigwHt5/u
        FTm4LYOJrMWENwmvyYrcvxVn6FOpE5NrUvITEFqllBWkgEdfx9VJHQnyrkhlyAqIGf/k3cobmG9NO
        Zoq//bujk0NHqBWeficotFHNyJuoIAbNvVYdJz3T3v8w2fOUuwKznxsbNiXxAeQg1M8BKQQRHu/aV
        DPfgzG76yCGYi5sn/wRgswq9UhqAyY658nYWA22XQChe1fOnhq6vDBlvSlRdrISIw7e9bF0pPmJz4
        m8qaJ+SlVyEG0NFqUaph3CWUMLeJn1WJHOKoSIcqY6BCufqryIxcA/yWlbCR7+L6Sb7uJ94Dq1OS5
        DiwPHFGA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lM8nq-000hpa-C8; Tue, 16 Mar 2021 12:28:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 818843012DF;
        Tue, 16 Mar 2021 13:28:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 31E1C20B05D7A; Tue, 16 Mar 2021 13:28:01 +0100 (CET)
Date:   Tue, 16 Mar 2021 13:28:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Ti Zhou <x2019cwm@stfx.ca>, Yunfeng Ye <yeyunfeng@huawei.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 02/10] tick/nohz: Add tick_nohz_full_this_cpu()
Message-ID: <YFCkUUCYchYpB/0W@hirez.programming.kicks-ass.net>
References: <20210311123708.23501-1-frederic@kernel.org>
 <20210311123708.23501-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311123708.23501-3-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2021 at 01:37:00PM +0100, Frederic Weisbecker wrote:
> Optimize further the check for local full dynticks CPU. Testing directly
> tick_nohz_full_cpu(smp_processor_id()) is suboptimal because the
> compiler first fetches the CPU number and only then processes the
> static key.
> 
> It's best to evaluate the static branch before anything.

Or you do tricky things like this ;-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 7340613c7eff..bd4a6b055b80 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -185,13 +185,12 @@ static inline bool tick_nohz_full_enabled(void)
 	return tick_nohz_full_running;
 }
 
-static inline bool tick_nohz_full_cpu(int cpu)
-{
-	if (!tick_nohz_full_enabled())
-		return false;
-
-	return cpumask_test_cpu(cpu, tick_nohz_full_mask);
-}
+#define tick_nohz_full_cpu(_cpu) ({					\
+	bool __ret = false;						\
+	if (tick_nohz_full_enabled())					\
+		__ret = cpumask_test_cpu((_cpu), tick_nohz_full_mask);	\
+	__ret;								\
+})
 
 static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask)
 {


