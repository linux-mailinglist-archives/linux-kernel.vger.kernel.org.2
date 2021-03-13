Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561CA339BA9
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 05:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhCMEF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 23:05:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52014 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232223AbhCMEFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 23:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615608311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1lTu9l1PV/Mpti23DnxY1c2hHQGZJ8zrPZ3av3UZ6Og=;
        b=AL2aVUEET1BPkEZedmu7T1N2GLr21DezKH/ygH7cnJKiAbNuNV/ph3wiE1w4d1dbB0BB1G
        QKebVOq6T0gh4804s7XBjrHUlHfd1/7c3np3T34Dv7uVNaJ6taqkkA3ql84zer1u+vo9wf
        ha4whF43kLIoJ1DFsUEo6yXo9HiL3i0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-591-wgqQ16CqO0uoiETgC2f_eA-1; Fri, 12 Mar 2021 23:05:07 -0500
X-MC-Unique: wgqQ16CqO0uoiETgC2f_eA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 70EE380D69E;
        Sat, 13 Mar 2021 04:05:06 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C28E22AE99;
        Sat, 13 Mar 2021 04:04:56 +0000 (UTC)
Date:   Fri, 12 Mar 2021 23:04:54 -0500
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>
Subject: Re: [PATCH] MAINTAINERS: update audit files
Message-ID: <20210313040454.GB3141668@madcap2.tricolour.ca>
References: <69f51dfe3ad24840ea1ef1f38cfe033f0fc62080.1615411783.git.rgb@redhat.com>
 <CAHC9VhTdD4FVHKDygOZPjvNeHPNGjyoTQ-TzrFHP5xpd9UtSKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTdD4FVHKDygOZPjvNeHPNGjyoTQ-TzrFHP5xpd9UtSKw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-12 16:38, Paul Moore wrote:
> On Thu, Mar 11, 2021 at 11:41 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> > Add files maintaned by the audit subsystem.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  MAINTAINERS | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6eff4f720c72..a17532559665 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3015,9 +3015,13 @@ L:       linux-audit@redhat.com (moderated for non-subscribers)
> >  S:     Supported
> >  W:     https://github.com/linux-audit
> >  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
> > +F:     arch/*/*/*audit*.[ch]
> 
> That looks like it has about two too many wildcards to hold up over time :)
> 
> I understand what you're trying to do here, and while I don't disagree
> in principle, I worry that the arch specific paths vary enough that
> trying to handle it here is going to be a bit of a mess.
> 
> > +F:     arch/x86/include/asm/audit.h
> 
> The fact that we need a special entry for the single header under x86
> tends to reinforce that.  The other additions make sense, but I think
> it may be best to leave the arch specific areas alone for now.

Ok, I should have labelled this "RFC".  :-)

> > +F:     include/asm-generic/audit_*.h
> >  F:     include/linux/audit.h
> >  F:     include/uapi/linux/audit.h
> >  F:     kernel/audit*
> > +F:     lib/*audit.c
> >
> >  AUXILIARY DISPLAY DRIVERS
> >  M:     Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>
> > --
> > 2.27.0
> 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

