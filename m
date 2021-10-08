Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 282E2427272
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 22:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbhJHUmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 16:42:47 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:44976 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbhJHUmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 16:42:46 -0400
Received: by mail-oi1-f174.google.com with SMTP id y207so12127207oia.11;
        Fri, 08 Oct 2021 13:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sJzsstFMEERhrGlERXPhJO68F8mqf34Jpfz/P1SCtNo=;
        b=iw2R1GmegoXsWxEaTU9yRFKS1zFXFg9oQoZW+PO6qGDhwN8w8RfxNUmm9E2gpk1Z3+
         qauCGaLGUCOvgUkWQgd2rsXgJe3LNOyiKsO9NlPyZD5z8Y+3uUbSQygANczIi5xnN7y6
         LSxc3Ms/TZ90fOAQ4ad1Z8qSEAd+5v5+2uh233HhMJwiFna4MCCgoUsT2JKAyHWP9ohE
         61Mh1YNc7wavd7fT0u/91T3sv+Z/7MkptoNyoW7V1zPGx7ecnrc3IcsIQEAllv/Gb0Vv
         DCC0b1A6HEE4YWdW8R3eI6cGjVel8J1DUD0XaxTd3Xf8FGwaCtNS1mAkSoHPIkUMs9vS
         ZUZw==
X-Gm-Message-State: AOAM530wZqpYI6fcaa32yxJRrdV0sfV1UnQEb+rMsKkJzTco7Yk2y1d2
        CDQ083FvbcahsWiAdNUTlQ==
X-Google-Smtp-Source: ABdhPJxFSo4/P7aevnhos/zTLz1XBpMJUQLj8h2Z8dVI2TARtfUN+nDtk93MxkzcUn0EmGPQdx+K3A==
X-Received: by 2002:a54:489a:: with SMTP id r26mr9613388oic.158.1633725650761;
        Fri, 08 Oct 2021 13:40:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bh39sm130431oib.37.2021.10.08.13.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 13:40:50 -0700 (PDT)
Received: (nullmailer pid 3282312 invoked by uid 1000);
        Fri, 08 Oct 2021 20:40:49 -0000
Date:   Fri, 8 Oct 2021 15:40:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: maxim,max77686: convert
 to dtschema
Message-ID: <YWCs0Zil/hZ3uL6F@robh.at.kernel.org>
References: <20211008123552.191384-1-krzysztof.kozlowski@canonical.com>
 <20211008123552.191384-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008123552.191384-2-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Oct 2021 14:35:51 +0200, Krzysztof Kozlowski wrote:
> Convert the regulators of Maxim MAX77686 PMIC to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> 
> ---
> 
> Changes since v1:
> 1. Split regulator nodes pattern on those supporting ena-gpios and those
>    don't.
> 2. Drop regulator-name from properties.
> 3. Add tag.
> ---
>  .../bindings/regulator/max77686.txt           | 71 ----------------
>  .../bindings/regulator/maxim,max77686.yaml    | 83 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 84 insertions(+), 71 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/max77686.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77686.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
