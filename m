Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2897539F731
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 14:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhFHNBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 09:01:24 -0400
Received: from smtp2.axis.com ([195.60.68.18]:6907 "EHLO smtp2.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230009AbhFHNBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:01:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1623157170;
  x=1654693170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b0NmHxsg1aBuIl6v7KAzslccYdqY1RPSbbU0UE9Pw/E=;
  b=E1JC4VOkMnZo3vg3q26UIOosaCdaefk5mbeTz9P6UksdmfjZFItMJ74h
   snX70Obn4XTVgY1Do0NPO0FUhyE96hNh56PWyhawGsMdb3wXR+m96+gwb
   a+qxKS5/YJeuhxOSrwUPQs2EuUBXDMDdrwj+lJduLO3jlUYUBUTDulzkx
   DQqWSp+rSG4pE+/oEJGfBq+EY/sKBOD2uEplizAsJVtsVuoT0dLjCzhLu
   NmqRiyc8qilzJ+iijf/QCcLm/egU26VFOD0vNwfBtqCMFc2Wd7bT8IoAC
   W9pUVhGwslRccuujG2YBDqIAMTxtDeJ9oAYOuVVlfP0mXEjOOBZ39AQST
   A==;
Date:   Tue, 8 Jun 2021 14:59:27 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Christoph Hellwig <hch@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Export tracing_start() and tracing_stop()
Message-ID: <20210608125927.GA4095@axis.com>
References: <20210602080118.21627-1-vincent.whitchurch@axis.com>
 <YL3X7yRr1+yW/PHU@infradead.org> <20210607091432.667ff0ba@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210607091432.667ff0ba@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2021 at 03:14:32PM +0200, Steven Rostedt wrote:
> That said though, tracing_stop() is probably not what is wanted
> (unless its for a suspend to ram thing). According to the above
> description, the author really wants to use "tracing_off()" and not
> "tracing_stop()" as tracing_off() is faster and can be turned back on
> in user-space with the "tracing_on" file in tracefs, where as,
> tracing_stop() can not be. tracing_stop() needs a tracing_start() to
> get it going again.
> 
> And tracing_off() is already EXPORT_SYMBOL_GPL() (as it is commonly
> used for debugging of modules). Again, it shouldn't have any in-kernel
> users in modules, because, like I stated above, it's similar to
> trace_printk() which should be removed before pushing to Linus.
> 
> I'll NAK this patch for a different reason. Use tracing_off() instead.

Right, thanks, that's certainly much simpler.  I'd only used
tracing_stop() before and never noticed that tracing_on can't be used to
restart tracing, probably because the kind of problems I used it for
usually resulted in the system needing a restart anyway to be usable.
