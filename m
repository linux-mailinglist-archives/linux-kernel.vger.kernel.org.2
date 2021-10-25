Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D512439932
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 16:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbhJYOvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 10:51:44 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:37690
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233663AbhJYOut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 10:50:49 -0400
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com [209.85.167.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B5C773F4A4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 14:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1635173303;
        bh=LH+S+D+GBCzu9tGuajRTF5P0LpOZ1vWiDJ3BDbAqLVU=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=EvJh6ZIOpOhskE1A4x3Vr+s9g68xvTtYbaM+M+Pb9a8IEGKBuU3ZfAvMHwtJafkM5
         owWEAXfldKHTMJ+g8kQl93iYP/GI56BTF5mwnfcWvYbZk7X/DTiYNrMxVFhQ1afT8r
         PU6razINBsQeSQYv5H77Y0iPrPSSBA3JF2ey+sshn+H8T4Uqk2upyv64CqTFB8hwBF
         lF+pNd4MTfzqepGDWm6Of5oZhxoxwYlQvWIxw7VKIwk1zobo72xUE7t959bvaSea2R
         /KNjWzkqpDFm2kmMQ26qzMiMzgHWYXlMD6+ptW7m1M5WUbBh1U45WXlUDoeOUBuGpT
         ZY71glKklVeMg==
Received: by mail-lf1-f72.google.com with SMTP id x17-20020a0565123f9100b003ff593b7c65so5318143lfa.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 Oct 2021 07:48:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LH+S+D+GBCzu9tGuajRTF5P0LpOZ1vWiDJ3BDbAqLVU=;
        b=5djY+JrYAoFB30r7fY/mSQgf7Mg/H4KnjuUV4uYflwx2uN2S98Bhj45pJndtS2v2jr
         mFvQ9Z+8pdxy7h5I1hCAqzmpMdYRpPnaIZVrOcwVM4lqYvQ6GHkQI8l1WafoQ0SKt9PG
         SC4elclwjCGz6S2GFOsu3JPp4a3oJljkrF98hybMB6o3hPVZITB4Rs85O4jk+QdL+qNo
         ZGsdumkOd8d+SECv84UQTz6z/WrHTWunqSUA+GLt7qeMKEtwFNFEWDANj7NAkF893Cl0
         tVoTHLENyfyo+bN3FUAi1ArB7+yWatRajYh4l9T7LZXdLvtH+tlaKnC94JB1L9iXJ69k
         IaWg==
X-Gm-Message-State: AOAM530cYrX7TeNCdr0zlw3mwVVIXRtQ5dLLUj/drTEXZJ7Fsry5HwEL
        4rO8IRbwjep5xK/QVmn6AaA/myeQotfJUGZNqGSIjwWRNjjIWMXBoXrJjjqyM5bi+AV0DHrDdlj
        vYNuwB7FvMei49+uwU3NA6OE9VixiCI9NmBGANTokfg==
X-Received: by 2002:a05:6512:b97:: with SMTP id b23mr7435095lfv.50.1635173303253;
        Mon, 25 Oct 2021 07:48:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxd6m499afz2jxS9BIn4Prm070HwxBO4wn8iB0xS8fXZQi09axQW2YeeTU0Wbfj4YyPtfX6Rw==
X-Received: by 2002:a05:6512:b97:: with SMTP id b23mr7435050lfv.50.1635173302733;
        Mon, 25 Oct 2021 07:48:22 -0700 (PDT)
Received: from [192.168.3.161] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id o5sm1667767lft.278.2021.10.25.07.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Oct 2021 07:48:22 -0700 (PDT)
Subject: Re: [PATCH] nfc: port100: fix using -ERRNO as command type mask
To:     Thierry Escande <thierry.escande@linux.intel.com>,
        linux-nfc@lists.01.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20211025144751.555551-1-krzysztof.kozlowski@canonical.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <42e958ae-7786-4d80-7491-6955e37a4f25@canonical.com>
Date:   Mon, 25 Oct 2021 16:48:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211025144751.555551-1-krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2021 16:47, Krzysztof Kozlowski wrote:
> During probing, the driver tries to get a list (mask) of supported
> command types in port100_get_command_type_mask() function.  The value
> is u64 and 0 is treated as invalid mask (no commands supported).  The
> function however returns also -ERRNO as u64 which will be interpret as
> valid command mask.
> 
> Return 0 on every error case of port100_get_command_type_mask(), so the
> probing will stop.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: 0347a6ab300a ("NFC: port100: Commands mechanism implementation")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/nfc/port100.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
> index 1296148b4566..ec1630bfedf4 100644
> --- a/drivers/nfc/port100.c
> +++ b/drivers/nfc/port100.c
> @@ -1109,15 +1109,11 @@ static u64 port100_get_command_type_mask(struct port100 *dev)
>  
>  	skb = port100_alloc_skb(dev, 0);
>  	if (!skb)
> -		return -ENOMEM;
> +		return 0;
>  
> -	nfc_err(&dev->interface->dev, "%s:%d\n", __func__, __LINE__);

Mistake, please ignore.

Best regards,
Krzysztof
