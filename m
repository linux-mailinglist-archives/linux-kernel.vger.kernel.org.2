Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD949427C5C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 19:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbhJIRW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 13:22:58 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:34720
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232057AbhJIRWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 13:22:54 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B66F73FFFC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Oct 2021 17:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633800056;
        bh=kL5onibrdbpTWmZcYTtwUGQkos1VrIQlfQOfi9rMBeo=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=tWwRsWSWTGQVVHm1S/UHgAMw8wNyY+pKURh7w3nBIxJ/+qROYaNFzZ/+u4Hz/rTn6
         ezNEAE3jykIHtEs7v7VohX01/WsrNfnseFv1Cx2tIWcp+0FpyqFYG0G51+fPOdJFrR
         ezMrCQmDXLZ7bt6UeBgHlwq/yVjJQjwUJD7iYVBdwa3pFlFE2Oc8USG8Lk0Hh0mzRc
         hYvdcOxl0MsHGAk66+BeAM1/RH0KRvauOkQkU4H1zoAHO9b7Kl11lUHmxF9rYkPf+a
         57ABPHy5YZvlr9eiW0rzwbTsZXNHkDE2ftugnO+hJzPRaofVXWG/CHGl2p6UCW63vG
         kU4j9ccqiuj6A==
Received: by mail-ed1-f71.google.com with SMTP id u23-20020a50a417000000b003db23c7e5e2so11962775edb.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Oct 2021 10:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kL5onibrdbpTWmZcYTtwUGQkos1VrIQlfQOfi9rMBeo=;
        b=tW8PnYjxV0m//jh/84UbwgIBgauaFnwBPz3h3FwC/TBQpQJfGC0E6W8JRJpWBtLIsF
         rfYw5E3tLh6Si5Oeer8m8CbQKxdKBlbuCJJmS64b620d6V4am/dXYEgqKJGRQMM02T3E
         kZswpIFTD0axueyl9fVbKW2EImoc52sEl255ucl/KJA+TCnlcoAVVgcyjedJRaI5MyPI
         bIdwW6YalQll68sFFHYGExfSHXZhnw0ghbOia1jNrIRLJnOosfJOj2qLVg0HntZ09hZi
         A2WdEFtLDben92aB10OTCBgiepio3+PDFpj7n0CXioPC+RJPz5w1ZVJyxqnZ27WV0Cek
         c5Vw==
X-Gm-Message-State: AOAM530PZXt1DoDenxBpBT0j2l9Mz1MdvjwagFLkJSLpm3B+TYSun90q
        NQS4csyIbPHnt5ytnS+WGHAwjv/88DSS7Ddeabpqz5ZXxGuP2QhQ1Xd68ya+Gs4TN1vgxyRuXsL
        vHf5PqMFEEeIwlPD5m07/zgabxxLxjNjUmynPjfGyOQ==
X-Received: by 2002:a05:6402:270b:: with SMTP id y11mr18888066edd.387.1633800056459;
        Sat, 09 Oct 2021 10:20:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzpQpfv74csrtSy6KUNxlPMuDmjg00caC1cHGJ+WK/WStFDQ1Er51zX/DIqVocH4mB+/nMy6w==
X-Received: by 2002:a05:6402:270b:: with SMTP id y11mr18888050edd.387.1633800056330;
        Sat, 09 Oct 2021 10:20:56 -0700 (PDT)
Received: from [192.168.0.20] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u23sm1238626edq.36.2021.10.09.10.20.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Oct 2021 10:20:55 -0700 (PDT)
Subject: Re: [PATCH v3] dt-bindings: net: nfc: nxp,pn544: Convert txt bindings
 to yaml
To:     David Heidelberg <david@ixit.cz>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~okias/devicetree@lists.sr.ht
References: <20211009161941.41634-1-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <192edb2d-837d-12ac-bb95-e38c8fd20381@canonical.com>
Date:   Sat, 9 Oct 2021 19:20:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211009161941.41634-1-david@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2021 18:19, David Heidelberg wrote:
> Convert bindings for NXP PN544 NFC driver to YAML syntax.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2
>  - Krzysztof is a maintainer
>  - pintctrl dropped
>  - 4 space indent for example
>  - nfc node name
> v3
>  - remove whole pinctrl
>  .../bindings/net/nfc/nxp,pn544.yaml           | 61 +++++++++++++++++++
>  .../devicetree/bindings/net/nfc/pn544.txt     | 33 ----------
>  2 files changed, 61 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/nfc/nxp,pn544.yaml
>  delete mode 100644 Documentation/devicetree/bindings/net/nfc/pn544.txt
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
