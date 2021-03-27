Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F3934B87D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 18:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhC0R0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 13:26:25 -0400
Received: from mail-oo1-f45.google.com ([209.85.161.45]:40799 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhC0R0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 13:26:07 -0400
Received: by mail-oo1-f45.google.com with SMTP id j20-20020a4ad6d40000b02901b66fe8acd6so2046098oot.7;
        Sat, 27 Mar 2021 10:26:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fH8tFDCOC308K03FzLFQnKsXtwxVkfLVBbvAS7mmuAs=;
        b=tvttJ7BKJ/NqdIM9XacM1etizXhVfDtAj3Ba4dUDzdzl680tB+V5oq9j9FMjuUKogP
         rJ+h7pVC2Hf+KOlbsIeegjEb1x7H2e7ZXmJJPxnDJxuMYEEQY4sRTf1a2fpCGd6lkk/I
         zpKcD6Ebzxn97ouFfSOo5EyfrUCqAtFGq5fQcAsqFs+HNacghDb0kV2Sj0zqZiyAxB6F
         9RtMI9yndBCmPScWOLWZe9b4TEnZpvBMSLG80UDNIHVx8rX9JWz0BXWQ9W/mJahKnmsx
         uSM+0Di2Fez1bfSsSIowy4dz76lAa3JusnFUSz8sfPQJPvAJGFLkUQxmkhLKzqANC5kK
         sm9g==
X-Gm-Message-State: AOAM533zGLBxGi5cWX6lYgUpAaVGsQeh66OR7i7hDrnyBOEvA7iIlD0R
        dEMMoxr4EeSI2hYUR89eVQ==
X-Google-Smtp-Source: ABdhPJxpFQVOG8TULBsrzj0l8Wudc/RJmkTuXOUoCC7m4aOnpwmBhQIraJ5U9iCAmR3S4cff9KiZ4g==
X-Received: by 2002:a4a:244d:: with SMTP id v13mr16117313oov.66.1616865966573;
        Sat, 27 Mar 2021 10:26:06 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.107.88])
        by smtp.gmail.com with ESMTPSA id g6sm2713086ooh.29.2021.03.27.10.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 10:26:06 -0700 (PDT)
Received: (nullmailer pid 277866 invoked by uid 1000);
        Sat, 27 Mar 2021 17:26:02 -0000
Date:   Sat, 27 Mar 2021 11:26:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-kernel@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH v2 02/13] dt-bindings: usb: mtk-xhci: add support wakeup
 for mt8183 and mt8192
Message-ID: <20210327172602.GA277819@robh.at.kernel.org>
References: <1616482975-17841-1-git-send-email-chunfeng.yun@mediatek.com>
 <1616482975-17841-2-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616482975-17841-2-git-send-email-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Mar 2021 15:02:44 +0800, Chunfeng Yun wrote:
> These two HW of wakeup don't follow MediaTek internal IPM rule,
> both use a specific way, like as early revision of mt8173.
> 
> Due to the index 2 already used by many DTS, it's better to keep
> it unchanged for backward compatibility, treat specific ones without
> following IPM rule as revision 1.x, meanwhile reserve 3~99 for
> later revisions with following the IPM rule.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: modify revision format
> ---
>  .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml     | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
