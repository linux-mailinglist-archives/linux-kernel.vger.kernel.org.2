Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A71D742A33A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236164AbhJLL3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhJLL3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:29:01 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AFAC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 04:26:59 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r18so66007790wrg.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=S9YA3sFh8Vp/2NSGlIrc2ICta8OJeqn3OCqMmSINMuU=;
        b=W8ZNLGCBcxSGBN6yG2iDdJzWQeDoztv2R7eA1Aw+vFdjZZ+rwyTll0Tq0BSw4TN7rt
         r4ZwmfiRV6PQNXDrJ9HdBVVumHNsvpOVmbtYHCO0HXTsgpFaWW3LdfaNDqfAUdCXex5z
         t4USFXRvTbgj0YpY1UBiG0TlBbKCXFvz0mn0BWziFfJrCCKBFaKgnMa/vHfaStP3fOf0
         /hbvAspR1AsxgVakLNrj6HR7cqYCXOw8sG4Gu/DttpgZ3iZ8+6PvO6X1SHWWEpo06ynG
         XeDoinjmYD+EcvDp57+cXd2WsrJ7thrEn+RzLNtjPWE2dg+5++BZdRoeD1Chzk7Ugvlg
         q9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=S9YA3sFh8Vp/2NSGlIrc2ICta8OJeqn3OCqMmSINMuU=;
        b=Z9un4AyX439W4Dw3TRSTdMdydjTqXi1r5aZZNWJnnqxFBiW96HYZVVFhQX6Zicnj48
         QbyZt/fED4OMZz+vXWAWx1mxrn3fDTRXDogI8gN4bNqWw6FiehWfJpVk/LMC0IimJUUk
         rtmNLdIur31cl939GK/4n0BsXL/MzZ3dDSkRj1PTNWJbaLgRNy1dr2xga0hSl0CqjdcF
         9aWQ7h40A/846oRfSAwzRJuozoySlJfYGpyyO3u1v/MF9do3IFj8WM2BlFdA3FLkLoHD
         DIhwPMyDhTh3czF/WUSKGkqkYTx34bLwHrQH0G6enDAdPehsZYS8jV6Lk4ULh4+9hT6m
         R11w==
X-Gm-Message-State: AOAM532O93n+iQGbpEyKH1Vdr9CPy4ZSvPmT+W6NX0PL9Ttoe697uWdd
        hH+/QGd1hTbK0EK9mmJgXds=
X-Google-Smtp-Source: ABdhPJyHiJWKQDSFm+qErcsDkxsviPeyesVZrw6UwS2uZegIA2ex4PyWPY9q/ZvVGMfvfTry7jNDHg==
X-Received: by 2002:a1c:7e87:: with SMTP id z129mr4741252wmc.75.1634038018047;
        Tue, 12 Oct 2021 04:26:58 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.16.219])
        by smtp.gmail.com with ESMTPSA id g2sm10332501wrq.62.2021.10.12.04.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 04:26:57 -0700 (PDT)
Message-ID: <00781d5212bb4015064d07e762ae0695d16e834e.camel@gmail.com>
Subject: Re: [PATCH v2 8/8] ep93xx: clock: convert in-place to COMMON_CLK
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Mike Rapoport <rppt@kernel.org>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "moderated list:ARM PORT" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 12 Oct 2021 13:26:56 +0200
In-Reply-To: <YWVvyKq4W4VShiRU@sirena.org.uk>
References: <20210726140001.24820-1-nikita.shubin@maquefel.me>
         <20210726140001.24820-9-nikita.shubin@maquefel.me>
         <ed557882a9530f2fd6245e34657be62399df76bc.camel@gmail.com>
         <CAK8P3a0Y4uwX4B10d5CR3WjZ1qXAqhKJGJ0EhUEF60uB1q3H9A@mail.gmail.com>
         <e50f2da7af1fa6f02fd413081fa5762837b86895.camel@gmail.com>
         <CAK8P3a3jAdYQerE03O5s2_PBUqt5QPCPSQxxs54E7-V=0HVBXA@mail.gmail.com>
         <YWVixgDQtJ8EGbwo@sirena.org.uk>
         <7f7acc8986aca1c895de732297b2995d05ec23e7.camel@gmail.com>
         <YWVmvHsEkPFkrD/R@sirena.org.uk>
         <7ec1690ea0ca9f6538b8228f78e62b2f38405fd4.camel@gmail.com>
         <YWVvyKq4W4VShiRU@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Tue, 2021-10-12 at 12:21 +0100, Mark Brown wrote:
>  Looks like Arnd is ready to pick it, and the only dependency which is
> > not yet merged into Linus's tree is "ASoC: cirrus: i2s: Prepare clock before using it".
> 
> OK, so I'm still unclear as to what's going on here.  Arnd's mail where
> I got copied into this subthread suggested that things were getting
> merged by individual trees which is generally easiest?

I only wanted to ask you to pick ASoC patch, I can resend it if you'd like.
It has no dependencies and all the previous patches were already picked
and are visible in the Linus's master.

-- 
Alexander Sverdlin.


