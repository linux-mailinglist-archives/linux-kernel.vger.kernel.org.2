Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31D663DEC54
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhHCLlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235596AbhHCLlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:41:12 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BF4C061757
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 04:41:00 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id hs10so27238462ejc.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 04:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UTH1xriYdp7u5xYL3QfzWmKRaaFC9ziEV6g6dXWdnAA=;
        b=tgjPUlEFLS9R3pe1i23bVN9uFNo5sB8O4gOOXAhmPTwVrZrVq+R0HvfFC7tCxJMGS0
         wiQmMdBJ7Qjs8IxqQ+Kk/XPsRmKOP2ZL14CDSP5EJahGpBhZxGqN+9OziIl5Yg45A85I
         5KfD8GlzssfveCwgOsgys80okroPvFFEkPF6mb1t0cW3CkOjQ9G8cWdaCQuhdirdHJGI
         JlTGf8jCSLZDGkdgMDG7NLABtdeNCfzSvAPPQng1kCP8mzptXf9k8jKgq6wMbyO1zWgz
         V/9Sa9moikRXguzOELOnYVB9mR75hUpcA59WfzrXQ2WZaagQPmNKgDsy97rVMTJMgRri
         ku0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UTH1xriYdp7u5xYL3QfzWmKRaaFC9ziEV6g6dXWdnAA=;
        b=t0b7e6SkBfviNIdhgPw42Blnk6YiiQjLiHZk0pmJQ5EHnhbdcbUi1e7IOfCl6i084H
         KdT4n/+ie/Bvf+RcTWDt2Gqmwl9x+st4c4UMTH+NWyjpyuf5g4lnO5q2zoIPOUDsYc9t
         kbvvOUySzbfQ1xc6g9FZeyxYxuJxpeyXnnYgX6UvhIgyJMDjURWpLu9V6x7yX/SmBZoc
         4pl7ZML6aqvCwf+ib2A8wlUuZ/6W6v+i+mB3GNhwrJUf1ZdMgn+gZyALvOaz2ja8aHvA
         GxGt75o/XdkuAkf0K8xTEsorRDzRSkHRKwb8yXn9flNED544k6T62xUzVVcgG+ckVb5X
         CxpA==
X-Gm-Message-State: AOAM533CZHcEp02F5fiE18Enf0U7IQT74eP+qpzNpITB2RMDamYWyqc6
        0LViwj+dBC+hWRjSxLdgcGa02LhsRvsTMZxCmXM=
X-Google-Smtp-Source: ABdhPJx+oRy7TDwar4JICPJWtGOTCfgTSmYrsw5qbLO26sc9JEqhl7vCfDGC77LJsFULHHYzz9kc6ojyUInie41FksE=
X-Received: by 2002:a17:906:4d12:: with SMTP id r18mr19569693eju.537.1627990859185;
 Tue, 03 Aug 2021 04:40:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:3018:0:0:0:0 with HTTP; Tue, 3 Aug 2021 04:40:58
 -0700 (PDT)
In-Reply-To: <CAL4-wQqCL1S-GYu7VKJeTT37wh=rR=SMUuwgKiXnnn_Y=uydOA@mail.gmail.com>
References: <20210802141245.1146772-1-arnd@kernel.org> <CAL4-wQqCL1S-GYu7VKJeTT37wh=rR=SMUuwgKiXnnn_Y=uydOA@mail.gmail.com>
From:   Martin Guy <martinwguy@gmail.com>
Date:   Tue, 3 Aug 2021 13:40:58 +0200
Message-ID: <CAL4-wQpKLtSj0xfNUXXLhbtN1wC051jpRneAuLYOi1riZfiinw@mail.gmail.com>
Subject: Re: [PATCH] ARM: ep93xx: remove MaverickCrunch support
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        soc@kernel.org, Nikita Shubin <nikita.shubin@maquefel.me>,
        Arnd Bergmann <arnd@arndb.de>, Oleg Nesterov <oleg@redhat.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forward opinion from people currently producing and supporting EP93XX boa=
rds:

From: Technologic Systems Support Team <support@embeddedarm.com>
To: martinwguy@gmail.com
Cc: jerome.oufella@savoirfairelinux.com

> I expect our customers would care if support was dropped.
> Unfortunately I don't know to what extent.  I'd like to bring
> Jerome Oufella of Savoir Faire Linux into the conversation here,
> as he runs the software company who most of our customers
> contract through when they need a modern Linux kernel running
> on one of our Cirrus Logic EP93XX series single board computers.
> I expect his opinion will be more valuable than mine.
=E2=80=8B>
> Good morning Jerome,
>
> A member of the Linux Kernel Development community reached out
> to us this morning letting us know the community has suggested
> dropping support for the MavericCrunch FPU on the EP9302 processor.
> Would this impact any of the development your team has been doing
> for some of our mutual customers?

From: Jerome Oufella<jerome.oufella@savoirfairelinux.com>
> I am aware of a few companies who rely on variants of the TS-7250
> running not-too-old LTS releases (4.19, 5.4) to cope with their patch pol=
icies.
>
> With Linux 5.10 being the next "Super LTS", this presumably brings its
> support lifespan until about 2030, which (I believe) they would be
> comfortable with considering the age of the platform.
>
> Jerome Oufella
> Vice-President, Technologies
> www.savoirfairelinux.com
