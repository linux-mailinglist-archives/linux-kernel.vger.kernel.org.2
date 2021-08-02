Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416FA3DD604
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 14:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhHBMwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 08:52:32 -0400
Received: from [103.31.38.59] ([103.31.38.59]:52506 "EHLO gnuweeb.org"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S232842AbhHBMwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 08:52:31 -0400
Received: from [10.7.7.2] (unknown [68.183.184.174])
        by gnuweeb.org (Postfix) with ESMTPSA id 9E92DBFC2A;
        Mon,  2 Aug 2021 12:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gnuweeb.org;
        s=default; t=1627908739;
        bh=9dMWCcCbqPK70BkGb3v5u2ZlddkJlkQvmwNyGfwCNY0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=EJiO+Ad5SHbv92sKxpB6MEf6KmMtSi5ulBYilpe/UjBcwQowgkJjTLssE+edrTD8A
         zgjYCN+AyGk3pUKRxG1XPSLlbVOmi+5PRw0dwXAVP9I7KIFz8ATbi9yTUEcxWmoP8b
         aVZfd98RRdgTje5itQUFljPztwGJ9EC/HdymeESJ9Qze+XUPb90sSZMfQj+qhD01mx
         Z5unXSLvJk27yost5r6MLzQ0kbP20RgF4BlvtaCVTEwV6e/IsjcaIaqkV+JFlS5YRh
         ReECLQn1YN6oXhG8Hz10lkPh5u40huVM15hMzKoi+3Ed0q9GUpxvGZIGe87RNnICmu
         crlAZT7WFh+0Q==
Subject: Re: WARNING: CPU: 0 PID: 12 at kernel/sched/fair.c:3306
 update_blocked_averages+0x941/0x9a0
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ammar Faizi <ammarfaizi2@gmail.com>
References: <b18744a7-d300-59a8-a6d7-55ba88471252@gnuweeb.org>
 <7473b5ba-72bf-7836-44a6-42851081a277@arm.com>
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
Message-ID: <9d1680de-39e5-609c-7410-7baabfb079e5@gnuweeb.org>
Date:   Mon, 2 Aug 2021 19:52:13 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <7473b5ba-72bf-7836-44a6-42851081a277@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/21 3:42 PM, Dietmar Eggemann wrote:
> So you're running with:
>
> 9e077b52d86a - sched/pelt: Check that *_avg are null when *_sum are
> (2021-06-17 Vincent Guittot)
>
> but not with:
>
> ceb6ba45dc80 - sched/fair: Sync load_sum with load_avg after dequeue
> (2021-07-02 Vincent Guittot)
>
> The SCHED_WARN_ON you're hitting is harmless and just tells you that the
> PELT load_avg and load_sum part of one of your cfs_rq's is not aligned.
> Has to be load (and not util or runnable) since load is the only one
> still not fixed in f55966571d5e.
>
> This should go away once you applied ceb6ba45dc80.

Alright, I have just moved to 5.14-rc4 and doesn't seem to have this
issue anymore.

Thanks for the response, Dietmar.

  Ammar

