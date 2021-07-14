Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C9E3C944B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 01:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbhGNXTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 19:19:16 -0400
Received: from mail-io1-f43.google.com ([209.85.166.43]:43829 "EHLO
        mail-io1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbhGNXTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 19:19:10 -0400
Received: by mail-io1-f43.google.com with SMTP id k16so4195444ios.10;
        Wed, 14 Jul 2021 16:16:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uOGySO5B775xqBKJyV7FjQ7diOPsFl6eDHJ1rU7rF6g=;
        b=UUTOcQZ1nwBa7dFEhXoj3uo4cnZUwqkfDexJjj+pFrif11IS+Ike3DmJl90p37uoJ7
         Z/bxUDSX71TMFPrJsW1QXJVrJOQIGpMa31AkNu7PxVo70xriTgm+T6fTX/GXTzJdZWuI
         OqhXANGb6AI88UnnqWy0wx/ZHSEww1w9P8fd7+lmRfbAn+Dm9N7RsfWCeoLrB6dpRLRo
         WCnB/Zf1Ob9DyeZd6VeaeW5/FQA2XHq3IAR/bjK+Jz9lx5kJJzaO4EPfsDDEL+fH1g5H
         CO04Qy+AnlLKLN/PvCJj5n89DG/eczPqpCoREh2jV34W+Me4SSQYB8Y+NX5DnRunJmR+
         n0BQ==
X-Gm-Message-State: AOAM5317eDeynDpzGduxafVR1H9jMSv9nTiFvxg9bwhj5lGYuVaXvu75
        pQf4PHre9H8l7eAJohL3Ww==
X-Google-Smtp-Source: ABdhPJxpLMV2kkl1j27F3b5jtqtuy1/rscEVt9YI++ng8OF52WRC44YMZOzjVkH91U/Jr9tzCzfR9A==
X-Received: by 2002:a5d:9396:: with SMTP id c22mr433920iol.204.1626304577478;
        Wed, 14 Jul 2021 16:16:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id c4sm1968039ilq.70.2021.07.14.16.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 16:16:16 -0700 (PDT)
Received: (nullmailer pid 3723842 invoked by uid 1000);
        Wed, 14 Jul 2021 23:16:12 -0000
Date:   Wed, 14 Jul 2021 17:16:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     djw@t-chip.com.cn
Cc:     linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        David Bauer <mail@david-bauer.net>,
        Tianling Shen <cnsztl@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Liang Chen <cl@rock-chips.com>,
        linux-rockchip@lists.infradead.org,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org, Wayne Chou <zxf@t-chip.com.cn>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v0 1/2] dt-bindings: add doc for Firefly ROC-RK3328-PC
Message-ID: <20210714231612.GA3723790@robh.at.kernel.org>
References: <20210709080126.17045-1-djw@t-chip.com.cn>
 <20210709080126.17045-2-djw@t-chip.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210709080126.17045-2-djw@t-chip.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Jul 2021 16:01:25 +0800, djw@t-chip.com.cn wrote:
> From: Levin Du <djw@t-chip.com.cn>
> 
> Add devicetree binding documentation for the Firefly ROC-RK3328-PC.
> 
> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> ---
> 
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
