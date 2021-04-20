Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7722365BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 17:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhDTPGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 11:06:20 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:45710 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbhDTPGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 11:06:17 -0400
Received: by mail-oi1-f173.google.com with SMTP id n184so13214405oia.12;
        Tue, 20 Apr 2021 08:05:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aHuLvQqopShusp+Waua9JzWi2y+R0TxyWbIgHg3wkjM=;
        b=IVi0IOGL55iiqj5FbrlKCd30Yh6eYgmD6QMVdXtq1nqOENz46rjsPZ9sNm+oAahhNs
         oUSF61pYJgQLGcaeBSe2cjTT4H7uqvEcU6ur13cNfTI5O+vrPrg1/uMZU46oS6kNLpjG
         pLgbuufVYFW8bt7QADo1SVE2Lp8AvLlBPVcAJI9mHfPqL+noT69rJr+8T98LDFMVj2Iu
         6bps536BqvPQHn1yEN4AvXaaXO7uaKelrKD8hKlXY5X1wjtf6FLI46A6wuMKlx2nDAix
         bpi6CusJxVpKIPak/yecMBwL8BVNcSagpfphmXGoX2lsMUFMf8sKvuuaymTg4Y5Pj1LA
         Y7mA==
X-Gm-Message-State: AOAM532AaSSqx3GtJw4iz/S/i0/0c0PJIaIulj5To9A3TduQxM+aoK7f
        Ca4xvRnHhiElMX0v/eescw==
X-Google-Smtp-Source: ABdhPJylx4E1RxTqUlW7O/drJY8WtJ82nhEcNAzvr9a/xRMxuYOgAqBOm/KnxqZQwAgQlagmnftR8w==
X-Received: by 2002:aca:4dd3:: with SMTP id a202mr3396610oib.17.1618931145824;
        Tue, 20 Apr 2021 08:05:45 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d17sm4205939oth.19.2021.04.20.08.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 08:05:44 -0700 (PDT)
Received: (nullmailer pid 3327674 invoked by uid 1000);
        Tue, 20 Apr 2021 15:05:43 -0000
Date:   Tue, 20 Apr 2021 10:05:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, zhangqing@rock-chips.com,
        enric.balletbo@collabora.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 13/15] dt-bindings: power: rockchip: Convert to
 json-schema
Message-ID: <20210420150543.GA3327645@robh.at.kernel.org>
References: <20210417112952.8516-1-jbx6244@gmail.com>
 <20210417112952.8516-14-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210417112952.8516-14-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 17 Apr 2021 13:29:50 +0200, Johan Jonker wrote:
> From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> Convert the soc/rockchip/power_domain.txt binding document to
> json-schema and move to the power bindings directory.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Note for rob+dt:
> A tag was not added on purpose, because:
>   Add "rockchip," prefix to the qos compatible name
>   in example.
>   Changed maintainers.
>   Size reg description is reduced.
>   Little style changes '' to ""
>   Restyle patternProperties
> Please have a look at it again.
> 
> For some SoC nodes this patch serie generates notifications
> for undocumented "assigned-clocks" and "assigned-clock-parents"
> properties till there is consensus of what to do with it.
> ---
> Changed V9:
>   Rename definitions to $defs
>   Restyle patternProperties
> Changed V8:
>   Add pd-node ref schema
> Changed V7:
>   Fix commit message and author format
>   Changed SPDX-License-Identifier back to GPL-2.0
>   Remove "clocks", "assigned-clocks" and "assigned-clock-parents"
>   Fix indent example
> Changed V6:
>   Changed author
> Changed V5:
>   Change SPDX-License-Identifier to  GPL-2.0-only OR BSD-2-Clause
>   Remove a maintainer
>   Changed patternProperties to power-domain
>   Add "clocks", "assigned-clocks" and "assigned-clock-parents"
> Changed V4:
>   Remove new compatible string
>   Style changes '' to ""
> Changed V3:
>   Use Enric's conversion with rk3399 example
> Changed V2:
>   Convert power_domain.txt to YAML with rk3568 example
> ---
>  .../bindings/power/rockchip,power-controller.yaml  | 246 +++++++++++++++++++++
>  .../bindings/soc/rockchip/power_domain.txt         | 136 ------------
>  2 files changed, 246 insertions(+), 136 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/rockchip,power-controller.yaml
>  delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
