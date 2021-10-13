Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7392242B0EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 02:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234890AbhJMAY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 20:24:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233128AbhJMAYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 20:24:54 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B37560BD3;
        Wed, 13 Oct 2021 00:22:51 +0000 (UTC)
Date:   Tue, 12 Oct 2021 20:22:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>, akpm@linux-foundation.org,
        bp@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] init: Make unknown command line param message clearer
Message-ID: <20211012202250.54a8db49@gandalf.local.home>
In-Reply-To: <87853d4f-d6f8-1d58-1a07-c8232dae87fd@infradead.org>
References: <20211012213523.39801-1-ahalaney@redhat.com>
        <20211012200106.1afdbb0b@gandalf.local.home>
        <87853d4f-d6f8-1d58-1a07-c8232dae87fd@infradead.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 17:18:32 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 10/12/21 5:01 PM, Steven Rostedt wrote:
> > On Tue, 12 Oct 2021 16:35:23 -0500
> > Andrew Halaney <ahalaney@redhat.com> wrote:
> >   
> >> --- a/init/main.c
> >> +++ b/init/main.c
> >> @@ -925,6 +925,10 @@ static void __init print_unknown_bootoptions(void)
> >>   	for (p = &envp_init[2]; *p; p++)
> >>   		end += sprintf(end, " %s", *p);
> >>   
> >> +	pr_notice("The kernel command line has unknown parameters. They are either\n");
> >> +	pr_notice("misspelled, not valid for the current kernel configuration,\n");
> >> +	pr_notice("or are meant for init but are not after the '--' delineator. They will\n");
> >> +	pr_notice("be passed to init along with those after '--' on the command line.\n");
> >>   	pr_notice("Unknown command line parameters:%s\n", unknown_options);
> >>   	memblock_free(unknown_options, len);  
> > 
> > What about just changing it to simply say:
> > 
> > 	pr_notice("Unknown kernel command line parameters "%s", will be	passed to user space.\n",
> > 		  unknown_options);
> >   
> 
> Yes, that's much more palatable.

Thanks.

Andrew (Halaney, not Morton),

Feel free to send a v2 with the above text, and just add:

Suggested-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
