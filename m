Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3FC424FB9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 11:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240355AbhJGJKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 05:10:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35572 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhJGJKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 05:10:05 -0400
Date:   Thu, 7 Oct 2021 11:08:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633597691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQSxA5BrKSmT8ugQ5tZPDqCHZNXyYi1pLPw9fmt61R8=;
        b=L7HcplSHp9acFF30+yftG8Hbkj6gMmaKZ/oqbz2lspZzB8v+yVQZs8jwzlzQhr5m0CCmZ8
        ELOTUP5tBg8d5nBNZs7TNs5Kkyboxvwz5QlR5Z6z6Lia3wKD+Om+C2XnsHp/V6GdtdQ+qG
        4H/PfgHHbe4ltRygQHMd84IBrHnsDToanQ6K36DGRNJVNo6zuu82tw5wPJ+JcsVc7A7SfF
        ArrJH7boZwOUjnZ2NXfQ3kCduMtcV7bmriCyek7l04k987iAr/xmgASfQNZUN8t3WFz6OS
        K3ieSP5rHqBKVijRlX3TcPWcApPtx+4rEFVrXFMl/jcCPnvMgxn7h64pJbIYrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633597691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQSxA5BrKSmT8ugQ5tZPDqCHZNXyYi1pLPw9fmt61R8=;
        b=hNvWqktYGFMs6n/8xolagZJiIEfd6GjeE34ctll7hzXk/ikaFUMOfuGkxxFSFWdeqv1Ink
        rDZhfxrhI71rFmAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 3/4] irq_work: Handle some irq_work in a per-CPU
 thread on PREEMPT_RT
Message-ID: <20211007090810.7jbxj7giedmqlzyl@linutronix.de>
References: <20211006111852.1514359-1-bigeasy@linutronix.de>
 <20211006111852.1514359-4-bigeasy@linutronix.de>
 <20211007085023.GP174703@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20211007085023.GP174703@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-10-07 10:50:23 [+0200], Peter Zijlstra wrote:
> How's this instead?

Yeah. The last minute move-up of the llist_add() was=E2=80=A6

> (work rename due to there already being a percpu variable of that same
> name on a number or archs, per 0day)

Let me grab that, add that ifdef smp and repost 3/4.

Sebastian
