Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D7336280B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 20:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhDPSxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 14:53:33 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:39719 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbhDPSx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:53:29 -0400
Received: by mail-oi1-f182.google.com with SMTP id i81so28843677oif.6;
        Fri, 16 Apr 2021 11:53:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bo317WIkFn1/Wn1GxMx0UU8JsonrX+yYrMt9jYM5jl4=;
        b=PL9bOK1xrMO1Q3EP3VdcsdewmAZoBBKLJtN8DwZ5ebg098qVQVjzpK76AFvzQjiU8+
         x4lQEZIaT9CaHwoo9qOvYYD7Mb7dX2VYLe6esjwlQ4y6v2z+FGRUkA3p1N/VF4Di5s5o
         iDruYVpbYJvb2opl49U3LvdMapDu1rqZZJAAcXe7BnvmOSZKBoJg4DxLasw9C6gnFmw0
         +axwdbjBd+MBTRXi2PRa9Bcr3cEX0aI9MB9Wbl+Xb6v48Jpe1WW//JCAcPKilyxdNA0F
         awUcbFD/S3FPvpc8PLLe9B3DhIdnWvKik1k4TNBhrKWzra7VSSdbGh5a3doMC2kdkww9
         cqog==
X-Gm-Message-State: AOAM530xRuQEEy20FhfVChdTbFignSO5E2KVSFCLa1IrmBYokDvfuGj5
        hnD2b/uynY/rH6CoT3ctPg==
X-Google-Smtp-Source: ABdhPJwV/QSxYl/xWKLHE2sSkjYKOeWI050rZiPSwPhXZYb8RB1IsWPwyyh33QU5h7/MmnBvjGIKmg==
X-Received: by 2002:aca:e003:: with SMTP id x3mr1658067oig.118.1618599184525;
        Fri, 16 Apr 2021 11:53:04 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t6sm395376ood.41.2021.04.16.11.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 11:53:02 -0700 (PDT)
Received: (nullmailer pid 3747499 invoked by uid 1000);
        Fri, 16 Apr 2021 18:53:01 -0000
Date:   Fri, 16 Apr 2021 13:53:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        enric.balletbo@collabora.com, heiko@sntech.de, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhangqing@rock-chips.com
Subject: Re: [PATCH v8 14/15] dt-bindings: power: rockchip: Add bindings for
 RK3568 Soc
Message-ID: <20210416185301.GA3747214@robh.at.kernel.org>
References: <20210416080342.18614-1-jbx6244@gmail.com>
 <20210416080342.18614-15-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416080342.18614-15-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2021 10:03:41 +0200, Johan Jonker wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> Add the compatible string for RK3568 SoC.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> A note for rob+dt and others:
>   A review and ack tag was not added, because in this version
>   the schema layout changed a bit
> Please have a look at it again
> 
> Changed V8:
>   Add pd-node ref schema
> ---
>  Documentation/devicetree/bindings/power/rockchip,power-controller.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
