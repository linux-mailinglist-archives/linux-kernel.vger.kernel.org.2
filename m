Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4DF31B2B2
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Feb 2021 22:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBNVRH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Feb 2021 16:17:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbhBNVRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Feb 2021 16:17:04 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA45C061574
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 13:16:24 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id d184so5315101ybf.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Feb 2021 13:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phdV8WYNd3IGThDsn8i4M24CobH7ljSVjSrnflRr3qU=;
        b=RWR4roQbM83TfOeedHSPPpdMu2Nrv1ah6uwnFW7JAwYCOunQAZ8ts3tL6Uzai09gGa
         LT56JMZcLhRHUVb7BIv9a9Fgcj/aqSsFk5h0+/P35/WMudzT1DP3ZIJaoMUE7V9Kw5bf
         1KY4nwyux5ymiaNyvoH7myw304kgkIsPme80xuiZ/8oJ6irIzBSN7B5TA5C6wHYHKGer
         AsFY/uKt4Typt7Sfa3f1Pqmue/ogKAp9PKQKvOKZHJ0u6Xx2gFMwIC2wLn2ox9t4XNJZ
         t69rSTJuJWKZmRkDhDUvmUixL5yCEpgZXNVyuR0eMeqwaewN6d1CYsAtITkIvU+yV34N
         0hJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phdV8WYNd3IGThDsn8i4M24CobH7ljSVjSrnflRr3qU=;
        b=SsSiO6M7u2GXtcYe5Qn2mLY6YvgPNYGUuWattG1kfKoP47eSUNzmiX/omNEs3H1882
         dOLTocfTd77o/5Zb69MX3JPq6ZFtNfbGi5Dx43AMJlermP8vsUUzL9uCfLvq5dZ6C35K
         vJ7vjgoI0sDGkpqRLOpdk4/6gIm+SIShOTHczXlKSzxSJ6y9+QZMXPu8ruGRSCR9ksHD
         Wk4JUS77I5/fi7qVZH6cmnjxkkY0JZZApX5Z83/xBGDsECg+vs/+SGd3Q8d671fNqiJG
         5Tt/xg9QNcHD/4/1CKzNs+TU9tcy8ev2Dd1qNnQ/uu02CKSI5oX1DchwD0KwQXs3k+Xo
         JjMg==
X-Gm-Message-State: AOAM532mB/yTZttrQquUh+5FFkhDIQda4aL2SKFh+IOjPYEsneNpgOie
        FjaAGgKvrnNdLVdzrG0Sv3nd5r+gAvsSRAbdnP6cag==
X-Google-Smtp-Source: ABdhPJwKlOywjb9o1r0z+/aEElhBXr3muf5MaDtLIwSmnIybpMmvKkrG398c3xt84cwnEWzqUgzwx2tz3LZ7RBGCdE0=
X-Received: by 2002:a25:718b:: with SMTP id m133mr19551522ybc.412.1613337383889;
 Sun, 14 Feb 2021 13:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20210205222644.2357303-1-saravanak@google.com>
 <20210205222644.2357303-9-saravanak@google.com> <161317679292.1254594.15797939257637374295@swboyd.mtv.corp.google.com>
In-Reply-To: <161317679292.1254594.15797939257637374295@swboyd.mtv.corp.google.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Sun, 14 Feb 2021 13:15:48 -0800
Message-ID: <CAGETcx_vTSGgmYVHPgi1uqHEGU9y4ZDd_=Z3Xg-Nbrsu-r5Tog@mail.gmail.com>
Subject: Re: [PATCH v4 8/8] clk: Mark fwnodes when their clock provider is added/removed
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kevin Hilman <khilman@kernel.org>,
        Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 4:39 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Saravana Kannan (2021-02-05 14:26:44)
> > This allows fw_devlink to recognize clock provider drivers that don't
> > use the device-driver model to initialize the device. fw_devlink will
> > use this information to make sure consumers of such clock providers
> > aren't indefinitely blocked from probing, waiting for the power domain
> > device to appear and bind to a driver.
>
> The "power domain" part of this commit text doesn't make any sense. Is
> it copy/pasted from some other patch? Should probably say "waiting for
> the clk providing device"?

Yeah, copy-pasta.

>
> >
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
>
> Acked-by: Stephen Boyd <sboyd@kernel.org>

Thanks,
Saravana
