Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E190932E5BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 11:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhCEKIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 05:08:13 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49215 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbhCEKII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 05:08:08 -0500
Received: from mail-wm1-f71.google.com ([209.85.128.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lI7NP-0005XK-Lw
        for linux-kernel@vger.kernel.org; Fri, 05 Mar 2021 10:08:07 +0000
Received: by mail-wm1-f71.google.com with SMTP id y9so220683wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Mar 2021 02:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ay2S85l1/jFLfWLeQBtCAoPsbPXTdqgq57n65WUa2l0=;
        b=iRy+OSNjT872FdE8FPfEACmzKpW0JKEuq6JlooC7ZxYiH3ngtQWi1Hammhcs/kUgqk
         O9Jwzgi8ta+S1ND4/HTBcEYJeF0CaSPVQmbo0Y8OmByuoKDuaLfhvlTr1W9FBUc+/quR
         40Q87VoXYAWo1q8qtLPfzPV4oCZP+q0gu7upOVl3r3CyIUsX38uWNz46ncusHLQfnaYG
         7heWO5qsNYPOwtqCyxSDUukn6V7GisIG/qM59otoKBgzI/9H/+9FN2vl/MmuiLkBat49
         i+occRcm0YPeW+1LUKaaTFr1a3/c+NJS1f0hlIghLoPIGu1EghDr2x+8LuwP2WKwpseO
         JQdw==
X-Gm-Message-State: AOAM530fB1x9sRzcqrH/1h/FzAH/Y6W+HlcWsIuIwrGCZY77qRmU5MND
        jlh3QJks23sQF8nuKYVoRojAPqeq+Fk8N4y4gOq9lYGCLlgjg/vGpoDuVT4NGmJCLGmEigzHu7q
        Iy17LQPZiMiqRVLc5ISRtuZmeFC8CAqm1au5HZiyjtg==
X-Received: by 2002:adf:df10:: with SMTP id y16mr8529532wrl.372.1614938887136;
        Fri, 05 Mar 2021 02:08:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOepjFppUsFOhGaPMirdRKmI7kh2qB5leecQOYR1dmX8rE+kDSdNDQJIwwIJjvtOK370QfOw==
X-Received: by 2002:adf:df10:: with SMTP id y16mr8529510wrl.372.1614938886976;
        Fri, 05 Mar 2021 02:08:06 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id v188sm15378373wme.1.2021.03.05.02.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Mar 2021 02:08:06 -0800 (PST)
Subject: Re: [PATCH 2/2] usb: gadget: s3c: Fix the error handling path in
 's3c2410_udc_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        balbi@kernel.org, gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, arnd@arndb.de, gustavoars@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20210221074133.938017-1-christophe.jaillet@wanadoo.fr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <36ef897b-aedc-fcc3-89c8-c602d9733a9b@canonical.com>
Date:   Fri, 5 Mar 2021 11:08:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210221074133.938017-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2021 08:41, Christophe JAILLET wrote:
> Some 'clk_prepare_enable()' and 'clk_get()' must be undone in the error
> handling path of the probe function, as already done in the remove
> function.
> 
> Fixes: 1c6d47aa4f4b ("USB Gadget driver for Samsung s3c2410 ARM SoC")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> checkpatch reports:
> WARNING: Unknown commit id '1c6d47aa4f4b', maybe rebased or not pulled?
> According to https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/drivers/usb/gadget/s3c2410_udc.c?id=3fc154b6b8134b98bb94d60cad9a46ec1ffbe372
> the commit ID looks correct to me. Maybe something should be tweaked somewhere
> before applying, but I don't know what!
> ---
>  drivers/usb/gadget/udc/s3c2410_udc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 

After fixing commit sha:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
