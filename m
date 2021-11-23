Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDA045A7D4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 17:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237047AbhKWQg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 11:36:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:42864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236736AbhKWQgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 11:36:14 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2F6D60F9D;
        Tue, 23 Nov 2021 16:33:05 +0000 (UTC)
Date:   Tue, 23 Nov 2021 11:33:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Greg KH <greg@kroah.com>
Cc:     linux-kernel@vger.kernel.org, stable-commits@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: Patch "tracing: Add length protection to histogram string
 copies" has been added to the 5.4-stable tree
Message-ID: <20211123113304.19da789b@gandalf.local.home>
In-Reply-To: <YZzaazoMzw8eANyR@kroah.com>
References: <20211121231943.88009-1-sashal@kernel.org>
        <YZzaazoMzw8eANyR@kroah.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2021 13:11:23 +0100
Greg KH <greg@kroah.com> wrote:

> On Sun, Nov 21, 2021 at 06:19:42PM -0500, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     tracing: Add length protection to histogram string copies
> > 
> > to the 5.4-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      tracing-add-length-protection-to-histogram-string-co.patch
> > and it can be found in the queue-5.4 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> > 
> > 
> > commit 0a0e233a0c25593f817b6d9ed48fb2d2fd080870
> > Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > Date:   Sun Nov 14 13:28:34 2021 -0500
> > 
> >     tracing: Add length protection to histogram string copies
> >     
> >     [ Upstream commit 938aa33f14657c9ed9deea348b7d6f14b6d69cb7 ]
> >     
> >     The string copies to the histogram storage has a max size of 256 bytes
> >     (defined by MAX_FILTER_STR_VAL). Only the string size of the event field
> >     needs to be copied to the event storage, but no more than what is in the
> >     event storage. Although nothing should be bigger than 256 bytes, there's
> >     no protection against overwriting of the storage if one day there is.
> >     
> >     Copy no more than the destination size, and enforce it.
> >     
> >     Also had to turn MAX_FILTER_STR_VAL into an unsigned int, to keep the
> >     min() comparison of the string sizes of comparable types.
> >     
> >     Link: https://lore.kernel.org/all/CAHk-=wjREUihCGrtRBwfX47y_KrLCGjiq3t6QtoNJpmVrAEb1w@mail.gmail.com/
> >     Link: https://lkml.kernel.org/r/20211114132834.183429a4@rorschach.local.home
> >     
> >     Cc: Ingo Molnar <mingo@kernel.org>
> >     Cc: Andrew Morton <akpm@linux-foundation.org>
> >     Cc: Tom Zanussi <zanussi@kernel.org>
> >     Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> >     Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> >     Fixes: 63f84ae6b82b ("tracing/histogram: Do not copy the fixed-size char array field over the field size")
> >     Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>  
> 
> This commit causes a bunch of build warnings, so odds are the backport
> is incorrect.
> 
> I'll drop it from the 5.4.y queue now.

Well, the above doesn't apply for me to 5.4, but the following appears to
work:

commit 0a0e233a0c25593f817b6d9ed48fb2d2fd080870
Author: Steven Rostedt (VMware) <rostedt@goodmis.org>
Date:   Sun Nov 14 13:28:34 2021 -0500

    tracing: Add length protection to histogram string copies
    
    [ Upstream commit 938aa33f14657c9ed9deea348b7d6f14b6d69cb7 ]
    
    The string copies to the histogram storage has a max size of 256 bytes
    (defined by MAX_FILTER_STR_VAL). Only the string size of the event field
    needs to be copied to the event storage, but no more than what is in the
    event storage. Although nothing should be bigger than 256 bytes, there's
    no protection against overwriting of the storage if one day there is.
    
    Copy no more than the destination size, and enforce it.
    
    Also had to turn MAX_FILTER_STR_VAL into an unsigned int, to keep the
    min() comparison of the string sizes of comparable types.
    
    Link: https://lore.kernel.org/all/CAHk-=wjREUihCGrtRBwfX47y_KrLCGjiq3t6QtoNJpmVrAEb1w@mail.gmail.com/
    Link: https://lkml.kernel.org/r/20211114132834.183429a4@rorschach.local.home
    
    Cc: Ingo Molnar <mingo@kernel.org>
    Cc: Andrew Morton <akpm@linux-foundation.org>
    Cc: Tom Zanussi <zanussi@kernel.org>
    Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
    Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
    Fixes: 63f84ae6b82b ("tracing/histogram: Do not copy the fixed-size char array field over the field size")
    Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
    Signed-off-by: Sasha Levin <sashal@kernel.org>

Index: linux-test.git/include/linux/trace_events.h
===================================================================
--- linux-test.git.orig/include/linux/trace_events.h
+++ linux-test.git/include/linux/trace_events.h
@@ -425,7 +425,7 @@ struct trace_event_file {
 
 #define PERF_MAX_TRACE_SIZE	2048
 
-#define MAX_FILTER_STR_VAL	256	/* Should handle KSYM_SYMBOL_LEN */
+#define MAX_FILTER_STR_VAL	256U	/* Should handle KSYM_SYMBOL_LEN */
 
 enum event_trigger_type {
 	ETT_NONE		= (0),
Index: linux-test.git/kernel/trace/trace_events_hist.c
===================================================================
--- linux-test.git.orig/kernel/trace/trace_events_hist.c
+++ linux-test.git/kernel/trace/trace_events_hist.c
@@ -3521,8 +3521,10 @@ static inline void __update_field_vars(s
 		if (val->flags & HIST_FIELD_FL_STRING) {
 			char *str = elt_data->field_var_str[j++];
 			char *val_str = (char *)(uintptr_t)var_val;
+			unsigned int size;
 
-			strscpy(str, val_str, STR_VAR_LEN_MAX);
+			size = min(val->size, STR_VAR_LEN_MAX);
+			strscpy(str, val_str, size);
 			var_val = (u64)(uintptr_t)str;
 		}
 		tracing_map_set_var(elt, var_idx, var_val);

-- Steve

