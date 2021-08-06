Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66803E313F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:40:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245266AbhHFVlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:41:04 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:39496 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhHFVlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:41:03 -0400
Received: by mail-io1-f51.google.com with SMTP id r72so104030iod.6;
        Fri, 06 Aug 2021 14:40:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SVZ3CU03g0qrDAF07gnpcK72ygfjL9r246Tcln5qp/s=;
        b=TDtym0jPjoBR3LmuJsLMozlcZd9kTGScXEIWhwKchEGIF6bgFN8twYoae2eKD9nnjz
         wy+8Tk4Oqo79GfpYpuV1xSg+eRX/q2PLyC2o4vzrCreJAXt92FZjCzUOBGzYJTqZPSpw
         GINl6V54fQZnQdkB3hIrPPnZHai4MH4k6Lwq+Jez1jTtnuB4CXR3DQagPzTlsG/Zltql
         f1TRSKIrNLHeZny3cUZPkKWWSY2JsZclnqbU7m2rH96vxDRsKYB+3uqCpZC4aow6fKHk
         VLWz5Xn4JZYJZsBSxHldguBa5EdbHFrcvSiAcpI+bvtsfhX+2jm9x4cOkle7+bRsJFxP
         Mrvg==
X-Gm-Message-State: AOAM531TvSQpqWbe8romyn4Zzt50bpdyE6hX4uED6USB3Oe0j74q3o98
        HgI04f179lS9U7f7rOhCKg==
X-Google-Smtp-Source: ABdhPJwEkxhHXJR5C/AUQDaT9F/idc9EmQCYPRxRDiKhGD8JlwYmclQ8f9Fgf1xeR22wuqWLCePiRg==
X-Received: by 2002:a02:b058:: with SMTP id q24mr11459307jah.88.1628286046526;
        Fri, 06 Aug 2021 14:40:46 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j2sm5438284ilr.80.2021.08.06.14.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:40:46 -0700 (PDT)
Received: (nullmailer pid 1851157 invoked by uid 1000);
        Fri, 06 Aug 2021 21:40:43 -0000
Date:   Fri, 6 Aug 2021 15:40:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@sipeed.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 06/17] dt-bindings: pinctrl: document Allwinner R329 PIO
 and R-PIO
Message-ID: <YQ2sW6ulsvlPluMC@robh.at.kernel.org>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-7-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802062212.73220-7-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2021 14:22:01 +0800, Icenowy Zheng wrote:
> Allwinner R329 have two pin controllers similar to previous Allwinner
> SoCs, PIO and R-PIO.
> 
> Add compatible strings for them.
> 
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  .../bindings/pinctrl/allwinner,sun4i-a10-pinctrl.yaml         | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
