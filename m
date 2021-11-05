Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAD1446484
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhKEOAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 10:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbhKEOAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 10:00:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3F56C061714
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 06:57:29 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636120648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=41fUQYQRItfdxOFUK3dRPaRWhEWtV10CSnYM0e/zT3o=;
        b=r8TnQFAcGYXoCyTVKYd37rfgQOaJWa8cecJh0vCSautQIyO40lmD0OJC33C6rNrGWmOdop
        SBHz7XUJ3kU+dbFOGhDSLxMXVhqpOgESXPzYEi161+8EC4ocjURMLN+WFdNLoNTpb/c06v
        6m/QyuTRGwCSwQc6LJ8KTINxlfw/zxVGinU+slycQEpattF8LxnbImP9V5Ye8JXC05hc3G
        amHri4ijPkBZOF1g9/2MWGLsvxy6F+NTLgM3Z5DuKlelvvLheg21N0ud204uC+hdI4KSse
        Lhs3Iuzq8vhXJvo1MAGoa8LgRAi+0IzhQaleD8y8VQI7fPMaV3n4YmVF8J6aBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636120648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=41fUQYQRItfdxOFUK3dRPaRWhEWtV10CSnYM0e/zT3o=;
        b=8JBP62uRQOT2yvJ65iG48WHrLtVe6mIzWyCk+TnpFTq/sHNCn/3Nscl8igvAq3bSjCiiJ4
        atVYwbugKsNSA/AA==
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: Removal of printk safe buffers delays NMI context printk
In-Reply-To: <1636111599.wwppq55w4t.astroid@bobo.none>
References: <1636039236.y415994wfa.astroid@bobo.none>
 <87ee7vki7f.fsf@jogness.linutronix.de>
 <1636073838.qpmyp6q17i.astroid@bobo.none>
 <87r1bv2aga.fsf@jogness.linutronix.de>
 <1636111599.wwppq55w4t.astroid@bobo.none>
Date:   Fri, 05 Nov 2021 15:03:27 +0106
Message-ID: <87h7cqg0xk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-05, Nicholas Piggin <npiggin@gmail.com> wrote:
>> What was removed from 93d102f094b was irq_work triggering on all
>> CPUs.
>
> No, it was the caller executing the flush for all remote CPUs itself.
> irq work was not involved (and irq work can't be raised in a remote
> CPU from NMI context).

Maybe I am missing something. In 93d102f094b~1 I see:

watchdog_smp_panic
  printk_safe_flush
    __printk_safe_flush
      printk_safe_flush_buffer
        printk_safe_flush_line
          printk_deferred
            vprintk_deferred
              vprintk_emit (but no direct printing)
              defer_console_output
                irq_work_queue

AFAICT, using defer_console_output() instead of your new printk_flush()
should cause the exact behavior as before.

> but we do need that printk flush capability back there and for
> nmi_backtrace.

Agreed. I had not considered this necessary side-effect when I removed
the NMI safe buffers.

I am just wondering if we should fix the regression by going back to
using irq_work (such as defer_console_output()) or if we want to
introduce something new that introduces direct printing.

John Ogness
