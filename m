Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF9B3172C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 22:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbhBJV7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 16:59:25 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:39908 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbhBJV7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 16:59:13 -0500
Received: by mail-ot1-f49.google.com with SMTP id d7so3322015otq.6;
        Wed, 10 Feb 2021 13:58:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uzz9hxfNfUAHoY/3tRRT+kBu3++kIrVwo6Tu0JjVTOA=;
        b=rhuD4PL9+RPWZbo3CMq2DdPFEEDwQ82RQpenRSqQPziH5RY0xUvVAepeFiCkwLZzjA
         kRN7LZTXCScD28Okqz2o4B6UvA1Kt6Wsf9ps+Y2ZLU76uypIoTlw3ELlUx1OtW+UpGOP
         NDbZ6IVv9sAegcVVRhVVb5PII9J52Cy6aV4WhPowZb58edumb8hqn93yZVyFBHoavi5a
         s1yuNUpcUNw73gHUEDgkxlfvEC7dw35jSC4Z7oai+PPtMYxhudDvmlAdaKGrJRFbDmO+
         8n9QwWHIIjxzLN/Ps2xAm8iORIWtYlSDd7W2Z8A3NMHIHv8e1gsKLk6EdGusax9jlZQ2
         Nfqw==
X-Gm-Message-State: AOAM533Upo8T4N8vPonLox7zVlLMHUgimS+91dsguPY9VnAxqoXTLI7z
        s9kRmzYwVmnnUGQw9KtfFw==
X-Google-Smtp-Source: ABdhPJxrVr6ixP0bO6YSUh9lvjgUA5Iqr/sRXpCaKJSQpamuci/ExTOUwsJzIsx7P+OBLu+LBfKdWw==
X-Received: by 2002:a9d:7997:: with SMTP id h23mr3754841otm.296.1612994312037;
        Wed, 10 Feb 2021 13:58:32 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o20sm608285oor.14.2021.02.10.13.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 13:58:31 -0800 (PST)
Received: (nullmailer pid 2868209 invoked by uid 1000);
        Wed, 10 Feb 2021 21:58:29 -0000
Date:   Wed, 10 Feb 2021 15:58:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>, linux-usb@vger.kernel.org,
        Ikjoon Jang <ikjn@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] dt-bindings: usb: mtk-xhci: add compatible
 for mt8195
Message-ID: <20210210215829.GA2868150@robh.at.kernel.org>
References: <20210203102642.7353-1-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203102642.7353-1-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Feb 2021 18:26:40 +0800, Chunfeng Yun wrote:
> There are 4 USB controllers on MT8195, the controllers (IP1~IP3,
> exclude IP0) have a wrong default SOF/ITP interval which is
> calculated from the frame counter clock 24Mhz by default, but
> in fact, the frame counter clock is 48Mhz, so we should set
> the accurate interval according to 48Mhz. Here add a new compatible
> for MT8195, it's also supported in driver. But the first controller
> (IP0) has no such issue, we prefer to use generic compatible,
> e.g. mt8192's compatible.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: no changes
> ---
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
