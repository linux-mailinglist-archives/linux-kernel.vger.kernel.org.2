Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 838F23909CF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 21:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhEYTpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 15:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbhEYTpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 15:45:10 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63E9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 12:43:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e2so33396835ljk.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 12:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s2HJsHtlpgip3mlRgyFOxcbNBFloH0gFAyE8clEbkrA=;
        b=YhgGx22YycvtdJruYObHjTbeSrdR+Uxb2QevpVpGBGpoXxKPl1RRT6RHl6IW6KA3or
         dHcgbhvqgJjTUbkj8JNCEuElmrnz2fNB5Ev4ZF06RV0wAUplHNw9KAy8mWREeK3wK8ak
         uZJQOf6o/npkSSujyAGjSom8KoZOhsQMlpwpdYosqyWl6YE6ebugrFnQKpnbfoOkkM26
         WQxY3WGI5dDgBPJJ577mzD805qGX0Bm7byVwWJiTl6kw0aOn59xpq+Us7wHxRmR13y1s
         9xpB6BE5N6zXiWBDVMefvgw8njbKSvR9FcEx4HBTms9g/s38OKZTmRPNHnJcZ/7h6OI8
         G46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s2HJsHtlpgip3mlRgyFOxcbNBFloH0gFAyE8clEbkrA=;
        b=CSJbP7Q2eEiOvnHU/i6CLRsyG54Kg/EP7NRTY/VlHL+KXrAOEhqk6IDBo1gBAULliT
         SFT8+qPYXhiRWWpbWWA/Vuz4me/tSDRvlqEkCAFIkDun2cIgWjbX49jXS6AjELz7mCNV
         06WdmrB9mN+SHLhEJdkSfj2x5W05P+UWz6g3z7KauBAy5apq1HG7WD6uyLfRIsftLq5D
         N6KDUXxWBJcDsGRjQ3p0J5HJamdlEUZ1eaBpW+aYx/xCqxaeWMOrbLhtOZr1lHYzq+af
         QwnUfChFuJcBalVTI351Gw/2YOUbGcd+oikKTHwlruNQTGWAExc0CueF9ZIUw/eE37mq
         Y7jg==
X-Gm-Message-State: AOAM5315llb99hPfEDoKXa6uawFmwOsmlj5YqL1Tg6IX9PyQSlroQc+D
        Ml3gjIKpDNoxaFGYlDr2IJ9ibYxqs/ZPlXTPuWI=
X-Google-Smtp-Source: ABdhPJyXTH+4RElt2vc239Z86YYEBuAltn/0gTZ6HVtghsk+pNw0Ryy6SsrshJrkinaj0rSI6yxD4g==
X-Received: by 2002:a05:651c:621:: with SMTP id k33mr21521707lje.484.1621971816268;
        Tue, 25 May 2021 12:43:36 -0700 (PDT)
Received: from [192.168.1.49] ([109.197.205.52])
        by smtp.gmail.com with ESMTPSA id c14sm1817315lfb.129.2021.05.25.12.43.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 12:43:35 -0700 (PDT)
Subject: Re: [RFC][PATCH 0/1] ep93xx: clock: convert in-place
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
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <b05ef6b2-9161-50a0-1c93-71bf8ec7fdb1@gmail.com>
Date:   Tue, 25 May 2021 21:39:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210525083340.27722-1-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nikita!

On 25/05/2021 10:33, Nikita Shubin wrote:
> Alexander please look at provided patch, the size goes from
> 
> ```
>    text    data     bss     dec     hex filename
> 4491689  920748   92840 5505277  5400fd vmlinux
> ```
> 
> to with patch applied:
> 
> ```
>    text    data     bss     dec     hex filename
> 4534485  927424   90304 5552213  54b855 vmlinux
> ```
> 
> If this is not acceptable to you, than it's perfectly fine, i'll 
> finish (actually only gpio left to rework to DT) and stash my rework 
> somewhere and can send link or patches to all interested.

I don't think that 50k is a serios issue even for this HW.
And Arnd is right, we still have some potential hidden within
missing CONFIG_LD_DEAD_CODE_DATA_ELIMINATION support.

> But still if you have possibility to test clocks for video and I2S
> it would be nice.

I don't have video, but I2S and ADC, and earliest in 2 weeks.

Thank you for looking into this!
--
Alexander.
