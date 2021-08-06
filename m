Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 327EA3E3072
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 22:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245070AbhHFUlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 16:41:36 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:37818 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbhHFUla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 16:41:30 -0400
Received: by mail-io1-f51.google.com with SMTP id l20so11679579iom.4;
        Fri, 06 Aug 2021 13:41:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UvvQPmrhuL4HtRndu0q71cWkxEo1zKJex15ocyueGJ0=;
        b=jCa84p1kkPBeN+5Ts5/jZ7tnQTVshyUTay0F5l8fB5Nm3XimBTw0E6a0JpUzuZXyyi
         nuJxZLdmieRZVv40ZsvayhgQ6csy+NT/AyStfA5iG3omdBtZL7ET14Ha6YQOHLmaIm59
         yJsgIsC/b6Mcyo1PNqCj1sungR3mpeUBXSjOjyM9BjwdwV8hTVqp0ZkZsqSjhNE7AU1I
         cMokvB9t4vAJcGvxgSRKSrkRIJDDeg01c+/E6kVfEF6RKb83XLnALjNvyLqM5xBDxXt8
         ES9RPxC+CgLGC99INQEXL6vo8nEBYHGUZjXk5i/6BufSKbMGgStyWFeccEyGB3bzWPGA
         OUww==
X-Gm-Message-State: AOAM533dYwxdq/Tl+c+48zLn2F2yqDsN6m9WWQR/yTN5jqI7BIyiHhHE
        Cfu0h/DK3Sy8qQIYEMzzXA==
X-Google-Smtp-Source: ABdhPJwtqAZpNSn8OeittrKtjsRZ9QEoOqX40BY44WtTvTgx9ajtlTLzXu/rOuwjY4Jw3gN+OtbSow==
X-Received: by 2002:a92:cd41:: with SMTP id v1mr15140ilq.212.1628282472733;
        Fri, 06 Aug 2021 13:41:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id s8sm5415957ilt.1.2021.08.06.13.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 13:41:12 -0700 (PDT)
Received: (nullmailer pid 1759128 invoked by uid 1000);
        Fri, 06 Aug 2021 20:41:10 -0000
Date:   Fri, 6 Aug 2021 14:41:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH 02/11] dt-bindings: usb: mtk-xhci: add optional property
 to disable usb2 ports
Message-ID: <YQ2eZkqb++K3K5NN@robh.at.kernel.org>
References: <1627635002-24521-1-git-send-email-chunfeng.yun@mediatek.com>
 <1627635002-24521-2-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1627635002-24521-2-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 30, 2021 at 04:49:53PM +0800, Chunfeng Yun wrote:
> Add support to disable specific usb2 host ports, it's useful when
> a usb2 port is disabled on some platforms, but enabled on others for
> the same SoC, another case is that the different package may support
> different number of ports.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> index 49729aab6d1a..61a0e550b5d6 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> @@ -154,6 +154,11 @@ properties:
>      description: The mask to disable u3ports, bit0 for u3port0,
>        bit1 for u3port1, ... etc
>  
> +  mediatek,u2p-dis-msk:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The mask to disable u2ports, bit0 for u2port0,
> +      bit1 for u2port1, ... etc

You already have this property in the parent node, right? Why are we 
duplicating it in both places?

Rob
