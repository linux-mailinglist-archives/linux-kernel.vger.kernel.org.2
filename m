Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCBF4253EB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241042AbhJGNW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:34188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233155AbhJGNWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:22:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34B2E61248;
        Thu,  7 Oct 2021 13:20:28 +0000 (UTC)
Date:   Thu, 7 Oct 2021 09:20:26 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     William Cohen <wcohen@redhat.com>
Cc:     mingo@redhat.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Reason for unused flags argument in trace_raw_output_*
 function?
Message-ID: <20211007092026.644d25de@gandalf.local.home>
In-Reply-To: <4988d521-472f-a50e-4686-52afde08d2e9@redhat.com>
References: <4988d521-472f-a50e-4686-52afde08d2e9@redhat.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2021 23:49:22 -0400
William Cohen <wcohen@redhat.com> wrote:

> Hi,
> 
> I have some code that analyzes x86_64 binaries
> (https://developers.redhat.com/articles/2021/08/09/debugging-function-parameters-
> dyninst#liveness_analysis) and list which function parameters are unused.
>  I noticed that trace_raw_output_* functions have an unused flags
> argument.  I assume this is is to make the argument list match up with
> some other function, but I couldn't see which function(s) the
> trace_raw_output_* functions are trying to match up with.  Which
> functions are the trace_raw_output_* function's arguments trying to match?
> 

The match of other printing functions is in kernel/trace/trace_output.c

And is called from kernel/trace/trace.c where one place it does pass in
flags:


static enum print_line_t print_trace_fmt(struct trace_iterator *iter)
{
	[..]
	if (event)
		return event->funcs->trace(iter, sym_flags, event);

Now if they are still used, is something we should investigate.

This code has changed a lot over the years when that "flags" parameter was
introduced. It could now just be a relic from the old implementations.

Thanks for pointing this out. If I get time I'll look deeper into it, but
feel free to look at it yourself.

-- Steve
