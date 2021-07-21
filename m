Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 685243D1835
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 22:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhGUTze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 15:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhGUTzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 15:55:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DF4C061575
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 13:36:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626899767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VhovpCDMe6qYvpY3LIzNmgTjkTz8Q04ycc21UN9oufA=;
        b=UK2zeV1RXy7ul4dkcmxFImbE+m20gPvafLWpJWzJAa3oXMdMVmeebh4GCvJ78W4BYf0tjk
        zUzEZFtJ6/QxSCe54orsYwW4i3DaIVeq/wkBMoO802pvXH0iKj22d7DB1ArfRGZce/xve4
        TcM3uFqtlNW5vcz+Sv6jTqQvvr5NAB+XKlILVK45Cqas9lahn95Huo2uBx/YpIyrZdcOw6
        npeGcYZxaR2z7Q9MgI66+cP1IRJIY4vyQ6RNMWSqfUyz01XVUbDDV2W/7FwXypedHZmu1F
        s3wLinTjvHdaymPek8hBjdceSkV+Ajvnxw8m7kJcnaLPprRfKVsRvGl32XKbTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626899767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VhovpCDMe6qYvpY3LIzNmgTjkTz8Q04ycc21UN9oufA=;
        b=Q35vB6KKP75fXv/myH8LmcYww7OrbBTlhpEwSNfivsguyeXXnjE3o+He2KvQ5eLfvMsIlB
        n0JxhQgFkY8mPdDQ==
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, kernel-team@fb.com,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [PATCH] x86,mm: print likely CPU at segfault time
In-Reply-To: <20210719150041.3c719c94@imladris.surriel.com>
References: <20210719150041.3c719c94@imladris.surriel.com>
Date:   Wed, 21 Jul 2021 22:36:07 +0200
Message-ID: <87sg07pfpk.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rik,

On Mon, Jul 19 2021 at 15:00, Rik van Riel wrote:
>
> Adding a printk to show_signal_msg() achieves that purpose. It isn't
> perfect since the task might get rescheduled on another CPU between
> when the fault hit and when the message is printed, but it should be
> good enough to show correlation between userspace and kernel errors
> when dealing with a bad CPU.

we could collect the cpu number in do_*_addr_fault() before interrupts
are enabled and just hand it through. There are only a few callchains
which end up in __bad_area_nosemaphore().

Thanks,

        tglx
