Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B7D315B10
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbhBJAXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:23:40 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:46690 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234075AbhBIUv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:51:57 -0500
Received: by mail-ot1-f51.google.com with SMTP id r21so10275490otk.13;
        Tue, 09 Feb 2021 12:51:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8m1+OgRyr53v1HGSskPz0Nyj8c/qtTFjxOdWIMe9bVw=;
        b=pyAnk1K3JZUWvyintPxJDfNBhb1nBmzfcQFFB9BLMLNbcjzycREjcF3B1N/Q4YMFp1
         MAz/htsoEcDBqeBibhWn/mejJoIfx9jkJraadthHBq2rbRI+uuxuO7WrkIQzNB5zHnZ/
         hq3KbDA+nQ9eIahV6rNAQPwv/+6e+9YNyEXeuhN3djeRNgBWY3rCs2frCRM754AP7rIs
         +x79eMR79HvyA/qRqe6li6JXhAYABD3gRjdYwRrlmYEd/FqpUZ1F5MN/frS1GM2ZWX85
         h30vdoOoVctbZ0ZXebx4+4VQCCHx2pbR+jG9oMFvlX+1P+W8xkd8zXWOXWBoWf/9clXQ
         7ppw==
X-Gm-Message-State: AOAM533X4pu76dOQj4OUVV5ZK0VUrSrzRifTHDTQqnaQYGw9vEJzpcME
        Bgi9YKZwrKbHWHWfPEdfvg==
X-Google-Smtp-Source: ABdhPJzBwihGqDNgY5q95zRe7VNuHJ4OLfOa1P8N6a/5hKGLICUgZC2r6d6cjGp3m+YcW9Yie4SS6A==
X-Received: by 2002:a05:6830:1e8b:: with SMTP id n11mr17405462otr.360.1612903876064;
        Tue, 09 Feb 2021 12:51:16 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id b7sm4526303oib.53.2021.02.09.12.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:51:14 -0800 (PST)
Received: (nullmailer pid 156352 invoked by uid 1000);
        Tue, 09 Feb 2021 20:51:13 -0000
Date:   Tue, 9 Feb 2021 14:51:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, linux-kernel@vger.kernel.org,
        Min Guo <min.guo@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: Re: [PATCH next v3 08/16] dt-bindings: usb: mediatek: musb: add
 mt8516 compatbile
Message-ID: <20210209205113.GA156297@robh.at.kernel.org>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
 <20210201070016.41721-8-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201070016.41721-8-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Feb 2021 15:00:08 +0800, Chunfeng Yun wrote:
> Add support mt8516 compatbile
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2~v3: no changes
> ---
>  Documentation/devicetree/bindings/usb/mediatek,musb.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
