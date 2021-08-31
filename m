Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63CE73FCD3E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 21:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237632AbhHaSxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 14:53:53 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41616 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhHaSxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 14:53:52 -0400
Received: by mail-oi1-f175.google.com with SMTP id 6so392069oiy.8;
        Tue, 31 Aug 2021 11:52:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GaISQQcUmH3yFJZK19hxSWvQKue1oPZpb+E7tciH02Y=;
        b=ueWpKKn2n3T4sdPzOe0+kiEiAsZK8iGJtnxL/EcnDgkmmquWsEDO9ap2O827UHDVRq
         UfpXU7lZHeOUzXqlndGzGu35Ko/M/VokuWclJUlZUZkmRDbly1UAkg+ymbGs9RhjPuIs
         sSfv/dDDayGtpqQgd3KUSavTtSAXwJ6pdqVKRjHA0Ac/BEnqAEjfBOX/TW2A0JS6LdBx
         tWM+Fq5dxp8c27D0alXJeA6J9eG3mP/KPLOA8si9ChQt8xoegXzBVXZGutzLVEMEvgGE
         4dA6l+BERpsBl3eXqeSu6vA2wz8HJCeHT88dChZ1M5jVdJ7EFR+3HnOEqpKPLI9Vdoh6
         OZOw==
X-Gm-Message-State: AOAM531qCiFM0AHDsU0tVCP9uCnoT4HYFqZOh1la0rSixL6u1GgZjPJd
        7IVPKb9glkgQyx8RN6ZLhQ==
X-Google-Smtp-Source: ABdhPJygcfOd/qjKOVhQVKqkAkEAqQWY71ZQpai34B/CzPJbh/oTSTdmC6yWvPldPEsDQdPHWvqTSw==
X-Received: by 2002:aca:d06:: with SMTP id 6mr4253337oin.105.1630435976319;
        Tue, 31 Aug 2021 11:52:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t1sm4027098otp.9.2021.08.31.11.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 11:52:55 -0700 (PDT)
Received: (nullmailer pid 466339 invoked by uid 1000);
        Tue, 31 Aug 2021 18:52:54 -0000
Date:   Tue, 31 Aug 2021 13:52:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: dt-bindings: mt8195: remove dependent headers in
 the example
Message-ID: <YS56hvQHAH/zD/dD@robh.at.kernel.org>
References: <20210831083956.9804-1-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831083956.9804-1-trevor.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 04:39:56PM +0800, Trevor Wu wrote:
> Drop the use of the defines including clock and power id, so that
> we can remove the headers which are not applied in the example.
> 
> Fixes: b5bac34fcfb4 ("dt-bindings: mediatek: mt8195: add audio afe document")
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../bindings/sound/mt8195-afe-pcm.yaml        | 40 +++++++++----------
>  1 file changed, 19 insertions(+), 21 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

Please pick this up for 5.15-rc1 (or don't so I can).

Rob
