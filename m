Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72A236A99F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Apr 2021 23:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231373AbhDYVzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Apr 2021 17:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231231AbhDYVzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Apr 2021 17:55:08 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6B67611ED;
        Sun, 25 Apr 2021 21:54:27 +0000 (UTC)
Date:   Sun, 25 Apr 2021 17:54:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ed Tsai <ed.tsai@mediatek.com>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <stanley.chu@mediatek.com>, <loda.chou@mediatek.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/1] sched: remove the redundant 'success' in the sched
 tracepoint
Message-ID: <20210425175426.23f292a9@oasis.local.home>
In-Reply-To: <0fd8e103cc2886724979f7d93066b86b773032eb.camel@mediatek.com>
References: <20210422122226.9415-1-ed.tsai@mediatek.com>
        <20210422114629.2b1ea3ad@gandalf.local.home>
        <0fd8e103cc2886724979f7d93066b86b773032eb.camel@mediatek.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2021 08:38:22 +0800
Ed Tsai <ed.tsai@mediatek.com> wrote:

> On Thu, 2021-04-22 at 11:46 -0400, Steven Rostedt wrote:
> > On Thu, 22 Apr 2021 20:22:26 +0800
> > Ed Tsai <ed.tsai@mediatek.com> wrote:
> >   
> > > 'success' is left here for a long time and also it is meaningless
> > > for the upper user. Just remove it.  
> > 
> > Have you tested all userspace code that might use this?
> > 
> > This is the "poster boy" example of why Peter Zijlstra hates trace
> > events ;-)
> > 
> > I know I've updated trace-cmd to check to see if this field exits
> > before
> > depending on it, but there may be some other tools that may not.
> > Perhaps
> > nothing will break.
> > 
> > I'm all for this change, but be ware, it might be reverted if there's
> > some
> > tool out that that expects it to exist. This is why it hasn't been
> > removed.
> > 
> > -- Steve  
> 
> It is left here over 5 years. Old userspace code need this entry and
> also someone may use it for a new tool. I hate this but it is a problem
> should be resolved for the kernel or ignore just fine.
> 

I'm willing to take this, with a note that if anyone complains, it may
be reverted. But as it goes with Linus's rule about breaking user
space. If you break user space, and nobody notices, you didn't really
break it!

-- Steve


