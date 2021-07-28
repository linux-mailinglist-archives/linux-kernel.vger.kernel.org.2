Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444383D90C3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbhG1OgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235420AbhG1OgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:36:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E7CC061757;
        Wed, 28 Jul 2021 07:36:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id o5so5019355ejy.2;
        Wed, 28 Jul 2021 07:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=U9j1VUNwpLjqthf/lcX140LSEyF9Vm2SDMFtz8UeK9Y=;
        b=ixMvR3uPmTOI3ig8cTK9p5JW7g3ktbkYGZ0HehamKHLaBqiINRUHlhYy73M4g7A9is
         1Cu0CmpA+wzXN5soyIOXxj2Vqu0JsVnRWp/DqnsIm0Mkws9Oa+kkYHsVV3cB4y6+mWET
         Zn2kwkjHIr5uzbXqp4iu/vxI4Edy7M2A9//1eWsHxvp6YWTzoAjRVXXqBG9r0xhaeg+i
         4ejMOhlBzsH4+4uID0mJlXifXaUUTad7xnfvueNsXlUwW59YTEw6H+9PvGFOJWtbNXl9
         DKiXSHzjAYdGqNlU/oxXs3Ghy+K0P8tXULQnrgGaUD967oM1y7vdcHclAOVIwKgMG6YC
         VOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U9j1VUNwpLjqthf/lcX140LSEyF9Vm2SDMFtz8UeK9Y=;
        b=SKVPa7GTt584G16HpWDgQ96ES9KNdV/eTNOUq7I4H5XN1U2c0U1KGimL7lWmDHg5d3
         8t9xcASuoxYA4qHEkuksVoT+uryvOx61gGGi9uh7MXZ0GBOGTWWVLHSCz0JzrmDZBoOk
         AqK6/A88c9+U00Y0PUl3RlvZ49hyQebqf9k/esKXL2zKSiy8kabu96FLPmjXkRgtVzkz
         3bvHG/lDqKckzeK5BY4KV7hnYZKIZsAqnDtEte+FqK0OAhbiqd3hxzTodblri05YH4SN
         JezG29T2pt+kT/PSP4woAZx12PiOcsjGzLDT7/KUlxJTbUh4dDGppf04v0M7y4utBMTG
         pA7Q==
X-Gm-Message-State: AOAM531cxDHc7Iv7ZQv4QbZyZDdSBigY75frI8xQ8hc7yPfeLBVBXBcS
        iNI12WU1NZpCbOZVCRX9vFg=
X-Google-Smtp-Source: ABdhPJyye5fMTzpPnUMWlW9dAlR8976//YpdeSHIGDi6TZPSCNQnHfH4Nr2GmoUJyASCfmHJGq9rEQ==
X-Received: by 2002:a17:906:c087:: with SMTP id f7mr26707500ejz.487.1627482980043;
        Wed, 28 Jul 2021 07:36:20 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id og35sm2151108ejc.28.2021.07.28.07.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 07:36:19 -0700 (PDT)
Subject: Re: [RFC PATCH 1/9] dt-bindings: soc: rockchip: add
 rk3568-usb2phy-grf
To:     Peter Geis <pgwipeout@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
References: <20210728122606.697619-1-pgwipeout@gmail.com>
 <20210728122606.697619-2-pgwipeout@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <fc6d5b02-707b-aa0e-9ef0-2984bbb1f5b8@gmail.com>
Date:   Wed, 28 Jul 2021 16:36:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210728122606.697619-2-pgwipeout@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 7/28/21 2:25 PM, Peter Geis wrote:
> Add the documentation for the rk3568-usb2phy-grf node, which is separate
> from the usb2phy node on this chip.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> index fa010df51a5c..3b0e06b6ea61 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> +++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> @@ -16,6 +16,7 @@ properties:
>            - enum:
>                - rockchip,rk3288-sgrf

>                - rockchip,rv1108-usbgrf
> +              - rockchip,rk3568-usb2phy-grf

Could you sort this in alphabetical order?

>            - const: syscon
>        - items:
>            - enum:
> 
