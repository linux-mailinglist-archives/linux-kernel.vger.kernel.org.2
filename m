Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC463D5C9D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 17:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbhGZO1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 10:27:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234837AbhGZOYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 10:24:12 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE37B60F55;
        Mon, 26 Jul 2021 15:04:40 +0000 (UTC)
Date:   Mon, 26 Jul 2021 11:04:34 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: use WARN_ONCE
Message-ID: <20210726110434.4b9f976d@oasis.local.home>
In-Reply-To: <20210726110237.3c25dbc7@oasis.local.home>
References: <20210726135635.143285-1-wangborong@cdjrlc.com>
        <20210726110237.3c25dbc7@oasis.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2021 11:02:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > @@ -1574,9 +1574,8 @@ __init static int init_events(void)
> >  
> >  		ret = register_trace_event(event);
> >  		if (!ret) {
> > -			printk(KERN_WARNING "event %d failed to register\n",
> > -			       event->type);
> > -			WARN_ON_ONCE(1);
> > +			WARN_ONCE(1, "event %d failed to register\n",
> > +				  event->type);
> >  		}
> >  	}
> >    
> 
> If you're going to change this, then nuke the conditional!
> 
> 	WARN_ONCE(!ret, "event %d failed to register\n", event->type);

Oh, and if you are making these types of changes, you need to
understand them. The string passed to WARN does not need the "\n" like
the printk() does.

	WARN_ONCE(!ret, "event %d failed to register", event->type);

-- Steve
