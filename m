Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F115B436120
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbhJUMOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbhJUMOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:14:44 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EDCFC061753
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:12:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r10so485778wra.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0vIQqYKkVJx23x9coP48EXe0l28e0ZIhnZSwiowHwyg=;
        b=fjDYojDfUIX7vpR8IADwpgpzztO0mBpWvU65QUoNAhI5h5l4jvmUm9miufICBJ5fu+
         FxiTVlKpiDwYP9RvWlJVzgmCn3rKhVbPBFdp3eV8AhF2NEhLLUTgdfsXR6jOaKfV95yA
         yKh8F+J7jnDhCPp43d4HMm/IFi5aPJNRVnbPhadYav0+2DUOEOyshcveJJlYbHUBBW89
         Gsnd+/3PE0Y4U0MHiH5O9sI0rqUhz35zhF46IeFgbtyqZUXESpSdaHnQMpFL1oUoZCPz
         VcOuC9wOfHlEiiYm1/30+n9HZsc9I3fqsfVUg3Hb9vpiPeZPD4gkJpKPjASc40Nw/YQx
         Tr/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0vIQqYKkVJx23x9coP48EXe0l28e0ZIhnZSwiowHwyg=;
        b=J3LGA9hh8A80fY0CkjP94vNbMcy1Eo5veS7g17UJjM+k03D/TEi4YxGuPRP2WqugFT
         6QtrjPURQF2oKWVisp2WohCfboJ96p94wDKH3CkR7iqCF7urC+8zYxEBOYloEABJSGLq
         eyn8TOR9a2JsSLRUAqZ5ZZBMKMcsTF/+DnnCNreZx/GkL4JEQrUvD0QRl90dmhxX+dv+
         JnoD1pzuyugG056MmMii4gQHbQ2HTcFmCCZ4RUapvGlSTkf2BTbMT2/3l6kayo8uaLj+
         3MlXxai/+Fz83rDkuJUoxQAxtrPGQalsC6nZRAGz5km7NJYs/9xVw/H6Dw4jz04/WsRF
         f0Ig==
X-Gm-Message-State: AOAM532QDZIAGwIwjN9aSyPTd6MtajjHxYEgDd1f/y0djyjfhxyQSsR4
        FfUBI1OPpMmhw1n0AR+qt6IOlw==
X-Google-Smtp-Source: ABdhPJzQay9dVlMqf3DY2Soi8sHXotsMVqIdyaXQBVCXgXq5JubAhzo8DeCcf5lcsyavZ1roeJjN1g==
X-Received: by 2002:a05:6000:1683:: with SMTP id y3mr6576853wrd.314.1634818346988;
        Thu, 21 Oct 2021 05:12:26 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id a2sm5200597wrq.9.2021.10.21.05.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 05:12:26 -0700 (PDT)
Date:   Thu, 21 Oct 2021 13:12:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 20/23] dt-bindings: mfd: update x-powers,axp152.yaml
 reference
Message-ID: <YXFZKGfFTbjAVCb5@google.com>
References: <cover.1634630485.git.mchehab+huawei@kernel.org>
 <aedef820f4dc9af5d3a3fcce2ad733d75e1ad4f0.1634630486.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aedef820f4dc9af5d3a3fcce2ad733d75e1ad4f0.1634630486.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Oct 2021, Mauro Carvalho Chehab wrote:

> Changeset f38d3e404326 ("dt-bindings: mfd: Convert X-Powers AXP binding to a schema")
> renamed: Documentation/devicetree/bindings/mfd/axp20x.txt
> to: Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: f38d3e404326 ("dt-bindings: mfd: Convert X-Powers AXP binding to a schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
> 
> To mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v3 00/23] at: https://lore.kernel.org/all/cover.1634630485.git.mchehab+huawei@kernel.org/
> 
>  Documentation/devicetree/bindings/gpio/gpio-axp209.txt | 2 +-

This file no longer exists.

If it's still relevant, please rebase onto Linux -next and resubmit.

See this commit for details:

  dt-bindings: gpio: Convert X-Powers AXP209 GPIO binding to a schema

>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> index fc42b2caa06d..538f04e60ff9 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> @@ -17,7 +17,7 @@ Required properties:
>  - gpio-controller: Marks the device node as a GPIO controller.
>  
>  This node must be a subnode of the axp20x PMIC, documented in
> -Documentation/devicetree/bindings/mfd/axp20x.txt
> +Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
>  
>  Example:
>  

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
