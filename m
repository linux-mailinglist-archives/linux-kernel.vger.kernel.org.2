Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FE334B879
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 18:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhC0RYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 13:24:49 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:35330 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhC0RYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 13:24:43 -0400
Received: by mail-ot1-f41.google.com with SMTP id v24-20020a9d69d80000b02901b9aec33371so8283176oto.2;
        Sat, 27 Mar 2021 10:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9KcE+QgrUuQXuE2OHRMrLAz8ThBgbzr+7gew1p6Sfs8=;
        b=nFRA/0tYeOsTg7ikogILh4dsb18RZUUmAREEP+THkN80cjLiXeqDRi3q/YWamJOM7f
         Mzzx15kizGIob0Iqn69ejIZYYu63YgZxfnRRr6jAeL/njBZfYgGo1Uz9ab+5UH0pgfK5
         r16y8Rrt2vNoom5JfAUbeFrflEjBhYE5vL1v3csYni9ZCMsmguzfiUMqENW15/RTGhCx
         95gDGI/u6SRnX5ZzS2FR0ZPqtZIRr6WRropALb0dbCzMG8Vw+ZZ+wRBdzagHPMYUi9M1
         kVjXHoppcYEoafFURfQ6o8tO39JKJS2A8Ul6MZ7YQurY16O8isltynjPsTIX13bQrVxd
         T+0A==
X-Gm-Message-State: AOAM532DQGP5xukxG/GdPd6utm0kNmAJIWpv1j3DhlhwgwKUADPZ989H
        Xbepr8L5uEW8D4960xTcFA==
X-Google-Smtp-Source: ABdhPJxmOLqcGKblP3FioISsj/PKoEKfEHBIhelUfWzhfJ4Qr92xjql0UTWYq8up9UX9BBsep6mh5g==
X-Received: by 2002:a9d:2628:: with SMTP id a37mr16901446otb.366.1616865882565;
        Sat, 27 Mar 2021 10:24:42 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.107.88])
        by smtp.gmail.com with ESMTPSA id r10sm2997394ots.33.2021.03.27.10.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 10:24:41 -0700 (PDT)
Received: (nullmailer pid 275943 invoked by uid 1000);
        Sat, 27 Mar 2021 17:24:38 -0000
Date:   Sat, 27 Mar 2021 11:24:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>
Subject: Re: [PATCH v2 01/13] dt-bindings: usb: mtk-xhci: support property
 usb2-lpm-disable
Message-ID: <20210327172438.GA268453@robh.at.kernel.org>
References: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 03:02:43PM +0800, Chunfeng Yun wrote:
> Add support common property usb2-lpm-disable
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: no changes
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> index 14f40efb3b22..2246d29a5e4e 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml
> @@ -103,6 +103,10 @@ properties:
>      description: supports USB3.0 LPM
>      type: boolean
>  
> +  usb2-lpm-disable:
> +    description: disable USB2 HW LPM
> +    type: boolean

Already has a type. Don't redefine here. Just 'usb2-lpm-disable: true' 
and make sure usb-xhci.yaml is referenced.

> +
>    imod-interval-ns:
>      description:
>        Interrupt moderation interval value, it is 8 times as much as that
> -- 
> 2.18.0
> 
