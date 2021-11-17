Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A58454D72
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 19:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240245AbhKQSzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 13:55:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240235AbhKQSy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 13:54:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637175119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13nKyu9G/DhMBQpI/9h2fo3VMA3cZcEqmTrdMC+6PKA=;
        b=FBRCjX2tbGZFL/cc6+BUIvCjEmPNiEUHwM0eOFQ7FaihNdIrefHwZ401j5YMSU9PYTXAEJ
        EB/dQNTp/Tfb0tgg5kAufTBsiKH/3OMwvzWODBXYFkGaTldvyh7EIWqzbISto1odD6jOIv
        c6aZdryqlxKb69nYJ6B0il8ASxUi2vg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-289-P4kNV0CiM4-zyI5N1sggFQ-1; Wed, 17 Nov 2021 13:51:54 -0500
X-MC-Unique: P4kNV0CiM4-zyI5N1sggFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B6D1A40C3;
        Wed, 17 Nov 2021 18:51:53 +0000 (UTC)
Received: from [10.22.33.89] (unknown [10.22.33.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2813A1007625;
        Wed, 17 Nov 2021 18:51:52 +0000 (UTC)
Message-ID: <7cb5ab62-21ea-f649-2009-38b8c1ff283a@redhat.com>
Date:   Wed, 17 Nov 2021 13:51:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 0/4] clocksource: Avoid incorrect hpet fallback
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Feng Tang <feng.tang@intel.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20211116234426.837799-1-longman@redhat.com>
 <20211117165426.GG641268@paulmck-ThinkPad-P17-Gen-1>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211117165426.GG641268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17/21 11:54, Paul E. McKenney wrote:
> On Tue, Nov 16, 2021 at 06:44:22PM -0500, Waiman Long wrote:
> A few questions:
>
> 1.	Once you have all the patches in place, is the increase in
> 	WATCHDOG_MAX_SKEW from 50us to 100us necessary?

I think so. Using Feng's reproducer, I was able to cause a hpet-hpet 
delay of more than 90us on a 1-socket system. With a default 50us 
WATCHDOG_MAX_SKEW, the chance of a warning showing up will be much 
higher. Trying to minimize the chance that a warning may appear is my 
primary reason to increase WATCHDOG_MAX_SKEW.

>
> 2.	The reason for having cs->uncertainty_margin set to
> 	2*WATCHDOG_MAX_SKEW was to allow for worst-case skew from both
> 	the previous and the current reading.  Are you sure that
> 	dropping back to WATCHDOG_MAX_SKEW avoids false positives?
I can remove the hunk of changing cs->uncertainty_margin. It is critical 
for this patch.
>
> 3.	In patch 3/4, shouldn't clock_skew_skip be a field in the
> 	clocksource structure rather than a global?  If a system had
> 	multiple clocks being checked, wouldn't having this as a field
> 	make things more predictable?  Or am I missing something subtle
> 	here?

Yes, you are right. I should have put it into clocksource structure. I 
will make the change in v3.


>
> 4.	These are intended to replace this commit in -rcu, correct?
>
> 	9d5739316f36 ("clocksource: Forgive repeated long-latency watchdog clocksource reads")
>
> 	But not this commit, correct?
>
> 	5444fb39fd49 ("torture: Test splatting for delay-ridden clocksources")
Yes, that is my intention.
> And would you like me to queue these, or would you rather send them
> separately?  (Either way works for me, just please let me know.)

I don't have a preference either way. If you are willing to queue these, 
it will be great too.

Cheers,
Longman

