Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A984028CB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 14:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344602AbhIGM3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 08:29:52 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:34048
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344595AbhIGM3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 08:29:47 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8FE71401A9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 12:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1631017720;
        bh=1lz5zbXaAC/6Xt9DSvyMvWDrwTMabkYousM6j7peGJE=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=X+paikGBkgHHKn07Xm0GYxpQ5sOKedPgIOXFMsfX6rE5xuMKDkx5U3TObNJhTG4uE
         FIdWaMdIe0pvBJpLGFln8TNQgbkoTctNb5/RMpYGFcx90v62+llQ1WkkY8tieP68SR
         HDUQmfRfGHra8V8Z+Mi34D+yVGuSC/gOGfM5R6DyyI4sg1rgpQmqnY0g/RkYI/TT7d
         jj7Xp8XRIWFgRLo2yHofEQGOcwxwPkfo/EcYZ/SYYirQqHmyMl2nnpr8tkwsN1fLR/
         6DlUixLpArreZdFwCD72vVwSNEkoV6qdegQDk6rUN6VswyQdUB0NEBtuuX54MMltAT
         EJjEljP90CuuA==
Received: by mail-wm1-f71.google.com with SMTP id r125-20020a1c2b830000b0290197a4be97b7so1039549wmr.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 05:28:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1lz5zbXaAC/6Xt9DSvyMvWDrwTMabkYousM6j7peGJE=;
        b=XsG/GYXXealuPqum3IMFuevCivlEUJETKKK8l4HmvFRdlWL/NCOwZoqKM8IvVpL9Xh
         1aqivZvtU5sNBaCBjVAzosv0LMCvQiSAzCUJ5s6NyS2P2thzrIsbmWeqL1jh/48sUreH
         TCpDrOq40hLIuq89YsOAUN29WPWaLaIlfaX4ZVZICosHoHAO4Yq5SMuo9awY1tisDP4r
         G7fW0Wo65v5/qLb38Y3KXODRvAutw3TDrqLatR92eW+sC2NIakZ/lWws5vCsxt3PNU3A
         608zireLC0qzfrExoHeWaP60a1KSPpVnlW6jtX5C0eY2FZ/TPXMp3L1wXZmacLs5V7QJ
         HfAA==
X-Gm-Message-State: AOAM533wsnEwkNvsjR7vlp/rLsSRVJWJYYJh+IsCb6CcFPh2FnGUFl7A
        E4VHnVH1uq08hwgJn9srTYYHB1IvD/yAQ2JAK+glXB5HTqKX0mksAFHtQwk2P3BmZfT+mKbIfCZ
        XjZe/n7eJWEWH9xAX+p0X7y+R7Y7/5rLQlyiQZM0Llw==
X-Received: by 2002:a05:600c:a44:: with SMTP id c4mr3736057wmq.83.1631017720022;
        Tue, 07 Sep 2021 05:28:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxnia4fxnHdJbDEwVsFWre7qSHYc2QGFISEhWQFymiMZBSSOqZlc7sbdrkWnKGP+ygKpVwCvw==
X-Received: by 2002:a05:600c:a44:: with SMTP id c4mr3736037wmq.83.1631017719840;
        Tue, 07 Sep 2021 05:28:39 -0700 (PDT)
Received: from [192.168.3.211] ([79.98.113.90])
        by smtp.gmail.com with ESMTPSA id f3sm2266751wmj.28.2021.09.07.05.28.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 05:28:39 -0700 (PDT)
Subject: Re: [PATCH] clk: samsung: s5pv210-audss: Make use of the helper
 function devm_platform_ioremap_resource()
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210907085122.4305-1-caihuoqing@baidu.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <cb81b1d4-d1de-c41d-3966-ac36f282de1d@canonical.com>
Date:   Tue, 7 Sep 2021 14:28:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907085122.4305-1-caihuoqing@baidu.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2021 10:51, Cai Huoqing wrote:
> Use the devm_platform_ioremap_resource() helper instead of
> calling platform_get_resource() and devm_ioremap_resource()
> separately
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/clk/samsung/clk-s5pv210-audss.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
