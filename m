Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D100415127
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237826AbhIVUKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237392AbhIVUKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:10:21 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F0CC0613B8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XBp4hdZqr8VwVUiwZYI8VPyo8z+fiJiv3xnzJAIXtMI=; b=WhqfKq0qyg8JBuFBDDCziAiUwn
        8EqDuloKUsT9epAgfAJavWYQO/nTArXhKXb3Y2VOyXoHhqnxmHejZLq+I5CT6aOxH8/N/V+uc1oI9
        aZz2OSWyGPjHl6u6Gq2BDwO0sLVw+nm4lpaLqo1bf1T9N5yfXEK6iTXFCHGmcDH4QYxhMCrNVRdWk
        ybnZK5z6f6xQcuacr4mXN3eOE4UIC/8fwug4GiT8esgBYLxwHLSz08ZR1xX7CP6rBR7uwdTqWVxux
        yn9yPOcQzGEeR7Os+mXSG8MtKjlMkUwM1CM4zomDYzhUz3psn3QHfihSU4/wbYLAN7GE8r9VmG0Xk
        uJQz35Xg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT8Vc-0054La-CJ; Wed, 22 Sep 2021 20:06:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 049E63001CD;
        Wed, 22 Sep 2021 22:06:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DD0F82133B1A0; Wed, 22 Sep 2021 22:06:23 +0200 (CEST)
Date:   Wed, 22 Sep 2021 22:06:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [RFC PATCH] locking/rwsem: Add upgrade_read()
Message-ID: <YUuMv6fA+TpqH3wb@hirez.programming.kicks-ass.net>
References: <20210922193657.29461-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922193657.29461-1-longman@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 03:36:57PM -0400, Waiman Long wrote:
> Currently there are about 12 instances in the kernel where an up_read()
> is immediately followed by a down_write() of the same lock. For example,
> 
>   drivers/tty/n_tty.c:		up_read(&tty->termios_rwsem);
>   drivers/tty/n_tty.c-		down_write(&tty->termios_rwsem);

And TTY is a high performance issue, that requires hacks like this?

> Since we have already provided a downgrade_write() function, we may as
> well provide an upgrade_read() function to make the code easier to read
> and the intention clearer.
> 
> If the current task is the only reader, the upgrade can be done by a
> single atomic operation. If not, the upgrade will have to be done by a
> separate up_read() call followed by a down_write(). In the former case,
> the handoff bit is not considered and the waiter will have to wait a
> bit longer to acquire the lock.
> 
> The new upgrade_read() function returns a value of 0 for safe upgrade
> where rwsem protected data won't change. Otherwise a value of 1 is
> returned to indicate unsafe upgrade where rwsem protected data may
> change during the upgrade process.

Yuck...

Is there any workload where this is a massive win? I'm thinking that
either the lock is contended and you get the unsafe option which is the
same as today, or the lock isn't contended and you would've gotten
fast-paths and you barely safe anything anyway.

Also, -ENODATA
