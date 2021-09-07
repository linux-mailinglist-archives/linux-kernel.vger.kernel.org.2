Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C368402F4A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346610AbhIGT6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346361AbhIGT6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:58:04 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E481C0612A6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:56:50 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id w78so36460qkb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B/Edk4LBvfx9KZTPxI+wCQZQrNHzI91hTxxTHmpXYcg=;
        b=THT107TMWHUXrfqR+8kWpmGAqYj44+aNM71kA+mDhbI2QpWNQIk+F1tRBpCciU3r/b
         FrA2/GjjdY79cFGVTuDVK/uPHa8nM0wVqY/8xTWcnuvvXowj9W04bJap+FlPfduTg05d
         kk6PAVx5GNvDpX473oeEGMCASW/rfguG4GYr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B/Edk4LBvfx9KZTPxI+wCQZQrNHzI91hTxxTHmpXYcg=;
        b=gcZm6cWW/lM2lbN4wi6UjLWTvXcF8eAruuLjaMsF68i5j1dODsy8q5VT7r0SzI1Bxt
         Zs+26jX68laTc8XslTJZC5LnrFPPyu5bHiNWrnBEMUT6kJ7MV+vUxgFAHhF6zeD3qD8A
         eKoKwcwH8noBJ0UWFK29Uf+S5pDH7xLtCbPr3Om7rJ8mERzQMS4osBha8ldzbdXTEMPy
         EgvE7EjtydaIXw7n97uONKy9p7PgDcL46m3IG9IeMQeybVGA8in/Cg/mouwsKNnED7i4
         vX0Kv070o1AHZA2XhqqwKqYki0IShvtzD1xO3fzdQWsXbaNuBuFii75Dx9DAa8AJJlv6
         7wfA==
X-Gm-Message-State: AOAM5317+NUHghb07BAKqdNfzqatK1wjkXaW1nEn9nMBnJsg3ztn2jfC
        dfEfcdgZzBwr6wYgGILTferwggC5cOlQ2A==
X-Google-Smtp-Source: ABdhPJxAnNBJwxIS/AdEwBflPdiomQ4uO4hxydRTqQWkwIZmInKPj9+HszAE/vWgBXHSlBs5TbpAMw==
X-Received: by 2002:ae9:dd43:: with SMTP id r64mr17060789qkf.225.1631044609470;
        Tue, 07 Sep 2021 12:56:49 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id l13sm17947qkp.97.2021.09.07.12.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:56:49 -0700 (PDT)
Date:   Tue, 7 Sep 2021 15:56:47 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     pr-tracker-bot@kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] gpio: updates for v5.15
Message-ID: <20210907195647.jutizso7o2r4mddj@meerkat.local>
References: <20210907083613.31268-1-brgl@bgdev.pl>
 <CAHk-=wgQBgkut6zXTbZN45AtJmSceXwDw6Y60ZmwrPkOL__A8g@mail.gmail.com>
 <163104361220.4526.774832613459764535.pr-tracker-bot@kernel.org>
 <CAHk-=wgAi8jHOFuk8iqXsL4Aekst996HGeN18aKQhXd-qu2dcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgAi8jHOFuk8iqXsL4Aekst996HGeN18aKQhXd-qu2dcQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2021 at 12:49:03PM -0700, Linus Torvalds wrote:
> > The pull request you sent on Tue, 7 Sep 2021 12:36:25 -0700:
> >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl refs/heads/master
> >
> > has been merged into torvalds/linux.git:
> > https://git.kernel.org/torvalds/c/9c23aa51477a37f8b56c3c40192248db0663c196
> 
> What what what?
> 
> Konstantin, is pr-tracker-bot confused?

Failure is always an option. Let me poke at the logs and see what happened
here.

-K

