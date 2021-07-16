Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B39B3CBB55
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbhGPRpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:45:44 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:41879 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhGPRpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:45:40 -0400
Received: by mail-io1-f50.google.com with SMTP id z9so11468761iob.8;
        Fri, 16 Jul 2021 10:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=abtEqAV33M3DgIPEkfoggh1NvUGRVPw0OXOjuerHpE4=;
        b=OeyCyFzXuAOVd8iFJ15NnSt9LcsvqtKrnuQh+tVh0BJBa9g+GTeCvVBvfouWw+eEqu
         Gsg4CngcO7WCSrW0CHmCAAtXY+6QFF0Iew58s13YWiCxrupKQRe/CY6XuefNhnjoI4o/
         3RrLeF+Xsi9GkgdpwrPsWtvW6Tziz/nlE0f+ZcAxmmQhodFBbyaUM3gMwpJ8TN36iSpB
         LzCToaMNNfzSXc0fRGBsc0GYLxp4yLdQlueeUPqfeIQyfrRDMj2GplzMdIa1tNiRst4t
         tZsv0v4sLLTW/Zo9UBUvgWGE94SRZ1mIU9wHlJWVF4gILNPsMD1Pw7HhQOjWUwA3U0wk
         PKEA==
X-Gm-Message-State: AOAM5323BckTXOkQXUprT8dDXdQtZ02yV04JqBpww1K0bHjzriMvEOB/
        5n028I4MjoJnBwpREWEKpg==
X-Google-Smtp-Source: ABdhPJxypwi9lv1+Z3SgmiNgIEr2wremF6jY0WjJ2dthFUCmeqyOmoP5mv6TuceqQs07W1yvN2zhzQ==
X-Received: by 2002:a5e:9309:: with SMTP id k9mr8023167iom.207.1626457365621;
        Fri, 16 Jul 2021 10:42:45 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id h11sm5338497ilc.1.2021.07.16.10.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 10:42:44 -0700 (PDT)
Received: (nullmailer pid 3655729 invoked by uid 1000);
        Fri, 16 Jul 2021 17:42:42 -0000
Date:   Fri, 16 Jul 2021 11:42:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, chunkuang.hu@kernel.org,
        hsinyi@chromium.org, kernel@collabora.com, drinkcat@chromium.org,
        eizan@chromium.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, jitao.shi@mediatek.com,
        Fabien Parent <fparent@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/7] dt-bindings: mediatek: Add #reset-cells to mmsys
 system controller
Message-ID: <20210716174242.GA3643756@robh.at.kernel.org>
References: <20210714101141.2089082-1-enric.balletbo@collabora.com>
 <20210714121116.v2.2.I3f7f1c9a8e46be07d1757ddf4e0097535f3a7d41@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714121116.v2.2.I3f7f1c9a8e46be07d1757ddf4e0097535f3a7d41@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 12:11:36PM +0200, Enric Balletbo i Serra wrote:
> The mmsys system controller exposes a set of memory client resets and
> needs to specify the #reset-cells property in order to advertise the
> number of cells needed to describe each of the resets.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> (no changes since v1)
> 
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt         | 2 ++
>  1 file changed, 2 insertions(+)

This will conflict. There's already multiple patches converting this to 
schema[1][2].

Rob

[1] https://lore.kernel.org/lkml/20210519161847.3747352-1-fparent@baylibre.com/
[2] https://lore.kernel.org/lkml/CAC=S1nhi0rLpQznvUP1FVNtEDzdffFG_aMO7j-w4fHBY8ceJnw@mail.gmail.com/
