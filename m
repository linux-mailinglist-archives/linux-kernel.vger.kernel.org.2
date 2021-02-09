Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80077315B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 01:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbhBJAaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 19:30:55 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:44010 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbhBIU4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 15:56:37 -0500
Received: by mail-oi1-f174.google.com with SMTP id d20so20913908oiw.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 12:56:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ejS4tdhR52JYnnlfzFqAKVsx5ukUQHINk1u0rYP7GiQ=;
        b=KM+Ay4f23Qu80c7IOrcQctOIqI/UG6PedQtRLUZykM1yWm3i7xrMPvJyqawD5tIS+T
         AHt2hQZ2ikXvjkcq70Wrt/Qq/qLzuccdj2h3VBUfsXf8OI1kJBxArxDVgWQyOIgt10ij
         QpvhIyimU+zIKDFEtV3SA6HGZBlrdjXR4QJFP02MZhQbDB2NRM8yzdF4bt3GV9h4DVZv
         V/b/3OY5MIBWNKd6ayRJYC4DVy2ikz8jMuXPbAvDMtuegEjsck3vWtRUeqTcEKB/O88O
         Nqc3iHJI6CtM9tBLym06VtR2tNxqU8H420aYlRw5wcRV8mETpFB3Ml0+RhSz1Lab5exR
         zJSw==
X-Gm-Message-State: AOAM533VbnkbL7TA7Nn36d6o3tXVnkBOGhwhkVPQg4DmZ/f8P7P8TEwX
        Cel9AjBzqrFdfUlJU6fuN/Bu0d3joA==
X-Google-Smtp-Source: ABdhPJxm224h6yL74JlgUNi3P5/DM+vvsFo+4bNVs1RVW27YOiS70JDy8LW1+QNkLr8bInysPI1yyQ==
X-Received: by 2002:aca:f12:: with SMTP id 18mr3746528oip.106.1612903455452;
        Tue, 09 Feb 2021 12:44:15 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id c206sm208089oia.44.2021.02.09.12.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 12:44:13 -0800 (PST)
Received: (nullmailer pid 143147 invoked by uid 1000);
        Tue, 09 Feb 2021 20:44:12 -0000
Date:   Tue, 9 Feb 2021 14:44:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Min Guo <min.guo@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH next v3 01/16] dt-bindings: usb: fix yamllint check
 warning
Message-ID: <20210209204412.GA139333@robh.at.kernel.org>
References: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210201070016.41721-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 03:00:01PM +0800, Chunfeng Yun wrote:
> Fix warning: "missing starting space in comment"
> 

I'm not seeing this warning in linux-next. It may already be fixed.

> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2~v3: no changes
> ---
>  Documentation/devicetree/bindings/usb/usb-device.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-device.yaml b/Documentation/devicetree/bindings/usb/usb-device.yaml
> index 7bb25a45427d..23e76cfb2066 100644
> --- a/Documentation/devicetree/bindings/usb/usb-device.yaml
> +++ b/Documentation/devicetree/bindings/usb/usb-device.yaml
> @@ -82,9 +82,9 @@ required:
>  additionalProperties: true
>  
>  examples:
> -  #hub connected to port 1
> -  #device connected to port 2
> -  #device connected to port 3
> +  # hub connected to port 1
> +  # device connected to port 2
> +  # device connected to port 3
>    #    interface 0 of configuration 1
>    #    interface 0 of configuration 2
>    - |
> -- 
> 2.18.0
