Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923C4402E87
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 20:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbhIGSsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 14:48:08 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:44682 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhIGSsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 14:48:05 -0400
Received: by mail-oi1-f173.google.com with SMTP id c79so90623oib.11;
        Tue, 07 Sep 2021 11:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=39RQTTYF/amkcltUtDp9LhMGXFZN1q3yD/uvIqsnXMk=;
        b=cDvlou8VQhPKcTnHkXc1i5a1tAgMB7hd/p6/lPcQCcUSWGQaOycEjO3N8/sb6/84Sy
         bKgg9JsC/eJ/CsQjU4teUVLd7qPlp+UHK8C4RPuRTpKmOnH1fXif3gvFCVrkaDOTwTbn
         MFaYafUVbaYr84nki+1ocj5pn495tGizsuKsda/6pHW0z9JwkAP+WmPcc7b4Bh4GvHy2
         SNKkAqASSnNElknM74HmFVpK0X3CMBP71f1kqydV1JcYIGzsqY4hBBIF92fbi7wF9a7p
         Dn/RQZm+PJpiLICnBwwCrNCotVJm+W8fIEHIjera8Pht/fyUYP3OMX23e5MP5L0WIV8Y
         SX8w==
X-Gm-Message-State: AOAM531eUBCU2Gi5ea67FR1xf9tiB187VdpUk9ySUNLNoZCGQ38wOXDA
        sSshqPUm7/S1Cw4WfN9Bdw==
X-Google-Smtp-Source: ABdhPJyVUR3P16ERRVW6NSwGEUXMlTh132UXxmCNpEOyGRal5QtTecpj1eeGoYCTESeb/H0aRtjnAA==
X-Received: by 2002:aca:5f09:: with SMTP id t9mr3985991oib.157.1631040418971;
        Tue, 07 Sep 2021 11:46:58 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i1sm2384905ooo.15.2021.09.07.11.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 11:46:58 -0700 (PDT)
Received: (nullmailer pid 136986 invoked by uid 1000);
        Tue, 07 Sep 2021 18:46:55 -0000
Date:   Tue, 7 Sep 2021 13:46:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc:     joel@jms.id.au, andrew@aj.id.au, lee.jones@linaro.org,
        osk@google.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH v2 1/3] dt-bindings: aspeed-lpc: Add UART routing
 compatible string
Message-ID: <YTezn1TDatYs2FMd@robh.at.kernel.org>
References: <20210902021817.17506-1-chiawei_wang@aspeedtech.com>
 <20210902021817.17506-2-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902021817.17506-2-chiawei_wang@aspeedtech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2021 at 10:18:14AM +0800, Chia-Wei Wang wrote:
> Add the compatible string and the device tree description for the
> Aspeed AST25xx/AST26xx UART routing control.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  .../devicetree/bindings/mfd/aspeed-lpc.txt    | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)

Either convert aspeed-lpc.txt to DT schema or make this a separate 
schema doc.

> 
> diff --git a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> index 936aa108eab4..45d44f812e5e 100644
> --- a/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> +++ b/Documentation/devicetree/bindings/mfd/aspeed-lpc.txt
> @@ -155,3 +155,25 @@ lpc_reset: reset-controller@98 {
>          reg = <0x98 0x4>;
>          #reset-cells = <1>;
>  };
> +
> +UART routing control
> +--------------------
> +
> +The UART routing control manages the RX muxes among the UART controllers
> +and the I/O pins. This is typicall used for the Serial-Over-Lan (SOL)
> +service.
> +
> +Required properties:
> +
> + - compatible:		One of:
> +			"aspeed,ast2500-uart-routing";
> +			"aspeed,ast2600-uart-routing";
> +
> + - reg:			offset and length of the IP in the LPC memory region
> +
> +Example:
> +
> +uart_routing: uart-routing@98 {
> +	compatible = "aspeed,ast2600-uart-routing";
> +	reg = <0x98 0x8>;
> +};
> -- 
> 2.17.1
> 
> 
