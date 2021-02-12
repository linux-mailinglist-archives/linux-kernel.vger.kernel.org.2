Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E17C31A040
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 15:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbhBLOCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 09:02:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230493AbhBLOCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 09:02:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613138465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lMH8Jy+Ac2exXElrSB53MclXMZkH36voPPBwm8uMTT8=;
        b=OicdHgx7ULvGTF7fd71z6srkch0gBeTHIurqY6jVns2n8DZmP6BNPcydZJ27lwSK5/l5l/
        ORPjMgHKSYR0ji02XURG8fGPYDbW7yE19OzlnFLkxKhtaO1QtgSXphRPfSM8Z/Bl6xCB1h
        VVSRrkOj38BEs+5WCFjl7JgX4YJswKE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-haYVU5a1Of6QesRuLmtI6Q-1; Fri, 12 Feb 2021 09:01:03 -0500
X-MC-Unique: haYVU5a1Of6QesRuLmtI6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96E49801981;
        Fri, 12 Feb 2021 14:01:02 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-8.gru2.redhat.com [10.97.112.8])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5669F6E528;
        Fri, 12 Feb 2021 14:01:02 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id A63AA416D87F; Fri, 12 Feb 2021 11:00:41 -0300 (-03)
Date:   Fri, 12 Feb 2021 11:00:41 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/3] nohz: change signal tick dependency to wakeup CPUs
 of member tasks
Message-ID: <20210212140041.GA182392@fuller.cnet>
References: <20210128202134.608115362@fuller.cnet>
 <20210128202235.849263653@fuller.cnet>
 <20210212122521.GA90839@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212122521.GA90839@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 01:25:21PM +0100, Frederic Weisbecker wrote:
> On Thu, Jan 28, 2021 at 05:21:36PM -0300, Marcelo Tosatti wrote:
> > Rather than waking up all nohz_full CPUs on the system, only wakeup 
> > the target CPUs of member threads of the signal.
> > 
> > Reduces interruptions to nohz_full CPUs.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > Index: linux-2.6/kernel/time/tick-sched.c
> > ===================================================================
> > --- linux-2.6.orig/kernel/time/tick-sched.c
> > +++ linux-2.6/kernel/time/tick-sched.c
> > @@ -444,9 +444,20 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_ta
> >   * Set a per-taskgroup tick dependency. Posix CPU timers need this in order to elapse
> >   * per process timers.
> >   */
> > -void tick_nohz_dep_set_signal(struct signal_struct *sig, enum tick_dep_bits
> > bit)
> 
> Why not keeping the signal struct as a parameter?
> 
> Thanks.

All callers use "struct signal_struct *sig = tsk->signal" as
signal parameter anyway...

Can change parameters to (task, signal, bit) if you prefer.

