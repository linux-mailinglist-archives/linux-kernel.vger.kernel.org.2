Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 040F841381D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 19:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhIURML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 13:12:11 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:40938 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhIURMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 13:12:10 -0400
Received: by mail-oi1-f179.google.com with SMTP id t189so116497oie.7;
        Tue, 21 Sep 2021 10:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RSqqPC5RzPI5oNtELEMcTpcIl+PKFrmudC28hXLnces=;
        b=u1vM2/T3vp44yaLWb4ydGjPKLMvXY9vaeOaDYXp5ICzs/Wx3X+oS8mhc2E6RkIESe1
         Ty8YwjGlu7qOznqe/fq1duBS2zlqzC+kEkBrbGouMc5VQDVD/oQPkQhz3MG+HluxP5ja
         9UO5lNctIVeKruM7vgmwAmWHFHeI3p2D/4ObQqAhy9/yAC4k78RAAGRUCd5C7jZFCSnQ
         Zj6bRdV8qFmYg8RrPOKRwbDuo55kS7sbU3WpPWMQRCIEJfZDNXFTI4a7XfEYXweaK+YJ
         k4+4b8jgZ82kg1tz99PR8g4Rxdu/farutR5wEDFAzcaPm14YgBGJKKwTIfei7I9xhNqH
         LfbQ==
X-Gm-Message-State: AOAM5309c+N+rKsYdhuV8Zy5lGVblSN1yHbqi65UczfYFP+2mB2tCJVD
        FKQ/Wnd5yJcMAgwTsELZbw==
X-Google-Smtp-Source: ABdhPJwH4CIpoWu4dhzELcwDixUt6gnKWJgymPlA4a/K671+NFCsyUlD18BbtS0xC5ek7GB5KvEByw==
X-Received: by 2002:aca:e009:: with SMTP id x9mr4608457oig.156.1632244241496;
        Tue, 21 Sep 2021 10:10:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i1sm4286746ooo.15.2021.09.21.10.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 10:10:38 -0700 (PDT)
Received: (nullmailer pid 2968018 invoked by uid 1000);
        Tue, 21 Sep 2021 17:10:37 -0000
Date:   Tue, 21 Sep 2021 12:10:37 -0500
From:   Rob Herring <robh@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        robh+dt@kernel.org, vkoul@kernel.org, lokeshvutla@ti.com,
        a-govindraju@ti.com, linux-kernel@vger.kernel.org, kishon@ti.com,
        mparab@cadence.com
Subject: Re: [PATCH 2/5] dt-bindings: phy: cadence-torrent: Add clock IDs for
 derived and received refclk
Message-ID: <YUoSDVVTs4em6UGP@robh.at.kernel.org>
References: <20210908182628.28364-1-sjakhade@cadence.com>
 <20210908182628.28364-3-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908182628.28364-3-sjakhade@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Sep 2021 20:26:25 +0200, Swapnil Jakhade wrote:
> Add clock IDs for derived and received reference clock output.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  include/dt-bindings/phy/phy-cadence.h | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
