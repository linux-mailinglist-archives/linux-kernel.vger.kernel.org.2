Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD7E43D63D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 00:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhJ0WGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 18:06:22 -0400
Received: from mail-oi1-f170.google.com ([209.85.167.170]:39807 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhJ0WGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 18:06:19 -0400
Received: by mail-oi1-f170.google.com with SMTP id s190so4714693oie.6;
        Wed, 27 Oct 2021 15:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HwCdZSodtvLkyfWWv4aoM6TtcXNL3x8BBvrixERndQI=;
        b=7uRHLYrN3RSGZnIoPaNMfunRqfRPKV1j2W451i8o8XzqPjmaME/f99QYLLHo/iboih
         3sQlOqj/TYQVIv+KOS0JocRTnLdOATB8wLk9VuoJDu2v+juP8uZKJphY5Lg8Mrzxr1Y0
         TrfI7tTIdivR/pd9FO7GzoAW7CTpE8cXJdGp43gXQ6bbrLA65ADUUafIA1KCF3/XCOFN
         XbIvBq9ez7pJxq7YqiVKYcnTSq395XokAbcfTvKyObnYKT2JQrmwWFnmoisJnSMqJwga
         ig3rTpbsPP+R2Zw1soXqFGZMMy4KRrhMaGIXlZDXrpeFyAntrMYn8Nq1SGtvMIgntoud
         FJbA==
X-Gm-Message-State: AOAM531EmcX+QUfi2BaKo6ni/druNV54kcuWndYgw6VoohLU9IS5mNN7
        0ukj0HBoMYiOreDhfN0QTQ==
X-Google-Smtp-Source: ABdhPJwhAqhMiSOGICDeao9e3Uvovr/4CVgqZChnKufwCP091o04QifT1B/0u7uUX+ckIH+hwm1Nnw==
X-Received: by 2002:a05:6808:17a7:: with SMTP id bg39mr180967oib.70.1635372233675;
        Wed, 27 Oct 2021 15:03:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j15sm469441ots.58.2021.10.27.15.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 15:03:52 -0700 (PDT)
Received: (nullmailer pid 2256435 invoked by uid 1000);
        Wed, 27 Oct 2021 22:03:51 -0000
Date:   Wed, 27 Oct 2021 17:03:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc:     devicetree@vger.kernel.org, kishon@ti.com, heiko@sntech.de,
        linux-arm-kernel@lists.infradead.org, vkoul@kernel.org,
        cl@rock-chips.com, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        michael.riesch@wolfvision.net
Subject: Re: [PATCH v3 1/3] dt-bindings: phy: rockchip: Add Naneng combo PHY
 bindings
Message-ID: <YXnMxyuH/aGAvYAY@robh.at.kernel.org>
References: <20211025080632.32063-1-yifeng.zhao@rock-chips.com>
 <20211025080632.32063-2-yifeng.zhao@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025080632.32063-2-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2021 16:06:30 +0800, Yifeng Zhao wrote:
> Add the compatible strings for the Naneng combo PHY found on rockchip SoC.
> 
> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> ---
> 
> Changes in v3: None
> Changes in v2:
> - Fix dtschema/dtc warnings/errors
> 
>  .../phy/phy-rockchip-naneng-combphy.yaml      | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
