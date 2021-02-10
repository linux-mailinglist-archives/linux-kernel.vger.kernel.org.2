Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB813173C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 23:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbhBJW4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 17:56:23 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:40077 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbhBJW4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 17:56:19 -0500
Received: by mail-ot1-f45.google.com with SMTP id i20so3466834otl.7;
        Wed, 10 Feb 2021 14:56:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uv4aJWJYHGLjPveszWg3xJuq8jmg9zeXVRApkBKWByA=;
        b=n9q5VGf3v3KY6GbLMNLYUH7gS2VwicVN3QaD9YAux8jEwar4gqWRmeoXOKqgX1Kx9A
         4RZCIzIggxQjf7YVIeVQPD/Uryp38RffoQjmpdX6FhvsOmQX6A+/5KEQGI25D0FXo3dV
         qwCzWzh/IOT3y4Koc3QSkhrh/cJXdA5kaS+sdmeQLff0C3hoAFRc7Jz7E3hpLIJO2wu6
         wYT05ez0+p8lRVP+aW2lMevrGkpb1N+cgiMzYKi3Mzy1+lVccF0PtHQ2hHqtXe2toahp
         aircgXP2tJG+uasXQmeg9lIQQrDM3kJ27xzuZp8L9hBqFvFxx3SiYhUFf8nU0Rqs4Xci
         HNeA==
X-Gm-Message-State: AOAM530DxJchneenBoeVdJ+aFoXZOU/yTk0hncSN+gfwHKZ5YgpOVVzx
        uynuwe0o/S4ytzAXK3ftZw==
X-Google-Smtp-Source: ABdhPJyWT2qLAEOdHmFjAYVt7c27wJXJg0f0C4sn+bfsP3pe/e4IaBuYnyOdn5MWGeYnU3y8C9odLw==
X-Received: by 2002:a05:6830:2089:: with SMTP id y9mr3983782otq.200.1612997737887;
        Wed, 10 Feb 2021 14:55:37 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l67sm741684oih.57.2021.02.10.14.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Feb 2021 14:55:37 -0800 (PST)
Received: (nullmailer pid 2970438 invoked by uid 1000);
        Wed, 10 Feb 2021 22:55:36 -0000
Date:   Wed, 10 Feb 2021 16:55:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, rdunlap@infradead.org
Subject: Re: [PATCH] doc: devicetree: bindings: usb:  Chnage descibe to
 describe in usbmisc-imx.txt
Message-ID: <20210210225536.GA2968213@robh.at.kernel.org>
References: <20210203153315.15170-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203153315.15170-1-unixbhaskar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 09:03:15PM +0530, Bhaskar Chowdhury wrote:
> 

Ironically, a typo in the subject. Will fix when applying.

> s/descibe/describe/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/usbmisc-imx.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> index b353b9816487..b796836d2ce7 100644
> --- a/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> +++ b/Documentation/devicetree/bindings/usb/usbmisc-imx.txt
> @@ -1,7 +1,7 @@
>  * Freescale i.MX non-core registers
> 
>  Required properties:
> -- #index-cells: Cells used to descibe usb controller index. Should be <1>
> +- #index-cells: Cells used to describe usb controller index. Should be <1>
>  - compatible: Should be one of below:
>  	"fsl,imx6q-usbmisc" for imx6q
>  	"fsl,vf610-usbmisc" for Vybrid vf610
> --
> 2.26.2
> 
