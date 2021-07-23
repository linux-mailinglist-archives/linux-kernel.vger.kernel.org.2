Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E86273D3D50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 18:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhGWPfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 11:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhGWPfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 11:35:30 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACABCC061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:16:02 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h11so2291267ljo.12
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZoAureMYkcTKH2kjg9aHilcdqLnHirWRjt47psmYZN0=;
        b=gKb9IbAk1CyxiOCKWdEghBR3LCHULECVwQnMLuyszzoTlTPDuhAk6Qe//KWjrkUix+
         JSJxNUpmjHiSLTCUxiDFlFWBxTXoDiMkRr11VjrZYCObnfL3DdW5SWQ3C/sXkvJih6Qb
         FLRe8LfxvVh+sxonzRNiG1jbe5do5aLKe2Zo+EkzFnfRBUAYRjBVe76sfH7qsGt8mLS2
         NF9o8DlVl5/JBAapYlOI/DZvB3xLCPh3QnT91Eg45swR2QJ6rgJNq5KaIg06rkRHoFZg
         F5+I2gPBwA8UysNZkfDAXK7UKrKe+NrTOsVU5h/cpKAI2vqFFSxfwlRqatvMhxrX8bCw
         eVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZoAureMYkcTKH2kjg9aHilcdqLnHirWRjt47psmYZN0=;
        b=alMRyfvZkD6Do2CAqfnBap+48dTf2ta8g8K/D9D0fp2xE+HBpqVZqnUO+bnweYe/Rr
         kDPuQhHkt8TYkQG1OPbkXLGwmSgr31s3OGcIPWtJz/kn87Loy0XczwC9ULaflE+MH6EI
         zZkPGKsxmEWRUi3icFipGqegSuLhEtMKkStoXseJWIecivnKpmSq1KGWBqROXK+yJZ75
         o5fhrsrxqp2EI9Gc7h/GDovDaA3p/gTEmikEdgfRfZMi/o4gQkc7ZzLVGq90xynCCZ+I
         ZJoTcOjhc3mODoT9zVzaLuBdQjodPOb2e8Z1hm7aupmHnCGxLrjQMiztHLB+wKPzwxz/
         3VWA==
X-Gm-Message-State: AOAM533LZeBbVhuIrZ7x3AxrVWTWFIuEy32WTEARsTTN8uJ1sDD8WTKk
        9LhL9ySn/rXZ71T7Pt4HDiahPrgj4g2v+3qrj8bV/g==
X-Google-Smtp-Source: ABdhPJw3749hvmB49BD91wti3yJglZ87jQLxwv2b7QCByud2Er1tsARQQK4S4N0k+/nWDIoZRYcoAQ+vmzMk5FawSg8=
X-Received: by 2002:a05:651c:160e:: with SMTP id f14mr3826874ljq.273.1627056961053;
 Fri, 23 Jul 2021 09:16:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1626429286.git.matthias.schiffer@ew.tq-group.com> <34be64092b7b4d0c75085a8c729f5f6fcfb56b61.1626429286.git.matthias.schiffer@ew.tq-group.com>
In-Reply-To: <34be64092b7b4d0c75085a8c729f5f6fcfb56b61.1626429286.git.matthias.schiffer@ew.tq-group.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 23 Jul 2021 18:15:50 +0200
Message-ID: <CACRpkdbaE+07ZZigct+JS-MU79U_D2nC82a-LcXm93KW5+xA_A@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] gpio: tqmx86: really make IRQ optional
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Lee Jones <lee.jones@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 16, 2021 at 12:01 PM Matthias Schiffer
<matthias.schiffer@ew.tq-group.com> wrote:

> The tqmx86 MFD driver was passing IRQ 0 for "no IRQ" in the past. This
> causes warnings with newer kernels.
>
> Prepare the gpio-tqmx86 driver for the fixed MFD driver by handling a
> missing IRQ properly.
>
> Fixes: b868db94a6a7 ("gpio: tqmx86: Add GPIO from for this IO controller")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
>
> v2: add Fixes line
> v3: no changes

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I suppose Lee will merge this into MFD with the rest of the patches?
I don't see anything stopping Bart from just merging this one patch
into the GPIO tree though. Only runtime dependencies.

Yours,
Linus Walleij
