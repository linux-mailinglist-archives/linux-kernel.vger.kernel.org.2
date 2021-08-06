Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D633E306A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245021AbhHFUh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:37:57 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:37597 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245005AbhHFUhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:37:55 -0400
Received: by mail-io1-f48.google.com with SMTP id l20so11660280iom.4;
        Fri, 06 Aug 2021 13:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TVKXYieXCB1DKiHzXxHGsFLtK6oj4KnoWI2F5Iz4p4M=;
        b=nqO9S0lcE+cYxKtyBPVspHSJd1joB7YVE1S32akblUP0FPXvVLYyV3jAWZ3muiWXyW
         2J40hvmZ3jxAUgA/cKyLEzbvG1LfdC24SKjsD2UINtlNL4+8kLVQ5ANOozCkZyq5jpj6
         7fGoTvxC7EdNQ0imEirsNVqK0kK6OMP3gGJ5lsNvErr5fVqNrX6fohqd3wNsfOMek6vI
         Nycu6vONU3b6vjSdGpQDrotVJO7hWUUQTGJBEfqpHZIfkNEN6IdRC+fJwQNXNKZIASIl
         W35wdvVL0ID6gPk0VL0l6Ncn2Q9Q9A9j5mdHCkA7eSglqFHcHYmfwoKlRdJf5NQZTKmv
         CyaQ==
X-Gm-Message-State: AOAM532wAeUx6Hwj7vs5gZacWDxuduFml8I5twtPO0Vs+UO3i/S3IclG
        4sAY9N1Js5uhDq/V95dpNw==
X-Google-Smtp-Source: ABdhPJxZCOZE9OxcqkC1fCzq3EI+rcQGE5VzKj6Tdg7VFwKzvA8LJ/8AIBSVEFv+o1tKeKa0bdflOA==
X-Received: by 2002:a6b:db03:: with SMTP id t3mr684509ioc.3.1628282258694;
        Fri, 06 Aug 2021 13:37:38 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u6sm5050320ilk.36.2021.08.06.13.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:37:38 -0700 (PDT)
Received: (nullmailer pid 1753643 invoked by uid 1000);
        Fri, 06 Aug 2021 20:37:37 -0000
Date:   Fri, 6 Aug 2021 14:37:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH 01/11] dt-bindings: usb: mtk-xhci: add support property
 'tpl-support'
Message-ID: <YQ2dkcKiXxIHLCOT@robh.at.kernel.org>
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 04:49:52PM +0800, Chunfeng Yun wrote:
> Add property 'tpl-support' to support targeted peripheral list
> for USB-IF Embedded Host Compliance Test

Given you have to configure the TPL somehow, how is this useful to be in 
DT? And no, that's not a suggestion to put all the TPL config into DT.

> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> index 240882b12565..49729aab6d1a 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> @@ -115,6 +115,8 @@ properties:
>  
>    usb2-lpm-disable: true
>  
> +  tpl-support: true
> +
>    imod-interval-ns:
>      description:
>        Interrupt moderation interval value, it is 8 times as much as that
> -- 
> 2.18.0
> 
> 
