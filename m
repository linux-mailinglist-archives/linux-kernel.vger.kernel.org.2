Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184EC3B36F7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbhFXT2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:28:25 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:36643 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbhFXT2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:28:24 -0400
Received: by mail-io1-f53.google.com with SMTP id s19so9651869ioc.3;
        Thu, 24 Jun 2021 12:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8eJH9Kzucu1Ik6hPDZiexVBLT3UFFKRlBapPfDjYMik=;
        b=te8kMvhnhEkqWMGZIwEfvUNKg/ccz4NRGGIP2/mTrcSEea2cDUJ8ftCKKhAOUH+C+8
         XgFvsl68RBMD7po4apL8jpKqb+pwAGw1WyrfZ2rkvOsdINWgNVN6aihPtb2lpPkMG0Em
         8jh5g2lQ/1xsmVGriCKQILoNHu96qgOZHicowQMrcbt53H0DjPUvFrM0pZTxk748zE4c
         rFSoDCMnEe5purG8LD3EJJDHIcvJOYDoAfhkqnIgk1sM0Q6xC78XZz9MjZhqiMkD6cEa
         ChSHyiWfF9hxUIHBaKDKUFob3xMojD4XWBLzr7TOl4L6ngrbSuhEG8uBOmNTIRz5u/sD
         UeKQ==
X-Gm-Message-State: AOAM531VtLO4g9TtkATXD6gGubM9R1qbOiRdzxxF+aNfBicCBKzTbf23
        nUeu9TlyRa58NWNsOHk8mA==
X-Google-Smtp-Source: ABdhPJynEp8iidB0Ms4zMtG+7pm348cqKAyaVz5781K5HDDj72Nwl2G5wVst5E0aL87+JgqA7hhUsg==
X-Received: by 2002:a02:5d0a:: with SMTP id w10mr5971532jaa.82.1624562764524;
        Thu, 24 Jun 2021 12:26:04 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m2sm2225616ilf.6.2021.06.24.12.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:26:03 -0700 (PDT)
Received: (nullmailer pid 1846282 invoked by uid 1000);
        Thu, 24 Jun 2021 19:26:00 -0000
Date:   Thu, 24 Jun 2021 13:26:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     linux-mediatek@lists.infradead.org, maoguang.meng@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yong.wu@mediatek.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dt-bindings: mediatek: Add mediatek,mt8183-jpgenc
 compatible
Message-ID: <20210624192600.GA1846233@robh.at.kernel.org>
References: <20210612031853.3115482-1-hsinyi@chromium.org>
 <20210612031853.3115482-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612031853.3115482-2-hsinyi@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jun 2021 11:18:52 +0800, Hsin-Yi Wang wrote:
> Add mediatek,mt8183-jpgenc compatible to binding document.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  .../devicetree/bindings/media/mediatek-jpeg-encoder.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
