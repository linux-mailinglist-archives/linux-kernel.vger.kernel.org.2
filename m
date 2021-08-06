Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6613E314C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245292AbhHFVng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:43:36 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:44738 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241587AbhHFVnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:43:31 -0400
Received: by mail-io1-f42.google.com with SMTP id d22so14211745ioy.11;
        Fri, 06 Aug 2021 14:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/zWfW8RsAFbtp93s/xAdzSAqFLqIYUcrzczKfwh3Lh0=;
        b=ftVgdvQvj3jwWTUmqkOS75+wxf7Nv8GETDIhq40GOKur4zy8YBajYmHVzBCruiKOhO
         u1w7z2kCVIDD4ThopzU8jpRpKhlZdpllyVlAADVA2tT0LGDuir1Oteonuk3UDkzNlQVz
         YN3qZQIHTo2Nz/hgO1TsnsTVKkSudbDKmHB9yCcGxHUNqJxFyksGb8nqrj56NGUEk6iz
         59pY3dSvH/KBmQWj1cnZCwnhuMn2Ng32NsjXUV/Uz8L9Gxtgi2o8IS9KyBFFYmKODs14
         CnWZ/eCRo0U5IxOYbZB7o5+rOtRPUxVWWXg1K1UCY9Tyu/KeuhvsLI6mkK96fBd2rDAR
         5MfA==
X-Gm-Message-State: AOAM531yHfT4oEcTa/fb2+ZVN7mAQvJ8KcaJL0drpnMAW1td5AScAIeY
        GcY5SUqjmEDeeGmbghAQeg==
X-Google-Smtp-Source: ABdhPJxdjcRaDyo4+/BjQuPLS4tWO4TCwPJiNts1M12fu5TnSKD3P19/6gfPvDWqOM/NZc6Xjt9+pA==
X-Received: by 2002:a6b:6b08:: with SMTP id g8mr2374131ioc.141.1628286194460;
        Fri, 06 Aug 2021 14:43:14 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id 12sm3514613ily.7.2021.08.06.14.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:43:13 -0700 (PDT)
Received: (nullmailer pid 1855489 invoked by uid 1000);
        Fri, 06 Aug 2021 21:43:11 -0000
Date:   Fri, 6 Aug 2021 15:43:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@sipeed.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH 14/17] dt-bindings: arm: sunxi: add compatible strings
 for Sipeed MaixSense
Message-ID: <YQ2s762cl83X7go1@robh.at.kernel.org>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-15-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802062212.73220-15-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2021 14:22:09 +0800, Icenowy Zheng wrote:
> Sipeed MaixSense is an Allwinner R329 development kit based on Maix IIA
> SoM.
> 
> Add compatible strings for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
