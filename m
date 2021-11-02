Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4387442AC2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 10:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbhKBJwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 05:52:01 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60402
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229869AbhKBJvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 05:51:54 -0400
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com [209.85.208.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3E7883F1AA
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 09:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635846559;
        bh=QrINL26Fq3mxvitvfD3yGH3qJYhXNEC7YRh2TlZeXPI=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=ZidIcpIT/dzZutOzmYBOWIchiWSsy4TSFnBTh9apON4401WvLZWdbZ0tw2OmvE+pe
         lzeSu10aSJVVAnf63Mdz+m5tL71rVQ3vI4rRF6bP7fAMQwRlmcgkl9GbdKuaju3OTa
         fe9cTbv7FC3dOp9hIOCVS2L4ZxWmN91cPqFH3p/itxn/Kz19szWRyn5SOsq1S5fCcn
         SuoixzQZdmlgzNX35wKTC/Kbc+QbCGyTJ/jZao4i2pgbDHYxBQ9w+UH5h11YcBM03r
         7K5TNcYDM8EuXcTy4BRGuKr3A89WeuH3kOjYr4XFIxvGaJc4bIzOXYiJzBh2XmMZUU
         OCf0WAPoBCigQ==
Received: by mail-lj1-f198.google.com with SMTP id n9-20020a2e9049000000b00212acec7473so6933103ljg.22
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 02:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QrINL26Fq3mxvitvfD3yGH3qJYhXNEC7YRh2TlZeXPI=;
        b=wzu0NIOxROKEPioeVd2Ap8O3BJVTBULs9ax7QfqfKX5kKgtlIy8aFCocnMzfd4az9b
         ptaKsXQyKCXC9q6gRS/u4nW3AJBhqtcjRVkaTsF8NSQKCxY9MNnQ3h6XZjmykarXELMK
         o989wkK9S9EY28ZDD5ieVhvfG03w4jPe2fQrjE1nFvQSWLhjUyyiMipxBPyGuG1qt5H5
         IneI8n41jTuGaGwE3WxkWpvKLHApvGO2HBI32h5dk3uU/PZmNPB6DJFahG6cre0WYk4a
         UfjjF5nF1IHknO3QVRDMqaJxge19puYtu0n0upx6vNdq/zB3ihQIaXCp+1yZkswN2sXy
         90zw==
X-Gm-Message-State: AOAM5333fG7ZBEPX0xD/rKkGGyzHzOnujPVPaltQm5b7t1UN8oXH4EwD
        2mpSdCTjZCilvInxAYhTvXchKsIbgNEq0NWoq16l+1SzTUnIjLrMDOXerq4h9nvPs+AKsABAE9N
        p+vLHEz8RtRtjad2rigrlnk0DHv3g9c+759BgwflK7w==
X-Received: by 2002:a05:6512:3d13:: with SMTP id d19mr32048464lfv.607.1635846558803;
        Tue, 02 Nov 2021 02:49:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZhL4Q7sws34mo0mTkJjCcGCaFI2kTdF+p8TepT7dcTH529ZZiddbbTUJajTFNBjzOa96HBg==
X-Received: by 2002:a05:6512:3d13:: with SMTP id d19mr32048452lfv.607.1635846558648;
        Tue, 02 Nov 2021 02:49:18 -0700 (PDT)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id a6sm287917lfb.186.2021.11.02.02.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Nov 2021 02:49:18 -0700 (PDT)
Message-ID: <4e3271fd-d804-ca47-100d-7592d7ce425d@canonical.com>
Date:   Tue, 2 Nov 2021 10:49:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH v2 03/12] watchdog: s3c2410: Fail probe if can't find
 valid timeout
Content-Language: en-US
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20211031122216.30212-1-semen.protsenko@linaro.org>
 <20211031122216.30212-4-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211031122216.30212-4-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2021 13:22, Sam Protsenko wrote:
> Driver can't work properly if there no valid timeout was found in
> s3c2410wdt_set_heartbeat(). Ideally, that function should be reworked in
> a way that it's always able to find some valid timeout. As a temporary
> solution let's for now just fail the driver probe in case the valid
> timeout can't be found in s3c2410wdt_set_heartbeat() function.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - (none): it's a new patch
> 
>  drivers/watchdog/s3c2410_wdt.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
