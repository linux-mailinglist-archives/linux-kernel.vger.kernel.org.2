Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C54535F472
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 15:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351090AbhDNNCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 09:02:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36399 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345934AbhDNNCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 09:02:00 -0400
Received: from mail-ed1-f72.google.com ([209.85.208.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lWf9F-0001Fc-Gc
        for linux-kernel@vger.kernel.org; Wed, 14 Apr 2021 13:01:37 +0000
Received: by mail-ed1-f72.google.com with SMTP id v5-20020a0564023485b029037ff13253bcso3296116edc.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 06:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q4rX3IUnG7PDVdoG/GXhqgIqrINra94M/50DgG0u7YQ=;
        b=oiVPp6GuGw1KAIQ3l0Kwsdy05Ku1+kqQjBIUWL6TAVRWllTsA5mChlQ8YTboILivmh
         BMl+NA0Ggokod1zWkXsb/1iTnvz91UdU1KTniuz/Dkj/P5uwahSVsOFprPvmxeAh9pqp
         g+TBdkvQsYBC5QX2U8IHSGgkgZ2TQ1+23TytbYC7KOG3yIlXTs3nuLnh4TMd0ZAf7UuS
         mxJu0waQV0i3hopqz428M1dXZE9ZURZ25NQLtHVeC2Ib6G/4Xi9T5/ErjnC8OGvTKmHw
         BoO1gBCWTvzxo85zntV4snpx44pud5DM1a8y8CKjqdtw08eCLMzyr8U/usbYr5zVH/zq
         Silw==
X-Gm-Message-State: AOAM530nIRvdJrk/v0/wECq+/phNISljlgplsEb/SpzWI7JzDMvivF5R
        bvYcnr/+ZozHgzCaHKp5a2oqvnwTD0UQMOonNMz6tPf9Dm9OfVElk6pbXL3n8uDK7XqJ0yVSugk
        XEy7G2yT+9iuHOKBZ98Cg0V6TlDpPXyURduDzcZdG8g==
X-Received: by 2002:a50:fe01:: with SMTP id f1mr5610389edt.272.1618405297135;
        Wed, 14 Apr 2021 06:01:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxc0DBAbMPqZcpnFL7rzAUquSu6gHeyD4yLbpaF9ZYIdFiPctrgkIFDO++3hadTl04rEq6ylg==
X-Received: by 2002:a50:fe01:: with SMTP id f1mr5610367edt.272.1618405297033;
        Wed, 14 Apr 2021 06:01:37 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-192-147.adslplus.ch. [188.155.192.147])
        by smtp.gmail.com with ESMTPSA id gs20sm1106742ejc.83.2021.04.14.06.01.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Apr 2021 06:01:36 -0700 (PDT)
Subject: Re: [PATCH v2 4/4] dt-bindings: add dasheng vendor prefix
To:     dillon.minfei@gmail.com, robh+dt@kernel.org, shawnguo@kernel.org,
        krzk@kernel.org, linux@rempel-privat.de, s.riedmueller@phytec.de,
        matthias.schiffer@ew.tq-group.com, leoyang.li@nxp.com,
        arnd@arndb.de, olof@lixom.net, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        prabhakar.csengg@gmail.com, mchehab@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-media@vger.kernel.org
References: <1618383117-17179-1-git-send-email-dillon.minfei@gmail.com>
 <1618383117-17179-5-git-send-email-dillon.minfei@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <9f8f3d55-b3f3-54d6-9143-5d676a21c901@canonical.com>
Date:   Wed, 14 Apr 2021 15:01:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <1618383117-17179-5-git-send-email-dillon.minfei@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2021 08:51, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> Add vendor prefix for DaSheng, Inc.
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
> v2: new add
> 
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)

This should be the first patch in the series.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
