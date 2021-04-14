Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44EE935FDC9
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 00:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhDNW20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 18:28:26 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:34587 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbhDNW2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 18:28:23 -0400
Received: by mail-ot1-f46.google.com with SMTP id k14-20020a9d7dce0000b02901b866632f29so20840485otn.1;
        Wed, 14 Apr 2021 15:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=morGz6AeVvrUIzO5wIYaVgIKsZD8zVL1TUP4w+6z6sE=;
        b=cdAJE/miosb8KneXUzihbUavLRGhJcH5TWND6fODxsFFD5q8RuPSNXeY30kCJ2CRO6
         ID9KKwx9wWKfGWW6a+ze35kjt0yZ1ikT39jxGCium9mTf9UbwqE80KjnfiXh9qn92nPq
         htnf7dZrCkjNFR9Sch0tBV/kTFzVfPqrz5hgfJvArHS2nf/5Hp2sz8Zt/J3I79/to0uv
         eftjYinxg7M91QQ9FoC5zV6xxsRmUMDf4IfDdaJfA67tCwMYtjVVCt0YN/26PjsonFrf
         2mpxAPGhFlSqmdcarccSZjlD3zcLKTvPhgE2d3xVwUTobL1HZrfO7hnCrA4znA+IftEk
         LHHA==
X-Gm-Message-State: AOAM530l9+hzItgK1XpyNAwxnCRkGS7Aw/WQW7JwkayDlBQE7wtxG/cS
        AnfNq7DD9lzvu3qocJvebA==
X-Google-Smtp-Source: ABdhPJxrtU0c9EKMuE2kgVb5yJ60Q4P4r+IPx1hYR+mmzQQRLlgL/rfFS3ceygMwRzvHHGUdMfnZwA==
X-Received: by 2002:a05:6830:1d49:: with SMTP id p9mr237738oth.300.1618439280508;
        Wed, 14 Apr 2021 15:28:00 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id j11sm194513ooo.45.2021.04.14.15.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 15:27:59 -0700 (PDT)
Received: (nullmailer pid 80432 invoked by uid 1000);
        Wed, 14 Apr 2021 22:27:59 -0000
Date:   Wed, 14 Apr 2021 17:27:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        enric.balletbo@collabora.com, linux-arm-kernel@lists.infradead.org,
        heiko@sntech.de, zhangqing@rock-chips.com
Subject: Re: [PATCH v7 10/11] dt-bindings: power: rockchip: Add bindings for
 RK3568 Soc
Message-ID: <20210414222759.GA80384@robh.at.kernel.org>
References: <20210414211856.12104-1-jbx6244@gmail.com>
 <20210414211856.12104-11-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414211856.12104-11-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021 23:18:55 +0200, Johan Jonker wrote:
> From: Elaine Zhang <zhangqing@rock-chips.com>
> 
> Add the compatible string for RK3568 SoC.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/power/rockchip,power-controller.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
