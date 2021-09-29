Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABFE41C0B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 10:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244797AbhI2Igd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 04:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244789AbhI2Igb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 04:36:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5256BC06174E;
        Wed, 29 Sep 2021 01:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SV4z02fQHJKU53d8jxad0OxnLv9XTsMO9xV7N7zdQ6Y=; b=rSe8TuC8imwfT6E1X6+WboQJLW
        7k7fqZpa/U1uGtZoCJbcblrFT0JFyr7cTZW0Nch1KpeE0R432yshLdinJP7FGEW3dozL0/zimcP4V
        PX58V37T6BdAwrcgCZTdKoOcpO4ZCw4CoUHOSwg3CH+zmkL9aLFwFe8yBQuBVXvCe+hei0usuo3wQ
        P7QAsfy/Mg4H+o/6pDYa+Dz9uPy6qa4P7KnCQFid498eo1cODfprebhnqCKGiXw6arj4ekjmVjfU4
        rB0ni5307qLFuCJKvxZFoG4+nkyJcSi9nC/RddFPl7QO8z3moJT26grUDEfqPwnCPwGm1+Hzl6Nk0
        dX4aT1oA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mVV1h-00BeBj-Of; Wed, 29 Sep 2021 08:33:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B38B30029A;
        Wed, 29 Sep 2021 10:33:16 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 82F9729AD1D57; Wed, 29 Sep 2021 10:33:16 +0200 (CEST)
Date:   Wed, 29 Sep 2021 10:33:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexander Lochmann <info@alexander-lochmann.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] Introduced new tracing mode KCOV_MODE_UNIQUE.
Message-ID: <YVQkzCryS9dkvRGB@hirez.programming.kicks-ass.net>
References: <20210927173348.265501-1-info@alexander-lochmann.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927173348.265501-1-info@alexander-lochmann.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 07:33:40PM +0200, Alexander Lochmann wrote:
> The existing trace mode stores PCs in execution order. This could lead
> to a buffer overflow if sufficient amonut of kernel code is executed.
> Thus, a user might not see all executed PCs. KCOV_MODE_UNIQUE favors
> completeness over execution order. While ignoring the execution order,
> it marks a PC as exectued by setting a bit representing that PC. Each
> bit in the shared buffer represents every fourth byte of the text
> segment.  Since a call instruction on every supported architecture is
> at least four bytes, it is safe to just store every fourth byte of the
> text segment.

I'm still trying to wake up, but why are call instruction more important
than other instructions? Specifically, I'd think any branch instruction
matters for coverage.

More specifically, x86 can do a tail call with just 2 bytes.
