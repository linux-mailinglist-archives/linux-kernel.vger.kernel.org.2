Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082B14170BA
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 13:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245243AbhIXLSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 07:18:20 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:32974
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245092AbhIXLST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 07:18:19 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C31AE402D9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 11:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632482205;
        bh=aiCG4TKCxB5pDlfBPhlfyfaq05mK5AFrA1zDk3YN3Zk=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=Z4UIyPdvy8C71nOFxy/9l2EumujKA1qpP6ICrGl/BXUQzp+oSl9eNfk9CHxHMrMh/
         ch7gwPHJ1W1qbwSQ4NdTRiTx1qWKshrq80WMeckWpimU3loYSpvDCmQWnf79xnnymH
         5OdgAFc45Izcn31222YhluaWGWUBDCHT5y4g+wIAK/0irRC18hxOWSVHZEa8LvI2tG
         5cdRk9wk+smixrLahQWx9rdH0npXQJYQJ074Z/zF708YGQWmzCRtMsAEnZiGx89+c/
         UDmjBvSN/dOnQh8qqhxTYk+YiMVxa1ZUzOIFhIpxr4Pbk07bQuJjagMlr05A9vordV
         tmVEvAvjmxOXA==
Received: by mail-wr1-f72.google.com with SMTP id j16-20020adfa550000000b0016012acc443so7760634wrb.14
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 04:16:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aiCG4TKCxB5pDlfBPhlfyfaq05mK5AFrA1zDk3YN3Zk=;
        b=vYvHLfpYKh/4GMxEbUm0G5WKo6JMnIbcMoJ2pzdZxDBbKXLS0Qp5ANN6sbqKpf5brH
         JK292bmXs4RSuYzHajINcmAZBLypZyXM3EU7sLIi7xeDnrR4W0j8YXHB7tL41mWB3Hcp
         uW244/Wy0oNe1RwPY+gHO4UokFUuCSu5noWBBVFsTfvPfr7W9m2jBSEO2Dm6aMcD9WtX
         tSZTIWMJXl0ndfrn/0mjRLjScXXris8tdSU7hF4+DSDHBoyjxfxcWu88YpaT+MLo/dEp
         DoFZAM/KIP0Q61gbtypy1fTSm9vLCzXkvkSICLI89qVR/X8myCFai1coSBC8Pejz/OQ+
         maAg==
X-Gm-Message-State: AOAM530ISGMeSHjDGXDQL46OCz7krZbF+dZ3c14f68r8OScyiUO4mgku
        SsVxwMJNzrs75ZmFGJB/LEa+S4f4jwtkrrr5H7TwuuUzBOFNQF6cFehpqSIMocKj6VzlY3dINJ7
        H8DIBoB+9h61D9MSCAXr0rw6aroDfh29Mfnwm9Vph9w==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr1445588wma.83.1632482205429;
        Fri, 24 Sep 2021 04:16:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+ZIBTe1TLhsLs5L6B4mgKWTfR95aGpSX0d+JQJIY6OfeZcyVoHaFWVremJOS2a55z2/0e4Q==
X-Received: by 2002:a7b:cc96:: with SMTP id p22mr1445571wma.83.1632482205225;
        Fri, 24 Sep 2021 04:16:45 -0700 (PDT)
Received: from [192.168.0.134] (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id o7sm9958016wro.45.2021.09.24.04.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 04:16:44 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: rpc: renesas-rpc-if: Add support for the
 R8A779A0 RPC-IF
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        devicetree@vger.kernel.org
References: <20210922085831.5375-1-wsa+renesas@sang-engineering.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <75713e8e-f675-240e-b503-99618d07afda@canonical.com>
Date:   Fri, 24 Sep 2021 13:16:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210922085831.5375-1-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/09/2021 10:58, Wolfram Sang wrote:

Please write a short sentence after commit title.

> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../devicetree/bindings/memory-controllers/renesas,rpc-if.yaml   | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> index 990489fdd2ac..b15992ad3613 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
> @@ -33,6 +33,7 @@ properties:
>            - renesas,r8a77970-rpc-if       # R-Car V3M
>            - renesas,r8a77980-rpc-if       # R-Car V3H
>            - renesas,r8a77995-rpc-if       # R-Car D3
> +          - renesas,r8a779a0-rpc-if       # R-Car V3U
>        - const: renesas,rcar-gen3-rpc-if   # a generic R-Car gen3 or RZ/G2 device

Where is the driver or DTS using these compatibles? The bindings can
come even without users, but are you sure this is what you want?
Changing them later, if ever needed, will be more difficult.


Best regards,
Krzysztof
