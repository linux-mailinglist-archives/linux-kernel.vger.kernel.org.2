Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475A845D291
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 02:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353206AbhKYBvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 20:51:18 -0500
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]:47582 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S238517AbhKYBtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 20:49:10 -0500
Received: from omf16.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C15191848AB03;
        Thu, 25 Nov 2021 01:45:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf16.hostedemail.com (Postfix) with ESMTPA id 2B70351A;
        Thu, 25 Nov 2021 01:45:57 +0000 (UTC)
Message-ID: <3530db0aa97eed41553ae94da6c99c8979c41cad.camel@perches.com>
Subject: Re: [RFC] printk: More consistent loglevel for continuous lines
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 24 Nov 2021 17:45:57 -0800
In-Reply-To: <YZ7enboRQprct49o@google.com>
References: <20211124154838.5415-1-pmladek@suse.com>
         <YZ7enboRQprct49o@google.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.83
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 2B70351A
X-Stat-Signature: 8zmr8yw31pnt1izp1i7pfj3ctf6nhwo5
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19kOlRXHfUIO0KHguxctVlq1FCd26cE0rM=
X-HE-Tag: 1637804757-559198
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-11-25 at 09:53 +0900, Sergey Senozhatsky wrote:
> On (21/11/24 16:48), Petr Mladek wrote:
> > 
> > Anyway, it looks a bit non-practical to update all existing pr_cont()
> > callers:
> > 
> > 	$> git grep "pr_cont" | wc -l
> > 	2054
> 
> Another question is how many pr_cont()-s are getting compiled with
> the "average" production kernel config. A number of pr_cont() is in
> debugging code - lockdep, kasan, etc. - which is not compiled for prod.

This was Linus' attempt to make KERN_CONT meaningful again when it
was IMO a slightly different issue to fix bare printks.

Linus changed the few bare printks that mattered to him at the time.

So the existing bare printk's should also be inspected.

There are still many hundreds of those bare printks around.

$ git grep -P '\bprintk\s*\(\s*(?!KERN_[A-Z]+)\s*"' | wc -l
6863

But most all of those are in really old and effectively dead code.

To approximately answer to the question of how many pr_cont's and
bare printks are getting compiled in an x86-64 config:

$ make defconfig
$ make clean
$ make
$ find . -name '*.o' | sed 's/\.o$/\.c/' | \
  xargs git grep -P '(\bprintk\s*\(\s*(?!KERN_[A-Z]+)|\bpr_cont\b|\bprintk\s*\(\s*KERN_CONT)' -- | \
  wc -l
518



