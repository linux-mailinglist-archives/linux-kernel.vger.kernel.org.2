Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58BF314265
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 22:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbhBHV4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 16:56:06 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:41002 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbhBHV4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 16:56:00 -0500
Received: by mail-ot1-f46.google.com with SMTP id s107so15615438otb.8;
        Mon, 08 Feb 2021 13:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eqlb8C0ETOy8SvYjIiHc1NLlXDk6F0aQYo/gB9v56Ho=;
        b=SHX38zG6p+tiPRvtNbC+icHT6LOC/GVuBOpKInsso7QYj/hoLaDc/ZcxOKydEJxQyf
         ZLKa5dnUyOx1RmH4UFD374LrhN58c7K4Lpc47WL8IxlmJnvM6Qi+eFXIAcTDFEc3VG4p
         b+e/FkRf0sDL8oP2hCLnhfkKVT+7MK4gxxmqmhkuNfABQ/P+GFT/cNZZ/lI65dKSnjiI
         nfxs/24sSkDJV4sdy8w9/Znm+4yy7phDhJ4MjPtRBmKU7OeWJ2rBHqQYgF9n9q81Kovz
         0V+dI+QQTXcAs5rvIIRWkLXmnSzsmrd00kCdDbvjkxF1Zm39qw3BJuXq6rVktwhMrmaW
         P8GA==
X-Gm-Message-State: AOAM530EWubpk3/bDiDkL4p9ooB3Jo4ou3LW6esHgzWoaK6wzvh4v6F8
        sRwHd3vF/PCmNGV3WB8B7Q==
X-Google-Smtp-Source: ABdhPJy+1GSfNEePnj5f9FpSkMeneRbLS+/hOm1zO1Clyf8W5YTWYvvJRQSNZbhhoca9Gmc9USaCMQ==
X-Received: by 2002:a9d:701c:: with SMTP id k28mr4166128otj.79.1612821319407;
        Mon, 08 Feb 2021 13:55:19 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z8sm3801754oon.10.2021.02.08.13.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 13:55:18 -0800 (PST)
Received: (nullmailer pid 2090093 invoked by uid 1000);
        Mon, 08 Feb 2021 21:55:17 -0000
Date:   Mon, 8 Feb 2021 15:55:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Min Guo <min.guo@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH next 06/15] dt-bindings: usb: mtk-xhci: add support
 mt2701 and mt7623
Message-ID: <20210208215517.GA2090042@robh.at.kernel.org>
References: <20210116090656.11752-1-chunfeng.yun@mediatek.com>
 <20210116090656.11752-6-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116090656.11752-6-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Jan 2021 17:06:47 +0800, Chunfeng Yun wrote:
> Add two compatible for mt2701 and mt7623;
> add property "assigned-clock" and "assigned-clock-parents"
> used by mt7629.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml     | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
