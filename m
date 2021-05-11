Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBCE837AF7B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 21:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhEKTly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 15:41:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231944AbhEKTlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 15:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620762046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rj6L9PURkNx4/ivnoPgM1A+pOZdnCZXr7aAOI6YcF60=;
        b=Y8IfC/pxbvbLdHUNHo1zQ8qjKX5HNi99jDSQset5AQWty5fLukkjciSRCTo3R8y2JUBpkn
        G/ECXdozC/uLw56pG+IIvWtyZi8wLBJ/7eQSHctZnAhfGwjds45wSpxAS9rIB/bsd2V1P8
        mQkxlpO9HCbITMqLd3psj8GWq/X6W3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-UKPH0FMIM-CilANLQZdxuQ-1; Tue, 11 May 2021 15:40:40 -0400
X-MC-Unique: UKPH0FMIM-CilANLQZdxuQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9416B1854E25;
        Tue, 11 May 2021 19:40:39 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 881A71037F34;
        Tue, 11 May 2021 19:40:31 +0000 (UTC)
Date:   Tue, 11 May 2021 15:40:28 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Eric Paris <eparis@redhat.com>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] audit: allow logging of user events in non-initial
 namespace.
Message-ID: <20210511194028.GQ3141668@madcap2.tricolour.ca>
References: <20210509183319.20298-1-michael.weiss@aisec.fraunhofer.de>
 <CAHC9VhRkh3uySjZ1qg07Fgky+R3jSmfJ80BLCFOK+LCPvZVrOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRkh3uySjZ1qg07Fgky+R3jSmfJ80BLCFOK+LCPvZVrOA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-05-10 18:48, Paul Moore wrote:
> On Sun, May 9, 2021 at 2:33 PM Michael Weiﬂ
> <michael.weiss@aisec.fraunhofer.de> wrote:
> >
> > Audit subsystem was disabled in total for user namespaces other than
> > the initial namespace.
> >
> > If audit is enabled by kernel command line or audtid in initial namespace,
> > it is now possible to allow at least logging of userspace applications
> > inside of non-initial namespaces if CAP_AUDIT_WRITE in the corresponding
> > namespace is held.
> >
> > This allows logging of, e.g., PAM or opensshd inside user namespaced
> > system containers.
> >
> > Signed-off-by: Michael Weiﬂ <michael.weiss@aisec.fraunhofer.de>
> > ---
> >  kernel/audit.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> I think this needs to wait on the audit container ID patchset to land.

That will interact with this, for sure and others related.

Given that there are non-init namespaces involved that may not be part
of containers, I would prefer to wait until namespaces are also
optionally documentable in audit events before permitting this change.
A patchset exists, but it has been deferred until the audit container
identifier patchset is settled.
(See https://github.com/linux-audit/audit-kernel/issues/32 )

> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 121d37e700a6..b5cc0669c3d7 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -1012,7 +1012,13 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
> >          * userspace will reject all logins.  This should be removed when we
> >          * support non init namespaces!!
> >          */
> > -       if (current_user_ns() != &init_user_ns)
> > +       /*
> > +        * If audit is enabled by kernel command line or audtid in the initial
> > +        * namespace allow at least logging of userspace applications inside of
> > +        * non-initial namespaces according to CAP_AUDIT_WRITE is held in the
> > +        * corresponding namespace.
> > +        */
> > +       if ((current_user_ns() != &init_user_ns) && !audit_enabled)
> >                 return -ECONNREFUSED;
> >
> >         switch (msg_type) {
> > @@ -1043,7 +1049,7 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
> >         case AUDIT_USER:
> >         case AUDIT_FIRST_USER_MSG ... AUDIT_LAST_USER_MSG:
> >         case AUDIT_FIRST_USER_MSG2 ... AUDIT_LAST_USER_MSG2:
> > -               if (!netlink_capable(skb, CAP_AUDIT_WRITE))
> > +               if (!netlink_ns_capable(skb, current_user_ns(), CAP_AUDIT_WRITE))
> >                         err = -EPERM;
> >                 break;
> >         default:  /* bad msg */
> > --
> > 2.20.1
> 
> -- 
> paul moore
> www.paul-moore.com
> 

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

