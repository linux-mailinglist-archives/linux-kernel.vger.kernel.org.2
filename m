Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626F13CC066
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 02:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbhGQA6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 20:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230476AbhGQA6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 20:58:07 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5877613C4;
        Sat, 17 Jul 2021 00:55:11 +0000 (UTC)
Date:   Fri, 16 Jul 2021 20:55:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] tracing: histogram fix and take 2 on the
 __string_len() marcros
Message-ID: <20210716205510.7f565b98@oasis.local.home>
In-Reply-To: <26A9CF5A-0724-4D4B-BC59-09849EC33326@oracle.com>
References: <20210715215753.4a314e97@rorschach.local.home>
        <CAHk-=wiWdG6jqKhdU62b06-DtESVxHVK8MA23iV+6fB5hnGEAw@mail.gmail.com>
        <20210716143705.56001390@oasis.local.home>
        <CAHk-=wjWosrcv2=6m-=YgXRKev=5cnCg-1EhqDpbRXT5z6eQmg@mail.gmail.com>
        <20210716171805.55aed9de@oasis.local.home>
        <26A9CF5A-0724-4D4B-BC59-09849EC33326@oracle.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Jul 2021 00:22:52 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:
> >   
> >> 	TP_STRUCT__entry(
> >> 		__field(unsigned long long, boot_time)
> >> 		__field(unsigned int, namelen)
> >> 		__dynamic_array(unsigned char,  name, namelen)  
> > 
> > __dynamic_array() allocates __entry->name on the ring buffer of namelen
> > bytes.
> > 
> > Where my patch would add instead:
> > 
> > 		__string(name, namelen)  
> 
> You mean
> 
>                  __string_len(name, namelen)

Yes.

> 
> 
> > Which would allocate __entry->name on the ring buffer with "namelen" + 1
> > bytes.
> > 
> >   
> >> 	),
> >> 	TP_fast_assign(
> >> 		__entry->boot_time = nn->boot_time;
> >> 		__entry->namelen = namelen;
> >> 		memcpy(__get_dynamic_array(name), namedata, namelen);  
> > 
> > The above is basically the open coded version of my __assign_str_len(),
> > where we could use.
> > 
> > 		__assign_str_len(name, namedata, namelen);
> > 
> > instead.
> >   
> >> 	),
> >> 	TP_printk("boot_time=%16llx nfs4_clientid=%.*s",
> >> 		__entry->boot_time, __entry->namelen, __get_str(name))
> >> )  
> > 
> > 
> > With my helpers, Chuck would no longer need this "%.*s", and pass in
> > __entry->namelen, because, the __assign_str_len() would have added the
> > '\0' terminating byte,  and "%s" would be sufficient.  
> 
> Exactly, I would still like to do this. I've been waiting
> for two months for the __string_len() macros to land.
> 
> 
> > But this isn't the example I original used. The example I was going to
> > use questions Chuck's use case, and was this:
> >   
> >> TRACE_EVENT(nfsd_dirent,
> >> 	TP_PROTO(struct svc_fh *fhp,
> >> 		 u64 ino,
> >> 		 const char *name,
> >> 		 int namlen),
> >> 	TP_ARGS(fhp, ino, name, namlen),
> >> 	TP_STRUCT__entry(
> >> 		__field(u32, fh_hash)
> >> 		__field(u64, ino)
> >> 		__field(int, len)
> >> 		__dynamic_array(unsigned char, name, namlen)
> >> 	),
> >> 	TP_fast_assign(
> >> 		__entry->fh_hash = fhp ? knfsd_fh_hash(&fhp->fh_handle) : 0;
> >> 		__entry->ino = ino;
> >> 		__entry->len = namlen;
> >> 		memcpy(__get_str(name), name, namlen);  
> > 
> > Everything up to here is the same as above, but then there's ...
> >   
> >> 		__assign_str(name, name);  
> > 
> > WTH! Chuck, do you know the above expands to:
> > 
> > 	strcpy(__get_str(name), (name) ? (const char *)(name) : "(null)");
> > 
> > If "name" does not have a terminating '\0' byte, this would crash hard.  
> 
> Yes, it does crash hard. That's why I sent this fix:

OK, that makes me feel better. I really didn't want this argument with
Linus for nothing ;-)

> 
> 7b08cf62b123 ("NFSD: Prevent a possible oops in the nfs_dirent() tracepoint")
> 
> Which is now in v5.14-rc1 (and should be picked soon up by
> automation for backport). I intended to fix nfs_dirent to use
> __string_len() and friends, but you decided to delay adding
> these new macros, and I had to send the above fix instead.
> 
> 
> > Even if it did have that byte, the __dynamic_array() above only
> > allocated "namelen" bytes, and that did not include the terminating
> > byte, which means you are guaranteed to overflow.
> > 
> > It may not have crashed for you if name is nul terminated, because the
> > ring buffer rounds up to 4 byte alignment,  and you may have had some
> > extra bytes to use at the end of the event allocation.
> > 
> > But this makes me question if name is really not terminated, and is
> > this patch actually necessary.  
> 
> Yes, it is necessary to finish this work.
> 
> 
> >> 	),
> >> 	TP_printk("fh_hash=0x%08x ino=%llu name=%.*s",
> >> 		__entry->fh_hash, __entry->ino,
> >> 		__entry->len, __get_str(name))
> >> )  
> > 
> > I'm dropping this patch for now,  
> 
> Please don't drop it. I'm sure these two are not the only uses
> for a proper __string_len(). The point of this exercise is to
> provide helpers that do all of this manipulation correctly so
> that others don't have to take the chance of getting it wrong.
> 
> 

How about this. I'll just give you the patch and you can apply it to
your tree. I updated it with documentation, and use memcpy instead of
strncpy() as it is replacing memcpy() and strncpy() will cause people
to question the code (as Linus has).

Here's my latest patch. Feel free to apply it to your tree. Hopefully
it wont conflict with other work I'm doing. But if it does, we'll work
it out. I don't have any code that relies on it.

-- Steve

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Subject: [PATCH] tracing: Add trace_event helper macros __string_len() and
 __assign_str_len()

There's a few cases that a string that is to be recorded in a trace event,
does not have a terminating 'nul' character, and instead, the tracepoint
passes in the length of the string to record.

Add two helper macros to the trace event code that lets this work easier,
than tricks with "%.*s" logic.

  __string_len() which is similar to __string() for declaration, but takes a
                 length argument.

  __assign_str_len() which is similar to __assign_str() for assiging the
                 string, but it too takes a length argument.

Note, the TRACE_EVENT() macro will allocate the location on the ring
buffer to 'len + 1', that will be used to store the string into. It is a
requirement that the 'len' used for this is a most the length of the
string being recorded.

This string can still use __get_str() just like strings created with
__string() can use to retrieve the string.

Link: https://lore.kernel.org/linux-nfs/20210513105018.7539996a@gandalf.local.home/

Tested-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/trace/trace_events.h               | 22 ++++++++++++++++++
 samples/trace_events/trace-events-sample.h | 27 ++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
index acc17194c160..08810a463880 100644
--- a/include/trace/trace_events.h
+++ b/include/trace/trace_events.h
@@ -102,6 +102,9 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(char, item, -1)
 
@@ -197,6 +200,9 @@ TRACE_MAKE_SYSTEM_STR();
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
@@ -459,6 +465,9 @@ static struct trace_event_functions trace_event_type_funcs_##call = {	\
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
@@ -507,6 +516,9 @@ static struct trace_event_fields trace_event_fields_##call[] = {	\
 #define __string(item, src) __dynamic_array(char, item,			\
 		    strlen((src) ? (const char *)(src) : "(null)") + 1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, (len) + 1)
+
 /*
  * __bitmask_size_in_bytes_raw is the number of bytes needed to hold
  * num_possible_cpus().
@@ -670,10 +682,20 @@ static inline notrace int trace_event_get_offsets_##call(		\
 #undef __string
 #define __string(item, src) __dynamic_array(char, item, -1)
 
+#undef __string_len
+#define __string_len(item, src, len) __dynamic_array(char, item, -1)
+
 #undef __assign_str
 #define __assign_str(dst, src)						\
 	strcpy(__get_str(dst), (src) ? (const char *)(src) : "(null)");
 
+#undef __assign_str_len
+#define __assign_str_len(dst, src, len)					\
+	do {								\
+		memcpy(__get_str(dst), (src), (len));			\
+		__get_str(dst)[len] = '\0';				\
+	} while(0)
+
 #undef __bitmask
 #define __bitmask(item, nr_bits) __dynamic_array(unsigned long, item, -1)
 
diff --git a/samples/trace_events/trace-events-sample.h b/samples/trace_events/trace-events-sample.h
index 13a35f7cbe66..e61471ab7d14 100644
--- a/samples/trace_events/trace-events-sample.h
+++ b/samples/trace_events/trace-events-sample.h
@@ -141,6 +141,33 @@
  *         In most cases, the __assign_str() macro will take the same
  *         parameters as the __string() macro had to declare the string.
  *
+ *   __string_len: This is a helper to a __dynamic_array, but it understands
+ *	   that the array has characters in it, and with the combined
+ *         use of __assign_str_len(), it will allocate 'len' + 1 bytes
+ *         in the ring buffer and add a '\0' to the string. This is
+ *         useful if the string being saved has no terminating '\0' byte.
+ *         It requires that the length of the string is known as it acts
+ *         like a memcpy().
+ *
+ *         Declared with:
+ *
+ *         __string_len(foo, bar, len)
+ *
+ *         To assign this string, use the helper macro __assign_str_len().
+ *
+ *         __assign_str(foo, bar, len);
+ *
+ *         Then len + 1 is allocated to the ring buffer, and a nul terminating
+ *         byte is added. This is similar to:
+ *
+ *         memcpy(__get_str(foo), bar, len);
+ *         __get_str(foo)[len] = 0;
+ *
+ *        The advantage of using this over __dynamic_array, is that it
+ *        takes care of allocating the extra byte on the ring buffer
+ *        for the '\0' terminating byte, and __get_str(foo) can be used
+ *        in the TP_printk().
+ *
  *   __bitmask: This is another kind of __dynamic_array, but it expects
  *         an array of longs, and the number of bits to parse. It takes
  *         two parameters (name, nr_bits), where name is the name of the
-- 
2.31.1

