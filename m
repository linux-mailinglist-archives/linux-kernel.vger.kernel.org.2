Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD689389225
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 17:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348497AbhESPDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 11:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242412AbhESPDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 11:03:01 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5909C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:01:41 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n2so14448314wrm.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 08:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=c0+Rd0cN2Kxw3wKjuJyw1Wk3NaAqV4eEJpjpMHxfUv4=;
        b=kcd3FqRM5X5eqTTvuyfAWPDoWUsD4/bk52rm15XClI+2cg1leIUR+vrZb8DKHOe6VY
         iyHIvTrO3o+gR8f9WPl2A/EIHVM8YjcxIGtgYEZTxq+nXfjbcW/QVD5xI+8o5GKpimwT
         3rX4OSoTVYwIBrPreaRPlWF4JA86oGbujIuK6u2i/xvHLO8/BObruVW0yC92P1TohZYa
         +VA/RNi3hY88h/dvLwhsIW/swdFXWrxAG4P9T3gk7q31a3suE4L+2vT2b1qS126/P9Gm
         JgaNg0sCOu75FiikrKvhJzQg6XGEjpzPf7D6FIUDUDaLg4taods3VzxYs3q+LMhYv2Kv
         /GMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=c0+Rd0cN2Kxw3wKjuJyw1Wk3NaAqV4eEJpjpMHxfUv4=;
        b=DybxJsYGFZDjW6TDNUzsyq7Zd+/WvFSG3sk5MIxTwjRjpvtdiA5waHFZUTvWNSKEG3
         r9r9XvKBy0EWsLqYrrlCKtCYYPDgsUrMCtSkBR1uqvo2UWXoX8j+Zep3KhtI02ypxBKA
         mY5o8m0y9VmJTzmQK8WGlm6AOKuctjIT5nTDknLTZ4ljlUszNFA/S1TAcivV3+xUfSif
         rSHdbTJbO3uQ6AbHisCNCZtGX7sGtQz0qDwObdIb0aCjbwO0s0a7+KM9yTHB4QVVyriT
         wgzH7zIEwAiYv56R+jXHAGg1oEfLQU3A4nEZxF8amfB2qO0/hzXhYr/OqTeBWmgERrco
         mJRA==
X-Gm-Message-State: AOAM531dgwliTVYEsMjsrQ/UC5jpqgL0bhb4SguCipEhAFRHNYPj4iD/
        OReyoeIhiBnT7c7NVYBZQfFS5g6enF0yVg==
X-Google-Smtp-Source: ABdhPJy7knz9TUpnkbC+wqZIWQaUoocLsIedqxu7VoxDQCx+5R5XOPgJt/z9xw6/DeDVn71JvZHbeg==
X-Received: by 2002:adf:eacf:: with SMTP id o15mr1448508wrn.219.1621436500429;
        Wed, 19 May 2021 08:01:40 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id a23sm9890212wrc.22.2021.05.19.08.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 08:01:40 -0700 (PDT)
Date:   Wed, 19 May 2021 16:01:38 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Herring <robh@kernel.org>, Icenowy Zheng <icenowy@aosc.io>,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/17] mfd: axp20x: Allow AXP 806 chips without
 interrupt lines
Message-ID: <20210519150138.GK2549456@dell>
References: <20210519104152.21119-1-andre.przywara@arm.com>
 <20210519104152.21119-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210519104152.21119-3-andre.przywara@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 May 2021, Andre Przywara wrote:

> Currently the AXP chip requires to have its IRQ line connected to some
> interrupt controller, and will fail probing when this is not the case.
> 
> On a new Allwinner SoC (H616) there is no NMI pin anymore, and at
> least one board does not connect the AXP's IRQ pin to anything else,
> so the interrupt functionality of the AXP chip is simply not available.
> 
> Check whether the interrupt line number returned by the platform code is
> valid, before trying to register the irqchip. If not, we skip this
> registration, to avoid the driver to bail out completely.
> Also we need to skip the power key functionality, as this relies on
> a valid IRQ as well.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/mfd/axp20x.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
