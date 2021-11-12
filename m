Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9448044EF84
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Nov 2021 23:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235979AbhKLWop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Nov 2021 17:44:45 -0500
Received: from mail-ot1-f48.google.com ([209.85.210.48]:41570 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbhKLWoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Nov 2021 17:44:44 -0500
Received: by mail-ot1-f48.google.com with SMTP id o15-20020a9d410f000000b0055c942cc7a0so16012373ote.8;
        Fri, 12 Nov 2021 14:41:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7sz3TOFRSclMOhQuNheMU/d1++ANZOcSK5SUiv/6PVA=;
        b=GnBa/L24C5dK5dnds6SUDI0WzTt1OuKD3REfnrCpnmDa0UhEuSDIS0DQJkQPEsfLO8
         yZd54s1yosLRgBn41Oj+OdDAT4BVC4O1rkXe8aeea61RP2HDmmUfDXzshjL3yzIQ7ZD9
         N8p3F0PbYoWDD00Q/9cC+XAXPV5QaLY3Yy3rPKN+gzP9DCoD59Yb4vHN9aZOs1aQtiHX
         2RmI/bswTxKcYkqn1e4wzovxCnhcjd8036abFW5EqxQLOySjes75qYfJgUyN2yKYmPmP
         Kg7b+5CU1JOlsLmS8FVLK3IqCCY6Y2p2DB/pwZhfHjCPdzQAFEtuUk2yr9Xh2cCPYKEk
         Hamg==
X-Gm-Message-State: AOAM531VeA3Vnh2/67yRZVxowfY+1JvOGZqoUj3P2GOpSfHkwbd/O8UB
        IzWtrTnNLl+s1wt3CJynpA==
X-Google-Smtp-Source: ABdhPJyBz7vyBfHFcHNXt6yZHSdVRM049pmejrMXMiHVLcKXJWruespk5icFKeEfqSflmThC3IazhA==
X-Received: by 2002:a9d:6405:: with SMTP id h5mr15227306otl.90.1636756913194;
        Fri, 12 Nov 2021 14:41:53 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h14sm1530253ots.22.2021.11.12.14.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:41:52 -0800 (PST)
Received: (nullmailer pid 3509128 invoked by uid 1000);
        Fri, 12 Nov 2021 22:41:51 -0000
Date:   Fri, 12 Nov 2021 16:41:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, Yz Wu <yz.wu@mediatek.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-mediatek@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Subject: Re: [PATCH 1/6] dt-bindings: nvmem: mediatek: add support bits
 property
Message-ID: <YY7tr3frW8yZTmje@robh.at.kernel.org>
References: <20211107075646.4366-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211107075646.4366-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 07 Nov 2021 15:56:41 +0800, Chunfeng Yun wrote:
> Add support bits property, will satisfy more consumers.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> Need convert mtk-efuse.txt into yaml first?
> ---
>  Documentation/devicetree/bindings/nvmem/mtk-efuse.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
