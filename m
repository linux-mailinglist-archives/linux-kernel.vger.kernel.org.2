Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D0944CEC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 02:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbhKKBdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 20:33:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:51561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232005AbhKKBdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 20:33:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636594217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=60dtU+HoYlocd4haAeH2HC3xlLjzOu/VsukztW1ALDk=;
        b=E1pSgqhlKo9mm6L6atckuKOKAG5B8ma4o40LhYkMqsybTOuL64E7z9PZ5GHGtKvLbryWda
        H9s17xOVWMgomt91GN954LbqxIaHvGEJ6DnKYvZgAvMHlEURlKc2jCEKtvv6xOhHT7N3n/
        QYF5aM2vihbxYlAs3GeZrac30h5Qq/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-a__PTCqxNAahdH-c-yMb9A-1; Wed, 10 Nov 2021 20:30:14 -0500
X-MC-Unique: a__PTCqxNAahdH-c-yMb9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84FB715724;
        Thu, 11 Nov 2021 01:30:12 +0000 (UTC)
Received: from [10.22.16.136] (unknown [10.22.16.136])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E15D01048126;
        Thu, 11 Nov 2021 01:30:10 +0000 (UTC)
Message-ID: <551c33a1-25d0-a840-f26b-238bee51d4ec@redhat.com>
Date:   Wed, 10 Nov 2021 20:30:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 0/2] clocksource: Avoid incorrect hpet fallback
Content-Language: en-US
To:     Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Cassio Neri <cassio.neri@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20211110221732.272986-1-longman@redhat.com>
 <20211111012301.GA15663@shbuild999.sh.intel.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211111012301.GA15663@shbuild999.sh.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/10/21 20:23, Feng Tang wrote:
> Hi Waiman, Paul,
>
> On Wed, Nov 10, 2021 at 05:17:30PM -0500, Waiman Long wrote:
>> It was found that when an x86 system was being stressed by running
>> various different benchmark suites, the clocksource watchdog might
>> occasionally mark TSC as unstable and fall back to hpet which will
>> have a signficant impact on system performance.
>   
> We've seen similar cases while running 'netperf' and 'lockbus/ioport'
> cases of 'stress-ng' tool.
>
> In those scenarios, the clocksource used by kernel is tsc, while
> hpet is used as watchdog. And when the "screwing" happens, we found
> mostly it's the hpet's 'fault', that when system is under extreme
> pressure, the read of hpet could take a long time, and even 2
> consecutive read of hpet will have a big gap (up to 1ms+) in between.
> So the screw we saw is actually caused by hpet instead of tsc, as
> tsc read is a lightweight cpu operation
>
> I tried the following patch to detect the screw of watchdog itself,
> and avoid wrongly judging the tsc to be unstable. It does help in
> our tests, please help to review.
>
> And one futher idea is to also adding 2 consecutive read of current
> clocksource, and compare its gap with watchdog's, and skip the check
> if the watchdog's is bigger.

That is what I found too. And I also did a 2nd watchdog read to compare 
the consecutive delay versus half the threshold and skip the test if it 
exceeds it. My patch is actually similar in concept to what your patch does.

Cheers,
Longman

