Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63F0032381A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 08:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbhBXHxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 02:53:07 -0500
Received: from verein.lst.de ([213.95.11.211]:36506 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232164AbhBXHxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 02:53:03 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 81C9868D0A; Wed, 24 Feb 2021 08:52:20 +0100 (CET)
Date:   Wed, 24 Feb 2021 08:52:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jessica Yu <jeyu@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?utf-8?B?77+8TWlyb3NsYXY=?= Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [GIT PULL] Modules updates for v5.12
Message-ID: <20210224075220.GA546@lst.de>
References: <YDUibKAt5tpA1Hxs@gunter> <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com> <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com> <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com> <20210223200130.GA8059@lst.de> <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com> <CAHk-=whudLzx0zmn+xLDmC1su6DF4oMQT6uEgjDEq0RsHRsDwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whudLzx0zmn+xLDmC1su6DF4oMQT6uEgjDEq0RsHRsDwA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 23, 2021 at 12:07:39PM -0800, Linus Torvalds wrote:
> On Tue, Feb 23, 2021 at 12:03 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > This is unacceptably slow. If that symbol trimming takes 30% of the
> > whole kernel build time, it needs to be fixed or removed.
> 
> I think I'm going to mark TRIM_UNUSED_KSYMS as "depends on BROKEN".
> There's no way I can accept that horrible overhead, and the rationale
> for that config option is questionable at best,

I think it is pretty useful for embedded setups.

BROKEN seems pretty strong for something that absolutely works as
intendended.  I guess to make you (and possibly others) not grumpy
we just need to ensure it doesn't get pulled in by allmodconfig.

So maybe just invert the symbol, default the KEEP_UNUSED_SYMBOL, and
add a message to the helptext explaining the slowdown?
