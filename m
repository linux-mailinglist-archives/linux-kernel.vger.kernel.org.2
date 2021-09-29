Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EC541CD06
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344464AbhI2T7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:59:09 -0400
Received: from ixit.cz ([94.230.151.217]:55350 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245758AbhI2T7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:59:08 -0400
Received: from [192.168.43.127] (78-80-97-115.customers.tmcz.cz [78.80.97.115])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 8F60323B26;
        Wed, 29 Sep 2021 21:57:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1632945445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qT1CJ3TMSHMj9mB3UfHXYaTVu0KzbPO6fnVovONq4TQ=;
        b=K8O42v2KRm/48IvJj55+VyeHCpMQbZNTdE7nhWf2Tivun4HvsqmPUC9xwtVkyq6edIPwDy
        lolz1SelsuZhi/lncBO7h7MRF6AlpDNXeOJXFFnbr5T3aRslk1dXj5Y6xaZmhQiT/0bHPo
        RB4VMSqeio/7IpRumE0aARQ9MgrpeS0=
Date:   Wed, 29 Sep 2021 21:56:01 +0200
From:   David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH] dt-bindings: add vendor prefix for asix
To:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <DPO70R.IGRAS5UQLITQ@ixit.cz>
In-Reply-To: <20210929192619.111098-1-david@ixit.cz>
References: <20210929192619.111098-1-david@ixit.cz>
X-Mailer: geary/40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sorry, typo got in. Please ignore.


On Wed, Sep 29 2021 at 21:26:19 +0200, David Heidelberg <david@ixit.cz> 
wrote:
> Add vendor prefix for ASIX Electronics Corp.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml 
> b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 18f3f3b286b7..a69fb7dc07d1 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -131,6 +131,8 @@ patternProperties:
>      description: Asahi Kasei Corp.
>    "^asc,.*":
>      description: All Sensors Corporation
> +  "^asix,.*":
> +    desription: ASIX Electronics Corp.
>    "^aspeed,.*":
>      description: ASPEED Technology Inc.
>    "^asus,.*":
> --
> 2.33.0
> 


