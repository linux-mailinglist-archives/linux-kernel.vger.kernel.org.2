Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCC333CBB74
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhGPR7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:59:38 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:36408 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbhGPR7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:59:37 -0400
Received: by mail-io1-f41.google.com with SMTP id u7so11552148ion.3;
        Fri, 16 Jul 2021 10:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kzjyBdk5+GE+lOrmE+ZJKGUST/qKGtHK5D4OJgw36OM=;
        b=pzJhJIz6xp58YqPXKC/gE08vSLBs9IG4tFaVDAx1P20x9gkBuxslo7LYNGqZeSPVyM
         xxTHw0/5oT1aCmDT/ADpoxrKic1C/+2PMLaLSqiHx6UUTRoszH1/LlU+ZjehKRrHDGV2
         1PgvOYkSlS1yCSF3Px+AqCKYs8VYV17dXrmvwI232GtRv/poLeL5BvexsNDEwI2soc1C
         xV7Ay/VZ2J1cS0rm+Xfbzt3ik6dBO2LFFyS26MwtM2zk+TL6S2y2bWp4Yfjw2vnotiaE
         PNWc4nSxrbe/JKkcz5O5yy1Z1cIgZgcyYLaoOgUtBoFClXxTdL5KC7sxinvmeiMpgvGt
         jZGw==
X-Gm-Message-State: AOAM531F2U6DrMQO3HRXzRnerWkE55WwKCOF2wqiBFl9XPNgk6TkoH55
        kP+6L7o4KUKODfL1yK22fA==
X-Google-Smtp-Source: ABdhPJwb98hD16OtNkCJhXnRWD9ELz1QV/5BYG2cg+o0CJ25J2YF0h0pA0OxISNIzfbnHx2Bn+EU0Q==
X-Received: by 2002:a6b:b2d7:: with SMTP id b206mr8292605iof.155.1626458201175;
        Fri, 16 Jul 2021 10:56:41 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r6sm5627844ioh.27.2021.07.16.10.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 10:56:40 -0700 (PDT)
Received: (nullmailer pid 3677111 invoked by uid 1000);
        Fri, 16 Jul 2021 17:56:37 -0000
Date:   Fri, 16 Jul 2021 11:56:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        drinkcat@chromium.org, linux-arm-kernel@lists.infradead.org,
        matthias.bgg@gmail.com, kernel@collabora.com,
        chunkuang.hu@kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        hsinyi@chromium.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, eizan@chromium.org,
        jitao.shi@mediatek.com
Subject: Re: [PATCH v2 4/7] arm64: dts: mt8173: Add the mmsys reset bit to
 reset the dsi0
Message-ID: <20210716175637.GA3677053@robh.at.kernel.org>
References: <20210714101141.2089082-1-enric.balletbo@collabora.com>
 <20210714121116.v2.4.I7bd7d9a8da5e2894711b700a1127e6902a2b2f1d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714121116.v2.4.I7bd7d9a8da5e2894711b700a1127e6902a2b2f1d@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 12:11:38 +0200, Enric Balletbo i Serra wrote:
> Reset the DSI hardware is needed to prevent different settings between
> the bootloader and the kernel.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi  | 2 ++
>  include/dt-bindings/reset/mt8173-resets.h | 2 ++
>  2 files changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
