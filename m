Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF5F3F8A93
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 16:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237853AbhHZO7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 10:59:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:49812 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbhHZO7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 10:59:50 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 359A8222A0;
        Thu, 26 Aug 2021 14:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629989942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LlngO2XtBN9Z6E5LGlEiMJXvHx+ew4KQpu73GXvjyS4=;
        b=dKvZNEZOC38s/Q8ec8unUBMIQqK2jIzWDmQupyuzePOYR2FDUPaYcQPFhXfDxPvjqCnnXI
        LLHYFIjOdvln9tFxRZwTjGh7aLc92q1qGwwlyOC0fgGXXvWvfKjTq02BVhR7XZsSlp+V4w
        B1bYsZ+2Z+lEpdq8YsXcwo59o/rxjnw=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EA707A3B8F;
        Thu, 26 Aug 2021 14:59:01 +0000 (UTC)
Date:   Thu, 26 Aug 2021 16:58:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] kernel: in_irq() cleanup
Message-ID: <YSesMuP/2y3OfdqB@alley>
References: <20210813145101.85782-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813145101.85782-1-changbin.du@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2021-08-13 22:51:01, Changbin Du wrote:
> Replace the obsolete and ambiguos macro in_irq() with new
> macro in_hardirq().
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>   # for vsprintf.c

But the rest looks good as well.

Best Regards,
Petr
