Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3E03F0B49
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 20:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbhHRSwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 14:52:08 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:40784 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhHRSwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 14:52:03 -0400
Received: by mail-ot1-f49.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so5293629oth.7;
        Wed, 18 Aug 2021 11:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ckY8TfLizlLki6TSxo5wp0folJ6pA7dMxy8jTNP3IZY=;
        b=DZEDb/gQfS4iusdxG8OgNDO26DcJC9k4U++pQrF6br8pDd0RlKGX91pF+ZFKAlbFkJ
         MEfW0+fI1OQ5dryRmZ+l8fsYYKdAMMLiNBJ/0XgN5mDDYUBckzroOpJtBOOmzq4ti0LU
         0iqrqEzzh8okrjzjUwZtKLWyxibly+letAuryOrBwg8vofLJs2t+tLlYPU91ZegnvNWX
         51qtBex6QoGy1jETM+oJYqSObZzFVrDQgwvWGZWPU+zqYLA+93j7iA+5seo1Fr8zrgoL
         2fFIJEYO/3MPNTNHCyE4nKUV79NWhSNr4myHGOFoRTcKGImMPmTgIxMKfKHBPP/QDwjX
         NJwQ==
X-Gm-Message-State: AOAM532LVWTVzG4B6KddcxJV0z7ZgyVeRLeVjZGzNmGIvIicWtliDbwU
        w/XOZuptw4xnnO+nJDwMVw==
X-Google-Smtp-Source: ABdhPJyQZCJea37RRp0wPPTpjcG5B5YEc2fW3prsf1QYQ/lhvUwj6e81S4Bo4n6TCsH/D9uM6sETTw==
X-Received: by 2002:a05:6830:2428:: with SMTP id k8mr6223477ots.57.1629312688240;
        Wed, 18 Aug 2021 11:51:28 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g10sm81438oof.37.2021.08.18.11.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 11:51:27 -0700 (PDT)
Received: (nullmailer pid 2905622 invoked by uid 1000);
        Wed, 18 Aug 2021 18:51:26 -0000
Date:   Wed, 18 Aug 2021 13:51:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: memory: convert TI a8xx DDR2/mDDR memory
 controller to dtschema
Message-ID: <YR1WrqkZGZaqDQzt@robh.at.kernel.org>
References: <20210818113248.85084-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818113248.85084-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2021 13:32:48 +0200, Krzysztof Kozlowski wrote:
> Convert Texas Instruments da8xx DDR2/mDDR memory controller bindings to
> DT schema format using json-schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../memory-controllers/ti,da8xx-ddrctl.yaml   | 35 +++++++++++++++++++
>  .../memory-controllers/ti-da8xx-ddrctl.txt    | 20 -----------
>  2 files changed, 35 insertions(+), 20 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti,da8xx-ddrctl.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-da8xx-ddrctl.txt
> 

Applied, thanks!
