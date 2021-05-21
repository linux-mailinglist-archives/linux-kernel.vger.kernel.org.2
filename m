Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6931938BC2D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 04:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238146AbhEUCCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 22:02:20 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:36570 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbhEUCCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 22:02:19 -0400
Received: by mail-ot1-f54.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso16682342otn.3;
        Thu, 20 May 2021 19:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eYAL0SQZfqse54W9hf+La4gHbbjMqJ8q2D/DcvhsGk8=;
        b=EZsqwbW61EOQ3diRxrZY+DcxLnDhtnTo6xRHDeRu+0XKtYxqLkLQhI7j2PYb0Aypbc
         BvLj8+uN7mYOuxp1p9DZUFMe/hfC4e+lwYLIS4icTlE5PkvdB/q4aS4mZ2SWv5nKigvT
         LlQ8KfL2cVBkg0dgbog+//jbD7jXjuPzjfhqGlLpZqatiIRpf2tLQiDv0TGzaLS0d+Xb
         DT+YIpXb9nx3tApDjjaK1Uzb1t0CXhEuV3awLT77mg7bkJf2LfVzVwLEWrR/r80rksbm
         zQSF9opGXEXBivBANzDlucv5Sx4WwlgKLNVJMAMcicpFIgR2mfsdVAKztr52jiZ3w0Ou
         5ftg==
X-Gm-Message-State: AOAM530yI7L7XHyCDuywj49N4di1RLvGsm4UntT/paqYN5zQe8nUGOwH
        SHKoimiH33JJ/SvesURjUQ==
X-Google-Smtp-Source: ABdhPJwQri+efVDl5VKRU4Kwy8jU2xTma3SwAw/7SLFL+NLfmUmQFW5hE6CoCDkahmDE7XkVWVQahw==
X-Received: by 2002:a05:6830:90f:: with SMTP id v15mr5965449ott.223.1621562456085;
        Thu, 20 May 2021 19:00:56 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id f2sm977768otp.77.2021.05.20.19.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 19:00:55 -0700 (PDT)
Received: (nullmailer pid 2500985 invoked by uid 1000);
        Fri, 21 May 2021 02:00:54 -0000
Date:   Thu, 20 May 2021 21:00:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     robh+dt@kernel.org, ulli.kroll@googlemail.com,
        linus.walleij@linaro.org, daniel@ffwll.ch,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        airlied@linux.ie
Subject: Re: [PATCH v2 1/3] dt-bindings: display: convert faraday,tve200
Message-ID: <20210521020054.GA2500924@robh.at.kernel.org>
References: <20210519203547.837237-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210519203547.837237-1-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021 20:35:45 +0000, Corentin Labbe wrote:
> Converts display/faraday,tve200.txt to yaml.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - added two subsequent patchs fixing issue found when converting
> - fixed all issues reported by Rob Herring
>  .../bindings/display/faraday,tve200.txt       | 54 ---------------
>  .../bindings/display/faraday,tve200.yaml      | 68 +++++++++++++++++++
>  2 files changed, 68 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/faraday,tve200.txt
>  create mode 100644 Documentation/devicetree/bindings/display/faraday,tve200.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
