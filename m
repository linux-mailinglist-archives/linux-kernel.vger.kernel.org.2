Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6295239162B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 13:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbhEZLct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 07:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbhEZLcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 07:32:24 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134C9C061345
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 04:29:01 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id b13so1531499ybk.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 04:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VZJmw4c/w1aJviXBkJs75wOQwEwbtioXuzg9Qv6tv5Y=;
        b=H0GiLBuoHLyqgHE/J91D74h4OQY++YzDVM96DR7+OsXwVLE5OPl7Hwtl29AZwm/Za7
         OADlmn1BNwhB8H38M2WUzEXkITgXSGkocLNKbnyEra2+ZT2+K6JOn2wIyzgc1Wnxn93w
         pkdIKPL7hlrK61sJMSv/AcpJgrd+iY/BUvGx9s3xCVDfK2I6x3WsvydAomSavlqHgn8z
         vL4x9RIVBPYU4b6WZsBmP5myKyJtjNwXLfnAaSsUxzkQJ2EOCDQPzbZ31GxVRG3Y2bHj
         dc80iBtM/D5RaDx5VWXcTkbJiJewOe9L1YRILEIRv5an3UAqKKG1FsePeVtBJyUkARjS
         V+eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZJmw4c/w1aJviXBkJs75wOQwEwbtioXuzg9Qv6tv5Y=;
        b=XO7uxHnpIQEpoJWdL2yMKxwgn1Gi7NcQwlnB7gpVPlPAUgvSvtLkfLJppRiQbPJmXn
         7hWCK1QAQcGY7lAihquXx01ssRTNO2K2wgL15mLJI1ca/ZaJWOMglTSdfplTeiWGPksl
         BQsIch3pJeGZZqXwRhBm2DuXyLFZ83qVWGAvKcNslnoIEwfLYkwbB4K8BK0hsQzVXoKR
         5+ReFZNfRA7wy9enhTA5fihBgDG7QTDW49Kci4IORiNZurTBRB3sFeiAOLob/cX0nvox
         4RcFqAP1smoHtMDUTs8KvcJKKaqi4XISHKGR1b7/iS7WaIcEPd9Ltb/emvQJbLvtfeLN
         FhwA==
X-Gm-Message-State: AOAM5321r2QdmVHql8CdGdW5xt8wuQuzF1RjxyW5OOPaW77gTbyD7m6U
        8HI+EmmBQm9UoSM92PimJ4NhHMd4TUzWWAaUnJbTAA==
X-Google-Smtp-Source: ABdhPJy1XkJQgfNmWeEbTm94qa+mEuNw5X68zb1bTQxhHHrPdFqHAV8LspcoAQallQ8h0F2T9t906bvCqOGSreByjl0=
X-Received: by 2002:a25:1804:: with SMTP id 4mr15627151yby.157.1622028540172;
 Wed, 26 May 2021 04:29:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210525175858.11611-1-grygorii.strashko@ti.com> <20210525175858.11611-6-grygorii.strashko@ti.com>
In-Reply-To: <20210525175858.11611-6-grygorii.strashko@ti.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 26 May 2021 13:28:49 +0200
Message-ID: <CAMpxmJWWS2dqRW_MPiFQq6c1wqFrKcEUbThZFyHeG1ZpgdGjJw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] dt-bindings: gpio: omap: Convert to json-schema
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 7:59 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
>
> Convert the OMAP GPIO Device Tree binding documentation to json-schema.
> The GPIO hogs node names defined to end with a 'hog' suffix.
>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---

Applied, thanks!

Bart
