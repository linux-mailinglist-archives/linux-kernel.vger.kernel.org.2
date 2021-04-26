Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E6636ACC5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 09:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhDZHR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 03:17:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60438 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbhDZHRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 03:17:53 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619421419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AhfatZBafAaOFUgz+S6LTYdlaDzgBz9nm0hLzAFnykA=;
        b=ZcvCttx8m3Vcg3X+GGjdPTuXdcI3xUWt/3Ym5EB0rc6HVD28GRKw8/u1+0JEaKbs8SqqjN
        HF2a5iYTxV2jLbTJLpzJc8Vrcs3xWkwiXk5qFtikJ2ZRlX/2lkzn6VeBtkgaJXNbeD8bke
        xF7zz/L5M7k1ibalhfj1bZZbtIJgGY8WqkBQfBo9vCtixPPMC8H993/2MLHtDi6wVX8BxA
        0n3Tl3OOSpkkYR3sLuWR1mSekKFfWZGOeNeSzFp8fytBs4jLcgP/cvPhb8QrpuKMDD0LPD
        gQKFV4UoVbCXAsvck19XfW8BX7+PDlI199rHA2DroJzmxnDlmN4ghNzbhTSQqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619421419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AhfatZBafAaOFUgz+S6LTYdlaDzgBz9nm0hLzAFnykA=;
        b=aHdWH83sU6KwRU2TLXnJhDFsv21n/5XEE3p/ZysvuJg0RSMM2rn0oWpP8JafQvuEivHs30
        yrz6UMjcdILatEBQ==
To:     Andi Kleen <ak@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@fb.com, neeraju@codeaurora.org,
        feng.tang@intel.com, zhengjun.xing@intel.com,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH v10 clocksource 3/7] clocksource: Check per-CPU clock synchronization when marked unstable
In-Reply-To: <20210426041235.GT1401198@tassilo.jf.intel.com>
References: <20210425224540.GA1312438@paulmck-ThinkPad-P17-Gen-1> <20210425224709.1312655-3-paulmck@kernel.org> <20210426041235.GT1401198@tassilo.jf.intel.com>
Date:   Mon, 26 Apr 2021 09:16:59 +0200
Message-ID: <871raxv7kk.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25 2021 at 21:12, Andi Kleen wrote:

> On Sun, Apr 25, 2021 at 03:47:04PM -0700, Paul E. McKenney wrote:
>> Some sorts of per-CPU clock sources have a history of going out of
>> synchronization with each other.  However, this problem has purportedy
>> been solved in the past ten years.  Except that it is all too possible
>> that the problem has instead simply been made less likely, which might
>> mean that some of the occasional "Marking clocksource 'tsc' as unstable"
>> messages might be due to desynchronization.  How would anyone know?
>> 
>> Therefore apply CPU-to-CPU synchronization checking to newly unstable
>> clocksource that are marked with the new CLOCK_SOURCE_VERIFY_PERCPU flag.
>> Lists of desynchronized CPUs are printed, with the caveat that if it
>> is the reporting CPU that is itself desynchronized, it will appear that
>> all the other clocks are wrong.  Just like in real life.
>
> Well I could see this causing a gigantic flood of messages then.
> Assume I have 300 cores, do I get all those messages 300 times repeated
> then? If the console is slow this might end up taking a lot
> of CPU time.

Exactly 4 pr_warn() lines in dmesg which are emitted exactly once when
the TSC deviates from the watchdog where three of them print a cpumask
are really a gigantic flood of messsages.

Thanks,

        tglx
