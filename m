Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013B3400197
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349462AbhICO5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:57:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233407AbhICO5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:57:09 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A4AA6023B;
        Fri,  3 Sep 2021 14:56:08 +0000 (UTC)
Date:   Fri, 3 Sep 2021 10:56:07 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yury Norov <yury.norov@gmail.com>, Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/vsprintf: add __putchar()
Message-ID: <20210903105607.35af6674@gandalf.local.home>
In-Reply-To: <YSuNTVh17CxUNxtC@smile.fi.intel.com>
References: <20210827171155.700434-1-yury.norov@gmail.com>
        <YSuNTVh17CxUNxtC@smile.fi.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Aug 2021 16:36:13 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Aug 27, 2021 at 10:11:55AM -0700, Yury Norov wrote:
> > There are 26 occurrences of the code snippet like this in the file :
> > 	if (buf < end)
> > 	        *buf = separator;
> > 	++buf;
> > 
> > This patch adds a helper function __putchar() to replace opencoding.
> > It adds a lot to readability, and also saves 43 bytes of text on x86.  
> 
> Last time I tried similar it failed the compilation.
> 
> Anyway, while you remove a lot of code I'm not sure it makes the code better
> to read and understand. Also, we use the same idiom outside of this file.
> 
> I would ask Rasmus' opinion on this.
> 

I actually like the clean up, although I haven't reviewed the entire patch.

If it is used outside this file, perhaps it should be in a header instead
and those other locations should be updated accordingly.

-- Steve
