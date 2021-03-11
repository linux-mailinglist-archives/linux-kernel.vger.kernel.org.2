Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76627336E29
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 09:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhCKIrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Mar 2021 03:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhCKIrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Mar 2021 03:47:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE92C061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Mar 2021 00:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=L2P1sESFUaV/AW0lkKatvnx8pKxtKng9weUi15MfMaU=; b=gBR8eV/IbSiscH5JXflpZdDHlL
        qXZjFCvww+N7QntlYCowl3IeE37q+IDEkBXAxykul4NiMQAW19F/sjBYh3mIXa0UshPeV29p4k4EJ
        Yxh2q43xfCKcQ0/DH0QF2tY0s5MrbYg8pELzhVxzsAEMMHzr79AmjLs2Eg3umsSUH6oDZefUO/Pa6
        JW45InAPh5dp07yzhiUFaew3WEUyxqEvWmVCGJIOLgx1JlIy2RUk/z3gIyC+tt4kFQ7VKCs6C4mrR
        Xy7Xy6OIkFSg0FPFWXzeLZa0WxY0g/tYCZJBHymbix50HqitTL6iQXBWFYy0UctE1BatbdFnkRfck
        t5ifThQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lKGxk-006tOG-55; Thu, 11 Mar 2021 08:46:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1E2B63013E5;
        Thu, 11 Mar 2021 09:46:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 03A2520C99AA3; Thu, 11 Mar 2021 09:46:30 +0100 (CET)
Date:   Thu, 11 Mar 2021 09:46:30 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, tglx@linutronix.de,
        john.ogness@linutronix.de, urezki@gmail.com, ast@fb.com,
        Eric Dumazet <edumazet@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hugetlb: select PREEMPT_COUNT if HUGETLB_PAGE for
 in_atomic use
Message-ID: <YEnY5hWLT/en7kw1@hirez.programming.kicks-ass.net>
References: <20210311021321.127500-1-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311021321.127500-1-mike.kravetz@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2021 at 06:13:21PM -0800, Mike Kravetz wrote:
> from irq context.  Changing the check in the code from !in_task to
> in_atomic would handle the situations when called with irqs disabled.

It does not. local_irq_disable() does not change preempt_count().
