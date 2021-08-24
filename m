Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542DC3F6B4E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 23:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235603AbhHXVmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 17:42:19 -0400
Received: from scorn.kernelslacker.org ([45.56.101.199]:43442 "EHLO
        scorn.kernelslacker.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbhHXVmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 17:42:12 -0400
X-Greylist: delayed 66273 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Aug 2021 17:42:12 EDT
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1mIe3R-0001GT-2b; Tue, 24 Aug 2021 17:33:57 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id AF50556006F; Tue, 24 Aug 2021 17:33:42 -0400 (EDT)
Date:   Tue, 24 Aug 2021 17:33:42 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: 5.14-rc breaks iotop swap io monitoring.
Message-ID: <20210824213342.GA1708@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20210824031648.GA2725@codemonkey.org.uk>
 <YSSuVO47ieWDfWMQ@hirez.programming.kicks-ass.net>
 <20210824151943.GA386@codemonkey.org.uk>
 <CAHk-=wiRe=JBK85HG7xtXH1XbOWcO1KYW8csuWfLuFoHKTqF0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiRe=JBK85HG7xtXH1XbOWcO1KYW8csuWfLuFoHKTqF0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 09:34:02AM -0700, Linus Torvalds wrote:
 > On Tue, Aug 24, 2021 at 8:19 AM Dave Jones <davej@codemonkey.org.uk> wrote:
 > >
 > > On Tue, Aug 24, 2021 at 10:31:16AM +0200, Peter Zijlstra wrote:
 > >  >
 > >  > If you need DELAYACCT I'm thinking:
 > >  >
 > >  >   e4042ad49235 ("delayacct: Default disabled")
 > >  >
 > >  > and
 > >  >
 > >  >   0cd7c741f01d ("delayacct: Add sysctl to enable at runtime")
 > >
 > > That does sound more relevant. however, even after echo 1  > /proc/sys/kernel/task_delayacct,
 > > it still fails in the same way.
 > 
 > Hmm.
 > 
 > What happens if you boot with the 'delayacct' kernel parameter.
 > 
 > Even if you enable it at run-time, processes that have been started
 > before it was enabled won't actually have the 'tsk->delays'
 > allocation. So I'm not sure how effective the run-time thing is.

Yeah that boot option does make iotop work again.

	Dave

