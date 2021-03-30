Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CD034F3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 23:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbhC3V70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 17:59:26 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:37824 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhC3V7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 17:59:24 -0400
Received: by mail-ot1-f45.google.com with SMTP id t23-20020a0568301e37b02901b65ab30024so17043905otr.4;
        Tue, 30 Mar 2021 14:59:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QieyNEvpATRQqrk3pzzamwRfJpDFYjRn5x3pSxJMeDg=;
        b=JJej0mdTdpK6DmBOygnK6EoPylXc0tCOA9KxikmERqcKrpWyFhrnunrAh25P+XF0wD
         Ugs8a0qQHNKnbI4apj4RLaopcJuC7jOYotiMYD/jzoAzeLVm7g5P+xN+gNGdnPcCDJyN
         JpMHaAVkYAdKXkYE6EnQyg/pPO36oPGmxe79HCa7Tks5QomTQ/9m2BTfHX6TQr/hfunf
         NfLadg0v14mVOmnbVloV/Y7p7bBwFn1Ueez3A2jFlfXynHM877a9asTvKCiOhu/9qqm2
         Lnwz40rbo6tAekWErRye+D2VXiRP7S/Lrs/1W08r1iKg9o0Yb1AKnmbGrhmEGzYRP3GF
         YdfQ==
X-Gm-Message-State: AOAM5305Oq5Zd/mcmBqVGhs929LlogICOOiEmlBtNFHg+gSo6UazeVj4
        oO5yiq5YKMYaa0AH3IxZJw==
X-Google-Smtp-Source: ABdhPJxNnYNc5QIo0AGcTFwJPNfo+tKzVjw+K5c5RB6VuiBXfpDyPZXU2H+w2KfsXKqzkCYrym5VIQ==
X-Received: by 2002:a9d:d05:: with SMTP id 5mr42299oti.312.1617141563417;
        Tue, 30 Mar 2021 14:59:23 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i4sm22832otj.56.2021.03.30.14.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 14:59:23 -0700 (PDT)
Received: (nullmailer pid 788345 invoked by uid 1000);
        Tue, 30 Mar 2021 21:59:22 -0000
Date:   Tue, 30 Mar 2021 16:59:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-mediatek@lists.infradead.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 1/4] dt-bindings: usb: mtk-xhci: support property
 usb2-lpm-disable
Message-ID: <20210330215922.GA788298@robh.at.kernel.org>
References: <1617002411-9015-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617002411-9015-1-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Mar 2021 15:20:08 +0800, Chunfeng Yun wrote:
> Add support common property usb2-lpm-disable
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v3: remove redefinition of type and description suggested by Rob
> v2: no changes
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
