Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD0D365F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 20:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhDTSaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 14:30:02 -0400
Received: from mail-oi1-f177.google.com ([209.85.167.177]:37827 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhDTSaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 14:30:00 -0400
Received: by mail-oi1-f177.google.com with SMTP id k25so39908006oic.4;
        Tue, 20 Apr 2021 11:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d7LlXLtHF7kRiurMSaEVCbtNq5eGf5BuN3Gp5t3XCEg=;
        b=Fmdlu9P/i2lSCZCaHmwfP4YvRl3hn5l2ZqmWKct39X8c0aOZinYQB1FUOGWTis5Le+
         L2O6C+HAszPbgRKztxoZKwTE5zwYWqQwPOlgupS/Dr6br8qc4pCfvepA4ewe2fiaFZGF
         mImNun62vkPZukuPGGsvswIuxcUI1CV8TIkJG/BVdagO4o4tZybFw5lRyIIlZ4v48C5J
         k/v2Y8y2+D9MwGNp5QIVI/7s+TcVoqrzpiK3zPL8e+yDlfgPxB4QA+b6Snw02V3sJQ1K
         zPAj9bd7g36l9ekIKVC3+XmYV1W2WomCvOCsgiO85x+SEaBbs6OZVps4HYMZONE2cux/
         TWdw==
X-Gm-Message-State: AOAM530U42E3xfxhmo/eM+HpGQtuEpv3OYUy+mTKi2qlbHyKuMrNExKL
        dZEhCjskApqDwq/vulywbZApUcFNMA==
X-Google-Smtp-Source: ABdhPJzX5Ki14lyW+QTuObN02IkSiksk7PCgzUJRqVI+QsjwTfdFYm5l5wwGv//2AV6EY2XIFu3aIQ==
X-Received: by 2002:aca:b7d5:: with SMTP id h204mr4144569oif.18.1618943367147;
        Tue, 20 Apr 2021 11:29:27 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d7sm405632oib.49.2021.04.20.11.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 11:29:26 -0700 (PDT)
Received: (nullmailer pid 3595907 invoked by uid 1000);
        Tue, 20 Apr 2021 18:29:25 -0000
Date:   Tue, 20 Apr 2021 13:29:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-mediatek@lists.infradead.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org, Ben Ho <Ben.Ho@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/8] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-willow
Message-ID: <20210420182925.GA3595853@robh.at.kernel.org>
References: <20210416164055.3223088-1-hsinyi@chromium.org>
 <20210416164055.3223088-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416164055.3223088-2-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Apr 2021 00:40:49 +0800, Hsin-Yi Wang wrote:
> Willow is known as Acer Chromebook 311 (C722/C722T).
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
