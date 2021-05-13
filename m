Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B381537FF68
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 22:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhEMUqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 16:46:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:55442 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233034AbhEMUqQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 16:46:16 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB163613FB;
        Thu, 13 May 2021 20:45:05 +0000 (UTC)
Date:   Thu, 13 May 2021 16:45:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ftrace: Handle commands when closing set_ftrace_filter
 file
Message-ID: <20210513164504.6214b03c@gandalf.local.home>
In-Reply-To: <YJ2K80OWCmoxy4n8@krava>
References: <20210505104818.24358ef7@gandalf.local.home>
        <YJ2K80OWCmoxy4n8@krava>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 May 2021 22:24:19 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> > Fixes: eda1e32855656 ("tracing: handle broken names in ftrace filter")  
> 
> nice, breaking kernel since 2009.. I'll put that on t-shirt ;-)

Hmm, maybe I'll recommend that for the Linux Plumber's t-shirt ;-)

 "Breaking kernel's since 2009"!

> 
> I saw the patch got already merged, FWIW:
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

I'm guessing you hit the bug too?

-- Steve
