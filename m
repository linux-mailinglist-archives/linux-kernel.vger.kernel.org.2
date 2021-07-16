Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6FB3CBB7A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhGPSAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 14:00:44 -0400
Received: from mail-il1-f174.google.com ([209.85.166.174]:33338 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbhGPSAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 14:00:39 -0400
Received: by mail-il1-f174.google.com with SMTP id z1so9087131ils.0;
        Fri, 16 Jul 2021 10:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w8fuSGIRi3aXlEM3SVAucMj5af3dyv+P+T2En9XIJ/Q=;
        b=R6NobiGckv8lef92q/PaJZEwUaX0VW/qhK/DjTIV2dUbUfiRO67RNJd34fJoN35LMh
         kAE+TTkphtNpQMxgCXzlmdtqz2hPhNSVivGVCcd758FWCNfMT53sVHD6OYwKDPXVu75m
         t4JODPbxkzHtHZhXPeoUA3CnBTwlodTCkR4LQK6ZKnDQv9fO1cWLuw+YIZxjX2flcT3e
         YLJo4xdGYVWtCfex448qwy4ite+U3OgvnUaUCBiYCwYcDnIxlDRqP6mxvC67gQUJyoaJ
         zFpRQuYth+QOXa/gmfhcVf05AS9i+dVk1/b4FF2MKYOx1yvZTqYcsdhWYcKxnbxSIfyL
         4o+A==
X-Gm-Message-State: AOAM531/LTbZAoL9mslB9WnLxzoW6hwH4hT5bcKBUmsRmbWc3vxGRfiH
        yM2EmUYGnZO7HtpU20bkAg==
X-Google-Smtp-Source: ABdhPJyQIdi20njTUKaiJxZnh7giOjOgLu/NhcLv5arRjHxmE92fv5pbzvwQDvh+bspS2OoNhKaUVA==
X-Received: by 2002:a92:2805:: with SMTP id l5mr7276380ilf.242.1626458263554;
        Fri, 16 Jul 2021 10:57:43 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id i3sm5220090ilr.56.2021.07.16.10.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 10:57:42 -0700 (PDT)
Received: (nullmailer pid 3678871 invoked by uid 1000);
        Fri, 16 Jul 2021 17:57:41 -0000
Date:   Fri, 16 Jul 2021 11:57:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     hsinyi@chromium.org, drinkcat@chromium.org,
        linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, eizan@chromium.org,
        linux-mediatek@lists.infradead.org, jitao.shi@mediatek.com,
        chunkuang.hu@kernel.org, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, kernel@collabora.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/7] arm64: dts: mt8183: Add the mmsys reset bit to
 reset the dsi0
Message-ID: <20210716175741.GA3678812@robh.at.kernel.org>
References: <20210714101141.2089082-1-enric.balletbo@collabora.com>
 <20210714121116.v2.5.I933f1532d7a1b2910843a9644c86a7d94a4b44e1@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714121116.v2.5.I933f1532d7a1b2910843a9644c86a7d94a4b44e1@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jul 2021 12:11:39 +0200, Enric Balletbo i Serra wrote:
> Reset the DSI hardware is needed to prevent different settings between
> the bootloader and the kernel.
> 
> While here, also remove the undocumented and also not used
> 'mediatek,syscon-dsi' property.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> (no changes since v1)
> 
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi  | 3 ++-
>  include/dt-bindings/reset/mt8183-resets.h | 3 +++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
