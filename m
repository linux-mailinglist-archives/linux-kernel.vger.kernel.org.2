Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B61416947
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 03:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243747AbhIXBOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 21:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhIXBOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 21:14:10 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F291C061574;
        Thu, 23 Sep 2021 18:12:38 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so8989714ota.13;
        Thu, 23 Sep 2021 18:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jZSX2L+ZaMKOPBuw6sCq8F1naptzLxLKZ6KKLxO+i+4=;
        b=kHAMhU1Oto8cAlmPrPpHprpOjYC2lIbMTDHkRW+9bErTMh9HJv71Xu0iy1cCi6nPNX
         Ioo/105yktlRy2B8cPNQYivKteMDQZdVkZYQ3MDiSY1Pwaipuzqr4TPBaCtIr+Z6H69E
         SwHetJcp7n73bcAujWxYhubRObnvNU/j9pYF1oLFzz4iaNwtun9ivoiR0W02+u3Mkm3D
         QxAS2zpUsmvms8f6B07JU69csKC2JtYanWR+5UrYWpTW7tZ6cz/b5iXK+gIC4nBG13zJ
         qXS8+gtxun3wMdq8xEUt89FD4B44YSGu40qK7lRVTfmx2c6UqXzQTU5puMDi3zriLe1s
         Eb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jZSX2L+ZaMKOPBuw6sCq8F1naptzLxLKZ6KKLxO+i+4=;
        b=xrSfsWHNY0XYglZN5nvf5iNzAqKjukfJrLQZ+Kysx8FDItMknJ/vHX4XfIw0hu826g
         7j3SA/+WaW5wgLCxEQMjBKXrjmkIzs2fzZJs9SkgyrPipuAA5tPBfwszgP63maysC9a7
         1GrkoQq3/gYdLQhd/EUyrxMnr84XZOKDmGooaWkN3HhvRSoNDF/8lQ9Vuw3a6AQrlqj6
         Dy4Z1nXmwAYQZOM6LqYhm5+Q25UWaiTcieCr6hjLUOeePpuBczjthVlGdCixRzzw45Tc
         /fNP1Z86yFwCLi95/S6wwwOEbWWTwMkiYsXX2wDk08TV7BckgrqKhoNpNcW9DejemWIY
         GhKA==
X-Gm-Message-State: AOAM531+DYreYCecqWX4BWDooVDtGIoHFjjnv+5pMYDORG1j9eVXdHkI
        TPappRj+AiuVqB9jOK0ibdB/3T2PAIQ=
X-Google-Smtp-Source: ABdhPJyPRwR+WThRfBelo3wHwUJs+OwT1JNHrGN+FTwMPv2PF4pPG295gmxKx4qNWxcwiP8o9nHF4w==
X-Received: by 2002:a05:6830:13c5:: with SMTP id e5mr1496794otq.374.1632445958006;
        Thu, 23 Sep 2021 18:12:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bk40sm1760724oib.8.2021.09.23.18.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 18:12:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 23 Sep 2021 18:12:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: hwmon: lm90: do not require VCC
 supply
Message-ID: <20210924011236.GA3029882@roeck-us.net>
References: <20210920181913.338772-1-krzysztof.kozlowski@canonical.com>
 <20210920181913.338772-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920181913.338772-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2021 at 08:19:13PM +0200, Krzysztof Kozlowski wrote:
> The LM90-like sensors usually need VCC supply, however this can be
> hard-wired to the board main supply (like in SiFive HiFive Unmatched
> RISC-V board).  Original bindings made VCC supply as required but in
> practice several other boards skipped it.  Make it optional.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied.

Thanks,
Guenter

> ---
> 
> Changes since v1:
> 1. New patch
> ---
>  Documentation/devicetree/bindings/hwmon/national,lm90.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
> index e712117da3df..6e1d54ff5d5b 100644
> --- a/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/national,lm90.yaml
> @@ -55,7 +55,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - vcc-supply
>  
>  additionalProperties: false
>  
