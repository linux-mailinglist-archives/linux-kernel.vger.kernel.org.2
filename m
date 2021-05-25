Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F104390600
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 17:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbhEYP7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 11:59:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55777 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhEYP7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 11:59:42 -0400
Received: from mail-vs1-f70.google.com ([209.85.217.70])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1llZRa-0007CM-P9
        for linux-kernel@vger.kernel.org; Tue, 25 May 2021 15:58:10 +0000
Received: by mail-vs1-f70.google.com with SMTP id s18-20020a05610201d2b029023869267cc8so7233218vsq.21
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 08:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MuGDp3ZHRnFLgtVx3ouCWP4TcKcZPadX0o0zLgLFxe4=;
        b=VC9f8JDmX0AkJSBugA9OKsaRUltWprFT7dXtin+BZ6JmJDPO6d2qm+y6b4OKOXFpIf
         /o7Ro33ljbJQsMylnFqc+cUFImGKTCzlu6ARGPbEbMyNObpzOtASJV1V0LSdzmOTDwgd
         D2exV54Fe0xWFfCRpJc6XrC8Bn2xHvfD7yv5Jm2BKtu+sO3vAEuN3RhoUdUvlXPqKGWj
         RsKcIIFvb/JYkM+SV3hi4Mqb4IkZFXg/sYurrcMhm55gr215AJJZx2q7piGa3gyitd4s
         KZVLGtxOUVxvfGd0bUgLYhmhE2Ugr3fx+l2IcLuBe9V2z+cHlKo+WZA5n+fpv2mxnk0U
         YyIg==
X-Gm-Message-State: AOAM531P7J1FDMAb9q8zQnKptZHEauqMHzxZNgRqGUL9FaXtKL43mbXr
        lSXjBVj6nS58eE8HqVTGg0ZvlsYPsoR+C0H63aYEpesFSgBYUY0Hdu1riaKmEoOrhTcj4H2V1il
        LzbnNPPXfCGqC8MXoDykz1WFz7a2vAILGKjVaoLCjbg==
X-Received: by 2002:a05:6102:670:: with SMTP id z16mr6166873vsf.5.1621958289524;
        Tue, 25 May 2021 08:58:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSQIVxDiGujhuPQ5HAuuNtEcc299f+SZv76DjSudei+k8iWKja7l2evoivzlynfZGe6qiO0g==
X-Received: by 2002:a05:6102:670:: with SMTP id z16mr6166851vsf.5.1621958289334;
        Tue, 25 May 2021 08:58:09 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.6])
        by smtp.gmail.com with ESMTPSA id o2sm1736666vsq.30.2021.05.25.08.58.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 08:58:08 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] extcon: extcon-max8997: Fix IRQ freeing at error
 path
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     hanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
References: <cover.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
 <1a0f3e0d3c9786f97a0a041469a52ee145712619.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <be185a44-43de-59fd-a134-e6a621f74eba@canonical.com>
Date:   Tue, 25 May 2021 11:58:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1a0f3e0d3c9786f97a0a041469a52ee145712619.1621340116.git.matti.vaittinen@fi.rohmeurope.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/05/2021 08:32, Matti Vaittinen wrote:
> If reading MAX8997_MUIC_REG_STATUS1 fails at probe the driver exits
> without freeing the requested IRQs.
> 
> Free the IRQs prior returning if reading the status fails.
> 
> Fixes: 3e34c8198960 ("extcon: max8997: Avoid forcing UART path on drive probe")
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
> Changelog:
>  v2:
>    - new patch (avoid backporting devm_wq just to fix IRQ freeing)
> ---
>  drivers/extcon/extcon-max8997.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
