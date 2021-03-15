Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7EB33C1AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 17:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbhCOQZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:25:43 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:38338 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbhCOQZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:25:21 -0400
Received: by mail-io1-f46.google.com with SMTP id k2so34046630ioh.5;
        Mon, 15 Mar 2021 09:25:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=27vnsydVUa4ltua5W1oR+ou4V2KplNlbp+72QsF/VKc=;
        b=HYmUR0yJEu8K7BbBjBTXfXx/8rZ9xFtZqE1DOL+t3Uxbgo6vJ15hcNppxL97z8GX0H
         F1ll91EkcNiVO7/ML/jIMO5OgFPAdN81BjwQOj2nGX8aeJMTm8PDZzqSxl04Tcc8UJyi
         WqG8BKWJHr06/4gpU3llL9EkZPCVSB4qkEK9xNpKPt926vmqoFwKnK8T5IcNDWnsogHg
         IwRsMsrnOEM2aKuGgph4NKC53r2RN+3FNV6ep/GIxsNjVKycgEjpKrqKmXtvMCgfHKqO
         K6/suI8IZqmVoAcrFoUTzcob4dQN1AtjLd3jUjS+gx+MMbm1HAnPS1K2qJAA/Kv8HT2o
         lTeQ==
X-Gm-Message-State: AOAM531b+B/XnWM1Jzo+CUriBqnxXN7/6SuEZ0k7YDFxSv155CxE77UR
        3x5PB0Gfa6W6umQhPYG1LA==
X-Google-Smtp-Source: ABdhPJxE9HKb1bqeMCiFcbCoEn58lMfaFkpCdrPrjNBrSCx1vHowTC3QNzQnIT1m/JGswSXQdzAlrw==
X-Received: by 2002:a5d:8552:: with SMTP id b18mr301530ios.124.1615825520666;
        Mon, 15 Mar 2021 09:25:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id h128sm7305247ioa.32.2021.03.15.09.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:25:19 -0700 (PDT)
Received: (nullmailer pid 980057 invoked by uid 1000);
        Mon, 15 Mar 2021 16:25:16 -0000
Date:   Mon, 15 Mar 2021 10:25:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tianling Shen <cnsztl@gmail.com>
Cc:     Jensen Huang <jensenhuang@friendlyarm.com>,
        Johan Jonker <jbx6244@gmail.com>,
        David Bauer <mail@david-bauer.net>,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Marty Jones <mj8263788@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R4S
Message-ID: <20210315162516.GA978743@robh.at.kernel.org>
References: <20210315084241.22345-1-cnsztl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315084241.22345-1-cnsztl@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Mar 2021 16:42:40 +0800, Tianling Shen wrote:
> Add devicetree binding documentation for the FriendlyARM NanoPi R4S.
> 
> Changes in v2:
> - Disable display for NanoPi R4S (reference commit: 74532de460ec)
> - Light "sys" LED on NanoPi R4S (reference commit: 833821eeab91)
> 
> Changes in v3:
> - Dropped non-existent node `display_subsystem`
> 
> Changes in v4:
> - Correctly dropped `display-subsystem` node
> - Dropped meaningless `pwm-fan` node
> - Dropped wrong `sdmmc` node
> - Disabled `i2c4` and `uart0` as they don't exist in the design
> - Format fixes
> 
> Signed-off-by: Tianling Shen <cnsztl@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
