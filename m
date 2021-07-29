Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E333DAC70
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 22:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232707AbhG2UH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 16:07:28 -0400
Received: from mail-il1-f170.google.com ([209.85.166.170]:37732 "EHLO
        mail-il1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbhG2UH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 16:07:26 -0400
Received: by mail-il1-f170.google.com with SMTP id f8so3854755ilr.4;
        Thu, 29 Jul 2021 13:07:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AjVi3HOc38IAipi+bfXo+kMMpn3RMH+B6clxAHAb76c=;
        b=diS03Qh+JP08PNujP02dFLghxhKZctYclgD0x2OKx3p1/OvTlE6bBakdYh+7O2krBI
         b++MJZBsx+EZnKJ7dXBPgVQS1fibdN690evK0/uBGtkhiueVUpVpVAubPYf+9xIDIT96
         JSRBgDIFaEp/waS+oiWHn5mREvu7+T1Y8Zh5wykTfEkNs0BbuENoIdPWLgtQzvauixtv
         G/0dS9oeVu/8dfL1BC8hoP1b2Fe+imyR6OdzvdI+aaUtf/WbFYUQZiq+RVONbXStqDId
         ZlNVC33J0gnONjTyecLKF4s/R0hPSAo1Vk/uhvdxJe2tIALEELKeaHWpltyjutC7l1hX
         +81A==
X-Gm-Message-State: AOAM53290kCGAfmTLWuBXYkTuoQgpMm+iC8WxCg5ZK9ALge83q8+tK7H
        QAmp8Pj+NmYRRDpTDaC7qw==
X-Google-Smtp-Source: ABdhPJz76WIWBBBfztDGL8PIe0R0FGSKx3wBqv/ZmLHj4fOZfYzL+kYtnOZ4BZTXgeNN0IKjggBTQg==
X-Received: by 2002:a92:c5c2:: with SMTP id s2mr4986347ilt.180.1627589242144;
        Thu, 29 Jul 2021 13:07:22 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id p14sm2400419ilo.6.2021.07.29.13.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 13:07:21 -0700 (PDT)
Received: (nullmailer pid 797014 invoked by uid 1000);
        Thu, 29 Jul 2021 20:07:20 -0000
Date:   Thu, 29 Jul 2021 14:07:20 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH 01/15] dt-bindings: mtd: update mtd-physmap.yaml reference
Message-ID: <YQMKeA4uO/3Rs01Y@robh.at.kernel.org>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
 <ab2ff9ee66110c37691b467ec8b4679e9d426416.1626947923.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab2ff9ee66110c37691b467ec8b4679e9d426416.1626947923.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jul 2021 11:59:58 +0200, Mauro Carvalho Chehab wrote:
> Changeset 63f8e9e0ac65 ("dt-bindings: mtd: Convert mtd-physmap to DT schema")
> renamed: Documentation/devicetree/bindings/mtd/mtd-physmap.txt
> to: Documentation/devicetree/bindings/mtd/mtd-physmap.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 63f8e9e0ac65 ("dt-bindings: mtd: Convert mtd-physmap to DT schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/devicetree/bindings/mtd/gpmc-nor.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
