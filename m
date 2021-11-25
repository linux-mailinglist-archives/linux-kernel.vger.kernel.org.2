Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1607745DE3B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 17:03:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356383AbhKYQGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 11:06:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbhKYQEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 11:04:43 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFDAC0619FF
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 07:50:42 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id g11-20020a4a754b000000b002c679a02b18so2187840oof.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 07:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AVHFn4pvQ57s87RuMlHiBuxgtL5CNCcNeKT5ib6MEyo=;
        b=GhBkYeXA78uyXC+yLqbJwX4KtwqiJeflNGNTb/z7Ijhhe4s9VdcI5z6K/puS7Rw2mb
         ankYD0w70SeM4FxjAtubHAWXg9v8WcePaAm4d95tYLRSZrSKqUW1iIwNXvP/emqmQzXY
         352LFlC/eloskssNo83XTqHgPVaZ3Q7vG1oUp+uTNV5QmOnhNvBgARrrRsvvUXDLYNuu
         WPaghyLOmvkUoj5mIZ3KbjYPQVgfqSWXLJXrq1jeYFX59JoBcfaLIreDDCYDrMGS/ays
         Dh6vwsslt4DVdHGnG3WmUiuWqsvhZZv+NKU6KHF1CofF3UoGgGN4imGDbXGzwV6/uK2m
         pang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AVHFn4pvQ57s87RuMlHiBuxgtL5CNCcNeKT5ib6MEyo=;
        b=vJrX5+gqlizPK3FIwEnVQPWdJSFIQfDwawpRbqXMOv9tyrCMBgc9c3wUErDO3OxPOA
         EGMHJJWNkfKs9XMVZF7RjLp+kMOI6e1v/l48foOi88XlPPtD6T/97VY4BSnh31s9zclQ
         hbf1of7MWbVLcw7Tot6RJnjQPZPVLfIcrP1pkn6fAovih00xspQxM1IiUYwIkdhpNHAD
         6Jdj8fASVii0gqdh8SGJDYnwEkYCy4uLpzOwhOIinVPcBX1IB2cDev6gO8gcAjps2i6s
         c4ap7vQP9Ews8MndC1iEpIVW0MdhM6/lwP1Q0c/m9gB1iFvS1jjYiniSRbmWT4X3UHBY
         9voQ==
X-Gm-Message-State: AOAM531V3SZ/u0Cg5B1cEj8SU4hO+RkBH5ndV6SFA91q5XAmaVC6rY7f
        KPx9SrNfRNUPGX7LuxUCPTOmy9wqBFzhDxTKj2tM6g==
X-Google-Smtp-Source: ABdhPJwnrU63IwJ0IC0mJHOP3P2NLtbrILPch0ESN77ylPQ03yg5iGgYl9R7ewbzrCsd7+wghhdlMusSvKDBb5cKx8s=
X-Received: by 2002:a4a:e155:: with SMTP id p21mr2600093oot.84.1637855439972;
 Thu, 25 Nov 2021 07:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20211122225807.8105-1-j@jannau.net> <20211122225807.8105-4-j@jannau.net>
 <5f16c962-72a1-21ec-9651-744053f74365@marcan.st> <d48d2e85-42f1-570a-bd8f-e3834147c8b8@marcan.st>
 <CACRpkdZghfRvox4aY4ROXYwFqiV6mnXZgw+42ZWYisXXgQ5+jQ@mail.gmail.com> <f13b54bd-d776-0d06-113a-5ca2bcbccfcd@marcan.st>
In-Reply-To: <f13b54bd-d776-0d06-113a-5ca2bcbccfcd@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Nov 2021 16:50:28 +0100
Message-ID: <CACRpkdZ4==HvMYrJe2jQMzeYqh65OKLEo9WEWDGZAZ8u7jkxFw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] arm64: dts: apple: t8103: Add i2c nodes
To:     Hector Martin <marcan@marcan.st>
Cc:     Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 6:42 AM Hector Martin <marcan@marcan.st> wrote:

> Pulling down an I2C bus between transactions is not legal; the idle
> state has to be high.

Oh right.

> Apple are actually not very good at configuring GPIOs for power saving;
> e.g. the I/Os for that unused i2c bus still have their input buffers
> turned on, which is a waste of power. If they wanted to save the
> smallest drop of power they'd turn that off. But the effect of this is
> so trivial it probably makes no difference in the context of a laptop,
> nevermind a desktop like the Mac Mini.

Hm that's true. The saying is that 99% is the backlight, the remaining 1% isn't
so significant after that.

Yours,
Linus Walleij
