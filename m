Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3910C3993B8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFBTph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:45:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:44350 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229489AbhFBTph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:45:37 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jun 2021 15:45:37 EDT
Received: (qmail 1998 invoked by uid 109); 2 Jun 2021 19:37:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Jun 2021 19:37:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20393 invoked by uid 111); 2 Jun 2021 19:37:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Jun 2021 15:37:11 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Jun 2021 15:37:10 -0400
From:   Jeff King <peff@peff.net>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     git@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: git feature request: git blame --ignore-cleanup/--ignore-trivial
Message-ID: <YLfd5pWtRqde1++Y@coredump.intra.peff.net>
References: <30399052.5964.1622647235870.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <30399052.5964.1622647235870.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 11:20:35AM -0400, Mathieu Desnoyers wrote:

> Considering the added value brought by splitting cleanups from functional changes
> from a maintainer perspective (easier reverts) and from a reviewer perspective
> (easier to focus on the functional changes), I think it would be good to improve
> the git tooling to allow easily filtering out the noise from git blame.
> 
> Perhaps a new git blame "--ignore-trivial" and/or "--ignore-cleanup" could solve
> this by filtering out "trivial" and "cleanup" patches from the history it considers.

There's "-w" to ignore whitespace-only changes. Since Git v2.23.0,
there's also "--ignore-rev-file", which lets you ignore arbitrary
commits. Since you have to generate a separate list of commits to feed
it, it's a little more involved than your "--invert-grep" example. But
it's also much more flexible (you can generate the file however you
like, and even tweak it by hand).

I do tend to agree with Al's notion that commits which are _supposed_ to
be trivial sometimes end up not being so. Or another way of thinking
about it is: relevance is a property of the query you're making, not the
original change.

So IMHO the best tool for this kind of thing is the "re-blame from
parent" feature that many interactive blame viewers have (I use tig, but
I'm sure other tools like magic have a similar feature). There when you
land on a boring commit, it's a single key to skip past it and see how
the earlier code came about.

-Peff
