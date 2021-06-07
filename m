Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E5839D930
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 11:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhFGKAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 06:00:15 -0400
Received: from forward102p.mail.yandex.net ([77.88.28.102]:44464 "EHLO
        forward102p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230193AbhFGKAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 06:00:15 -0400
Received: from forward101q.mail.yandex.net (forward101q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb98])
        by forward102p.mail.yandex.net (Yandex) with ESMTP id 15EC154C28A4;
        Mon,  7 Jun 2021 12:58:19 +0300 (MSK)
Received: from vla5-d4be149c9aa7.qloud-c.yandex.net (vla5-d4be149c9aa7.qloud-c.yandex.net [IPv6:2a02:6b8:c18:3485:0:640:d4be:149c])
        by forward101q.mail.yandex.net (Yandex) with ESMTP id 110CBCF40023;
        Mon,  7 Jun 2021 12:58:19 +0300 (MSK)
Received: from vla5-445dc1c4c112.qloud-c.yandex.net (vla5-445dc1c4c112.qloud-c.yandex.net [2a02:6b8:c18:3609:0:640:445d:c1c4])
        by vla5-d4be149c9aa7.qloud-c.yandex.net (mxback/Yandex) with ESMTP id RdnaOXaVse-wIK0wVwT;
        Mon, 07 Jun 2021 12:58:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1623059899;
        bh=pri2U53hHSTg+Row1G0suIH2TvQb+Kxs4Vlq7p1ILLE=;
        h=In-Reply-To:Cc:To:From:Subject:Message-ID:References:Date;
        b=wHcZ1vs58rVgLbR2DByIGdLucNJo2xshM7eNbZT+yQjwSJuuwUEXV5NrQE32AIQ7f
         TsBpYGu9f6Ruj3i7d2EWwwml942vSBoOeh8QzZWjCZVjvhH0IqDSog389sVx/E4eAa
         mnUptL6vZfLH95U0epcgBLfSO3pVpbnShNCvoHZM=
Authentication-Results: vla5-d4be149c9aa7.qloud-c.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla5-445dc1c4c112.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id tvWRgfBwki-wIM8Col6;
        Mon, 07 Jun 2021 12:58:18 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Message-ID: <79d5bffd63b46bb7d54ebcef4765cfca28f76ff0.camel@yandex.ru>
Subject: Re: [PATCH] audit: Rename enum audit_state constants to avoid
 AUDIT_DISABLED redefinition
From:   Sergey Nazarov <s-nazarov@yandex.ru>
To:     Paul Moore <paul@paul-moore.com>
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>
Date:   Mon, 07 Jun 2021 12:58:13 +0300
In-Reply-To: <CAHC9VhTvp3Z26JbXJdq8p4T7w3GZk-1CFWY328o75-AqqUbNTg@mail.gmail.com>
References: <ba47c2acb7bee9102bb6a85e9ba8b5918fa3610b.camel@yandex.ru>
         <CAHC9VhTvp3Z26JbXJdq8p4T7w3GZk-1CFWY328o75-AqqUbNTg@mail.gmail.com>
Content-Type: text/plain; charset="koi8-r"
X-Mailer: Evolution 3.28.5 (3.28.5-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Paul!
I think this could be easer. It's enouth to rename AUDIT_DISABLE only.
enum audit_state deals with per-task syscalls audit context, so we can
use AUDIT_CONTEXT_DISABLED for example. If it's okay, I can send a new
patch version.

В Сб, 05/06/2021 в 22:40 -0400, Paul Moore пишет:
> On Fri, Jun 4, 2021 at 7:21 AM Sergey Nazarov <s-nazarov@yandex.ru>
> wrote:
> > 
> > AUDIT_DISABLED defined in kernel/audit.h as element of enum
> > audit_state
> > and redefined in kernel/audit.c. This produces a warning when
> > kernel builds
> > with syscalls audit disabled and brokes kernel build if -Werror
> > used.
> > enum audit_state used in syscall audit code only. This patch
> > changes
> > enum audit_state constants prefix AUDIT to AUDITSC to avoid
> > AUDIT_DISABLED
> > redefinition.
> > 
> > Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
> > ---
> >  kernel/audit.h   |  8 ++++----
> >  kernel/auditsc.c | 34 +++++++++++++++++-----------------
> >  2 files changed, 21 insertions(+), 21 deletions(-)
> 
> Hi Sergey,
> 
> Thanks for sending a patch to fix this problem.  One comment below
> ...
> 
> > diff --git a/kernel/audit.h b/kernel/audit.h
> > index 1522e10..ee81f20 100644
> > --- a/kernel/audit.h
> > +++ b/kernel/audit.h
> > @@ -21,16 +21,16 @@
> >     a per-task filter.  At syscall entry, the audit_state is
> > augmented by
> >     the syscall filter. */
> >  enum audit_state {
> > -       AUDIT_DISABLED,         /* Do not create per-task
> > audit_context.
> > +       AUDITSC_DISABLED,       /* Do not create per-task
> > audit_context.
> >                                  * No syscall-specific audit
> > records can
> >                                  * be generated. */
> > -       AUDIT_BUILD_CONTEXT,    /* Create the per-task
> > audit_context,
> > +       AUDITSC_BUILD_CONTEXT,  /* Create the per-task
> > audit_context,
> >                                  * and fill it in at syscall
> >                                  * entry time.  This makes a full
> >                                  * syscall record available if some
> >                                  * other part of the kernel decides
> > it
> >                                  * should be recorded. */
> > -       AUDIT_RECORD_CONTEXT    /* Create the per-task
> > audit_context,
> > +       AUDITSC_RECORD_CONTEXT  /* Create the per-task
> > audit_context,
> >                                  * always fill it in at syscall
> > entry
> >                                  * time, and always write out the
> > audit
> >                                  * record at syscall exit time.  */
> 
> I believe that just as the AUDIT_ prefix proved to be a bit too
> generic, I think that the AUDITSC_ prefix is also not the best
> choice.
> Would you object to using the AUDIT_STATE_ prefix?  As that may get a
> bit long, I might suggest dropping the _CONTEXT from the enums too
> such that you would end up with the following:
> 
>   enum audit_state {
>     AUDIT_STATE_DISABLED,
>     AUDIT_STATE_BUILD,
>     AUDIT_STATE_RECORD,
>   };
> 
> Thoughts?
> 

