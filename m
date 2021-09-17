Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B1540F78C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244026AbhIQMem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:34:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54306 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbhIQMel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:34:41 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631881998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kHJeIvr+P7Ms3bNYhLTCIEhPaeM9p16SWGlpPl7C21k=;
        b=dFgr3luHUrjdK6hswnFOQWM/RjR+eY9MC3KPaV3gIYNShR6gHbpUA/QpA0/sNzCf1upM9G
        UtbjRu0VEFfQAkSUqu5j/gB5ixN2YVby4jMwy/rVC17tOm7KS7CWOE0oC/ZtTu5aNjybcH
        X+6TXZ3LpnX9inVXUiqemAqGdHnaRgWQysHkFf60qPgut89Rr+5QeZr+V/NXivwlb5LAS2
        oCWrDBE/Z0SVQ9QMt6ouz6OHnyrZHiKnXxrodXLUySyAWXeukC12UN5P/AyGCIlW9w58MU
        IQWxSxHKGpzl4AXMzpkhcqwx4HT/KaFj7g3lXPMj7C6mNe6xYQbfjYAG5vbhWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631881998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kHJeIvr+P7Ms3bNYhLTCIEhPaeM9p16SWGlpPl7C21k=;
        b=4y9nWeyrxMP2guYW80GB70UaILdH3/48BHqDfzZQaLXCVCVcSE12YejYwa5EjfV+7Lmca1
        Nk7Kcj8mnMsN0cAw==
To:     Peter Zijlstra <peterz@infradead.org>, Ondrej Zary <linux@zary.sk>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/iopl: Fake iopl(3) CLI/STI usage
In-Reply-To: <YUSCDX5QwzTcCPFa@hirez.programming.kicks-ass.net>
References: <202109151423.43604.linux@zary.sk>
 <202109171011.31916.linux@zary.sk>
 <YURdxNpH8YNQZQT7@hirez.programming.kicks-ass.net>
 <202109171229.19289.linux@zary.sk>
 <YUSCDX5QwzTcCPFa@hirez.programming.kicks-ass.net>
Date:   Fri, 17 Sep 2021 14:33:18 +0200
Message-ID: <87mtob8jqp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17 2021 at 13:54, Peter Zijlstra wrote:
>> [   14.876824] fixup_iopl_exception: 333 callbacks suppressed
>> [   14.876832] traps: hpasmd[360] attempts to use CLI/STI, pretending it's a NOP, ip:80a5356
>
> I'd say...
>
> Not sure it's really worth it, but something like the below might
> help.

One entry per task is really good enough. Though that wont help for such
stuff which is started over and over again....

Thanks,

        tglx
