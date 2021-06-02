Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88972399257
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 20:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhFBSTs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 14:19:48 -0400
Received: from mail-ot1-f43.google.com ([209.85.210.43]:42876 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBSTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 14:19:46 -0400
Received: by mail-ot1-f43.google.com with SMTP id x41-20020a05683040a9b02903b37841177eso3264725ott.9;
        Wed, 02 Jun 2021 11:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wpRwaaLx7ZrqEe3dJg/pfS23Gh7oExJO6rQu4khhsvk=;
        b=ccQDv6W3xGChDX+ITjFshq0p2tgLThSjkmoBDY8DCTepRjT3zOnF9Q/2xVe/nxoZOm
         m+Mjsx5zX+uaMrg/y2LZ3vQN6L/f1H+OTQx2mXD0b4BthD7TdG5dePZTd55DQSfCUQfw
         VArRuen5S6AZ2TO2MRzNZ3AHccv5PN7vrEoXcg3HY8kzIN+lJ49EueD6BvQ6J9x+GMnY
         X8iJytBVrLK/BFeSNm2pjTDa+Qr1qtGt8Qt4Z8zMWfAgXCzD6ObnbTnEobkZLc2XkclO
         Lo+p2NkGWEXjbFU2P82XYN6K0/Q+wmES1tp/qtbwPWrr84TaOWJSGKAz84rTJTAr8ux6
         7deg==
X-Gm-Message-State: AOAM533ZlEC4LXVObddFdZFgflhFyXfpc7v/i6pn2HRlCbleofO3iNim
        8BYtwR+IN77ITG+cv3v0QA==
X-Google-Smtp-Source: ABdhPJz6mFx2UAL5eFsPavAxkeMRAsjIw/c+vaFDEXCA/NcRNW/9Nw3FYzsBljrABentk20l/DHNSA==
X-Received: by 2002:a9d:5c16:: with SMTP id o22mr9314609otk.319.1622657866851;
        Wed, 02 Jun 2021 11:17:46 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id x7sm122639ooc.23.2021.06.02.11.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 11:17:46 -0700 (PDT)
Received: (nullmailer pid 3706027 invoked by uid 1000);
        Wed, 02 Jun 2021 18:17:44 -0000
Date:   Wed, 2 Jun 2021 13:17:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        vkoul@kernel.org, t.schramm@manjaro.org,
        linux-phy@lists.infradead.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, kishon@ti.com,
        heiko@sntech.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] dt-bindings: soc: rockchip: grf: add compatible
 for RK3308 USB grf
Message-ID: <20210602181744.GA3705993@robh.at.kernel.org>
References: <20210601164800.7670-1-jbx6244@gmail.com>
 <20210601164800.7670-3-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601164800.7670-3-jbx6244@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Jun 2021 18:47:57 +0200, Johan Jonker wrote:
> From: Tobias Schramm <t.schramm@manjaro.org>
> 
> The RK3308 has a USB GRF.
> This patch adds a compatible string for it.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
> 
> Changed:
>   Add "rockchip,rk3308-usb2phy-grf" to "usb2phy@[0-9a-f]+$"
>   patternProperties too.
> ---
>  Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
