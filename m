Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C70380A28
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 15:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbhENNIX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 09:08:23 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:45590 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhENNIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 09:08:18 -0400
Received: by mail-ot1-f41.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so5249346otc.12;
        Fri, 14 May 2021 06:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=l2eXy9z3afSwFgDJvgpFD/dJeeyQ7yGcCchF95C+EYo=;
        b=Wbj72ygQ9iVvDjFCFSAS2BSP1M6ZnKFVJqpR0bEC+hlq4kc06rxxdAx9o3DSJi4nJU
         0DXczJwUOcZ3N+G4A6BdFZ5yENe2MtQuFCCsPW22aH2sEzWivP/27Pb9NnEDUrgU0kVV
         clreHaA3YzQub0fSZoIazjpQWzXxjuQumkgZjT1Lw82aKcuyF4cY8CQnmi1nTF7Ieusq
         wdjXlQsrO+WCo5JcN0RmmpfuUBJk3ZeEosZOend85mUHd3Z475NI+f+9VDoM0/KU0t4x
         63neVVnkVYsHA4+ce4VE+nf/VxXaGMqmf77Br4YcYPhYi1IPHPnqqDV7xDXVtu6Rf8GI
         1zLQ==
X-Gm-Message-State: AOAM531b8Bam55CZUMGcJY+wP314WDVHTavhuZLO2/lHxfnSG5tE9hrP
        hsJU3B0rpca7umoQCxqimw==
X-Google-Smtp-Source: ABdhPJwxT9wq5KV3S8bxY0nu4XKjmrJVihBR6WLFWVuWar1OZi3pT3atscgWLMtmxfBX5YT16XPM8w==
X-Received: by 2002:a9d:6c86:: with SMTP id c6mr21822666otr.9.1620997626366;
        Fri, 14 May 2021 06:07:06 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i130sm1195577oif.49.2021.05.14.06.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 06:07:05 -0700 (PDT)
Received: (nullmailer pid 3936692 invoked by uid 1000);
        Fri, 14 May 2021 13:06:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     =?utf-8?q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>
In-Reply-To: <20210513233024.2076725-5-t.schramm@manjaro.org>
References: <20210513233024.2076725-1-t.schramm@manjaro.org> <20210513233024.2076725-5-t.schramm@manjaro.org>
Subject: Re: [PATCH v2 4/7] ASoC: dt-bindings: sun8i-a23-codec-analog: add compatible for Allwinner V3
Date:   Fri, 14 May 2021 08:06:56 -0500
Message-Id: <1620997616.593902.3936691.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 01:30:21 +0200, Tobias Schramm wrote:
> The analog codec frontend of the Allwinner V3 is compatible with the
> analog codec frontend used on the Allwinner H3.
> This patch adds a compatible string for the analog codec frontend on the
> Allwinner V3 SoC.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---
>  .../bindings/sound/allwinner,sun8i-a23-codec-analog.yaml | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/sound/allwinner,sun8i-a23-codec-analog.yaml:21:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:

See https://patchwork.ozlabs.org/patch/1478254

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

