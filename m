Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9907636CDAD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 23:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbhD0VKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 17:10:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43742 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbhD0VKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 17:10:34 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619557790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=lZmVNGp/sO52Y8pqU/C06FwXzAgga9JldSyLl4UxiD4=;
        b=IxDBWyLIASiHY5zARu6g2QZBv/1xWQjlIp5Kgk762DAkRFLTrJpn24SQ99aNwzNyrSduWC
        WhtLSnWz7eN18Tcli7IJqhv6kb36yPncKFRPPxUlhsqeQtUFbhOOFaCctZWiDgpU9RezHU
        eHRwoA727e7ok9pzd8qd8qrzDAFb9l0XxF3aV9SI+xLg8ssz7rFOJ4qh6QS2sUIuKnU0Z1
        ZfWecTJDo0fs2NH+aPXQW8Z4Rtn6hMUU1H3VsOAmzmUTJwjt5RmKKzZ7DzchvE6iHBF9Ty
        AA3HS15oIxcUzJc+I22aKOXEQZGzQkx33ClCub6m1eqYHk+XlTw9YJHH9LqbWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619557790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=lZmVNGp/sO52Y8pqU/C06FwXzAgga9JldSyLl4UxiD4=;
        b=35GmVG3ps9sSNRPpxRWcToosqXrH6i+ji7ZNIJuuRqi4U/8WhMVkvQCFcOZBW904CUWq56
        fdIpibTQDuO2JXCQ==
To:     paulmck@kernel.org, Feng Tang <feng.tang@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        0day robot <lkp@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel-team@fb.com, neeraju@codeaurora.org, zhengjun.xing@intel.com
Subject: Re: [clocksource]  8c30ace35d: WARNING:at_kernel/time/clocksource.c:#clocksource_watchdog
In-Reply-To: <20210427175027.GA945820@paulmck-ThinkPad-P17-Gen-1>
Date:   Tue, 27 Apr 2021 23:09:49 +0200
Message-ID: <87y2d3mo2q.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

On Tue, Apr 27 2021 at 10:50, Paul E. McKenney wrote:
> On Tue, Apr 27, 2021 at 06:37:46AM -0700, Paul E. McKenney wrote:
>> I suppose that I give it (say) 120 seconds instead of the current 60,
>> which might be the right thing to do, but it does feel like papering
>> over a very real initramfs problem.  Alternatively, I could provide a
>> boot parameter allowing those with slow systems to adjust as needed.
>
> OK, it turns out that there are systems for which boot times in excess
> of one minute are expected behavior.  They are a bit rare, though.
> So what I will do is keep the 60-second default, add a boot parameter,
> and also add a comment by the warning pointing out the boot parameter.

Oh, no. This starts to become yet another duct tape horror show.

I'm not at all against a more robust and resilent watchdog mechanism,
but having a dozen knobs to tune and heuristics which are doomed to fail
is not a solution at all.

Thanks,

        tglx
