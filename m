Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87FBA3909C5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 21:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232609AbhEYTlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 15:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhEYTlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 15:41:10 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F27CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 12:39:38 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id c15so39675807ljr.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IbVJxsO27o2qFZxL3wyS49D5/TsMce+2ElGODKqUVa4=;
        b=RmavRQ4tE3i1dwKyHWmQX7m5Rb3+XwETpdwOSNwaqbPideWuj5Kqv6DNbOm3Y1zlLa
         w7PR9TR3GvY+RYcoOrM0AgfVV5vRHlPn3fgzW5bq8bjfMvveR9a154W7w7FmknUufuIW
         Br5RuaFYddK0QHrafDVv512vlMNp3/urUnmS38fR9BsLsSWxWmxx3QOfhpJzMYVFdVVJ
         g30fZ25nJQoN5IGTIrBXcvikPw8ceAMvinBGBDiWmua3pNvcKxBaCFmELqoN48OwxHSK
         2C8+/rKLvqJ0j6LDd+IE84TkhBJSjrrOKi8EW9qOYlKHBVBNQIZ7ycyw/qsaFgRWgGSU
         nDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IbVJxsO27o2qFZxL3wyS49D5/TsMce+2ElGODKqUVa4=;
        b=jFTwWCymMTGhVqlyvIKUxrRjQ8hpNZlXMllJyLQJ4924qrZlCYJeKWBAY9FdWXwSlJ
         TPFrT4zklvlaGRtju5ULjXIsJy5T30bQEAtbd02/NFnFHzbGGMaPPzz5SXvVnDxTRVoH
         BbSwTmeKIvGXJv3CvPDve/QqUz4mw6IVy0WDbDMW18s37fh9VzdjZccM5ZY700ZnjUva
         St89Phy5hxOllQuZ6mfe9NGltHy0Nlc5e+ZrcTkCvjMU3285wesnZbU/JVjjgSuafa4x
         HEBDrRqZFh28k/0YbeX+PanUvdP8QypSWehsAOrqTtJ2WHWxXnqt4FPXUtBhb6zwR+qg
         7PUA==
X-Gm-Message-State: AOAM532DoxU+K9aX//2RrujH+NyJj15Pdvp+MYEez5UVLcKme+9i46mR
        CmXjMEF5DQ/Mh6wliNQHDKVp6PI34ex6YI8jHm0=
X-Google-Smtp-Source: ABdhPJxNCkeUjIcsF3C7x6hBdpSWC2YvSU/3UnXLKVFkJHxJWMv1xuc+prB8xa4Z5N8WwtdWPhTRWw==
X-Received: by 2002:a2e:89c5:: with SMTP id c5mr15874234ljk.301.1621971576850;
        Tue, 25 May 2021 12:39:36 -0700 (PDT)
Received: from [192.168.1.49] ([109.197.205.52])
        by smtp.gmail.com with ESMTPSA id v21sm242563lfe.255.2021.05.25.12.39.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 12:39:36 -0700 (PDT)
Subject: Re: [PATCH 1/1] ep93xx: clock: convert in-place to COMMON_CLK
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        YiFei Zhu <yifeifz2@illinois.edu>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210525083340.27722-1-nikita.shubin@maquefel.me>
 <20210525083340.27722-2-nikita.shubin@maquefel.me>
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <3cc57395-7489-fdb3-a497-f93a0439b92b@gmail.com>
Date:   Tue, 25 May 2021 21:35:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210525083340.27722-2-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nikita!

On 25/05/2021 10:33, Nikita Shubin wrote:
> Converted in-place without moving file to drivers/clk.
> 
> tested on ts7250 (EP9302).
> 
> Only setting rate and change parent tested for, as they
> are missing on ts7250:
> - video
> - I2S
> - ADC/KEYPAD

I will be able to test I2S and ADC but earliest in 2 weeks,
as I'm currently away from my test boards.

--
Regards,
Alexander.
