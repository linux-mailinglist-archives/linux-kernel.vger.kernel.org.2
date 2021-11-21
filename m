Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DFD4583E3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Nov 2021 14:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbhKUNzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Nov 2021 08:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238196AbhKUNzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Nov 2021 08:55:06 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC960C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Nov 2021 05:52:01 -0800 (PST)
Received: from ip4d173d4a.dynamic.kabel-deutschland.de ([77.23.61.74] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1monGC-0005ft-7s; Sun, 21 Nov 2021 14:52:00 +0100
Message-ID: <6cc591c5-ed71-3213-3119-c778b3b2823d@leemhuis.info>
Date:   Sun, 21 Nov 2021 14:51:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: mm: LTP/memcg testcase regression induced by
 8cd7c588decf..66ce520bb7c2 series
Content-Language: en-BS
To:     Mike Galbraith <efault@gmx.de>,
        lkml <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Cc:     Mel Gorman <mgorman@techsingularity.net>
References: <99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <99e779783d6c7fce96448a3402061b9dc1b3b602.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1637502721;e91716e0;
X-HE-SMSGID: 1monGC-0005ft-7s
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, this is your Linux kernel regression tracker speaking.

CCing regression mailing list, which should be in the loop for all
regressions, as explained here:
https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html

On 21.11.21 11:57, Mike Galbraith wrote:
> Greetings,
> 
> FYI, something in this series causes LTP controllers::memcg_regression
> testcase to hang forever.  Verified via brute force revert of the lot.
> 
> After letting box moan for 4.5 hours, I poked ^C repeatedly, but runltp
> didn't exit/recover gracefully, and ps hung, so I nuked the box.  All
> memcg_test_1 instances were stuck in reclaim_throttle().
> [...]

TWIMC: To be sure this issue doesn't fall through the cracks unnoticed,
I'm adding it to regzbot, my Linux kernel regression tracking bot:

#regzbot ^introduced 8cd7c588decf..66ce520bb7c2
#regzbot ignore-activity

Ciao, Thorsten, your Linux kernel regression tracker.

P.S.: If you want to know more about regzbot, check out its
web-interface, the getting start guide, and/or the references documentation:

https://linux-regtracking.leemhuis.info/regzbot/
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md

The last two documents will explain how you can interact with regzbot
yourself if your want to.

Hint for the reporter: when reporting a regression it's in your interest
to tell #regzbot about it in the report, as that will ensure the
regression gets on the radar of regzbot and the regression tracker.
That's in your interest, as they will make sure the report won't fall
through the cracks unnoticed.

Hint for developers: you normally don't need to care about regzbot, just
fix the issue as you normally would. Just remember to include a 'Link:'
tag to the report in the commit message, as explained in
Documentation/process/submitting-patches.rst
That aspect was recently was made more explicit in commit 1f57bd42b77c:
https://git.kernel.org/linus/1f57bd42b77c


P.P.S.: As a Linux kernel regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them.
Unfortunately therefore I sometimes will get things wrong or miss
something important. I hope that's not the case here; if you think it
is, don't hesitate to tell me about it in a public reply. That's in
everyone's interest, as what I wrote above might be misleading to
everyone reading this; any suggestion I gave they thus might sent
someone reading this down the wrong rabbit hole, which none of us wants.

BTW, I have no personal interest in this issue, which is tracked using
regzbot, my Linux kernel regression tracking bot
(https://linux-regtracking.leemhuis.info/regzbot/). I'm only posting
this mail to get things rolling again and hence don't need to be CC on
all further activity wrt to this regression.
