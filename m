Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90DB942A24C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 12:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbhJLKjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 06:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236056AbhJLKi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 06:38:58 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AC6C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 03:36:57 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e3so31865504wrc.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 03:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=u8KoHqciBlPRfZiEEzMpxTtlARh9EB21VEjR+8BCYuM=;
        b=VstF64oG+VLBoC6+RF7RZrMmETzmIQsSxwIrM4iuyJZNbsj7SD0CiGmCCdBIvYMrCn
         x46f0WdDiuhe4cDCG9+Zhp0AS9Deyf/Fn5cTjdNYZFPE3n4OGlkNQWSqkwuN8i0duDx2
         NpdSOrjavvb/J2Z+jkKzNf9ur5FPHC6zUJ1qfXdH+ahRDqIsYiUPd1UWK59JpzFLx3go
         92dcYyXso/JVC2CbQe6Iv4ueVyx1PWtf/aWC5qu8i11Djuse6kzZJwuMwv1QYlZ57Ldt
         kDrI6lVRtKpRmvDtSnx1y3CYj43ZM2Qzl212+Y+wroMfAYA6k5d/KICMaMwweN/6Falz
         mbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=u8KoHqciBlPRfZiEEzMpxTtlARh9EB21VEjR+8BCYuM=;
        b=H3AUvnaIMGnHNWKYO9Xl8dYF5Inv0UWKNFzl9lS7m/ywCnu2/VQZNP01iSHjfvSVfj
         Q0tz6VLHs0r4/7QvUe+kjo6iHzSVNh7lRzybYcmRElhOsQ5U8NVPFpxKBS7jNZV91EDf
         w9fzLFgMtIgnFP3J1TWDyrIZp4JgK1C7O5b1SGNCb5WTeAoBO2guaiZk6+ZHKLP7XKDc
         ybnPTlI/V+tXl4I6XewJxDN/Vqa3Kl/BSQixJKy7EeBoLsjgjoK/n5qEt8eY5qvSwimk
         RDQlTJPksPmauBv69IxJYg/mbal9HMgiSwJhHrrJVYoGHLUXZi+llTD1vPxxLs+r76F4
         BZKw==
X-Gm-Message-State: AOAM533cvUcLqw4r2Sl1Ouf/ft7zPipdXMzrR65yY1HGk92TJenCwhe/
        0mbm+7U+Yf4iDL3t3Rr49XQ=
X-Google-Smtp-Source: ABdhPJwkI6gxGiZNTp8TKZdQ1IFiaoSipIChH3SuBqVR8DUSUZjP7GyglXTl2Fw1/yRQWS923c81KQ==
X-Received: by 2002:a05:600c:35c2:: with SMTP id r2mr4727738wmq.26.1634035015752;
        Tue, 12 Oct 2021 03:36:55 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.16.219])
        by smtp.gmail.com with ESMTPSA id v185sm2152672wme.35.2021.10.12.03.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 03:36:55 -0700 (PDT)
Message-ID: <7f7acc8986aca1c895de732297b2995d05ec23e7.camel@gmail.com>
Subject: Re: [PATCH v2 8/8] ep93xx: clock: convert in-place to COMMON_CLK
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc:     Russell King <linux@armlinux.org.uk>,
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
Date:   Tue, 12 Oct 2021 12:36:54 +0200
In-Reply-To: <YWVixgDQtJ8EGbwo@sirena.org.uk>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
         <20210726140001.24820-1-nikita.shubin@maquefel.me>
         <20210726140001.24820-9-nikita.shubin@maquefel.me>
         <ed557882a9530f2fd6245e34657be62399df76bc.camel@gmail.com>
         <CAK8P3a0Y4uwX4B10d5CR3WjZ1qXAqhKJGJ0EhUEF60uB1q3H9A@mail.gmail.com>
         <e50f2da7af1fa6f02fd413081fa5762837b86895.camel@gmail.com>
         <CAK8P3a3jAdYQerE03O5s2_PBUqt5QPCPSQxxs54E7-V=0HVBXA@mail.gmail.com>
         <YWVixgDQtJ8EGbwo@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

On Tue, 2021-10-12 at 11:26 +0100, Mark Brown wrote:
> On Tue, Oct 12, 2021 at 11:05:08AM +0200, Arnd Bergmann wrote:
> > On Tue, Oct 12, 2021 at 10:37 AM Alexander Sverdlin
> 
> > > There is "ASoC: cirrus: i2s: Prepare clock before using it" still
> > > unmerged as well with an ACK from Mark Brown, I did remind him
> > > about it again this morning, but I can resend it to you if you wish.
> 
> > (adding Mark to cc)
> 
> > Let's wait for him to reply then. I don't think it matters much either
> > way, since the series is not doing an atomic conversion if the other
> > drivers are merged through different trees, and Mark has given
> > an Ack for the driver.
> 
> You're going to have to tell me what's going on here:
> 
>    https://lore.kernel.org/all/20210914103212.GB4434@sirena.org.uk/

here you were asking about "spi: spi-ep93xx: Prepare clock before using it"
which you've already applied (as 7c72dc56a631).

Nevertheless, there are no dependencies in the patches 1..7, they are all
pre-requsites for the last patch 8/8.

-- 
Alexander Sverdlin.


