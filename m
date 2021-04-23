Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC4B369014
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 12:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241859AbhDWKJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 06:09:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45102 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbhDWKJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 06:09:26 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619172529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JYza8wGbxXNcNh22/P8wZBNU1iEMeqk4CXTY/BnZuI0=;
        b=FzjGmcJ66NTtrXytOIKTFyHne0GMmiuWxg9c3zT0DDAt4K9EYacpRSkpW9XPb1iySuPxoe
        DN5ToRFncQig7OKGpiqdzXsfOc5FAlPTq97FKMT6AcReXtdvrxKAajJH0a8XveT5qwwB4U
        DA5O+NFF6cMuMU84U4UUv7w1BrmHX15isJTbBPSnJpld1x103sNRs4QXvOqjSn3rmUYFbQ
        dS1lRPH0n9oAoTGOsDDJ6p155CvgCKFbjmO8uNMB4oMjxRvsVOqD9kdbG9xMumQk6CpYdz
        KmeXZSH6ju+pNQPMJquHh2aB4qzZJWMlnF1G6c5MBqc9wKRRMzKzetA9RpLdFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619172529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JYza8wGbxXNcNh22/P8wZBNU1iEMeqk4CXTY/BnZuI0=;
        b=oTmAgqX0vnHHBCFncqwnfX7DuI1rbqIuH9DUGr+Ri3oIOSDsRv7jPCCPu08t9xrzjaabXm
        UFA7n56UPkhXaZBA==
To:     Lukasz Majewski <lukma@denx.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adhemerval Zanella <adhemerval.zanella@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <carlos@redhat.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [patch 5/6] futex: Prepare futex_lock_pi() for runtime clock selection
In-Reply-To: <20210423113424.19e26b77@jawa>
References: <20210422194417.866740847@linutronix.de> <20210422194705.338657741@linutronix.de> <20210423113424.19e26b77@jawa>
Date:   Fri, 23 Apr 2021 12:08:48 +0200
Message-ID: <877dktwbwv.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23 2021 at 11:34, Lukasz Majewski wrote:
>>  	ret = get_futex_key(uaddr, flags & FLAGS_SHARED, &q.key,
>> FUTEX_WRITE); @@ -3711,7 +3711,7 @@ long do_futex(u32 __user *uaddr,
>> int op, 
>>  	if (op & FUTEX_CLOCK_REALTIME) {
>>  		flags |= FLAGS_CLOCKRT;
>> -		if (cmd != FUTEX_WAIT_BITSET &&	cmd !=
>> FUTEX_WAIT_REQUEUE_PI)
>> +		if (cmd != FUTEX_WAIT_BITSET && cmd !=
>> FUTEX_WAIT_REQUEUE_PI) return -ENOSYS;
>
> What is the exact change for those two lines above? Looks like some
> different tab/spaces...

Oops. Yes. I surely stared at every hunk more than once...

