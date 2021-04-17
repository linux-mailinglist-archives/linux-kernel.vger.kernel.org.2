Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922DA363127
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Apr 2021 18:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbhDQQZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Apr 2021 12:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236535AbhDQQZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Apr 2021 12:25:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B44C061574
        for <linux-kernel@vger.kernel.org>; Sat, 17 Apr 2021 09:25:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618676696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D51MGajNTanzxAn0hfY5Mdjl4UL76mIBB+4bnKNLbM0=;
        b=sUls1B0zO+QBdGBnlVta3iN5ouPKJq1Nb4YPBOr1bW3qp6rsopnPKdTjLGEkuaneE7cZFr
        sxQzSiwCDiZHwtfbm3jcxBiKGW7ook8fRnPnjXqneO2dbUF1E0mm9iaY2e3GomwO+DZokb
        bOrMd2OIRMdKE/CqZUpVSy19WkeuQkjD26f/2Qcf0h2PStUrDSs1DXGiaZu1J5YmNNfxOJ
        yaOL4k1paTl/Ldx8VY6ObaxZdrnkETvY6Xvzn4ZwCP6VohQdBXQWwtR5kj6mSl2XKZOXnI
        0bsvbgP2fwO7wYjScqZLKaJ0xcYxYiQMeFCjOfTHu82CdItJVTXKTueBMVoQXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618676696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D51MGajNTanzxAn0hfY5Mdjl4UL76mIBB+4bnKNLbM0=;
        b=DqotEnmEVcqXIIVnpSoTVMAzbHTdBZyjFpVhfAy5hivnbUXxK0ziF337QBDG6398j3l47M
        10HAGIhTzp5iSjDw==
To:     Peter Xu <peterx@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Anna-Maria Behnsen <anna-maria@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Nitesh Narayan Lal <nitesh@redhat.com>,
        Alex Belits <abelits@marvell.com>
Subject: Re: [PATCH v5] hrtimer: avoid retrigger_next_event IPI
In-Reply-To: <20210416171321.GU4440@xz-x1>
References: <20210407135301.GA16985@fuller.cnet> <87o8en4k9a.ffs@nanos.tec.linutronix.de> <20210409165146.GA40118@fuller.cnet> <87lf9q4lue.ffs@nanos.tec.linutronix.de> <20210413170431.GA16190@fuller.cnet> <20210415153935.GA69750@fuller.cnet> <87im4nv0fh.ffs@nanos.tec.linutronix.de> <20210415204017.GA111847@fuller.cnet> <20210416160023.GA6187@fuller.cnet> <20210416171321.GU4440@xz-x1>
Date:   Sat, 17 Apr 2021 18:24:56 +0200
Message-ID: <87pmysswtj.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16 2021 at 13:13, Peter Xu wrote:
> On Fri, Apr 16, 2021 at 01:00:23PM -0300, Marcelo Tosatti wrote:
>>  
>> +#define CLOCK_SET_BASES ((1U << HRTIMER_BASE_REALTIME) |	\
>> +			 (1U << HRTIMER_BASE_REALTIME_SOFT) |	\
>> +			 (1U << HRTIMER_BASE_TAI) |		\
>> +			 (1U << HRTIMER_BASE_TAI_SOFT))
>> +
>> +static bool need_reprogram_timer(struct hrtimer_cpu_base *cpu_base)
>> +{
>> +	if (cpu_base->softirq_activated)
>> +		return true;
>
> A pure question on whether this check is needed...
>
> Here even if softirq_activated==1 (as softirq is going to happen), as long as
> (cpu_base->active_bases & CLOCK_SET_BASES)==0, shouldn't it already mean that
> "yes indeed clock was set, but no need to kick this cpu as no relevant timer"?
> As that question seems to be orthogonal to whether a softirq is going to
> trigger on that cpu.

That's correct and it's not any different from firing the IPI because in
both cases the update happens with the base lock of the CPU in question
held. And if there are no active timers in any of the affected bases,
then there is no need to reevaluate the next expiry because the offset
update does not affect any armed timers. It just makes sure that the
next enqueu of a timer on such a base will see the the correct offset.

I'll just zap it.

Thanks,

        tglx

