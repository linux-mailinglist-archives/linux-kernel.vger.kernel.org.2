Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04BD402BE4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 17:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345336AbhIGPfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345324AbhIGPfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:35:50 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437DDC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 08:34:44 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id mf2so20463245ejb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 08:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sLshdDJWTTxA1z2zwu565QHDwZZYVlc/2rDF0k3QQOs=;
        b=jJWU6ZzgjW+vIdktCRGus45oL51TsOHWzjLW9DhObevYhpEBIdr+vvmEjuGaE40usA
         9NhuAH2l9i7vuIJHBdV8oOigcwMqsCQIGs3995I55NIR3ggYo1Fi+2YQ+DYnO6bSJP3l
         Wtr24nOmCP2fzcKEqm91GC+IqzCAoW9Pbxszay56eb0szI050K7QPPhQNGoMCyFdCRXz
         Xybf+RZS/WGQSFbaptf7azB0hJNgpxHVl1VMMRBHvKKKQGFC/snb7oF8nWuPwsJwAqFr
         /oy9XWuvt3RTMudw0xy5IP/4GnUS4HPVZ5KyZdSqZ6vF6JCkrQBO/wMjDz5DWsq9hVrI
         v79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sLshdDJWTTxA1z2zwu565QHDwZZYVlc/2rDF0k3QQOs=;
        b=M0nyPqLyHd7PZbOnPlau10YQ/pKDgeooZ1Oibf3mj2K1DRpQLHuQIDVFWLmvJ58vM+
         2MhY6oFmClp+4uVQq6WPVv0KfKrF4ZgOl0H5BVyn/4zdJ54Lt0Yy7gBbVkl2NK26r9jW
         BjiZk6X+XgJO8f9RhMwPCD5tFp/O+Bv5DU3zOlaU/NCISN2Z0Lut8JrdDUqNiXtfEOrl
         eLIdZyEW6WHo6OnKwH1nhuHz5O3Wi97w5RjqWSSZ6GOVkiHwXnsjIc0J3ArFASfUUh4X
         U2doef0N+Pn47hL7SiYaNwVehxoyqNF15XX0gkYk5mItyFQW5GvJLckYSXdSmOvpKAmP
         RcPQ==
X-Gm-Message-State: AOAM5331JuucCH9mzbeg+M/mxPfJxqyA1UzBU93YMPkU/DFdAm35SQaX
        8L0WkR4y4eqtniVANdvCGLHC31LpycJ3XbPtS01s
X-Google-Smtp-Source: ABdhPJy96oHO23rrypc24/EC+mCPa7QQ6KFYu4vzS2aQNnsTeAR8uLjzrip2aDwB461s2qRnHGPt6ZxJz17TQzioyAU=
X-Received: by 2002:a17:906:8802:: with SMTP id zh2mr19390869ejb.344.1631028882670;
 Tue, 07 Sep 2021 08:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <4e2370a9022495c49f3108fe34c5a2b2f4b28dfa.1630684009.git.christophe.leroy@csgroup.eu>
 <CAHC9VhS4Q8U6ZVPoSaVuDawMLS6VOtwZZVNMT1QeFAJUeQHj-Q@mail.gmail.com> <2057e2ab-b303-8ec6-9c43-2c2614591925@csgroup.eu>
In-Reply-To: <2057e2ab-b303-8ec6-9c43-2c2614591925@csgroup.eu>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 7 Sep 2021 11:34:31 -0400
Message-ID: <CAHC9VhRV06YHwy5cAAiRvOPUGQ9s1LkOdacMAJVzwykD8B_sgA@mail.gmail.com>
Subject: Re: [PATCH] audit: Fix build failure by renaming struct node to
 struct audit_node
To:     LEROY Christophe <christophe.leroy@csgroup.eu>
Cc:     Eric Paris <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 2:41 AM LEROY Christophe
<christophe.leroy@csgroup.eu> wrote:
> Le 03/09/2021 =C3=A0 19:06, Paul Moore a =C3=A9crit :
> > On Fri, Sep 3, 2021 at 11:48 AM Christophe Leroy
> > <christophe.leroy@csgroup.eu> wrote:
> >>
> >> struct node defined in kernel/audit_tree.c conflicts with
> >> struct node defined in include/linux/node.h
> >>
> >>            CC      kernel/audit_tree.o
> >>          kernel/audit_tree.c:33:9: error: redefinition of 'struct node=
'
> >>             33 |  struct node {
> >>                |         ^~~~
> >>          In file included from ./include/linux/cpu.h:17,
> >>                           from ./include/linux/static_call.h:102,
> >>                           from ./arch/powerpc/include/asm/machdep.h:10=
,
> >>                           from ./arch/powerpc/include/asm/archrandom.h=
:7,
> >>                           from ./include/linux/random.h:121,
> >>                           from ./include/linux/net.h:18,
> >>                           from ./include/linux/skbuff.h:26,
> >>                           from kernel/audit.h:11,
> >>                           from kernel/audit_tree.c:2:
> >>          ./include/linux/node.h:84:8: note: originally defined here
> >>             84 | struct node {
> >>                |        ^~~~
> >>          make[2]: *** [kernel/audit_tree.o] Error 1
> >>
> >> Rename it audit_node.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >> ---
> >>   kernel/audit_tree.c | 20 ++++++++++----------
> >>   1 file changed, 10 insertions(+), 10 deletions(-)
> >
> > That's interesting, I wonder why we didn't see this prior?  Also as an
> > aside, there are evidently a good handful of symbols named "node".  In
> > fact I don't see this now in the audit/stable-5.15 or Linus' tree as
> > of a right now, both using an allyesconfig:
> >
> > % git show-ref HEAD
> > a9c9a6f741cdaa2fa9ba24a790db8d07295761e3 refs/remotes/linus/HEAD
> > % touch kernel/audit_tree.c
> > % make C=3D1 kernel/
> >   CALL    scripts/checksyscalls.sh
> >   CALL    scripts/atomic/check-atomics.sh
> >   DESCEND objtool
> >   CHK     kernel/kheaders_data.tar.xz
> >   CC      kernel/audit_tree.o
> >   CHECK   kernel/audit_tree.c
> >   AR      kernel/built-in.a
> >
> > What tree and config are you using where you see this error?  Looking
> > at your error, I'm guessing this is limited to ppc builds, and if I
> > look at the arch/powerpc/include/asm/machdep.h file in Linus tree I
> > don't see a static_call.h include so I'm guessing this is a -next tree
> > for ppc?  Something else?
> >
> > Without knowing the context, is adding the static_call.h include in
> > arch/powerpc/include/asm/machdep.h intentional or simply a bit of
> > include file creep?
>
> struct machdep_calls in asm/machdep.h is full of function pointers and
> I'm working on converting that to static_calls
> (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D260878&=
state=3D*)
>
> So yes, adding static_call.h in asm/machdep.h is intentional and the
> issue was detected by CI build test
> (http://kisskb.ellerman.id.au/kisskb/buildresult/14628100/)
>
> I submitted this change to you because for me it make sense to not
> re-use globably defined struct names in local C files, and anybody may
> encounter the problem as soon as linux/node.h gets included directly or
> indirectly. But if you prefer I guess the fix may be merged through
> powerpc tree as part of this series.

Yes, this patch should go in via the audit tree, and while I don't
have an objection to the patch, whenever I see a patch to fix an issue
that is not visible in Linus' tree or the audit tree it raises some
questions.  I usually hope to see those questions answered proactively
in the cover letter and/or patch description but that wasn't the case
here so you get to play a game of 20 questions.

Speaking of which, I don't recall seeing an answer to the "where do
these include file changes live?" question, is is the ppc -next tree,
or are they still unmerged and just on the ppc list?

--=20
paul moore
www.paul-moore.com
