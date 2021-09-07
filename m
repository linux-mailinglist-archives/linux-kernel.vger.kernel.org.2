Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA03402EB0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 21:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345332AbhIGTFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 15:05:03 -0400
Received: from mail-oi1-f181.google.com ([209.85.167.181]:39508 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhIGTFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 15:05:02 -0400
Received: by mail-oi1-f181.google.com with SMTP id v2so193568oie.6;
        Tue, 07 Sep 2021 12:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UdQQQExBHiPR6qIP5oY8gqjMFJjYP3y1rT1TQorSqZY=;
        b=fm5IarekAL853qff3sJvBVgAWZzAe1s3Yw8xn49xkza06eTPTQvaLCvTuZY75kmIxb
         7Jq4LyL/BJjN9TByE5AqQyMhJ5ubZoAvRKpUxeI0BsprkxB/ExLww265JKeTEW0MQjkv
         WnEgVw3IkjgseRXeKTa+WB4OeITC1P0Sk2x6Aot5ND8Zno+fydgCiI+WVn0mvjRUYW6T
         vtogIlR9lUBKIdfxG/ithSiGhv7er/EYs8T/UNKds73Owf/uh5wy3AO4PaC9ts0M6J9O
         QiyjoLubQ2K3Nu+sO7V46pn+kF7B69tB9GAszBbuMlKSqMKQzYUGS2T+sfQyDSYt1U7+
         2d2Q==
X-Gm-Message-State: AOAM531uIzofrpL0T8QvjTnx/Td4VCDfHR6urD/nnIEsVAYLs3lJ6df/
        YQ7gwxxJs/Z9+3FnbY8ELg==
X-Google-Smtp-Source: ABdhPJyuZ8CDEvv85V5xxEoQU6PojBqj9F3XU3VxctkZMnSq2K+26cFrvDhXC+jeh8QmrJJjPBgWSw==
X-Received: by 2002:aca:be56:: with SMTP id o83mr4090913oif.51.1631041435623;
        Tue, 07 Sep 2021 12:03:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m16sm2379853oop.3.2021.09.07.12.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 12:03:54 -0700 (PDT)
Received: (nullmailer pid 165371 invoked by uid 1000);
        Tue, 07 Sep 2021 19:03:53 -0000
Date:   Tue, 7 Sep 2021 14:03:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Nikhil Devshatwar <nikhil.nd@ti.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v5 6/6] phy: dt-bindings: cdns,dphy: add Rx DPHY
 compatible
Message-ID: <YTe3mUFPhkI910AG@robh.at.kernel.org>
References: <20210902185543.18875-1-p.yadav@ti.com>
 <20210902185543.18875-7-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902185543.18875-7-p.yadav@ti.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Sep 2021 00:25:43 +0530, Pratyush Yadav wrote:
> The DPHY is treated to be in Tx mode by default. Add a new compatible
> for Rx mode DPHYs.
> 
> Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 
> ---
> 
> Changes in v5:
> - Use enum instead.
> - Add Laurent's R-by.
> 
> Changes in v4:
> - New in v4.
> 
>  Documentation/devicetree/bindings/phy/cdns,dphy.yaml | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
