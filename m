Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F013F6C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 02:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbhHYA37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 20:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhHYA36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 20:29:58 -0400
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E22C061757
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 17:29:13 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1mIgmy-0001eD-O3; Tue, 24 Aug 2021 20:29:08 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id 48C3056006F; Tue, 24 Aug 2021 20:29:08 -0400 (EDT)
Date:   Tue, 24 Aug 2021 20:29:08 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: 5.14-rc breaks iotop swap io monitoring.
Message-ID: <20210825002908.GA16064@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
References: <20210824031648.GA2725@codemonkey.org.uk>
 <YSSuVO47ieWDfWMQ@hirez.programming.kicks-ass.net>
 <20210824151943.GA386@codemonkey.org.uk>
 <CAHk-=wiRe=JBK85HG7xtXH1XbOWcO1KYW8csuWfLuFoHKTqF0w@mail.gmail.com>
 <20210824213342.GA1708@codemonkey.org.uk>
 <CAHk-=wg8XonsSN1SXjpSh3pO3-+EMZvdkb1xwJbLpZxCT2=thQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg8XonsSN1SXjpSh3pO3-+EMZvdkb1xwJbLpZxCT2=thQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Note: SpamAssassin invocation failed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 04:26:59PM -0700, Linus Torvalds wrote:
 > >  > What happens if you boot with the 'delayacct' kernel parameter.
 > >  >
 > > Yeah that boot option does make iotop work again.
 > 
 > Ok, so it's that delay allocation thing is it.
 > 
 > I'm inclined to let it be and see if somebody else notices, and how
 > big of a deal it is.
 >
 > The 'delayacct' kernel command line is an acceptable workaround if
 > this is something only a few people will even notice or care about.
 > 
 > I wonder how much people care about some statistics and iotop these days.
 > 
 > I also assume the swap stats still show up in "vmstat" etc, and that
 > it's just that iotop ended up using fancier interfaces?

afaict, vmstat is fine (though none of my machines are using swap, so
they're just reporting 0)

	Dave

