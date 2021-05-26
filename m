Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC5A39227E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 00:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhEZWEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 18:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbhEZWEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 18:04:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6D5C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 15:03:06 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622066583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UTohWqh3CSUGUskeJH4858GrTk9b2+xV1h3FHXzjaSU=;
        b=wTn6lXcSZYO2TFFgWrM2WXXKKx47TL0MrnqKsGIxkwrr5hdRVf57DDva3YhYKiVkvdpEzl
        5t5Arh+vgdrUUYVMHTXEU4oLtZAcdABbCVEkBrf0sEWylbYztyBnJ5wf+qKn1zBqDc3epC
        5B13ZIv4PqQyDHvZijrf97yDZLlgJNzX76AioSXJN0AiRMnnP05rlhHavLhdRWA6IvTxEj
        bXk4yneKWFzYJshPRijClnYRxjq78odRTj8kk4no9fUCUKl1euiAIC4jMi9Tdy+5bphvcR
        6fDXCzPC/E5AV5FsTk6MVVQmHohRsDIpmdnB+laZDD8ffO9YlfIrjILJAsPfQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622066583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UTohWqh3CSUGUskeJH4858GrTk9b2+xV1h3FHXzjaSU=;
        b=lM0paLMzfM2uJwyiCU7lUlADVqFr7WzxGxoDcbVscPRdeGvlJ5AeIp/xWsGoSEzAIbpUYf
        BI4Dj9Xu1qZ/k8Cw==
To:     Andy Lutomirski <luto@kernel.org>,
        syzbot <syzbot+2067e764dbcd10721e2e@syzkaller.appspotmail.com>,
        bp@alien8.de, bp@suse.de, dave.hansen@linux.intel.com,
        fenghua.yu@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tony.luck@intel.com,
        x86@kernel.org, yu-cheng.yu@intel.com
Subject: Re: [syzbot] WARNING in ex_handler_fprestore
In-Reply-To: <fe20f360-7c6c-f1bf-c3a5-403ae979fae6@kernel.org>
References: <0000000000004c453905c30f8334@google.com> <fe20f360-7c6c-f1bf-c3a5-403ae979fae6@kernel.org>
Date:   Thu, 27 May 2021 00:03:03 +0200
Message-ID: <87sg29886g.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25 2021 at 17:33, Andy Lutomirski wrote:
> On 5/24/21 1:51 AM, syzbot wrote:
> I entirely believe that this bug is real and that syzbot bisected it
> correctly, but I'm puzzled by the reproducer.  It says:

The bug is real and the bisection is correct.

> ptrace$setregs(0xd, r0, 0x0, &(0x7f0000000080))
>
> I would really, really expect this to result from PTRACE_SETREGSET or
> PTRACE_SETFPREGS, but this is PTRACE_SETREGS.
>
> Am I missing something really obvious here?

That ptrace muck is a red herring and has nothing to do with it.

I decoded it fully by now and will send out coherent info (and hopefully
a patch) tomorrow with brain awake. Time for bed here...

Thanks,

        tglx


