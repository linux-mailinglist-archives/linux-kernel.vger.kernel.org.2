Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37B103161FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhBJJVH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhBJJSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:18:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD67C061786
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 01:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LbeIvRb0vRXRonmlxKLhQurNNj84YIsXZdqLUtKqlKI=; b=ek19VJOxg0m0Rjc+QVwozXCmkv
        LFtIX8jd/tVz6UntrS0oLi0w2d+6ENQogXN9ZEuY0w7GodG7KAJ6YuxLA3QmnnZlqgRE50OwBStao
        8PYXmAxzTHV4jEm6Mt/BCbTEOg1CGbphh5dJyjKHsABFbzlcJ+2u2E+LKuRhwkOuJMlJQ71GoiuN4
        Sl7ATTTjX7Ykxfr0Ap8OBcUDnZGT+PiC+L4TS1W/BbGHkMwkGT8mjeA9ml+taR3RZfTxMrzDBB0Ex
        uENCcNpMiIpjt5OEx2YinIpWaImD8jxL2Yp4nr6/dTDwwOIJk9yDaXo4wARM/sdFkQ3WIz/ul9gzV
        Ff82ABBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1l9ld1-008dW9-NG; Wed, 10 Feb 2021 09:17:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 127393010D2;
        Wed, 10 Feb 2021 10:17:42 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8CA9201D99FE; Wed, 10 Feb 2021 10:17:42 +0100 (CET)
Date:   Wed, 10 Feb 2021 10:17:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/2] locking/mutex: Kill mutex_trylock_recursive()
Message-ID: <YCOktpCPCeqe+woy@hirez.programming.kicks-ass.net>
References: <20210210085248.219210-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210085248.219210-1-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 09:52:46AM +0100, Sebastian Andrzej Siewior wrote:
> Remove mutex_trylock_recursive() from the API and tell checkpatch not to
> check it for it anymore.

W00t!!

Thanks!
