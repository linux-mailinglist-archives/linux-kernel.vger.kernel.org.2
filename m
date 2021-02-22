Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04A3321A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhBVOR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhBVNp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:45:29 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FE4C061574;
        Mon, 22 Feb 2021 05:44:49 -0800 (PST)
Date:   Mon, 22 Feb 2021 14:44:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614001488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UmkKxSuxf2lxqJkgtl3XnV9gfHTSvgUlAUYzT5ggsJU=;
        b=pZUSSAFvBoyP1dpDeqoxnsGMVgovOH77deerJ5DMvVljZuArS7+xHuzQwdxc0s2Kz6g7zp
        GjC3Ko9YO39MFw9dwMIigR8nBnCKT3oJYrJJZSMPPXXrZTfBggx1hplMS+jnevyl8r42hs
        UUQ8CkLC3DvEl9XfEG3voflSPO+BB6mb2SNDabf4BokAlG5R4f6sUT3WP9aSNR2aWzGoyp
        J2cfP3q6460d/MtOVkYoxQ2v2PyAZkPnNt1PBjR0dG1QTBvf+6C2LtvyIyeTOvB+WuAb1+
        HrntmKGjUwWPbKH5V+WqGJEljvEGux8jf/Y9qi9P8OH8SUR61gsT9xwVKM1gkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614001488;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UmkKxSuxf2lxqJkgtl3XnV9gfHTSvgUlAUYzT5ggsJU=;
        b=MfmbRRR2Crr01BunWSQh2AUWTQ0Rmf3GcahJrs0XW6kzfdAdj/643H8W8Ng1bqq7v/cOyj
        bgRFvhDCu/mexvAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jonathan Schwender <schwenderjonathan@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [RFC v2] sched/rt: Fix RT (group) throttling with nohz_full
Message-ID: <20210222134446.qesg7mg4ypjda3um@linutronix.de>
References: <20210201093412.4900-1-schwenderjonathan@gmail.com>
 <20210202090010.5350-1-schwenderjonathan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210202090010.5350-1-schwenderjonathan@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-02-02 10:00:10 [+0100], Jonathan Schwender wrote:
> If nohz_full is enabled (more precisely HK_FLAG_TIMER is set), then
> do_sched_rt_period_timer may be called on a housekeeping CPU,
> which would not service the isolated CPU for a non-root cgroup
> (requires a kernel with RT_GROUP_SCHEDULING).
> This causes RT tasks in a non-root cgroup to get throttled
> indefinitely (unless throttling is disabled) once the timer has
> been moved to a housekeeping CPU.
> To fix this, housekeeping CPUs now service all online CPUs
> if HK_FLAG_TIMER (nohz_full) is set.

This originates from
   https://lore.kernel.org/linux-rt-users/b07b6fc7-1a5f-0dcc-ca65-821de96cd8b4@gmail.com/

Could someone please take a look?

Sebastian
