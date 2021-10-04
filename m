Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB85E4213E9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236786AbhJDQWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:22:06 -0400
Received: from mail-ot1-f46.google.com ([209.85.210.46]:40912 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236773AbhJDQV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:21:59 -0400
Received: by mail-ot1-f46.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so22207229otq.7;
        Mon, 04 Oct 2021 09:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/xhcRaXeSwI22a55xcmDjhj060dG9svhnJ1Kf7rSZM4=;
        b=jyZpoHlqszm6bh4PcrynCYZ5d+iJnK4TzKEaEaqS7GQlW04DJm+1bIN+iWMeLvYCBR
         WuvYB7bEVsLBRS5ny2XCJ4BXOW+zpuPr6tw9NgnX4gcFZpJW33q9ogk4olY8oWvH61sw
         0dGvCdMpelctYb2pFFVSWpgQzOmBqOUTskwzXT1TxV2kMKEMSP7xOA92T967rM3lmAaO
         9pibq9dw0Y2ndMNOsTOMBAZmA8425WUdTOorJqV6JHqoBjBkg+5wFqlMBYyzwj3A6g1P
         m2yI3blxjaRJD2wK9NuZO5B9e3M0QRXNfOBJ6BE8IX7EcGykwCLye6WpOD5DBUB/w0R0
         qdWg==
X-Gm-Message-State: AOAM532tRsBCMNwPN7Ej15Cq435PnO2/Hvm4zAH49xHfyU2oN0IyiqfD
        cFLh0govt7J5sxiNu1BCAqbXZvnPRg==
X-Google-Smtp-Source: ABdhPJz3i06qsMtau5TraGJF8w7v9w1RAZV7CejKkpFU1R7VMlkhPxGZKUBxHA4zC/+p/tDmZRgh6g==
X-Received: by 2002:a9d:3b2:: with SMTP id f47mr10137667otf.253.1633364409607;
        Mon, 04 Oct 2021 09:20:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i12sm2773162oik.50.2021.10.04.09.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:20:08 -0700 (PDT)
Received: (nullmailer pid 1407750 invoked by uid 1000);
        Mon, 04 Oct 2021 16:20:08 -0000
Date:   Mon, 4 Oct 2021 11:20:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] regulator: dt-bindings: maxim,max8997: convert to
 dtschema
Message-ID: <YVspuAjMZFIoK/to@robh.at.kernel.org>
References: <20211001130249.80405-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001130249.80405-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Oct 2021 15:02:49 +0200, Krzysztof Kozlowski wrote:
> Convert the Maxim MAX8997 PMIC bindings to DT schema format.  Extend the
> examples with additional one copied from kernel's exynos4210-origen.dts.
> Also the binding descriptions are copied from old file, so license
> entire work under GPL-2.0.
> 
> This also adds previously undocumented 32 kHz clock output modelled as
> regulators.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/regulator/max8997-regulator.txt  | 145 ------
>  .../bindings/regulator/maxim,max8997.yaml     | 445 ++++++++++++++++++
>  2 files changed, 445 insertions(+), 145 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/regulator/max8997-regulator.txt
>  create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
