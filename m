Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D92D41EC65
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 13:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354080AbhJALkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 07:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353912AbhJALkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 07:40:09 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45037C06177E
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 04:38:25 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id y23so3005524lfj.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 04:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PgQJwBmVLBdUeAFbcJpLOUvKI5KGsOalaorIVrJziYU=;
        b=ulGdV921YPSj31Yv4v5aF/syTvWDzr0emxFqFfTXLGaac8eOgGmUwTS2oQqs9+4MaT
         ycJJ4EGMFd1wiR/zE0HlRhLZMtUDrYcG8Cr0hZxQmBlm3f6VfnGmWUYOyEGuccqje6Kd
         f4GITEqFG47ZwzLDHw9uq53A5+pAdnhsw17ahJv5ZuVf4U9IJ2d3AwJBGWDMAfF5AhZm
         MrXvj+pMDYf7U5gRFhMMsvAqNMb/OCUK9FxDr6neZzgERJ4g+QgUNRGh/nG+POoPyV28
         vf9j6BK1UWjNCQXLmoyAqCerQFmcdJzzsxVO48fBV8Tiiwq75Yk8tA868/lhicBoEji6
         WTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PgQJwBmVLBdUeAFbcJpLOUvKI5KGsOalaorIVrJziYU=;
        b=1XNcfIM7uwp2xyGUEUjXAtNMd/dJWeZ7n88aQ5dQL2Yb79iRqEssigs0CszhX8kPqI
         /NqqmxwggFBbxZYbEo7wa6VrFqqB7scXLdnNzWboDyBn4vnLOFeXTP5oGskDWd9fDXhW
         lcp3Mp6lSf1+hFv1Dpm+65Db2+7q3n8jJvK3XP64BnMNl6a+vzYIH0gcV3Afuvvggm+/
         VTTElfqODU8DtcnnUPswsmF1clRHHUoQ/Cs7LymMw/mkV5fSMJmdJqaavY44i+B+NjRo
         hQ9FhZOUlZhGHjtE3WD4TRNhTPqW9WnIZxK+sqJhb6xu8cg6O/m5hzuZjNS3IraLgasb
         cisA==
X-Gm-Message-State: AOAM532bkQkMS2z+eAu39A9EsdT4CIPjwfDHiZM1lB2ov0XZCRPml/9d
        ZKsAltgdF178Uj8FSAc8/eYj0SwlsVYtNEEPX8J9tQ==
X-Google-Smtp-Source: ABdhPJxco3cL637mdMjAYhbk4AYPbPN/02smOY4EnT08ERaI7xmLVT0QYUwcEKNdpq2dlrNPhyl+AzDtpyyabfLalGs=
X-Received: by 2002:a2e:8011:: with SMTP id j17mr10931191ljg.145.1633088303563;
 Fri, 01 Oct 2021 04:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210928235635.1348330-1-willmcvicker@google.com>
 <7766faf8-2dd1-6525-3b9a-8ba790c29cff@canonical.com> <CABYd82YodFDwBxexCv+0hpYrdYEX1Z1CvnRkmnBPkEJNJ4bssQ@mail.gmail.com>
 <CAOesGMgSt_mYvRzF0rC=fnjMYGO9EX0_Ow2cD1d8XKLD5pHsZA@mail.gmail.com>
 <CAGETcx-b0ea-rqH+fj37sq9SLWY=+ePK94Y6rnLPuNbqFVBWmw@mail.gmail.com> <CAOesGMhQ3YsLJeQ7aUfb=0oNa3uPCx42wO1U7-ArqJTAUq1G3Q@mail.gmail.com>
In-Reply-To: <CAOesGMhQ3YsLJeQ7aUfb=0oNa3uPCx42wO1U7-ArqJTAUq1G3Q@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 1 Oct 2021 13:38:11 +0200
Message-ID: <CACRpkdajAwysiTOGuFcEySJjePp774J+4Z_YHXaoquTXk6cA+g@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] arm64: Kconfig: Update ARCH_EXYNOS select configs
To:     Olof Johansson <olof@lixom.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Will McVicker <willmcvicker@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-rtc <linux-rtc@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 7:36 AM Olof Johansson <olof@lixom.net> wrote:

> A much more valuable approach would be to work towards being able to
> free up memory by un-probed drivers at the end of boot. That would
> possibly benefit all platforms on all architectures.

This would be really neat.

Also the ages-old problem of discarding unreferenced strings which
apparently still isn't possible would be great to have solved. E.g.
to couple strings to the file/module it belongs with and discard them
if the code is not probed.

Yours,
Linus Walleij
