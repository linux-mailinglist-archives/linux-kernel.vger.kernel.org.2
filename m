Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CDE84129A1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 01:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240506AbhITX7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 19:59:53 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:46906 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbhITX5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 19:57:53 -0400
Received: by mail-oi1-f180.google.com with SMTP id s69so19633953oie.13;
        Mon, 20 Sep 2021 16:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c93NXpgi+p5XaCllWBXTLuYEA3fNOgZcX/nvr8ucDT8=;
        b=WDbnSz6YG2N71u645N4/vExLmcrvNafF/n1RBeyQaP9VV/Q1/1b3Pm9jvwb4AAtXpP
         0SYBSgCQIFq1k4lC7zbG5l/UZ2LD6zCrp/BP0OMP7nuAvca9R6oY5yzExM+mmy76kp0Y
         8LRERTl7WxnVDzJPT6HFmefMhRG8GZmE+T2ckq2SjHR7ZQz+uCggEuG/rBe0WdGXqtLC
         CCJYJufrN2OrMsWBD+5UUSdy8WxjRJWdH/95wMFEJHf36R8weA/T+Vyu1D5aQrYO9I0F
         soQ8xL3+K+/SGvPSeqn0FDZnGLAcPMyhRm/tpOdRMd5eQ5aciqhv19rQccXlMVI54F4F
         nqtQ==
X-Gm-Message-State: AOAM532mwJmgG13g6ao5jFcy3EswxDHr98HPKoylBilCjNxp1N9fPsEb
        HStZhxK6KnyezOpIB74w81TSbO4eKg==
X-Google-Smtp-Source: ABdhPJxbShQYydLWhlk/xGNiMTT7AzAb2ftOT6Bl3SAFnSA368SVgvPwj9OmarpSNVanmN5IIk0uVA==
X-Received: by 2002:aca:afcc:: with SMTP id y195mr1309932oie.71.1632182185308;
        Mon, 20 Sep 2021 16:56:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a11sm3462634oiw.36.2021.09.20.16.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 16:56:24 -0700 (PDT)
Received: (nullmailer pid 1068768 invoked by uid 1000);
        Mon, 20 Sep 2021 23:56:23 -0000
Date:   Mon, 20 Sep 2021 18:56:23 -0500
From:   Rob Herring <robh@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, lokeshvutla@ti.com, a-govindraju@ti.com,
        kishon@ti.com, linux-phy@lists.infradead.org, robh+dt@kernel.org,
        vkoul@kernel.org, mparab@cadence.com
Subject: Re: [PATCH v2 03/15] dt-bindings: phy: cadence-torrent: Rename SSC
 macros to use generic names
Message-ID: <YUkfp/sARPD3i82R@robh.at.kernel.org>
References: <20210908122930.10224-1-sjakhade@cadence.com>
 <20210908122930.10224-4-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210908122930.10224-4-sjakhade@cadence.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Sep 2021 14:29:18 +0200, Swapnil Jakhade wrote:
> Rename SSC macros to use generic names instead of PHY specific names,
> so that they can be used to specify SSC modes for both Torrent and
> Sierra. Renaming the macros should not affect the things as these are
> not being used in any DTS file yet.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
> ---
>  .../devicetree/bindings/phy/phy-cadence-torrent.yaml      | 4 ++--
>  include/dt-bindings/phy/phy-cadence.h                     | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
