Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBD638C06B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 09:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbhEUHKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 03:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbhEUHJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 03:09:08 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342D4C06138A
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:07:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x8so19932638wrq.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 00:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=UVrA5QFmTG2iIlOXpk2fw/hbPPuOvcNlfWC7IQPNV58=;
        b=kbidLdCxWZFiiIM5BEmAaoLdQU6U9sSuZ+i+mq+7g6fCxMGFMjqUNI4fTKZpXF8aSC
         6RRHzQ5E5wKYE4srG3qVEQNFat/Qlj1UsoC4Jhed//SdZatfanpn0kopRBMI2tI+/wpy
         tDnyAF2d/byQJG3kYcH/9cUqAtCrn+U3FAkJrTPf5mTgbVx/r2DPyZNkqKB7c9Lk6boI
         x8adcNL29QqHL0avnFujAIs22suk52BieNXuVTLC/1670dS64xKcRrs1nPxLOX7sl0mN
         cb666+nYKARH+tEAzJQc4e3xfry31JX46pyeIKXpWuulJ+k1Xi44QQOv09VrGsSBd/OO
         npUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=UVrA5QFmTG2iIlOXpk2fw/hbPPuOvcNlfWC7IQPNV58=;
        b=cYxDcCJghY8Qtkl9Ute8WgMCQfaDxGv3C7DVxWDpD0H9ObuYmVyQ9FQVxWI1OHeIbi
         Bn9adN3EsR3ECGhLeJZJBRMEvfQljjOaeHk2QhFZX9NgO0KySzc0R0fbSHvN666Lj/xC
         LWtj8wvQaysuYT5K56myCnR3oTElvLmO3JcPOox59drvzX+o7RQFaTWhAko0eqQxdqm/
         fOOa4C3rFNE37KsZcSTBMMsphMUOo96VJVHu5NoQNLf938JkFB3g5rZYni+TFsdDFt21
         xFUDpglEGLJgtpkP89KzlOO7Jr5QVK7ygiLWAloAaE8b4Z3p4LXbFAeYB+1Us+CC+QSG
         pYCg==
X-Gm-Message-State: AOAM532yfzvjFAUxL3u2fWPGQcXRr4NTEVelf6QGhH6hcM/mrFp2p6Ac
        jA9PCcUeIDLDWgXGQE80AUuP4Q==
X-Google-Smtp-Source: ABdhPJz9FNkCozvTfwBbqDoQ+ssjunqvKn45GHrAiNLpEwNHjUFzbjSKSF7Go7nPY3Dep7yQ1scz1Q==
X-Received: by 2002:a5d:4b89:: with SMTP id b9mr7848043wrt.238.1621580863866;
        Fri, 21 May 2021 00:07:43 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id z6sm5164258wml.29.2021.05.21.00.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 00:07:43 -0700 (PDT)
Date:   Fri, 21 May 2021 08:07:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel-team@android.com
Subject: Re: [PATCH 03/39] mfd: ioc3: Directly include linux/irqdomain.h
Message-ID: <20210521070741.GS2549456@dell>
References: <20210520163751.27325-1-maz@kernel.org>
 <20210520163751.27325-4-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210520163751.27325-4-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2021, Marc Zyngier wrote:

> This driver include linux/irqdomain.h via a bizarre set of
> indirection, which we are about to break.
> 
> Directly include the required file.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  drivers/mfd/ioc3.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
