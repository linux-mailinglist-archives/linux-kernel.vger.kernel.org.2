Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5D7836ACBA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 09:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbhDZHOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 03:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231616AbhDZHOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 03:14:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC48C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 00:14:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619421236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RaeUs5ig8oPGFA8a5hIT5TIvfrrFjhQ7teck4xtX8Qw=;
        b=PAQJAWrmNnCJFeyQoyRAf1iRckUeWSnfRPOMUwq3jdi0DRw3FiVYyp1J+OgYA5lBjueL5O
        Ss2I9f8waxo8kC52mPdacLBib7iVIcLXefvU4zIuBtMpYfQYPL/uI9dum1vdn2OmuAEPhq
        KjPX4zN6uqBHDfFUe1a0wraY/IEXsJDTms+jMOj5Ih1cU4KwKpmfEa3t9zKk5ZE3Fvvn9i
        602AfWxkrkdXOZAm8+B6+kypF8cLZc9inS77PagccqQrEuyWi3rMjSNfezgJN9rEhMM5Uf
        ki+6jVOBNk0xD7O9s57NHE8o4NnkpV2p2cj+Hvt2ZiqiPwKno2wZbG9j9Ka/Jg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619421236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RaeUs5ig8oPGFA8a5hIT5TIvfrrFjhQ7teck4xtX8Qw=;
        b=WPdHavk1yviViMt0Zq3BEKwkrm0wo6qXWRl+8xsfjDf2f90aI0USk95BIV+qNoN7ck+bUB
        4sTfNsPUGW2YrxAg==
To:     Andi Kleen <ak@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        feng.tang@intel.com, zhengjun.xing@intel.com,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH v10 clocksource 1/7] clocksource: Provide module parameters to inject delays in watchdog
In-Reply-To: <20210426040736.GS1401198@tassilo.jf.intel.com>
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1> <20210425224709.1312655-1-paulmck@kernel.org> <20210426040736.GS1401198@tassilo.jf.intel.com>
Date:   Mon, 26 Apr 2021 09:13:56 +0200
Message-ID: <874kftv7pn.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25 2021 at 21:07, Andi Kleen wrote:
>> occur between the reads of the two clocks.  Yes, interrupts are disabled
>> across those two reads, but there are no shortage of things that can
>> delay interrupts-disabled regions of code ranging from SMI handlers to
>> vCPU preemption.  It would be good to have some indication as to why
>
> I assume vCPU preemption here refers to preempt RT? I didn't think
> a standard kernel could preempt when interrupt are disabled.

Neither does Preempt-RT. It's about vCPU's being preempted by the
hypervisor which can happen anytime independent of the state of the
guest.

Thanks,

        tglx
