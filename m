Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5C5A3231BB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 21:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232563AbhBWUCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 15:02:19 -0500
Received: from verein.lst.de ([213.95.11.211]:34953 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231650AbhBWUCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 15:02:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 15B4468D0A; Tue, 23 Feb 2021 21:01:31 +0100 (CET)
Date:   Tue, 23 Feb 2021 21:01:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jessica Yu <jeyu@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?utf-8?B?77+8TWlyb3NsYXY=?= Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.12
Message-ID: <20210223200130.GA8059@lst.de>
References: <YDUibKAt5tpA1Hxs@gunter> <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com> <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com> <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 11:55:50AM -0800, Linus Torvalds wrote:
> On Tue, Feb 23, 2021 at 10:42 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I think there is something horribly wrong in my tree, and my build
> > process is now about 30% slower. It went from 5+ minutes to 8+
> > minutes. The main suspect would be some lack of parallelism.
> 
> I don't see quite what is wrong, but bisection is clear, and points
> the finger at
> 
>     367948220fce "module: remove EXPORT_UNUSED_SYMBOL*"
> 
> which looks entirely trivial, but clearly isn't.
> 
> It's repeatable. That commit slows down my build hugely.

Does your build now enable TRIM_UNUSED_KSYMS but previously didn't by
chance?

> 
>               Linus
---end quoted text---
