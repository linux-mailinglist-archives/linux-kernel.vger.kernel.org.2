Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AECA3E0A95
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 00:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbhHDWwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 18:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235246AbhHDWw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 18:52:29 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D89C061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 15:52:15 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x8so7239300lfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 15:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DYdZtyj8pNJFHp1KzrJy5cVFfneYSipKoxottjQPwPY=;
        b=doSXqBlBbAIFWmKvVcXxT/K32bvtAZZBK2FEyHzxixpcjRxWFOx5udQqJpS6DdhtUe
         FL6OBkaguKCSYQAvHnzfiO0SLkhTRKxL7FoaP745lcIisR4UxslZW4xaAUoGk5sL254z
         dPbVtjCVGSnJOwY+ifIHr6gVFxZx7b/1x5vAzq/WvplArlpLcM6kpF3eLtdXYFOukoPW
         gFxu+uT5qKvWCWeKj/nDRJJTZ3rNCo9FZyWE3f2K4S4vtFaaxHDCQsNUbPoZIq4mPh34
         ykez7xP+bCu8oV26aiyBysa0HQ3f6MBXVuZnnK32yWUWEelmtGzNtyBhl5aIul9VHvEe
         kPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DYdZtyj8pNJFHp1KzrJy5cVFfneYSipKoxottjQPwPY=;
        b=rqnmHiTTRAQnODQH9Qr4LVueJ/u3EX6P0cup77EFwnQXNFJ4bVaGk4Dgq/zXGK3Mp0
         Cx3GezhBRnBfJZD3DGX+WWc4uNZ7eAgHG2VOMwLeJpcSau2YvOxBnveuajRdUKU1ygdp
         IAm4TUiI6m/D95f5d+yrO8MusVIz2fVtXwg7AT4scg9CJgxQv46bw60xKF7vDBHnbAic
         IzMMp8Hz2x0L/O5cxhNn5LnXJUPDp6P1rtujYalaa5MprUwzbwYvcDpg+JFAhvGCGgzJ
         d5w6duPQCgkBNQPv4ZqsRyj+4R8/KCYaV3g4oVHai4jHXDF3BPfjU9oDvNEiNntr8oFf
         GBmg==
X-Gm-Message-State: AOAM532H+TRM4t9ZpyPUD9v7IXyu65xmliVeiAB/ajeyKQIZKOaAN3Vj
        2NyC0ZLOhH94NcyFaEpqujbCYw4WWVRuSIuJGcnr8w==
X-Google-Smtp-Source: ABdhPJxilMlJha+CPg1BqDjtl7sd+Vy6Ff1gM+CV6JM+oj4VrZKGn4WYEmB51egRJoRDeYJ/4vNw3rBQtVbz5qFDYF8=
X-Received: by 2002:a05:6512:132a:: with SMTP id x42mr1051247lfu.291.1628117533435;
 Wed, 04 Aug 2021 15:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210801233314.3150754-1-linus.walleij@linaro.org>
 <20210801233314.3150754-2-linus.walleij@linaro.org> <YQejHNP1AzFHZ6gK@google.com>
In-Reply-To: <YQejHNP1AzFHZ6gK@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 Aug 2021 00:52:02 +0200
Message-ID: <CACRpkdaK0pBgmFSazjJ5NOj9rF9DzUyCfumxyi8PNaS_61_=Ww@mail.gmail.com>
Subject: Re: [PATCH 2/2] mfd: db8500-prcmu: Handle missing FW variant
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        phone-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 2, 2021 at 9:47 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 02 Aug 2021, Linus Walleij wrote:
>
> > There was an "unknown" firmware variant turning up in the wild
> > causing problems in the clock driver. Add this missing variant
> > and clarify that varian 11 and 15 are Samsung variants, as this
> > is now very well known from released products.
> >
> > Cc: Michael Turquette <mturquette@baylibre.com>
> > Cc: Stephen Boyd <sboyd@kernel.org>
> > Cc: linux-clk@vger.kernel.org
> > Cc: phone-devel@vger.kernel.org
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > Clock maintainers: could you please ACK this so Lee can take
> > this into the MFD tree? The chances of merge collisions are
> > zero, this code changes very seldom.
> > ---
> >  drivers/clk/ux500/u8500_of_clk.c | 3 ++-
>
> >  drivers/mfd/db8500-prcmu.c       | 6 ++++--
> >  include/linux/mfd/dbx500-prcmu.h | 3 ++-
>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Actually I intended for the clock people to ACK it for you
but since it is completely independent of 1/2 it actually works
either way, maybe they will rather pick it up, who knows? :D

Yours,
Linus Walleij
