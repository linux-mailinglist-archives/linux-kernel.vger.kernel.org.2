Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A099039E5E3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFGRxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229997AbhFGRxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:53:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623088270;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R5niUi3fJSiRjHfDOa1VQ749sIe5Im1MrK9zK8A3744=;
        b=Jjsiv7Y3Qk/J3WMSGUM8S8AxtKs4d046QEG9gUdpCVeWQR7PbC1r2pYthAwH2CyxaTmkBa
        xA6Aw8VVKnH0YMeyqePyPYfaT1y9dn2EEA0QfCWcPnzGWaO7xyisFBoVFZ4Rm9eEz1PytM
        u8qtUQJWMWnozIBANvSv95jiFp9kTXg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-5Rj1YZ9GOgGc7PgClhvOWQ-1; Mon, 07 Jun 2021 13:51:09 -0400
X-MC-Unique: 5Rj1YZ9GOgGc7PgClhvOWQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79A0A106BB2E;
        Mon,  7 Jun 2021 17:51:08 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.3.128.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 085E719C66;
        Mon,  7 Jun 2021 17:51:00 +0000 (UTC)
Date:   Mon, 7 Jun 2021 13:50:58 -0400
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Sergey Nazarov <s-nazarov@yandex.ru>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, Eric Paris <eparis@redhat.com>
Subject: Re: [PATCH] audit: Rename enum audit_state constants to avoid
 AUDIT_DISABLED redefinition
Message-ID: <20210607175058.GO447005@madcap2.tricolour.ca>
References: <ba47c2acb7bee9102bb6a85e9ba8b5918fa3610b.camel@yandex.ru>
 <CAHC9VhTvp3Z26JbXJdq8p4T7w3GZk-1CFWY328o75-AqqUbNTg@mail.gmail.com>
 <79d5bffd63b46bb7d54ebcef4765cfca28f76ff0.camel@yandex.ru>
 <CAHC9VhQfzx6xhZz+ghkRB2UKWHmsHKjLzz_7z3L47GHOoHLchw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQfzx6xhZz+ghkRB2UKWHmsHKjLzz_7z3L47GHOoHLchw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-07 13:07, Paul Moore wrote:
> On Mon, Jun 7, 2021 at 5:58 AM Sergey Nazarov <s-nazarov@yandex.ru> wrote:
> > Hi, Paul!
> > I think this could be easer. It's enouth to rename AUDIT_DISABLE only.
> > enum audit_state deals with per-task syscalls audit context, so we can
> > use AUDIT_CONTEXT_DISABLED for example. If it's okay, I can send a new
> > patch version.
> 
> Hi Sergey,
> 
> I personally prefer the AUDIT_STATE_* enums and would rather see that.

I find AUDITSC_* or AUDIT*CONTEXT* are more helpful since that makes it
clear it is about syscall context while STATE doesn't make that clear.

The minimal change could have been to AUDIT_DISABLE_CONTEXT.

> > В Сб, 05/06/2021 в 22:40 -0400, Paul Moore пишет:
> > > On Fri, Jun 4, 2021 at 7:21 AM Sergey Nazarov <s-nazarov@yandex.ru>
> > > wrote:
> > > >
> > > > AUDIT_DISABLED defined in kernel/audit.h as element of enum
> > > > audit_state
> > > > and redefined in kernel/audit.c. This produces a warning when
> > > > kernel builds
> > > > with syscalls audit disabled and brokes kernel build if -Werror
> > > > used.
> > > > enum audit_state used in syscall audit code only. This patch
> > > > changes
> > > > enum audit_state constants prefix AUDIT to AUDITSC to avoid
> > > > AUDIT_DISABLED
> > > > redefinition.
> > > >
> > > > Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
> > > > ---
> > > >  kernel/audit.h   |  8 ++++----
> > > >  kernel/auditsc.c | 34 +++++++++++++++++-----------------
> > > >  2 files changed, 21 insertions(+), 21 deletions(-)
> > >
> > > Hi Sergey,
> > >
> > > Thanks for sending a patch to fix this problem.  One comment below
> > > ...
> > >
> > > > diff --git a/kernel/audit.h b/kernel/audit.h
> > > > index 1522e10..ee81f20 100644
> > > > --- a/kernel/audit.h
> > > > +++ b/kernel/audit.h
> > > > @@ -21,16 +21,16 @@
> > > >     a per-task filter.  At syscall entry, the audit_state is
> > > > augmented by
> > > >     the syscall filter. */
> > > >  enum audit_state {
> > > > -       AUDIT_DISABLED,         /* Do not create per-task
> > > > audit_context.
> > > > +       AUDITSC_DISABLED,       /* Do not create per-task
> > > > audit_context.
> > > >                                  * No syscall-specific audit
> > > > records can
> > > >                                  * be generated. */
> > > > -       AUDIT_BUILD_CONTEXT,    /* Create the per-task
> > > > audit_context,
> > > > +       AUDITSC_BUILD_CONTEXT,  /* Create the per-task
> > > > audit_context,
> > > >                                  * and fill it in at syscall
> > > >                                  * entry time.  This makes a full
> > > >                                  * syscall record available if some
> > > >                                  * other part of the kernel decides
> > > > it
> > > >                                  * should be recorded. */
> > > > -       AUDIT_RECORD_CONTEXT    /* Create the per-task
> > > > audit_context,
> > > > +       AUDITSC_RECORD_CONTEXT  /* Create the per-task
> > > > audit_context,
> > > >                                  * always fill it in at syscall
> > > > entry
> > > >                                  * time, and always write out the
> > > > audit
> > > >                                  * record at syscall exit time.  */
> > >
> > > I believe that just as the AUDIT_ prefix proved to be a bit too
> > > generic, I think that the AUDITSC_ prefix is also not the best
> > > choice.
> > > Would you object to using the AUDIT_STATE_ prefix?  As that may get a
> > > bit long, I might suggest dropping the _CONTEXT from the enums too
> > > such that you would end up with the following:
> > >
> > >   enum audit_state {
> > >     AUDIT_STATE_DISABLED,
> > >     AUDIT_STATE_BUILD,
> > >     AUDIT_STATE_RECORD,
> > >   };
> > >
> > > Thoughts?
> 
> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635

