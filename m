Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B380333320
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 03:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbhCJC2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Mar 2021 21:28:17 -0500
Received: from mail-il1-f170.google.com ([209.85.166.170]:36609 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhCJC2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Mar 2021 21:28:15 -0500
Received: by mail-il1-f170.google.com with SMTP id g9so14122519ilc.3;
        Tue, 09 Mar 2021 18:28:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H/PbJJ+B+OfvmyZFpcyfF/sjb4tA6E0cFD7ESjMM+e0=;
        b=E124yc9puClWVoIgYcMGg/BGRueIAGEnlszL/tXvYy2M7KizwCgduTRuP9lu4FRItn
         42oCo6JbTpBn0MSgqezbSNMQONCDp4huqot15OJDM77kqdyGZYthyKHPaPR6Off0x2E2
         2Sp7fHmnhjris/1r3PqL4G6Z+GEAAebpAbqZGNedj7Fc2hEAzu6Pn9XU5hBqlF/kvDPX
         D3+FAeFQe778KspuikHaNMmxWK0iIvCeF84qdnYRqCjS6leL+y3z9OopfXdu9oDmequl
         JomNpgexuiCa79HKGdfRcKJGL5SgkvoaxGaWeRmTGVlAMGGKYrQPDlwq4qmg9ZDqN09r
         8Lcg==
X-Gm-Message-State: AOAM532PREabYSkqyE/hDib7rOz7gHor9FrGS+I9InsQVTXQYmsQrU6Q
        n3uzf2yF9rterLtIKYobuw==
X-Google-Smtp-Source: ABdhPJxaBqWxJBySm+R6hLqmNeaFC9yTJW09h+zTC0LttNCVmJdKatSxs4V8sNf0p307tRVKiggTJw==
X-Received: by 2002:a92:6510:: with SMTP id z16mr1137919ilb.88.1615343294967;
        Tue, 09 Mar 2021 18:28:14 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id j12sm8238945ila.75.2021.03.09.18.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 18:28:14 -0800 (PST)
Received: (nullmailer pid 1613968 invoked by uid 1000);
        Wed, 10 Mar 2021 02:28:11 -0000
Date:   Tue, 9 Mar 2021 19:28:11 -0700
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v4 01/12] dt-bindings: usb: fix yamllint check warning
Message-ID: <20210310022811.GA1612587@robh.at.kernel.org>
References: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308053745.25697-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 01:37:34PM +0800, Chunfeng Yun wrote:
> Fix warning: "missing starting space in comment"

What tree is this in because I don't see it.

> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2~v4: no changes
> ---
>  Documentation/devicetree/bindings/usb/usb-device.yaml | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-device.yaml b/Documentation/devicetree/bindings/usb/usb-device.yaml
> index d4c99809ee9a..b77960a7a37b 100644
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
