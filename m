Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A376D3A3F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 11:49:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbhFKJvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 05:51:32 -0400
Received: from mail-wm1-f50.google.com ([209.85.128.50]:52856 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhFKJvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 05:51:31 -0400
Received: by mail-wm1-f50.google.com with SMTP id f17so7749913wmf.2;
        Fri, 11 Jun 2021 02:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7ObfSjunS2lqcu+qmz5f/+ME5Q9V/oV3SAiNhGet7h0=;
        b=ClRCy2c0ol1tBDtfW5RGO5sESybQqKJgcKnfy8A2Py/6VY67/NwXULxLLMBifRExwS
         ntroCvu6XNQlu4XJn4tdwlZEQibGveP0GIcF1zwC0Hd/EF4B9yPBdIewIb6KiHM9hQNb
         9OV6wZE44HMN1/Z+sZFFJwt57YeVDk/MvgBvDnPXqCX6kaM3lyBn1a2T4Zv/0GP9G2ze
         lOe5iGnCZG6xFx9kafVbE/9FYJN29esHDg6lLVJEioVWGMBQppyV160ZH068BzPlgfvr
         lg+83qjJq697jJS4ht7RTr2wZo1Z2KWbQqbSz516lS2ABz06tStNlb6BqoxENNL/T8cZ
         NqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7ObfSjunS2lqcu+qmz5f/+ME5Q9V/oV3SAiNhGet7h0=;
        b=jncx/PCrKjbat2sQooEONfgJwEWvFdtQek+ESOX6rsInjxAEgUB//mVZBBGnXhigIm
         9u17RmiPrvqNbNclY1fBgWPWhRHM9cJIAHUtapAPZ5Y+EmnMxLdtyhxx9J8/1BQMJuLN
         KNs5wsfaJLbGWqURXyoxPi5XjK+qIkcvULZ8yXNPSsd0cHq+7H3gywhpXyuTvqTr+8p2
         8JaJERGk/XF4TaBtIMko1ZI0ndAHtp/tveCz0c6MDYK/0z4apdddSTslsu49AdUBtSoe
         IPLJs0IEuUMjxDbT0m81xYkrHh2HZLQiWyDSuIcXiwPyEJeZGYMBnsjYUZ1d5wuC6/XW
         hWRw==
X-Gm-Message-State: AOAM533mALsvzxRg1QsFiNw788fRc/hLrnk8wlmEmvRu6ixACdpYKzk5
        /i5CrukvhrQqEKoXeZJDH2k=
X-Google-Smtp-Source: ABdhPJzcgh43AweTQqlpG4DsIlO93zwseDZqvtC3I1XN2r+uEIw3ceMUybZE1nde+hE5GmM70BNbgw==
X-Received: by 2002:a05:600c:22d9:: with SMTP id 25mr19855564wmg.152.1623404912991;
        Fri, 11 Jun 2021 02:48:32 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id 89sm6799095wrq.14.2021.06.11.02.48.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 02:48:32 -0700 (PDT)
Subject: Re: [PATCH v3 1/2] dt-bindings: mediatek: convert mtk jpeg
 decoder/encoder to yaml
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        maoguang.meng@mediatek.com, yong.wu@mediatek.com
References: <20210611092357.2930310-1-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <b8c3433d-8860-38bc-27f0-877f05e9e0a7@gmail.com>
Date:   Fri, 11 Jun 2021 11:48:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210611092357.2930310-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/06/2021 11:23, Hsin-Yi Wang wrote:
> Convert mediatek jpeg decoder and encoder bindings to yaml.>
[...]
> diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> new file mode 100644
> index 0000000000000..e4e791d76cdaa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/mediatek-jpeg-encoder.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek JPEG Encoder Device Tree Bindings
> +
> +maintainers:
> +  - Xia Jiang <xia.jiang@mediatek.com>
> +
> +description: |-
> +  MediaTek JPEG Encoder is the JPEG encode hardware present in MediaTek SoCs
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt2701-jpgenc
> +          - mediatek,mt8183-jpgenc

Commit message talks about conversion. Sorry for nit-picking, but I think the
new compatible should get a new patch. If you add changes to a file while
converting/moving it, it get's really hard to find that change later on.

Regards,
Matthias

