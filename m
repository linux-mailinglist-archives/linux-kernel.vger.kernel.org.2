Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49FD739060C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhEYQAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:00:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55802 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhEYQAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:00:38 -0400
Received: from mail-ua1-f70.google.com ([209.85.222.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llZSV-0007FW-NS
        for linux-kernel@vger.kernel.org; Tue, 25 May 2021 15:59:07 +0000
Received: by mail-ua1-f70.google.com with SMTP id f15-20020a9f2bcf0000b02901f8fe91b89cso13264419uaj.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:59:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qOqY/PaRB6dSn8r0kW8K84aqr6meO0lIWYfkoynWtaE=;
        b=SmubmuhMTx6hhkeDQlDVWxhHhalD9I+CBh2+5fl42STcIJTQRWjPwZ1zWE4BjApJej
         2vVpXz+FyEE2K8ZtQK9OHFtMlc1JFxwVKvIKF55Xql5IO8g6aJhI5dLc/FqXjAJic3jb
         gD3ddulCNuwEtiOd5gchsdbL9UB3hFxrs9yH+CKClLmi/IJOO9xCbL9NQv2vPF/cQgHp
         vswDVIpwbjjHWQwwNrRlQ7uETG2AVdwO7TuHvVGk9c8b3qwP7d91PcHhkklKjpfHK9T3
         a/aA3XJ5a+1LpA+eOiIxQ/Kl+rTEQ0aPkDbyPnbk1hylpZZ56HVJQz138+njeFqR/1Fp
         HgKw==
X-Gm-Message-State: AOAM531yHtgnEuqs20OHlmmNrVt6eatLcl5sm+sxxhWBs15KbHILHsPG
        pm2sBETrC0cTLkXHaWh30SwlwlDrPQ9AmJWJ4HVo3gIYtbkOhrDdLy1SCHbRz+NEZYrcQn9Ea6h
        CEsz67lt9PmHSxg7+UUkn92XJyC859jfub7kQ5gBIxQ==
X-Received: by 2002:a67:ff98:: with SMTP id v24mr26470726vsq.50.1621958346453;
        Tue, 25 May 2021 08:59:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcpLRiXf0FA0FqFZi6+bm39L/TX6DsrBBXmeURF2JB9Uix9bnsGyhRkftDM9zOVxfRQ7ziwQ==
X-Received: by 2002:a67:ff98:: with SMTP id v24mr26470707vsq.50.1621958346299;
        Tue, 25 May 2021 08:59:06 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id d25sm1654563vsh.5.2021.05.25.08.59.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 08:59:05 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] extcon: extcon-max8997: Simplify driver using devm
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     hanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
References: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
 <2bb395c1d6547a6597d72de21dbb9687926de713.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <208fcd8c-f84f-667a-2505-a5abff625c59@canonical.com>
Date:   Tue, 25 May 2021 11:59:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2bb395c1d6547a6597d72de21dbb9687926de713.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2021 08:33, Matti Vaittinen wrote:
> Simplify driver by switching to use the resource managed IRQ
> requesting and resource managed work-queue initialization.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> Changelog:
>  v2:
>   - IRQ freeing fix splitted in own patch
> 
> Please note that the change is compile-tested only. All proper testing is
> highly appreciated.
> ---
>  drivers/extcon/extcon-max8997.c | 47 +++++++++++----------------------
>  1 file changed, 16 insertions(+), 31 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
