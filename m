Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D50F37EB6C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380272AbhELTaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344607AbhELRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 13:02:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B834EC061348
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 09:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1JP4F+Z9+TEOr0TNcfdbm6Mnb1AommIz0iuHgy4wIgg=; b=ozvazW/OivZjzHfhztUO7Vh79y
        +cMUKNxfW6aohgg2DRwMyadT/ggbxJ4ENcHNY/4vE22QX9TNy43WLrgdkbUCPO9kh8JSuzdpuVXjF
        sVDR8AJ8jZUVXFuAnGaC9KtcUz6gHRk3uGnV/+2znI1DXu/saAVJuSLZZjddIjSdtrgWIalarFWm/
        gA94+HU19Lv0x4rVNpmX7dfjV5OPpXzZQTf+vXBkgORipr9djg9/47+I0ohteMt4XKsiqgbicCRwF
        zGVlY9mdU2N68XgLDW+IogRRa0co7Y7j0RGn+wa557RQUOE9B1HGYMsLQFWRcDKIWVp4uLktpEzbV
        vtj2ok4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lgs7s-003OE0-BP; Wed, 12 May 2021 16:54:24 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8B1C33001E1;
        Wed, 12 May 2021 18:54:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7907528B39B05; Wed, 12 May 2021 18:54:19 +0200 (CEST)
Date:   Wed, 12 May 2021 18:54:19 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Leo Yan <leo.yan@linaro.org>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/lockdep: Correct calling tracepoints
Message-ID: <YJwIO4h9FaRdrC0o@hirez.programming.kicks-ass.net>
References: <20210512120937.90211-1-leo.yan@linaro.org>
 <YJvL+IvlTtoNv2c7@hirez.programming.kicks-ass.net>
 <20210512093202.5fca1259@gandalf.local.home>
 <YJvgreWRNgkloeuh@hirez.programming.kicks-ass.net>
 <20210512111439.5f80f707@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512111439.5f80f707@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 12, 2021 at 11:14:39AM -0400, Steven Rostedt wrote:
> On Wed, 12 May 2021 16:05:33 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Thing is, if you look at the list copy:
> > 
> >   https://lore.kernel.org/lkml/20200821085348.782688941@infradead.org/
> > 
> > things were okay. I suspect there was a conflict at some point and
> > resolution got it backwards because the hunks are so similar and I never
> > noticed :/
> 
> Was this a git merge issue or a quilt merge issue ?

Probably quilt, I never do anything like that with git.
