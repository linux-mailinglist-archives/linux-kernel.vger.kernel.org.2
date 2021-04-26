Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8892636AF7B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 10:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbhDZIL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 04:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbhDZILG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 04:11:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BB7C061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 01:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=54e8KxTlMxMNItn0tucnFhc4T1kLMt7mf/+cwXF6rQg=; b=lv9+6O7hiCWac6G54xjYSCCb7t
        hdEq/UVSvFYaL5NMavLSqLYCm61jY8vqpeBQ0A6OMaGTiFLk384RkO/pN0Gfsgvga0p0d0arXYIPD
        sWkkOgPz9zIiouzvyyKmcMTJL8tmw//dK9CHi1ckVWfk/dMgKBUHqSu8YK9DhBcU/NJSxZYILExXp
        hQhXLRCwvxfy/0wFd+GE+T9Bn94kO92f2rTzqA5qbjSnZz3g6M63FK2ShClAlRha+e6G77dKGXxpn
        qedZxMxoHSEqlId5I2XA68FwSajufOujJZiHgoQ2WEW4i9Mf0If++PKgONN15d/6t3GHOb29UhWvh
        mgM4yzKA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lawJP-005Lvz-MP; Mon, 26 Apr 2021 08:09:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F1A0300212;
        Mon, 26 Apr 2021 10:09:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 100FD2C988F39; Mon, 26 Apr 2021 10:09:47 +0200 (CEST)
Date:   Mon, 26 Apr 2021 10:09:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ed Tsai <ed.tsai@mediatek.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org, stanley.chu@mediatek.com,
        loda.chou@mediatek.com
Subject: Re: [PATCH 1/1] sched: remove the redundant 'success' in the sched
 tracepoint
Message-ID: <YIZ1S1+dyLwVDeqS@hirez.programming.kicks-ass.net>
References: <20210422122226.9415-1-ed.tsai@mediatek.com>
 <20210422114629.2b1ea3ad@gandalf.local.home>
 <0fd8e103cc2886724979f7d93066b86b773032eb.camel@mediatek.com>
 <20210425175426.23f292a9@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210425175426.23f292a9@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 25, 2021 at 05:54:26PM -0400, Steven Rostedt wrote:
> On Fri, 23 Apr 2021 08:38:22 +0800
> Ed Tsai <ed.tsai@mediatek.com> wrote:
> 
> > On Thu, 2021-04-22 at 11:46 -0400, Steven Rostedt wrote:
> > > On Thu, 22 Apr 2021 20:22:26 +0800
> > > Ed Tsai <ed.tsai@mediatek.com> wrote:
> > >   
> > > > 'success' is left here for a long time and also it is meaningless
> > > > for the upper user. Just remove it.  
> > > 
> > > Have you tested all userspace code that might use this?
> > > 
> > > This is the "poster boy" example of why Peter Zijlstra hates trace
> > > events ;-)
> > > 
> > > I know I've updated trace-cmd to check to see if this field exits
> > > before
> > > depending on it, but there may be some other tools that may not.
> > > Perhaps
> > > nothing will break.
> > > 
> > > I'm all for this change, but be ware, it might be reverted if there's
> > > some
> > > tool out that that expects it to exist. This is why it hasn't been
> > > removed.
> > > 
> > > -- Steve  
> > 
> > It is left here over 5 years. Old userspace code need this entry and
> > also someone may use it for a new tool. I hate this but it is a problem
> > should be resolved for the kernel or ignore just fine.
> > 
> 
> I'm willing to take this, with a note that if anyone complains, it may
> be reverted. But as it goes with Linus's rule about breaking user
> space. If you break user space, and nobody notices, you didn't really
> break it!

LatencyTop was I think the offender at the time, but I can't really
remember. Anyway, glad to be rid of it, if we get away with it that is
;-)
