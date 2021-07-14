Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B983C9370
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 23:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbhGNV72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 17:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhGNV71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 17:59:27 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0772D61362;
        Wed, 14 Jul 2021 21:56:34 +0000 (UTC)
Date:   Wed, 14 Jul 2021 17:56:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [GIT PULL] tracing: Add __string_len() and __assign_str_len()
 helpers
Message-ID: <20210714175633.3b53346a@oasis.local.home>
In-Reply-To: <CAHk-=wj5Pp5J-CAPck22RSQ13k3cEOVnJHUA-WocAZqCJK1BZw@mail.gmail.com>
References: <20210713171143.7784697e@oasis.local.home>
 <CAHk-=wj5Pp5J-CAPck22RSQ13k3cEOVnJHUA-WocAZqCJK1BZw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 12:20:47 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Jul 13, 2021 at 2:11 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Add macros for the TRACE_EVENT() macro that can be used to assign strings
> > that either need to be truncated, or have no nul terminator, and depends
> > on a length attribute to assign.  
> 
> I pulled this, but then I looked at the actual patch, and decided it's
> not acceptable.
> 
> > +#define __assign_str_len(dst, src, len)                                                \
> > +       strncpy(__get_str(dst), (src) ? (const char *)(src) : "(null)", len);   \
> > +       __get_str(dst)[len] = '\0';  
> 
> I can see so many problems in the above that it's not even funny.

It's part of the ugliness of the TRACE_EVENT() macro helpers, as these
macros should never be used outside of the TP_fast_assign() logic.
They're internal helper macros, that have a lot of assumptions. It's
probably time to add a bunch of comments to them.

> 
> Maybe all users would end up avoiding the pitfalls, but the above
> really is disgusting.
> 
> And yes, there's a pre-existing multi-statement macro without any
> grouping, but that's not an excuse for doing more of them, and doing
> them badly.

Adding the "do { } while(0)" is probably a good idea here. I haven't
thought it necessary because of the limited use cases. But I have seen
people get crazy inside the TP_fast_assign(), so it probably should be
included. But other than that, I don't see any issues.

> 
> And by "badly" I mean - among other things - the questionable NUL
> termination that *overflows* the size that was specified, but also
> using strncpy() at all.
> 
> Hint: use strscpy instead of re-implementing it badly. If you really
> want the crazy NUL padding that strncpy does - which I doubt you do -
> use strscpy_pad(), making it explicit.

Note, the source is guaranteed to be a smaller buffer than the
destination. The destination is allocated to len + 1, we only want to
copy the full source string, which does not have a terminating '\0',
and add it to a string that we will add a terminating '\0' too.

In other words, strscpy is not any better, because we have to add one
more anyway.

If you look at how that is allocated, we have:

+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, (len) + 1)


That "(len)+1" adds the extra byte for the '0'. Hence, it is similar to:

	dst = kmalloc(len + 1, GFP_KERNEL);
	strncpy(dst, src, len);
	dst[len] = '\0';

Where the requirement is that you want to save len bytes of source into
dst, where len must be at least the size of src.

The use case for such a thing is:

TRACE_EVENT(foo,
	TP_PROTO(const char *foobar, int len),
	TP_STRUCT__entry(
		__string_len(	str,	foobar,		len)
	),
	TP_fast_assign(
		__assign_str_len(str, foobar, len);
	),
	TP_printk("str=%s", __get_str(str))
);


This creates the event "foo" where in the kernel proper, you have:

	trace_foo(myfoo, myfoo_len);

Where myfoo_len, is known to be all the characters to copy from myfoo
(where myfoo has no terminator)

The TRACE_EVENT macro turns into:

 I manually substituted the __string_len() and __assign_str_len() macros
 to show what the functions end up as.

(created by the macro magic in include/trace/trace_events.h)


// trace_event_get_offsets_foo is used to calculate the dynamic fields
// of the trace event, and figure out where they will be located.

static inline notrace int trace_event_get_offsets_foo(
	struct trace_event_data_offsets_foo *__data_offsets, const char *foobar, int len)
{
	int __data_size = 0;
	int __maybe_unused __item_length;
	struct trace_event_raw_foo __maybe_unused *entry;

// The "(len)+1" will be used to calculate the __item_length below

	__item_length = (len + 1) * sizeof(char);

// the dynamic fields (strings and such) are located after the static
// fields in the trace event, and the offset is recorded in the bottom
// 16 bits of a 32 bit word, and the size in the top 16 bits.

	__data_offsets->item = __data_size +
			       offsetof(typeof(*entry), __data);
	__data_offsets->item |= __item_length << 16;
	__data_size += __item_length;


// Each "__string_len()" or "__string()" in the TP_STRUCT__entry is inserted
// into this macro created function. Thus, the above code is duplicated for
// each field that uses __string(), __string_len() or __dynamic_array().


	return __data_size;
}

#define __get_str(str)	\
		((void *)__entry + (__entry->__data_loc_str & 0xffff))

// The trace_event_raw_event_foo() is called by the trace_foo()
// when the trace foo event is enabled (via static branch).

static notrace void
trace_event_raw_event_foo(void *__data, const char **foobar, int len)
{
	struct trace_event_file *trace_file = __data;
	struct trace_event_data_offsets_foo __maybe_unused __data_offsets;
	struct trace_event_buffer fbuffer;
	struct trace_event_raw_foo *entry;
	int __data_size;

// First the size is calculated from the above code to find out how much
// needs to be allocated on the ring buffer.

	__data_size = trace_event_get_offsets_foo(&__data_offsets, foobar, len);

	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
				 sizeof(*entry) + __data_size);

	if (!entry)
		return;

// The below is the __assign_str_len() that is in the TP_fast_assign() which
// is expanded here.

	strncpy(__get_str(str), (foorbar) ? (const char *)(foobar) : "(null)", len);
	__get_str(str)[len] = '\0';

// The above will not overflow, as the caller is expected to pass in a len
// that has fewer than or equal to characters of the string (or that is a bug).
// The destination was allocated as len + 1, so it will not overflow

	trace_event_buffer_commit(&fbuffer);
}

There is no overflow, because the __string_len() automatically
allocated len+1, and len is used here.

I agree that for __assign_str_len() that it should have a do { }
while(0) because someone could have:

	TP_fast_assign(
		if (len > 10)
			__assign_str_len(str, foobar, 10);
		else
			__assign_str_len(str, foobar, len);

and this would break with the current logic.

I admit TRACE_EVENT() logic is rather ugly, but it was done this way to
make it really easy to create events, otherwise, people would need to
do all this by hand, and that would be difficult and error prone. The
fact that we have over 1000 events proves that it was easy ;-)

But, besides wrapping the __assign_str_len() in a do { } while (0), I
don't see an overflow or other bug in this code.

-- Steve

