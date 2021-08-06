Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8F493E2F33
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 20:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242816AbhHFSVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 14:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbhHFSVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 14:21:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2738EC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Aug 2021 11:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Wl5Kv86ynkllD9kxckp+jLjrVHROzccsIwB9+Ndc/Zg=; b=hVl/2faKlL84Gg7r0t9LcFcYW+
        9vCS/Vzrs8zdIyZ4UXY/pLXJeslVpjPCZIrMG2p41SDkm/biTe5++/HjrAi//cKzVVwACbWhXhFQU
        fhizS6+ky1YL3BwbUA9KTlZW4yExzrDYMqZ0rsAcZze9W5W3KLVIJixaZYmMwlS4CVOS41n5luuWd
        wGRECAuTcAqhsrawqCKsNOCiQViI7ad8tetqV0OEi7hrxXn77q2MyI3UxF7b5jVJ4yjtGrSdZ5Q29
        bkSRuPTYLFFDu1QE0H+5ai5hBks/h+L947zVX4yKfsbpiJILy0a9zL8ZmW/rA5SFlBhZKXwhW0HGt
        2bsY/7CA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mC4Sg-006QWe-Ry; Fri, 06 Aug 2021 18:20:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA22C98632E; Fri,  6 Aug 2021 20:20:49 +0200 (CEST)
Date:   Fri, 6 Aug 2021 20:20:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] notifier: Make atomic_notifiers use raw_spinlock
Message-ID: <20210806182049.GC2184@worktop.programming.kicks-ass.net>
References: <20210806140718.mxss3cbqijfebdo5@linutronix.de>
 <20210806180242.GB2184@worktop.programming.kicks-ass.net>
 <20210806180653.mohdmxgrt6h3valt@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806180653.mohdmxgrt6h3valt@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2021 at 08:06:53PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-08-06 20:02:42 [+0200], Peter Zijlstra wrote:
> > On Fri, Aug 06, 2021 at 04:07:18PM +0200, Sebastian Andrzej Siewior wrote:
> > > What do we do with this?
> > > Do we merge this as-is, add another "robust atomic notifier" using only
> > > raw_spinlock_t for registration and notification (for only
> > > cpu_pm_notifier_chain) instead of switching to raw_spinlock_t for all
> > > atomic notifier in -tree?
> > 
> > Right, so the problem I see with this is that
> > notifier_chain_{,un}register() are O(n). Hardly something we should be
> > putting under raw_spin_lock :/
> 
> Yup, pretty much. So we make one robust notifier for
> cpu_pm_notifier_chain?

Yeah, I suppose so :-( Ideally that whole pm notifier thing goes, but
that's *far* more work and I really don't want to be responsible for the
brain damange resulting from looking at all that 'special' idle code.
