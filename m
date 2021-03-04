Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7F932D518
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 15:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241519AbhCDOQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 09:16:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49946 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236834AbhCDOPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 09:15:55 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614867313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NGk7ynXX606N/EQMXCjaGhcEcCV5EwcvMIk3MDZxjBI=;
        b=cehfyJlPzQP5pIAvWt3dF/k4NyxTRgyKKdDvmgGdF/pgp4lvBsAWiU0+nDnAmob4+v23Bw
        7W1J4gfRcfrh8Lr7kPNiG2oEibRJQ0lyn8w6d7b3nCJqSnbo10VeJWFAe/465Y1qdWezXR
        FyaSZW8imfl7vKEnQn8HSuCYY5IC9jflgY1pstEcRzg7iVUBxVfavAnbwghMzcY594r7m+
        UUd8JJ1CvH6p8jmlt/7t0uF+JjXueFUUXQHgGqWAastpwAHYLVkzsgHuGWQKdUXfL8ARDt
        JRPSxFUnAtZf90fMUawiGlxZumouDYy0ocFvYSeonQnwXOoXJVe44AMouIyNjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614867313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NGk7ynXX606N/EQMXCjaGhcEcCV5EwcvMIk3MDZxjBI=;
        b=Y8y4ZL0/TzNJx9NqeNZHxK0ddEGM9FIelqR3spU3eFXDjoODztxjHLWVe+Ov+fPiUKDTHS
        CTDrTRVKTzOsiwAA==
To:     Feng Tang <feng.tang@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        Qais Yousef <qais.yousef@arm.com>, andi.kleen@intel.com
Subject: Re: [PATCH] clocksource: don't run watchdog forever
In-Reply-To: <20210304074316.GA43191@shbuild999.sh.intel.com>
References: <1614653665-20905-1-git-send-email-feng.tang@intel.com> <YD4CdQqX5Lea1rB5@hirez.programming.kicks-ass.net> <20210302120634.GB76460@shbuild999.sh.intel.com> <875z286xtk.fsf@nanos.tec.linutronix.de> <20210304074316.GA43191@shbuild999.sh.intel.com>
Date:   Thu, 04 Mar 2021 15:15:13 +0100
Message-ID: <87wnun57ke.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feng,

On Thu, Mar 04 2021 at 15:43, Feng Tang wrote:
> On Wed, Mar 03, 2021 at 04:50:31PM +0100, Thomas Gleixner wrote:
>> Anything pre TSC_ADJUST wants the watchdog on. With TSC ADJUST available
>> we can probably avoid it.
>> 
>> There is a caveat though. If the machine never goes idle then TSC adjust
>> is not able to detect a potential wreckage. OTOH, most of the broken
>> BIOSes tweak TSC only by a few cycles and that is usually detectable
>> during boot. So we might be clever about it and schedule a check every
>> hour when during the first 10 minutes a modification of TSC adjust is
>> seen on any CPU.
>
> I don't have much experience with tsc_adjust, and try to understand it:
> The 'modification of TSC' here has 2 cases: ? 
> * First read of 'TSC_ADJUST' MSR of a just boot CPU returns non-zero
> value

That's catching stupid BIOSes which set the TSC to random values during
boot/reboot. That's a one off boot issue and not a real problem. The
kernel fixes it up and is done with it. Nothing to care about.

> * Following read of 'TSC_ADJUST' doesn't equal to the 'tsc_adjust' value
>   saved in per-cpu data.

That's where we catch broken BIOS/SMI implementations which try to
"hide" the time wasted in BIOS/SMI by setting the TSC back to the value
they saved on SMI entry. That was a popular BIOS "feature" some years
ago, but it seems the BIOS tinkerers finally gave up on it.

>> Where is this TSC_DISABLE_WRITE bit again?

I'm serious about this. Once the kernel has taken over a CPU there is
absolutely no reason for any context to write to the TSC/TSC_ADJUST
register ever again. So having a mechanism to prevent writes would
surely help to make the TSC more trustworthy.

> Also, does the patch ("x86/tsc: mark tsc reliable for qualified platforms")
> need to wait till this caveat case is solved?

Yes, but that should be trivial to do. 

Thanks,

        tglx
