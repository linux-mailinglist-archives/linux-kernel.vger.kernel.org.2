Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56FD3B87C4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 19:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbhF3Rf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 13:35:57 -0400
Received: from smtprelay0017.hostedemail.com ([216.40.44.17]:34280 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229852AbhF3Rfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 13:35:55 -0400
Received: from omf19.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 89441182CF669;
        Wed, 30 Jun 2021 17:33:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 049E120D751;
        Wed, 30 Jun 2021 17:33:24 +0000 (UTC)
Message-ID: <d3cf5de00a7ac017ae70d4cba58c1d93defd5491.camel@perches.com>
Subject: Re: [PATCH 2/3] checkpatch: tweak extern in C warning
From:   Joe Perches <joe@perches.com>
To:     jim.cromie@gmail.com
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 30 Jun 2021 10:33:23 -0700
In-Reply-To: <CAJfuBxz7DMfFOwyvUvN7F9Jc=meQs7ro5OFhiycq1GxMNHRPzw@mail.gmail.com>
References: <20210626034016.170306-1-jim.cromie@gmail.com>
         <20210626034016.170306-3-jim.cromie@gmail.com>
         <b8758249e142da8c2db9920e4cf71596ff7f9570.camel@perches.com>
         <CAJfuBxz7DMfFOwyvUvN7F9Jc=meQs7ro5OFhiycq1GxMNHRPzw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.90
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 049E120D751
X-Stat-Signature: xm9jujjg5nouzutkfi3xgywfn19nrebb
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19VdBI13MJr65OEhEVChqywAUzcvQcQSJE=
X-HE-Tag: 1625074404-837417
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2021-06-26 at 21:47 -0600, jim.cromie@gmail.com wrote:
> On Sat, Jun 26, 2021 at 12:46 PM Joe Perches <joe@perches.com> wrote:
> > On Fri, 2021-06-25 at 21:40 -0600, Jim Cromie wrote:
> > > The extern-in-C rule has one important exception: the symbol is
> > > defined in/by the linker script.  By convention, these almost always
> > > contain: _start, _stop, _end.  Suppress the warning on such symbols.
> > []
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > []
> > > @@ -6910,7 +6910,8 @@ sub process {
> > >                   $stat =~ /^.\s*extern\s+/)
> > >               {
> > >                       WARN("AVOID_EXTERNS",
> > > -                          "externs should be avoided in .c files\n" .  $herecurr);
> > > +                          "externs should be avoided in .c files\n($stat)\n" .  $herecurr)
> > > +                         unless $stat =~ /_start|_stop|_end/;
> > 
> > nak.
> > 
> > As far as I can tell, there's no reason these symbols
> > should not be in .h files.
> 
> judging from the codebase, it has been a case-by-case decision,
> with 8/10 of the linker-vars extern'd into C files, not headers.
[]
> > besides that:
> > 
> > output is single line, $stat should not be used and
> > using unless is not desired.
> > 
> 
> could you clarify ?
> style issues are easy, std if form...
> $stat is already used, it must contain extern to get here.

Sure, it's used as part of a test but it's never output as part of
an error message.  $stat strips any leading '+' from the 2nd and
subsequent lines.

There's a mechanism used in several other tests to show these lines.

				my $cnt = statement_rawlines($stat);
				my $herectx = get_stat_here($linenr, $cnt, $here);

with the output of $herectx.

> checking it for a likely-linker-symbol seems fair.


