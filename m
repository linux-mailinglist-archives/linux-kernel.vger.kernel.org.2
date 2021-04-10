Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF3635ABC3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 10:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbhDJICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 04:02:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55208 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhDJICN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 04:02:13 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618041718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hbntxd/PYUB6gqhRZOYZxuUYiPagve3eao3tRNeKPxQ=;
        b=gXe9hV0bmQnshXaTex+3PCpGd+P9URYB2Q3W6i/Qk4jzoRyqGmUOK2iaJ6zfv+ue2BIZdw
        Qn5B5FssFL6tINBWJiz+2/Lhfl64U640E5y6BCotJRKE26kNrbVuW5I1HRBD+OYQArbZ6e
        tShZcElxmj9BF/SPnconMEZHvQqlycbLevmzGUItu1sO1NxyUieL5QR0wDbzxdIe8gifWr
        6CSy4o5OsbRhVaVpCq6vaaIC1kky32wp+BqIuAavAwg1rXoH6ZOpZcEs7VrxbNpT9ad+6J
        pkN4bwSMJR6R4/i0/oXpsflgI5xmli1g1S3lHPc9hNaCVBEWR2TSQQTvA+JojQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618041718;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hbntxd/PYUB6gqhRZOYZxuUYiPagve3eao3tRNeKPxQ=;
        b=Uc+tIAUh/NNiNxVc9v1XIeqbUANbK6fqhgPxWqO4e2FO3LrYJjTDQtixc9PnkTBKxndBM7
        QO4G0zSWpPM+fZAw==
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com
Subject: Re: [PATCH v7 clocksource] Do not mark clocks unstable due to delays for v5.13
In-Reply-To: <20210402224828.GA3683@paulmck-ThinkPad-P72>
References: <20210402202929.GA22273@paulmck-ThinkPad-P72> <20210402203137.22479-1-paulmck@kernel.org> <87pmzc498v.ffs@nanos.tec.linutronix.de> <20210402224828.GA3683@paulmck-ThinkPad-P72>
Date:   Sat, 10 Apr 2021 10:01:58 +0200
Message-ID: <87im4u4lft.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02 2021 at 15:48, Paul E. McKenney wrote:
> Hello!
>
> If there is a sufficient delay between reading the watchdog clock and the
> clock under test, the clock under test will be marked unstable through no
> fault of its own.  This series checks for this, doing limited retries
> to get a good set of clock reads.  If the clock is marked unstable
> and is marked as being per-CPU, cross-CPU synchronization is checked.
> This series also provides delay injection, which may be enabled via
> kernel boot parameters to test the checking for delays.
>
> Note that "sufficient delay" can be provided by SMIs, NMIs, and of course
> vCPU preemption.

I buy the vCPU preemption part and TBH guests should not have that
watchdog thing active at all for exactly this reason.

SMI, NMI injecting 62.5ms delay? If that happens then the performance of
the clocksource is the least of your worries.

Thanks,

        tglx
