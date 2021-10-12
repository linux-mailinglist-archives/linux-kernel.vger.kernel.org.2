Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F112742A4FF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 14:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236612AbhJLM7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 08:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbhJLM7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 08:59:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AA6C061570
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 05:57:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id r7so66766969wrc.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9BRnICML+eh11SmOadr/4aabH8joUGg2Wy5/vcK4NCA=;
        b=k05qddI4yMu88qAtizX86dn+CSQ7sN6YlzZGwHC/ASkZAXkHZX2hPh/kjQJF0Q6WLf
         uMeg0bprEYDw/1ymRRz4N6JvPWYfxYB+tKd+DilwPwKEJveflVRPWzwj5slwRny2Fv00
         ZwzUK9K7cZekAfkYsqx6BltBBgTqXzmiSR7v4nnDWfD4+8u3/cxulBQ0m1LIDs4eObxO
         LtI2i9uYFE1sm97ppjTCHsZehlFbIanMqM0c3vZJQUuMADJj9Y+OrAxozWtmGDWMk/N3
         +zRsTb1mBdXTfFRMgdsrZr2soLzGHQPujDyk74s4pcFv29KcOG/jtbWVFrSZxR+lCKJ6
         xdhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9BRnICML+eh11SmOadr/4aabH8joUGg2Wy5/vcK4NCA=;
        b=FZjF4vX8adshECP0dPWvwsasvEhncOMnnhnUp6Syv6xa1sVvZN4AuSaLt3QzP2Ko9G
         6Dhpkkcth0GYryxYpVrAxImdTBwlp+IJXGRO9eD6ShoLWbx/GtjuAVbux3jGubzlhIW9
         zOQQwFVDK4bMM/vb3SZQuNNh7GSfNxlxi+cGuRjjT+etCgXm0Fc8QX5GP+svsl8Ri4RJ
         kEObz4yHzIhZSD/rGM2zMqtTzA4XVrDd7MKNGfkOFD9sH5z2Mumqu3qGY4IL/5vh5kOP
         p68jAb3jaTENxVUbpNj5fUnO52jz9WrOW8RyMuNgIpZeiDHmtugcBWfacb8YMq/xx1tO
         FEFQ==
X-Gm-Message-State: AOAM530Cp6xzVo15a9bamm85zu37H9hHazlb6qLbMgWBpArdWJPBANeB
        uPjuLFeJfvMTjKgOAKAC+HI=
X-Google-Smtp-Source: ABdhPJzLYzD62tUiHRV/dwDOcWPFQYWHFzpV3DkNYqm2qNlN/GuIXT0Ga4u8NFeMMlIaug2C56H0JQ==
X-Received: by 2002:a1c:7201:: with SMTP id n1mr5306097wmc.19.1634043466664;
        Tue, 12 Oct 2021 05:57:46 -0700 (PDT)
Received: from [192.168.1.21] ([195.245.16.219])
        by smtp.gmail.com with ESMTPSA id m15sm2656721wmq.0.2021.10.12.05.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 05:57:46 -0700 (PDT)
Message-ID: <3ea0db23ab3284fdee2fec6cfc08026a0acccb6f.camel@gmail.com>
Subject: Re: [PATCH v2 8/8] ep93xx: clock: convert in-place to COMMON_CLK
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Mark Brown <broonie@kernel.org>,
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
        Nikita Shubin <nikita.shubin@maquefel.me>
Date:   Tue, 12 Oct 2021 14:57:45 +0200
In-Reply-To: <CAK8P3a2cvd+od4+UwwrBQ=7F3+cpEAMFz9tBfsZ=nR1Ak1ppwQ@mail.gmail.com>
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
         <00781d5212bb4015064d07e762ae0695d16e834e.camel@gmail.com>
         <CAMuHMdUCpfpORD9r28r1hdtdKMPyvXtkYZQsiBCfM8WDcLYKFw@mail.gmail.com>
         <CAK8P3a2cvd+od4+UwwrBQ=7F3+cpEAMFz9tBfsZ=nR1Ak1ppwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, 2021-10-12 at 14:39 +0200, Arnd Bergmann wrote:
> Right, if everything else is in mainline, then having the last two patches
> in the soc tree gets the job done the quickest.
> 
> If any of the other patches are only in linux-next but not in mainline yet,
> then it seems best for Mark to take the ASoC/i2s patch for v5.16, and I'll
> take the last one for v5.17, or maybe queue it separately from the rest
> and send that in the second half of the 5.16 merge window after everything
> else has landed.

correct, everything else is in mainline, only these two left floating.
Should I resend them for soc patchwork?

-- 
Alexander Sverdlin.


