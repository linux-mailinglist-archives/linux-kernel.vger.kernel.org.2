Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0796B399475
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 22:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhFBUVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 16:21:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:49832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhFBUVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 16:21:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 84ABB600D4;
        Wed,  2 Jun 2021 20:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622665187;
        bh=KB2GKW9SrbmTXxENdtwpzdj5V5Jp/dfe70z3tJI18og=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=d5z912FEDHYB5+BJiGs0e82WgopzuuRFLZcJeDpO7M5myYuS9w8Cse2FpQ1DoVgsx
         wpPHyRt4LdPJwly4UMn4BgPxQKtdRPUgyhqKPdPybnaZOcy3CPgeblmPkt7EBJ1iob
         qe4FlVegDQAiMOON+qiSJlWeRbylc0L8QdLVRzGYeJ+1JhVWpUosZLX65PbXmYwvvX
         P21jca3JNvVpCmvQMQDTBIfNxYIoBSmho8BayML1FkGZnbSUsAB2H7gNLlgJiKU8mJ
         Lg/fjPvNsm/7k7Ns+xa5iVz8wljfRowsCHAyU5whNOiYwx9VyP3KiUHl1hihE9noDn
         2QfczPJJY7R9w==
Date:   Wed, 2 Jun 2021 22:19:40 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        Lepton Wu <ytht.net@gmail.com>, Mel Gorman <mgorman@suse.de>,
        Qais Yousef <qais.yousef@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Kitt <steve@sk2.org>, Wang Qing <wangqing@vivo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] docs: accounting: update delay-accounting.rst
 reference
Message-ID: <20210602221940.7e0a6135@coco.lan>
In-Reply-To: <871r9k6rmy.fsf@meer.lwn.net>
References: <cover.1622648507.git.mchehab+huawei@kernel.org>
        <629b0bd21d02c8faef9a6d17d9eee8ff612715e0.1622648507.git.mchehab+huawei@kernel.org>
        <YLe0BQcrnfRgH1dV@hirez.programming.kicks-ass.net>
        <20210602200121.64a828a1@coco.lan>
        <871r9k6rmy.fsf@meer.lwn.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 2 Jun 2021 20:29:23 +0200
Peter Zijlstra <peterz@infradead.org> escreveu:

> > Peter Zijlstra <peterz@infradead.org> escreveu:
> >   
> > > On Wed, Jun 02, 2021 at 05:43:13PM +0200, Mauro Carvalho Chehab wrote:  
> 
> > > >  Enables/disables task delay accounting (see
> > > > -:doc:`accounting/delay-accounting.rst`). Enabling this feature incurs
> > > > +:doc:`/accounting/delay-accounting`). Enabling this feature incurs    
> > > 
> > > This breaks any chance of using 'goto file' like features in text
> > > editors :/   
> > 
> > This is a feature of your favorite text editor. Not all have it.  
> 
> Afaict both vim (gf) and emacs (M-x ffap) can do this. That covers about
> 99% of all sane editors no? :-)

Heh, not quite ;-) Here, I use nano(/pico), from the old times where 
(al)pine was my emailer. I can live with vim, but I prefer an editor
that starts in editing mode.

I tried to use emacs a few times, but my fingers are too much into
pico/nano control keys, so it was ending by making me typing a lot
slower. Besides that, nano works well on 99% of my daily needs. 

When I need more fancy, like regex substitutions, changing/moving
big code blocks, editing multiple files at the same time, etc, 
then I just use a GUI editor (currently kate, but seeking for
a good replacement, as some changes during F33 times - still 
present on F34 - caused some regressions).

Em Wed, 02 Jun 2021 12:36:05 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> > That's said, automarkup.py has a rule to convert Documentation/<foo>.rst
> > into :doc:`<foo>`. So, an alternative approach would be to convert
> > treewide all :doc:`<foo>` into Documentation/<foo>.rst and add something 
> > at checkpatch.pl to recommend to avoid :doc: notation.  
> 
> That seems like the right approach to me.  We have the automarkup
> capability, we might as well make use of it...

Ok, I'll prepare a separate patch series addressing it. 

-

Jon,

With regards to the :doc: -> Documentation/ conversion, I guess I'll
do it on an independent patch series against your docs-next tree.

Then, I'll send a separate patch series after 5.14-rc1 in order to
address the stuff under linux-next.

Thanks,
Mauro
