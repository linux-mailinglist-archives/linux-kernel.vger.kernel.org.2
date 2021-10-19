Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C31C4335E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 14:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235638AbhJSM2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 08:28:23 -0400
Received: from smtprelay0090.hostedemail.com ([216.40.44.90]:45042 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235533AbhJSM2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 08:28:22 -0400
Received: from omf07.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B7607100CD86D;
        Tue, 19 Oct 2021 12:26:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id C18ED315D74;
        Tue, 19 Oct 2021 12:26:06 +0000 (UTC)
Message-ID: <4c6a85a4934ef977eee07fb7e38b07b8061bfce4.camel@perches.com>
Subject: Re: [PATCH] staging: vt6655: Fix line wrapping in rf.c file
From:   Joe Perches <joe@perches.com>
To:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 19 Oct 2021 05:26:05 -0700
In-Reply-To: <810a4e29b0c54520a30cae4d37fde0a59ea3d83b.camel@gmail.com>
References: <20211018150526.9718-1-karolinadrobnik@gmail.com>
         <YW2O3wC8wMEKS3Ub@kroah.com>
         <84f3c940fedb961e6e7e88d47c3d15e598bc32c3.camel@perches.com>
         <810a4e29b0c54520a30cae4d37fde0a59ea3d83b.camel@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C18ED315D74
X-Spam-Status: No, score=-2.90
X-Stat-Signature: 87uixfj7rnyqhe7tuq9g4m97zeze61wg
X-Rspamd-Server: rspamout01
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1//BRstIUjWag0uUzgJvaEENDABgRIeRoI=
X-HE-Tag: 1634646366-419216
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-10-19 at 11:59 +0100, Karolina Drobnik wrote:
> Hi,
> 
> Thank you very much for your comments.
> 
> On Mon, 2021-10-18 at 17:12 +0200, Greg KH wrote:
> > Also, these are all just fine as-is for now.  A better way to make
> > these lines smaller is to use better variable and function names 
> > that are shorter and make sense :)
> 
> I have v2 ready but I'm not sure, given the Joe's patch, if my solution
> is a satisfactory one. I didn't jump on such refactoring as I'm still
> learning about the codebase/process and didn't want to muddle the
> waters (...more than I do already).
> 
> Greg, what would you prefer? Should I back up with my patch, pick
> something else and let Joe's patch be merged?

What I suggested is not a patch it's just an example.

There's quite a lot of code in that driver that _could_
be updated/refined/refactored (none of which _I_ will
submit), but it's up to you do whatever _you_ want.

You could:

o remove the Hungarian notation
o convert the mixed case variables to snake case
o remove unnecessary function definitions and make them static
o refactor various functions

Generally, I prefer refactoring code to make it simpler or
more like the generally preferred kernel styles.

Another option would be to submit a completely new driver for
this device based on this existing driver as what's there isn't
particularly great IMO, but read the vt6655 TODO file and see if
there's something you actually want to do there.

> Also, I have a question about the patch if that's ok :)

It's OK to ask.

> On Mon, 2021-10-18 at 22:56 -0700, Joe Perches wrote:
> > Maybe some refactoring like:
> > ---
[]
> > diff --git a/drivers/staging/vt6655/rf.c
[]
> > +       uChannel--;
> 
> I see that you introduced `uChannel--` to further tidy up the lines
> with `[uChannel - 1]`. In general, is there anything wrong with
> indexing like `i - 1`?

Depends on how often it's used and if it's ever missed accidentally.

> What's the preference here? DRY things up as much as possible?

Up to you

> I'm asking because when I was reading this line, at first, it wasn't
> clear to me why we could decrement it (example though: "Was this
> modified earlier? Do we need to "correct" it?").

Generally, just try to make code clear for a reader.

When you do that, the compiler will also do a better job
at what it does.

If you look at the callers of the function, see if it's better
to decrement the argument instead.

