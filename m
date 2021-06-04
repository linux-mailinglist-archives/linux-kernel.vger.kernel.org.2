Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF6939B14C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 06:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbhFDEVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 00:21:42 -0400
Received: from smtprelay0049.hostedemail.com ([216.40.44.49]:60632 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229452AbhFDEVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 00:21:41 -0400
Received: from omf05.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 2A43F180A55E1;
        Fri,  4 Jun 2021 04:19:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id 3D999B2795;
        Fri,  4 Jun 2021 04:19:52 +0000 (UTC)
Message-ID: <1e068d21106bb6db05b735b4916bb420e6c9842a.camel@perches.com>
Subject: Re: [PATCH V3 7/9] tracing: Add __print_ns_to_secs() and
 __print_ns_without_secs() helpers
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org
Date:   Thu, 03 Jun 2021 21:19:50 -0700
In-Reply-To: <20210603172902.41648183@gandalf.local.home>
References: <cover.1621024265.git.bristot@redhat.com>
         <2c59beee3b36b15592bfbb9f26dee7f8b55fd814.1621024265.git.bristot@redhat.com>
         <20210603172902.41648183@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3D999B2795
X-Spam-Status: No, score=-0.90
X-Stat-Signature: 5t93p93qdgp44jy6mg3at4bsag6b3te5
X-Rspamd-Server: rspamout03
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19AEbHkhP1XrqS3t2H/RM7OUQRY2pqJ5Co=
X-HE-Tag: 1622780392-643404
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-06-03 at 17:29 -0400, Steven Rostedt wrote:
> > +++ b/include/trace/trace_events.h
> > @@ -358,6 +358,21 @@ TRACE_MAKE_SYSTEM_STR();
> >  	trace_print_hex_dump_seq(p, prefix_str, prefix_type,		\
> >  				 rowsize, groupsize, buf, len, ascii)
> >  
> > 
> > +#undef __print_ns_to_secs
> > +#define __print_ns_to_secs(value)			\
> > +	({						\
> > +		u64 ____val = (u64)value;		\
> > +		do_div(____val, NSEC_PER_SEC);		\
> > +		____val;				\
> > +	})
> 
> I know my name is on this, but we need parenthesis around "value".

If tracing cleanups for trace_events.h are being done, perhaps
another bit of untidiness is the macro definition and uses of
__assign_str.

$ git grep -w -1 __assign_str include/trace/trace_events.h
include/trace/trace_events.h-
include/trace/trace_events.h:#undef __assign_str
include/trace/trace_events.h:#define __assign_str(dst, src)                                             \
include/trace/trace_events.h-   strcpy(__get_str(dst), (src) ? (const char *)(src) : "(null)");

Its definition has a semicolon as do most uses but a dozen handfuls of
other uses do not have a semicolon.  It'd be more consistent to add a
semicolon to the uses without them and when done treewide, then remove
the semicolon from the macro declaration.

$ git grep -P '\b__assign_str\b' | wc -l
551
$ git grep -P '\b__assign_str\b.*;' | wc -l
480

For instance: sunrpc.h has a mixture of uses with and without semicolons.

$ git grep -P '\b__assign_str\b' include/trace/events/sunrpc.h | wc -l
65
$ git grep -P '\b__assign_str\b.*;' include/trace/events/sunrpc.h | wc -l
38

It's especially odd in the last block below to have 3 successive uses
where the first and last has a semicolon, but the middle one does not.

So perhaps as a start:
---
 include/trace/events/sunrpc.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index d02e01a27b690..861f199896c6a 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -154,8 +154,8 @@ TRACE_EVENT(rpc_clnt_new,
 		__entry->client_id = clnt->cl_clid;
 		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
 		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
-		__assign_str(program, program)
-		__assign_str(server, server)
+		__assign_str(program, program);
+		__assign_str(server, server);
 	),
 
 	TP_printk("client=%u peer=[%s]:%s program=%s server=%s",
@@ -180,8 +180,8 @@ TRACE_EVENT(rpc_clnt_new_err,
 
 	TP_fast_assign(
 		__entry->error = error;
-		__assign_str(program, program)
-		__assign_str(server, server)
+		__assign_str(program, program);
+		__assign_str(server, server);
 	),
 
 	TP_printk("program=%s server=%s error=%d",
@@ -284,8 +284,8 @@ TRACE_EVENT(rpc_request,
 		__entry->client_id = task->tk_client->cl_clid;
 		__entry->version = task->tk_client->cl_vers;
 		__entry->async = RPC_IS_ASYNC(task);
-		__assign_str(progname, task->tk_client->cl_program->name)
-		__assign_str(procname, rpc_proc_name(task))
+		__assign_str(progname, task->tk_client->cl_program->name);
+		__assign_str(procname, rpc_proc_name(task));
 	),
 
 	TP_printk("task:%u@%u %sv%d %s (%ssync)",
@@ -494,10 +494,10 @@ DECLARE_EVENT_CLASS(rpc_reply_event,
 		__entry->task_id = task->tk_pid;
 		__entry->client_id = task->tk_client->cl_clid;
 		__entry->xid = be32_to_cpu(task->tk_rqstp->rq_xid);
-		__assign_str(progname, task->tk_client->cl_program->name)
+		__assign_str(progname, task->tk_client->cl_program->name);
 		__entry->version = task->tk_client->cl_vers;
-		__assign_str(procname, rpc_proc_name(task))
-		__assign_str(servername, task->tk_xprt->servername)
+		__assign_str(procname, rpc_proc_name(task));
+		__assign_str(servername, task->tk_xprt->servername);
 	),
 
 	TP_printk("task:%u@%d server=%s xid=0x%08x %sv%d %s",
@@ -622,8 +622,8 @@ TRACE_EVENT(rpc_stats_latency,
 		__entry->task_id = task->tk_pid;
 		__entry->xid = be32_to_cpu(task->tk_rqstp->rq_xid);
 		__entry->version = task->tk_client->cl_vers;
-		__assign_str(progname, task->tk_client->cl_program->name)
-		__assign_str(procname, rpc_proc_name(task))
+		__assign_str(progname, task->tk_client->cl_program->name);
+		__assign_str(procname, rpc_proc_name(task));
 		__entry->backlog = ktime_to_us(backlog);
 		__entry->rtt = ktime_to_us(rtt);
 		__entry->execute = ktime_to_us(execute);
@@ -669,15 +669,15 @@ TRACE_EVENT(rpc_xdr_overflow,
 			__entry->task_id = task->tk_pid;
 			__entry->client_id = task->tk_client->cl_clid;
 			__assign_str(progname,
-				     task->tk_client->cl_program->name)
+				     task->tk_client->cl_program->name);
 			__entry->version = task->tk_client->cl_vers;
-			__assign_str(procedure, task->tk_msg.rpc_proc->p_name)
+			__assign_str(procedure, task->tk_msg.rpc_proc->p_name);
 		} else {
 			__entry->task_id = 0;
 			__entry->client_id = 0;
-			__assign_str(progname, "unknown")
+			__assign_str(progname, "unknown");
 			__entry->version = 0;
-			__assign_str(procedure, "unknown")
+			__assign_str(procedure, "unknown");
 		}
 		__entry->requested = requested;
 		__entry->end = xdr->end;
@@ -735,9 +735,9 @@ TRACE_EVENT(rpc_xdr_alignment,
 		__entry->task_id = task->tk_pid;
 		__entry->client_id = task->tk_client->cl_clid;
 		__assign_str(progname,
-			     task->tk_client->cl_program->name)
+			     task->tk_client->cl_program->name);
 		__entry->version = task->tk_client->cl_vers;
-		__assign_str(procedure, task->tk_msg.rpc_proc->p_name)
+		__assign_str(procedure, task->tk_msg.rpc_proc->p_name);
 
 		__entry->offset = offset;
 		__entry->copied = copied;
@@ -1107,9 +1107,9 @@ TRACE_EVENT(xprt_retransmit,
 		__entry->xid = be32_to_cpu(rqst->rq_xid);
 		__entry->ntrans = rqst->rq_ntrans;
 		__assign_str(progname,
-			     task->tk_client->cl_program->name)
+			     task->tk_client->cl_program->name);
 		__entry->version = task->tk_client->cl_vers;
-		__assign_str(procedure, task->tk_msg.rpc_proc->p_name)
+		__assign_str(procedure, task->tk_msg.rpc_proc->p_name);
 	),
 
 	TP_printk(
@@ -1842,7 +1842,7 @@ TRACE_EVENT(svc_xprt_accept,
 
 	TP_fast_assign(
 		__assign_str(addr, xprt->xpt_remotebuf);
-		__assign_str(protocol, xprt->xpt_class->xcl_name)
+		__assign_str(protocol, xprt->xpt_class->xcl_name);
 		__assign_str(service, service);
 	),
 

