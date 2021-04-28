Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00D2C36D3FD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbhD1Iba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236805AbhD1Ib3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:31:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75049C061574
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 01:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=HKmR83wbMrXIN1GQCjjKTIEAr6iS+t5wzeghEaNE/3c=; b=h2clHxz5vWLNgFB8LzunBQ99T/
        +fsGBfz3Yf4mT2JPidTAHn8VzXbrdA5xFHX1MBxwoUxA4MPLKQqNe2gFy3fhAfwybirua2j58iqng
        WFnfMjMQ4S616aO5DnykJujMt1c0cLQrHGErIuu5afyh8S4hH/exYT3kNEApgv/ls0p7UUPCZ3qpe
        xFSH/Fua72DIZJQtUpWYvQRk21qzGmH2dUIXKAFcwE3xL5v2uSop8SK5m5CsF3SsKDN2OnGY4npDq
        kExH6QbxQDbtKIhnVuFSqN2rRi9/6gmA0ZKKFPbmF9eR3vM38n8V7p/ImIVzr36uO1Ih2ahB92Uvg
        XHjcgRrA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lbfaB-0082el-DV; Wed, 28 Apr 2021 08:30:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E0FC1300094;
        Wed, 28 Apr 2021 10:30:05 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B3AE62BF7B83C; Wed, 28 Apr 2021 10:30:05 +0200 (CEST)
Date:   Wed, 28 Apr 2021 10:30:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     =?iso-8859-1?Q?J=F6rn?= Engel <joern@purestorage.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: sched: wakeup setting TIF_NEED_RESCHED too frequently
Message-ID: <YIkdDeb9c+XmDRvM@hirez.programming.kicks-ass.net>
References: <YIh/QubidJcE5IIv@cork>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YIh/QubidJcE5IIv@cork>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 02:16:50PM -0700, Jörn Engel wrote:
> Anyway, trying to find a cause, I noticed the following call chain:
> 	set_nr_if_polling()
> 	ttwu_queue_remote()
> 	ttwu_queue()
> 	try_to_wake_up()
> 	default_wake_function()
> 	curr->func()
> 	__wake_up_common()
> 	__wake_up_common_lock()
> 	__wake_up()
> 	wake_up()
> 
> Call chain above is manually created from source code.  Closest sample I
> caught with instrumentation is missing the leaf calls after
> try_to_wake_up():
> 	_raw_spin_unlock_irqrestore+0x1f/0x40
> 	try_to_wake_up+0x425/0x5e0
> 	wake_up_q+0x3f/0x80
> 	futex_wake+0x159/0x180
> 	do_futex+0xcd/0xba0
> 
> Afaics, the result is us setting TIF_NEED_RESCHED on any wakeup, unless
> wake_list is already populated.  Is that actually intentional?  And is
> that useful for performance of latency?  I think it isn't, but I am
> probably missing something here.

set_nr_if_polling() only sets TIF_NEED_RESCHED IFF TIF_POLLING_NRFLAG is
set. TIF_POLLING_NRFLAG is only set when idle and is then sufficient to
wake that cpu and reschedule.

If not TIF_POLLING_NRFLAG, then we send an IPI to deal with the
non-empty wake_list.
