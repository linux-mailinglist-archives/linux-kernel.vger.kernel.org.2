Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56043E948E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhHKP3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 11:29:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231388AbhHKP3g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 11:29:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D15F66056B;
        Wed, 11 Aug 2021 15:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628695752;
        bh=GZA5xibJwSTSz1gm+1HKlvDUFmznkOLoXB/EQufGjGQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=d1AXNQO9MOQfe2nHoOPi2CzaLo5nGZ4ykOZ1i9/aF9tR+x8MS9MdyjMI9+jHqu28/
         Kcz9Z/qMrgs32sh2M48fevzjdl8O7dV3J18bVMOpIf/Fridx4ztnD0csr1tB9JtpVe
         ObbQbYhtMhTp0nmD1apv/p1+7X0wRhwCej5qpVCpYpxmGiMAkVUfgKnWHsjT8es8P/
         PXI4qD945Wx7m3f2XQBe9gw62rFY46E78rad766i2Au9FQJ6BbIfdTJ0dHUW7p/H4Q
         fQlbidQ7iC8XpU9XWXo8lxT9mO4HFGed75oyzYt3RXtPnB34MApOkCHF1ebHQbaX7q
         cmpb84ajbBMew==
Message-ID: <934b0ae20a78f87b556d0dfd150282f033bc1483.camel@kernel.org>
Subject: Re: [PATCH] tracing / histogram: Fix NULL pointer dereference on
 strcmp() on NULL event name
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Date:   Wed, 11 Aug 2021 10:29:10 -0500
In-Reply-To: <20210811103522.0cac5f1a@oasis.local.home>
References: <20210808003011.4037f8d0@oasis.local.home>
         <20210811103522.0cac5f1a@oasis.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2021-08-11 at 10:35 -0400, Steven Rostedt wrote:
> On Sun, 8 Aug 2021 00:30:11 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > diff --git a/kernel/trace/trace_events_hist.c
> > b/kernel/trace/trace_events_hist.c
> > index 949ef09dc537..a48aa2a2875b 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -3430,6 +3430,8 @@ trace_action_create_field_var(struct
> > hist_trigger_data *hist_data,
> >  			event = data->match_data.event;
> >  		}
> >  
> > +		if (!event)
> > +			goto free;
> >  		/*
> >  		 * At this point, we're looking at a field on another
> >  		 * event.  Because we can't modify a hist trigger on
> > -- 
> 
> Tom,
> 
> Is this OK? I'm going to start running this through my tests and when
> it's done, I'm going to send it off to Linus.

Sorry, missed this one.

But yeah, this fixes the problem, thanks!

Reviewed-by: Tom Zanussi <zanussi@kernel.org>


> 
> -- Steve

