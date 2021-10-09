Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A361F427B02
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 16:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234353AbhJIO4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 10:56:04 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:48358
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233799AbhJIO4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 10:56:03 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B6EBD3FFF5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 14:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633791245;
        bh=Z/66e4vIUc4jlwu8qwngzIGNtrlMePU5AHgS8MHQkVI=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=bYvVMOsBPoDMy1MNYQGbk85dhzN1Ty6b9t0nDucSFyVDqpclKv3HNiAyArwBP6RFB
         QU65+pZdJBcHqYcq5ZQSHSpZhqwofd3ilPqigmcO8LuwxHVp5mlRVLH6+gtxcjJ5+Z
         PmHhkOkbO6vwf1RskNwuktfx8y1MJwNUGbwREVl7gm39esLUu+9ueKDHQmVAFDW3ar
         4Ol1q1oIKxPK674Ttfkoqx65S0FTJ7RE6CgPX2MTjhwy7MfgKzkX7vL9HOsoS8drI1
         eTDjv2/f/dIXuBV7k2Wj3dGgEgBm0RDchLwkjec+1vhJLJRP0+HQd/zLPN5sObYu3Q
         dyHcy8s39iGAQ==
Received: by mail-ed1-f69.google.com with SMTP id c8-20020a50d648000000b003daa53c7518so11721322edj.21
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 07:54:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z/66e4vIUc4jlwu8qwngzIGNtrlMePU5AHgS8MHQkVI=;
        b=AFw596m5wBKwOY4cgmVPAeyXtvlSkWrgSexwxrs6g0tjfodiHoxn3WQLNLbB9Q0NQm
         1ja6rgLnZE8mHKohdW020uqPTNWmmdr2H8nK2CondR2nI/9DVVHcLJmAalvi4ZmeB2EV
         yp2IZHtcWWALNHM1nVJYeIvgnBxF8HpoLDBdcH0VTt0iTsKI8bTx2o8FwPRWNjR55R4+
         +qYSol9ZooG717m03uskhAqWVCvpgY8piPaG3kT7XCvDznU+lrb/+0OZTLJ3jG9mxYgY
         pVGH4krTOWX0Yu1Jv6n6izK1H3HbagMwrsaWEUyaMjMwbwWxxTklzYzQKKo+TmejXnQG
         WfYg==
X-Gm-Message-State: AOAM533eaWVcOpVOL0vfv7KjDkOjDAEE68KtxzosOGQ8TNsn38Rz9NuL
        cDCI0/Okvv7iPYnKPLx9UkC2A7wT8/LCPWrFn1USjzAd92a42ttW/GCIgMzbnYFKJHPWxXZS7cR
        aI4aFnWQyxpBaF+g+VxVlvZxtLvOgoUf8W5I40SuY6g==
X-Received: by 2002:a17:906:2b91:: with SMTP id m17mr11970338ejg.202.1633791244982;
        Sat, 09 Oct 2021 07:54:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrqgQvL7LCCEPsBYg170QsPlUWmRldSNgpFRe8Ei1FFODLUOx87al9hRkomspH82VL67MniQ==
X-Received: by 2002:a17:906:2b91:: with SMTP id m17mr11970311ejg.202.1633791244796;
        Sat, 09 Oct 2021 07:54:04 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id v13sm1071656ejo.36.2021.10.09.07.54.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 07:54:04 -0700 (PDT)
Subject: Re: [PATCH v5 6/8] dt-bindings: memory-controllers: ti,gpmc: Convert
 to yaml
To:     Roger Quadros <rogerq@kernel.org>, tony@atomide.com
Cc:     robh+dt@kernel.org, grygorii.strashko@ti.com, nm@ti.com,
        lokeshvutla@ti.com, nsekhar@ti.com, miquel.raynal@bootlin.com,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211007120830.17221-1-rogerq@kernel.org>
 <20211007120830.17221-7-rogerq@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <05368ff4-a2fa-a7d2-b87b-d8363b085148@canonical.com>
Date:   Sat, 9 Oct 2021 16:54:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211007120830.17221-7-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2021 14:08, Roger Quadros wrote:
> Convert omap-gpmc.txt to ti,gpmc.yaml.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/memory-controllers/omap-gpmc.txt | 157 ----------------
>  .../bindings/memory-controllers/ti,gpmc.yaml  | 172 ++++++++++++++++++
>  2 files changed, 172 insertions(+), 157 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/omap-gpmc.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Best regards,
Krzysztof
