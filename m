Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068CA43BDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 01:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbhJZX1w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 19:27:52 -0400
Received: from mail-oo1-f49.google.com ([209.85.161.49]:41706 "EHLO
        mail-oo1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240276AbhJZX1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 19:27:50 -0400
Received: by mail-oo1-f49.google.com with SMTP id t201-20020a4a3ed2000000b002b8c98da3edso291807oot.8;
        Tue, 26 Oct 2021 16:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=COX6qcOMv7vPVSkX300sUvDrTEmMuSLBZS7S2513Mmw=;
        b=MzKaAIoInez/5e9tHYr3sRvemPIHNB8M79eJ/f3yRxfzhY1jRzhuCHGlo0JcsvXHKk
         tnt7HngAYsAGy2ki3QlslmDegQwrUPh0LaNyrH8UllSx3+5ru0c7uR2ugVrWyxNV1vKc
         fkSYah1KV3q+kvZA7Ku0c0Dv7opPfvTOzUTvJdIfkcne31v+JNGXuj7ZzNJmID8KiFwB
         +xhwX5RkSo2KDhb/PQzjtL4fS5a3uP3ddwlgFBXfcPMglHvcFGZIeSO8MGwpPgU3iDuZ
         LOEfBinHr6HiFG9Afa3BUVz9GDY5PD7i0htZpj23E6gwcrgRojI4L4RXjLmJeTLpQkBf
         c4Sg==
X-Gm-Message-State: AOAM530cDORcd6SnksgTB8bfOjWsb85Wi1qo7JYLst2oCK38uEJ/UYHs
        NGiMexMVIF/qyrHh//jHwepdC3PwHA==
X-Google-Smtp-Source: ABdhPJw9VIQP4mMuRqaMaqZ94kJ7Cn/A9ZuKO3RqfD8xOl9Aii/KrvmCGlr+NhlOlRcgW3g58iI8lA==
X-Received: by 2002:a4a:d0cd:: with SMTP id u13mr19392608oor.49.1635290725253;
        Tue, 26 Oct 2021 16:25:25 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 16sm5171704oty.20.2021.10.26.16.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:25:24 -0700 (PDT)
Received: (nullmailer pid 3510703 invoked by uid 1000);
        Tue, 26 Oct 2021 23:25:22 -0000
Date:   Tue, 26 Oct 2021 18:25:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hector Martin <marcan@marcan.st>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: usb: dwc3: Document
 role-switch-reset-quirk
Message-ID: <YXiOYvnKmXNaLnoJ@robh.at.kernel.org>
References: <20211017125904.69076-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211017125904.69076-1-sven@svenpeter.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2021 at 02:59:03PM +0200, Sven Peter wrote:
> The dwc3 controller on the Apple M1 must be reset whenever a
> device is unplugged from the root port and triggers a role
> switch notification. Document the quirk to enable this behavior.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  Documentation/devicetree/bindings/usb/snps,dwc3.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index 25ac2c93dc6c..9635e20cab68 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -226,6 +226,12 @@ properties:
>        avoid -EPROTO errors with usbhid on some devices (Hikey 970).
>      type: boolean
>  
> +  snps,role-switch-reset-quirk:
> +    description:
> +      When set, DWC3 will be reset and reinitialized whenever a role switch
> +      is performed.
> +    type: boolean

This binding is a example of why we don't do a property per quirk. We 
end up with a gazillion of them.

Imply this from the SoC specific compatible (I don't recall seeing one 
for the M1, so that's a problem).

Rob
