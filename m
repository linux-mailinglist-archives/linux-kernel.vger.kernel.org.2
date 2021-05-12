Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C517F37EB67
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379256AbhELTaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245598AbhELQxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:53:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA63C061377
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 09:40:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620837649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=em+U9a6FM8ymDiy6LBPRJEL1v1bzD6GxyUDyFHHo2is=;
        b=swgT0EjH+Oa5vkcu0y/RSrMfzTJbZ35lupVMk1T1qMXTl6M3n9mrwjXpMvH2tRXtuXk8Eh
        VIpKvW4CzLeL+37Yt0UUdMGWOwTtJhHUqkPnMkaLKgTguqcmsBFL7zbYpApFJmFOsZ6sYY
        IJsf0rrP29x791poPTx8xaEPorK5XG61BuII1SHR2rF83luw/YBzq+rVnnn3QHJVR0wAdJ
        1wVw7zDGeA+UnXPeeNxo2TLwFV3INX97liUBo4AC5XMfkPBegFQsXurFEpvzrgISW7Pd1z
        OFZfK3Tr38Fm4yoNzs7mXbeU/TJDneo/Ojp9lESuYQ0c6GRy55uSbD7TzyAowA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620837649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=em+U9a6FM8ymDiy6LBPRJEL1v1bzD6GxyUDyFHHo2is=;
        b=CpshR5MbSNLvu7wfU7qXyDS8dUljWn6BD/XpGF7MV0rdoOlx/VQ0cAH8pbjN05PJwVd2FK
        dR3XN+QKq3c5WNAg==
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [patch 2/8] hrtimer: Force clock_was_set() handling for the HIGHRES=n, NOHZ=y case
In-Reply-To: <YJvtVD/SotLoZU/U@hirez.programming.kicks-ass.net>
References: <20210427082537.611978720@linutronix.de> <20210427083724.180273544@linutronix.de> <YJvtVD/SotLoZU/U@hirez.programming.kicks-ass.net>
Date:   Wed, 12 May 2021 18:40:49 +0200
Message-ID: <87r1ibewha.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12 2021 at 16:59, Peter Zijlstra wrote:
> On Tue, Apr 27, 2021 at 10:25:39AM +0200, Thomas Gleixner wrote:
>>  void clock_was_set(void)
>>  {
>> +	if (!hrtimer_hres_active() && !tick_nohz_active)
>> +		goto out_timerfd;
>> +
>>  	/* Retrigger the CPU local events everywhere */
>>  	on_each_cpu(retrigger_next_event, NULL, 1);
>> +
>> +out_timerfd:
>>  	timerfd_clock_was_set();
>>  }
>
> Isn't that simpler when written like:
>
> 	if (hrtimer_hres_active() || tick_nohz_active())
> 		on_each_cpu(retrigger_next_event, NULL, 1);
>
> 	timerfd_clock_was_set();
>
> ?

Yes, but look at the later patches. Then we'll introduce it there. :)

