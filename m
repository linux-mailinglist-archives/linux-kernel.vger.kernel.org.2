Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F013E043F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 17:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239103AbhHDPdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 11:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239058AbhHDPdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 11:33:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B924C0613D5;
        Wed,  4 Aug 2021 08:33:12 -0700 (PDT)
Date:   Wed, 4 Aug 2021 17:33:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628091189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UITlFQfMn5a0ECmudpd6OTfbQkrY3q2ViFmsUd3y0O4=;
        b=S2FFqwPNBno1O6pWE5QfyQ3X3ppQfvNrqSCCFH2VX42eeZBvQ/QzRF85D0MDEVtcuf1Nyk
        yJvCOfQsYsO+2xwCe8WrUsjG2LewHgOKUks4mhzid5kTEUFM56GTZgpWKcEyz5wMtkEFVh
        7C/326YYoNX65TopjIjQA0ijoqNH8UyCbCYwLoYJps2/0cJQr5PZMlRVjWVNZz2w35b5pc
        IgssKC74H+0BCfqkalCQuAozbBunA/asUsXdGCOxmMXhHlQsfeKp+6YEfN4lOu1ycR5bMW
        wYy2a/NvjfOGOGXQrn5KAe1g5SiGODJkKndWhDfSwbZy2sSpywFtsR+0+BZogw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628091189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UITlFQfMn5a0ECmudpd6OTfbQkrY3q2ViFmsUd3y0O4=;
        b=6FNL0w5IQx/o71Yw07KRIwB0qY27ffUQoONfH/lx5Kfl23fqgpa2RpeMx61Bv8zsfjx6AW
        xR+zMUCSSHKL2/Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804153308.oasahcxjmcw7vivo@linutronix.de>
References: <20210802162750.santic4y6lzcet5c@linutronix.de>
 <20210804082418.fbibprcwtzyt5qax@beryllium.lan>
 <20210804104340.fhdjwn3hruymu3ml@linutronix.de>
 <20210804104803.4nwxi74sa2vwiujd@linutronix.de>
 <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
 <20210804131731.GG8057@worktop.programming.kicks-ass.net>
 <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
 <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-04 08:23:55 [-0600], Jens Axboe wrote:
> Totally untested, but I think the principle is sound. I'll run it through
> some testing.

This is needed:

diff --git a/fs/io-wq.c b/fs/io-wq.c
index 1192ee2abd982..77ec6896edaa5 100644
--- a/fs/io-wq.c
+++ b/fs/io-wq.c
@@ -428,9 +428,9 @@ static struct io_wq_work *io_get_next_work(struct io_wqe *wqe)
 	}
 
 	if (stall_hash != -1U) {
-		raw_spin_unlock(&wqe->lock);
+		raw_spin_unlock_irq(&wqe->lock);
 		io_wait_on_hash(wqe, stall_hash);
-		raw_spin_lock(&wqe->lock);
+		raw_spin_lock_irq(&wqe->lock);
 	}
 
 	return NULL;


otherwise the spinlock_t lock in io_wait_on_hash() is acquired with
disabled interrupts which is a no-no on -RT.
With that it all looks good as far as I can tell.
Thank you.

Sebastian
