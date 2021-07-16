Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CADC03CBBE8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 20:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbhGPSkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:51504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229462AbhGPSkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:40:03 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B13606115B;
        Fri, 16 Jul 2021 18:37:07 +0000 (UTC)
Date:   Fri, 16 Jul 2021 14:37:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [GIT PULL] tracing: histogram fix and take 2 on the
 __string_len() marcros
Message-ID: <20210716143705.56001390@oasis.local.home>
In-Reply-To: <CAHk-=wiWdG6jqKhdU62b06-DtESVxHVK8MA23iV+6fB5hnGEAw@mail.gmail.com>
References: <20210715215753.4a314e97@rorschach.local.home>
        <CAHk-=wiWdG6jqKhdU62b06-DtESVxHVK8MA23iV+6fB5hnGEAw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 11:11:38 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Jul 15, 2021 at 6:57 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > tracing: One fix in the histogram code and another take at the __string_len() macro  
> 
> What part of "strncpy()" is garbage did I not make clear?

So how do you want this implemented?

#define __assign_str_len(dst, src, len)					\
	do {								\
		strscpy(__get_str(dst), (src) ? (const char *)(src) : "(null)", len); \
		__get_str(dst)[len] = '\0';				\
	} while(0)

I could even do:

#define __assign_str_len(dst, src, len)					\
	do {								\
		if (!src && len > 6)					\
			len = 6;					\
		memcpy(__get_str(dst), (src) ? (const char *)(src) : "(null)", len); \
		__get_str(dst)[len] = '\0';				\
	} while(0)

Which would work just as well, although I had to account if len is
greater than "(null)". Which should never happen, but I have it there,
because I copied the code from the __string() version which uses
strlen() and that would break if a null is passed in (which in rare
cases happen). But it would actually be a bug to use __string_len() in
a place that can take a NULL, unless len was zero.

Not sure how the above is any different than using strncpy().

Again, src is a string without a '\0'. What I don't understand is how
strscpy() is any better than strncpy() in this situation?

As I replied to you last time, the dst is created by allocating 'len +
1' on the ring buffer, and len is to be no greater than the number of
characters in src.

The only purpose to use this is to either truncate a string, or to pass
in a string that was read from a memory location that does not have a
terminating '\0' in it, but you know the length of the string. If you
have a normal string, simply use the __string() which uses strlen() to
calculate the required space.

It's basically this:

	dst = malloc(len + 1);
	memcpy(dst, src, len);
	dst[len] = '\0';

"strncpy() is garbage" does not compute to me in the above usage.

-- Steve
