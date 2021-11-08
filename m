Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE7F449EF5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 00:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240885AbhKHXUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 18:20:00 -0500
Received: from linux.microsoft.com ([13.77.154.182]:45490 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234561AbhKHXT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 18:19:59 -0500
Received: from kbox (unknown [24.17.193.74])
        by linux.microsoft.com (Postfix) with ESMTPSA id 459FF20B417F;
        Mon,  8 Nov 2021 15:17:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 459FF20B417F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1636413434;
        bh=Y3US/BTw3rd1MFFpONjydRLneEok+1DRyWGgTe/tWM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wi9hHcLxMVfMPZF/wD2U3kk0ifYZxD6ajNw9oEGSCF5Z0OfBswY6Sg7Y+zCP7DNEP
         rGq3HjYXMjojM9AJS4iDUml0PeliXTLj4fPjIphYWLjIiGyC1SeTX8Jxrqq4QemOko
         xVNepu4LtRF+rggnIGH5lBhao7D8ynIZxFy2X/ZE=
Date:   Mon, 8 Nov 2021 15:17:10 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/10] user_events: Optimize writing events by only
 copying data once
Message-ID: <20211108231710.GA1521@kbox>
References: <20211104170433.2206-1-beaub@linux.microsoft.com>
 <20211104170433.2206-10-beaub@linux.microsoft.com>
 <20211108174542.39c255e1@gandalf.local.home>
 <20211108230034.GB1452@kbox>
 <20211108180452.3ec1f4ec@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108180452.3ec1f4ec@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 06:04:52PM -0500, Steven Rostedt wrote:
> On Mon, 8 Nov 2021 15:00:34 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > > > -	memcpy(entry + 1, data, datalen);
> > > > +	if (unlikely(!copy_nofault(entry + 1, i->count, i)))  
> > > 
> > > Need:
> > > 		__trace_event_discard_commit(event_buffer.buffer, event_buffer.event);
> > > 
> > > Because the trace_event_buffer_reserve() will not only allocate space on
> > > the ring buffer, but may also disable preemption.
> > > 
> > > -- Steve
> > >   
> > 
> > Ah, thank you!
> 
> Which reminds me that trace_event_buffer_reserve() expects to be called
> with preemption disabled. And I'm guessing that may not be the case for you.
> 

Thanks, should be good there:
I have rcu_read_lock_sched() held, which will have preemption disabled
during the various probe calls.

> I'll change this so that it always disables preemption even if it uses the
> filter buffer, and *always* disables preemption on return.
> 
> -- Steve

Thanks,
-Beau
