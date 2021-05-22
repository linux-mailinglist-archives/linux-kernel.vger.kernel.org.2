Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B5638D2F5
	for <lists+linux-kernel@lfdr.de>; Sat, 22 May 2021 04:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhEVCQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 22:16:57 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:53565 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbhEVCQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 22:16:56 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 14M2F3hC003882
        for <linux-kernel@vger.kernel.org>; Sat, 22 May 2021 11:15:04 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 14M2F3hC003882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1621649704;
        bh=4Aw2OFXnuy6gv0xA0xiEWBCj1w+CAdcrvr+rK0CQxAU=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=hcs3gVJHqV15kNLpKFAsLCH7QL+PmsapWiEA6j3cl/rkwB3WQUELL1TmyKj1EUsEr
         vnea+nz/u1rp9AObm95hm6Br2EIL7b3NpcWy/KHJlYNdwUlwiYeTuv65AEsVQX83Gh
         2yvkMUs1PrRtHryhWegIHixFltPuWU+5pS8ppEULY+SjdNyYtdEkbavJKBRXZWnyRm
         kS36F33U24hBHB1eNRXkqk0D9AZFWGPrJCHaDj6N2lOBZ80i5AQ3uIXkUNL/KzNnhJ
         wJybHr9zyzSJEY10r9ZhkjNoJVhWMzQCfhT7QHzVeX/eChXstDqL6e02c8yuBtJqPG
         hjswYnaUl/mJA==
X-Nifty-SrcIP: [209.85.216.53]
Received: by mail-pj1-f53.google.com with SMTP id b9-20020a17090a9909b029015cf9effaeaso8258847pjp.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 19:15:03 -0700 (PDT)
X-Gm-Message-State: AOAM533iefGstY6s/2oRHm45uY0co5kNZMUWX3WSbBhGcHievZRFfUZb
        AWSRyleVIbPQx+Epxhf+ETvH0ZliqAvsMSBDVqw=
X-Google-Smtp-Source: ABdhPJx26DBPGeVIGoCze3uS6lPlnA+tE/VShWtF2MtgS47JF2uO7kSTv/2uYmN86Yc5x60aewf0auZb7mXFWRdCrGw=
X-Received: by 2002:a17:903:228a:b029:f7:9f7e:aa2c with SMTP id
 b10-20020a170903228ab02900f79f7eaa2cmr4551199plh.71.1621649703021; Fri, 21
 May 2021 19:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210430015627.65738-1-masahiroy@kernel.org> <162162208791.14477.6963689219198766644.git-patchwork-notify@kernel.org>
In-Reply-To: <162162208791.14477.6963689219198766644.git-patchwork-notify@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 22 May 2021 11:14:24 +0900
X-Gmail-Original-Message-ID: <CAK7LNAST-2CDycoAsKEmVw-56um7HHs07smaWemsOsL8eo+F6w@mail.gmail.com>
Message-ID: <CAK7LNAST-2CDycoAsKEmVw-56um7HHs07smaWemsOsL8eo+F6w@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: replace LANG=C with LC_ALL=C
To:     patchwork-bot+linux-kselftest@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 22, 2021 at 3:34 AM
<patchwork-bot+linux-kselftest@kernel.org> wrote:
>
> Hello:
>
> This patch was applied to shuah/linux-kselftest.git (refs/heads/next):
>
> On Fri, 30 Apr 2021 10:56:27 +0900 you wrote:
> > LANG gives a weak default to each LC_* in case it is not explicitly
> > defined. LC_ALL, if set, overrides all other LC_* variables.
> >
> >   LANG  <  LC_CTYPE, LC_COLLATE, LC_MONETARY, LC_NUMERIC, ...  <  LC_ALL
> >
> > This is why documentation such as [1] suggests to set LC_ALL in build
> > scripts to get the deterministic result.
> >
> > [...]
>
> Here is the summary with links:
>   - [v2] kbuild: replace LANG=C with LC_ALL=C
>     https://git.kernel.org/shuah/linux-kselftest/c/77a88274dc1a
>
> You are awesome, thank you!
> --


Huh?

This patch exists in Linus' tree.

Why is this going to the kselftest tree
in the first place?



commit 77a88274dc1a2cf3a775161d9a3242bc798ee680
Author: Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri Apr 30 10:56:27 2021 +0900

    kbuild: replace LANG=C with LC_ALL=C

    LANG gives a weak default to each LC_* in case it is not explicitly
    defined. LC_ALL, if set, overrides all other LC_* variables.

      LANG  <  LC_CTYPE, LC_COLLATE, LC_MONETARY, LC_NUMERIC, ...  <  LC_ALL

    This is why documentation such as [1] suggests to set LC_ALL in build
    scripts to get the deterministic result.

    LANG=C is not strong enough to override LC_* that may be set by end
    users.

    [1]: https://reproducible-builds.org/docs/locales/

    Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
    Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)
    Reviewed-by: Matthias Maennich <maennich@google.com>
    Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net> (mptcp)
    Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>






--
Best Regards
Masahiro Yamada
