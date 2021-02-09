Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EAFD315B13
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhBJAYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:24:55 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:41472 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbhBIUuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:50:15 -0500
Received: by mail-ot1-f49.google.com with SMTP id s107so18743239otb.8;
        Tue, 09 Feb 2021 12:49:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/W1Gn4hxQtNB99JBDiBpqMrtEUA7Z2tTBFo11od6Dq0=;
        b=e0wjo6JbWO5w7RpB2Cp7t80sFbYZvnl3QN41i9wqoCCsgPObGi9+7PRU5WvLskivBa
         QzmrD/dE+4+hXUFmlSdiushUxmm8KbFbbCqUHBrokF9ms9j/7Ef+u8dLGan5jaVqENvY
         ggaSfI8xrANBuzTx1meOXCTIJqHmH55gybHIZ/nCuEQhWeKPwMoDJqPnNync0/HZGBJH
         4FruLVDTSEoPFw+dggEN5sk6eQqOeJSmT6eYEbhPptmWBpGcLHW7opU/L+adI3zQAeQv
         7WN022zhREcibtlbhbg0uyAg3UjYcjKZ/ZM3aWcEt+LM8nv16hsgbfChIPegWfp5n5Ki
         Es4A==
X-Gm-Message-State: AOAM530Ld87GckTcFMNIEDL9b+peUWdntJbqKKonjaT2wYvTul4uE82/
        Ta94Au7nybyc12EUNxx9/A==
X-Google-Smtp-Source: ABdhPJyPT+UqiQpXCouB4drib6QDW/Lva0rnlvUnEysuBk1EhC8ytPiq8quZZkYVCOhE67HMCZ96EA==
X-Received: by 2002:a05:6830:2316:: with SMTP id u22mr4610464ote.324.1612903773115;
        Tue, 09 Feb 2021 12:49:33 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a63sm4594300otc.75.2021.02.09.12.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:49:32 -0800 (PST)
Received: (nullmailer pid 152989 invoked by uid 1000);
        Tue, 09 Feb 2021 20:49:30 -0000
Date:   Tue, 9 Feb 2021 14:49:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Min Guo <min.guo@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH next v3 06/16] dt-bindings: usb: mtk-xhci: add optional
 assigned clock properties
Message-ID: <20210209204930.GA152956@robh.at.kernel.org>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
 <20210201070016.41721-6-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201070016.41721-6-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021 15:00:06 +0800, Chunfeng Yun wrote:
> Add optional property "assigned-clock" and "assigned-clock-parents"
> used by mt7629.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v3: no changes
> v2: separate compatible out of the patch
> ---
>  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml        | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
