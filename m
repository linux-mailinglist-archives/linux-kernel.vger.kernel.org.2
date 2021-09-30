Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1AE41D2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 07:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348142AbhI3Foe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 01:44:34 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:49374
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348054AbhI3Fod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 01:44:33 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 7258A3F4BE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 05:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632980565;
        bh=1mKwPojwZVljLwBZplr11EQoeIBGXn/S/x5FHURshGs=;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
         In-Reply-To:Content-Type;
        b=iW/uhLksi0sdoYjLXnPBqVFKhVmoJW8n8afXhQu/A0ofK1K/fM4cuT5zzpBBP+bdT
         C13bJ8wSvQP9ZByl9W6OViGtbyQoPDo89JtIB6IvTGYpJt21kWmm7CYgzfkmXxkWwg
         bIqEd/guY7lJynAdsyg+GtPqSTlbzHoY/BjOCDKKvNioA9mRdieRhpQu9+TwXxyTkk
         1DhNusLpjVvukz+7VFd3AV186z3lluWCPOjOtTnAyxarMhH0NOR7HumTUlev6PLgpz
         Mztxhbz0Td4afJqVlwSgoB0XdhuJBMzvdO0YIGO9eLWiwpljHVdgS1JBoSGCzeqOD/
         oTyxkxAuITZIQ==
Received: by mail-lf1-f71.google.com with SMTP id 12-20020ac2484c000000b003fcb3298d00so4493741lfy.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 22:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1mKwPojwZVljLwBZplr11EQoeIBGXn/S/x5FHURshGs=;
        b=wMu4Kgcr3/0GsWWffHtUL6R20LERw9QYL+p3fV9K3olnwz+JUP6YnztAS1900tWLb6
         ypiOqwiD3oqY6q9lBsHjh+XNz9eEFjKNX5U/fugoRUmGddmEa44X8IR91qgCKsjCFN8Z
         A3TGR4zTbn5eY5jc2WNZc/6gK7cX1Wf0BNla3WtIlLcOqOosVzzXLRUuza0WN/Pc1X6H
         81FKiXfTJJDl2CW+4YGLp0l/XfBfsXH+2eFDmtTn6RVbYuPJO/yN7yn4NNzwc9vxMitl
         y3HRF5TSiEflnF7Hn73ZPTjrOUelKwd1fBGUkHM86qC7GYsitrLSMSotNt4Qimd0yH+y
         H8lA==
X-Gm-Message-State: AOAM530Jgd1ZLoVfdz8BOeHxrtGxxd2ZWSllohFFavUkp/1yKpBq7KXh
        a4ajN5CgaTBY8aUiulJRu6L90OVgyoAHePXP8l3zoFBM/pDKlB+GTbW6NyLkiWkqkr51npxRgRp
        6RNE4k6+VAX0OA7n+htJ5CS7d3pKFSLbR4mKuoUmxXQ==
X-Received: by 2002:ac2:5606:: with SMTP id v6mr3779639lfd.520.1632980564526;
        Wed, 29 Sep 2021 22:42:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfzHOQe412riavI/Qmxs0LY7rgPu/GGpo/1fLrCa042n08AZ+YLqvCU8IZK13tu6wUDRAysw==
X-Received: by 2002:ac2:5606:: with SMTP id v6mr3779623lfd.520.1632980564295;
        Wed, 29 Sep 2021 22:42:44 -0700 (PDT)
Received: from [192.168.0.197] ([193.178.187.25])
        by smtp.gmail.com with ESMTPSA id q6sm43696lfg.188.2021.09.29.22.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 22:42:43 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: add vendor prefix for asix
To:     David Heidelberg <david@ixit.cz>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210929192619.111098-1-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <d3b20df8-1953-9a8d-e59c-fda3656d3790@canonical.com>
Date:   Thu, 30 Sep 2021 07:42:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210929192619.111098-1-david@ixit.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2021 21:26, David Heidelberg wrote:
> Add vendor prefix for ASIX Electronics Corp.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Already on the list since some months (unfortunately still not merged):
https://lore.kernel.org/linux-samsung-soc/20210929140854.28535-2-l.stelmach@samsung.com/T/#u

Best regards,
Krzysztof
