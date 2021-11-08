Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCBB449DB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 22:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbhKHVNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 16:13:35 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:56590
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239862AbhKHVNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 16:13:33 -0500
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C02F13F1EC
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 21:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1636405847;
        bh=mwPFRn0AEGOneXePTnmoZQRi4asMCrfCLz0IrMjqCXA=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=DKhDC7F7lG4RVE4qNWgrKjnY/dvBbqJUWACN2l7Q8M60U9wCQA4QJgEehUtC3MdW9
         5pJ331lKyUtm0tVPWbqoRa+i99e3WD1XDloL+fHW1YKkBvLJViJER83V78uFjpkUiO
         DTS1RNB+ZuUAHy6E5eLTHASCx4KO44FhSWOZ/LsiC1990j56vjx/jsrJVSzJnbE8B7
         AufpFT2m+HstTIxCjZMN4iJpIqHlKNF2a7kIP5U+/AXsLHw6IixuXeQ8cZnB1pAIzP
         YnxII2IOnGo4XBhPznbQ92VWJKzYLwZvrjBORGNML6t+1hgXHrq723l+/ARDjBNxye
         86hLzC1TC372Q==
Received: by mail-wr1-f69.google.com with SMTP id v17-20020adfedd1000000b0017c5e737b02so4402150wro.18
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 13:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mwPFRn0AEGOneXePTnmoZQRi4asMCrfCLz0IrMjqCXA=;
        b=jEImfan9j6khl4ja/QRO9+f3wmXyvJQ7Lh0dKGmhhf21mqrTd2QrwN2bIL+gNHuvig
         1pXbwJ9W5DqmwHySVLlZOKQNqRC1xYohsL9FQkTMhwOPcNmpCAQpIWRfg/mXapKzDPjJ
         tskuTbEUojuDtOX7i/jKbEptROwIs9gESdBaxLKf3Mmysqkt2uB2OdI2/13k0CzPdmsN
         SVk0ETK34LKXi0TTqDxzASjWainH4+VYYe7/pnvC9qJlbSU9dc+EBmhSdljm47XSGZZI
         iXT2mRwgQLmfsucFMw3jyv/EizjeIcQhZNz/o1QymDCWplIDi8OAO9LbQlTmGC9X4hRx
         melA==
X-Gm-Message-State: AOAM530J08XzbiaB9rnWzkmDd4OT3pAuWFLwJmWbV+zF90dbbNmpmHcc
        rDbFvxUBdv4Td/6o+SEq4e9P2IllEig+/uvxXpa0D83JdOYzOapxLYCQV+6rscDpSeG3O+3fCCR
        5wF/wAaR0vg951/cw3tJKl/SLvSAqeqLOwYncvHdHLA==
X-Received: by 2002:a05:651c:246:: with SMTP id x6mr2094963ljn.49.1636405836536;
        Mon, 08 Nov 2021 13:10:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZb4LKcW1A1+MA8CuLWPJQDB5phDB0potg5NQYQwGvOUd0o3C/EZkqT0mWfTObhT2/wWNBag==
X-Received: by 2002:a05:651c:246:: with SMTP id x6mr2094920ljn.49.1636405836357;
        Mon, 08 Nov 2021 13:10:36 -0800 (PST)
Received: from [192.168.3.67] (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id a16sm1929374lfu.274.2021.11.08.13.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 13:10:36 -0800 (PST)
Message-ID: <8343f11a-89e8-c043-6296-000f7ba3e3d2@canonical.com>
Date:   Mon, 8 Nov 2021 22:10:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH 04/13] dt-bindings: riscv: update microchip polarfire
 binds
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
 <20211108150554.4457-5-conor.dooley@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20211108150554.4457-5-conor.dooley@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11/2021 16:05, conor.dooley@microchip.com wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> Add mpfs-soc to clear undocumented binding warning

What warnings? There is no such compatible used.

> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  Documentation/devicetree/bindings/riscv/microchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/riscv/microchip.yaml b/Documentation/devicetree/bindings/riscv/microchip.yaml
> index 3f981e897126..1ff7a5224bbc 100644
> --- a/Documentation/devicetree/bindings/riscv/microchip.yaml
> +++ b/Documentation/devicetree/bindings/riscv/microchip.yaml
> @@ -21,6 +21,7 @@ properties:
>        - enum:
>            - microchip,mpfs-icicle-kit
>        - const: microchip,mpfs
> +      - const: microchip,mpfs-soc
>  
>  additionalProperties: true
>  
> 


Best regards,
Krzysztof
