Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDCA4211B6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 16:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhJDOon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 10:44:43 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:40691 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbhJDOom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 10:44:42 -0400
Received: by mail-oi1-f174.google.com with SMTP id t189so21810331oie.7;
        Mon, 04 Oct 2021 07:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jLi+zvTcPBdSi3uAI5y27tr3d55lBMSMYRjbfwJHoK4=;
        b=q/kIsz4Bd4X4OEUpGkDzUf+OWY7KkAK+6QNhvyuUh1T0b+mQo41mY/v1GyF0ds3HrC
         4Ekmu+7mY2vy+cUArVk823FPvTuUQU/tW8i/GAD7IiJt3K0GCH532hCqMDQsmUkv4apJ
         h/x8T42VboIj7QN2QuXpvwrcxnEZnVOKCMb/jxfnLjOwIcQZU4JQfoHLfxJPqc1Gw+Td
         I3r1Thiiu64piTH1viCO3mAUhqXRH+1LlaUvUUAxtigE4YOQPMnBumJVhBRJ1XvlrNGH
         aS6wIJKN2rOSQK6BNBWtYX645Tc0eztZCQNJJlncUjgedVadSr/Yyl2OFXgMWxiDlRLk
         5RNw==
X-Gm-Message-State: AOAM532jjnOPEtwBzl0r7s1wMIRTI/f6eYyPQYOEueoX/Iad+0ZKDOHu
        +Ta/cXVPfgkeyMTpHrfbXQ==
X-Google-Smtp-Source: ABdhPJwFVhVHZiT52Mp5NnkMkPwiAubk1K7QsnCTn/ftI+/c23Em+F3YbHdrtFtBTx0GwCi2/Onp+w==
X-Received: by 2002:a05:6808:bcb:: with SMTP id o11mr13490894oik.168.1633358573014;
        Mon, 04 Oct 2021 07:42:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 14sm2742983oiy.53.2021.10.04.07.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 07:42:52 -0700 (PDT)
Received: (nullmailer pid 1264769 invoked by uid 1000);
        Mon, 04 Oct 2021 14:42:51 -0000
Date:   Mon, 4 Oct 2021 09:42:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-clk@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 07/10] dt-bindings: mfd: samsung,s2mps11: convert to
 dtschema
Message-ID: <YVsS60gb1ZuF42N8@robh.at.kernel.org>
References: <20211001094106.52412-1-krzysztof.kozlowski@canonical.com>
 <20211001094106.52412-8-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001094106.52412-8-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Oct 2021 11:41:03 +0200, Krzysztof Kozlowski wrote:
> Convert the MFD part of Samsung S2MPS11/S2MPS13/S2MPS14/S2MPS15/S2MPU02
> family of PMICs to DT schema format.  Previously the bindings were
> mostly in mfd/samsung,sec-core.txt.
> 
> The conversion copies parts of description from existing bindings
> therefore the license is not changed from GPLv2.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/mfd/samsung,s2mps11.yaml         | 267 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 268 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/samsung,s2mps11.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
