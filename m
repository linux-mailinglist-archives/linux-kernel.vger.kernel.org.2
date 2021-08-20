Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1BA3F2A51
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 12:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbhHTKwy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 06:52:54 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:58000
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232069AbhHTKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 06:52:53 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8BD8F406E1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 10:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629456734;
        bh=bEY0tLoe24jiwQ1BBwb3ntpzUGXLwmR1QkfqwNeab5Q=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=NIMqk8+hTRCl41SfiPqxypEjfwN6iwszeo7BvIK4f7272qtohKT6B2D5AFkRQOTg3
         ZGORwjQF92sypjSB2aupREJRpqyymOJaWpqv2HKeOJm0dE108bwIVvzGpHmwsv9g6R
         2ZqN9agHeswTUZdb8ucs9OHuFkJNxWkB1pHikAzZAjWR8Vy+uQNYHGBGgxspUPtiEz
         Vkj7gXtPxBHHX/MgKMtbZu4+SRfqnGldYZAoMLCgfndBXKtdaz3umTRku51yIHXV6d
         fUUNaXzYTIwBwGrBo2PmPmIHLq2M4M4U3WLwUdqtLSsmlZ+IcSsO+YvpDKmH1b+ZUQ
         SVitWDqcS75Ag==
Received: by mail-ej1-f72.google.com with SMTP id gv53-20020a1709072bf500b005c0428ef7e7so3515591ejc.21
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 03:52:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bEY0tLoe24jiwQ1BBwb3ntpzUGXLwmR1QkfqwNeab5Q=;
        b=DdiOn77hTXVpALjOMwcV0X3JHUI14TSDhrddF0Okx1zqSJLOGOFcMpMsk2remJd0fW
         2uvwGYTbqIxWIs6noASIGuRM0vr4ddsYmKjyoNlww2lSFQB09K91sjtIexNR4xLxO5qi
         jZL5c1Uyff/UNWsELpvNydb5Z2K1dXZWfS1mdwudtzczmyOo8DvlQ+v5bgUfBNeJfaHv
         TaeGuKGOSr2Cn744jbtgVvwQXu86fML7OxEkhNcsANH+YpbYKzyRmQHANDH5kRbg3CTw
         ytDDUAU/0Hkr5Pqr4tdPyQ7ZZB5hbZxCT/bT3Vb8MYlkt7D0j+YJ4cj3RvY9wiFqzUmF
         NeOw==
X-Gm-Message-State: AOAM530v0PLTUh1Wk5AL6wFJm6AF+xVZK0foikEemA1i8A0em5jr23p9
        Dog95YQB0kL69S8It3SURkh9aFzrKKhrFlrvLVlPk2GalAFOcDu/ZtPq3XWySMg1Eew5K2z6j87
        YN3sEVZEk+lblJZJl3hzXhH4cGbT9IrX6JGJUi03zgQ==
X-Received: by 2002:a50:99d9:: with SMTP id n25mr21936501edb.310.1629456734353;
        Fri, 20 Aug 2021 03:52:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwgHZjGv4/G3o//as9FIIt8mx7PidsjndSwA7RNnyaBmG0u7l+H7nGHvlAtxIyexightLogQ==
X-Received: by 2002:a50:99d9:: with SMTP id n25mr21936486edb.310.1629456734250;
        Fri, 20 Aug 2021 03:52:14 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id h8sm3269223edv.30.2021.08.20.03.52.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Aug 2021 03:52:13 -0700 (PDT)
Subject: Re: [PATCH] memory: tegra: make the array list static const, makes
 object smaller
To:     Colin King <colin.king@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210819133155.10441-1-colin.king@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9ecb8f1b-7e2a-7d5a-c176-07459d0c148f@canonical.com>
Date:   Fri, 20 Aug 2021 12:52:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210819133155.10441-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/2021 15:31, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the array list on the stack but instead it
> static const. Makes the object code smaller by 110 bytes:
> 
> Before:
>    text    data     bss     dec     hex filename
>   37713   21992      64   59769    e979 .../tegra/tegra210-emc-cc-r21021.o
> 
> After:
>    text    data     bss     dec     hex filename
>   37539   22056      64   59659    e90b .../tegra/tegra210-emc-cc-r21021.o
> 
> (gcc version 10.3.0)
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/memory/tegra/tegra210-emc-cc-r21021.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Looks good, it's too late for this cycle, so I'll take it after merge
window.


Best regards,
Krzysztof
