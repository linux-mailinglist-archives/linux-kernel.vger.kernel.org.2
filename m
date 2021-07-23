Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560083D4212
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 23:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbhGWUhT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 16:37:19 -0400
Received: from mail-il1-f179.google.com ([209.85.166.179]:44968 "EHLO
        mail-il1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbhGWUhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 16:37:18 -0400
Received: by mail-il1-f179.google.com with SMTP id o7so1583428ilh.11;
        Fri, 23 Jul 2021 14:17:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p1I4YA5z0bAMYWdfTVPdMJOKCvxbdQgOQuioBmQ4aXU=;
        b=rW0+rXRQHH3Fix+pQNHrYr4y7L524MrdvdVZw+QUMowDB18GfQC1ynSe6aFvMwXDDG
         WH6gR1EdkTKuEWrAsLxO4Z4Ts6VDGiLWPbfNjeu9m66nAaoSnSyx3NvSZzJeSoalxsns
         aNqytSqYZCAP5bewHysGay6yg5BxMeUo5E39zQADUQTBnH7osXzF3Rd/TMXcRSQbmfXp
         STc8/I2/eMqp8LXlcdjUa/lH9PRYax829F+GuC/KhMZcVswtT1ibSvRDmaqlvOif5AuX
         S+1ARNTdO9HBiO4Kjrq9FuwgPB2M1der4Oci8tuo/+4N9g8E/Y95GepUiA+DqeNxpEAf
         wnhA==
X-Gm-Message-State: AOAM531fyjYYd1b9C4pZqv6tyZEM+HMZKwmqXgWj+FSd/D5lfbzNv224
        9pPborxhD3riiVAX6PSoug==
X-Google-Smtp-Source: ABdhPJxf/xogG2+afjIAe+EPYocLU4CDhzyjoHg/UZN4LLbiGtJjZJ43LbRQVKFv9wtDhe/8yEO1iA==
X-Received: by 2002:a92:c549:: with SMTP id a9mr4686197ilj.248.1627075071284;
        Fri, 23 Jul 2021 14:17:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id r3sm16729306ilg.20.2021.07.23.14.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 14:17:50 -0700 (PDT)
Received: (nullmailer pid 2601057 invoked by uid 1000);
        Fri, 23 Jul 2021 21:17:48 -0000
Date:   Fri, 23 Jul 2021 15:17:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@gmail.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, Sean Paul <sean@poorly.run>,
        Marek Vasut <marex@denx.de>, dri-devel@lists.freedesktop.org,
        Krishna Manikandan <mkrishn@codeaurora.org>
Subject: Re: [PATCH] dt-bindings: display: Fix graph 'unevaluatedProperties'
 related warnings
Message-ID: <20210723211748.GA2601003@robh.at.kernel.org>
References: <20210719195001.2412345-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210719195001.2412345-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jul 2021 13:50:01 -0600, Rob Herring wrote:
> The graph schema doesn't allow custom properties on endpoint nodes for
> '#/properties/port' and '#/$defs/port-base' should be used instead. This
> doesn't matter until 'unevaluatedProperties' support is implemented.
> 
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Krishna Manikandan <mkrishn@codeaurora.org>
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/display/bridge/ti,sn65dsi83.yaml    | 6 ++++--
>  .../bindings/display/msm/dsi-controller-main.yaml           | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 

Applied, thanks!
