Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D72736401A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 13:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbhDSLCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 07:02:49 -0400
Received: from smtprelay0118.hostedemail.com ([216.40.44.118]:35932 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237833AbhDSLCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 07:02:42 -0400
Received: from omf11.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 17BD018020DA3;
        Mon, 19 Apr 2021 11:02:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf11.hostedemail.com (Postfix) with ESMTPA id 2016120A295;
        Mon, 19 Apr 2021 11:02:10 +0000 (UTC)
Message-ID: <8cddfac598fb0ef3c10d583fc70a5ebf1c8aeddc.camel@perches.com>
Subject: Re: [PATCH v5] printk: Userspace format enumeration support
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, kernel-team@fb.com
Date:   Mon, 19 Apr 2021 04:02:08 -0700
In-Reply-To: <YH1TIebAQyiMPuvI@kroah.com>
References: <YEgvR6Wc1xt0qupy@chrisdown.name>
         <02c3b2f3-ff8e-ceb9-b30b-e533959c0491@rasmusvillemoes.dk>
         <YFDAfPCnS204jiD5@chrisdown.name> <YFHAdUB4lu4mJ9Ar@alley>
         <5ea3b634-5467-35cf-dd08-1001f878b569@rasmusvillemoes.dk>
         <YFMvfawY+0CncS8G@alley> <YHmXi303WxVZzVwI@chrisdown.name>
         <e9f74575-1ba0-0c06-b370-59d151c72ed6@rasmusvillemoes.dk>
         <YH1Kex8NOr89BJXq@alley> <YH1TIebAQyiMPuvI@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=1.60
X-Rspamd-Server: rspamout02
X-Stat-Signature: f8tx41ti33ixk61gc7rgse56fbagbfns
X-Rspamd-Queue-Id: 2016120A295
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+ecAu86kQ+6gE4zOHZP4JWVjjxPmJUBcc=
X-HE-Tag: 1618830130-112912
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-04-19 at 11:53 +0200, Greg Kroah-Hartman wrote:
> Hm, 12734 of the pr_err() calls do live in drivers/, so most of those
> should be dev_err().  Might be something good to throw at interns...

That depends on how much churn you want to have in old drivers that
generally don't have any users because the hardware is ancient or
no longer manufactured.

I suggest not changing those.

But I believe a coccinelle script was written quite awhile ago
to convert pr_<level> to dev_<level> when a struct device * is
available.

http://btrlinux.inria.fr/staging-media-replace-pr_-with-dev_/


