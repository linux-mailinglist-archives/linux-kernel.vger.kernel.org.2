Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23203E05C0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 18:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbhHDQUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 12:20:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36866 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234064AbhHDQUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 12:20:17 -0400
Date:   Wed, 4 Aug 2021 18:20:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628094003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L4wHZ6wbrGv70RUhb1xAJtO/dX7kNEKKQsfBytS5G5M=;
        b=ZkvcAOsZLiuT6VeHuSg4HhXRJ1UJbh2aR8VSHXywjSg35cYF+g8tt323D/aIxnHZ0TENe4
        NTefvUUq6ULnqi9Oql35/g3pY3I57y3taqG7BN8U1Jr9CTkLSh46RTDR8hAgDu+EA2IQ8b
        6zQ9H6NL+8Ai40RAjbtRM9nT7Ozz7r/0vQGkO5gR17U2eff6bGvG5pY7b68U7d76WAIvgA
        Ugj+Zh8h59T3xx5H9n4IKa5xBtNCjB5zkZYgTUwOESV2MhnHKOgsvmPI8nidoGQsR5vScz
        TrFZzjp6dzDze2DIlRgn1ORz7qxHm/WGi5mNfk/EE7I4qhKVv0d+vvqjnv0Xjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628094003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L4wHZ6wbrGv70RUhb1xAJtO/dX7kNEKKQsfBytS5G5M=;
        b=DCMYxwTcDzLJIGkvs+KScIQnvc8v/sJVDfvgwyxINMCBg5UeWImC8jcp+9tJxNWT+teksl
        hmnW1xIytEENXmCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Wagner <wagi@monom.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v5.14-rc4-rt4
Message-ID: <20210804162001.resdas32c6oy75o3@linutronix.de>
References: <20210804110057.chsvt7l5xpw7bo5r@linutronix.de>
 <20210804131731.GG8057@worktop.programming.kicks-ass.net>
 <4f549344-1040-c677-6a6a-53e243c5f364@kernel.dk>
 <feebf183-2e33-36b5-4538-62a40b2a58b6@kernel.dk>
 <20210804153308.oasahcxjmcw7vivo@linutronix.de>
 <f2d0a028-fe85-28ff-9cea-8ab1d26a15d0@kernel.dk>
 <20210804154743.niogqvnladdkfgi2@linutronix.de>
 <7c946918-ae0d-6195-6a78-b019f9bc1fd3@kernel.dk>
 <20210804155747.cwayhjsdjc4zaubd@linutronix.de>
 <c3fa07d1-a3c4-6775-f419-4875eb41bc88@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3fa07d1-a3c4-6775-f419-4875eb41bc88@kernel.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-04 10:05:39 [-0600], Jens Axboe wrote:
> So what do you propose in the interim? As far as io_uring is concerned,
> it's not a _huge_ deal to do the IRQ dance, but it does bother me that
> we're making things slightly worse for the mainline kernel just to make
> the out-of-tree patches happy.

I'm sorry but I propose nothing other than the dance. I don't think
PeterZ/ tglx will appreciate the ifdefery to avoid the IRQ-on/off here.
I have no other ideas here.

Sebastian
