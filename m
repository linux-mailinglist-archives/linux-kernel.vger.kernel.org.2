Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5766393F69
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236645AbhE1JKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236352AbhE1JJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:09:45 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3082C06138A
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:08:02 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id a5so4373976lfm.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VJUFVUjwMi3jp1lDpVisyiJzn7Zhoa8E+bQf9DwQVqs=;
        b=fpYeaAiobh84ePdqE0lJtTQRLx27OqasFcegutrZktiaCGsASz+DMX4fKBLm26YlY5
         M7A6YWw3xaofHKY0wgdSuH1fc9F8P7AaH3mngotvTgh8lFRMa6ky7HvX6MZgBPWYYB0Z
         yT6Z3ymqSzYfEstFNYIvNPKqwp7fnMbcUwMVqJtZ98ZE2Z0WoF7qORBprrS/YW3LaG/A
         Ucd8lp1sbFF4vtWkEZ54MCc7R1NjuiRe//fgzBXCjU68LLCuIn97/TWMQ5wDwiqs93jz
         8LLzxcaNWPAxW/pYgxCyB9/FU/uHoupokEXnqZ3uT+NFXAfoqI2pZOZBHAcHGddIGqbj
         Gq7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VJUFVUjwMi3jp1lDpVisyiJzn7Zhoa8E+bQf9DwQVqs=;
        b=Uf3zJLOEih+8vPqLDG0L+J+cjY0sqJkCvcHoryfrBAHhPGEer8CYf1BpcGQyuI0mfc
         w5aDLhzgjU+DGKkUKOOoUnFWvFf1V5g/ToR10G3wthExDi11GIRxJevEdFmnrTeL7e7u
         ZfhWADtKmwGyyAftgmUBupariKivcZCxS7z3RVTk41rm30t2Rs/jpGM31BHlbJLW0Oil
         D/IGN/Dp+hALZGYqDR+nYfBp3/H9tRQF3pj7XjNbvGW5QecSd0al1/YRbEAK/gLbwzyk
         bmCTcGQJPQFG5X3k2LTuCbMEzyVJzeCDqwXeOirbMoTQt9ItJD6qpI2Gm+q12lA4Ze+l
         RGPQ==
X-Gm-Message-State: AOAM531Avm4SfdoAeraZpJo4qUtak6inHMSc89AMSo05268MTRXRG0sU
        NcUGzp1O/XRi46JIk7joO3qV/YnKtvq7M2w5sGKRkA==
X-Google-Smtp-Source: ABdhPJx+MczqJp0WaFPiI1m6x20/PKlEQDY+9K+GCnZ31rKGFb2DvTQymQLi+07iXyF2+WSjeSbcPFZAxbRKsMGeaqY=
X-Received: by 2002:ac2:47e6:: with SMTP id b6mr5079578lfp.649.1622192881082;
 Fri, 28 May 2021 02:08:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210520202730.4444-1-dariobin@libero.it> <20210520202730.4444-3-dariobin@libero.it>
 <87ea9971-9e15-c595-95cc-14c68b0b68d8@mleia.com> <1972814783.387983.1621877304255@mail1.libero.it>
 <414c9176-7922-929f-e82e-f80f07e91b2c@mleia.com> <106030092.519428.1622143415836@mail1.libero.it>
 <b25a0e33-d7e8-322a-2a73-bda6e88c8f8b@mleia.com> <2062056721.520514.1622147634190@mail1.libero.it>
In-Reply-To: <2062056721.520514.1622147634190@mail1.libero.it>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 28 May 2021 11:07:49 +0200
Message-ID: <CACRpkdZb4WZS8cd=nFz_J0GrBc5HJ8SMYtniB2W_Jpq_vtPTYQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] pinctrl: core: configure pinmux from pins debug file
To:     Dario Binacchi <dariobin@libero.it>,
        Tony Lindgren <tony@atomide.com>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Drew Fustini <drew@beagleboard.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 10:33 PM Dario Binacchi <dariobin@libero.it> wrote:
> > Il 27/05/2021 21:57 Vladimir Zapolskiy <vz@mleia.com> ha scritto:

> > Unfortunately you continue to cling to the broken interface, while I see no
> > comments from you about asked to consider pin groups and pin group functions.
>
> Could you kindly explain to me, with some practical examples, what kind of interface
> would you implement ?

I am not fully understanding this discussion.

I get the feeling that this is caused by the early architectural decisions with
pinctrl-single to put all configuration of pin groups and functions per pin into
the device tree.

Tony specifically wanted this because what he gets from TI are some raw
ASIC data dumps from the designers, that he could make a script to process
into device tree rather than into .h files, and get this out of the kernel.
(As I remember it, Tony correct me if I'm wrong.)

This makes it hard to align some concepts of the pin control subsystem such
as functions and groups because pinctrl-single assume a 1-to-1 mapping
between one pin and one group, which in turn has a 1-to-many mapping
to functions.

Is the patch trying to debugfs around this somehow?

If this hack is only needed for pinctrl-single.c then it should be placed in
that driver, so Tony can review it and maintain it as applicable in that
driver's context only, not in the pinctrl core as it appears the general
applicability for other drivers is not there.

Would this really be useful for other drivers than pinctrl-single.c?

Yours,
Linus Walleij
