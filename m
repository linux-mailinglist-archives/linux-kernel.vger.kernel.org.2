Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8414F350157
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 15:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbhCaNfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 09:35:41 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:39791 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235755AbhCaNf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:35:28 -0400
Received: by mail-oi1-f179.google.com with SMTP id i81so20003121oif.6;
        Wed, 31 Mar 2021 06:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OO7ubuY6oTKvyUG1gEO7CnoaNU1mo7KyFjqzNQtFekg=;
        b=CI+oWxnSL9O06hUSl63jE6UVZqXwxahMrp2sDwKHmnrv0wLRD1RaPVXn5HCvbu4/aQ
         tW2hQXlRZy3l3shyZwtWo7YZ4QnAAHpIN/ajZAuFdGe56wBjjeH60laVuuPKv1RhrdRv
         b6ShaDj6vHksEJnsApLZRCoYnAnhgHIKU5mIf3LzI2OgfwLN3RJvvoscG2BY3vpPrQ57
         pMOmle6+MiI+Z6frCCMFQOAIBvTKHULitW1Fgxap0CBBXAg8LCkP85jMHwdj/bHtPauz
         eWwtJwYhSOsLni1f/VGHdlb/DyOKOJm4jbtXudYt3mdKt85/inD/QUNRx1u6Q7LjMIFp
         rQTQ==
X-Gm-Message-State: AOAM532DeoShuUIs/bEYTZGTdYfFPx1Lq2DQtppY7kBnEIZrB4Xx6nWH
        ZMyeBWonfpNgoXfGdCVY4Q==
X-Google-Smtp-Source: ABdhPJzR60WxulAypcTek0JQWaHluHrpPJGXqUHdYhkTq5G28iPykqY6g8W79IHDsXKCTbhxKKVeKQ==
X-Received: by 2002:aca:6543:: with SMTP id j3mr2341007oiw.158.1617197728353;
        Wed, 31 Mar 2021 06:35:28 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m127sm433005oib.32.2021.03.31.06.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 06:35:26 -0700 (PDT)
Received: (nullmailer pid 2066047 invoked by uid 1000);
        Wed, 31 Mar 2021 13:35:25 -0000
Date:   Wed, 31 Mar 2021 08:35:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     zhangxuezhi1@yulong.com, david@lechnology.com, daniel@ffwll.ch,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        airlied@linux.ie, robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/1] dt-bindings: display: sitronix, st7789v-dbi: Add
 Waveshare 2inch LCD module
Message-ID: <20210331133525.GA2065994@robh.at.kernel.org>
References: <20210330081505.116351-1-zhangxuezhi3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210330081505.116351-1-zhangxuezhi3@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 08:15:05 +0000, Carlis wrote:
> From: "Xuezhi Zhang" <zhangxuezhi1@yulong.com>
> 
> Document support for the Waveshare 2inch LCD module display, which is a
> 240x320 2" TFT display driven by a Sitronix ST7789V TFT Controller.
> 
> Signed-off-by: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> ---
> v2:change compatible name.
> v3:change auther name.
> ---
>  .../display/sitronix,st7789v-dbi.yaml         | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/sitronix,st7789v-dbi.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
