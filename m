Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2393680A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 14:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236593AbhDVMim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 08:38:42 -0400
Received: from smtprelay0048.hostedemail.com ([216.40.44.48]:50868 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236074AbhDVMh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 08:37:29 -0400
Received: from omf14.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 1D57A182CF66E;
        Thu, 22 Apr 2021 12:36:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id 21CC1268E40;
        Thu, 22 Apr 2021 12:36:51 +0000 (UTC)
Message-ID: <54e5b0ab49002e0dd92e9d44ef62ff08641e330c.camel@perches.com>
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
From:   Joe Perches <joe@perches.com>
To:     Chris Down <chris@chrisdown.name>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Date:   Thu, 22 Apr 2021 05:36:50 -0700
In-Reply-To: <YIAlM2jXadciFfGW@chrisdown.name>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
         <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
         <YFDAfPCnS204jiD5@chrisdown.name> <YFHAdUB4lu4mJ9Ar@alley>
         <5ea3b634-5467-35cf-dd08-1001f878b569@rasmusvillemoes.dk>
         <YFMvfawY+0CncS8G@alley> <YHmXi303WxVZzVwI@chrisdown.name>
         <e9f74575-1ba0-0c06-b370-59d151c72ed6@rasmusvillemoes.dk>
         <YIAlM2jXadciFfGW@chrisdown.name>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 21CC1268E40
X-Spam-Status: No, score=1.60
X-Stat-Signature: ta4atm7m4gohrhg3sxc4e9wigtd5uyth
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19zmJnCWRJ0LeuLU9AFz9xbikk9wNEd7ZI=
X-HE-Tag: 1619095011-313763
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-04-21 at 14:14 +0100, Chris Down wrote:
> Rasmus Villemoes writes:
> > > One (ugly) way to handle this would be to have a new "level" field in
> > > the printk index entry, with semantics that if it's some sentinel value,
> > > look at the format itself for the format, otherwise if it's some other
> > > value, the level field itself is the level.
> > > 
> > > This will work, but it's pretty ugly. Any better suggestions? :-)
> > 
> > Well, that was more or less exactly what I suggested when I wrote
> > 
> > > One could also record the function a format is being used with - without
> > > that, the display probably can't show a reasonable <level> for those
> > > dev_* function.
> > 
> > But, I think the real question is, why are we/you interested in the
> > level at all? Isn't the format string itself enough for the purpose of
> > tracking which printks have come and gone? IOW, what about, on the
> > display side, simply skipping over some KERN_* prefix if present?
[]
> Judging by the conversation there's no immediately obvious better way, so 
> unless you or Petr object, I'll send a patch in the v6 series which implements 
> the "ugly" way with dev_printk support as the first user. That should make it 
> easier to add other printk-likes in future as needed.

There are dozens of these types of printks extensions in the kernel.
Today, your test case .config uses btrfs which has its own too.

You really should evaluate the utility of log level monitoring and
reconsider adding some compiler extension use of __printf to generate
this format tracking ability.


