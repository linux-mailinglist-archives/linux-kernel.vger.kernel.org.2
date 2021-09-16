Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 074FA40D3C8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 09:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhIPHag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 03:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhIPHae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 03:30:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A66EC061574;
        Thu, 16 Sep 2021 00:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6+0oJHkC1WPybChCSiGgjurT2CwvEQ/aq6741k0XJjc=; b=ope2r8fq7aD8JVQ8vGaKdo0Z9I
        ai4abU8HGTFUAyfOvjV4ev+Hyfp+iqHaUw5GU6O+bmhP4+rCBVoO7FmHf9JfRPovQOLbSANkpKHSW
        zw+kMH3rdobOtDxlHx1sjw4+/WpwmZmtrjSHNwk+ujoLgTm6iIsrkxAuBVg5sjZTln42AnMu9DyrN
        MRsEabgCvHXmgHmfzfmDOlpufHeITGcWwmaMXG+DPjYg5cb8tI9dbUqgyDTyYjw4O8LrK0FTYLr+T
        Zs0XvcOZXPrCXMLl6aLXQe+XgcL9fqEzUxo7WEiB82dBc73BiL7OgzHUSBUpPmOYPF5dPI14LyVvo
        ZtsbMhcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mQlp9-003bQU-DF; Thu, 16 Sep 2021 07:28:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A0247300093;
        Thu, 16 Sep 2021 09:28:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 712E4200A5E23; Thu, 16 Sep 2021 09:28:45 +0200 (CEST)
Date:   Thu, 16 Sep 2021 09:28:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, mingo@kernel.org, jiangshanlai@gmail.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH rcu 10/14] rcu: Make rcutree_dying_cpu() use its "cpu"
 parameter
Message-ID: <YULyLRwSJ6jj1bTF@hirez.programming.kicks-ass.net>
References: <20210915233305.GA3906641@paulmck-ThinkPad-P17-Gen-1>
 <20210915233343.3906738-10-paulmck@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915233343.3906738-10-paulmck@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2021 at 04:33:39PM -0700, Paul E. McKenney wrote:
> The CPU-hotplug functions take a "cpu" parameter, but rcutree_dying_cpu()
> ignores it in favor of this_cpu_ptr().  This works at the moment, but
> it would be better to be consistent.  This might also work better given
> some possible future changes.  This commit therefore uses per_cpu_ptr()
> to avoid ignoring the rcutree_dying_cpu() function's argument.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

I think even in the old days dying and starting ran on the affected CPU,
and I don't ever see that changing.

Then again, none of this is hot-path in any way, so *meh* :-)
