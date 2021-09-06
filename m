Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8174017A2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 10:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbhIFIOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 04:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239780AbhIFIOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:14:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59876C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 01:13:47 -0700 (PDT)
Date:   Mon, 6 Sep 2021 10:13:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630916024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYHBl87y3v8Ieky0bj4T/DhMiiK93Kxq3slzmlTSg2A=;
        b=o9/UDVQ+51nWr44c6wetNcWoBuHo6IwP+/bkKa5WT3Z9dP+lG0QspuRogF/HF6Z+EOlOFS
        eQMUsEmmxlUCuhGdx+Y7OfODDse+zx+CvYIWBwJWlOcFVccjjJw6zvftYSbZryW/t6x7Z1
        PlgUsvlvHsl/XqJBVfP0BEdOpoI9sdKvG3OOK2e1QXEvNJz9jk9OFko0wit64nXtZ1u0LD
        AQhQi9AVC1FBtl9Zsqik/UbNxf2ry88/og4qgXzMUpSHSEYfOwh7zO/gmWmxMdXFPwzLLf
        3lH7PKtwtTEahMAYGTu4h1D+u9axlsb9jalXG8hW5ck+Q7LwlsQpu5bs89oqBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630916024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vYHBl87y3v8Ieky0bj4T/DhMiiK93Kxq3slzmlTSg2A=;
        b=RwVcuBBDgG2GYWaiy0dYXBXyDSkTkJyILPdBve27jb5ltsyhQo71HF/MH08Y4Scu5X7HI2
        hoNs3TMbc59J0dAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] trace: Add migrate-disabled counter to tracing output.
Message-ID: <20210906081343.klxtb652s5aphg4z@linutronix.de>
References: <20210806164907.xtgvrb25eb4isxhd@linutronix.de>
 <20210806135124.1279fc94@oasis.local.home>
 <20210810132625.ylssabmsrkygokuv@linutronix.de>
 <20210903194216.1392b62e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210903194216.1392b62e@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-03 19:42:16 [-0400], Steven Rostedt wrote:
Hi Steven,

> BTW,
> 
> When doing a v2, always create a new thread. Never send it as a reply to
> the previous patch. The reason I missed this is because replies to previous
> patches do not end up in my internal patchwork. And I only look at that for
> patches. Not my INBOX.

oki.

> 
> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -181,7 +181,8 @@ static int trace_define_common_fields(void)
> >  
> >  	__common_field(unsigned short, type);
> >  	__common_field(unsigned char, flags);
> > -	__common_field(unsigned char, preempt_count);
> > +	/* XXX */
> > +	__common_field(unsigned char, preempt_mg_count);
> >  	__common_field(int, pid);
> >  
> >  	return ret;
> 
> I'm going to have to nuke this hunk of the patch, and update all the other
> locations that have preempt_mg_count in it. Because I just tested it, and
> this breaks user space.

I left that with that XXX on purpose so you can look and comment and say
how to fix it. The problem I had with preempt_count was that only the
lower nibble contains the preemption counter. So I thought you could
easily came up with something how this can be split or taught to only
expose the lower nibble. I didn't after a few attempts.
My understanding is that this `preempt_count' is also used in the filter
tracefs file so something like "preempt_count > 1" > filter would also
match for migrate_count = 2, preempt_count = 1. You seem to be happy to
filter in user space.

Sebastian
