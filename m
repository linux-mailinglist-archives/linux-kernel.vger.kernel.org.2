Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242D2371F16
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 20:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbhECSBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 14:01:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48694 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbhECSBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 14:01:48 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620064853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ybWEm0mGIHCtz87WK8S5IqBOn19onecVqJzpzLBEw3A=;
        b=KWutC8Xr0/O9okcisl5YFwXzc3Xz+TBFCGIQUoWGFF8Cku1LVRyE/kY5hjmHZnC3WjYxpP
        GC/JgwYeOMW0lLXgQwJAyWtXnRtcKVBlYFTd5AqB7XLfG/IzUBxjWlCJCS/cBKMY/LUJPM
        Vbi6qKIQL/YqYMa3Cu9MOEvj638ZpH0rXPSbQV5D+z2hIDC09MRk+O+pnqkVuO+jpERk8D
        Sg6AFUTSd/prhIbBw6kUn6DAyITmT2IltzFXunPIbLvWNrEPx+1ugJ5gOLMCCvu8ZraeCw
        7VbwfV7adYAhagPIgw5ADsFHbN9Jb13FKNkMd6+ACzXSB4cliZMKO63/YfNDdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620064853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ybWEm0mGIHCtz87WK8S5IqBOn19onecVqJzpzLBEw3A=;
        b=auEY4YLz8LRn3xSUI0iBxneIrl1Xca0UgfKaIBqJtqeLbbeS7Vq6EqrmRC9nVAInvm8NJo
        V6j5oXwOG5gJfzCg==
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] alarmtimer: check RTC features instead of ops
In-Reply-To: <YJAX60DSp/imRstL@piout.net>
References: <20210429214902.2612338-1-alexandre.belloni@bootlin.com> <877dkkfdif.ffs@nanos.tec.linutronix.de> <YIu7ZqowGScElHBr@piout.net> <871rasf8qe.ffs@nanos.tec.linutronix.de> <YJAX60DSp/imRstL@piout.net>
Date:   Mon, 03 May 2021 20:00:53 +0200
Message-ID: <87wnsfd7e2.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03 2021 at 17:34, Alexandre Belloni wrote:
> On 30/04/2021 10:59:53+0200, Thomas Gleixner wrote:
>> I'm even more confused. So RTC0 does not have .set_alarm() but why does
>> it turn on RTC_FEATURE_ALARM? I'm obviously misinterpreting the above...
>> 
>
> I'm sorry for not being clear.
>
> With RTC0 not having alarms and RTC1 having alarms:
>
> The previous situation was:
>
> The driver for RTC0 didn't have any .set_alarm() to signel it doesn't
> support alarms.
> On registration, alarmtimer_rtc_add_device finds out it doesn't have the
> .set_alarm() callback and doesn't select that RTC.
> On registration of RTC1, alarmtimer_rtc_add_device finds .set_alarm()
> and RTC1 is now the alarmtimer rtcdev.
>
> The new situation is:
>
> The driver for RTC0 always have .set_alarm() but clears
> RTC_FEATURE_ALARM to signal it doesn't support alarms.
> On registration, alarmtimer_rtc_add_device finds .set_alarm() and RTC0
> is now the alarmtimer rtcdev, leading to an error when rtc_timer_start()
> is called.
>
> I hope this is clearer.

Yes, that makes sense now!
