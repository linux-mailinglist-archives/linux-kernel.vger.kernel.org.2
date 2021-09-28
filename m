Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E92E41BA77
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 00:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243120AbhI1Wg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 18:36:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238632AbhI1Wg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 18:36:56 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632868515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hr8gQAyAgYcOyI5nNtgt0e8+sqk6FwHVjdr3NP4STq4=;
        b=yPVbE2BY1d8/z60Rq3UHL9M6xuRwOmPjJ6SMnJFuBB27BotZ0J+HGolKLtbF7AjbCaR5Nk
        3s2opZo0UoDu6c32cFWxwRtj13JnCGR6qRp8mPCB9+nty69BJrPUtmLwowCTyqk3IWOXnD
        4iRUKXZj62Xw4eMvDyWsw17/eO66nu8pv30PrR0Lik5sEIJIekwnyLRT2/SaUKEBY+qRAN
        m+/LW4NhMMP4EmWstuKgodeia18qo6lwy8r3OMsaVeeK4kJUBSgKFJ1n3ixoCyIG5Raau2
        6qavE8MvgenEOlcPGx3p9YewFuawAS4AtaGJxkr/te531e6v37idbKIurf2FvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632868515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Hr8gQAyAgYcOyI5nNtgt0e8+sqk6FwHVjdr3NP4STq4=;
        b=Ao/DYRKfJmSl8Z/hcZgsmlwmXCH13mGpUQpwZyg0y2JfX684x6BWJan6bhW9JqxkEWdL3a
        xORFSFw5IVRPzbDg==
To:     Peter Zijlstra <peterz@infradead.org>, paulmck@kernel.org,
        sfr@canb.auug.org.au
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Re: [PATCH 1/3] rcu: Always inline rcu_dynticks_task*_{enter,exit}()
In-Reply-To: <20210928084217.908041969@infradead.org>
References: <20210928084020.819856223@infradead.org>
 <20210928084217.908041969@infradead.org>
Date:   Wed, 29 Sep 2021 00:35:14 +0200
Message-ID: <87ee989vml.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28 2021 at 10:40, Peter Zijlstra wrote:

> RCU managed to grow a few noinstr violations:
>
>   vmlinux.o: warning: objtool: rcu_dynticks_eqs_enter()+0x0: call to rcu_dynticks_task_trace_enter() leaves .noinstr.text section
>   vmlinux.o: warning: objtool: rcu_dynticks_eqs_exit()+0xe: call to rcu_dynticks_task_trace_exit() leaves .noinstr.text section
>
> Fix them by adding __always_inline to the relevant trivial functions.
>
> Also replace the noinstr with __always_inline for the existing
> rcu_dynticks_task_*() functions since noinstr would force noinline
> them, even when empty, which seems silly.
>
> Fixes: 7d0c9c50c5a1 ("rcu-tasks: Avoid IPIing userspace/idle tasks if kernel is so built")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
