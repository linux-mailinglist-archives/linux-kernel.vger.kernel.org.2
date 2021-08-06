Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05B253E2F29
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 20:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242669AbhHFSLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 14:11:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51838 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbhHFSLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 14:11:02 -0400
Date:   Fri, 6 Aug 2021 20:10:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628273445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3zsBHwXdMgJYV7iZZsmGRoaixiLolsf1JKG5J7vuiRI=;
        b=4LqUwnPwnT33HtrOrSXTn5feTEedYKsj6T68JC1mtEwN4EQ+2CwyuOuFtDEjVa5T+b1rki
        qeY/CuYIiNqwl9WQRzm5AHBcFJrRXzb9vgvhpdhpwboPrpdIpJRZmLknL48BPKsBJMzJ8F
        ycnctx+vmEH6yOqj+FG5gnUwvrA+nHh2GY/ZDrtf4abt7qyXj4VUft9dUN3GQZtunPAGLG
        l3yP8E69znP8wMouRdu7Yt07AYu2hqA8psMM9iBajuQ/4+QeBxKz7A7tMq1OkYmTEsJprG
        iX1cX8E/WkcFIucu0GdznqJQDZF9ogYoSar+ilqsz/sAttivBdmGomHC7lAU8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628273445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3zsBHwXdMgJYV7iZZsmGRoaixiLolsf1JKG5J7vuiRI=;
        b=q1WR9zX4CerFXFq37C69aadxBIn2zVZ0Xml+4aLrdDW5SjWpi3UUHVB2nCdm4k9l+JI7pb
        vslXIsI0u/O6oOAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] trace: Add migrate-disabled counter to tracing output.
Message-ID: <20210806181044.6tqzlanvxdihaguy@linutronix.de>
References: <20210806164907.xtgvrb25eb4isxhd@linutronix.de>
 <20210806135124.1279fc94@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210806135124.1279fc94@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-06 13:51:24 [-0400], Steven Rostedt wrote:
> > diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> > index ad413b382a3ca..7c4280b4c6be7 100644
> > --- a/include/linux/trace_events.h
> > +++ b/include/linux/trace_events.h
> > @@ -69,6 +69,7 @@ struct trace_entry {
> >  	unsigned char		flags;
> >  	unsigned char		preempt_count;
> >  	int			pid;
> > +	unsigned char		migrate_disable;
> 
> The only issue I have with this patch is this part. It extends the
> header of all events beyond 8 bytes, and actually adds another 4 or 8
> bytes despite being just a char in size. That's because this is a
> header of a structure, which depending on the first field of an event,
> padding may be added to have 4 or 8 byte alignment.
> 
> I'll be fine with merging this counter with either flags or
> preempt_count (neither needs all 8 bits). I can figure out how to
> update libtraceevent to handle this case.

I was kind of expecting that. Let me try 4 bits for the preempt counter
and 4 bits for the migrate counter.

> -- Steve
> 

Sebastian
