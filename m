Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A363EBD9F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 22:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbhHMUtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 16:49:40 -0400
Received: from mail-ot1-f44.google.com ([209.85.210.44]:34721 "EHLO
        mail-ot1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbhHMUta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 16:49:30 -0400
Received: by mail-ot1-f44.google.com with SMTP id e13-20020a9d63cd0000b02904fa42f9d275so13584665otl.1;
        Fri, 13 Aug 2021 13:49:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WR7uDjxrUVN4AooG1rp4oYurHuq5CzCbP2cCx2Yn0Hk=;
        b=JgM9VFvXNw9xerXETWRiornXxL+Pq1juhJxHm/VBOufoQAuCalMPFW+wvd+tYdeJaH
         Y/Owe41wY8U4swIugKK82FKprLYARqXD6ND2WkSGiK/Xlm/GqA5sy7YJgfpTVTCL9PAR
         QrHl5tlti5Ml6h349gQiLzSBeBF3PlwdilqcT3mMVP3MGutkRfrdkkf/wKcHrbCcMVrw
         85UcZMWVPJDO7L9aE4t1Hw6dmmDE+3GKPUPixz3Q8OGG2fqC6qJMRFLfU/NKuSrw19Ju
         R7xLvx6V1Rb8CXkB6wE1WmgXGLIDRmlMQ98r9rZWmEfNHofqLubYfKLgR2kOQUiTGvMR
         h3IA==
X-Gm-Message-State: AOAM531I7KbmU+JkH35DY1gIoBzRlT9cqM0Z3jtVXXtfUNxcbnSKihBL
        wOG1JyzWNypZI2XjHZTEYQ==
X-Google-Smtp-Source: ABdhPJzirUAytpaW6TgtFI+xKQCEZxnjH4itq90oLrts13DOK4jbtJNqsXwk/BKu/fMKi22SIxnwhw==
X-Received: by 2002:a9d:2782:: with SMTP id c2mr3604968otb.323.1628887743001;
        Fri, 13 Aug 2021 13:49:03 -0700 (PDT)
Received: from robh.at.kernel.org (2603-8080-2a06-ed00-7254-0b80-dd3c-00c6.res6.spectrum.com. [2603:8080:2a06:ed00:7254:b80:dd3c:c6])
        by smtp.gmail.com with ESMTPSA id m16sm482172oop.3.2021.08.13.13.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 13:49:02 -0700 (PDT)
Received: (nullmailer pid 4005715 invoked by uid 1000);
        Fri, 13 Aug 2021 20:49:00 -0000
Date:   Fri, 13 Aug 2021 15:49:00 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sungbo Eo <mans0n@gorani.run>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mediatek@lists.infradead.org, Min Guo <min.guo@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: mtk-musb: add MT7623 compatible
Message-ID: <YRbavByuh2HGnVo7@robh.at.kernel.org>
References: <20210803151320.71531-1-mans0n@gorani.run>
 <20210808123840.176738-1-mans0n@gorani.run>
 <20210808123840.176738-2-mans0n@gorani.run>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210808123840.176738-2-mans0n@gorani.run>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 08 Aug 2021 21:38:39 +0900, Sungbo Eo wrote:
> Document MT7623 compatible for mtk-musb.
> 
> Signed-off-by: Sungbo Eo <mans0n@gorani.run>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
> v2:
> * add reviewed by Matthias
> ---
>  Documentation/devicetree/bindings/usb/mediatek,musb.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
