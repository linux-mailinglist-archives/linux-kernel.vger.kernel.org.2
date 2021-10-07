Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28AD1424B9F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 03:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhJGBaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 21:30:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:48112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230300AbhJGB37 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 21:29:59 -0400
Received: from rorschach.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCD8F6113E;
        Thu,  7 Oct 2021 01:28:05 +0000 (UTC)
Date:   Wed, 6 Oct 2021 21:28:03 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing/synthetic_events: Fix use when created by
 dynamic_events file
Message-ID: <20211006212803.48151494@rorschach.local.home>
In-Reply-To: <20211007101952.d9d282257b9c49fe699c0679@kernel.org>
References: <20211006115317.2cfcc742@gandalf.local.home>
        <20211007101952.d9d282257b9c49fe699c0679@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Oct 2021 10:19:52 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> >  	raw_command = skip_spaces(raw_command);
> >  	if (raw_command[0] == '\0')
> > -		return ret;
> > +		return -ECANCELED;  
> 
> Good catch! BTW, I thought trace_parse_run_command() skips such empty line.

I think it does, but I was paranoid to remove that part, as this is
going to stable. As a clean up, we could remove that for the next merge
window.

> 
> Anyway,
> 
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

-- Steve
