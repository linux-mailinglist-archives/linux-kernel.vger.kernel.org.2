Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C253E00BD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237943AbhHDMBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:01:39 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:45868
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234533AbhHDMBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:01:35 -0400
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 440833F07E
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 12:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628078482;
        bh=UrGdV0D3iWVxaJtJA8ED/FFHeXLfzVORwPvVExdU3p8=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=HdZ0MyL4jiB93jGyPdnFr+rlzde2NZa0C8i6LVyOxj0tC0TcTKfP5oewO5Yo/yIpR
         lG585pZzpyFGmUc43TO+7A2ys0KM/d3o1srlC5W+QIsMVYtXIphtB6LSJm0Vu1D2+E
         3udBqjIBM75TFayovEKWbSxq7DrR857pBGVQyOtiC+jZljWcfxBLjaWmXkaOMS4Umz
         ikmQPknPVKtMN+5pcDShri2lAhZ3oxX23PVSwDkPIKX9cu0g3wtzjQvc9psnsmtgC9
         Mwsx1+y5k3RE3Ispk+eL4aPB9S0sGtjNFqKHfBIRX7DNvWcfLaExfzDbUGZxdtuDra
         ct/ESoLr1c0MQ==
Received: by mail-ej1-f71.google.com with SMTP id z20-20020a1709069454b0290595651dca8eso727824ejx.23
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 05:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UrGdV0D3iWVxaJtJA8ED/FFHeXLfzVORwPvVExdU3p8=;
        b=FajyL4Rn2Tq+HLjtDnF4VtIOkBsNg3GpslvmDAvJjjr0EimHFi+1/B5vtNzyORYpkG
         qyIlpczvynZv9BgK1MnTsj4JOrv7iyer4tZVgbBrMQkauRvWbh1iYkWBrxaZ/47nLcLo
         pzW61cRlIPfPFt6vUOE/qhqekzlby2CcIRcKKdym9poRYzfZYcSXFUFU8WKQQNaX1B65
         Qv0yPcFdRZwDCdJHoFyHqi+6upTWGcvCNh9CW/9mqHXIDxTJRGWaIClF8YBtaw1seOLz
         p/dIn5tfUFl/E3yrFTaayvvpsafAd/pUBS9mrG+P+Qr/4QPNo1mg3R/sjzalQLB1OXp7
         jXcQ==
X-Gm-Message-State: AOAM5324TGMrcbvkUU8ijWj4M9huDn8F3+dWTRZMEkXRxCb0VCg4SK6A
        7IhgSl5U5B9QUriPx++d0nhqeSltswJu5/2h+gpk0SLfY1GJllDDISgypn9v25X6dMchabybud2
        zFqJN+5nlVGRdAjidu+sOwEeNCQZVElap+ez75Fxl2Q==
X-Received: by 2002:a50:9b06:: with SMTP id o6mr32405091edi.284.1628078482082;
        Wed, 04 Aug 2021 05:01:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzu9mcDgpRKO7iN+OSXq3CE2q+TuTk8y4Xr56jJ++XDrgspBXyzOuCzES6ol2tmnRVRRmEudQ==
X-Received: by 2002:a50:9b06:: with SMTP id o6mr32405064edi.284.1628078481900;
        Wed, 04 Aug 2021 05:01:21 -0700 (PDT)
Received: from [192.168.8.102] ([86.32.43.172])
        by smtp.gmail.com with ESMTPSA id i11sm607007ejx.82.2021.08.04.05.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Aug 2021 05:01:21 -0700 (PDT)
Subject: Re: [PATCH 4/4] rtc: s5m: set range
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org
References: <20210804104133.5158-1-alexandre.belloni@bootlin.com>
 <20210804104133.5158-4-alexandre.belloni@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <4fe80580-50a8-2b51-548c-480e60164490@canonical.com>
Date:   Wed, 4 Aug 2021 14:01:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210804104133.5158-4-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2021 12:41, Alexandre Belloni wrote:
> The S5M8763X type seems to handles dates from year 0000 to 9999, there is
> no info on leap year handling after 2099. The other models handles dates
> from 2000 to 2099.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-s5m.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 

Seems correct:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
