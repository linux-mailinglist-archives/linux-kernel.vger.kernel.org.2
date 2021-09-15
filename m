Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CBB40BDF4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 05:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234650AbhIODB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 23:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229834AbhIODBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 23:01:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5B35E6115B;
        Wed, 15 Sep 2021 03:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631674820;
        bh=rF1cgOkMET1rIM6rMMdpESe+7st4aaHFxdm5yWI68Zs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u4IXpGMxoGm4NvcpUe1lstICSKXxZu8NuQ3f7bj9bJ2SystiOAJuJUAqrAum4kGaR
         z3WAt9P3IjXg7zqjfn77UAIhaV5hoT6qVWvsXJ0MwJIxGmXIL2RtEyCf8UtkOx4RbL
         2Fx2aVB/LdbcVOAat6Pz6e+R8FYD08fqsQuvzpcT7lTAqAhdkO33TIbF0jDvx3gVDS
         kF1nOGE0TPRjwn4nQgp+lOt1DI+rLZJy8+70TCdmA9ANfKWMY2xvxTI+nosASZutfJ
         YjetClMOUTQR2/JIwb92YcD/McgSNJulIbOZVPiuXWxw7sMv8nCc47T8Nq7jvHE0Kc
         bXPggH1RzJagA==
Date:   Wed, 15 Sep 2021 12:00:17 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v2 5/5] tools/bootconfig: Define memblock_free_ptr() to
 fix build error
Message-Id: <20210915120017.a694a43cf7464b4010b39927@kernel.org>
In-Reply-To: <CAHk-=wg3bPXCmV3k6Znffnx=zZPFh+jcANujf8DZx6MsHLxS3g@mail.gmail.com>
References: <163166717752.510331.12843735095061762373.stgit@devnote2>
        <163166721835.510331.4931010992364519157.stgit@devnote2>
        <CAHk-=whsAk7u0arWz37YbCyQPZgKfKOhrM1oKp+0B9uJk6J9OQ@mail.gmail.com>
        <20210915104718.135cb7393fb63bd8140105a2@kernel.org>
        <CAHk-=wg3bPXCmV3k6Znffnx=zZPFh+jcANujf8DZx6MsHLxS3g@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 18:57:34 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Sep 14, 2021 at 6:47 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > Hmm, OK. Let me copy lib/bootconfig.c itself into tools/bootconfig
> > as a user-space code.
> 
> Well, or we need to have some really good way to mark these shared files.
> 
> Normally I don't think we share any *.c files with tooling, and
> tooling copies over the *.h files it needs. Is this the only one?

What I need to share is lib/bootconfig.c and include/linux/bootconfig.h.
Those provides bootconfig APIs and parser.

But since bootconfig.c uses some kernel APIs, I made wrapper
header files. If I can add #ifdefs to split the parser and APIs
from those part (as you can see 90% of code doesn't need kernel
APIs), I think I don't need any wrappers to include the file
(instead of copying bootconfig.c).

> So yes, copying the *.c file in this case would match what we do for
> the header files, but particularly if there are others, maybe we could
> have something like the "uapi" directory that allows people to
> explicialy share files with the tools.

OK.

> But it would need to be very explicit in the pathname, so that people
> would have that big warning sign of "hey, now you're editing a file
> that is shared with tooling".
> 
> That has worked at least _somewhat_ with include/uapi/ and arch/*/include/uapi/.

Hmm, what about lib/uapi/bootconfig.c ?

Thank you,

> 
>          Linus


-- 
Masami Hiramatsu <mhiramat@kernel.org>
