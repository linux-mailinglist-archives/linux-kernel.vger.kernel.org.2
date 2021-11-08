Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFC1449DAA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 22:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbhKHVMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 16:12:24 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:42550
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238171AbhKHVMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 16:12:22 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 52C973F1B2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 21:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636405777;
        bh=Va/pwg0yU2yK/e7gM+AfCFIYpglqXBbYNHqGSFsajyo=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=YZvAA0wYyA7LJlfe5euuTj+SgWcDR+24x/KAtkVWngYxnbRJBVsHeQNhHZoaH66Gu
         2GfbHCy4Oz/wQBAso/w//0nRj9U79rwTMrJEd3dg0hMNnJU7HCorDO1lJBCFqzZKvJ
         FnWibgy3kW3RLnkW0nsJ8BtAG3IXX5jUUXmYBcPdmy/Z+t/EJjtWqjEV/GCOhEhFDb
         kELjwQjsjTvXLVF0pzG9PgP0Ho42EaYqzBN3yUg6/12XWBc5f6IzIg3HlKNCrqjTJl
         iJF/Bovy948WVp4k7hjjxAN+txCaGjJDusm7V8DwAvn7pYzwyWTiReM3snSUbG6+O2
         VUDgsp5RnXIfw==
Received: by mail-wr1-f69.google.com with SMTP id h7-20020adfaa87000000b001885269a937so3275829wrc.17
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 13:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Va/pwg0yU2yK/e7gM+AfCFIYpglqXBbYNHqGSFsajyo=;
        b=3oRtDe1rJuBauZsEFN8ZSQ6nlx7N1aqUCHMETt1HLPpYJkFzzUJddn4zaf/F2mti6R
         0+CPxjr8ZWcWBLwU9n1syoMc5dZJzpDi0cGSEbKoivndeGMbyw+WOcuPLfKCbKs0sy3z
         dGW1fLwOlHOkpDz380IZhPMmYRFgEaG9Zcj6S0VQ4TbgrJPXnC91DV+GXJ8ZZRM6+I5l
         gWM6h8T2qYgK4qVhkijqioCvzP/wTTEHDaqF21xstHtOaD8TYwqiHbPNDhuqiHGMWlGC
         tIcASoLN66xC4xxZmKi6sHi+JLX3ITQbSpuF/3tw6F0gjK5IPRCprq9BT5JT2mPlX0iL
         Pmjg==
X-Gm-Message-State: AOAM530iMeIA3AfoMr9aaIXSH1rmx3fgTnuo3xOtgP3RFIL729rTXU2K
        c4gNCyy0y9olIFv7EsZiYVaYOgEt9+kt1petzdXs+uDcOanWEyDpRQY5Q1GPaLdoc+LzL6dF2Pb
        H7RPd18phsH3tQLDeWTk8Sev13CyQZqwfkXJfiXdDlg==
X-Received: by 2002:a05:651c:11cf:: with SMTP id z15mr2048859ljo.30.1636405766136;
        Mon, 08 Nov 2021 13:09:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5zuS8P1mHA/OLv+7/rIK0KelVh9uEKzH2K354xcsLSXE2l72piSekseZIEjgtyZT8qG201w==
X-Received: by 2002:a05:651c:11cf:: with SMTP id z15mr2048814ljo.30.1636405765859;
        Mon, 08 Nov 2021 13:09:25 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id p21sm1933204lfg.18.2021.11.08.13.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 13:09:25 -0800 (PST)
Message-ID: <8a316610-c0f6-dadd-4745-bd3aff76372c@canonical.com>
Date:   Mon, 8 Nov 2021 22:09:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 03/13] dt-bindings: soc/microchip: update sys ctrlr compat
 string
Content-Language: en-US
To:     conor.dooley@microchip.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com, robh+dt@kernel.org,
        jassisinghbrar@gmail.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, broonie@kernel.org,
        gregkh@linuxfoundation.org, lewis.hanly@microchip.com,
        daire.mcnamara@microchip.com, atish.patra@wdc.com,
        ivan.griffin@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     geert@linux-m68k.org, bin.meng@windriver.com
References: <20211108150554.4457-1-conor.dooley@microchip.com>
 <20211108150554.4457-4-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211108150554.4457-4-conor.dooley@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2021 16:05, conor.dooley@microchip.com wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Update 'compatible' strings for system controller drivers to the
> approved Microchip name.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/mailbox/microchip,polarfire-soc-mailbox.yaml     | 4 +++-
>  .../soc/microchip/microchip,polarfire-soc-sys-controller.yaml | 4 +++-
>  drivers/mailbox/mailbox-mpfs.c                                | 1 +
>  3 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/microchip,polarfire-soc-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/microchip,polarfire-soc-mailbox.yaml
> index bbb173ea483c..b08c8a158eea 100644
> --- a/Documentation/devicetree/bindings/mailbox/microchip,polarfire-soc-mailbox.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/microchip,polarfire-soc-mailbox.yaml
> @@ -11,7 +11,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: microchip,polarfire-soc-mailbox
> +    enum:
> +      - microchip,polarfire-soc-mailbox
> +      - microchip,mpfs-mailbox
>  
>    reg:
>      items:
> diff --git a/Documentation/devicetree/bindings/soc/microchip/microchip,polarfire-soc-sys-controller.yaml b/Documentation/devicetree/bindings/soc/microchip/microchip,polarfire-soc-sys-controller.yaml
> index 2cd3bc6bd8d6..d6c953cd154b 100644
> --- a/Documentation/devicetree/bindings/soc/microchip/microchip,polarfire-soc-sys-controller.yaml
> +++ b/Documentation/devicetree/bindings/soc/microchip/microchip,polarfire-soc-sys-controller.yaml
> @@ -19,7 +19,9 @@ properties:
>      maxItems: 1
>  
>    compatible:
> -    const: microchip,polarfire-soc-sys-controller
> +    enum:
> +      - microchip,polarfire-soc-sys-controller
> +      - microchip,mpfs-sys-controller
>  
>  required:
>    - compatible
> diff --git a/drivers/mailbox/mailbox-mpfs.c b/drivers/mailbox/mailbox-mpfs.c
> index 0d6e2231a2c7..9d5e558a6ee6 100644
> --- a/drivers/mailbox/mailbox-mpfs.c
> +++ b/drivers/mailbox/mailbox-mpfs.c
> @@ -233,6 +233,7 @@ static int mpfs_mbox_probe(struct platform_device *pdev)
>  
>  static const struct of_device_id mpfs_mbox_of_match[] = {
>  	{.compatible = "microchip,polarfire-soc-mailbox", },
> +	{.compatible = "microchip,mpfs-mailbox", },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, mpfs_mbox_of_match);

Please split the bindings from the code.


Best regards,
Krzysztof
