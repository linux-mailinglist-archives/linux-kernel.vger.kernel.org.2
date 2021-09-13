Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B801409E11
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 22:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbhIMUVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 16:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241893AbhIMUVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 16:21:15 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183DBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:19:59 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 9so16173694edx.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 13:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a6cDeTvVM/zwuAekpHf0unWAPapurIVQ8FF1NNOdAUw=;
        b=sPoy/dS3wFFuiTrUc9FWgn/a+pIInQwVXZDUCfZrt/nRsTJSJfnLpiJFPHkKzvCIZa
         onPHm/+SGfI/11cIX+N2K9iKl91Vi85K4823RHjOhsYOkZZyT3r6LdVvAawfjW0/6P/J
         w4pHIjRmSZM+YNvsPxXp2uLEyC2dd8RGeM76t8PCUtHc8Yasb0UmofvVR+zBMcdlxmaI
         J2ad6YZ75zK8lAgn3Z6Ih3+1lkkw4FegxETcJK1D1L/UqzVkv4CrlRt9iYmEJ8eQ8qhm
         xdw5u+QtkptWiw98qira3GEy0clqaidZpTCCe3DbuypPXA+jq81x//wgHNCGcDAPUqnO
         0ZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a6cDeTvVM/zwuAekpHf0unWAPapurIVQ8FF1NNOdAUw=;
        b=xKMhY1427uGWECQCUJ1OwPkteyXh7EqLL+hPXcFa+frfNgwIhMNevOFUu3AARu4kcW
         lCdx4pgvnJ+rYTSou2GLAQN5XPi401mYlzgqIz3Cxyb3qc5HtgKHXVP49JtW8ORRg8WS
         m7xUzONzk9jX3KETac9WJwE0dRzClFXz/cqEtpbVRB+55ZGUMluL9MbCcbCnbgVWxdNu
         cNYDdsECu4/0/Yi/1qGBXlCHnDkYDYX0/mI2zi77+j7iD5TZN/ujL1UzV7SDSgn8IS2T
         ZTRGQjapan21fwqTw873zO/fpH3DphxQlAxDcbaodkKQwHzR3/5KFkGX2BHZR6e2ACQP
         mZPw==
X-Gm-Message-State: AOAM533Ocj/bEKdRRRevM3eaXNgbzRW+2bTaGOYpU7CaD2gUs4a2lz19
        3q0d1n0ivOAYhbprS54BoxZNY1xOvIxkiMq5rVPY
X-Google-Smtp-Source: ABdhPJzXztdoaWcmdR79de3Ty/sKwyB2qHD8EM1jfTUpK2BcaoJb8HBR6a7zJmM2CQIaTVZDUNOG8hONRx/ACwD7zds=
X-Received: by 2002:aa7:dd4e:: with SMTP id o14mr14707466edw.104.1631564397579;
 Mon, 13 Sep 2021 13:19:57 -0700 (PDT)
MIME-Version: 1.0
References: <4e2370a9022495c49f3108fe34c5a2b2f4b28dfa.1630684009.git.christophe.leroy@csgroup.eu>
 <CAHC9VhS4Q8U6ZVPoSaVuDawMLS6VOtwZZVNMT1QeFAJUeQHj-Q@mail.gmail.com>
 <2057e2ab-b303-8ec6-9c43-2c2614591925@csgroup.eu> <CAHC9VhRV06YHwy5cAAiRvOPUGQ9s1LkOdacMAJVzwykD8B_sgA@mail.gmail.com>
 <MRZP264MB29885BAAB4F2D486BB33D201EDD39@MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM>
In-Reply-To: <MRZP264MB29885BAAB4F2D486BB33D201EDD39@MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 13 Sep 2021 16:19:46 -0400
Message-ID: <CAHC9VhSDP4M8_3pr2FpTdG08Q+agovtsRshpG8e+SHCe+hY_vQ@mail.gmail.com>
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

On Tue, Sep 7, 2021 at 11:45 AM LEROY Christophe
<christophe.leroy@csgroup.eu> wrote:
> > -----Message d'origine-----
> > De : Paul Moore <paul@paul-moore.com>
> > On Mon, Sep 6, 2021 at 2:41 AM LEROY Christophe
> > <christophe.leroy@csgroup.eu> wrote:
> > > Le 03/09/2021 =C3=A0 19:06, Paul Moore a =C3=A9crit :
> > > > On Fri, Sep 3, 2021 at 11:48 AM Christophe Leroy
> > > > <christophe.leroy@csgroup.eu> wrote:
> > > >>
> > > >> struct node defined in kernel/audit_tree.c conflicts with struct
> > > >> node defined in include/linux/node.h
> > > >>
> > > >>            CC      kernel/audit_tree.o
> > > >>          kernel/audit_tree.c:33:9: error: redefinition of 'struct =
node'
> > > >>             33 |  struct node {
> > > >>                |         ^~~~
> > > >>          In file included from ./include/linux/cpu.h:17,
> > > >>                           from ./include/linux/static_call.h:102,
> > > >>                           from ./arch/powerpc/include/asm/machdep.=
h:10,
> > > >>                           from ./arch/powerpc/include/asm/archrand=
om.h:7,
> > > >>                           from ./include/linux/random.h:121,
> > > >>                           from ./include/linux/net.h:18,
> > > >>                           from ./include/linux/skbuff.h:26,
> > > >>                           from kernel/audit.h:11,
> > > >>                           from kernel/audit_tree.c:2:
> > > >>          ./include/linux/node.h:84:8: note: originally defined her=
e
> > > >>             84 | struct node {
> > > >>                |        ^~~~
> > > >>          make[2]: *** [kernel/audit_tree.o] Error 1
> > > >>
> > > >> Rename it audit_node.
> > > >>
> > > >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > > >> ---
> > > >>   kernel/audit_tree.c | 20 ++++++++++----------
> > > >>   1 file changed, 10 insertions(+), 10 deletions(-)
> > > >
> > > > That's interesting, I wonder why we didn't see this prior?  Also as
> > > > an aside, there are evidently a good handful of symbols named
> > > > "node".  In fact I don't see this now in the audit/stable-5.15 or
> > > > Linus' tree as of a right now, both using an allyesconfig:
> > > >
> > > > % git show-ref HEAD
> > > > a9c9a6f741cdaa2fa9ba24a790db8d07295761e3 refs/remotes/linus/HEAD %
> > > > touch kernel/audit_tree.c % make C=3D1 kernel/
> > > >   CALL    scripts/checksyscalls.sh
> > > >   CALL    scripts/atomic/check-atomics.sh
> > > >   DESCEND objtool
> > > >   CHK     kernel/kheaders_data.tar.xz
> > > >   CC      kernel/audit_tree.o
> > > >   CHECK   kernel/audit_tree.c
> > > >   AR      kernel/built-in.a
> > > >
> > > > What tree and config are you using where you see this error?
> > > > Looking at your error, I'm guessing this is limited to ppc builds,
> > > > and if I look at the arch/powerpc/include/asm/machdep.h file in
> > > > Linus tree I don't see a static_call.h include so I'm guessing this
> > > > is a -next tree for ppc?  Something else?
> > > >
> > > > Without knowing the context, is adding the static_call.h include in
> > > > arch/powerpc/include/asm/machdep.h intentional or simply a bit of
> > > > include file creep?
> > >
> > > struct machdep_calls in asm/machdep.h is full of function pointers an=
d
> > > I'm working on converting that to static_calls
> > > (https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=3D260=
878
> > > &state=3D*)
> > >
> > > So yes, adding static_call.h in asm/machdep.h is intentional and the
> > > issue was detected by CI build test
> > > (http://kisskb.ellerman.id.au/kisskb/buildresult/14628100/)
> > >
> > > I submitted this change to you because for me it make sense to not
> > > re-use globably defined struct names in local C files, and anybody ma=
y
> > > encounter the problem as soon as linux/node.h gets included directly
> > > or indirectly. But if you prefer I guess the fix may be merged throug=
h
> > > powerpc tree as part of this series.
> >
> > Yes, this patch should go in via the audit tree, and while I don't have=
 an
> > objection to the patch, whenever I see a patch to fix an issue that is =
not visible in
> > Linus' tree or the audit tree it raises some questions.  I usually hope=
 to see those
> > questions answered proactively in the cover letter and/or patch descrip=
tion but
> > that wasn't the case here so you get to play a game of 20 questions.
> >
> > Speaking of which, I don't recall seeing an answer to the "where do the=
se
> > include file changes live?" question, is is the ppc -next tree, or are =
they still
> > unmerged and just on the ppc list?
>
> It is still an RFC in the ppc list.

I just merged this into audit/next but I rewrote chunks of the subject
line and commit description as the build failure isn't yet "real" as
the offending patch is still just a RFC.  Hopefully be merging this
patch into audit/next now we'll prevent future problems if/when the
other patch is merged.

--=20
paul moore
www.paul-moore.com
