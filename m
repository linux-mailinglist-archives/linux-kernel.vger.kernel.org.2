Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C49D3D1C19
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 04:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhGVCLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 22:11:18 -0400
Received: from mail-il1-f176.google.com ([209.85.166.176]:40907 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhGVCLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 22:11:17 -0400
Received: by mail-il1-f176.google.com with SMTP id b14so4104508ilf.7;
        Wed, 21 Jul 2021 19:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lsMmdb3RACH1JkoBJG5sGumKb94IlRY0tNHad0u0PRI=;
        b=c/bfAJWwg7ENiKQoU8lWOBcWDNQ1pJ1cIWNq5fht/7IXI7kZWHiYkWZV+GhYZFqgHl
         6REpuIdn2mHXLOu+V2Bbx0rjl8B4PuNYKPC/cImPrlkm1frvRDnQiUY6FuEqD20/15Tn
         iEQQkTXMhIUWoSwZg3vmUUIKzY6sgRCdEyMVtGkF7Gww0QH+ZpjkWn44jR6lTzdhzCWu
         fv2phbS9FBbLHXnPsNCCsdk5xh+OPz5zD/PGVcTkyHmoouSHmN86vfDnsV/STUrPbwRK
         ZNTSMQ/ePfmmtmkP3baq8BRGwbtETIqAPrM3Rp4DTl6RRogolH22mJrSqGdcn3qJknuT
         SXGw==
X-Gm-Message-State: AOAM532290PQV6vb9rvryABMRv4WXqJJ2bY2g538qtfpeUecifvqms/C
        ck1HMdfohw7at7k9MmaO5Q==
X-Google-Smtp-Source: ABdhPJzmZE18IFaBDdOlrhlpnBJ9AsAYn8ZvXINaR6JGQ41ByUku4NHP3Ts8jbSgGijUtBKOGvhjJQ==
X-Received: by 2002:a05:6e02:1a8b:: with SMTP id k11mr26794183ilv.136.1626922312055;
        Wed, 21 Jul 2021 19:51:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id l9sm6060802iln.12.2021.07.21.19.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 19:51:51 -0700 (PDT)
Received: (nullmailer pid 3204306 invoked by uid 1000);
        Thu, 22 Jul 2021 02:51:48 -0000
Date:   Wed, 21 Jul 2021 20:51:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        srv_heupstream@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        ming-fan.chen@mediatek.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, anthony.huang@mediatek.com,
        Tomasz Figa <tfiga@chromium.org>, anan.sun@mediatek.com,
        Joerg Roedel <joro@8bytes.org>, yi.kuo@mediatek.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, youlin.pei@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 01/11] dt-bindings: memory: mediatek: Add mt8195 smi
 binding
Message-ID: <20210722025148.GA3204276@robh.at.kernel.org>
References: <20210715121209.31024-1-yong.wu@mediatek.com>
 <20210715121209.31024-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715121209.31024-2-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2021 20:11:59 +0800, Yong Wu wrote:
> Add mt8195 smi supporting in the bindings.
> 
> In mt8195, there are two smi-common HW, one is for vdo(video output),
> the other is for vpp(video processing pipe). They connect with different
> smi-larbs, then some setting(bus_sel) is different. Differentiate them
> with the compatible string.
> 
> Something like this:
> 
>     IOMMU(VDO)          IOMMU(VPP)
>        |                   |
>  SMI_COMMON_VDO      SMI_COMMON_VPP
>  ----------------     ----------------
>   |      |   ...      |      |     ...
> larb0 larb2  ...    larb1 larb3    ...
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-common.yaml    | 6 +++++-
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml      | 3 +++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
