Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06AE455002
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 22:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241113AbhKQWAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 17:00:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25495 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241276AbhKQV6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 16:58:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637186152;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6VIrXJQXepYyEy6GUgX2mEjRrDCUS7p7t5J+28qOmg=;
        b=cAGfytzxugxZPZmaJ1fL05DDlr9VmiA2K0YNk6e12UrdL5+BXuoSohPDjvLgYO9ao6vSLZ
        BNSWy6eORbB2GRjfcGvfzObg7vLOr3aTPAHcEZX5ydjsI9AQeTBO35EuKDJXSDTralp+DO
        9Ja2gGm6HVElHd4Tvaj5DL+uJA8BfSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-kj9fOSGANyiZmjwZBtjywQ-1; Wed, 17 Nov 2021 16:55:48 -0500
X-MC-Unique: kj9fOSGANyiZmjwZBtjywQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AF5EA57051;
        Wed, 17 Nov 2021 21:55:46 +0000 (UTC)
Received: from [10.22.33.89] (unknown [10.22.33.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A04E15C22B;
        Wed, 17 Nov 2021 21:55:45 +0000 (UTC)
Message-ID: <ede5405d-55f4-e1ea-23ef-56303cbfa411@redhat.com>
Date:   Wed, 17 Nov 2021 16:55:45 -0500
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
 <7cb5ab62-21ea-f649-2009-38b8c1ff283a@redhat.com>
 <20211117212547.GO641268@paulmck-ThinkPad-P17-Gen-1>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211117212547.GO641268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/17/21 16:25, Paul E. McKenney wrote:
> On Wed, Nov 17, 2021 at 01:51:51PM -0500, Waiman Long wrote:
>> On 11/17/21 11:54, Paul E. McKenney wrote:
>>> On Tue, Nov 16, 2021 at 06:44:22PM -0500, Waiman Long wrote:
>>> A few questions:
>>>
>>> 1.	Once you have all the patches in place, is the increase in
>>> 	WATCHDOG_MAX_SKEW from 50us to 100us necessary?
>> I think so. Using Feng's reproducer, I was able to cause a hpet-hpet delay
>> of more than 90us on a 1-socket system. With a default 50us
>> WATCHDOG_MAX_SKEW, the chance of a warning showing up will be much higher.
>> Trying to minimize the chance that a warning may appear is my primary reason
>> to increase WATCHDOG_MAX_SKEW.
> Should we downgrade the "had to retry read" complain to pr_info(),
> and make the only real warning be the case where a large number of
> consecutive read attempts fail?  I believe that Heiner Kallweit was
> looking for something like this.
Sure. I will downgrade it to pr_info().
>
>>> 2.	The reason for having cs->uncertainty_margin set to
>>> 	2*WATCHDOG_MAX_SKEW was to allow for worst-case skew from both
>>> 	the previous and the current reading.  Are you sure that
>>> 	dropping back to WATCHDOG_MAX_SKEW avoids false positives?
>> I can remove the hunk of changing cs->uncertainty_margin. It is critical for
>> this patch.
> Assuming "not critical", good!

Yes, it is "not critical". Somehow I missed the "not" :-)

Cheers,
Longman

