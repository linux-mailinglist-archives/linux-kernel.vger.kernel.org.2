Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993AE32FBC7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 17:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhCFQRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Mar 2021 11:17:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59188 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhCFQQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Mar 2021 11:16:43 -0500
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lIZbe-0004kO-Fm
        for linux-kernel@vger.kernel.org; Sat, 06 Mar 2021 16:16:42 +0000
Received: by mail-ed1-f69.google.com with SMTP id l23so2631383edt.23
        for <linux-kernel@vger.kernel.org>; Sat, 06 Mar 2021 08:16:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zs2DsRzkX8tT8l/nIzy+fjRZiW0RahwNShoX9pnJ+yo=;
        b=ikEEDWmYEB9WY2F+vCWhnpg/mj7+Aow7LShjFn95Et7NC0AMex+djNBN+hfLZk8Ee2
         c72p9HmoZ1OIK5uf2VHglOqwyZZLuK26RyhG+H37R0lA2syGgybGgy7TWAxZlKO3qOsV
         AROHQZUmXwJMcxO0kB248xD/sfIXegk3EDNvZqEvBiWmx1cfCnx458tPIjygVx7jVlNn
         0bc5+0rHB3SjQahapUWeizHwiVVk5/nRrUDcl+5Wd4m9+3ivMCAfSnx1AYfOlF9Mx9Xa
         oXR8MYlIu9aY05LRjX7n0nwWpVFJtTqCIxNX55pxWZ4/AxvNr0yQW370rnCzqPUFPgAN
         LFdg==
X-Gm-Message-State: AOAM533Pj89X7aYkSx18mNuU6TEIeZDb3GTrw387anttpcqeKuJOkODG
        O1WUgmW9ij7XsSt29mYGXIbfQAb7F5cWtSIo4ggcWjB91j+33k3+pCNkx99NKYfpfh4OBVhpgcO
        xpvDT4kA3HOBPjLAPSaN94zD3HEimZtxkjc5azpx13Q==
X-Received: by 2002:a17:906:f0d0:: with SMTP id dk16mr7545020ejb.48.1615047402264;
        Sat, 06 Mar 2021 08:16:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwPWbiOXwIA7NfjdpkKMCrGW3Leo2IzuIBlWgonJHx7ep3pWh8GAJ7OaqjMH9aWvpe63p3XqA==
X-Received: by 2002:a17:906:f0d0:: with SMTP id dk16mr7545010ejb.48.1615047402155;
        Sat, 06 Mar 2021 08:16:42 -0800 (PST)
Received: from [192.168.1.116] (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.gmail.com with ESMTPSA id b6sm3356219ejb.8.2021.03.06.08.16.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Mar 2021 08:16:41 -0800 (PST)
Subject: Re: [PATCH 2/2 v2] usb: gadget: s3c: Fix the error handling path in
 's3c2410_udc_probe()'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        balbi@kernel.org, gregkh@linuxfoundation.org, nathan@kernel.org,
        gustavoars@kernel.org, arnd@arndb.de, ben-linux@fluff.org
Cc:     linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20210306142145.3490-1-christophe.jaillet@wanadoo.fr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <64c3ca58-639f-95af-35e1-7d5ba240a7c9@canonical.com>
Date:   Sat, 6 Mar 2021 17:16:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210306142145.3490-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2021 15:21, Christophe JAILLET wrote:
> Some 'clk_prepare_enable()' and 'clk_get()' must be undone in the error
> handling path of the probe function, as already done in the remove
> function.
> 
> Fixes: 3fc154b6b813 ("USB Gadget driver for Samsung s3c2410 ARM SoC")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: Fix a stupid error in the hash in Fixes:
> ---
>  drivers/usb/gadget/udc/s3c2410_udc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 

Do not ignore received tags but add them before sending a new version of patch.
https://lore.kernel.org/linux-samsung-soc/36ef897b-aedc-fcc3-89c8-c602d9733a9b@canonical.com/T/#t

Also somehow your 2nd patch is not in-reply to first one. Don't change
the settings of sending patches. git format-patch and
git send-email default settings are correct. Look here:
https://lore.kernel.org/linux-samsung-soc/
Only your patches are not threaded.

Best regards,
Krzysztof
