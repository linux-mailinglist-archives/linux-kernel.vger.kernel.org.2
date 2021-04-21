Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B92873670E1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 19:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244588AbhDURGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 13:06:08 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:39477 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241494AbhDURGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 13:06:05 -0400
Received: by mail-ot1-f49.google.com with SMTP id 65-20020a9d03470000b02902808b4aec6dso34808471otv.6;
        Wed, 21 Apr 2021 10:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VnNhlqosJN6VFBQj67DgFC5yjath8Pyw2MjPCOlu98I=;
        b=OmXKoa/zG5t/AeSUOfEg8PrjP94RDn89TcNmkPRtGKuhpKHJ2A/Y9SWs800D+KvlQa
         mxxSPbA5KjQ6G31ctuYODt/rOliHmaiFgeAC13eqPf1GV8JikMpGW2OIrU3oOPUH8xx0
         K6OtHUx5oQn+1/PlPZmTu2HL4u5ymUdHY4/WTRvRB7bHojGzF+lwZ210Tg7a3BcSTpgF
         2HEegA4fsVO6cJyUjLyE8WY/hxy7d167hQg6NhuDNITIFK/3/Yybqh1mm69uHGONS2Lr
         xyHmck/Ub+4Y8Rwh47KQQdOW9EHQzbpPghBeoi7CcYV5+iwpwmvikFJH8YvDfZfbp0HD
         Um1w==
X-Gm-Message-State: AOAM532Os0Jl4jnJk/loRETfDTRHH/BCmuSyrYPLXtUjHk8iym9aro4v
        Wz2G1eMIbKtAiPlp5LsFgw==
X-Google-Smtp-Source: ABdhPJxGxlSet0sEADtkRKnhfmQuBwGN5IXkVGmSuiXkwvuaZPHYwC/G3VRmp+wcC3rD2bbZcrYz3g==
X-Received: by 2002:a9d:2230:: with SMTP id o45mr6550457ota.104.1619024732078;
        Wed, 21 Apr 2021 10:05:32 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x2sm696611ote.47.2021.04.21.10.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 10:05:31 -0700 (PDT)
Received: (nullmailer pid 1300033 invoked by uid 1000);
        Wed, 21 Apr 2021 17:05:30 -0000
Date:   Wed, 21 Apr 2021 12:05:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     devicetree@vger.kernel.org, Ben Ho <Ben.Ho@mediatek.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sean Wang <sean.wang@mediatek.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v3 05/10] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-fennel
Message-ID: <20210421170530.GA1299957@robh.at.kernel.org>
References: <20210421090601.730744-1-hsinyi@chromium.org>
 <20210421090601.730744-6-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421090601.730744-6-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2021 17:05:56 +0800, Hsin-Yi Wang wrote:
> Fennel is known as Lenovo IdeaPad Flex 3 Chromebook.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
