Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07C8738D2FD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 04:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhEVCY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 22:24:59 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:50521 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbhEVCY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 22:24:56 -0400
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 14M2Mtv0010761
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 11:22:56 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 14M2Mtv0010761
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621650176;
        bh=EPGned69FKUpkJI4QLd6tg1KYZSxfDCHyOxPCM5QqnU=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=BXLeU/SEtBR404q86CpeXocPi7voKf4PhMclP5ED+UAHz+CDvjAaaRRN6jv27QS3f
         byhRfKEii7fjP/oW8Ay7KXTKYLZAjf2wDfYjyDM5O7xPLRDZoU/AChNZpx/Ay/N7mX
         +68gMEt+vE7N4+PvAA5bInkBICc4uck+DhDwByJnbFwLl9LExh5/fG2+GrpXUkVGWV
         LQdCQWrhpN93mSAmMMbwfYn7KevbYzomnKpQBw8bSQinbA50wYPWd0Y8dpV7Tf9MDm
         4bU/WlHswuZ2XIwmBHRENDneNhSCozbTh14BXi/eYJQ6POqbpLbMqDdx/4cfJbKede
         BeyUt0ZYIuwQw==
X-Nifty-SrcIP: [209.85.210.175]
Received: by mail-pf1-f175.google.com with SMTP id c12so4652571pfl.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 19:22:56 -0700 (PDT)
X-Gm-Message-State: AOAM533p3EpmIXqNepMrVlV6TCEunyPJPA8vTmrZA0mxUJ6IW/EZYjto
        w+5vc9iOShLeHqfu2Ggl+dpy0eFJKwJiI+vu2dU=
X-Google-Smtp-Source: ABdhPJw1Lm3WCTCLlBMpOL19Gi7VpiN6h+rTGq0BEb+eMQuBveC618Vv/WDLZU4oohnVjDO+fwduXxzz4XsGRCH6CKA=
X-Received: by 2002:a62:ab14:0:b029:2db:b3d9:1709 with SMTP id
 p20-20020a62ab140000b02902dbb3d91709mr12881875pff.80.1621650175519; Fri, 21
 May 2021 19:22:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210430015627.65738-1-masahiroy@kernel.org> <162162208791.14477.6963689219198766644.git-patchwork-notify@kernel.org>
 <CAK7LNAST-2CDycoAsKEmVw-56um7HHs07smaWemsOsL8eo+F6w@mail.gmail.com>
In-Reply-To: <CAK7LNAST-2CDycoAsKEmVw-56um7HHs07smaWemsOsL8eo+F6w@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 22 May 2021 11:22:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNATWFLTKYBg6OOc5JQeb5mZXjUXqo0GNU3vAqVrwfcqDew@mail.gmail.com>
Message-ID: <CAK7LNATWFLTKYBg6OOc5JQeb5mZXjUXqo0GNU3vAqVrwfcqDew@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: replace LANG=C with LC_ALL=C
To:     patchwork-bot+linux-kselftest@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 11:14 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sat, May 22, 2021 at 3:34 AM
> <patchwork-bot+linux-kselftest@kernel.org> wrote:
> >
> > Hello:
> >
> > This patch was applied to shuah/linux-kselftest.git (refs/heads/next):
> >
> > On Fri, 30 Apr 2021 10:56:27 +0900 you wrote:
> > > LANG gives a weak default to each LC_* in case it is not explicitly
> > > defined. LC_ALL, if set, overrides all other LC_* variables.
> > >
> > >   LANG  <  LC_CTYPE, LC_COLLATE, LC_MONETARY, LC_NUMERIC, ...  <  LC_ALL
> > >
> > > This is why documentation such as [1] suggests to set LC_ALL in build
> > > scripts to get the deterministic result.
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - [v2] kbuild: replace LANG=C with LC_ALL=C
> >     https://git.kernel.org/shuah/linux-kselftest/c/77a88274dc1a
> >
> > You are awesome, thank you!
> > --
>
>
> Huh?
>
> This patch exists in Linus' tree.
>
> Why is this going to the kselftest tree
> in the first place?


Sorry, I misunderstood it.

I think this notification was unneeded
because the commit was not actually
applied to kselftest tree.


--
Best Regards
Masahiro Yamada
