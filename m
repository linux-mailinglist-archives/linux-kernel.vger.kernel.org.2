Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5D2732A4AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838485AbhCBKzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:55:00 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36324 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383052AbhCBKqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:46:10 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614681928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vSOy8dFeOWs2dUYht0tqtF69xzoKC+eQy2xuFHyua5I=;
        b=Y6pmBHMmwv8wUtkfhespjgY/x6QS9e35XcglBRIUOp2I+XS9TXMGCMMMB0p5GB+v7X3qCC
        mbAzXSdYQyT2ucsI03h/edoxdZppVl4N8+/hfbCUPuzqumqBq/F3Ek5exG/O5TIeaBtLcl
        cCfunqwhLVa4VYPyQJv/XqDOsSuC+jJ8236Ef5i1WX6D3PCa6MNmLYZkPzLQPkd3C96rxU
        e4wWxawSMHaj5IJv7iNZUwhN2sgYyCPhlJzTJuWAkhpDqsp7U1sCL1oeh30PMwCjEqvCXX
        7zQtRQI1vwab/ahWbsm6EBF2tsBt1/crPwz4ynYy3efJZrODPTdX3cX+5M8IxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614681928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vSOy8dFeOWs2dUYht0tqtF69xzoKC+eQy2xuFHyua5I=;
        b=GXOfiVqk2mYR6O83D5argptmP1sp4qvmGQZHwJ/9nP5x+tH7n5o31BZ9g2mQ0Kqfp//m3W
        zjM5bqhiwrRtomCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH next v3 02/15] mtd: mtdoops: synchronize kmsg_dumper
In-Reply-To: <YDzaYqrk3Dv37uDa@alley>
References: <20210225202438.28985-1-john.ogness@linutronix.de> <20210225202438.28985-3-john.ogness@linutronix.de> <YDzaYqrk3Dv37uDa@alley>
Date:   Tue, 02 Mar 2021 11:45:27 +0100
Message-ID: <87tuptq1fc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-01, Petr Mladek <pmladek@suse.com> wrote:
>> The kmsg_dumper can be called from any context and CPU, possibly
>> from multiple CPUs simultaneously. Since the writing of the buffer
>> can occur from a later scheduled work queue, the oops buffer must
>> be protected against simultaneous dumping.
>> 
>> Use an atomic bit to mark when the buffer is protected. Release the
>> protection in between setting the buffer and the actual writing in
>> order for a possible panic (immediate write) to be written during
>> the scheduling of a previous oops (delayed write).
>
> Just to be sure. You did not use spin lock to prevent problems
> with eventual double unlock in panic(). Do I get it correctly,
> please?

I do not understand what possible double unlock you are referring to.

I chose not to use spinlocks because I wanted something that does not
cause any scheduling or preemption side-effects for mtd. The mtd dumper
sometimes dumps directly, sometimes delayed (via scheduled work), and
they use different mtd callbacks in different contexts.

mtd_write() expects to be called in a non-atomic context. The callbacks
can take a mutex.

John Ogness
