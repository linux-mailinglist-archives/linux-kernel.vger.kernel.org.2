Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F76042A2CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 13:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhJLLGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 07:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbhJLLGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 07:06:01 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9952BC061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 04:03:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v17so65659569wrv.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 04:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=i9Lqdw/Q3XhB3PIabHJgPAAJRtLcyIIONIfHyfQ8+uc=;
        b=AI01ovuqMMaOEI5I64ucvpqVxSPfbnr52vB/aXys1aJW5USUkWWOkuKHn2hoj/rqdA
         vCsRw7N4szIBkNY5WKiZS0zEKBpzML+hrjPIlMBZxUdmo/CvExtXeohCbThj+G1C1oBc
         4Zq8EPrVbCFHCqEREBcZqxw2+ZQxqODCDLlVinvpVgb1jGa0ABsSZSnChW616PCeJv99
         s8uq4WErnZYp4dIbYQly3E2W84bHvF5FLG4H1Io7yT2KIWKXBU6n9DpihOy4/LCSAhWh
         P+2ouuJoS962OPKcRj+QlWT7GL5CW62iA4EczjwX8V8u3A6tV61nSABfeB8247P7XwvV
         yxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=i9Lqdw/Q3XhB3PIabHJgPAAJRtLcyIIONIfHyfQ8+uc=;
        b=L8hW27cCF5OvjNLMLtfoRd4a2ihNf4hmcjFYyEj0NI5JcIGQ4tIh1/qt0XwApubUkF
         kost1OtyS/1qAcd1I44MX203Di5gkSBF7yjX8//reP2O11EdoIkGXCYHBabtSY58WlGV
         6bq/xHdhHx/RAZv72/uGxot4XvkHR3ftijwER8brFuk2DYbLfAPH0UTYE53n6wec1otJ
         2aPIjBVRdaaD6M2+AiYECDJZImuzC9LBvO2Gxs+3hEpR7HuZppEXTvBjD4XOhk6kS1o0
         +/o4fM85jO56tzo/4gMfOoMOgiqJsqUeRgEX37JhRZmfSzajUR59//yjNR9h3VXM7FLq
         K90A==
X-Gm-Message-State: AOAM532ekDjotE0Y9j5LnQnV5xsgiGZZuZIImiDnqwDzLnyva6G4ZH6F
        ZrjewjspzzmDwCcAxRLUTiE=
X-Google-Smtp-Source: ABdhPJyJquycDYz5y8P+Z1srcHSArUPYnZyN89nppLxIAbRwDbrv1nZlpqn0sYRs/i7ev8OLLQkidQ==
X-Received: by 2002:a05:600c:358d:: with SMTP id p13mr4883477wmq.88.1634036638267;
        Tue, 12 Oct 2021 04:03:58 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.16.219])
        by smtp.gmail.com with ESMTPSA id l16sm2308597wmj.33.2021.10.12.04.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 04:03:57 -0700 (PDT)
Message-ID: <7ec1690ea0ca9f6538b8228f78e62b2f38405fd4.camel@gmail.com>
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
Date:   Tue, 12 Oct 2021 13:03:56 +0200
In-Reply-To: <YWVmvHsEkPFkrD/R@sirena.org.uk>
References: <20210726115058.23729-1-nikita.shubin@maquefel.me>
         <20210726140001.24820-1-nikita.shubin@maquefel.me>
         <20210726140001.24820-9-nikita.shubin@maquefel.me>
         <ed557882a9530f2fd6245e34657be62399df76bc.camel@gmail.com>
         <CAK8P3a0Y4uwX4B10d5CR3WjZ1qXAqhKJGJ0EhUEF60uB1q3H9A@mail.gmail.com>
         <e50f2da7af1fa6f02fd413081fa5762837b86895.camel@gmail.com>
         <CAK8P3a3jAdYQerE03O5s2_PBUqt5QPCPSQxxs54E7-V=0HVBXA@mail.gmail.com>
         <YWVixgDQtJ8EGbwo@sirena.org.uk>
         <7f7acc8986aca1c895de732297b2995d05ec23e7.camel@gmail.com>
         <YWVmvHsEkPFkrD/R@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

thanks for looking into it!

On Tue, 2021-10-12 at 11:43 +0100, Mark Brown wrote:
> > > You're going to have to tell me what's going on here:
> 
> > >    https://lore.kernel.org/all/20210914103212.GB4434@sirena.org.uk/
> 
> > here you were asking about "spi: spi-ep93xx: Prepare clock before using it"
> > which you've already applied (as 7c72dc56a631).
> 
> Right, you asked me to do the same thing on two patches so I didn't send
> the same thing over and over again.
> 
> > Nevertheless, there are no dependencies in the patches 1..7, they are all
> > pre-requsites for the last patch 8/8.
> 
> So what's going on with patch 8 then?  Is there some plan to merge it?

Looks like Arnd is ready to pick it, and the only dependency which is
not yet merged into Linus's tree is "ASoC: cirrus: i2s: Prepare clock before using it".

-- 
Alexander Sverdlin.


