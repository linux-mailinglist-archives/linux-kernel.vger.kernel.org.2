Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8094D399454
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 22:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhFBUM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 16:12:59 -0400
Received: from mail-oi1-f182.google.com ([209.85.167.182]:45728 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBUM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 16:12:59 -0400
Received: by mail-oi1-f182.google.com with SMTP id w127so3867522oig.12;
        Wed, 02 Jun 2021 13:11:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3gem2VAQRvFplAWFQHGfada4VjRLkmbUR91Bl8uiQ1Y=;
        b=K9vOG1p/qCBaZt+dB3SGd71eyFiFeKIvfWelc+PUAjKr0+s8M7HZ6EpLeOa2APdwbC
         LTDsYM/H/BGltd9xdzU+67hlVFe4J3UvSuK1HNJ1BCVrD4f4bXVSU04C2W/WdqHMuTpL
         7pw3xiCTiRz+Go1TRRFtTxsIY6tx6KsH1eFBLa7aUfcgyZM/ITBIBdIrWQptSMklFa6+
         U7+Tq764rfwTZL5i9nE4eJG6IhPYf1fJbjCHzvY2T8oj41ZXLc/CsCIv6IZgzem+nFB0
         yaTT7mM8gq/n8PLDFcHk2Cv+49P7U3C1S06mtrIPnL56vwnwIesE6xshGatUZPuDW7hS
         aEDQ==
X-Gm-Message-State: AOAM533119/FrdeK1oS2XR8/1vpAOgEpaSDSm+Ad4UeW3vLXj1K5vi4f
        oOzp05AY+6Pw7ubIWIcquQ==
X-Google-Smtp-Source: ABdhPJxT77S6h3/WeXIguRZu6ZOD+xXpJHz/pe3tDit/4kfpDjhc2sr3vDTaUncOXiOF5Z8fwjEouw==
X-Received: by 2002:aca:654d:: with SMTP id j13mr4974972oiw.125.1622664675540;
        Wed, 02 Jun 2021 13:11:15 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u6sm202482otk.63.2021.06.02.13.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:11:14 -0700 (PDT)
Received: (nullmailer pid 3909398 invoked by uid 1000);
        Wed, 02 Jun 2021 20:11:13 -0000
Date:   Wed, 2 Jun 2021 15:11:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     cy_huang@richtek.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, broonie@kernel.org, devicetree@vger.kernel.org,
        lgirdwood@gmail.com
Subject: Re: [PATCH v2 1/2] regulator: rt6245: Add the binding document for
 Richtek RT6245
Message-ID: <20210602201113.GA3909335@robh.at.kernel.org>
References: <1622092449-21461-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622092449-21461-1-git-send-email-u0084500@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 May 2021 13:14:08 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Add the binding document for Richtek RT6245.
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
>  .../regulator/richtek,rt6245-regulator.yaml        | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rt6245-regulator.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
