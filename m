Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDD9402DF6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 19:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242371AbhIGRuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 13:50:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:41330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234449AbhIGRuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 13:50:32 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8924161101;
        Tue,  7 Sep 2021 17:49:24 +0000 (UTC)
Date:   Tue, 7 Sep 2021 13:49:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kalesh Singh <kaleshsingh@google.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        John Reitan <john.reitan@arm.com>,
        =?UTF-8?B?w5hyamFu?= Eide <orjan.eide@arm.com>,
        Mark Underwood <mark.underwood@arm.com>,
        Gary Sweet <gary.sweet@broadcom.com>,
        Stephen Mansfield <stephen.mansfield@imgtec.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RESEND v2] tracing/gpu: Add imported size to gpu_mem_imported
 tracepoint
Message-ID: <20210907134923.2dd41a8a@gandalf.local.home>
In-Reply-To: <CAC_TJvdv+BSQh0vqWmA220op+b5=8=ZYrhXcmDRE-Fppo0zE0w@mail.gmail.com>
References: <20210831170233.1409537-1-kaleshsingh@google.com>
        <20210903163047.20e4f286@gandalf.local.home>
        <CAC_TJvdv+BSQh0vqWmA220op+b5=8=ZYrhXcmDRE-Fppo0zE0w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Sep 2021 15:36:03 -0700
Kalesh Singh <kaleshsingh@google.com> wrote:

> On Fri, Sep 3, 2021 at 1:30 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Tue, 31 Aug 2021 17:02:29 +0000
> > Kalesh Singh <kaleshsingh@google.com> wrote:
> >  
> > > The existing gpu_mem_total tracepoint provides GPU drivers a uniform way
> > > to report the per-process and system-wide GPU memory usage. This
> > > tracepoint reports a single total of the GPU private allocations and the
> > > imported memory. [1]
> > >
> > > To allow distinguishing GPU private vs imported memory, add an
> > > imported_size field to the gpu_mem_total tracepoint. GPU drivers can use
> > > this new field to report the per-process and global GPU-imported memory
> > > in a uniform way.
> > >
> > > User space tools can detect and handle the old vs new gpu_mem_total
> > > format via the gpu_mem/gpu_mem_total/format file.
> > >
> > > [1] https://lore.kernel.org/r/20200302234840.57188-1-zzyiwei@google.com/
> > >
> > > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > > ---
> > >  include/trace/events/gpu_mem.h | 17 +++++++++++------
> > >  1 file changed, 11 insertions(+), 6 deletions(-)
> > >  
> >
> > This is that trace event that doesn't have any in tree callers, right? I
> > thought there was going to be some soon.  
> 
> The trace event is currently used by the Android GPU drivers, and
> there is some work ongoing to add this in drm core upstream but it's
> not yet ready.
> 
> >
> > For the updates to the tracing side (besides not having any users), it
> > looks trivial to me.
> >
> > Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >
> > But this needs to be pulled in by one of the GPU maintainers.  
> 
> Thanks for the review Steve. I'll resend adding the GPU maintainers.

OK, so it was Greg that gave me the Ack to accept it.

I'll need his Ack again for the update.

-- Steve
