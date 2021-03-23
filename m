Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044763458D8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCWHhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCWHhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:37:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F524C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hNa8GWEFXrTRVC0OdCCWR8WzHJzwy0rEwo3851VyTJ4=; b=qRTsMPhA4kdwJZJ0Xfr0eIoFMr
        JoDH1zZOh3Crt74HguOFjgttoHgzwTc+f5BrfSQXrGZi8mN9C66dFHH9ObkdfN8kmPXB7CD61UZg5
        ZJkPMYnIL5iAg3ZSH0xuyGBGe3g0Hb14Jdn4aPXQC0Y0sSobEZNSjouYfopFsJ3LEzBQiVqf6IShp
        yEism55VznO61u92T4VpjkpAfbnePlhukLrDoVP5FtjT+43OuGBkrqoBvopD/fnrts9pLLAOeg+x6
        03EjdWgzzrIgxMO+iCiAFJAw9N6N8Rp5aACkHdBdYEdQk8eBaUXUF9HuSRM0OMgCalRCO5ht/D/PQ
        iaZGACFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lOba6-009jAr-QN; Tue, 23 Mar 2021 07:36:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EE8D73010C8;
        Tue, 23 Mar 2021 08:35:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D348D2BE708BA; Tue, 23 Mar 2021 08:35:59 +0100 (CET)
Date:   Tue, 23 Mar 2021 08:35:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] static_call: fix function type mismatch
Message-ID: <YFmaXxwcAb9bPchv@hirez.programming.kicks-ass.net>
References: <20210322170711.1855115-1-arnd@kernel.org>
 <20210322153214.25d869b1@gandalf.local.home>
 <YFkCZuOwe37d2bV+@hirez.programming.kicks-ass.net>
 <CAK8P3a2sz4emewH_HA+nsf0e5tP6qtAxhBOFucmzW4OPDJASdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2sz4emewH_HA+nsf0e5tP6qtAxhBOFucmzW4OPDJASdQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 10:18:17PM +0100, Arnd Bergmann wrote:

> > Steve is correct. Also, why is that warning correct? On x86 we return in
> > RAX, and using int will simply not inspect the upper 32 bits there.
> 
> I think the code works correctly on all architectures we support because
> both 'int' and 'long' are returned in a register with any unused bits cleared.
> It is however undefined behavior in C because 'int' and 'long' are not
> compatible types, and the calling conventions don't have to allow this.

Then please kill the warning, it's bullshit.

> > And I'm fairly sure I had a pointer user somewhere recently.
> 
> I've only tested my series with 5.12-rc so far, but don't get any other
> such warnings. Maybe it's in linux-next?

No, it's in Linus' tree, see commit:

  c8e2fe13d1d1 ("x86/perf: Use RET0 as default for guest_get_msrs to handle "no PMU" case")
