Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04A543CBDB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 16:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242485AbhJ0OVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 10:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242500AbhJ0OVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:21:23 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB161C0613B9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:18:57 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id w15so11218039edc.9
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 07:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=A7VSAROM1Lq92tsQzcvA0FV6paOOKRRSG0CkqXmrfHY=;
        b=WO/8J0WHy3bqbZ8bWtK8os21bmAyrg+d4GoI0FdQVNmBnedrhDrQwHoExDY2HYNc56
         wuGhdsWbyO6HMLfe7SEFEzeORWHjKA3PZMg0C1afDFnRQUD4ZqFUyBM5nPwZFehS7m/X
         W/E1Vfn3gFK5Z6fjNK0H27jiZurO+y4SQwZaV5JTnwtZ2OLx5cmApkpw8B1O6X9Xo+om
         726nvMv4VOVc1TVOL4hZMFRAdnEIUsRQn11GxzVLikDaXwVX/sMLg1dKx8sp7Q28O1DL
         OhJN2gwLwq3QBfaJBJecj9D85HBBgpvARrJFIHfm0cmYWs/UjVH5m3m/ip7qm2ysF2c5
         YYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=A7VSAROM1Lq92tsQzcvA0FV6paOOKRRSG0CkqXmrfHY=;
        b=VkOync8acbbhtOMNBbJPxpFNCg/fKPnuRwcI8mH1we7tMTF9S3t7LpfP1oNrgTiLrf
         woECgUDsNJZlForCdpVzPGUZXfgoMkrpjRyToQnidNUNBzZAXpdXwl+uSmBwnDFKXRX1
         e41LFReQ7sKyFo2SCGtT7cNsZ1j/NREk30x28d6tuKfLuNHbAR2LbyGIajR3trvoYN7E
         jhTsPaKStskcf9xOLc0nLh2uQbGVq40oTrdFGcgH+2MAsj4dXOh27OLDN7I94cmMGBVu
         DcaucAh5n37mg1eBCh3r7ijFMFQnnNBoyBa0Pbric0pY+gl3xSR9Va+JHCnkbritHbFK
         V4jA==
X-Gm-Message-State: AOAM531F640czfn1D2JnAShGEFmMDPQk5Z9JHXmuZ+Mog01p6zz8oMoQ
        Y7dLumyQSdwr3o/1b3Z4lHupXdahBjeOLqMXQNHA
X-Google-Smtp-Source: ABdhPJx/AVRgyCKdtHofrLmeNbJZOE7jZKTiy9OBTXYs7O2Og+i8eOPvBwKXpaar1l0AT/K2AG1HPgfhyoHnEQ1j4vY=
X-Received: by 2002:a17:906:919:: with SMTP id i25mr38774337ejd.171.1635344330893;
 Wed, 27 Oct 2021 07:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20211026133147.35d19e00@canb.auug.org.au> <87k0i0awdl.fsf@mpe.ellerman.id.au>
 <CAHC9VhTj7gn3iAOYctVRKvv_Bk1iQMrmkA8FVJtYzdvBjqFmvg@mail.gmail.com>
 <87tuh2aepp.fsf@mpe.ellerman.id.au> <2012df5e-62ec-06fb-9f4d-e27dde184a3f@csgroup.eu>
In-Reply-To: <2012df5e-62ec-06fb-9f4d-e27dde184a3f@csgroup.eu>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 27 Oct 2021 10:18:40 -0400
Message-ID: <CAHC9VhRHs8Lx8+v+LHmJByxO_m330sfLWRsGDsFtQxyQ1860eg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the audit tree with the powerpc tree
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Richard Guy Briggs <rgb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 7:41 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
> Le 27/10/2021 =C3=A0 13:29, Michael Ellerman a =C3=A9crit :
> > Paul Moore <paul@paul-moore.com> writes:
> >> On Tue, Oct 26, 2021 at 6:55 AM Michael Ellerman <mpe@ellerman.id.au> =
wrote:
> >>> Stephen Rothwell <sfr@canb.auug.org.au> writes:
> >>>> Hi all,
> >>>>
> >>>> Today's linux-next merge of the audit tree got conflicts in:
> >>>>
> >>>>    arch/powerpc/kernel/audit.c
> >>>>    arch/powerpc/kernel/compat_audit.c
> >>>>
> >>>> between commit:
> >>>>
> >>>>    566af8cda399 ("powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPA=
T_GENERIC")
> >>>>
> >>>> from the powerpc tree and commits:
> >>>>
> >>>>    42f355ef59a2 ("audit: replace magic audit syscall class numbers w=
ith macros")
> >>>>    1c30e3af8a79 ("audit: add support for the openat2 syscall")
> >>>>
> >>>> from the audit tree.
> >>>
> >>> Thanks.
> >>>
> >>> I guess this is OK, unless the audit folks disagree. I could revert t=
he
> >>> powerpc commit and try it again later.
> >>>
> >>> If I don't hear anything I'll leave it as-is.
> >>
> >> Hi Michael,
> >>
> >> Last I recall from the powerpc/audit thread there were still some
> >> issues with audit working properly in your testing, has that been
> >> resolved?
> >
> > No.
> >
> > There's one test failure both before and after the conversion to use th=
e
> > generic code.
> >
> >> If nothing else, -rc7 seems a bit late for this to hit -next for me to
> >> feel comfortable about this.
> >
> > OK. I'll revert the patch in my tree.
>
> But it's been in the pipe since end of August and no one reported any
> issue other issue than the pre-existing one, so what's the new issue
> that prevents us to merge it two monthes later, and how do we walk
> forward then ?

We work to resolve the test failure, it's that simple.  I haven't seen
the failure so I haven't been much help to do any sort of root cause
digging on the problem, it would be helpful if those who are seeing
the problem could dig into the failure and report back on what they
find.  That is what has been missing and why I never ACK'd or merged
the powerpc audit code.

--=20
paul moore
www.paul-moore.com
