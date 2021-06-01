Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B716339772C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbhFAPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbhFAPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:51:48 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14ECC061756
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:50:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id h3so8510064wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WdETsCRKY4os9kllNCB4jSefDrVkhrCY6bqwrR0XeTw=;
        b=gddUDKq8PpQrhDh2XK3F6MMe5HbMGjC6l9SoxQ5sC9Fd30FUCB08CWBakDshCYQmBM
         6lWGK2tDdV1rv/WXjuohz8XG/DMY+Jf6Y83nchdRii0wJXQrv0eQVflubk0ql4/7bcLY
         xqSSkNniR2rBTb9x/zdj3Dh4uNAGRYc8hfbmvH6PdW1l4a7LYPAzb6q2OeRnjLyKBMFe
         nA2gCXwbqhU8l2NrYAsjlAcL2ki0tC7Pzl3TK9XJsIOTppPyY9Gs+FNKm84rj+nBRiZk
         1YqejYf24mcrGKFS2cHx+z4LiX+jKYmRCVzzpRFA1fimvl6AFG3heEFkfWjMRESu67l4
         Nkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WdETsCRKY4os9kllNCB4jSefDrVkhrCY6bqwrR0XeTw=;
        b=uBQUK4roeAzX7bsFC+sVu6erOzmLQQjih0MM6577C5E2s+U4jaRuKNiUA3KHbKqvBM
         1TsEMdpKud3QwNMIDmxkJAmTIFpERi09tDg+7PzT86E3HtcHdMW449Rzl3sIBRXAJpNU
         o62+6SX17AG1d0PwsjxJ15OhM7A0vmhBW1YuedsacssUJCoZHXVW0vpeCdSJVv97LayI
         38DL0HNupBGwMHdy2BlapEWtQwH7Oz4yUfCr+3KjCI9EQwTQaxCXpyvtGg6fD01w8yLZ
         82ua1jdv7jVVruxqg2jmnXmH53HEOm4nglnjlwqr2l3zJQN7z1mr2wJXydOSsEs5nVoI
         xpEg==
X-Gm-Message-State: AOAM530GvtHSYsGF/Wq4dpqyYdlKy/srjwTpaDsosYnXDuXPWMgLL4ri
        4iRbC9xxnb8UqZZtePKwZYKyOw==
X-Google-Smtp-Source: ABdhPJxm/6kOzJAMLbPyTQnHiUuT3hRimVa19PcjdNU3xnm14yvjNYHVap2PwllbKoR3LOA/NjtnIA==
X-Received: by 2002:a05:600c:2054:: with SMTP id p20mr562349wmg.165.1622562604490;
        Tue, 01 Jun 2021 08:50:04 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id 25sm2949103wmk.20.2021.06.01.08.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:50:03 -0700 (PDT)
Date:   Tue, 1 Jun 2021 16:50:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, Peter Rosin <peda@axentia.se>,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-i2c@vger.kernel.org
Subject: Re: [PATCH v2 1/6] dt-bindings: mfd: ti,j721e-system-controller: Fix
 mux node errors
Message-ID: <20210601155002.GB2165650@dell>
References: <20210526184839.2937899-1-robh@kernel.org>
 <20210526184839.2937899-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210526184839.2937899-2-robh@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021, Rob Herring wrote:

> The ti,j721e-system-controller binding does not follow the standard mux
> controller node name 'mux-controller' and the example is incomplete. Fix
> these to avoid schema errors before the mux controller binding is
> converted to schema.
> 
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../mfd/ti,j721e-system-controller.yaml       | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
