Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36639312F34
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 11:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbhBHKj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 05:39:59 -0500
Received: from mail-ej1-f41.google.com ([209.85.218.41]:44967 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbhBHK2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 05:28:45 -0500
Received: by mail-ej1-f41.google.com with SMTP id w1so23683114ejf.11;
        Mon, 08 Feb 2021 02:28:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/sXUHbfTSNaWe0Vrtyl40wVJaY9DiX1LwKI8X9Eee5A=;
        b=IfQeUUVL+02pYuTuXc8mRMMx03+XuEgNZHFj/v8k5xbzQUX/+vUhdy32r7rXV2j5ei
         +XNcnR3/nQo7LzLb/9b3fvBS9j4ebKRMDRWTTOg3cHtxaJeLe1QRfjxlgGcb12aTRDNy
         2vzkX7KuanODLABhhaxc1bj/2/Qqm1KjqNKL3Hw3tEiylb0GM6s9FkU/tP/s2YvUp7CF
         EBpiG7sVG0XcDqqmy0ZvIu0a3ph2AzJX6b7pFaqs1mi4N/1av+kP1CC16uGk7WiCDSGh
         /AGeWX5q7sIVZaAdsovE9RheEBGa65ktNjovF7atI5D33TXH74Q4ZaJX+DfsdOZ+Ut2+
         BbJA==
X-Gm-Message-State: AOAM533yA7Yt2xNDpob9wkT8nqvkQPH7hUngMHZI81EsNTSXriSQXLZl
        AOnW9cCDBuD2f3dMKI+1vDI=
X-Google-Smtp-Source: ABdhPJy0w+9yYbPmP5ReyAJ8xWSe+CjI2MLaTbf6iSDnOvs1rvvIS/VC0J1GAivNVnbfEQN34Rlpyw==
X-Received: by 2002:a17:906:6bc5:: with SMTP id t5mr11941692ejs.253.1612780053394;
        Mon, 08 Feb 2021 02:27:33 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id b3sm9289294edw.14.2021.02.08.02.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 02:27:32 -0800 (PST)
Date:   Mon, 8 Feb 2021 11:27:30 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Hector Martin <marcan@marcan.st>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>, robh+dt@kernel.org,
        Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 01/18] dt-bindings: vendor-prefixes: add AAPL prefix
Message-ID: <20210208102730.p4nhsl35oowsklv2@kozik-lap>
References: <20210204203951.52105-1-marcan@marcan.st>
 <20210204203951.52105-2-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210204203951.52105-2-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 05:39:34AM +0900, Hector Martin wrote:
> Amusingly, this wasn't yet documented, even though this vendor prefix
> has been used since time immemorial on PPC.
> 
> Signed-off-by: Hector Martin <marcan@marcan.st>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 041ae90b0d8f..d7950c723472 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -25,6 +25,8 @@ patternProperties:
>    # Keep list in alphabetical order.
>    "^70mai,.*":
>      description: 70mai Co., Ltd.
> +  "^AAPL,.*":

All prefixes are lower case... see ABB below (not mentioning that the
company name is not APPLE), so just "apple".

> +    description: Apple Inc.
>    "^abb,.*":
>      description: ABB

Best regards,
Krzysztof
