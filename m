Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A00443E61
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbhKCIa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:30:28 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:57584
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231512AbhKCIaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:30:25 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E46F23F1BF
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 08:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635928068;
        bh=iiMC/TbWwWkVZ6Szlrhxi5wL8pvgvpBMcUFNxm6iENM=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=BOX0seKZ5eXLs2skVmwt1LcuA/Rf0WM8z2K0XkbPgfaWDH5zymMQgUqrpSp+Aigba
         SaruNtCBsW0w0E7nwcUIFWuYLOysOZv8pgwwlHVxFfSopvuArtp+1JiU0KZj4r0m0s
         OegBmwkMlm2VHC4aH0o6euVv+jVASM6Rf/vEIyUvyzXmPI3OQs4EtgKGnyzIkaoiFt
         5ITrU3rtOuzsc08DZXsGWmy3rdJfN4fbHaTuOTXBvhiI5Htc1hQz6xAdsxJclT2UGP
         wSfF96zDSIoSJ1Eix8r+464PdT+WA89hFi7/y+sGw8zADzTXmVVH8iJSd/DqAFfOkI
         8HUcd/sZBXDaw==
Received: by mail-lf1-f72.google.com with SMTP id t8-20020a056512030800b004017cf4c16dso82023lfp.14
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 01:27:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iiMC/TbWwWkVZ6Szlrhxi5wL8pvgvpBMcUFNxm6iENM=;
        b=yyhRtnbo4D2YcnAxoVE8AqEWc5qGHdlc4WdzkDYdaI8iFfeKqRJG/CIPlPoEI5qwn7
         3zQ5eTyA1O37DYPcms1gZG80Xx9ZuFRfYmGqsSc3BqLNBAa87lxzlyf+VoCObtcEgsFs
         NQo5w0UZhz/9BFp/3O/odN3KedJPCNTnWjVJlaDOLxkwN8S0k51qdwwrL5XGF6uPeI8R
         kBs4ifOZueSsfYdQSkQC/p65yI2aWCLNim82uylLAlDzkcolP0Ez1yTa1FsaotdVfuPJ
         8n7qQE5O2HAEtyXxuHr3KxifBrLGSiaf4PTOWHZfL7Dr6U6KKR4qJn6DugI5OSlTJ8jq
         vYAg==
X-Gm-Message-State: AOAM533bSMN2WPCiCegzpd/nAqxFruA1oejzlUdSevF+NkiRpuiRqkra
        1ieIRZo3R66/fU8mtIgfXFfvKY0lQFV7karlyUf7uBpNNj2PhrxphIOxT0V1481y1j6H5oQdLHF
        kvk100J8hUYm+sozFu72bU/EqdjKnmQqpDcL9AdLrwA==
X-Received: by 2002:a05:6512:3f86:: with SMTP id x6mr40055436lfa.616.1635928068102;
        Wed, 03 Nov 2021 01:27:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwu43lUF6yDVHsDvyw6C4kRdXgj4eKQQH3FqgytHu5fTFkfmrcp9ngAlMz7Dgs1vjWLngCPnw==
X-Received: by 2002:a05:6512:3f86:: with SMTP id x6mr40055400lfa.616.1635928067747;
        Wed, 03 Nov 2021 01:27:47 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id u6sm128527ljo.105.2021.11.03.01.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 01:27:47 -0700 (PDT)
Message-ID: <217cc985-9c82-f9ad-78ee-4d9d82a894d7@canonical.com>
Date:   Wed, 3 Nov 2021 09:27:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [RFC PATCH] ARM: s3c: mark as deprecated and schedule removal
 after 2022
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, Olof Johansson <olof@lixom.net>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Inki Dae <inki.dae@samsung.com>, Cedric Roux <sed@free.fr>,
        Sam Van Den Berge <sam.van.den.berge@telenet.be>,
        Lihua Yao <ylhuajnu@outlook.com>,
        Heiko Stuebner <heiko@sntech.de>
References: <20211102110519.142434-1-krzysztof.kozlowski@canonical.com>
 <YYFpZ9zh5++xl6nr@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <YYFpZ9zh5++xl6nr@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2021 17:37, Mark Brown wrote:
> On Tue, Nov 02, 2021 at 12:05:19PM +0100, Krzysztof Kozlowski wrote:
> 
>> Let's mark all S3C24xx and S3C64xx platforms as deprecated and mention
>> possible removal in one year (after 2022).  The deprecation message will
>> be as text in Kconfig, build message (not a warning though) and runtime
>> print error.
>>
>> If there are any users, they might respond and postpone the removal.
> 
> The Speyside system is s3c64xx based, I'm in the middle of reorganising
> my hardware setup so it's not usable right now but it's quite useful.
> 

Thanks Mark for the feedback! If we keep the s3c64xx, are you able to
provide some tests from time to time?

Best regards,
Krzysztof
