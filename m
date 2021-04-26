Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B4C36B5C7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 17:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234052AbhDZP3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 11:29:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34852 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhDZP3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 11:29:20 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619450918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gugWQa6xRv8Em7uLjQXQhkSCbIDH+ekIYoeqePadw8s=;
        b=VyDVOWSdRtQ7Aq661DZ1DFIG7xLuI0Qtko0zlA1tvTdn5dgA6MDU5OSOXA6WzD3zdM5jdz
        SSBIJcAJx7G1z4bqv28ySyTAHz0w74lY5tRD5goRFpMRW9qE0H01OKHg4MGUN2EAk3hIsv
        QHslT40J6SeAp0wB6UCxgM2qPhBufToMCvUc3DEZ9vKCwYJ2fPGSqRCCqK+xXEWjANdQ5q
        F0usAjgUhX7UMNV5G7T1dqRymq+v6kziF7jDTPOLw+NBXaXHvIbFYzT6cCZDuHTaIQh3v2
        m2cxY44qWMR7G+vv/cAObc/L1mmFBi9izqO4ZnULgoQFqofgMFGdp6ch2EA5FA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619450918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gugWQa6xRv8Em7uLjQXQhkSCbIDH+ekIYoeqePadw8s=;
        b=dCdD9MmU3F5zlLIIk3OWlsVE0CnjBSjm8vKhQ3xm1oImP7EsA5+i2BsEGirf0itNB0qGs8
        oLMF0JShu1TqfjDA==
To:     Feng Tang <feng.tang@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        ak@linux.intel.com, zhengjun.xing@intel.com,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Subject: Re: [PATCH v10 clocksource 6/7] clocksource: Forgive tsc_early pre-calibration drift
In-Reply-To: <20210426150127.GB23119@shbuild999.sh.intel.com>
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1> <20210425224709.1312655-6-paulmck@kernel.org> <20210426150127.GB23119@shbuild999.sh.intel.com>
Date:   Mon, 26 Apr 2021 17:28:37 +0200
Message-ID: <87a6plt68q.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26 2021 at 23:01, Feng Tang wrote:
> On Sun, Apr 25, 2021 at 03:47:07PM -0700, Paul E. McKenney wrote:
> We've reported one case that tsc can be wrongly judged as 'unstable'
> by 'refined-jiffies' watchdog [1], while reducing the threshold could
> make it easier to be triggered.
>
> It could be reproduced on the a plaform with a 115200 serial console,
> and hpet been disabled (several x86 platforms has this), add 
> 'initcall_debug' cmdline parameter to get more debug message, we can
> see:
>
> [    1.134197] clocksource: timekeeping watchdog on CPU1: Marking clocksource 'tsc-early' as unstable because the skew is too large:
> [    1.134214] clocksource:                       'refined-jiffies' wd_nesc: 500000000 wd_now: ffff8b35 wd_last: ffff8b03 mask: ffffffff
> [    1.134217] clocksource:                       'tsc-early' cs_nsec: 507537855 cs_now: 4e63c9d09 cs_last: 4bebd81f5 mask: ffffffffffffffff
> [    1.134220] clocksource:                       No current clocksource.
> [    1.134222] tsc: Marking TSC unstable due to clocksource watchdog

Yes, refined jiffies is the worst case.

Though the worst of everything is that any of this exists at all, but
you knew that already :)

Thanks,

        tglx
