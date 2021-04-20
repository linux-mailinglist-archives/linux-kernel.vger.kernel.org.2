Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2218C365F43
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhDTSbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:31:04 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:37424 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhDTSay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:30:54 -0400
Received: by mail-oi1-f169.google.com with SMTP id k25so39911985oic.4;
        Tue, 20 Apr 2021 11:30:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qRJfvycjMVS7+Dlrjz9iVo/JVehkXqgejrTGtGxoW4s=;
        b=efCUz1DVG91rjsCBAKPFYT+8bm69jPJ1B0bsOls42QbQT7tDGrrx3YIvLlcRB19xn6
         V4F6jhaLE/aAROT7aD69mGPVbRtmdSpoSAINzFoKXfpY2jgwSsAmWysaEJLrv04I8Spe
         Y3aQQSa02UVR6vG/YqK9e4RpIsx6Yroi8aBf9H49zf87Axd5UFIlgT+UvMdxBLN13Pw8
         uv+2Ph8BWDFu4jfHQ81GgEmNDMumNwWol+7Yc87Yx+luhyh+2WNyJNKN0w4klIBqJ03S
         WZCVpLt4p0OS+6I3Zfc+0McsDDrLi6eYsCqRpNCT1Oy3nJAkJc4q3BHoYH334y3Ex72B
         wOoQ==
X-Gm-Message-State: AOAM532ngv+PKmY92N9IFO+GfE6+DkbaehKXH9Y6AdcO7zFieExtxsvx
        KecgIWpjls++z0ptBheU/Q==
X-Google-Smtp-Source: ABdhPJxWkFPc8q9nP0fElXNWc9Q4jrFRA2tAzgnQqBAEDU5kiVPRlVmLTq5c/xsKqk85G5VWPJqWAQ==
X-Received: by 2002:aca:3286:: with SMTP id y128mr4170561oiy.145.1618943422492;
        Tue, 20 Apr 2021 11:30:22 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j8sm4542127otj.49.2021.04.20.11.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:30:21 -0700 (PDT)
Received: (nullmailer pid 3597326 invoked by uid 1000);
        Tue, 20 Apr 2021 18:30:20 -0000
Date:   Tue, 20 Apr 2021 13:30:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-kenzo
Message-ID: <20210420183020.GA3597276@robh.at.kernel.org>
References: <20210416164055.3223088-1-hsinyi@chromium.org>
 <20210416164055.3223088-4-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416164055.3223088-4-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Apr 2021 00:40:51 +0800, Hsin-Yi Wang wrote:
> Kenzo is known as Acer Chromebook 311.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
