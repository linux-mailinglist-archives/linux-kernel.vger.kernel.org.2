Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6539B3E3141
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 23:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245280AbhHFVlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 17:41:23 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:36702 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhHFVlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 17:41:22 -0400
Received: by mail-io1-f47.google.com with SMTP id f11so14147675ioj.3;
        Fri, 06 Aug 2021 14:41:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uhznWD02bvTnRNXTmc/rxQJVDeSbb/fFCBHNI2+YSq4=;
        b=RZVWAiUXOHpNHSPe6kFDxtv4kf2AM132k/hzXnE6872RqdEwVgGNbgqH0HrwofGdRH
         wp3L44bvJ1wzP00K/oQENgB6d0u3h1kVzsEaXJYZVtnymC+57v9BaqZCinpu3KY8/0k4
         nTcjUxnuqXpKsq6vDm6Qiv3PHbPB7OxhrDtZAwXNA7y7z+j+2C1oFFcJi0Egekz2SuK1
         uLPX3NXVdVS7VkXau+CxKRT85RZTnMu5Y+Dbsb1xCJTNr+qnbyu0S2ZbxbJlWtkNNNJd
         W4ypvH73+MoPiZruS5X0AKlSMJUL569KR6PPMZRqVtpr79OO0im1qE7z3tDr+BAO3QD5
         hiKw==
X-Gm-Message-State: AOAM533ltCAIuNCh/qQTX0+ymVuQ3fadpt4LYO4Eu6T01BZRxoOFzVG9
        9Fgl1XE5GzPlxF9UIpOhBg==
X-Google-Smtp-Source: ABdhPJwEiRaN+S9+/SO3kTm/jShjgi5oxBuwfPl8aKdDK8CxuHvByUbUauU7TQ835dkJ2AeTehqXMw==
X-Received: by 2002:a05:6638:1b9:: with SMTP id b25mr7966322jaq.23.1628286065659;
        Fri, 06 Aug 2021 14:41:05 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id t16sm5129090ilg.56.2021.08.06.14.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:41:05 -0700 (PDT)
Received: (nullmailer pid 1851760 invoked by uid 1000);
        Fri, 06 Aug 2021 21:41:03 -0000
Date:   Fri, 6 Aug 2021 15:41:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <icenowy@sipeed.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 09/17] dt-bindings: clock: sunxi-ng: add compatibles for
 R329 CCUs
Message-ID: <YQ2sbzC7ZzxUsktv@robh.at.kernel.org>
References: <20210802062212.73220-1-icenowy@sipeed.com>
 <20210802062212.73220-10-icenowy@sipeed.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802062212.73220-10-icenowy@sipeed.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Aug 2021 14:22:04 +0800, Icenowy Zheng wrote:
> R329 has a CPUX CCU and a R-CCU.
> 
> Add compatible strings for them.
> 
> Signed-off-by: Icenowy Zheng <icenowy@sipeed.com>
> ---
>  .../devicetree/bindings/clock/allwinner,sun4i-a10-ccu.yaml    | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
