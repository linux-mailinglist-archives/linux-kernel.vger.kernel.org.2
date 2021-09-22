Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9337441517C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbhIVUjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:39:08 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:38483 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237697AbhIVUjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:39:04 -0400
Received: by mail-oi1-f179.google.com with SMTP id u22so6406438oie.5;
        Wed, 22 Sep 2021 13:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jdntUWQh+5gL0EzR4qub6kq7E3MZXxinoC2uHIipJc4=;
        b=JndvHN9M0sgddv27nLZxQrHD72MAycNF70y1qn/zSKxzYYKFodAHe/xTCYhFscrWUT
         Ip6FZI/BbjolVIL24U4mqpupVqWFPeg7NKWXnL5ZVHniQ2gFwXu0o07DXqb13ghFskqY
         j+W0AqCANt7DG3SbOrugz6xyp6K8J9q3w4eCFrxZNvkQDpNAS8NW/z6p8Sa+hbaFkArt
         DHkCylv9aR5YNl56tZtHnTyMyjFCIijiGr4AZ076uOANTOxFGzvnhfq23JLPNaO8bg3J
         +grQ5csWrEiroRsT/IwE0DOUkM20TEKw1i8dI+3xk6jNqYWs0sxHKQnFeFCffZ4buetc
         bIpw==
X-Gm-Message-State: AOAM5332cZEzxsbzO777FEm8kRDQQGOnp+i0JKELGqiJjQuhuiCakGh0
        qbCQfJVUI7VKT9MVPPKw5Lv7nSbbzw==
X-Google-Smtp-Source: ABdhPJwUxyDhVip4CA1Rok/LmLTf+dCRkqa0q/UNrEyPqXLi10KjmTNEHQ29OjaispYZs6TmIfUYhg==
X-Received: by 2002:a05:6808:209b:: with SMTP id s27mr9717645oiw.168.1632343053457;
        Wed, 22 Sep 2021 13:37:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r23sm720180otu.54.2021.09.22.13.37.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:37:33 -0700 (PDT)
Received: (nullmailer pid 1250145 invoked by uid 1000);
        Wed, 22 Sep 2021 20:37:32 -0000
Date:   Wed, 22 Sep 2021 15:37:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
Message-ID: <YUuUDDlHuMXuA/vc@robh.at.kernel.org>
References: <20210918045114.387005-1-zhang.lyra@gmail.com>
 <20210918045114.387005-3-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918045114.387005-3-zhang.lyra@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2021 12:51:12 +0800, Chunyan Zhang wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add bindings for Unisoc system global register which provide register map
> for clocks.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> ---
>  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
