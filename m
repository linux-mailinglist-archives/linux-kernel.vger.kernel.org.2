Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE70372A7B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 14:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbhEDM5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 08:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhEDM5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 08:57:01 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FBFC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 05:56:06 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id v5so2220065ljg.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 05:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ZEIfQIWplyJsRjhAB9oJ0mVxCOsZMQEFoeb6pJvTqk=;
        b=P2xiwxC9N7JTjuvp40yQtJbPylijakcYl1ZZ7HGbdTWla3UaPkanl5AEiQcR4rhrM3
         WjaO3gBAyqKEHCnQ34sF3SBIAPXIuO35j963dIxZRlM7Nb+22HonRKQL2nb6aHKYp/gS
         I/5u/1nThzvX3AOyBptLIhReutJxeW15knqcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ZEIfQIWplyJsRjhAB9oJ0mVxCOsZMQEFoeb6pJvTqk=;
        b=mbgvJ6XLVSnwQWGRoU6MFz5nKfDELpUgTyXsQRGeDoOybItb9I288edXVRsjMqEl8d
         NQNo4LRiL5/GRZd6M89QMXNgykECxabuKwF7pNNUvhlpnRAbm4sufyKBt5gcyS6PzJ6U
         1Itwa1+kzdMJJCM6k8Bb86eXZXstJJaHmI6pWudIR6Wluh3G1MLeKfpi1AWQLWd5l30s
         Yqckv0FOtXegyq5ZLOdo+0t7bCPGNq7vhSb6YijEQDzIRv3LveY+EjlGp/ZV1W4dJaaf
         VwLH8RJFsF9gN45UVI6TM6+tT4AhEsAC+qGANqyBMiuUWdlVGxm+ESS7g5hQHfVJ0tzi
         JdPw==
X-Gm-Message-State: AOAM532xJqppBr+dg6JU0r04RZsabvoXR7D1GAyjbHqMKdXoyzTRfvOf
        2XZxmcX/v+946TyQfmCMlOYNgUQI0j/NLA==
X-Google-Smtp-Source: ABdhPJz6q0dsA0L7YWMXou33UVu5YojapWem4CQ5qSF7phNGDBDI5HJjixe1kmAHdqrx0bhl6EtUvg==
X-Received: by 2002:a05:651c:612:: with SMTP id k18mr10679742lje.339.1620132965224;
        Tue, 04 May 2021 05:56:05 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id p9sm259232lfu.185.2021.05.04.05.56.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 05:56:04 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id x2so13104599lff.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 05:56:04 -0700 (PDT)
X-Received: by 2002:a05:6512:108c:: with SMTP id j12mr16512793lfg.403.1620132963589;
 Tue, 04 May 2021 05:56:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210427111526.1772293-1-acourbot@chromium.org> <20210427111526.1772293-9-acourbot@chromium.org>
In-Reply-To: <20210427111526.1772293-9-acourbot@chromium.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Tue, 4 May 2021 21:55:51 +0900
X-Gmail-Original-Message-ID: <CAPBb6MWhP+uJSHzMHuH93fxgFosw=FPUoHOLuDX1ZYGunWX11g@mail.gmail.com>
Message-ID: <CAPBb6MWhP+uJSHzMHuH93fxgFosw=FPUoHOLuDX1ZYGunWX11g@mail.gmail.com>
Subject: Re: [PATCH v4 08/15] dt-bindings: media: document mediatek,mt8183-vcodec-dec
To:     Rob Herring <robh+dt@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Apr 27, 2021 at 8:16 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> MT8183's decoder is instantiated similarly to MT8173's.

Gentle ping on this, could we get your Acked-by for this minor change?

Thanks,
Alex.

>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  Documentation/devicetree/bindings/media/mediatek-vcodec.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> index 06db6837cefd..a2a2a9e2ade3 100644
> --- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> +++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> @@ -9,6 +9,7 @@ Required properties:
>    "mediatek,mt8173-vcodec-enc" for mt8173 avc encoder.
>    "mediatek,mt8183-vcodec-enc" for MT8183 encoder.
>    "mediatek,mt8173-vcodec-dec" for MT8173 decoder.
> +  "mediatek,mt8183-vcodec-dec" for MT8183 decoder.
>  - reg : Physical base address of the video codec registers and length of
>    memory mapped region.
>  - interrupts : interrupt number to the cpu.
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
