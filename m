Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DAB41CF1D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 00:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347233AbhI2WNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 18:13:10 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:41523 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347092AbhI2WNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 18:13:07 -0400
Received: by mail-oi1-f175.google.com with SMTP id s24so4772546oij.8;
        Wed, 29 Sep 2021 15:11:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Xe2Jz+HG0oynCJl0Rh79iqr/d53l3gDFqX1VxKfAJeg=;
        b=ef0UsrVKgGoh2JfiUG3ctWAjc8LZl88Vjf1AN6V+4wdsZAgnNHuSPt2djHDjuYk1cg
         shusupkpdqo8QzW9E+MHin1WUYGBUaQYEn82MAEYTpmwzRYByO0J+6yp9Ek9oW1XD4MW
         Vb6YBIJrUSrbU1RVLnZNiKggz6SJxQ49msw5bILbSjJc0zjlKaVHUksM6N/zf/bxZec1
         JVEsMQ4LyB8/z+I+Ej8rppNYqub9Mp9ZVpQZWSicpL++Z0ZuV6Gw/VWFE0CNcHXKZAMI
         /yJDo6wYSPTiCejOAEKSeJHq2JYWV8KoGFymbKj635twZ1VZ7RHOIMtKhcLuGAOvsXAJ
         GTzA==
X-Gm-Message-State: AOAM530EsT1VEGJkjTJklFS9sl9iUsagZ0No7tDXfK+RUdIAVYrDLPvg
        OM+40Yc1M3Ilduae5JI/hA==
X-Google-Smtp-Source: ABdhPJy/+/VB5A39jM44w1plBCdCfDo7DjkavPi1UzNuFA1EpZDX2UQk/OCAu6tqg2tZ2h0FWKJbAA==
X-Received: by 2002:a05:6808:309f:: with SMTP id bl31mr17941oib.41.1632953485705;
        Wed, 29 Sep 2021 15:11:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k2sm207954oog.5.2021.09.29.15.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 15:11:25 -0700 (PDT)
Received: (nullmailer pid 313269 invoked by uid 1000);
        Wed, 29 Sep 2021 22:11:24 -0000
Date:   Wed, 29 Sep 2021 17:11:24 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     linux-kernel@vger.kernel.org, joel@jms.id.au,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        openbmc@lists.ozlabs.org, osk@google.com,
        linux-aspeed@lists.ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org
Subject: Re: [PATCH v7 3/5] dt-bindings: aspeed: Add UART routing controller
Message-ID: <YVTkjKdXcyIVImmP@robh.at.kernel.org>
References: <20210927023053.6728-1-chiawei_wang@aspeedtech.com>
 <20210927023053.6728-4-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927023053.6728-4-chiawei_wang@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Sep 2021 10:30:51 +0800, Chia-Wei Wang wrote:
> Add dt-bindings for Aspeed UART routing controller.
> 
> Signed-off-by: Oskar Senft <osk@google.com>
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.yaml   |  4 ++
>  .../bindings/soc/aspeed/uart-routing.yaml     | 56 +++++++++++++++++++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/aspeed/uart-routing.yaml
> 

Applied, thanks!
