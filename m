Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5EE437C7F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 18:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbhELQD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 12:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbhELP21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 11:28:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110DAC0611CC
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:11:10 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id h4so23971106wrt.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 08:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W4XgYJ8+mVcGs+SfB2znlX/BtQuwWvv6RmitvV0I9Us=;
        b=ill6EvDGlsrM18q3cJsbpVTXryJwQRW6hgBDs2vy9rngryYawBom2xFCOKD3fOamO2
         AyxmpxqNCBLPiEZWmtd+bZKDW2qr2z9FVA7peUW4SrLuvRM4xga0GXaTp9hAIzbSzOnX
         spX6mEbGactsUGVCCX35iL08puJpeHAW3cVGBAhz/qQ3YWk7mDIMKM6tqgF04i5mXEeR
         lS4Nca9zlQ05j+jQ39eokkiGUxIni4r8DdgvzgICUGC1dZJSlDV1xQiYMeN0aRFKJ+dy
         8Bs6rQJJhpSaCb+qvToXn9NG6g/icdLH5zqFFIO1YHYHQlD1CDVELW1hAQDAMS386Lag
         Wlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W4XgYJ8+mVcGs+SfB2znlX/BtQuwWvv6RmitvV0I9Us=;
        b=o+A0LwT86Q4kf4kioy7SMjerX9hImq8zl8NauUpkXOIXaswiDFP7o5KozBc3sZK5Dp
         3NofEnPSrBg4CMmShpD0LWnIzH8C7vJEuPGkY8MLGv8Z0+2c35jOvOXKJ/BhwIqzPoyx
         tQCVqUUA3PvqWItMlWvq3RQOtph2gjQ9dvIvtCGQFrcdJoepTDXQcUK9+OhqocDLSqQy
         ZyIn+Bdc2+bitBO8uqFo30aIsmdcXgj7+2XTYMq/QI1lQHoelxd2MjJhmy0jhWAmQbXW
         gO73k3u1Zjjb9SzG7hKCPVqmTknlKyUZymG9WqCkH7obvTdJITUvDixSJkerRl/5rb6D
         wTQg==
X-Gm-Message-State: AOAM532ugSMzJkge8ozpXBc2LygCCrZ9VImTFzDSkIJXW1GUvKIlLqAk
        Pa1t51JE1aYWuF8jDgnbG5j/z0EjYF4iJg==
X-Google-Smtp-Source: ABdhPJwohaeGeQcb6BDOkXEhXQQTdwLBIcHRW6ytEUym4yqXARME4CLJyos9DGAAn7I3yqDtZnlyXw==
X-Received: by 2002:adf:9c8e:: with SMTP id d14mr46741550wre.140.1620832269287;
        Wed, 12 May 2021 08:11:09 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1412:ffb:31a1:6c9d? ([2a01:e34:ed2f:f020:1412:ffb:31a1:6c9d])
        by smtp.googlemail.com with ESMTPSA id q12sm31540104wrx.17.2021.05.12.08.11.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 08:11:08 -0700 (PDT)
Subject: Re: [linux-nfc] [PATCH 1/2] MAINTAINERS: nfc: add Krzysztof Kozlowski
 as maintainer
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-nfc@lists.01.org
References: <20210512144319.30852-1-krzysztof.kozlowski@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <961dc9c5-0eb0-586c-5e70-b21ca2f8e6f3@linaro.org>
Date:   Wed, 12 May 2021 17:11:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512144319.30852-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2021 16:43, Krzysztof Kozlowski wrote:
> The NFC subsystem is orphaned.  I am happy to spend some cycles to
> review the patches, send pull requests and in general keep the NFC
> subsystem running.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> ---
> 
> I admit I don't have big experience in NFC part but this will be nice
> opportunity to learn something new. 

NFC has been lost in the limbos since a while. Good to see someone
volunteering to take care of it.

May I suggest to create a simple nfc reading program in the 'tools'
directory (could be a training exercise ;)


> I am already maintainer of few
> other parts: memory controller drivers, Samsung ARM/ARM64 SoC and some
> drviers.  I have a kernel.org account and my GPG key is:
> https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/keys/1B93437D3B41629B.asc
> 
> Best regards,
> Krzysztof
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cc81667e8bab..adc6cbe29f78 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12899,8 +12899,9 @@ F:	include/uapi/linux/nexthop.h
>  F:	net/ipv4/nexthop.c
>  
>  NFC SUBSYSTEM
> +M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>  L:	netdev@vger.kernel.org
> -S:	Orphan
> +S:	Maintained
>  F:	Documentation/devicetree/bindings/net/nfc/
>  F:	drivers/nfc/
>  F:	include/linux/platform_data/nfcmrvl.h




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
