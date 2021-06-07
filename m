Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FEE939E4F7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jun 2021 19:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhFGRKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 13:10:13 -0400
Received: from mail-ej1-f48.google.com ([209.85.218.48]:41642 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhFGRKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 13:10:12 -0400
Received: by mail-ej1-f48.google.com with SMTP id ho18so16905262ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 10:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hftge2z/nCvoHEdxWR2iSOrmMyd0wmymVhWiCXlzW+g=;
        b=bHMz5TGtkKXuxGplLWe+Us5miWu/oHo+rYKagxGRMYVGJeSihqSKNYo7Zt+tPjMzOJ
         hGNCb/AmeDGwK34ugu1LUKRRqPhTdrHmHXi4jk/jretE3lrDCaANOtSD5u1qWUW8axM0
         xgNJobanOYQnSvYl5fi0E3Ut9BLX5JVApxuwsFnrb6Oqz7Pz0so0dBUtGdaovX2Y1IYa
         c9rS+OSZv6iVelbWbZDsy13zURRv434FmGyFqGyG9d87pIxItfNEEfbUbilNNF4TzxDj
         TWOg3EhPWNyKsPCk3gTJfC2CQ6dUDqh9BBvk6yne/iCwZTmCGlFMct8Q/mFL8zkcOTTb
         z4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hftge2z/nCvoHEdxWR2iSOrmMyd0wmymVhWiCXlzW+g=;
        b=LBWWTSYM2egKTBR32DTOlIfPYeTX4SNHwKMci7dvmw/hAn+eAnajUPGAnxFi4mIMMj
         6H7mkfAO0947j082s/Eoryq1PcsRZ9bZ705H3UN1/Ek1YGe3nR/VF/PtJEyrV5HmVI5q
         QrYSpl93bqESG8adX3r2LQfjmfP7J9vaEhK2T38RUq5bj4uFLwkE2LzPoQNS+FMdZu8Y
         Fdcebn+jYn880FdmTfpzeVJvuiPx3r4LrBUh2x05w0nQy90X5je56yjPvwzluNZS7ytk
         FP8YG0cO1y/plDc4XHdoOtcW3DFaS66MvOdwPxrPKFIVMg+jXJRBGlU1ydZAZU1PnTmX
         kQUg==
X-Gm-Message-State: AOAM5302RsTFX5iI/OxZ+CguCZpjBPXdetKRmpsqIeXO2SzEWwwBz8Vg
        wZwPc17mEDYS7y7nHxzVfFOGYyjBJ1I1kXCP2x5Z
X-Google-Smtp-Source: ABdhPJy7Wk9xnXyYncr43TZXNloVaPVqJXF2R3zQprtYyzXvhjyQr7IWORZ2c89vtYeYiCPDPoKlrzZBeNcoMfecrLs=
X-Received: by 2002:a17:907:10d8:: with SMTP id rv24mr18791462ejb.542.1623085640492;
 Mon, 07 Jun 2021 10:07:20 -0700 (PDT)
MIME-Version: 1.0
References: <ba47c2acb7bee9102bb6a85e9ba8b5918fa3610b.camel@yandex.ru>
 <CAHC9VhTvp3Z26JbXJdq8p4T7w3GZk-1CFWY328o75-AqqUbNTg@mail.gmail.com> <79d5bffd63b46bb7d54ebcef4765cfca28f76ff0.camel@yandex.ru>
In-Reply-To: <79d5bffd63b46bb7d54ebcef4765cfca28f76ff0.camel@yandex.ru>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 7 Jun 2021 13:07:09 -0400
Message-ID: <CAHC9VhQfzx6xhZz+ghkRB2UKWHmsHKjLzz_7z3L47GHOoHLchw@mail.gmail.com>
Subject: Re: [PATCH] audit: Rename enum audit_state constants to avoid
 AUDIT_DISABLED redefinition
To:     Sergey Nazarov <s-nazarov@yandex.ru>
Cc:     linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Eric Paris <eparis@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 7, 2021 at 5:58 AM Sergey Nazarov <s-nazarov@yandex.ru> wrote:
> Hi, Paul!
> I think this could be easer. It's enouth to rename AUDIT_DISABLE only.
> enum audit_state deals with per-task syscalls audit context, so we can
> use AUDIT_CONTEXT_DISABLED for example. If it's okay, I can send a new
> patch version.

Hi Sergey,

I personally prefer the AUDIT_STATE_* enums and would rather see that.

> =D0=92 =D0=A1=D0=B1, 05/06/2021 =D0=B2 22:40 -0400, Paul Moore =D0=BF=D0=
=B8=D1=88=D0=B5=D1=82:
> > On Fri, Jun 4, 2021 at 7:21 AM Sergey Nazarov <s-nazarov@yandex.ru>
> > wrote:
> > >
> > > AUDIT_DISABLED defined in kernel/audit.h as element of enum
> > > audit_state
> > > and redefined in kernel/audit.c. This produces a warning when
> > > kernel builds
> > > with syscalls audit disabled and brokes kernel build if -Werror
> > > used.
> > > enum audit_state used in syscall audit code only. This patch
> > > changes
> > > enum audit_state constants prefix AUDIT to AUDITSC to avoid
> > > AUDIT_DISABLED
> > > redefinition.
> > >
> > > Signed-off-by: Sergey Nazarov <s-nazarov@yandex.ru>
> > > ---
> > >  kernel/audit.h   |  8 ++++----
> > >  kernel/auditsc.c | 34 +++++++++++++++++-----------------
> > >  2 files changed, 21 insertions(+), 21 deletions(-)
> >
> > Hi Sergey,
> >
> > Thanks for sending a patch to fix this problem.  One comment below
> > ...
> >
> > > diff --git a/kernel/audit.h b/kernel/audit.h
> > > index 1522e10..ee81f20 100644
> > > --- a/kernel/audit.h
> > > +++ b/kernel/audit.h
> > > @@ -21,16 +21,16 @@
> > >     a per-task filter.  At syscall entry, the audit_state is
> > > augmented by
> > >     the syscall filter. */
> > >  enum audit_state {
> > > -       AUDIT_DISABLED,         /* Do not create per-task
> > > audit_context.
> > > +       AUDITSC_DISABLED,       /* Do not create per-task
> > > audit_context.
> > >                                  * No syscall-specific audit
> > > records can
> > >                                  * be generated. */
> > > -       AUDIT_BUILD_CONTEXT,    /* Create the per-task
> > > audit_context,
> > > +       AUDITSC_BUILD_CONTEXT,  /* Create the per-task
> > > audit_context,
> > >                                  * and fill it in at syscall
> > >                                  * entry time.  This makes a full
> > >                                  * syscall record available if some
> > >                                  * other part of the kernel decides
> > > it
> > >                                  * should be recorded. */
> > > -       AUDIT_RECORD_CONTEXT    /* Create the per-task
> > > audit_context,
> > > +       AUDITSC_RECORD_CONTEXT  /* Create the per-task
> > > audit_context,
> > >                                  * always fill it in at syscall
> > > entry
> > >                                  * time, and always write out the
> > > audit
> > >                                  * record at syscall exit time.  */
> >
> > I believe that just as the AUDIT_ prefix proved to be a bit too
> > generic, I think that the AUDITSC_ prefix is also not the best
> > choice.
> > Would you object to using the AUDIT_STATE_ prefix?  As that may get a
> > bit long, I might suggest dropping the _CONTEXT from the enums too
> > such that you would end up with the following:
> >
> >   enum audit_state {
> >     AUDIT_STATE_DISABLED,
> >     AUDIT_STATE_BUILD,
> >     AUDIT_STATE_RECORD,
> >   };
> >
> > Thoughts?
> >
>


--=20
paul moore
www.paul-moore.com
