Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E754934B84F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 17:47:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbhC0QrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 12:47:03 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:41788 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhC0Qq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 12:46:27 -0400
Received: by mail-ot1-f46.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so8212299otq.8;
        Sat, 27 Mar 2021 09:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y/BVIqm9Jq7ZW/Oco7OKjjg+344uTpacMlZauU6/8hk=;
        b=C2pcwv1nuRXXn6vxthFB6RySupJRagSJScHdlXJ1M1S5+2XtAPl7BPCoDi89xX3sBA
         H9AMC2gpFgKHAMzQlEux1lFV+vEgXRIiCbZdLjm27G+zNY4kIWQb9BerXHd427X8vBTw
         RauMUVm/18UtuJpBJfX3MONRhVt9W4C27fPil4xOQzMbQ/njm7CLu4gdtT7LnnqdYoEa
         dafpPFzEXugaOWvTiOQWW+eWnPi5FVi4GiXnIP7ZXh6E03ksbtgZlxlfXh5PqfcmdOnI
         wizVw0K8RgspYG6FmzX3AwzQEyRwZk+5/dLc0Hqy8dtFD1wcUGfOejzhYm8Jcg/xsi5/
         q0KA==
X-Gm-Message-State: AOAM533ZvSTOtKEi4vOuOFxVP3T+CFsYAolZL6hf3lvoNpDk0pNB+xUr
        Z6IAZSwl0YynzVxkW7LtIQ==
X-Google-Smtp-Source: ABdhPJyiLlMULt5oNPhCIY5FnTQM5utBQb7deddBIqLmXy1AE+0nSH5lAm87+7eTA9wy1ATfu+orfw==
X-Received: by 2002:a9d:d89:: with SMTP id 9mr16655449ots.23.1616863586920;
        Sat, 27 Mar 2021 09:46:26 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.99.140])
        by smtp.gmail.com with ESMTPSA id u2sm2467871oic.28.2021.03.27.09.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Mar 2021 09:46:26 -0700 (PDT)
Received: (nullmailer pid 225171 invoked by uid 1000);
        Sat, 27 Mar 2021 16:46:22 -0000
Date:   Sat, 27 Mar 2021 10:46:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/5] dt-bindings: timer: Add compatibles for sun50i
 timers
Message-ID: <20210327164622.GA225116@robh.at.kernel.org>
References: <20210322044707.19479-1-samuel@sholland.org>
 <20210322044707.19479-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322044707.19479-3-samuel@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Mar 2021 23:47:04 -0500, Samuel Holland wrote:
> The sun50i SoCs contain timer blocks which are useful as broadcast
> clockevent sources. They each have 2 interrupts, matching the A23
> variant, so add the new compatible strings with the A23 compatible
> as a fallback.
> 
> Acked-by: Maxime Ripard <maxime@cerno.tech>
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
>  .../timer/allwinner,sun4i-a10-timer.yaml        | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
