Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94A3341BB2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 12:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhCSLn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 07:43:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:35660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229806AbhCSLnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 07:43:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1616154234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6XavM+VwOLTEyzDfW0LHTRkD6JR3SUxqoyIvE6dwWw0=;
        b=PBigIA6gqdnbUdaBaEJ7C1obmLo7EwCX4sGPjPWGEsM3tYFAJcgCPe/oDgbp86P2Lcd4nD
        hE0MuASM3hEiIYKgnBYvE12En0LpLtwtPwFcdCY8gWlIr/Jw2SJRdJYHsvJaS2OizZYv88
        XMHvcWTphUn/6e6UU1TzP3dlxRAU2eU=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 177B5AE05;
        Fri, 19 Mar 2021 11:43:54 +0000 (UTC)
Date:   Fri, 19 Mar 2021 12:43:53 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
Message-ID: <YFSOeTrGXBzUkfml@alley>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
 <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
 <YFDAfPCnS204jiD5@chrisdown.name>
 <YFHAdUB4lu4mJ9Ar@alley>
 <5ea3b634-5467-35cf-dd08-1001f878b569@rasmusvillemoes.dk>
 <YFMvfawY+0CncS8G@alley>
 <226a276d-2018-b419-4a6b-3ab21d3e4584@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <226a276d-2018-b419-4a6b-3ab21d3e4584@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2021-03-18 12:31:44, Rasmus Villemoes wrote:
> On 18/03/2021 11.46, Petr Mladek wrote:
> 
> > BTW: Is the trick with int (printk)(const char *s, ...) documented
> > somewhere? Is it portable?
> 
> It is completely standard and portable C, explicitly spelled out in the
> C standard itself. C99:

Thanks a lot for the detailed info.

I still prefer to avoid using this "trick". But I am not going to
block it if more people would prefer it.

Best Regards,
Petr
