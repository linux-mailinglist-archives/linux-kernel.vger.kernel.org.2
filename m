Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041053F95C4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 10:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhH0IJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 04:09:08 -0400
Received: from smtprelay0131.hostedemail.com ([216.40.44.131]:58164 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229934AbhH0IJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 04:09:06 -0400
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id BFC5E22AB5;
        Fri, 27 Aug 2021 08:08:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 7395520A298;
        Fri, 27 Aug 2021 08:08:12 +0000 (UTC)
Message-ID: <18d9f8d6803c8957ec091c207780c163af07e41f.camel@perches.com>
Subject: Re: [PATCH 1/5] vsprintf/Documentation: Add X to %*ph extension to
 output upper case hex
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 27 Aug 2021 01:08:10 -0700
In-Reply-To: <YSiY0aa+C9cyJni4@smile.fi.intel.com>
References: <cover.1630003183.git.joe@perches.com>
         <bc33e306a9064dfbf1180a35f9bfa587c6502eca.1630003183.git.joe@perches.com>
         <YSiY0aa+C9cyJni4@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Stat-Signature: 59ktf3o3pnawonoefr8m9jwr44aeznyf
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7395520A298
X-Spam-Status: No, score=-0.42
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/Xj/j/nAJ4SKNqA3ky0WP/6cqw4QroyOk=
X-HE-Tag: 1630051692-852234
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-08-27 at 10:48 +0300, Andy Shevchenko wrote:
> On Thu, Aug 26, 2021 at 11:43:01AM -0700, Joe Perches wrote:
> > A few sysfs output uses of hex arrays are uppercase and are nominally ABI.
> > 
> > Add a mechanism to the existing vsprintf %*ph hex output extension to
> > support upper case hex output.
> 
> ...
> 
> > +	The preferred output is lowercase
> >  	%*ph	00 01 02  ...  3f
> >  	%*phC	00:01:02: ... :3f
> >  	%*phD	00-01-02- ... -3f
> >  	%*phN	000102 ... 3f
> > +	Formats with X are uppercase, used for backwards compatibility
> > +	%*phX	00 01 02  ...  3F
> > +	%*phCX	00:01:02: ... :3F
> > +	%*phDX	00-01-02- ... -3F
> > +	%*phNX	000102 ... 3F
> 
> Why not using %*pH...?

I find X more intelligible.

> > +	char locase = 0x20;	/* ASCII OR'd for lower case see: number() */
> 
> If you use h vs H, you may derive this from (fmt[...] & SMALL).

It's not necessary to use any more of the rather limited vsprintf
extension namespace.


