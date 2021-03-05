Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865DF32F5EA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 23:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCEWaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 17:30:22 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:34491 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhCEWaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 17:30:08 -0500
Received: by mail-ot1-f47.google.com with SMTP id h10so3371395otm.1;
        Fri, 05 Mar 2021 14:30:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EG3oJ5PRX0DYUjC6mcyCt0rOTflE0zkFNOBLyyJWSWY=;
        b=tctDhVEV6VGJo8tMh7UuRUfIIMnl0X7XRiHSpKJ+nZqmA7pK+TPbeYZmSwzyd4n+qg
         AYagum83Zf6Om2gDloT9iWH6xemv85MI3+MIMu23RofwI6d52JxTnooVVYVcuaI6pmuX
         oXWaKzoLgHPEuoWlJsArnAOAIhrKnnGLRD2TW+9CF4pi9GtKZz/+FB4uChJGCdwp899Q
         VQfN/5vgkpdKBlBEczXeFhtJBc6VIG0isdnheBb5CJHQ9uPK3QL0nbVT2+S/V2H4qbvb
         baILNOQ1tVzGfzfX7Afj4yLqIk7JzN0oemM2J9eKvAdCvSB4JLPrvyrzOegDMl427/Yf
         G6QA==
X-Gm-Message-State: AOAM532gj1imZqlXJxGZK3viH82wR2LcXaK7bzcvQrRTZQqQKLqxD3n9
        ztvQ51wx0sq+jwxss5d0Fg==
X-Google-Smtp-Source: ABdhPJwbxmDpm+hfKjSxJ9aA3XJLGWVWCaIgXC53dtLMdkzCRvvoH+H1XbT7wXmprnO3BZe9Vj/z1w==
X-Received: by 2002:a9d:400a:: with SMTP id m10mr9623177ote.33.1614983408268;
        Fri, 05 Mar 2021 14:30:08 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n11sm807413oij.51.2021.03.05.14.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 14:29:49 -0800 (PST)
Received: (nullmailer pid 760212 invoked by uid 1000);
        Fri, 05 Mar 2021 22:29:47 -0000
Date:   Fri, 5 Mar 2021 16:29:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        mkorpershoek@baylibre.com, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] dt-bindings: arm64: dts: mediatek: Add
 mt8183-pumpkin board
Message-ID: <20210305222947.GA760161@robh.at.kernel.org>
References: <20210217205945.830006-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210217205945.830006-1-fparent@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Feb 2021 21:59:43 +0100, Fabien Parent wrote:
> Add binding documentation for the MT8183 Pumpkin board.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
