Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819123EF5A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 00:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbhHQWTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 18:19:19 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:38538 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234474AbhHQWTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 18:19:12 -0400
Received: by mail-ot1-f42.google.com with SMTP id 108-20020a9d01750000b029050e5cc11ae3so320804otu.5;
        Tue, 17 Aug 2021 15:18:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hH6x0kKNvTVTngzAJglfbn28xI8QAAWrgkjyn1ogaAA=;
        b=ZyXGhcuDnO0+Dk5sMD967Q07buGcAiYkL52moxSVei8j+tfZFH29Q4FPGE2PAnBOIV
         lLtR/d6whN8Dy9fMgAPwHO4cb8oUDXhqJGnuPjZb8XrPUEbAAtH+dNdGIkPGPTEIGCg0
         Ek5XgTsysaaGPeDEjptrhqM4H5tP4tL1wiNtqRe04K7iyE7I8QB5gTl841k+rbA1FNv4
         nwZ8sgtCZwEhs0u+Qplq0ONFHQoIbMhlFtAujt5G9m0CqqFgMScHpIfb2QAKqmYlhDyz
         lIvoCJ6KMfzIbSzHTTkDEGd7t5ohbsfcwHHaGWQcIu+tyDy/Is/jfe2LbJCLouTyVZSE
         B5rw==
X-Gm-Message-State: AOAM531R9o8nNoVL/Y+8Hj6Nsh4w58g+j5QBnKkd1oiwz9ZXOucSysvG
        4N7BcUrAKl3PelGjYgL4Rg==
X-Google-Smtp-Source: ABdhPJyZkwXaIBIiV+RYqjeipQRsYMSwJcPUjKRxBFM10YNTOL1cqAvlf+PDs3/94oHBkGxuqgjARA==
X-Received: by 2002:a9d:77da:: with SMTP id w26mr4522551otl.293.1629238718681;
        Tue, 17 Aug 2021 15:18:38 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s12sm654598otk.21.2021.08.17.15.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 15:18:37 -0700 (PDT)
Received: (nullmailer pid 939324 invoked by uid 1000);
        Tue, 17 Aug 2021 22:18:36 -0000
Date:   Tue, 17 Aug 2021 17:18:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     alexandre.belloni@bootlin.com, soc@kernel.org, arnd@arndb.de,
        nicolas.ferre@microchip.com, linux-arm-kernel@lists.infradead.org,
        olof@lixom.net, linux-kernel@vger.kernel.org,
        ludovic.desroches@microchip.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/7] dt-bindings: ARM: at91: document CalAmp LMU5000
 board
Message-ID: <YRw1vN9KHSY1hCmR@robh.at.kernel.org>
References: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
 <20210816064416.1630674-4-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816064416.1630674-4-claudiu.beznea@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2021 09:44:12 +0300, Claudiu Beznea wrote:
> Document CalAmp LMU5000.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---
>  Documentation/devicetree/bindings/arm/atmel-at91.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
