Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 523873776D8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 May 2021 15:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhEIN4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 09:56:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59748 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhEIN4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 09:56:55 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620568551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tbIKhz7cqq8kDkJ2MrpIE0ligoxtEOO42wHzqgYTaLI=;
        b=KlRFJW73GufhLkvR5a3cWFjrQewdHYUkYVglhGkMitJIJsTQa/n48yxg3kOgvb/+01cnIa
        qky63ujrbf1Bub7Ie2nqk9n77E6ahAlrXl9OYWp4MT6i8UvZ59IeZ2uUZKJ1gC+gwz+p7l
        ejMoV3sail6TwHlXPv6hS4dtIZH4AXG4hXAd3wbH+vYgTz2QgRls16X9R8p5zfnaelwNUu
        UxZuhFbc3CVVAvFqJZcGa6CijKBIGwLudVZDcZ4jyDkcrHaqWbl8jDtujD778EBiFd1xNO
        slQmZvXQi/m6Je2ewNbCTcV9kET3aAhtgeMYvdDY48/YvdwnGDziU31EREncAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620568551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tbIKhz7cqq8kDkJ2MrpIE0ligoxtEOO42wHzqgYTaLI=;
        b=ACtbLBYDR03czoV0e4xtVfJvvsQrpMmCdgpwf7udzl33MrPp1JYgGY0E4NUYWcJKRlGkTC
        iK9s0xUFfOjRN/Dw==
To:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [patch 1/2] x86/cpu: Init exception handling from cpu_init_secondary()
In-Reply-To: <ccbd2f11-bb74-19bd-cf5c-d524625f9a0d@linux.alibaba.com>
References: <20210507110210.147106915@linutronix.de> <20210507114000.429303187@linutronix.de> <ccbd2f11-bb74-19bd-cf5c-d524625f9a0d@linux.alibaba.com>
Date:   Sun, 09 May 2021 15:55:51 +0200
Message-ID: <87wns8ko48.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 09 2021 at 07:40, Lai Jiangshan wrote:
> On 2021/5/7 19:02, Thomas Gleixner wrote:
>> +#ifdef CONFIG_SMP
>> +void cpu_init_secondary(void)
>> +{
>> +	cpu_init_exception_handling();
>> +	cpu_init();
>> +}
>> +#endif
>
> Hello
>
> No code invokes this function in this patch.
>
> Forgot to invoke it from start_secondary() or somewhere?

Yes. Stupid me.
