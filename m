Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F008F3A4344
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbhFKNub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:50:31 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:46732 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhFKNu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:50:29 -0400
Received: by mail-wm1-f42.google.com with SMTP id h22-20020a05600c3516b02901a826f84095so8538400wmq.5;
        Fri, 11 Jun 2021 06:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=73CyQddFjXeyq3KLs0vmikz1AYd/seTWj9eRVSGOW1U=;
        b=jzLyoN/KkjTThG6bLNAg+/k0lmoOx9xjP+/VMtG7CGQOS89k0uP/vWxgDXoZQIB4p8
         YLzAUMIAOsxpZQaa3NWjBADC5OCsxm7Gl8AGFsvMRzCN3FDDm/f7pMW4lqIRhxYvywU0
         cZlHSZP31v/uMF/EIAt+GumjA6W0JoTUT54PPl3GI/WV7Y+OHd0T+ONBKAMwzlGiXAuT
         UeSH5oXuhVft61NUFIC7mWW21wKcHFMBjAkK7+xiO25uCy0H8ATn3z5buEAK5dL28L0U
         GHHHsd0bmjZbTwBAsFrQJnwOilkZ5iQ77M1EEzlMvQUIzdD3NhfTFYcHcfXRNAoSiJ9r
         kSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=73CyQddFjXeyq3KLs0vmikz1AYd/seTWj9eRVSGOW1U=;
        b=EM+AAAz58bNIOy06zxPJR9d74Wgl3wRxyniFVkvjdvZ5jBnSEkmCrMER1RvogWcay2
         jGRte2CItxE5khE58/Q+6WCCGw5FPtkaTILhxmF8yRoJfTa2+i3g6Go/rKFZHe86MEM2
         cRXIF5tansqBDDdBtGHR37+dnamkxwORTxZeqeMj2K8Y40qFo8glf9JarAAwdh5Gi3C5
         KlHaK1BALPHpdg7B3YbagvHao70c1CC0C4cO7d2SXNM6c7TkCK0az45d/b8nHStVWpzh
         8MKCxYw3fLlNIdWlF6NEAJn0kgAJg17I1mfIDYBO10VhZs1xdS6NImPpksBdZ0W5YNic
         6s4w==
X-Gm-Message-State: AOAM5303JD2w2CBpt68FC7PvIoHN5jv0Jjd397ZVG0Wei6kY5w5mioXZ
        FTjm6h62itYIjfScndKfLQk=
X-Google-Smtp-Source: ABdhPJwpq2Yeiy/iQrYQe033avggot+eV2WT1p/iVOHuNKV/PwV32Zh/FfzWYziG/2sltaCxGIo/Vg==
X-Received: by 2002:a7b:ce13:: with SMTP id m19mr4165326wmc.159.1623419250311;
        Fri, 11 Jun 2021 06:47:30 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id v132sm13686127wmb.14.2021.06.11.06.47.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jun 2021 06:47:29 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] dt-bindings: mediatek: Add mediatek,mt8183-jpgenc
 compatible
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        maoguang.meng@mediatek.com, yong.wu@mediatek.com
References: <20210611112009.2955944-1-hsinyi@chromium.org>
 <20210611112009.2955944-2-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <9b8cb121-e7a1-8f1d-c591-d42a113415f8@gmail.com>
Date:   Fri, 11 Jun 2021 15:47:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210611112009.2955944-2-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/06/2021 13:20, Hsin-Yi Wang wrote:
> Add mediatek,mt8183-jpgenc compatible to binding document.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> index 28f26e79fcb3a..e4e791d76cdaa 100644
> --- a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> @@ -17,6 +17,7 @@ properties:
>      items:
>        - enum:
>            - mediatek,mt2701-jpgenc
> +          - mediatek,mt8183-jpgenc
>        - const: mediatek,mtk-jpgenc
>    reg:
>      maxItems: 1
> 
