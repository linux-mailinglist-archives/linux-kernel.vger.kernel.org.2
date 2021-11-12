Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCFA44EF86
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 23:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbhKLWoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 17:44:54 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:41760 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhKLWow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:44:52 -0500
Received: by mail-oo1-f51.google.com with SMTP id a11-20020a4ad1cb000000b002c2657270a0so3397156oos.8;
        Fri, 12 Nov 2021 14:42:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5bCqd7sIMFGA5KFCBzhnXm+TAVQSLDZFleUsssSJUQs=;
        b=EqlpTN3DN6MxhIQWQ2k63bbQzHETSK0dva/Dw7i+6NwWMbBUV3gksdA0B+OBd25Pqm
         1CqUM5cgbrrcK712AzgAm+aQ/qHi04FiCj5L1sWmgV8heciSDmcJMkTqho4u+EF0JaJG
         d/xrIfTX4U5P2TQyFPHrcbTsvXtRdypMab8ZLd8+xgA5EZCx9y/sEPwSikusTpIO62dL
         IcQn12FzCCzYlS6YnFRwu5D4+95ymPGKsKR3DnDho2mfZjPH4hNMAipJiG6ScNgZirsa
         7xjb0HtrDu6rvrUz77gcee2ng6Hqp0K8A30itgf0Wyq28fRE+e97eosKshXqd5/1yAng
         ia2g==
X-Gm-Message-State: AOAM5333c860g+i+gFWqEetOl6H6kRz7CoFDLG3W3msYHeVW9TtsGY9I
        52ke6fNJbzQI+vLfb4ecBGdqTiBA1A==
X-Google-Smtp-Source: ABdhPJwj7xNclVwnawiBK0OBO6kEdrva2JPF0+s/zDJlVUjRW9F1boBX09kJBKF/3ZTGyPW4h0MVEA==
X-Received: by 2002:a4a:6342:: with SMTP id r2mr10458399oof.54.1636756921106;
        Fri, 12 Nov 2021 14:42:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a13sm1591533oiy.9.2021.11.12.14.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:42:00 -0800 (PST)
Received: (nullmailer pid 3509395 invoked by uid 1000);
        Fri, 12 Nov 2021 22:41:59 -0000
Date:   Fri, 12 Nov 2021 16:41:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, Yz Wu <yz.wu@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Subject: Re: [PATCH 2/6] dt-bindings: nvmem: mediatek: add support for mt8195
Message-ID: <YY7tt9k/pnTuqno9@robh.at.kernel.org>
References: <20211107075646.4366-1-chunfeng.yun@mediatek.com>
 <20211107075646.4366-2-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107075646.4366-2-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Nov 2021 15:56:42 +0800, Chunfeng Yun wrote:
> Add compatible for mt8195
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
