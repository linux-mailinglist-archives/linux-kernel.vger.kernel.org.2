Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859EB3CBE50
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 23:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbhGPVVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 17:21:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:52532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234405AbhGPVVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 17:21:03 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E69D613CC;
        Fri, 16 Jul 2021 21:18:07 +0000 (UTC)
Date:   Fri, 16 Jul 2021 17:18:05 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] tracing: histogram fix and take 2 on the
 __string_len() marcros
Message-ID: <20210716171805.55aed9de@oasis.local.home>
In-Reply-To: <CAHk-=wjWosrcv2=6m-=YgXRKev=5cnCg-1EhqDpbRXT5z6eQmg@mail.gmail.com>
References: <20210715215753.4a314e97@rorschach.local.home>
        <CAHk-=wiWdG6jqKhdU62b06-DtESVxHVK8MA23iV+6fB5hnGEAw@mail.gmail.com>
        <20210716143705.56001390@oasis.local.home>
        <CAHk-=wjWosrcv2=6m-=YgXRKev=5cnCg-1EhqDpbRXT5z6eQmg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 11:45:57 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Fri, Jul 16, 2021 at 11:37 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >
> > So how do you want this implemented?
> >
> > #define __assign_str_len(dst, src, len)                                 \
> >         do {                                                            \
> >                 strscpy(__get_str(dst), (src) ? (const char *)(src) : "(null)", len); \
> >                 __get_str(dst)[len] = '\0';
> 
> What? That "__get_str(dst)[len] = '\0';" is pointless and wrong.

I wrote up explanations to all this, and when I finally went to show an
example of where this would be used, I found a major bug, that
questions whether this is needed or not.

Chuck, WTH!

This feature was going to be used by Chuck, because he said he had strings
that had to be saved that did not have terminating nul bytes.

For example, he has:

fs/nfsd/trace.h:

> DECLARE_EVENT_CLASS(nfsd_clid_class,
> 	TP_PROTO(const struct nfsd_net *nn,
> 		 unsigned int namelen,
> 		 const unsigned char *namedata),
> 	TP_ARGS(nn, namelen, namedata),

Above, namedata supposedly has no terminating '\0' byte,
and namelen is the number of characters in namedata.

> 	TP_STRUCT__entry(
> 		__field(unsigned long long, boot_time)
> 		__field(unsigned int, namelen)
> 		__dynamic_array(unsigned char,  name, namelen)

__dynamic_array() allocates __entry->name on the ring buffer of namelen
bytes.

Where my patch would add instead:

		__string(name, namelen)

Which would allocate __entry->name on the ring buffer with "namelen" + 1
bytes.


> 	),
> 	TP_fast_assign(
> 		__entry->boot_time = nn->boot_time;
> 		__entry->namelen = namelen;
> 		memcpy(__get_dynamic_array(name), namedata, namelen);

The above is basically the open coded version of my __assign_str_len(),
where we could use.

		__assign_str_len(name, namedata, namelen);

instead.

> 	),
> 	TP_printk("boot_time=%16llx nfs4_clientid=%.*s",
> 		__entry->boot_time, __entry->namelen, __get_str(name))
> )


With my helpers, Chuck would no longer need this "%.*s", and pass in
__entry->namelen, because, the __assign_str_len() would have added the
'\0' terminating byte,  and "%s" would be sufficient.

But this isn't the example I original used. The example I was going to
use questions Chuck's use case, and was this:

> TRACE_EVENT(nfsd_dirent,
> 	TP_PROTO(struct svc_fh *fhp,
> 		 u64 ino,
> 		 const char *name,
> 		 int namlen),
> 	TP_ARGS(fhp, ino, name, namlen),
> 	TP_STRUCT__entry(
> 		__field(u32, fh_hash)
> 		__field(u64, ino)
> 		__field(int, len)
> 		__dynamic_array(unsigned char, name, namlen)
> 	),
> 	TP_fast_assign(
> 		__entry->fh_hash = fhp ? knfsd_fh_hash(&fhp->fh_handle) : 0;
> 		__entry->ino = ino;
> 		__entry->len = namlen;
> 		memcpy(__get_str(name), name, namlen);

Everything up to here is the same as above, but then there's ...

> 		__assign_str(name, name);

WTH! Chuck, do you know the above expands to:

	strcpy(__get_str(name), (name) ? (const char *)(name) : "(null)");

If "name" does not have a terminating '\0' byte, this would crash hard.

Even if it did have that byte, the __dynamic_array() above only
allocated "namelen" bytes, and that did not include the terminating
byte, which means you are guaranteed to overflow.

It may not have crashed for you if name is nul terminated, because the
ring buffer rounds up to 4 byte alignment,  and you may have had some
extra bytes to use at the end of the event allocation.

But this makes me question if name is really not terminated, and is
this patch actually necessary.

> 	),
> 	TP_printk("fh_hash=0x%08x ino=%llu name=%.*s",
> 		__entry->fh_hash, __entry->ino,
> 		__entry->len, __get_str(name))
> )

I'm dropping this patch for now, and will send another pull request
with just the histogram bug fix.

Thanks,

-- Steve
