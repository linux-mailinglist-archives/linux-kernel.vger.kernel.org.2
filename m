Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711763B7041
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 11:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbhF2JrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 05:47:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33160 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbhF2JrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 05:47:20 -0400
Received: from mail-ed1-f69.google.com ([209.85.208.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lyAIW-0005fv-7t
        for linux-kernel@vger.kernel.org; Tue, 29 Jun 2021 09:44:52 +0000
Received: by mail-ed1-f69.google.com with SMTP id y18-20020a0564022712b029038ffac1995eso11322977edd.12
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jun 2021 02:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=P6S93IgLQX/j9P4a+cNZB4S+kLehvqpx4P2yVdaV6XE=;
        b=D4tuxU6U9HaNOxIdoGKNMJ2EDq8xuYzEmjJukDaxfXGx8gQiyfkf3esyYM2VJL1O1Q
         Ze6pCE7xMSrVCbg8kqtg7N0cV4dm70zfbEJcidBuYujTETSXR5dlKX1bAC1i5gXCYSKQ
         LT2Vnwnrun7cuMBKRglBD7DCc9OGtFSZqe9ja3b5CVeS0gIbADfmJxPgYvYOVoT+zsDU
         EzPk+tcVljA08si/E/SAjtIDYfic2cH9pvjtHw0sPn+e6VbFbbCRD41dAzQkxMFNmNMI
         eTDeY2gWwDAcHcCM0+kU84Rx7V6tERWQJRf8bvRzyOcrR6XB5RecPNDFKOtErHj9+AZQ
         vE9w==
X-Gm-Message-State: AOAM53175IuyhiIv98EQ7PyfGjx+vtDboncYdNUsCa0TkPwgVSIQxNsJ
        03cOgJMsBEcwlTjyQ2zIM9hXFmeFYxySjB29lMjBhY4SsD1q3J0vv66wzZZdXrykTgol+GoJHqW
        F1eYmoPZtAeX4mZUAxUuuMY5zjb0cWUcBFD/O/cNe6Q==
X-Received: by 2002:a05:6402:2813:: with SMTP id h19mr38800580ede.39.1624959892026;
        Tue, 29 Jun 2021 02:44:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy06olXLZfAm05U4GcZNHdgwCRhnlpCZ8sU2e7+C3VS7EOVINUFGdMcuDwYXMbgFp8XUZyLKw==
X-Received: by 2002:a05:6402:2813:: with SMTP id h19mr38800560ede.39.1624959891916;
        Tue, 29 Jun 2021 02:44:51 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-177-222.adslplus.ch. [188.155.177.222])
        by smtp.gmail.com with ESMTPSA id z28sm7763057ejl.69.2021.06.29.02.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 02:44:51 -0700 (PDT)
Subject: Re: [PATCH v5] serial: samsung: use dma_ops of DMA if attached
To:     Tamseel Shams <m.shams@samsung.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        ajaykumar.rs@samsung.com, robin.murphy@arm.com
References: <CGME20210629045610epcas5p4fa9d2a217b351a950899073d6b7d3dfd@epcas5p4.samsung.com>
 <20210629045902.48912-1-m.shams@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <8569ce54-26ef-e36a-b3a9-2d31e2575bd2@canonical.com>
Date:   Tue, 29 Jun 2021 11:44:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629045902.48912-1-m.shams@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/06/2021 06:59, Tamseel Shams wrote:
> When DMA is used for TX and RX by serial driver, it should
> pass the DMA device pointer to DMA API instead of UART device
> pointer. DMA device should be used for DMA API because only
> the DMA device is aware of how the device connects to the memory.
> There might be an extra level of address translation due to a
> SMMU attached to the DMA device. When serial device is used for
> DMA API, the DMA API will have no clue of the SMMU attached to
> the DMA device.
> 
> This patch is necessary to fix the SMMU page faults
> which is observed when a DMA(with SMMU enabled) is attached
> to UART for transfer.
> 
> Signed-off-by: Tamseel Shams <m.shams@samsung.com>
> Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> ---
> Changes since v1:
> 1. Rebased the patch on "tty-next" branch of TTY driver tree
> 
> Changes since v2:
> 1. Updated the commit message.
> 2. Changed the comment description
> 
> Changes since v3:
> 1. Removed the null pointer check for "dma", "dma->tx_chan" and
> "dma->rx_chan" and instead sending DMA device pointer while calling
> DMA API.
> 
> Changes since v4:
> 1. Fixed the alignments of arguments.
> 
>  drivers/tty/serial/samsung_tty.c | 46 +++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 21 deletions(-)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
