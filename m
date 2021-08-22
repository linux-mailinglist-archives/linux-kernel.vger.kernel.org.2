Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503623F3EC5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 10:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbhHVI5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 04:57:49 -0400
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:52918 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231147AbhHVI5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 04:57:48 -0400
Received: from omf20.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 179F0837F24A;
        Sun, 22 Aug 2021 08:57:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf20.hostedemail.com (Postfix) with ESMTPA id B9EDD18A600;
        Sun, 22 Aug 2021 08:57:05 +0000 (UTC)
Message-ID: <8afa5f3847a18ab15005614903646da822c1267a.camel@perches.com>
Subject: Re: [PATCH] vsprintf and docs: Add X to %ph for upper case output
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 22 Aug 2021 01:57:04 -0700
In-Reply-To: <CAHp75Vdyms1O+GLFDNn+P0CswbCnk8=XR4t2OBex8i-KuuD9Pg@mail.gmail.com>
References: <6abd83d11f1daa3094f82e92843e8279f302e349.camel@perches.com>
         <CAHp75Vdh2CP9n0FrU+6nkmzVWKoKD6RN-RGv7Z+UD_KUoFXPfw@mail.gmail.com>
         <12a41a13f8d03a16c3d5c20710a901c090b7d244.camel@perches.com>
         <CAHp75Vdyms1O+GLFDNn+P0CswbCnk8=XR4t2OBex8i-KuuD9Pg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: B9EDD18A600
X-Stat-Signature: wgy1553wk4biasi49qfz8yjj6b44wkmz
X-Spam-Status: No, score=-1.34
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18rAtfRSpKbw6o4poblu2d7KN68o7P98rA=
X-HE-Tag: 1629622625-21147
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2021-08-22 at 11:53 +0300, Andy Shevchenko wrote:
> On Sun, Aug 22, 2021 at 11:45 AM Joe Perches <joe@perches.com> wrote:
> > On Sun, 2021-08-22 at 11:31 +0300, Andy Shevchenko wrote:
> > > On Sun, Aug 22, 2021 at 6:00 AM Joe Perches <joe@perches.com> wrote:
> > > > 
> > > > Uppercase hex output of small char arrays is moderately frequently used.
> > > > Add a mechanism to support the %*ph output as uppercase using 'X'.
> > > 
> > > Besides the fact of existing hex_asc_upper_*(), what ABI (!) uses
> > > this? If none, I dunno we need this.
> > > And show at least a few users where we gain something after conversion.
> > > 
> > 
> > There are at least a few uses that could be converted.
> 
> Provide a series then!
> 
> ...
> 
> > +       return snprintf(buf, 16 * 2 + 2, "%16phNX\n", sn);
> 
> > +       return scnprintf(buffer, PAGE_SIZE, "%16phNX\n", unique_id);
> 
> I think you need to convert to sysfs_emit() in both cases.

First things first...

