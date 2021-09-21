Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C52A413B80
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 22:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbhIUUiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 16:38:15 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:36760 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234921AbhIUUiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 16:38:14 -0400
Received: by mail-oi1-f181.google.com with SMTP id y201so1050813oie.3;
        Tue, 21 Sep 2021 13:36:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=74OhYUyeQYysi/TzRlJJ051fes4I/adprkYFLTi5Sdw=;
        b=PEmfxGR2vC8ZC//3Nsi+rcK3BDGVjQ5PsAGM8SXIOSTFHICk/mYSSm1AhKiF4TT6Af
         lQJC7k1N0M0/21F2B0AALtYvqAOHuXobowoqJd5Gyuv7RY/7qCmGqGb6qIxPSBr7/w6Z
         CtZkKhhda9IkfLRqBn3UStMzhyyN36XnvVq+tap6IV0S70jzvmdKp5MFmmulXAhsajUS
         RGmnwGIlm2Od90d5jfSW1Lxtgns8Nmz3MgeHxfGDBIbhtOqx+c8bZQsCByQVJN6dL9LC
         hljnPzT603bTMxXUFI7bRAn9faQSt1hOeZa5vImId2i2xkgdN180soT1tCJzRWF0zoda
         /n3Q==
X-Gm-Message-State: AOAM533+rgVFv0H6GC48HHIqCrAYOogW8R0eSoUugwNjvXxJtaV6+WWE
        7EstX4+mT2iee6DWVDdxNQ==
X-Google-Smtp-Source: ABdhPJzpj/fzNJ7BMj74jnTQOWdAXExqWcupsGQA5m5n6ary5zeQWefviZyc6aAk8QOZVNYAsL3+Tg==
X-Received: by 2002:a05:6808:1481:: with SMTP id e1mr5210840oiw.5.1632256605224;
        Tue, 21 Sep 2021 13:36:45 -0700 (PDT)
Received: from robh.at.kernel.org (rrcs-192-154-179-36.sw.biz.rr.com. [192.154.179.36])
        by smtp.gmail.com with ESMTPSA id v19sm16599oic.31.2021.09.21.13.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 13:36:44 -0700 (PDT)
Received: (nullmailer pid 3285894 invoked by uid 1000);
        Tue, 21 Sep 2021 20:36:42 -0000
Date:   Tue, 21 Sep 2021 15:36:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Ikjoon Jang <ikjn@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, youlin.pei@mediatek.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, yi.kuo@mediatek.com,
        anan.sun@mediatek.com, Tomasz Figa <tfiga@chromium.org>,
        ming-fan.chen@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
        anthony.huang@mediatek.com, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v4 02/13] dt-bindings: memory: mediatek: Add mt8195 smi
 sub common
Message-ID: <YUpCWib8Tpf0wfif@robh.at.kernel.org>
References: <20210914113703.31466-1-yong.wu@mediatek.com>
 <20210914113703.31466-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914113703.31466-3-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2021 19:36:52 +0800, Yong Wu wrote:
> Add the binding for smi-sub-common. The SMI block diagram like this:
> 
>         IOMMU
>          |  |
>       smi-common
>   ------------------
>   |      ....      |
>  larb0           larb7   <-max is 8
> 
> The smi-common connects with smi-larb and IOMMU. The maximum larbs number
> that connects with a smi-common is 8. If the engines number is over 8,
> sometimes we use a smi-sub-common which is nearly same with smi-common.
> It supports up to 8 input and 1 output(smi-common has 2 output)
> 
> Something like:
> 
>         IOMMU
>          |  |
>       smi-common
>   ---------------------
>   |      |          ...
> larb0  sub-common   ...   <-max is 8
>       -----------
>        |    |    ...   <-max is 8 too.
>      larb2 larb5
> 
> We don't need extra SW setting for smi-sub-common, only the sub-common has
> special clocks need to enable when the engines access dram.
> 
> If it is sub-common, it should have a "mediatek,smi" phandle to point to
> its smi-common. meanwhile the sub-common only has one gals clock.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> change note: add "else mediatek,smi: false".
> ---
>  .../mediatek,smi-common.yaml                  | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
