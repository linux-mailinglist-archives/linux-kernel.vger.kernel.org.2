Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E20402F21
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346084AbhIGTu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243859AbhIGTu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:50:28 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184D4C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:49:22 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id y34so3244lfa.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 12:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ClRGRaZgiBSDmEFkwxJRClT6UcHDrtBvPnX9h2YwL3Y=;
        b=QdHbVLCDMYlkts4Ts3bynLSBKsUB9gytGgloai+ljEqyKIvsUIRoCK6wPWHikfBT2j
         GR7Tt8+OiSyaXCTwm0rtwxqEwD/zDLPNBPIpusojOP61TPIhI2mRL9aafidNu/jjkzNR
         m1B9Uh7/Km01lOI5qVfatpwsOfDwKUxFlKlls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ClRGRaZgiBSDmEFkwxJRClT6UcHDrtBvPnX9h2YwL3Y=;
        b=rLAWZYRV9zEm1GnsaoGKzhymuS+6VlHbh17iuhlS5Cf2Jrt9C56u4caJt2lmPUkAiv
         B4vy4hXxsCkqF/Ho9f+38my71235TibcIXXVTpSJ68nyFdNJKwhlZX867m4AfP13hyLA
         VX0GaJ27SzIn82fOMyhVRFe0iGln4dnp4KbRAuJB1P4Dxp7xZiHSHJUWIZrfbv3/Jkq3
         oezsOcVaORwtoF1eVdSsjV6Rtls/ApAGJp67fEHA62ONP+J7Z+C3ZTycZmgz5gia9Dx3
         5iqoGbaY/N+87ra3T6EKGRtpf23dinc3nt0pXHqtA9RLPlpySYIVeNrBaJ5tGmD+D6h7
         YIkg==
X-Gm-Message-State: AOAM531BHp8ebzQbg1FUhA/PpKIGV53DRjubh5duNW45aB5ye4fqT142
        XUD5G5Uy1G2Ts0CJyc1b1dyfRLEw69gJ3OZF7sg=
X-Google-Smtp-Source: ABdhPJzKt4L/C1ZgisC4e79Yk9ze/aYRvhYJPzzSZTOUIHmUGgY/QUUQYEFWqYrYslGe9RKtLFNfhQ==
X-Received: by 2002:ac2:4e50:: with SMTP id f16mr49046lfr.229.1631044160163;
        Tue, 07 Sep 2021 12:49:20 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id q18sm1535145ljm.50.2021.09.07.12.49.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 12:49:19 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id s10so157186lfr.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 12:49:19 -0700 (PDT)
X-Received: by 2002:a05:6512:34c3:: with SMTP id w3mr49782lfr.173.1631044159064;
 Tue, 07 Sep 2021 12:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210907083613.31268-1-brgl@bgdev.pl> <CAHk-=wgQBgkut6zXTbZN45AtJmSceXwDw6Y60ZmwrPkOL__A8g@mail.gmail.com>
 <163104361220.4526.774832613459764535.pr-tracker-bot@kernel.org>
In-Reply-To: <163104361220.4526.774832613459764535.pr-tracker-bot@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 12:49:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgAi8jHOFuk8iqXsL4Aekst996HGeN18aKQhXd-qu2dcQ@mail.gmail.com>
Message-ID: <CAHk-=wgAi8jHOFuk8iqXsL4Aekst996HGeN18aKQhXd-qu2dcQ@mail.gmail.com>
Subject: Re: Re: [GIT PULL] gpio: updates for v5.15
To:     pr-tracker-bot@kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 12:40 PM <pr-tracker-bot@kernel.org> wrote:
>
> The pull request you sent on Tue, 7 Sep 2021 12:36:25 -0700:
>
> > git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl refs/heads/master
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/9c23aa51477a37f8b56c3c40192248db0663c196

What what what?

Konstantin, is pr-tracker-bot confused?

I have in fact merged that gpio tree, but I haven't pushed the merge out.

And the thing pr-tracker-bot points to isn't the merge, nor is it the
commit that the pull request points to, ie that

   for you to fetch changes up to 889a1b3f35db6ba5ba6a0c23a3a55594570b6a17

which doesn't exist in my public tree yet (it does show up in gitweb,
but with a big

    Notice: this object is not reachable from any branch.

warning because it only shows up due to the object database being shared).

            Linus
