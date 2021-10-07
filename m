Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F79E425428
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 15:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241600AbhJGNfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 09:35:08 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:51662
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241592AbhJGNfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 09:35:07 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id ACDD940005
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 13:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633613592;
        bh=XOOtcMxu4VGplGw4HdBrnq8LT8wk3wMvDJtbbxYgvsw=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Hm0ObiBkLQ/uvvAkSfpV/DAlHEH9GBBRC7DBOC4aBdXrFVvwWquRyo2ArUINBLpRH
         F+1aqEXzH9gx8FcWOB1rDC7msnQi2BTzZHzoKzqeqNQqebfyA3M4Rzr+9pcClMtgau
         f8RQA/Shljmh728voCd24eCl92vpQLDNECfNUlnJRPYUZrPMxzjJBX4epn2vIMQHMm
         bDuO9JtXZ+s3ODF/Lb8pCXnX9CCyEiih6qE2Btoc01BLTXxYAJTPVsBrQSwCEolvvI
         xuu+lSx0/oMTno4oHuLsSIG9M82kxFGM06tSIxqbmcEeCaGDA2hO7KUBOAkZ329wfY
         feVa95XfbHrfw==
Received: by mail-wr1-f70.google.com with SMTP id k16-20020a5d6290000000b00160753b430fso4731553wru.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 06:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XOOtcMxu4VGplGw4HdBrnq8LT8wk3wMvDJtbbxYgvsw=;
        b=wi6OITOchQsfzGwxYd0Uy3ooOI3zzL06NzffKQnU59OZhaFdpAT02mYqf1VyyxuSqI
         1w0ngQEkNuuyr/h4ZQy84+fxmVKo2/y0CxIby7yqCC4IBBRJ89wFfj4RRkgAshr0VieG
         PPom3XRlAnybs1FsCCGckMTtADV6DtJxm8B5h/DPtD5Zh9wth7DlbJyrSQfqz2d+xOrk
         qBLSAPLXw9R4OSC6VzV5xHq/+SEG0I9VXM9Na48OBbAwxpP4Y588Wl98jupR+p6TpumH
         zYIBQeu3O/MKUfj0THYJUhyuMWMzrOdOuotgUSqaBM/UEKlMg+VEetddQz1dIA5vwRS0
         5YBg==
X-Gm-Message-State: AOAM531GQuZZxyo03PRU9G8NLWvfWmhAUcnNKtYRUnB1y09UwHv1hloq
        WVKkLHnlTjIJKIgoargL0yhPm9r28ZjaN1fdRoahyPUXvOjh5RKX/I0rj/vMATgO9BvgfxrmFuP
        aVNteJRkw/5R4H5hsNswjZpOIocjRXuWgBHBu4a0u9A==
X-Received: by 2002:a1c:4487:: with SMTP id r129mr16396831wma.127.1633613591678;
        Thu, 07 Oct 2021 06:33:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjsCDvHGtPoTWQUiPu1xD+rfOLwo1X6CpLXbYUd/gRjlfYdJKXG9PE5H5BcQatFGmrqVvqCA==
X-Received: by 2002:a1c:4487:: with SMTP id r129mr16396804wma.127.1633613591523;
        Thu, 07 Oct 2021 06:33:11 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-186-13.adslplus.ch. [188.155.186.13])
        by smtp.gmail.com with ESMTPSA id y1sm13474952wrh.89.2021.10.07.06.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 06:33:11 -0700 (PDT)
Subject: Re: [PATCH v2] tty: serial: samsung: Improve naming for common macro
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20211005095800.2165-1-semen.protsenko@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e2e8cf83-b888-9472-c25d-03c4068e25d3@canonical.com>
Date:   Thu, 7 Oct 2021 15:33:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005095800.2165-1-semen.protsenko@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2021 11:58, Sam Protsenko wrote:
> Having "_USI" suffix in EXYNOS_COMMON_SERIAL_DRV_DATA_USI() macro is
> confusing. Rename it to just EXYNOS_COMMON_SERIAL_DRV_DATA() and provide
> USI registers availability for all Exynos variants instead. While at it,
> also convert .has_usi field type to bool, so its usage is more obvious.
> 
> Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> ---
> Changes in v2:
>   - Converted .has_usi field to boolean
>   - Used true/false instead of 1/0 values in
>     EXYNOS_COMMON_SERIAL_DRV_DATA() macro
> 
>  drivers/tty/serial/samsung_tty.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
