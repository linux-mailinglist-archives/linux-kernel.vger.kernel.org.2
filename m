Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3B1D402E63
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345912AbhIGSbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:31:34 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:44763 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236461AbhIGSbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:31:33 -0400
Received: by mail-ot1-f53.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so203864otg.11;
        Tue, 07 Sep 2021 11:30:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RY7t/KtclcMrm1EFQWrDQzShg6OefcMHqjUW+/7wI8k=;
        b=V1ud0fLlm9ttD8jfEmCaycFQMBV+a0dnOozuLAx1TFT3Jrino+9TfsRUVEQXYzde5r
         8cjCZgtl4PCQDmoC3G4xe6bEFSnf4n6qooI1bb2aftJ2BORE9pOP2OfgfmqsT9TKyNkc
         UlYOr2RcaYezZKmVvoz2k2z7XzfMLkqma2s8VNBcmjbzDFUXRe3qJt5VB82cf+t6DKEV
         9U/rDBkQ4aRODgklvZZfGVbWRwbEtaAKCkBpvra/RgOL132zNxY0rFuVOmphF7x2mS00
         eRNIMkO+iJSSUWqgFWNU2C9ebKrAKvctiBSYjFfTe2z72EB51urkT/l0Ja8F+HzXW/QA
         QlAw==
X-Gm-Message-State: AOAM530BKbhAmJJZrnd9bGLcPvOJgeI2E7aDoLQuc2lfR1Pynxu6BChl
        uLVM5YravaqbvTOF2BQSOAO0nSwexg==
X-Google-Smtp-Source: ABdhPJy0rnbbmCqZo6/JDD6kKwVz/6PyHgi9xXqaVz1dF2On7vgXzqe19r+KS/YvEyPjAkIj4CeaUA==
X-Received: by 2002:a9d:7299:: with SMTP id t25mr16204557otj.272.1631039426239;
        Tue, 07 Sep 2021 11:30:26 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k1sm2665289otr.43.2021.09.07.11.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 11:30:25 -0700 (PDT)
Received: (nullmailer pid 110400 invoked by uid 1000);
        Tue, 07 Sep 2021 18:30:24 -0000
Date:   Tue, 7 Sep 2021 13:30:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        paul.bouchara@somainline.org, robh+dt@kernel.org, sam@ravnborg.org,
        konrad.dybcio@somainline.org, daniel@ffwll.ch,
        marijn.suijten@somainline.org, devicetree@vger.kernel.org,
        thierry.reding@gmail.com, martin.botka@somainline.org
Subject: Re: [PATCH 2/2] dt-bindings: display: Add bindings for Novatek
 NT35950
Message-ID: <YTevwDHhSJKIboWl@robh.at.kernel.org>
References: <20210901173127.998901-1-angelogioacchino.delregno@somainline.org>
 <20210901173127.998901-2-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210901173127.998901-2-angelogioacchino.delregno@somainline.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Sep 2021 19:31:27 +0200, AngeloGioacchino Del Regno wrote:
> The nt35950 IC from Novatek is a Driver IC used to drive MIPI-DSI panels,
> with Static RAM for content retention in command mode and also supports
> video mode with VESA Frame Buffer Compression or Display Stream Compression
> on single, or dual dsi port(s).
> This DDIC is also capable of upscaling an input image to the panel's native
> resolution, for example it can upscale a 1920x1080 input to 3840x2160 with
> either bilinear interpolation or pixel duplication.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> ---
>  .../display/panel/novatek,nt35950.yaml        | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt35950.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
