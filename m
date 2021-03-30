Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4A834E4FE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhC3KBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbhC3KAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:00:55 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C096FC061574;
        Tue, 30 Mar 2021 03:00:54 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v4so15590459wrp.13;
        Tue, 30 Mar 2021 03:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/OWdtssKXgIS/+aSy2WIqZQ6CLWvQMHzZY5qZ+tnkf0=;
        b=JO27lLB7x9tZrvIhOSdWQz+73oSPwtJusWq99CFR+AkWrMEa3itDADmvNzED8cGBGf
         eI6V9iyS1Qesg+IF9Jb+ZDqgtUF85MWgDvQw07uQB6OUdG3opquFEa4wHCRY/MeJoSHq
         qhRXUj24/KNO7hTjAlXB9WLbeK5Lpr59mTWJ/l5S8SOT9m9YP74ATWtf863aCB6u74f1
         DZf5NsikuLk5iV4O6SWfSw5D5kMR1izrqC/uPfdVCIGn2Dq0SRxsWeLaa2478kpega7x
         PQCbjsX1r/AXbx+hqI8CQ9d5zfjTSPg7ygul5k7MuH0axKXeDNPjX2AgXarujvpzbskp
         ZzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/OWdtssKXgIS/+aSy2WIqZQ6CLWvQMHzZY5qZ+tnkf0=;
        b=cYyJBT34/+7sdUZ0tskdvoePG4t1QkLtAgFWj9G3hbj69aJDho83RuwdotLIsO4gCM
         I83qmvN4JLo0f2GJFdTSXD7mhx4ibgIG9Yxb7YlC+j/hNDxzpI6Bsjpw778zy4KKkrIo
         /kAlZfP+NoBQYB4nmX/QYVTSs3eNC4YaNgaChBd9r7b1X8/L5hFNYdWc/zJRYKEs+7Kk
         aytOjR52H1DnbuZKJvzcUdLXJI+09WWKYR2AT9q3FIaGTcc14CuZSVZcItG4gnXYMWGO
         pAZAfNJQMhp9A9onx8nsDFQ2QzFVQzJZvgr0nqhcvOojVAJ/6IdjZLJxqiYHEkBkFtaa
         Dd+g==
X-Gm-Message-State: AOAM532fsj5T4gtJenJM6zqJhGHKZR/I0KJynn4Z4rLr1QHpPiRfNOoI
        cqQZJTdiDYvyaVvjhWZm1Y4=
X-Google-Smtp-Source: ABdhPJy6+7wu9rLrhuijj+YjhwYpn19FhS7/B87uWaI8puF70viFHrqgpl92ju2nKTHiGQ69LNZ84A==
X-Received: by 2002:adf:ce8a:: with SMTP id r10mr33005493wrn.17.1617098453573;
        Tue, 30 Mar 2021 03:00:53 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id g9sm33159038wrp.14.2021.03.30.03.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:00:53 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: arm64: dts: mediatek: Add mt8516-pumpkin
 board
To:     Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>
Cc:     mkorpershoek@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20210223223613.2085827-1-fparent@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <56a1fbe6-2c87-e01d-768d-b956237c9f3f@gmail.com>
Date:   Tue, 30 Mar 2021 12:00:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210223223613.2085827-1-fparent@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/02/2021 23:36, Fabien Parent wrote:
> Add binding documentation for the MT8516 Pumpkin board.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---

Applied to v5.12-next/dts64

Thanks!

>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 93b3bdf6eaeb..366a753f64ba 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -125,6 +125,10 @@ properties:
>                - google,krane-sku176
>            - const: google,krane
>            - const: mediatek,mt8183
> +      - items:
> +          - enum:
> +              - mediatek,mt8516-pumpkin
> +          - const: mediatek,mt8516
>  
>  additionalProperties: true
>  
> 
