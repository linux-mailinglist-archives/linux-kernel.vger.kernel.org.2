Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455B63F2E06
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 16:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240874AbhHTOZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 10:25:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240802AbhHTOZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 10:25:37 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55B5E610FF;
        Fri, 20 Aug 2021 14:24:59 +0000 (UTC)
Date:   Fri, 20 Aug 2021 10:24:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     <Viktor.Rosendahl@bmw.de>
Cc:     <jing.yangyang@zte.com.cn>, <cgel.zte@gmail.com>,
        <vulab@iscas.ac.cn>, <colin.king@canonical.com>,
        <linux-kernel@vger.kernel.org>, <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] tools/tracing: fix application of sizeof to
 pointer
Message-ID: <20210820102452.341d25f8@oasis.local.home>
In-Reply-To: <e43ee2b8ed6e69bdda1ab859a4a16bc80bbba8d6.camel@bmw.de>
References: <8fd4bb65ef3da67feac9ce3258cdbe9824752cf1.1629198502.git.jing.yangyang@zte.com.cn>
        <e43ee2b8ed6e69bdda1ab859a4a16bc80bbba8d6.camel@bmw.de>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2021 09:00:09 +0000
<Viktor.Rosendahl@bmw.de> wrote:

> > Reported-by: Zeal Robot <zealci@zte.com.cn>
> > Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
> > ---
> >  tools/tracing/latency/latency-collector.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/tracing/latency/latency-collector.c
> > b/tools/tracing/latency/latency-collector.c
> > index 3a2e6bb..64d531d 100644
> > --- a/tools/tracing/latency/latency-collector.c
> > +++ b/tools/tracing/latency/latency-collector.c
> > @@ -1538,7 +1538,7 @@ static void tracing_loop(void)
> >  				mutex_lock(&print_mtx);
> >  				check_signals();
> >  				write_or_die(fd_stdout, queue_full_warning,
> > -					     sizeof(queue_full_warning));
> > +					     sizeof(*queue_full_warning));  
> 
> The old code would give a size of 8, i.e. the size of the pointer. Your
> suggestion will give a size of 1, i.e. the size of the first character of the
> error message. So instead of ouputing "Could no" we would only write out "C".

Which is obviously incorrect to use sizeof(*queue_full_warning), and
just makes the current bug into an even worse bug.

> 
> What we want is the length of the error message. This could be achieved in two
> ways:
> 
> 1. By changing the sizeof(queue_full_warning) to strlen(queue_full_warning).
> 
> 2. By changing the definition of queue_full_warning to be an array, in that case
> we would like to use sizeof(queue_full_warning) - 1, the "- 1" comes from the
> fact that we don't want to write out the terminating null character.
> 
> I think the first approach with strlen() is the better solution because it's
> shorter and modern compilers will do the strlen() calculation of constant
> strings at compile time anyway.

Either approach is fine. But it needs to fix the issue, and not just
blindly follow what Coccinelle tells you. Tools like Coccinelle can
help point you where a problem is. But people still need to use their
brain to actually fix the issue.

-- Steve
