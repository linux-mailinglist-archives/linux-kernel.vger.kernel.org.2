Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6737C3F518B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 21:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhHWTuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 15:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbhHWTue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 15:50:34 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1D8C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:49:51 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id g4-20020a4ab044000000b002900bf3b03fso582831oon.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zTRs4BS0zxZLB3LmR+LQQP1mEXdfXgwLSSOmcQuzVM=;
        b=TKOlOqAtEwSItfC/SYqWQ37BFqbPOoDsulmCCgWgHgxQsR0HiSEu9vYLc504KkwwZF
         4WttrWCItzSxKu0zYwLopJ9VUrw7baHi3lpfWY2rE3Py53K1prRnh2+yhi4KRwCy56al
         lmqoD8Yvb10KZeYt+sI7YLl98qplcFklcsdKGXmbCVrUllZKCOnZuSbLwTGpys0YcHG2
         NNSv34fNQ8tlamnSauPHfp7cJ3FoR3rwbxS4otUpNoPNAsk4xuaCahbAhihPP9PjbWao
         NBWeEp1orLn0B4WXbON4TnfxqUmHu4hLO1LsVM7FyRvA5krg2NHtBaYms9yjPVYuiz+Q
         7ZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zTRs4BS0zxZLB3LmR+LQQP1mEXdfXgwLSSOmcQuzVM=;
        b=P12e7Ec+7Gs1IqxNeOlaUdSZl3FZWEVZCYPnX7zhW2BiOOeiUye3JWLNDZWE43ma6L
         YHmMwXldWXez0rTfxKUaSrPPYR6xT+Ndas1AvzhMwHY6WtuzyPGDERNmERNR1ULDiyoP
         P7OurEILRXpgHPfiDbUb6xjSmrVagbNF4cRmCPgOKxLe1MoUYKacMyFY+EzBo/rqrtDE
         rrj6TBRx+qK07iK0mEdwNOYMbPG8U9VljtRaQFr6Tve3ktUAPeKioG2b/YG/6o+noWfS
         LGXQAoeg9Jgs2cRSezx8fjrRpYKSZm6UuTCabCyAxzRB4LRzud/vEF/wXA7NwmJdMyFA
         fyWg==
X-Gm-Message-State: AOAM530q4boAe8mndetzT6nGYPUfk1B3f8EadAnH+RITBqruyOgbcJtC
        HGhlMM3KNM37Ki47vuZtbhNhhcyglD+wAZ1dF5fxtPKmuW8=
X-Google-Smtp-Source: ABdhPJwtqT1MYncFYx1ABQOt4lWM7n/Z3lCopKobiq4xA1qo98CVYGAMhhzxlNjsp/B4DmLNC5MG2pfDXNh+XRwLE8I=
X-Received: by 2002:a4a:4484:: with SMTP id o126mr3720094ooa.90.1629748190992;
 Mon, 23 Aug 2021 12:49:50 -0700 (PDT)
MIME-Version: 1.0
References: <YSP6Lv53QV0cOAsd@zn.tnic>
In-Reply-To: <YSP6Lv53QV0cOAsd@zn.tnic>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 23 Aug 2021 15:49:39 -0400
Message-ID: <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
Subject: Re: ERROR: modpost: "pm_suspend_target_state" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko]
 undefined!
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <Lijo.Lazar@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 3:43 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Hi folks,
>
> I'm seeing this:
>
> ERROR: modpost: "pm_suspend_target_state" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> make[1]: *** [scripts/Makefile.modpost:150: modules-only.symvers] Error 1
> make[1]: *** Deleting file 'modules-only.symvers'
> make: *** [Makefile:1766: modules] Error 2
> make: *** Waiting for unfinished jobs....
>
> with the attached config which has
>
> # CONFIG_SUSPEND is not set
>
> on latest Linus tree.
>
> It probably has been fixed already but lemme report it just in case.

Maybe fixed with this patch?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5706cb3c910cc8283f344bc37a889a8d523a2c6d

Alex

>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette
