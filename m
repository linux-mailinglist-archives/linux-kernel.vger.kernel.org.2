Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36841316F37
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 19:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhBJSvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 13:51:14 -0500
Received: from mail-oi1-f173.google.com ([209.85.167.173]:35256 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbhBJSoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 13:44:17 -0500
Received: by mail-oi1-f173.google.com with SMTP id l3so3177777oii.2;
        Wed, 10 Feb 2021 10:44:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+I9yJIL4KQm5Wx44PMzjcCtAomnWnzNWkCxOGux9jys=;
        b=ivTru8WtY9FiRw8H4BBFxBgL80tf+u1z/WTIxlOs7O1H9GrAn1GWFh3V+KyDt8ow8S
         rhrWH9V+1tASISTSXNZcwRV60nHu7BzJolYHQnWMcTxxJN0V0KZfa82J+h+aQy+QbL4m
         Ydf1OxUoetiQ871NnjlqtjEVBqqpJbxecyr6pXPt2/jTRoc/GBJvKM9cBMvF22TO5Pay
         3PU4DcPrEkqptsFwsHy846J+rzcnqukfzfy9QlzjAqARlA+Dzg8VYN+Yt+2RQaRGEgIB
         4FvY7JIJb4TKhPIe3x1A0lKdSCZfvBa1Cuykd9Lg8/tdfdrAJ504snHEg/24xSqcUaDX
         Joug==
X-Gm-Message-State: AOAM533t0X40GpxoZogV60/I4VOGiGVkDqbnyJNPKSrK8CAtHugf+ZaJ
        gHVFsdSC+D4ACTUMm/zFoA==
X-Google-Smtp-Source: ABdhPJyfbAunYXL98GGmqi1N5eZneUtqnS/9idmsDqgvl9PyHkMNV568YQbcdgYoOgzKG8DJNP9Amg==
X-Received: by 2002:aca:da83:: with SMTP id r125mr214368oig.127.1612982616148;
        Wed, 10 Feb 2021 10:43:36 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v67sm545918otb.43.2021.02.10.10.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 10:43:35 -0800 (PST)
Received: (nullmailer pid 2520189 invoked by uid 1000);
        Wed, 10 Feb 2021 18:43:34 -0000
Date:   Wed, 10 Feb 2021 12:43:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     linux-rockchip@lists.infradead.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        balbi@kernel.org, linux-usb@vger.kernel.org, heiko@sntech.de
Subject: Re: [PATCH v5 1/8] dt-bindings: usb: convert rockchip,dwc3.txt to
 yaml
Message-ID: <20210210184334.GA2520125@robh.at.kernel.org>
References: <20210209192350.7130-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209192350.7130-1-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 Feb 2021 20:23:43 +0100, Johan Jonker wrote:
> In the past Rockchip dwc3 usb nodes were manually checked.
> With the conversion of snps,dwc3.yaml as common document
> we now can convert rockchip,dwc3.txt to yaml as well.
> Remove node wrapper.
> 
> Added properties for rk3399 are:
>   power-domains
>   resets
>   reset-names
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> Changed V5:
>   add select
> 
> Changed V3:
>   remove aclk_usb3_rksoc_axi_perf
>   remove aclk_usb3
> 
> Changed V2:
>   remove node wrapper
> ---
>  .../devicetree/bindings/usb/rockchip,dwc3.txt      |  56 -----------
>  .../devicetree/bindings/usb/rockchip,dwc3.yaml     | 104 +++++++++++++++++++++
>  2 files changed, 104 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
