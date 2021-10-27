Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1893643D022
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 19:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbhJ0R4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 13:56:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25004 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238393AbhJ0R4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 13:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635357224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xs32P5xw9k+anZul8tFQ2JCjeHg1mdaLsIqXwU0vnNE=;
        b=ebaNN0lAISTq0FFPD/8B5LGvx3QvYl4ch9zbKAO7BFZNFDI9V3fy6X3bTlHuhAaRc3Efp2
        +husEgjeEdZSvpQpRYTHVM47ox925Gw3VfM56F3hTEc0/EWMehacYYB85Qb5Bu9Vvr2E4S
        HNodw1XgoeuWZe1BFSQ0CG7EJnNWu2E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-29CCxQbxNJyUlMNtSW0P-Q-1; Wed, 27 Oct 2021 13:53:43 -0400
X-MC-Unique: 29CCxQbxNJyUlMNtSW0P-Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BAF9802B4F;
        Wed, 27 Oct 2021 17:53:42 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C21F36F951;
        Wed, 27 Oct 2021 17:53:09 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 00C3441752B6; Wed, 27 Oct 2021 14:52:47 -0300 (-03)
Date:   Wed, 27 Oct 2021 14:52:47 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v5 2/8] add prctl task isolation prctl docs and samples
Message-ID: <20211027175247.GA296917@fuller.cnet>
References: <20211019152431.885037499@fedora.localdomain>
 <20211019154210.706067872@fedora.localdomain>
 <20211027123806.GA70141@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027123806.GA70141@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 02:38:06PM +0200, Frederic Weisbecker wrote:
> > +- activation state:
> > +
> > +        The activation state (whether activate/inactive) of the task
> 
> active/inactive ?

Fixed.

> > +        This feature allows quiescing select kernel activities on
> 
> selected?

Fixed.

> > +                - Bit ISOL_INHERIT_CONF: Inherit task isolation configuration.
> > +                  This is the stated written via prctl(PR_ISOL_CFG_SET, ...).
> 
> state

Fixed.

> > +        The 'pmask' argument specifies the location of an 8 byte mask
> > +        containing which features should be activated. Features whose
> > +        bits are cleared will be deactivated. The possible
> > +        bits for this mask are:
> > +
> > +                - ``ISOL_F_QUIESCE``:
> > +
> > +                Activate quiescing of background kernel activities.
> > +                Quiescing happens on return to userspace from this
> > +                system call, and on return from subsequent
> > +                system calls (unless quiesce_oneshot_mask is configured,
> > +                see below).
> > +
> > +        If the arg3 argument is non-zero, it specifies a pointer to::
> > +
> > +         struct task_isol_activate_control {
> > +                 __u64 flags;
> > +                 __u64 quiesce_oneshot_mask;
> 
> So you are using an entire argument here to set a single feature (ISOL_F_QUIESCE).

Yes, but there is room at "struct task_isol_activate_control" for other features 
to use (and additional space in the remaining prctl arguments, if necessary).

> It looks like the oneshot VS every syscall behaviour should be defined at
> configuration time for individual ISOL_F_QUIESCE features.

It seems one-shot selection is dependent on the 
application logic:

	configure task isolation
	enable oneshot quiescing of kernel activities
	do {
		process data (no system calls)
		if (event) {
			process event with syscalls
			enable oneshot quiescing of kernel activities
		}
       } while (!exit_condition);

Considering configuration performed outside the application (by chisol),
is the administrator supposed to know the internals of the application
at this level ?

What if the application desires to use one-shot in a section
(of code) and "all syscalls" for another section.

> Also do we want that to always apply to all syscalls? Should we expect corner
> cases with some of them? 

What type of corner cases do you think of? 

> What about exceptions and interrupts?

Should move the isolation_exit_to_user_mode_prepare call from
__syscall_exit_to_user_mode_work to exit_to_user_mode_prepare.
Good point.

About your question. Think so, because otherwise: 

     enable oneshot quiescing of kernel activities
     do {
             process data (no system calls)	    <--- 1. IRQ/exception
             if (event) {
                     process event with syscalls
                     enable oneshot quiescing of kernel activities
             }
     } while (exit_condition == false);


If either an interrupt or exception occurs at point 1 above, userspace
might not be notified, and the interrupt/exception handler might 
change state in the kernel which makes the current CPU a target
for IPIs, for example changing per-CPU vm statistics.

> My wild guess is that we need to leave room for future flexibility. Either open
> some configuration space on ISOL_F_QUIESCE for that or create a seperate
> ISOL_F_QUIESCE_ONESHOT.

See above about oneshot being application dependent.

> 
> Other than that, the general interface looks good! Now time for me to
> look at the implementation...

OK, thanks.

