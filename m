Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5415F35AC18
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 11:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbhDJJFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Apr 2021 05:05:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55510 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhDJJFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Apr 2021 05:05:09 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618045494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XpQpnV8inwurre/JMjzsAgUTER9EyXm2D3ZFREPmzIE=;
        b=FiQMKs55s6H/KKxDKfNbDE4g1BvVozjxlLQWoycgVzNzU92MyAHlMb5dyhJWl1WvmNKyi4
        V5ZXl7fXlTGwU3ZUubwT16kGqQqzpxTgiGl4i2ml6ree3n0Et4elOc9p4nQt5nPRLP7AzN
        qQbLIvKNVCcDUaz3tgSujqPUB0IKUb0O21IEJCvp3Wku8c7Hm3VIBlN6kZF7et5UYw/VIG
        c+UxVqyFp0gy0pEijPezqQj7DOSKnsUw+Nw47M0f/DwHvHdgf1jFHw56GwtETDYxoAo2D0
        KNbMajXNjdwCTDtG1d5+NT2z8gUIwlVqD3eCXgfznk6WKQ3z99x1q6tc+aDq5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618045494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XpQpnV8inwurre/JMjzsAgUTER9EyXm2D3ZFREPmzIE=;
        b=18gpPar/4C44Fk/MVpz2MIfoRKolxwHlXgUQ4iO4nuVKyOvQ5FDcQCX80K/N4i0zcNuN/n
        SArRX3pn4OxQTmCQ==
To:     paulmck@kernel.org, linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, sboyd@kernel.org, corbet@lwn.net,
        Mark.Rutland@arm.com, maz@kernel.org, kernel-team@fb.com,
        neeraju@codeaurora.org, ak@linux.intel.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH v7 clocksource 5/5] clocksource: Do pairwise clock-desynchronization checking
In-Reply-To: <20210402224906.3912-5-paulmck@kernel.org>
References: <20210402224828.GA3683@paulmck-ThinkPad-P72> <20210402224906.3912-5-paulmck@kernel.org>
Date:   Sat, 10 Apr 2021 11:04:54 +0200
Message-ID: <878s5q4iix.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 02 2021 at 15:49, paulmck wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
>
> Although smp_call_function() has the advantage of simplicity, using
> it to check for cross-CPU clock desynchronization means that any CPU
> being slow reduces the sensitivity of the checking across all CPUs.
> And it is not uncommon for smp_call_function() latencies to be in the
> hundreds of microseconds.
>
> This commit therefore switches to smp_call_function_single(), so that
> delays from a given CPU affect only those measurements involving that
> particular CPU.

Is there any reason I'm missing why this is not done right in patch 3/5
which introduces this synchronization check?

Thanks,

        tglx


