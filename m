Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA38334BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 23:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhCJWmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 17:42:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbhCJWla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:41:30 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD6CC061761;
        Wed, 10 Mar 2021 14:41:30 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id r25so27739448ljk.11;
        Wed, 10 Mar 2021 14:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0QF4U1EjzeSFBBGGRg6Folsa6RnufGkB2larNXv6VrY=;
        b=KCA16+3bpcWUZAppOub6HxaIT0x2+IXvTUVF6jPnkizPkHKk3p/PUqlhjGZ+2G8zxZ
         7lTceSoHkk19ke+t03y2eVF2ufTcPeW4mwLle1nz6r6TJe5bua2BX7AFqZw4O2J3CQdw
         Ek95LlsiON8VngfODwWDoo6byZPsEmDdeMCf89t8ArxPNHgJXoIqq3if8WxgQUgzfPzO
         dZE8EXXkrHDLKVcRubxSGX7ji3bc7ORt6dGHBWYwR+9iMmlB9llBPsUsR0yBJF2Zez+2
         humu29V3GVRUJoSq0A154RjH4MgTLOddG14cy9YR6cq7FISx41cxl6nEkEv9+q+wqx6y
         Manw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0QF4U1EjzeSFBBGGRg6Folsa6RnufGkB2larNXv6VrY=;
        b=Y23rO5WbJEZhkQ/1wW3LtqiUMaIV4xNNy3I82x+RSE71CoQ1dpKT66LH62Lu7ez8JP
         1eRFdiBgtLtqpLdK++S7Se+vuhq0GpEWMIGyz5Ezc2VVPz7QeIZvVfBr8VWmpazzsYB1
         DhKuDWuP6QPCb9b3umcBOCuGldCVzg45FuQ6jfn1+4kHyOvfMOa6YClGeY8pwP0ZYdJT
         +a+9FhPsOWlWk2eTVJIfaWpwFdDv1d0/KoxaCzeKon7KLLTF4Ge4KTLNmqeA1xlDwaF8
         oF2Dv4odePz5lX98MNKXco8cHO7Z4Zg0AR3f+CoC22KVbLOBg03HQMuFjRdZhd81OhLg
         wMRA==
X-Gm-Message-State: AOAM531jlqbxD1k2CWdErAIzmbhGPbmlqs/UoPvYpL++D7yycPPMecRh
        IUZQfBw1GBtXIJJeZTcVrKBi9CDsB34=
X-Google-Smtp-Source: ABdhPJyV8prnjfdr7O/N86GIUgpIE/sjZlwQYIl+xENvrLMV8gDcJHtRiJm3vQfxrH8uxZp+jI2nzg==
X-Received: by 2002:a2e:a48b:: with SMTP id h11mr3002205lji.492.1615416088614;
        Wed, 10 Mar 2021 14:41:28 -0800 (PST)
Received: from localhost.localdomain (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id v2sm296728ljg.89.2021.03.10.14.41.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Mar 2021 14:41:27 -0800 (PST)
Subject: Re: [PATCH v4 2/3] dt-bindings: mtd: Document use of nvmem-cells
 compatible
To:     Ansuel Smith <ansuelsmth@gmail.com>, Rob Herring <robh@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210310210812.8880-1-ansuelsmth@gmail.com>
 <20210310210812.8880-2-ansuelsmth@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <5d798266-3a18-d50d-9c3e-f91bc2460fe5@gmail.com>
Date:   Wed, 10 Mar 2021 23:41:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210310210812.8880-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

See inline

On 10.03.2021 22:08, Ansuel Smith wrote:
> Document nvmem-cells compatible used to treat mtd partitions as a
> nvmem provider.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>   .../bindings/mtd/partitions/nvmem-cells.yaml  | 96 +++++++++++++++++++
>   1 file changed, 96 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> new file mode 100644
> index 000000000000..f70d7597a6b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/nvmem-cells.yaml
> @@ -0,0 +1,96 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/nvmem-cells.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nvmem cells
> +
> +description: |
> +  Any partition containing the compatible "nvmem-cells" will register as a
> +  nvmem provider.
> +  Each direct subnodes represents a nvmem cell following the nvmem binding.
> +  Nvmem binding to declare nvmem-cells can be found in:
> +  Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>

I think that when Rob wrote:

On 10.03.2021 03:58, Rob Herring wrote:
 > I think this should reference nvmem.yaml.

he meant you using:

allOf:
   - $ref: "nvmem.yaml#"

(you'll need to adjust binding path).

Please check how it's done in Documentation/devicetree/bindings/nvmem/*.yaml files


> +properties:
> +  compatible:
> +    const: nvmem-cells
