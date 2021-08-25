Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FC23F7A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 18:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240935AbhHYQcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 12:32:01 -0400
Received: from mail-ot1-f45.google.com ([209.85.210.45]:44707 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbhHYQb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 12:31:59 -0400
Received: by mail-ot1-f45.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so47102492otg.11;
        Wed, 25 Aug 2021 09:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tMEQ5rSS37SXZ86EXg6wb4SRLylx3WacUr1VwiLL/Ng=;
        b=Kf/5zzAhvWOIr+h1x/fWWoMGDkOWt2xQbkuJ2aSI93CUvtLBazWZHgMGFRoSBHpNLe
         rp91Oe4as8RBftXZNx5pHAbDx04eGlMAHbBVxNYst8F5PxgFk8VZgKszH3inVB1Vk6Ss
         SwTHqZkdisuec8l+aGwP/R3wbYBgMvoLrXg2Jo69mv+N+/zAuggqBle5wN8hNsCDf+Gi
         yqfVHfBNAz46Z4/MBliWO7srsPRKcnS390X7c8YATkHzcgHv7+1NshC75oNgQbp5x70h
         sxTk6Vjtp9qsgCLnmi62oxUmaYazLukGF4px/h4e5L02k9sWNxGTmv7CtVpoSmtZpOEW
         02HA==
X-Gm-Message-State: AOAM530MEq5/zHhSujOBP1wXlo980swr0SroF7FaIxSXdbkJ7n0uVGuV
        25/HgA2sZQAO0E0gsXHJzA==
X-Google-Smtp-Source: ABdhPJxfTu0ee+tYGYmnlkF+0uBzIVdwz+W40xhaEOvLrBXPblsCrnPz+qZSsntwz86pKMcuTxI+sA==
X-Received: by 2002:a9d:6e0a:: with SMTP id e10mr34241962otr.259.1629909073115;
        Wed, 25 Aug 2021 09:31:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r20sm66162oot.16.2021.08.25.09.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 09:31:12 -0700 (PDT)
Received: (nullmailer pid 2904615 invoked by uid 1000);
        Wed, 25 Aug 2021 16:31:11 -0000
Date:   Wed, 25 Aug 2021 11:31:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, kernel@collabora.com,
        jitao.shi@mediatek.com, eizan@chromium.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, chunkuang.hu@kernel.org,
        hsinyi@chromium.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org, drinkcat@chromium.org
Subject: Re: [PATCH v3 2/7] dt-bindings: mediatek: Add #reset-cells to mmsys
 system controller
Message-ID: <YSZwT8QahCfWE5N3@robh.at.kernel.org>
References: <20210825102632.601614-1-enric.balletbo@collabora.com>
 <20210825122613.v3.2.I3f7f1c9a8e46be07d1757ddf4e0097535f3a7d41@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825122613.v3.2.I3f7f1c9a8e46be07d1757ddf4e0097535f3a7d41@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 12:26:27 +0200, Enric Balletbo i Serra wrote:
> The mmsys system controller exposes a set of memory client resets and
> needs to specify the #reset-cells property in order to advertise the
> number of cells needed to describe each of the resets.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
> Changes in v3:
> - Based on top of the patch that converts mmsys to schema
> 
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
