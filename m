Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD953BCA00
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 12:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbhGFKfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 06:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbhGFKfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 06:35:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A47C061574
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jul 2021 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n2Vzx/jD6M+1KgcgpN/qKExJDJdXYiAmzmysfJfl01o=; b=n2viB8M4RXVDiYLyvvYbcTNk3V
        A8ED53F16U0tzR1oqzalTVtNxY6CqG8RT3RRiyHx9Bp0s5oLHeakV28w6smscQiQ/bQnKfQQsWPch
        JZEBlV9ueq0x0+chJEIyG0NhmnrJdFyON/uSXcOTpdx1Urmtagd+XyxdudMeh6r1qhRu35H45muhL
        /XW32kjz3gapDCvQhLZ9S7IhY/R81+UdFtOgaj4Z6dj7U1Q0C6PYAOMJ9yJqu+6CZ8MWaMejr1OdZ
        orh8JFn17EqmlfPnSAd2lLUpaxQjyrL/gZ50A2V9VHR9xEmK+GxcyOJfqjvwaMR4fKY6zgGzJKwU5
        u1DAOP2g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0iO2-00F17E-Ea; Tue, 06 Jul 2021 10:33:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 05EEC300233;
        Tue,  6 Jul 2021 12:33:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E708F200D9D6C; Tue,  6 Jul 2021 12:33:04 +0200 (CEST)
Date:   Tue, 6 Jul 2021 12:33:04 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: RCU vs data_race()
Message-ID: <YOQxYJaypdsmqhlX@hirez.programming.kicks-ass.net>
References: <YMxYR33XEfVg6AoD@hirez.programming.kicks-ass.net>
 <YMxgbuEdrq8k3eZp@elver.google.com>
 <YMyC0iux0wKzc1JG@hirez.programming.kicks-ass.net>
 <20210618204800.GK4397@paulmck-ThinkPad-P17-Gen-1>
 <YM+TlNDJm1Jx1WQW@hirez.programming.kicks-ass.net>
 <20210620210127.GR4397@paulmck-ThinkPad-P17-Gen-1>
 <YNA/gkHbq46A/21C@hirez.programming.kicks-ass.net>
 <20210621133757.GS4397@paulmck-ThinkPad-P17-Gen-1>
 <YOQNgsS9Tjt4aDmG@hirez.programming.kicks-ass.net>
 <CANpmjNNRAJ34KUF-1hWrP3F0Ooy4oi6kbH82WWpDxmVqVSj4SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNRAJ34KUF-1hWrP3F0Ooy4oi6kbH82WWpDxmVqVSj4SA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 06, 2021 at 10:44:46AM +0200, Marco Elver wrote:
> On Tue, 6 Jul 2021 at 10:00, Peter Zijlstra <peterz@infradead.org> wrote:
> [...]
> > In that case, would not an explicit: data_debug(addr) call (implemented
> > by KASAN/KCSAN/whoever), which would report whatever knowledge they have
> > about that address, be even more useful?
> 
> KCSAN/KASAN report data-races/memory errors as soon as they encounter
> them, but before they do, cannot give you any more than that (metadata
> if it exists, but not sure it can be interpreted in any useful way
> before an error occurs).
> 
> But maybe I misunderstood. Is data_debug() meant to not return
> anything and instead just be a "fake access"?

Mostly just print any meta data that you might have. Like who allocated
it, or which code touched it. I'm thinking KASAN/KCSAN need to keep
track of such stuff for when a violation is detected.

If I understand Paul right; and there's a fair chance I didn't; I tihnk
the issue is that when RCU finds a double call_rcu() (or some other
fail), it has very little clue how we got there, and any addition
information might be useful.

