Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105CA4213C6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236621AbhJDQPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:15:49 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:45928 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbhJDQPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:15:48 -0400
Received: by mail-ot1-f42.google.com with SMTP id e66-20020a9d2ac8000000b0054da8bdf2aeso19972449otb.12;
        Mon, 04 Oct 2021 09:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9pHNGaYLedy2/rF6U3XjvOEGSg4O6NG7AmCNgzokAII=;
        b=pdsjDxYchdmsNrpmhRsdylevGXg4j50AR/DYqaNdzgNHq4poxFGwduYEem9LmSuPuY
         rrSqYIdiZXacksAp3gKJy/9A3l3lIrjKb11i0EZI9pTqIcYNVgELQm4NqFumEshvQ2Vo
         mwK8q8whcO3ZyK0NerY5sMdlV1tzp6poERhzahaHUKp8H6yDv9Ggqy/PXZ5EQM3x7eIg
         xTG8n513XmHnN/4adRGDIUAAqyBOLezntR59bXWiY8Zde1yYXuWJ7M4ujVjzHGnp/puY
         vwExCU4btmeDyoYo3nUoymZ8xmWwGQfYBt4Ptm2/fCsO9eIv6IbjyYsTCIMqCqhLX1/F
         g4uA==
X-Gm-Message-State: AOAM5300QrR09C2NHNRwJNo/warYXrYPqJeNnVD5sCQSkFzzmQWLfBmB
        o4CIAQFntl9Z+J8PbnfLc1uzck9IHw==
X-Google-Smtp-Source: ABdhPJwEZ0BagtJN5AvO5EZ9ML2djYGaYoHOHyT3OzZOwd/LIqJLqZZn3Xe+N+lNuESlzTYBZLD//w==
X-Received: by 2002:a9d:7f8b:: with SMTP id t11mr10447457otp.363.1633364038792;
        Mon, 04 Oct 2021 09:13:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d4sm3005196oth.47.2021.10.04.09.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:13:58 -0700 (PDT)
Received: (nullmailer pid 1397999 invoked by uid 1000);
        Mon, 04 Oct 2021 16:13:57 -0000
Date:   Mon, 4 Oct 2021 11:13:57 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 2/2] mfd: dt-bindings: maxim,max77686: convert to dtschema
Message-ID: <YVsoRSrqPRIhLgP/@robh.at.kernel.org>
References: <20210928141353.112619-1-krzysztof.kozlowski@canonical.com>
 <20210928141353.112619-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928141353.112619-3-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 16:13:53 +0200, Krzysztof Kozlowski wrote:
> Convert the MFD part of Maxim MAX77686 PMIC to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/mfd/max77686.txt      |  26 ----
>  .../bindings/mfd/maxim,max77686.yaml          | 124 ++++++++++++++++++
>  MAINTAINERS                                   |   1 -
>  3 files changed, 124 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/max77686.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max77686.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
